class LobbiesController < ApplicationController
  def index
    @game = Game::Multi.new( :max_players => 4)
  end

  def create
    if session[:current_game_id]
      Game.find(session[:current_game_id]).cancel! rescue nil
    end
    @game = Game::Multi.new(params[:game])
    if @game.save
      session[:current_game_id] = @game.id
      current_user.update_attribute(:game_id, @game.id)
      render :action => :wait
    else
      render :action => :index
    end
  end

  def wait
    @game = Game::Multi.find(session[:current_game_id])
  end

  def start
    @game = Game::Multi.find(session[:current_game_id])
    @game.start!
    redirect_to game_path
  end
end
