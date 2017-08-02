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
  $('.pointer').hover(function(e){
    var rId = $(e.target).data('pointer');
    $('.callout-footer[data-footer="'+rId+'"]').slideDown(250);
    var list = $('.callout-footer[data-footer="'+rId+'"]');
  },function(e){
    var rId = $(e.target).data('pointer');
    $('.callout-footer[data-footer="'+rId+'"]').slideUp(250);
  });
}

$(document).on('turbolinks:load', function() {
  dislikeDisappear();
  changeButton();
  callOutHover();
});
