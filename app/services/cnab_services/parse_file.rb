# frozen_string_literal: true

module CnabServices
  class ParseFile < ApplicationService
    def initialize(file)
      @file = file
    end

    def call
      reader_lines = @file.lines.map do |line|
        reader_line = CnabServices::ReaderLine.call(line)
        unless reader_line.success?
          raise StandardError,
                "Error with reader line #{line}"
        end

        reader_line.payload
      end
    rescue StandardError => e
      OpenStruct.new({ success?: false, error: e.message })
    else
      OpenStruct.new({ success?: true, payload: reader_lines })
    end
  end
end
