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
    puts "   Tic Tac Toe"
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
  def make_a_move(board)
    puts "Choose a cell from #{board.empty_cells} to place your next move."
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
      move = board.empty_cells.sample
    end
    board.empty_cells.delete(move)
    board.computer_cells << move
  end

  protected

  def best_move(board)
    if board.empty_cells.include?(5)
      return 5
    elsif (move = computer_winning_move(board))
      return move
    elsif (move = computer_defending_move(board))
      return move
    elsif (move = computer_attacking_move(board))
      return move
    else
      return nil
    end
  end

  protected

  # To complete a winning line
  def computer_winning_move(board)
    Game::WINNING_LINES.each do |line|
      if ((board.computer_cells & line).count == 2) && ((board.empty_cells & line).count == 1)
        move = line & board.empty_cells
        return move[0]
      end
    end
    nil
  end

  # To block player from winning
  def computer_defending_move(board)
    Game::WINNING_LINES.each do |line|
      if ((board.human_cells & line).count == 2)
        move = board.empty_cells & line
        return move[0]
      end
    end
    nil
  end

  # To form a potentially winning line
  def computer_attacking_move(board)
    Game::WINNING_LINES.each do |line|
      if ((board.computer_cells & line).count == 1) && ((board.empty_cells & line).count == 2)
        move = (board.empty_cells & line).sample
        return move
      end
    end
    nil
  end
end

class Game
  attr_accessor :board, :human, :computer
  WINNING_LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
  end

  def new_turn
    board.display
    human.make_a_move(board)
    board.display
    check_end_game
    computer.make_a_move(board)
    board.display
    check_end_game
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
      if (board.human_cells & line).count == 3
        return "Player"
      elsif (board.computer_cells & line).count == 3
        return "Computer"
      end
    end
    nil
  end

  def check_end_game
    if winner
      puts "#{winner} won!"
      play_again_or_quit
    elsif board.empty_cells == [ ]
      puts "It's a tie."
      play_again_or_quit
    end
  end
end

Game.new.new_turn

