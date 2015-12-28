require_relative 'characters'

class NightReader

  include Characters

  def split_message(message)
    message = message.split("\n")
  end

  def map_characters(message)
    new_message = split_message(message)
    result = Array.new(new_message[0].length/2, "")
    result.each_with_index do |string, index|
      new_message.each_with_index do |char, i|
        result[index] += new_message[i].slice!(0..1)
      end
    end
  end

  def night_read(message)
    new_message = shift_to_capital(message)
    new_message.map! do |character|
      character = BRAILLE[[character]] || character
    end
    new_message.join
  end

  def shift_to_capital(message)
    new_message = map_characters(message)
    new_message.each_with_index do |character, index|
      if character == ".....0"
        new_message.delete_at(index)
        new_message[index] = BRAILLE[[new_message[index]]].upcase
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  message = File.read(ARGV[0]).chomp
  n = NightReader.new
  count = n.count_characters(message)
  translated = n.night_read(message)
  f = File.new(ARGV[1], 'w')
  f.write(translated)
  puts "Created '#{ARGV[1]}' containing #{count/6} characters"
end
