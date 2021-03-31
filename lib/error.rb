# Error Class to find all the errors
class Error
  private

  def indentation(lines, i)
    unless lines.strip.empty?
      @white_space = lines.index(lines.lstrip)
      if lines.include?('end')
        @max_space -= 2
        @counter -= 1 if @counter != 0
      end

      if @white_space != @max_space
        @errors << "#{@file}:#{i + 1}: the indentation should be #{@max_space}"\
        " spaces, instead of #{@white_space}"
      end
      if lines.include?('class') || lines.include?('def')
        @max_space += 2
        @counter += 1 if lines.include?('def')
      end
    end
  end

  def trailing_white_space(lines, i)
    if lines[-2] == ' ' || lines[-1] == ' '
      @errors << "#{@file}:#{i + 1}: trailing white space, please"\
      ' remove the white space'
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
        else
          @brackets.delete('(')
        end
      when '}'
        if @bracky.pop != '{'
          @errors << "#{@file}:#{ind + 1}: Unexpected closing bracket \'}\'"
        else
          @brackets.delete('{')
        end
      when ']'
        if @bracky.pop != '['
          @errors << "#{@file}:#{ind + 1}: Unexpected closing bracket \']\'"
        else
          @brackets.delete('[')
        end
      end
    end
  end

  def empty_line(lines, ind)
    if lines[ind].strip.empty? && @counter > 0
      @errors << "#{@file}:#{ind + 1}: Empty line, please remove the empty line"
    end
  end
public

  def check
    @lines.length.times do |i|
      open_close(@lines[i])
      break if @stopper.positive?

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
