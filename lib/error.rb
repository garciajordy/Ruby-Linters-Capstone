# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength

# Error class
class Error
  def indentation(lines, ind)
    break unless lines.strip.empty?

    @white_space = lines.index(lines.lstrip)
    if lines.include?('end')
      @max_space -= 2
      @counter -= 1 if @counter != 0
    end
    if @white_space != @max_space
      puts "#{@file}:#{ind + 1}: the indentation should be #{@max_space}
       spaces, instead of #{@white_space}"
      @tester += 1
    end
    @max_space += 2 if lines.include?('class') || lines.include?('def')
    @counter += 1 if lines.include?('def')
  end

  def trailing_white_space(lines, ind)
    if lines[-2] == ' ' || lines[-1] == ' '
      puts "#{@file}:#{ind + 1}: trailing white space,
       please remove the white space"
      @stopper += 1
    else
      @tester += 2
    end
  end

  def open_close(lines)
    if lines.include?('class') || lines.include?('def') || lines.include?('if')
      @counter_end += 1
    elsif lines.include?('end')
      @counter_end -= 1
    end
  end

  def closing_brackets(lines, ind)
    if !@brackets.empty? && @stopper.zero?
      puts "#{@file}:#{ind}: Expecting a closing bracket \')\',\'}\',\']\'"
      @stopper += 1
    end

    lines.each_char do |brack|
      case brack
      when '(', '{', '['
        @brackets[brack] = ind + 1
        @bracky.push(brack)
      when ')'
        if @bracky.pop != '('
          puts "#{@file}:#{ind + 1}: Unexpected closing bracket \')\'"
          @tester += 1
        elsif @tester > 50
          @tester -= 30
        else
          @brackets.delete('(')
        end
      when '}'
        if @bracky.pop != '{'
          puts "#{@file}:#{ind + 1}: Unexpected closing bracket \'}\'"
        elsif @tester > 50
          @tester -= 30
        else
          @brackets.delete('{')
        end
      when ']'
        if @bracky.pop != '['
          puts "#{@file}:#{ind + 1}: Unexpected closing bracket \']\'"
        elsif @tester > 50
          @tester -= 30
        else
          @brackets.delete('[')
        end
      end
    end
  end

  def empty_line(lines, ind)
    if lines[ind].strip.empty? && @counter.positive?
      puts "#{@file}:#{ind + 1}: Empty line, please remove the empty line"
      @tester += 1
    else
      @tester += 2
    end
  end

  def check
    @lines.length.times do |i|
      open_close(@lines[i])
      break if @stopper.positive?

      closing_brackets(@lines[i], i)
      if @counter_end.negative?
        puts "#{@file}:#{i + 1}: unexpected keyword END"
        break
      end
      trailing_white_space(@lines[i], i)
      indentation(@lines[i], i)
      empty_line(@lines, i)
      if @counter_end.positive? && i == @lines.length - 1
        puts "#{@file}:#{@lines.length}: missing keyword END"
        @tester += 5
      end
    end
  end
end

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
