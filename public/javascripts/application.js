var block_click = false;

$(document).ready(function() {
  $('ul.tiles a.hidden_image').click(function() {
    if (typeof(checked_tile) == 'undefined' || checked_tile != $(this).attr('id')) {
      block_click = true;
      $(this).addClass('highlighted');

      $.getScript('game/reveal/' + $(this).attr('id').substr(4), function() {
        alert('Load was performed:' + data);
        block_click = false;
      });
    }
  });
});
