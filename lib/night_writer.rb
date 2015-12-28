require_relative 'characters'

class NightWriter

  include Characters

  def write_character(character)
    [ENGLISH[character][0], ENGLISH[character][1], ENGLISH[character][2]]
  end

  def write_phrase(message)
    new_message = shift_character(message)
    braille_characters = write_character(new_message[0])
    new_message.shift
    new_message.each do |character|
      @next = write_character(character)
      braille_characters.each_with_index do |character, index|
        braille_characters[index] += @next[index]
      end
    end
    braille_characters
  end

  def shift_character(message)
    new_message = message.chars
    letters = ("A".."Z").to_a
    new_message.map! do |character|
      letters.include?(character) ? "shift #{character.downcase}".split : character
    end.flatten
  end

  def night_write(message)
    message = write_phrase(message)
    message.map! do |line|
      line += "\n"
    end.join
  end
end

if __FILE__ == $PROGRAM_NAME
  message = File.read(ARGV[0]).chomp
  n = NightWriter.new
  count = n.count_characters(message)
  translated = n.night_write(message)
  f = File.new(ARGV[1], 'w')
  f.write(translated)
  puts "Created '#{ARGV[1]}' containing #{count} characters"
end
