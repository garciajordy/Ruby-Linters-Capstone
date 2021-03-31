require_relative '../lib/file_reader'
describe FileReader do
  describe '#indentation' do
    it 'Indentation on line 3 should be 4 instead of 2' do
      file = FileReader.new('test.rb')
      file.check
      expect(file.errors(0)).to eql('test.rb:3: Use 4 (not 2) spaces for indentation')
    end
  end

  describe '#white_trailing_space' do
    it 'white trailing space on line 4 should be removed' do
      file = FileReader.new('test.rb')
      file.check
      expect(file.errors(1)).to eql('test.rb:4: trailing white space, please remove the white space')
    end
  end

  describe '#closing_bracket' do
    it 'unexpected closing bracket on line 5' do
      file = FileReader.new('test.rb')
      file.check
      expect(file.errors(2)).to eql("test.rb:5: Unexpected closing bracket '}'")
    end
  end

  describe '#empty_line' do
    it 'unexpected empty line on line 8' do
      file = FileReader.new('test.rb')
      file.check
      expect(file.errors(3)).to eql('test.rb:8: Empty line, please remove the empty line')
    end
  end

  describe '#open_close' do
    it 'unexpected keyword END on line 12' do
      file = FileReader.new('test.rb')
      file.check
      expect(file.errors(4)).to eql('test.rb:12: unexpected keyword END')
    end
  end
end
