require 'pry'

class TicTacToe
  attr_accessor :board

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    puts "A new game has started:"
    puts
    puts "===================="
    puts
    board_positions
    puts
    puts "===================="
    puts
    display_board
    puts
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def board_positions
    puts "BOARD POSITIONS:"
    puts " 1 | 2 | 3 "
    puts "-----------"
    puts " 4 | 5 | 6 "
    puts "-----------"
    puts " 7 | 8 | 9 "
  end

  def display_board
    puts "Current board:"
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def input_to_index user_input
    # Instructions is not looking for user prompts
    # "turn" method will use the "gets" method
    # puts "Enter a position:"
    # index = gets.to_i
    # puts index.class
    # board[index-1] = (true ? "X" : "O")
    # puts "You entered #{index}"

    # Instructions wants a method with 1 argument
    user_input.to_i - 1
  end

  def move(index, player="X")
    @board[index] = player

    # Why is this incorrect?
    # @board[self.input_to_index index] = player
  end

  def position_taken? index
    @board[index] == "X" || @board[index] == "O"

    # Alternative solution
    # @board[index] != " "
  end

  def valid_move? index
    !position_taken?(index) && index >= 0 && index <= 8

    # Alternative solution
    # !position_taken?(index) && index.between?(0,8)
  end

  def turn_count
    @board.count {|index| index == "X" || index =="O"}

    # Alternative solution
    # @board.count {|index| index!= " "}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"

    # Alternative solution
    # turn_count.even? ? "X" : "O"
    # turn_count.odd? ? "O" : "X"
  end

  def turn
    puts "Player #{current_player}'s turn." # <= Comment line out to pass tests
    puts "Enter a position (1-9):"
    user_input = gets.strip
    puts
    index = input_to_index user_input
    if(valid_move?(index))
      move index, current_player
      display_board
      puts
    else
      puts "Invalid position, please try again."
      puts
      puts "===================="
      puts
      board_positions
      puts
      puts "===================="
      puts
      display_board
      puts
      turn
    end
  end

  ##################################################
  # Review logic for end game scenarios!!
  ##################################################

  def won?
    # iterate through WIN_COMBINATIONS
    # If statement based on 2 conditions:
      # 1st: Check if 1st winning index/position is taken
      # 2nd: Determine 1st winning index == 2nd winning index && 2nd winning index == 3rd winning index
        # If 1st, 2nd, and 3rd indices are equal, they are the same player

    WIN_COMBINATIONS.any? do |combo|
      if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
        return combo
      end
    end
  end
  
  def full?
    @board.all? {|element| element != " "}
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    if combo = won?
      # puts "won: #{won?}"
      # puts "combo: #{combo}"
      # puts "combo[0]: #{combo[0]}"
      # puts "@board[combo[0]]: #{@board[combo[0]]}"
      @board[combo[0]]
    end
  end

  def play
    until over? do
      turn
    end

    if won?
      # puts "Congratulations #{winner}!" # <= Uncomment line to pass tests
      puts "Congratulations Player #{winner} won!"
    else
      puts "Cat's Game!"
    end
  end

end


# newgame = TicTacToe.new
# puts
# puts "new game:"
# pp newgame
# puts
# puts ".input_to_index 2"
# pp "Position ##{newgame.input_to_index 2}"
# puts
# newgame.move 2
# puts
# newgame.move 8, "O"
# puts
# newgame.move 5, "X"
# puts
# puts ".turn_count"
# pp newgame.turn_count
# puts
# puts "current_player"
# pp newgame.current_player
# puts
# puts "turn"
# newgame.turn
# puts
# puts "won?"
# newgame.move 1, "X"
# pp newgame.won?
# puts
# puts "newgame.full?"
# pp newgame.full?
# puts
# puts "winner"
# pp newgame.winner
# puts

# newgame.play

# puts ".display_board:"
# newgame.display_board
# puts
# binding.pry
# 0
