# frozen_string_literal: true

require_relative 'error'
class FileReader < Error
  def initialize(file_name)
    @file = file_name.to_s
    @lines = File.readlines(@file)
    @max_space = 0
    @white_space = 0
    @counter = 0
    @counter_end = 0
    @brackets = {}
    @bracky = []
    @errors = []
    @stopper = 0
    @tester = 0
  end
end
