require 'spec_helper'

describe RevealsController do
  before :each do
    @game = Game.create
  end

  context 'when it is first click' do
    it 'sets last_revealed' do
      get :show, :game_id => @game.id, :id => 3
      @game.reload
      @game.last_revealed.should eql(3)
    end
  end

  context 'when it is last click' do
    it 'clears last_revealed' do
      @game.update_attribute(:last_revealed, 5)
      get :show, :game_id => @game.id, :id => 3
      @game.reload
      @game.last_revealed.should be_nil
    end
  end
  
  context 'on second click' do
    context 'both tiles are the same' do
      it 'sets both tiles to visible' do
        game = Game.create
        image = game.flickr_images.last
        tile1 = image.tiles.first
        tile2 = image.tiles.last
        game.update_attribute(:last_revealed, game.tiles.index(tile1))
        get :show, :game_id => game.id, :id => game.tiles.index(tile2)
        tile1.reload
        tile2.reload
        tile1.visible?.should be_true
        tile2.visible?.should be_true
      end
    end

    context 'tiles are different' do
      it 'sets both tiles to invisible' do
        game = Game.create
        image = game.flickr_images.last
        tile1 = image.tiles.first
        tile2 = game.flickr_images.first.tiles.last
        game.update_attribute(:last_revealed, game.tiles.index(tile1))
        get :show, :game_id => game.id, :id => game.tiles.index(tile2)
        tile1.reload
        tile2.reload
        tile1.visible?.should be_false
        tile2.visible?.should be_false
      end
    end
  end
end
