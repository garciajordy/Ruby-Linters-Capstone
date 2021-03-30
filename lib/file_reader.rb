# frozen_string_literal: true

class FileReader
  def initialize(file_name)
    @file = file_name.to_s
    @lines = File.readlines(@file)
  end
end