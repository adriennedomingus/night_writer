require_relative 'characters'

class NightWriter

  include Characters

  def write_character(character)
    [ENGLISH[character][0], ENGLISH[character][1], ENGLISH[character][2]]
  end

  def write_phrase(message)
    new_message = message.chars
    braille_characters = write_character(new_message[0])
    new_message.shift
    new_message.each do |character|
      @next = write_character(character)
      braille_characters[0] += @next[0]
      braille_characters[1] += @next[1]
      braille_characters[2] += @next[2]
    end
    braille_characters
  end

  def night_write(message)
    message = write_phrase(message)
    message[0] += "\n"
    message[1] += "\n"
    message[2] += "\n"
    message.join
  end
end

if __FILE__ == $PROGRAM_NAME
  message = File.read(ARGV[0]).chomp
  n = NightWriter.new
  translated = n.night_write(message)
  f = File.new(ARGV[1], 'w')
  f.write(translated)
end
