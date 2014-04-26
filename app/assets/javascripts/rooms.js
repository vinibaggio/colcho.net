$(function() {
  var $review = $('.review');

  $review.on('ajax:beforeSend', function() {
    $(this).find('input').attr('disabled', true);
  });

  $review.on('ajax:error', function() {
    replaceButton(this, 'fa-times', '#B94A48');
  });

  $review.on('ajax:success', function() {
    replaceButton(this, 'fa-check', '#468847');
  });

  function replaceButton(container, icon_class, color) {
    $(container).find('input:submit').
        replaceWith($('<i/>').
                      addClass(icon_class).
                      addClass('fa').
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
