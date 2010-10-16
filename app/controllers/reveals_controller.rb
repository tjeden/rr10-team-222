class RevealsController < ApplicationController
  def show
    @game = Game.find(session[:current_@game_id])
    @index1 = params[:id].to_i
    @index2 = @game.last_revealed
    @result = @game.reveal_tile(@index1)
    @image = @game.get_photo_from_tile(@index1)
  end
end
