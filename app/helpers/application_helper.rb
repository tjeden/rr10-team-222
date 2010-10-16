module ApplicationHelper

  def flickr_img(photo, options = {})
    farm_id = photo.farm
    server_id = photo.server
    id = photo.photo_id
    secret = photo.secret
    size = case options[:size]
    when :thumbnail
      "_t" 
    when :small
      "_m" 
    when :medium
      "" 
    when :large
      "_b" 
    else
      "_s"
    end
    image_tag( "http://farm#{farm_id}.static.flickr.com/#{server_id}/#{id}_#{secret}#{size}.jpg" )
  end
end
