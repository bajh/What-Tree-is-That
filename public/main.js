$(window).load(function(){

  $('#info').on('click', function(){
    $(this).hide();
    $('footer').slideToggle();
    $('document').on('click', function(){
      $('footer').slideToggle();
      
    })
  });

  slide_show = new Slideshow();
  slide_show.cycle();

  $('.disclaimer').on('click', function(){
    $('footer').show();
  });

  if ("geolocation" in navigator) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var latitude = position.coords.latitude;
      var longitude = position.coords.longitude;
      $.post('coordinates', { latitude: latitude, longitude: longitude }, function(response){
          if (response.species == null) {
            $('#main-text').text("Sorry, we couldn't find any trees near you!");
          } else {
            if (response.species == "UNK" || response.species == "") {
              $('#main-text').text("Nobody knows!");
            } else {
              $('#main-text').text(response.species);
              slide_show.stop(response.image);
            }
          }
        }
      )
    })
  }
})