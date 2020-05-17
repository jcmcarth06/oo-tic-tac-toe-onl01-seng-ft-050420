class TicTacToe

 def initialize
  @board = Array.new(9, " ") #establishes a new board in the form of an array with 9 spaces
 end

 WIN_COMBINATIONS = [ # a nested array filled with all the possible ways to form three in a row on the grid
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
  ]

 def display_board #  establishes the physical shape of the board and tells it where each space on the board array exists
   puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
   puts "-----------"
   puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
   puts "-----------"
   puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
 end

 def input_to_index(player_input)
    player_input.to_i - 1 #because the array starts at 0 instead of 1, this tells the program to subtract 1 from the user's input
 end

 def move(index, current_player = "X")
   @board[index] = current_player
 end

 def position_taken?(index) # a position is available if it is not occupied by another piece or is empty
   !(@board[index].nil? || @board[index] == " ")
 end

 def valid_move?(index) # a move is valid if it is on the board and it is false that the position is taken
   index.between?(0,8) && !position_taken?(index)
 end

 def turn
   puts "Please choose a number 1-9:"
   user_input = gets.chomp # recives the user input
   index = input_to_index(user_input) # this will translate tha input int a index value
   if valid_move?(index) # checks if the move is valid before proceeding
     player_token = current_player
     move(index, player_token) #makes the move on the board
     display_board
   else
     turn #the turn is over, requests a new loop
   end
 end

 def turn_count # when no turns have been played, the counter is at zero. With each turn, the counter goes up by one and returns the turn number
   turn = 0
   @board.each do |index|
   if index == "X" || index == "O"
     turn += 1
    end
  end
  return turn
  end

  def current_player # if the last player was X, then it is O's turn and vice versa
      num_turns = turn_count
      if num_turns % 2 == 0
        player = "X"
      else
        player = "O"
      end
      return player
  end

  def won? # a win is when a payer gets one of the predetermined three in a rows
    WIN_COMBINATIONS.each {|win_combo|
      index_0 = win_combo[0]
      index_1 = win_combo[1]
      index_2 = win_combo[2]

      position_1 = @board[index_0]
      position_2 = @board[index_1]
      position_3 = @board[index_2]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combo
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combo
      end
    }
    return false
  end

  def full? # the board is full if every space is occupied by either an x or an o
    @board.all? {|index| index == "X" || index == "O"}
  end

  def draw? # the game is a draw is the somebody wins or if the board is full
    if !won? && full?
      return true
    else
      return false
    end
  end

  def over? # The game is over if there is a win or draw
    if won? || draw?
      return true
    else
      return false
    end
  end

  def winner
    index = []
    index = won?
    if index == false
      return nil #returns the name of the winner
    else
      if @board[index[0]] == "X"
        return "X"
      else
        return "O"
      end
    end
  end

  def play
    until over? == true # ugame keeps playing until it is over
      turn
    end
    if won? # if the game was won, congratulate the winner
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!" #else if the game was a draw, tell the player its end in a draw
    end
  end
end
