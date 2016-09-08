class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def isLetter?(char)
     char =~ /[A-Za-z]/
  end
  
  def guess(char)
    if char == '' || char == nil || isLetter?(char)==nil
      raise ArgumentError
    end
    
    if @guesses.include? char
      return false
    elsif @word.include? char
      @guesses += char
    elsif @wrong_guesses.include? char
      return false
    else
      @wrong_guesses += char
    end
    return true
  end
  
  def word_with_guesses
    res = ''
    @word.split('').each do |l|
      if @guesses.include? l
        res += l
      else
        res += '-'
      end
    end
    return res
  end
  
  def check_win_or_lose
    res = word_with_guesses
    if res == @word
      return :win
    elsif @guesses == ''
      return :lose
    else
      return :play
    end
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
