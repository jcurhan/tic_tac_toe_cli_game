require_relative 'board'
require_relative 'player'
require_relative 'computer'

class Game
  attr_accessor :board, :current_player
  PIECES = ["X", "O"]

  def initialize
    @board = Board.new
    @player = Player.new(@board, self)
    @computer = Computer.new(@board, self)
    start_game
  end

  def players 
    @players ||= [@player, @computer]
  end

  def start_game
    game_intro
    pick_game_symbol
    select_first_player
    move = make_first_move
    update_the_grid(move)
  end

  def game_intro
    @board.intro_board
    puts 'if you are ready, type "Yes"'
    gets.chomp.downcase == "yes" ? true : game_intro
  end

  def pick_game_symbol
    puts "Great! to begin, please choose your symbol. Type either 'X' or 'O'"
    response = gets.chomp
    if PIECES.include?(response)
      @player.game_symbol = response
      @computer.game_symbol = (PIECES - [@player.game_symbol]).first
    else
      puts "That's not a valid symbol. Please try again"
      pick_game_symbol
    end
  end

  def select_first_player
    @current_player = players.sample
  end

  def make_first_move
    @current_player.make_move
  end

  def update_the_grid(move = nil)
     if @board.valid_space?(move, @current_player)
      check_for_winner
      set_next_move
    else
      if @current_player == @player
        puts 'That space is already taken or is an invalid response.'
      end
        redo_move
    end
  end

  def set_next_move
    @current_player == @player ? computer_make_move : player_make_move
  end

  def redo_move
    @current_player == @player ? player_make_move : computer_make_move
  end

  def player_make_move
    move = @player.make_move
    update_the_grid(move)
  end

  def computer_make_move
    move = @computer.make_move
    update_the_grid(move)
  end

  def check_for_winner
    if check_rows_for_win || check_cols_for_win || check_diags_for_win
      print_winner_name_and_play_again
    else 
      check_for_tie
    end
  end

  def check_for_tie
    @board.board_full? ? print_tie_message_and_play_again : true
  end

  def check_rows_for_win(rows = nil)
    rows = rows || @board.grid  
    rows.any? do |row|
      row.uniq.length == 1 && !row.include?(' ')
    end
  end

  def check_cols_for_win
    cols = @board.transpose_board_grid
    check_rows_for_win(cols)
  end

  def check_diags_for_win
    diag1 = []
    diag2 = []
    for idx in (0..@board.number_of_columns - 1)
      diag1 << @board.grid[idx][idx]
      diag2 << @board.grid[idx][-(idx + 1)]
    end
    diags = [diag1, diag2]
    check_rows_for_win(diags)
  end

  def print_winner_name_and_play_again
    @board.show_board
    puts "#{self.current_player.class} wins!"
    play_again?
  end

  def print_tie_message_and_play_again
    @board.show_board
    puts "The game is a draw!"
    play_again?
  end

  def play_again?
    puts 'Do you want to play again (Yes / No)'
    gets.chomp.downcase == 'yes' ? Game.new : abort("Thank you for playing!")
  end
end

Game.new