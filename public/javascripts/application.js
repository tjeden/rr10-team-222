var block_click = false;

function reveal_image_at_index(url, index) {
  $('#img_'+index).fadeOut(700, function() {
      $('#img_'+index).html('<img src="' + url + '" alt="revealed tile"/>');
      $('#img_'+index).fadeIn(700, function() {
        block_click = false;
      });
  });
}

function hide_images_at_indexes(index1, index2) {
  $('#img_'+index1 + ', #img_'+index2).fadeOut(500, function() {
    $('#img_'+index1).html('<img src="/images/card_back.jpg" alt="Click to reveal"/>').removeClass('highlighted');
    $('#img_'+index2).html('<img src="/images/card_back.jpg" alt="Click to reveal"/>').removeClass('highlighted');
    $('#img_'+index1 + ', #img_'+index2).fadeIn(500, function() {
        block_click = false;
    });
  });
}

function prepare_to_hide_images_at_indexes(index1, index2) {
  setTimeout( 'hide_images_at_indexes(' + index1 + ', ' + index2 + ')', 5000 );
}

$(document).ready(function() {
  $('ul.tiles a.hidden_image').click(function() {
    if (block_click) return;
    if (typeof(checked_tile) == 'undefined' || checked_tile != $(this).attr('id')) {
      block_click = true;
      $(this).addClass('highlighted');

      $.getScript('game/reveals/' + $(this).attr('id').substr(4));
    }
  });
});
