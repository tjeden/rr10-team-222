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
      game.errors[:images_category].should eql(['There is not enough photos in that category'])
      Game.count.should eql(0)
      Tile.count.should eql(0)
    end

  end
end
