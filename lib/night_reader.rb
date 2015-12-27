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
    new_message = map_characters(message)
    new_message.map! do |character|
      character = BRAILLE[[character]]
    end
    new_message.join
  end
end
