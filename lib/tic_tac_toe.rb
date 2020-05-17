class TicTacToe

 def initialize # this is when a new instance of the game is initialized.
  @board = Array.new(9, " ") # instance variable named board with a new array of 9 empty stings creathing the board.
 end

 WIN_COMBINATIONS = [ # a nested array filled with the index favlues fo rthe various winning combinations possible.
    [0, 1, 2], # top horizontal row
    [3, 4, 5], # middle horizontal row
    [6, 7, 8], # bottom horizontal row
    [0, 3, 6], # left vertical row
    [1, 4, 7], # middle vertical row
    [2, 5, 8], # right vertical row
    [0, 4, 8], # diagonal left to right
    [6, 4, 2]  # diagonal right to left
  ]

 def display_board # a method that will print the current board.
   puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
   puts "-----------"
   puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
   puts "-----------"
   puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
 end

 def input_to_index(player_input) # a method to pass user input
    player_input.to_i - 1 # indicex in the array start at 0m -1 to correctly translate the players perspective.
 end

 def move(index, current_player = "X") #must take in two arguments, the index in the board and the players token
   @board[index] = current_player
 end

 def position_taken?(index) # will check index values of the #move method. then check to see if that postion is vacent
   !(@board[index].nil? || @board[index] == " ")
 end

 def valid_move?(index) # this will check if a move is valid and not already filled with a token
   index.between?(0,8) && !position_taken?(index)
 end

 def turn # a single complete turn
   puts "Please choose a number 1-9:" #asks the user for their move
   user_input = gets.chomp # recives the user input
   index = input_to_index(user_input) # this will translate tha input int a index value
   if valid_move?(index) # if the move is valid,
     player_token = current_player
     move(index, player_token) #make the move and display it on the board
     display_board
   else
     turn #ask for input again
   end
 end

 def turn_count # this method returns the number of turns that have been played based on the @board variable
   turn = 0
   @board.each do |index|
   if index == "X" || index == "O"
     turn += 1
    end
  end
  return turn
  end

  def current_player # this will use the #turn_count methon to determine if its a "X" or "O" turn
      num_turns = turn_count
      if num_turns % 2 == 0
        player = "X"
      else
        player = "O"
      end
      return player
  end

  def won? # should return false/nil if there is no win combination, or return the winning combination index as an array if there is a win
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

  def full? # method should return true if every element in the board contains either an "X" or an "O"
    @board.all? {|index| index == "X" || index == "O"}
  end

  def draw?
    if !won? && full?
      return true # returns true if the board is full and has not been won
    else
      return false # false if the board is won, and false if the board is neither won nor full
    end
  end

  def over? # returns true if the board has been won or is full
    if won? || draw?
      return true
    else
      return false
    end
  end

  def winner # Given a winning @board
    index = []
    index = won?
    if index == false
      return nil # the winning method should return x,o that has won the game
    else
      if @board[index[0]] == "X"
        return "X"
      else
        return "O"
      end
    end
  end

  def play
    until over? == true # until the game is over take turns
      turn
    end
    if won? # if the game was won, congratulate the winner
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!" #else if the game was a ddraw, tell the player its end in a draw
    end
  end
end
