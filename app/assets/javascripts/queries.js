function changeButton() {
  $('.fav').click(function(){
    var url = window.location.href;
    var buttonId = $(this).data('button-id');
    setTimeout(function(){
      $('#change-favorites-' + buttonId).load(url + ' #change-favorites-' + buttonId);
    }, 25);
  });
}

function dislikeDisappear(){
  $('.dislike').click(function(){
    $(this).parents('.callout').remove();
  });
}

function callOutHover(){
  $('[data-callout-hover-reveal]').hover(function(){
    $(this).find('.callout-footer').slideDown(250);
      },function(){
    $(this).find('.callout-footer').slideUp(250);
    });
}

$(document).on('turbolinks:load', function() {
  dislikeDisappear();
  changeButton();
  callOutHover();
});
