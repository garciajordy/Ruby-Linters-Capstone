# Error Class to find all the errors
class Error
  attr_reader :white_space

  private

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def indentation(lines, ind)
    @white_space = lines.index(lines.lstrip)
    if lines.strip.length.positive?
      if lines.include?('end')
        @max_space -= 2
        @counter -= 1 if @counter != 0
      end
      if @white_space != @max_space
        @errors << "#{@file}:#{ind + 1}: Use #{@max_space} (not #{@white_space}) spaces for indentation"
        @tester += 2
      end
      @max_space += 2 if lines.include?('class') || lines.include?('def')
      @counter += 1 if lines.include?('def')
    elsif @tester > 50
      @tester = 5
    end
  end

  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def trailing_white_space(lines, ind)
    if lines[-2] == ' ' || lines[-1] == ' '
      @errors << "#{@file}:#{ind + 1}: trailing white space, please"\
      ' remove the white space'
      @tester += 1
    elsif @tester > 50
      @tester = 5
    end
  end

  def open_close(lines)
    if lines.include?('class') || lines.include?('def') || lines.include?('if')
      @counter_end += 1
    elsif lines.include?('end')
      @counter_end -= 1
    end
  end
  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength

  def closing_brackets(lines, ind)
    if !@brackets.empty? && @stopper.zero?
      @errors << "#{@file}:#{ind}: Expecting a closing bracket \')\',\'}\',\']\'"
      @stopper += 1
    end

    lines.each_char do |brack|
      case brack
      when '(', '{', '['
        @brackets[brack] = ind + 1
        @bracky.push(brack)
      when ')'
        if @bracky.pop != '('
          @errors << "#{@file}:#{ind + 1}: Unexpected closing bracket \')\'"
        elsif @tester == 100
          @tester = 0
        else
          @brackets.delete('(')
        end
      when '}'
        if @bracky.pop != '{'
          @errors << "#{@file}:#{ind + 1}: Unexpected closing bracket \'}\'"
        elsif @tester == 100
          @tester = 0
        else
          @brackets.delete('{')
        end
      when ']'
        if @bracky.pop != '['
          @errors << "#{@file}:#{ind + 1}: Unexpected closing bracket \']\'"
        elsif @tester == 100
          @tester = 0
        else
          @brackets.delete('[')
        end
      end
    end
  end

  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
  def empty_line(lines, ind)
    if lines[ind].strip.empty? && @counter.positive?
      @errors << "#{@file}:#{ind + 1}: Empty line, please remove the empty line"
    elsif @tester > 50
      @tester = 5
    end
  end

  public

  def errors(num)
    @errors[num]
  end

  def check
    @lines.length.times do |i|
      open_close(@lines[i])
      # break if @stopper.positive?

      closing_brackets(@lines[i], i)
      if @counter_end.negative?
        @errors << "#{@file}:#{i + 1}: unexpected keyword END"
        break
      end
      trailing_white_space(@lines[i], i)
      indentation(@lines[i], i)
      empty_line(@lines, i)
      if @counter_end.positive? && i == @lines.length - 1
        @errors << "#{@file}:#{@lines.length}: missing"\
        ' keyword END'
      end
    end
    if @errors.empty?
      puts 'You have no errors.'
    else
      @errors.each { |er| puts er }
      puts "you have #{@errors.length} errors."
    end
  end
end
