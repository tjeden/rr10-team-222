class RevealsController < ApplicationController
  def show
    @game = Game.find(params[:game_id])
    @game.reveal_tile(params[:id])
  end
end
