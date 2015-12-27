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
      result[index] += new_message[0].slice!(0..1)
      result[index] += new_message[1].slice!(0..1)
      result[index] += new_message[2].slice!(0..1)
    end
    result
  end

  def translate_message(message)
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
    new_message
  end

  def count_characters(message)
    count = 0
    message.chars.each do
      count += 1
    end
    count/6
  end
end


if __FILE__ == $PROGRAM_NAME
  message = File.read(ARGV[0]).chomp
  n = NightReader.new
  count = n.count_characters(message)
  translated = n.translate_message(message)
  f = File.new(ARGV[1], 'w')
  f.write(translated)
  puts "Created '#{ARGV[1]}' containing #{count} characters"
end
