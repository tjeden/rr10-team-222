class RevealsController < ApplicationController
  def show
    @game = Game.find(session[:current_game_id])
    render :nothing => true and return if current_user and current_user != @game.active_user
    @index1 = params[:id].to_i
    @index2 = @game.last_revealed
    @game.reveal_tile(@index1, current_user)
    @image = @game.get_photo_from_tile(@index1)
  end

  def check
    @game = Game::Multi.find( session[:current_game_id])
    if @game.last_move
      render :text => @game.last_move.number 
    else
      render :text => 0
    end
  end

  def old
    game = Game::Multi.find(session[:current_game_id])
    @move = Move.find_by_game_id_and_number(game.id, params[:id])
    if @move
      @index1 = @move.index1  
      @index2 = @move.index2  
      @image1 = game.get_photo_from_tile(@index1)
      @image2 = game.get_photo_from_tile(@index2)
    else
      render :nothing => true
    end
  end
end
