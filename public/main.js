$(window).load(function(){

  var geolocationAttempts = 0;

  $('#info').on('click', function() {
    $(this).hide();
    $('#footer_text').slideToggle();
  });

  $('#footer_text').on('click', function() {
    $(this).slideToggle(function() {
      $('#info').slideToggle();
    });
  });

  slide_show = new Slideshow();
  slide_show.cycle();

  $('.disclaimer').on('click', function() {
    $('footer').show();
  });

  if ("geolocation" in navigator) {
    geolocationCall(geolocationAttempts);
  };

  function geolocationCall(counter){
    navigator.geolocation.getCurrentPosition(function(position) {
      var latitude = position.coords.latitude;
      var longitude = position.coords.longitude;
      $.post('coordinates', { latitude: latitude, longitude: longitude }, function(response){
          if (response.species == null) {
            $('#main-text').text("Sorry, we couldn't find any trees near you!");
          } else if (response.species == "error") {
            if (counter > 2) {
              $('#main-text').text("An error occurred. Please try again later");
            } else {
              counter += 1;
              setTimeout(geolocationCall(counter), 500);
            }
          } else if (response.species == "UNKNOWN" || response.species == "") {
            $('#main-text').text("Nobody knows!");
          } else {
            $('#main-text').text(response.species);
            slide_show.stop(response.image);
          }
        }
      )
    })
  }

})