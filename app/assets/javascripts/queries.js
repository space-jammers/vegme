function changeButton() {
  $('.button').click(function(){
    var url = window.location.href;
    var buttonId = $(this).data('button-id');
    setTimeout(function(){
      $('#change-favorites-' + buttonId).load(url + ' #change-favorites-' + buttonId);
    }, 25);
  });
}

function dislikeDisappear(){
    $('.dislike').click(function(){
      console.log('clicked');
      $(this).parents('.recipe-query-box').remove();
    });
}

$( document ).ready(function() {
    $('.dislike').click(function(){
      console.log('clicked');
      $(this).parents('.recipe-query-box').remove();
    });
  changeButton();

});
