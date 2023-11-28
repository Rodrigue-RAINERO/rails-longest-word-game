require 'open-uri'

class GamesController < ApplicationController
  VOYELLES = ["A", "E", "I", "O", "U", "Y"]
  def new
    @voyelles = VOYELLES

    @consonnes = ('A'..'Z').to_a - @voyelles

    @letters = @consonnes.sample(5) + @voyelles.sample(5)
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)

    # api_url = "https://wagon-dictionary.herokuapp.com/#{params[:letter]}"
    # response = URI.open(api_url).read
    # @data = JSON.parse(response)
    # if @data['found']
    #   return "valid word"
    # else
    #   return "non"
    # end
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
