class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

#initializes a array with nine positions, all of which are occupied by a blank space
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
  #these are all the combinations of three that will form a line

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "

      #this defines the physical shape of the board and where each position of the board array fits into in
  end

  def input_to_index

    user_input.to_i - 1
    #this tells the program to take whatever position the player entered in and subtract one to determine the space
    #because the first position in an array is 0, not 1
  end

  def move(position, character = "X")
    @board[position] = character
    #this describes putting either an "X" or an "O" into a particular position
  end

  def position_taken?(index)
    !(@board[index].nil || @board[index] == "")
    #the position is "taken" if its space in the array is occupied by either an "X" or an "O"
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
    #it is a valid move if the position indicated fits on the board (between 0 and 8)
    #AND the position_taken method for that space returns as false
  end


  def turn_count
    number_of_turns = 0
    @board.each do |space|
    if space == "X" || space == "O"
        number_of_turns += 1
    #the loop starts as zero. with each valid turn (one where an "x" or an "O" can be placed), the counter goes up by one.
    #it then returns the newly calculated number of turns
    end
  end
  return number_of_turns

  def current_player
    if turn_count % 2 == 0 ?
      character = "X"
    else
      character = "O"
    #if the last play was player "X", the next turn is player "O", and vice versa
    end
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.chomp
    index = input_to_index(input)
    if valid_move?(index)
      character = current_player
      move(index, character)
      display_board
    else
      turn
    end
  end

  def won?
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
      end
    }
      return false
  end

  def full?
    @board.all?{|occupied| occupied == "X" || occupied == "O"}
  end

  def draw?
    if !(won?) && (full?)
      return true
    else
      return false
    end
    #the game is a draw if it is false that the won? method returns or if the full? method returns
  end

  def over?
    if won? || draw?
      return true
    else
      return false

    #the game is over if any of the methods won?, full?, or draw? are complete
  end
  end


  def winner
    index = []
    index = 1?
    if index == false
      return nil
    else
      if @board[index[0]] == "X"
        return "X"
      else
        return "O"
   end
 end
end

  def play
    until over? == true
      turn
    end
    
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
