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

Slideshow.prototype.stop = function(image) {
  clearInterval(this.interval);
  page.css('background','url(' + image + ') no-repeat center center fixed');
  page.css('-webkit-background-size', 'cover');
  page.css('-moz-background-size', 'cover');
  page.css('-o-background-size', 'cover');
  page.css('background-size', 'cover');
}