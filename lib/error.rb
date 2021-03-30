
class Error

    def indentation(lines,i)
    
        #  puts "#{@lines[i].length - 1}  #{@lines[i]}"
        if lines.strip.length > 0
        @white_space = lines.index(lines.lstrip)
        if lines.include?('end')
          @max_space -= 2
          @counter -= 1 if @counter != 0
        end 
  
        if @white_space != @max_space
          puts "#{@file}:#{i + 1}: the indentation should be #{@max_space} spaces, instead of #{@white_space}"
        end
         if lines.include?('class') || lines.include?('def')
          @max_space += 2
          @counter += 1 if lines.include?('def')
         end
      end
    end

    def trailing_white_space(lines,i)
        if lines[-2] == " " || lines[-1] == " "
          puts "#{@file}:#{i+1}: trailing white space, please remove the white space"
        end
    end

    def open_close(lines)
        if lines.include?('class') || lines.include?('def') || lines.include?('if') 
          @counter_end += 1
        elsif lines.include?('end')
            @counter_end -= 1
        end
    end
end