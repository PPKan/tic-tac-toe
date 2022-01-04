# frozen_string_literal: true

# The main game logic goes here
class Game
  attr_reader :game_over, :all_filled, :turn

  def initialize
    @gamepad = Array.new(3) { Array.new(3) { ' ' } }
    @turn = 'O'
    @game_over = false
    @all_filled = false
  end

  def play
    # take input
    loop do
      puts 'Input your number from 0~8'
      input = gets.chomp.to_i

      @row = input / 3
      @column = input % 3

      # binding.pry

      break if (input < 9 && input >= 0) && @gamepad[@row][@column] == ' '

      puts 'The number is invalid'
    end

    # put in O/X
    @gamepad[@row][@column] = @turn

    # judge whether game ended

    if (@gamepad[0][0] != ' ' && @gamepad[0][0] == @gamepad[0][1] && @gamepad[0][1] == @gamepad[0][2]) ||
       (@gamepad[1][0] != ' ' && @gamepad[1][0] == @gamepad[1][1] && @gamepad[1][1] == @gamepad[1][2]) ||
       (@gamepad[2][0] != ' ' && @gamepad[2][0] == @gamepad[2][1] && @gamepad[2][1] == @gamepad[2][2]) ||
       (@gamepad[0][0] != ' ' && @gamepad[0][0] == @gamepad[1][0] && @gamepad[1][0] == @gamepad[2][0]) ||
       (@gamepad[0][1] != ' ' && @gamepad[0][1] == @gamepad[1][1] && @gamepad[1][1] == @gamepad[2][1]) ||
       (@gamepad[0][2] != ' ' && @gamepad[0][2] == @gamepad[1][2] && @gamepad[1][2] == @gamepad[2][2]) ||
       (@gamepad[0][0] != ' ' && @gamepad[0][0] == @gamepad[1][1] && @gamepad[1][1] == @gamepad[2][2]) ||
       (@gamepad[0][2] != ' ' && @gamepad[0][2] == @gamepad[1][1] && @gamepad[1][1] == @gamepad[2][0])

      @game_over = true

    elsif @gamepad[0].all? { |i| i != ' ' } && @gamepad[1].all? { |i| i != ' ' } && @gamepad[2].all? { |i| i != ' ' }

      @game_over = true
      @all_filled = true
    else
      # swap the turn
      @turn = swap(@turn)
    end

    @game_over
  end

  def draw
    p " #{@gamepad[0][0]} | #{@gamepad[0][1]} | #{@gamepad[0][2]} "
    p '-----------'
    p " #{@gamepad[1][0]} | #{@gamepad[1][1]} | #{@gamepad[1][2]} "
    p '-----------'
    p " #{@gamepad[2][0]} | #{@gamepad[2][1]} | #{@gamepad[2][2]} "
  end

  private

  def swap(turn)
    return 'X' if turn == 'O'
    return 'O' if turn == 'X'
  end
end

# The code runs here
game = Game.new

loop do
  game.draw
  finished = game.play

  break if finished
end

if game.all_filled
  puts 'OOPS! No one wins!'
else
  puts "Congratulations! #{game.turn} wins!"
end
