require 'pry'

class GameStats
  attr_reader :timer, :user_shots, :computer_shots

  def initialize
    @timer_start = Time.now
    @user_shots = 0
    @computer_shots = 0
  end

  def timer_stopped
    @timer = Time.now - @timer_start
  end

  def user_records_a_shot
    @user_shots += 1
  end

  def computer_records_a_shot
    @computer_shots += 1
  end

end
