function adminChange() {
  $('.feedback-admin-form').click(function(){
    this.submit(function(e){
      e.preventDefault();
      console.log("SUCCESS");
    });
  });
}

$(function(){
  adminChange();
});
