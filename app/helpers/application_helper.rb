module ApplicationHelper

  def flickr_img(photo, options = {})
    image_tag(photo.get_url(options))
  end

  def flickrify(text)
    "<span class='title'>#{text[0...-1]}</span><span class='title_alt'>#{text[-1..-1]}</span>".html_safe
  end

  def show_elapsed_time(game)
    all_seconds = (Time.now - game.created_at).round
    minutes = all_seconds / 60
    seconds = all_seconds % 60

    sprintf('%d:%2d', minutes, seconds).gsub(' ', '0')
  end
end
