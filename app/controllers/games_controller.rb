class GamesController < ApplicationController

  def new
    @grid = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @grid = params[:grid].upcase.chars

    if !word_in_grid?(@word, @grid)
      @result = "The word can't be built out of the original grid"
    elsif !english_word?(@word.downcase)
      @result = "The word is not a valid English word"
    else
      @result = "Good job! #{@word} is valid!"
    end
  end

  def word_in_grid?(word, grid)
    word.chars.all? do |letter|
      word.count(letter) <= grid.count(letter)
    end
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = URI.open(url).read
    result = JSON.parse(response)
    result['found']
  end
  
end
