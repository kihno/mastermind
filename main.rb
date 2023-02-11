module AllColors
  COLORS = ['red', 'blue', 'yellow', 'green', 'black', 'white']
end

class CodeMaker
  include AllColors
  attr_reader :code, :correct_color, :correct_location

  def generate_code
    @code = [COLORS.sample, COLORS.sample, COLORS.sample, COLORS.sample]
  end

  def check_code(guess)
    @correct_color = 0
    @correct_location = 0
    code_match = @code.map(&:clone)

    guess.each do |guess_color|
      if code_match.include?(guess_color)
        index = code_match.index(guess_color)
        code_match.delete_at(index)
        @correct_color += 1
      end
    end

    @code.each_with_index do |code_color, index|
      if code_color == guess[index]
        @correct_location += 1
        @correct_color -= 1
      end
    end
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
    puts "Guess first color:"
    guess_one = gets.chomp.downcase
    validate_guess(guess_one)
    puts "Guess second color:"
    guess_two = gets.chomp.downcase
    validate_guess(guess_two)
    puts "Guess third color:"
    guess_three = gets.chomp.downcase
    validate_guess(guess_three)
    puts "Guess fourth color:"
    guess_four = gets.chomp.downcase
    validate_guess(guess_four)
  end
end

class Game
  def game_start
    @hal = CodeMaker.new
    @dave = CodeBreaker.new
    @gameover = false
    @hal.generate_code
    game_loop
  end

  def welcome_message
    puts "Welcome to Mastermind. You have 12 guesses to break the super secret code. The secret code is 4 colors from the following options: red, blue, yellow, green, white, or black. Colors may repeat. Enter your guess."
  end

  def response
    if @hal.correct_location == 4
      @gameover = true
      puts "Your guess: #{@dave.code_guess}"
      puts "Secret Code: #{@hal.code}"
      puts "You broke the code!"
    elsif @dave.turns == 1
      @gameover = true
      puts "Your guess: #{@dave.code_guess}"
      puts "Secret Code: #{@hal.code}"
      puts "Mission failed. You couldn't hack it."
    else
      puts "Your guess: #{@dave.code_guess}"
      puts "Correct Color: #{@hal.correct_color}"
      puts "Correct Location: #{@hal.correct_location}"
      @dave.turns -= 1
      puts "You have #{@dave.turns} guesses left."
    end
  end

  def game_loop
    welcome_message
    until @gameover
      @dave.guess
      @hal.check_code(@dave.code_guess)
      response
      @dave.clear_guess
    end
  end
end

new_game = Game.new
new_game.game_start
