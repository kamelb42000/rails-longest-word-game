require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end


  def score
    @letters = params[:game_letters]
    @word = params[:words]
    if letters_grid(@word)
      if word_api(@word)
        @response = "Bonne réponse"
      else
        @response = "Ton mot n'est pas anglais"
      end
    else
      @response = "Tes lettres ne sont pas dans le tableau"
    end
  end

  private

  def letters_grid(word)
    word.chars.all? { |letter| @letters.include?(letter) }
  end

  def word_api(words)
    url = "https://wagon-dictionary.herokuapp.com/#{words}"
    response = URI.open(url).read
    word_data = JSON.parse(response)
    word_data['found']
  end

end
