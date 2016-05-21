$( document ).ready(function() {
  //display spinner between pages
  $(document).on("page:fetch", function(){
    $(".sk-folding-cube").show();
  });

  $(document).on("page:receive", function(){
    $(".sk-folding-cube").hide();
  });

});
