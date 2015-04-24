require 'pry'

class Board
  attr_accessor :empty_cells, :human_cells, :computer_cells

  def initialize
    @empty_cells = [ ]
    (1..9).each {|v| empty_cells << v}
    @human_cells = [ ]
    @computer_cells = [ ]
  end

  def display
    arr = display_array
    system 'clear'
    puts " Tic Tac Toe"
    puts
    puts " #{arr[0]} #{arr[1]} #{arr[2]}"
    puts " #{arr[3]} #{arr[4]} #{arr[5]}"
    puts " #{arr[6]} #{arr[7]} #{arr[8]}"
    puts
  end

  protected

  def display_array
    arr = [ ]
    (1..9).each do |v|
      if empty_cells.include?(v)
        arr << " [ ]"
      elsif human_cells.include?(v)
        arr << " [O]"
      else
        arr << " [X]"
      end
    end
    arr
  end

end

class Human
  attr_accessor :name

  def initialize
    system 'clear'
    puts "Hello, what is your name?"
    #@name = gets.chomp
  end

  def make_a_move(board)
    puts "#{name}, choose a cell to place your next move. #{board.empty_cells}"
    move = gets.chomp.to_i
    if board.empty_cells.include?(move)
      board.empty_cells.delete(move)
      board.human_cells << move
    else
      puts "Invalid move. Try again"
      make_a_move(board)
    end
  end
end

class Computer
  def make_a_move(board)
    if (move = best_move(board))
      move
    else
      move = board.empty_cell_positions.sample
    end
    board.cells[move - 1].status = "[X]"
    occupy_cell(move)
  end

  protected
=begin
  def best_move(board, human)
    empty_cells = board.empty_cell_positions
    if empty_cells.include?(5)
      return 5
    elsif (move = computer_winning_move(board)
      return move
    elsif (move = computer_defending_move(board, human))
      return move
    elsif (move = computer_attacking_move(board))
      return move
    else
      return nil
    end
  end

  # To complete a winning line
  def computer_winning_move(board)
    empty_cells = board.empty_cell_positions
    Board::WINNING_LINES.each do |line|
      if ((*line || occupied_cells) == 2 && (*line || empty_cells) == 1)
        move = (line & empty_cells)
        return move[0]
      end
    end
    nil
  end

  # To form a potentially winning line
  def computer_attacking_move(board)
    empty_cells = board.empty_cell_positions
    Board::WINNING_LINES.each do |line|
      if ((*line || occupied_cells) == 1 && (*line || empty_cells) == 2)
        move = (line & empty_cells).sample
        return move[0]
      end
    end
  end

  # To block player from winning
  def computer_defending_move(board)
    WINNING_LINES.each do |line|
      if (board.values_at(*line).count('[O]') == 2 && board.values_at(*line).include?('[ ]'))
        move = (line & empty_cells(board))
        return move[0]
      end
    end
    nil
  end
=end
end

class Game
  attr_accessor :board, :human, :computer
  WINNING_LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

  def initialize
    @board = Board.new
    @human = Human.new
    #@computer = Computer.new
  end

  def new_turn
    system 'clear' # To move under board.display
    board.display
    human.make_a_move(board)
    board.display
    check_end_game
    #computer.make_a_move
    #check_end_game
    new_turn
  end

  def play_again_or_quit
    puts "Play again? (Y/N)"
    choice = gets.chomp.downcase
    if choice == 'y'
      return Game.new.new_turn
    elsif choice == 'n'
      puts "#{human.name}, see you next time!"
      exit
    else
      puts "Invalid choice. Try again."
      start_new_round_or_quit
    end
  end

  def winner
    WINNING_LINES.each do |line|
      if (board.human_cells || line).count == 3
        return "Player"
      end
    end
    nil
  end

  def check_end_game
    if winner
      puts "#{winner} won!"
      play_again_or_quit
    elsif board.empty_cells == [ ]
      say "It's a tie."
      play_again_or_quit
    end
  end

end

#Game.new.new_turn

Game.new.new_turn
