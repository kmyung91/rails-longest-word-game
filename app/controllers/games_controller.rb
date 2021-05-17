class GamesController < ApplicationController
  def new
# TODO: generate random grid of letters
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def included?
    params[:word].chars.all? { |letter| params[:word].count(letter) <= params[:letters].count(letter) }
  end

  def english?
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)
    json['found']
  end

  def score
    if included? == false
      @response = "Sorry but #{params[:word]} can't be built out of #{params[:letters]}"
    elsif english? == false
      @response = "Sorry but #{params[:word]} does not seem to be a valid English word..."
    else
      @response = "Congratulations! #{params[:word]} is a valid English word!"
    end
  end
end
