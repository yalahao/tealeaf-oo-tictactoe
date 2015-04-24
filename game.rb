require 'pry'

class Board
  attr_accessor :cells

  def initialize
    @cells = [ ]
    (1..9).each do |position|
      cell = Cell.new(position)
      cells << cell
    end
  end

  def display
    system 'clear'
    puts " Tic Tac Toe"
    puts
    (1..3).each do |row|
      display_row(row)
    end
    puts
  end

  def empty_cell_positions
    empty_cell_positions = [ ]
    cells.each do |cell|
      empty_cell_positions << cell.position if cell.status == "[ ]"
    end
    empty_cell_positions
  end

  protected

  def display_row(row_num)
    row = String.new
    (0..2).each do |position|
      row << " #{cells[(row_num - 1) * 3 + position].status}"
    end
    puts row
  end
end

class Cell
  attr_reader :position
  attr_accessor :status

  def initialize(position)
    @position = position
    @status = "[ ]"
  end
end

class Player
  attr_accessor :occupied_cells

  def initialize
    @occupied_cells = Array.new
  end

  def occupy_cell(position)
    occupied_cells << position
  end
end

class Human < Player
  attr_accessor :name

  def initialize
    system 'clear'
    puts "Hello, what is your name?"
    @name = gets.chomp
    super
  end

  def make_a_move(board)
    puts "#{name}, choose a cell to place your next move. #{board.empty_cell_positions}"
    move = gets.chomp.to_i
    if board.empty_cell_positions.include?(move)
      board.cells[move - 1].status = "[O]"
      occupy_cell(move)
    else
      puts "Invalid move. Try again"
      make_a_move
    end
  end
end

class Computer < Player
  def make_a_move(board)
    if best_move
    end

  end

  protected

  def best_move

  end

end

class Game
  attr_accessor :board, :human, :computer

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
    else
      puts "Invalid choice. Try again."
      start_new_round_or_quit
    end
  end

  WINNING_LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

  def winner
    WINNING_LINES.each do |line|
      if (human.occupied_cells || line).count == 3
        return "Player"
      end
    end
    nil
  end

  def check_end_game
    if winner
      puts "#{winner} won!"
      play_again_or_quit
    elsif board.empty_cell_positions == [ ]
      say "It's a tie."
      play_again_or_quit
    end
  end

end

Game.new.new_turn
