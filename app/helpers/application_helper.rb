module ApplicationHelper

  def flickr_img(photo, options = {})
    farm_id = photo.farm
    server_id = photo.server
    id = photo.id
    secret = photo.secret
    if options[:size]
      size = "_t" if options[:size] == :thumbnail
      size = "_m" if options[:size] == :small
      size = "" if options[:size] == :medium
      size = "_b" if options[:size] == :large
    else
      size = "_s"
    end
    image_tag( "http://farm#{farm_id}.static.flickr.com/#{server_id}/#{id}_#{secret}#{size}.jpg" )
  end
end
