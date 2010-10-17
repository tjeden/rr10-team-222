require 'spec/spec_helper'

describe Game do
  context 'on create' do
    it 'creates 12 photos' do
      lambda {
        Game.create
      }.should change(FlickrImage, :count).by(12)
      Tile.count.should eql(24)
      photo = FlickrImage.last
      photo.farm.should_not be_nil
      photo.server.should_not be_nil
      photo.photo_id.should_not be_nil
      photo.secret.should_not be_nil
    end

    it 'sets error when tag was not found' do
      game = nil
      lambda {
        game = Game.create( :images_category => 'titssdadasdafsdfsafsa')
      }.should change(FlickrImage, :count).by(0)
      game.errors[:images_category].should eql(['There is not enough photos in this category'])
      Game.count.should eql(0)
      Tile.count.should eql(0)
    end

    it 'allows to combine 2 tags' do
      game = nil
      lambda {
        game = Game.create( :images_category => 'tits boobs')
      }.should change(Game, :count).by(1)
    end
  end

  context 'reveal_tile' do
    before :each do
      @game = Game.create
    end

    context 'when it is first click' do
      it 'sets last_revealed' do
        @game.reveal_tile(3)
        @game.reload
        @game.last_revealed.should eql(3)
      end
    end

    context 'when it is last click' do
      it 'clears last_revealed' do
        @game.update_attribute(:last_revealed, 5)
        @game.reveal_tile(3)
        @game.reload
        @game.last_revealed.should be_nil
      end
    end
  
    context 'on second click' do
      context 'both tiles are the same' do
        it 'sets both tiles to visible' do
          image = @game.flickr_images.last
          tile1 = image.tiles.first
          tile2 = image.tiles.last
          @game.update_attribute(:last_revealed, @game.tiles.index(tile1))
          @game.reveal_tile( @game.tiles.index(tile2))
          tile1.reload
          tile2.reload
          tile1.visible?.should be_true
          tile2.visible?.should be_true
        end
      end

      context 'tiles are different' do
        it 'sets both tiles to invisible' do
          @game = Game.create
          image = @game.flickr_images.last
          tile1 = image.tiles.first
          tile2 = @game.flickr_images.first.tiles.last
          @game.update_attribute(:last_revealed, @game.tiles.index(tile1))
          @game.reveal_tile( @game.tiles.index(tile2))
          tile1.reload
          tile2.reload
          tile1.visible?.should be_false
          tile2.visible?.should be_false
        end
      end
    end
  end
end
