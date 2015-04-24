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

  protected

  def display_row(number)
    row = String.new
    (0..2).each do |position|
      row << " #{cells[number + position].status}"
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


class Game
  attr_accessor :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
  end


=begin
  def new_turn
    system 'clear' # To move under board.display
    board.display
    human.make_a_move
    check_end_game
    board.display
    computer.make_a_move
    check_end_game
    board.display
    play_again_or_quit
  end

=end


  def play_again_or_quit
    puts "Play again? (Y/N)"
    choice = gets.chomp.downcase
    if choice == 'y'
      return new_round
    elsif choice == 'n'
      puts "#{human.name}, see you next time!"
    else
      puts "Invalid choice. Try again."
      start_new_round_or_quit
    end
  end
end

Board.new.display