require_relative "../lib/file_reader"

file = FileReader.new(ARGV.first)
file.check