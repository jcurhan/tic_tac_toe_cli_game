class Computer
  attr_accessor :game_symbol, :board, :game

  def initialize(board, game)
    @board = board
    @game = game
  end

  def make_move
    @game.current_player = self
    move = rand(1..9)
  end
end