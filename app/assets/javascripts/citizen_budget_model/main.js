/* jshint laxcomma: true */
jQuery(function ($) {
  $('.sortable').sortable({
    axis: 'y'
  , cursor: 'move'
  , handle: 'span.glyphicon-resize-vertical'
  , update: function (event) {
      var $target = $(event.target);
      var url;
      if($(this).data('sort_url') !== undefined) {
        url = $(this).data('sort_url');
      } else {
        url = location.href.split('?')[0].split('#')[0] + '/sort'
      }
      $.ajax({
        type: 'POST'
      , url: url
      , data: $target.sortable('serialize')
      }).done(function () {
        $target.effect('highlight');
      });
    }
  });

  $('.editable').editable({type: 'text'});

  $("#variable_public_editable").on('change', function(e) {
    if($(this).is(':checked')) {
      $(".only-for-public-editable").show();
    } else {
      $(".only-for-public-editable").hide();
    
    }
  });
});
