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
      $(this).parents('.recipe-query-box').fadeOut();
    });
}

$( document ).ready(function() {
  dislikeDisappear();
  changeButton();

  $('input#limit').focusout(function(){
      const rCount = $(this).val();
      console.log(rCount);
      $.ajax({
        url: "/result_count",
        type: 'post',
        data: { count: rCount }
      });
  });

});
