$(function() {
  var $review = $('.review');

  $review.bind('ajax:beforeSend', function() {
    $(this).find('input').attr('disabled', true);
  });

  $review.bind('ajax:error', function() {
    replaceButton(this, 'icon-remove', '#B94A48');
  });

  $review.bind('ajax:success', function() {
    replaceButton(this, 'icon-ok', '#468847');
  });

  function replaceButton(container, icon_class, color) {
    $(container).find('input:submit').
        replaceWith($('<i/>').
                      addClass(icon_class).
                      css('color', color));
  };

  function highlightStars(elem) {
    elem.parent().children('label').removeClass('toggled');
    elem.addClass('toggled').prevAll('label').addClass('toggled');
  }

  highlightStars($('.review input:checked + label'));

  var $stars = $('.review input:enabled ~ label');

  $stars.on('mouseenter', function() {
    highlightStars($(this));
  });

  $stars.on('mouseleave', function() {
    highlightStars($('.review input:checked + label'));
  });

  $('.review input').on('change', function() {
    $stars.off('mouseenter').off('mouseleave').off('click');
    $(this).parent('form').submit();
  });
});
