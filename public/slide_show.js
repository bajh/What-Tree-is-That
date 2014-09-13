function Slideshow() {
  this.cycling = true;
}

Slideshow.prototype.cycle = function(next_pic) {
  self = this;
  if (this.cycling) {
    setTimeout(function(){
      page = $('html');
      page.css('background','url(tree_' + next_pic + '.jpg) no-repeat center center fixed');
      page.css('-webkit-background-size', 'cover');
      page.css('-moz-background-size', 'cover');
      page.css('-o-background-size', 'cover');
      page.css('background-size', 'cover')
      if (next_pic == 4) {
        self.cycle(1);
      } else {
        self.cycle(next_pic + 1);
      }
    }, 650);
  } else {
    page.css('background','url(' + self.image + ') no-repeat center center fixed');
    page.css('-webkit-background-size', 'cover');
    page.css('-moz-background-size', 'cover');
    page.css('-o-background-size', 'cover');
    page.css('background-size', 'cover');
  }
}

Slideshow.prototype.stop = function(image) {
  this.cycling = false;
  this.image = image;
}