var block_click = false;
var elements_to_hide = new Array(2);
var checked_tile;
var preloaded_images = new Array();

function reveal_image_at_index(url, index, remove_block) {
  $('#img_'+index).fadeOut(400, function() {
      $('#img_'+index).html('<img src="' + url + '" alt="revealed tile"/>');
      $('#img_'+index).fadeIn(400, function() {
        if (remove_block) block_click = false;
      });
  });
}

function hide_images_at_indexes(index1, index2) {
  $('#img_'+index1 + ', #img_'+index2).fadeOut(200, function() {
    $('#img_'+index1).html('<img src="/images/card_back2.jpg" alt="Click to reveal"/>').removeClass('highlighted').addClass('hidden_image');
    $('#img_'+index2).html('<img src="/images/card_back2.jpg" alt="Click to reveal"/>').removeClass('highlighted').addClass('hidden_image');
    $('#img_'+index1 + ', #img_'+index2).fadeIn(200, function() {
        block_click = false;
    });
  });
}

function prepare_to_hide_images_at_indexes(index1, index2) {
  block_click = setTimeout( 'hide_images_at_indexes(' + index1 + ', ' + index2 + ')', 4000 );
  checked_tile = null;
  elements_to_hide[0] = index1;
  elements_to_hide[1] = index2;
}

function preload_images(image_list) {
  jQuery.each(image_list, function(i) {
    preloaded_images[i] = new Image();
    preloaded_images[i].src = this;
  });
}

$(document).ready(function() {
  $('input[placeholder],textarea[placeholder]').placeholder();

  $('ul.tiles a.hidden_image').click(function(e) {
    e.preventDefault();
    var ok_to_continue = true;
    if (block_click != false)
    {
      ok_to_continue = false;
      if (typeof(block_click) == 'number')
      {
        ok_to_continue = true;
        clearTimeout(block_click);
        hide_images_at_indexes(elements_to_hide[0], elements_to_hide[1]);
        checked_tile = null;
      }
    } 
    if (ok_to_continue && (typeof(checked_tile) == 'undefined' || checked_tile != $(this).attr('id')))
    {
      block_click = true;
      checked_tile = $(this).attr('id');
      elements_to_hide = new Array(2);
      $(this).addClass('highlighted');

      $.getScript('game/reveals/' + $(this).attr('id').substr(4));
    }
  });
});
