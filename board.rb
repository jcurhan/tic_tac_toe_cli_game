class Board
  attr_accessor :grid

  def initialize(size = 3)
   @grid = Array.new(size) { Array.new(size, ' ')}
  end

  def intro_board
    puts "Welcome to Justin's Tic-Tac-Toe! Each player will take a turn selecting a square from the gameboard."
    puts "Below is what the board looks like. There are squares 1-9." 
    puts "Whichever player, if any, gets three of his or her 'X' or 'O' symbol in a row, wins!"
    puts "1 | 2 | 3" 
    puts "----------"
    puts "4 | 5 | 6" 
    puts "----------"
    puts "7 | 8 | 9"
  end

  def show_board
    puts 'Current Game Board:'
    @grid.each do |space|
      puts "#{space[0]} | #{space[1]} | #{space[2]}"
    end
  end

  def number_of_columns
    @grid.length
  end

  def valid_space?(position, player)
    @current_player = player
    find_position(position)
    if (position.between?(1,9) && !space_taken?)
      update_space
    else
      false
    end
  end

  def update_space
    @grid[@row][@column] = @current_player.game_symbol
  end

  def find_position(position)
    @row = ((position - 1) / 3).to_f.ceil
    @column = (position - 1) % 3
  end

  def space_taken?
    @grid[@row][@column] == "X" || @grid[@row][@column] == "O"
  end

  def board_full?
    !@grid.flatten.select {|space| space == ' '}.any?
  end

  def transpose_board_grid
    cols = []
    for idx in (0..number_of_columns - 1) do
      cols << self.grid.collect {|row| row[idx] }
    end 
    cols
  end
end