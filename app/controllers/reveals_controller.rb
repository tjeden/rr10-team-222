class RevealsController < ApplicationController
  def show
    @game = Game.find(session[:current_game_id])
    render :nothing => true and return if current_user and current_user != @game.active_player
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
    game = Game::Multi.find(session[:current_game_id])
    @move = Move.find_by_game_id_and_number(game.id, params[:id])
    @index1 = @move.index1  
    @index2 = @move.index2  
    @image1 = game.get_photo_from_tile(@index1)
    @image2 = game.get_photo_from_tile(@index2)
  end
end
