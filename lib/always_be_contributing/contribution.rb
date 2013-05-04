require 'date'

module AlwaysBeContributing
  class Contribution < Struct.new(:date, :value)
    def self.from_raw(raw)
      AlwaysBeContributing::Contribution.new(raw[0],raw[1])
    end

    def initialize(date, value)
      self.date = Date.parse(date)
      self.value = value
    end

    def nil?
      self.date.nil? || self.value.nil?
    end
  end
end
