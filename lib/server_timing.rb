# frozen_string_literal: true

require "tree_stand"

require "server_timing/version"

module ServerTiming
  class Error < StandardError; end
  class ParserMissing < Error; end
  class ServerTimingHeaderMissing < Error; end

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
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == "https"
    req = Net::HTTP::Head.new(uri)
    res = http.request(req)
    header = res["Server-Timing"]
    raise ServerTimingHeaderMissing if header.nil?
    header
  end
end
