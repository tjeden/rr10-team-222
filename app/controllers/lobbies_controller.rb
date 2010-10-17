class LobbiesController < ApplicationController
  before_filter :check_permission

  def index
    @game = Game::Multi.new( :max_players => 4)
  end

  def check; end

  def create
    if session[:current_game_id]
      begin
        old_game = Game.find(session[:current_game_id])
        if old_game.is_current_user_owner?
          old_game.cancel!
        end
      rescue
      end
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
  rescue
    redirect_to new_game_path
  end

  def users
    @game = Game::Multi.find(session[:current_game_id])
  rescue
    redirect_to game_path
  end

  def start
    @game = Game::Multi.find(session[:current_game_id])
    @game.start!
    redirect_to game_path
  end

end
