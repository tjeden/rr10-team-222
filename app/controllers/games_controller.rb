class GamesController < ApplicationController

  def show
    if session[:current_game_id].blank?
      render :action => 'new_game'
    else
      @game = Game.find(session[:current_game_id])
    end
  end

  def new
    @game = Game.create!
    session[:current_game_id] = @game.id
    redirect_to game_path
  end
  
end
