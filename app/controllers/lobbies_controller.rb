class LobbiesController < ApplicationController
  before_filter :check_permission

  def index
    @game = Game::Multi.new( :max_players => 4)
  end

  def check; end

  def create
    cancel_game
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
    @game = Game::Multi.find(current_user.game_id)
  rescue
    quit_game
  end

  def users
    @game = Game::Multi.find(current_user.game_id)
    quit_game if @game.canceled?
  rescue
    quit_game
  end

  def start
    @game = Game::Multi.find(current_user.game_id)
    @game.start!
    redirect_to game_path
  rescue
    session[:current_game_id] = nil
    redirect_to lobby_path
  end

  def back
    cancel_game
    redirect_to :action => :index
  end

end
