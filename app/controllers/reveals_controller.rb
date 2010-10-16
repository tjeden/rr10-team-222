class RevealsController < ApplicationController
  def show
    game = Game.find(session[:current_game_id])
    @image = game.reveal_tile(params[:id].to_i)
    @index = params[:id]
  end
end
