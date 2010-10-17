var block_click = false;
var elements_to_hide = new Array(2);
var checked_tile;
var preloaded_images = new Array();
var last_move;

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

function checkOtherMoves() {
  if (!my_turn) {
    $.get('game/reveals/check',function(new_move) {
      if (typeof(last_move) == 'undefined') {
        last_move = new_move;
      } else if (new_move != last_move) {
        console.log(last_move);
        console.log(new_move);
        last_move = parseInt(last_move) + 1;
        $.getScript('game/reveals/' + last_move + '/old');
      }
    });
  }
}

function advance_time() {
  var time = $('#timer').html().split(':');
  var seconds = parseFloat(time[1]);
  var minutes = parseFloat(time[0]);
  seconds = seconds + 1;
  if (seconds > 59) {
    seconds = 0;
    minutes = minutes + 1;
  }
  if (seconds < 10) {
    s_seconds = '0' + (seconds + '')
  } else {
    s_seconds = '' + seconds
  }
  $('#timer').html(minutes + ':' + s_seconds)
}

$(document).ready(function() {
  $('input[placeholder],textarea[placeholder]').placeholder();

  $('ul.tiles a.hidden_image').click(function(e) {
    e.preventDefault();
    if (!my_turn) { return false; }
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

  if ($('#multiplayer_game').length) {
    setInterval(function (){ checkOtherMoves(); }, 2000); 
  }
  if ($('#timer').length) {
    setInterval(function (){ advance_time(); }, 1000);
  }

});
