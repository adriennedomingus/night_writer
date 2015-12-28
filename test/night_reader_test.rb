require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/night_reader'


class NightReaderTest < MiniTest::Test

  def test_it_separates_message_into_lines
    n = NightReader.new
    result = ["0...000..0.00.000.", ".......00.0...00.0", "....0...0.0......."]
    message = "0...000..0.00.000.\n.......00.0...00.0\n....0...0.0......."

    assert_equal result, n.split_message(message)
  end

  def test_it_creates_characters
    n = NightReader.new
    result = ["0.....", "......", "00..0.", "0..0..", ".00.0.", ".00.0.",
              "0.....", "0000..", "0..0.."]
    message = "0...000..0.00.000.\n.......00.0...00.0\n....0...0.0......."

    assert_equal result, n.map_characters(message)
  end

  def test_it_converts_braille_to_english
    n = NightReader.new
    result = "a message"
    message = "0...000..0.00.000.\n.......00.0...00.0\n....0...0.0......."

    assert_equal result, n.night_read(message)
  end

  def test_shift_character_makes_next_capital
    n = NightReader.new
    result = "a Message"
    message = "0.....000..0.00.000.\n.........00.0...00.0\n.....00...0.0......."

    assert_equal result, n.night_read(message)
  end

  def test_with_two_capital_letters
    n = NightReader.new
    result = "a MessagE"
    message = "0.....000..0.00.00..0.\n.........00.0...00...0\n.....00...0.0......0.."

    assert_equal result, n.night_read(message)
  end
end
