module AllColors
  COLORS = ['red', 'blue', 'yellow', 'green', 'black', 'white']
end

class CodeMaker
  include AllColors
  attr_reader :generate_code, :code
  attr_accessor :check_code

  def generate_code
    @code = [COLORS.sample, COLORS.sample, COLORS.sample, COLORS.sample]
  end

  def check_code(guess)
    p @code
    p guess
    intersection = @code - guess
    p intersection
    color = 4 - intersection.length
    location = 0
    p color
    p location

    @code.each_with_index do |code_color, index|
      if code_color == guess[index]
        location += 1
        color -= 1
      end
    end

    p "Secret Code: #{@code}"
    p "Your Guess: #{guess}"
    p "Correct Color: #{color}"
    p "Correct Location: #{location}"
  end
end

class CodeBreaker
  include AllColors
  attr_reader :code_guess
  attr_accessor :turns

  def initialize
    @code_guess = []
    @turns = 12
  end

  def validate_guess(guess)
    valid = false

    until valid
      if COLORS.include?(guess)
        @code_guess.push(guess)
        valid = true
      else
        p "Please choose a valid color: red, blue, yellow, green, black, or white."
        guess = gets.chomp
      end
    end
  end

  def clear_guess
    @code_guess = []
  end

  def guess
    puts "Guess first color."
    guess_one = gets.chomp.downcase
    validate_guess(guess_one) 
    puts "Guess second color."
    guess_two = gets.chomp.downcase
    validate_guess(guess_two) 
    puts "Guess third color."
    guess_three = gets.chomp.downcase
    validate_guess(guess_three) 
    puts "Guess fourth color."
    guess_four = gets.chomp.downcase
    validate_guess(guess_four) 
  end
end

class Game
  def game_start
    @hal = CodeMaker.new
    @dave = CodeBreaker.new 
    @turns = 12
    @gameover = false
    @hal.generate_code
    game_loop
  end

  def game_loop
    while @dave.turns > 0
      @dave.guess
      @hal.check_code(@dave.code_guess)
      @dave.clear_guess
      @dave.turns -= 1
      puts "You have #{@dave.turns} guesses left."
    end
  end
end

new_game = Game.new
new_game.game_start

