require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = random(11)
  end

  def score
    @user_letter = params[:word].upcase
    @letters = params[:letters]
    @grid = in_grid?(@letters, @user_letter)
    @dictionary = in_dictionary?
  end

  private

  def random(times)
    charset = Array('A'..'Z')
    Array.new(times) { charset.sample }
  end

  def in_grid?(grid_letters, word)
    word.chars.all? { |letter| word.count(letter) <= grid_letters.count(letter) }
  end

  def in_dictionary?
    url = "https://wagon-dictionary.herokuapp.com/#{@user_letter}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)
    @found = word['found']
  end
end
