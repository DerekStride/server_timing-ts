# frozen_string_literal: true

module ServerTiming
  module Handwritten
    extend self

    def extract(header)
      header.split(",").map do |raw_metric|
        parts = raw_metric.split(";").map(&:strip)
        dur = parts.find { |part| part.start_with?("dur=") }
        parts.delete(dur)
        desc = parts.find { |part| part.start_with?("desc=") }
        parts.delete(desc)
        name = parts.shift
        raise if parts.any?

        duration = dur&.split("=")&.last&.to_f
        description = desc&.split("=")&.last
        TimingMetric.new(name:, duration:, description:)
      end
    end
  end
end
