require 'spec/spec_helper'

describe Game do
  context 'on create' do
    it 'creates 24 photos' do
      lambda {
        Game.create
      }.should change(FlickrImage, :count).by(12)
      photo = FlickrImage.last
      photo.farm.should_not be_nil
      photo.server.should_not be_nil
      photo.photo_id.should_not be_nil
      photo.secret.should_not be_nil
    end

  end
end
