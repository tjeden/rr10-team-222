module ApplicationHelper

  def flickr_img(photo)
    farm_id = photo.farm
    server_id = photo.server
    id = photo.id
    secret = photo.secret
    image_tag( "http://farm#{farm_id}.static.flickr.com/#{server_id}/#{id}_#{secret}_s.jpg" )
  end
end
