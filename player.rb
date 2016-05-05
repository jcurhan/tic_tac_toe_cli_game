class Player
  attr_accessor :game_symbol, :board, :game

  def initialize(board, game)
    @board = board
    @game = game  
  end

  def make_move
    @board.show_board
    @game.current_player = self
    puts 'Please select a square (1-9).'
    move = gets.chomp.to_i
  end
end
