module AllColors
  COLORS = ['red', 'blue', 'yellow', 'green', 'black', 'white']
end

class CodeMaker
  include AllColors
  attr_accessor :generate_code, :code

  def generate_code
    @code = [COLORS.sample, COLORS.sample, COLORS.sample, COLORS.sample]
  end

  def check_code
  end
end

class CodeBreaker
  include AllColors
  attr_accessor :code_guess, :turns

  def initialize
    @code_guess = []
    @turns = 12
  end

  def validate_guess(guess)
    valid = false

    until valid
      if COLORS.include?(guess)
        p "You guessed #{guess}"
        @code_guess.push(guess)
        p @code_guess
        valid = true
      else
        p "Please choose a valid color: red, blue, yellow, green, black, or white."
        guess = gets.chomp
      end
    end
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
end

hal = CodeMaker.new
dave = CodeBreaker.new
dave.guess
