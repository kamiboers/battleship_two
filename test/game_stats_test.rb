require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/game_stats'
require 'pry'

class GameStatsTest < Minitest::Test

  def test_game_stats_initializes_with_baseline_attributes
    recorder = GameStats.new

    assert_equal 0, recorder.user_shots
    assert_equal 0, recorder.computer_shots
  end

  def test_user_records_a_shot_increments_user_shots
    recorder = GameStats.new
    recorder.user_records_a_shot

    assert_equal 1, recorder.user_shots

    recorder.user_records_a_shot

    assert_equal 2, recorder.user_shots
  end

  def test_computer_records_a_shot_increments_user_shots
    recorder = GameStats.new
    recorder.computer_records_a_shot

    assert_equal 1, recorder.computer_shots

    recorder.computer_records_a_shot
    recorder.computer_records_a_shot

    assert_equal 3, recorder.computer_shots
  end

  def test_timer_returns_new_time_when_stopped
    recorder = GameStats.new

    refute recorder.timer_stopped == 0
  end

end
