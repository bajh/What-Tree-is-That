function Slideshow() {
  this.picture = 1;
  this.interval;
}

Slideshow.prototype.cycle = function(next_pic) {
  self = this;
  setInterval(function(){
    $('html').attr('id', 'img' + self.picture);
    if (self.picture == 4) {
      self.picture = 1;
    } else {
      self.picture = self.picture + 1;
    }
  }, 650);
}

Slideshow.prototype.stop = function(object) {
  clearInterval(this.interval);
  $('html').css('background','url(' + object.image + ') no-repeat center center fixed');
  $('html').css('-webkit-background-size', 'cover');
  $('html').css('-moz-background-size', 'cover');
  $('html').css('-o-background-size', 'cover');
  $('html').css('background-size', 'cover');
}