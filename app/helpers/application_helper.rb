module ApplicationHelper

  def flickr_img(photo, options = {})
    image_tag(photo.get_url(options))
  end

  def flickrify(text)
    "<span class='title'>#{text[0...-1]}</span><span class='title_alt'>#{text[-1..-1]}</span>".html_safe
  end
end
