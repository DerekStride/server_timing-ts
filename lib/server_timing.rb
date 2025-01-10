# frozen_string_literal: true

require "tree_stand"

require "server_timing/version"

module ServerTiming
  class Error < StandardError; end
  class ParserMissing < Error; end
  class ServerTimingHeaderMissing < Error; end

  TimingMetric = Data.define(:name, :duration, :description) do
    def to_metric = "#{name};dur=#{dur};desc=#{desc}"
    def dur = duration
    def desc = description
  end

  def parser
    @parser ||= begin
      TreeStand.configure do
        config.parser_path = File.expand_path(File.join(__dir__, "..", "treesitter"))
      end

      TreeStand::Parser.new("server_timing")
    end
  end

  def parse(source) = parser.parse_string(source)

  def get_header(url)
    header = Net::HTTP.get_response(URI(url)).[]("Server-Timing")
    raise ServerTimingHeaderMissing if header.nil?
    header
  end

  def extract(tree)
    tree.query(<<~QUERY).map do |match|
      (timing_metric
        name: (token) @name
        duration: (duration value: (number) @duration)?
        description: (description value: (string) @description)?)
    QUERY
      name = match.fetch("name").text
      duration = match["duration"]&.text&.to_f
      description = match["description"]&.text
      TimingMetric.new(name:, duration:, description:)
    end
  end
end
