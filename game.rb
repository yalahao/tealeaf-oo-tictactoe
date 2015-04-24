# Architecture
=begin

Player
  @score
  win

Human < Player
  @name
  make_a_move

Computer < Player
  make_a_move

Board
  @status
  @empty_cells
  display

Cell
  @position
  @state

Game
  @board
  @human
  @comptuer
  new_turn
  check_end_game

=end

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

  def empty_cells
    empty_cells = [ ]
    cells.each do |cell|
      empty_cells << cell if cell.status == "[ ]"
    end
    empty_cells
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

class Human
  attr_accessor :name

  def initialize
    system 'clear'
    puts "Hello, what is your name?"
    @name = gets.chomp
  end

  def make_a_move(board)
    empty_cell_positions = [ ]
    board.empty_cells.each {|cell| empty_cell_positions << cell.position}
    puts "#{name}, choose a cell to place your next move. #{empty_cell_positions}"
    move = gets.chomp.to_i
    if empty_cell_positions.include?(move)
      board.cells[move - 1].status = "[O]"
    else
      puts "Invalid move. Try again"
      make_a_move
    end
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
    #check_end_game
    board.display
    #computer.make_a_move
    #check_end_game
    board.display
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

  def cells_of(player)
    if player.class?(Human)
      

  def winner
    WINNING_LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
    WINNING_LINES.each do |line|
      if board.values_at(*line).count('[O]') == 3
        return "Player"
      elsif board.values_at(*line).count('[X]') == 3
        return "Computer"
      end
    end
    nil
  end

end

Game.new.new_turn