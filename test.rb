# frozen_string_literal: true

class Test
  def initialize(name)
    @name = [name]
    @age = name.length
  end

  def call_me
    puts "HEEEEY, #{@name}!!"
  end
end
