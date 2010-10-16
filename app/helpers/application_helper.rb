module ApplicationHelper

  def flickr_img(photo, options = {})
    image_tag(flickr_url(photo, options = {}))
  end

  def flickrify(text)
    "<span class='title'>#{text[0...-1]}</span><span class='title_alt'>#{text[-1..-1]}</span>".html_safe
  end

  def flickr_url(photo, options = {})
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
    "http://farm#{farm_id}.static.flickr.com/#{server_id}/#{id}_#{secret}#{size}.jpg" 
  end
end
