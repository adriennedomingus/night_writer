require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/night_writer'


class NightWriterTest < MiniTest::Test

  def test_it_maps_single_character_when_starting_empty
    n = NightWriter.new
    result = ["00", "..", "0."]

    assert_equal result, n.write_character("m")
  end

  def test_it_maps_different_single_character
    n = NightWriter.new
    result = ["0.", ".0", "00"]

    assert_equal result, n.write_character("z")
  end

  def test_it_maps_multiple_characters
    n = NightWriter.new
    result = ["000.", "....", "0..."]

    assert_equal result, n.write_phrase("ma")
  end

  def test_it_maps_different_characters
    n = NightWriter.new
    result = ["0.0.", "0...", "...."]

    assert_equal result, n.write_phrase("ba")
  end

  def test_it_maps_longer_message
    n = NightWriter.new
    result = ["0.0.000.00", "0....00..0", "......0.00"]

    assert_equal result, n.write_phrase("badly")
  end

  def test_it_adds_newline_character
    n = NightWriter.new
    result = "0.0.000.00\n0....00..0\n......0.00\n"

    assert_equal result, n.night_write("badly")
  end
end
