// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var wrap = $("#listing_profile_right");

wrap.on("scroll", function(e) {
    
  if (this.scrollTop > 100) {
    wrap.addClass("fixed_profile_right");
  } else {
    wrap.removeClass("fixed_profile_right");
  }
  
});

var main = function(){
   var menu = $('#listing_profile_right');

   $(document).scroll(function(){
      if ( $(this).scrollTop() >= $(window).height() - menu.height() ){
      menu.addClass('fixed_profile_right');
      } else {
      menu.removeClass('fixed_profile_right');
      }
   });
};
$(document).ready(main);