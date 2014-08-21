jQuery(function ($) {
  $('.sortable').sortable({
    axis: 'y'
  , cursor: 'move'
  , handle: 'span.glyphicon-resize-vertical'
  , update: function (event, ui) {
      $target = $(event.target);
      $.ajax({
        type: 'POST'
      , url: location.href.split('?')[0].split('#')[0] + '/sort'
      , data: $target.sortable('serialize')
      }).done(function (request) {
        $target.effect('highlight');
      })
    }
  })
});
