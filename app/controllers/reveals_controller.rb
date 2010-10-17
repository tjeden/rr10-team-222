class RevealsController < ApplicationController
  def show
    @game = Game.find(session[:current_game_id])
    @index1 = params[:id].to_i
    @index2 = @game.last_revealed
    @game.reveal_tile(@index1, current_user)
    @image = @game.get_photo_from_tile(@index1)
  end

  def check
    @game = Game::Multi.find( session[:current_game_id])
    render :text => @game.last_move.number
  end

  def old
    move = Move.find_by_game_id_and_number(session[:current_game_id],params[:reveal])
    render :text => 'ok'
  end
end
