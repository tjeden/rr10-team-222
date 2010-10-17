class LobbiesController < ApplicationController
  def index
    @game = Game::Multi.new
  end

  def create
    if session[:current_game_id]
      Game.find(session[:current_game_id]).cancel! rescue nil
    end
    @game = Game::Multi.new(params[:game])
    if @game.save
      session[:current_game_id] = @game.id
      redirect_to game_path
    else
      render :action => :index
    end
  end
end
