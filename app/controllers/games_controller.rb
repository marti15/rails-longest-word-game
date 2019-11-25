class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @answer = params['answer']
    @letters = params[:letters]

    if included?(@answer.upcase, @letters)
      if english_word?
        @message = "Well done!"
      else
        @message = "Not an english word!"
      end
    else
      @message = "Not in the grid!"
    end
  end

  def english_word?
    @answer = params['answer']
    response = open("https://wagon-dictionary.herokuapp.com/#{@answer}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end
end
