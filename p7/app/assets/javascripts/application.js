// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function Tagger(imgId, tagId, leftId, topId, widthId, heightId) {
  this.isMouseDown = false;
  
  this.imgElement = document.getElementById(imgId);
  this.tagElement = document.getElementById(tagId);
  this.leftAttrElement = document.getElementById(leftId);
  this.topAttrElement = document.getElementById(topId);
  this.widthAttrElement = document.getElementById(widthId);
  this.heightAttrElement = document.getElementById(heightId);
  
  var obj = this;
  this.imgElement.onmousedown = function(event) {
    obj.mouseDown(event);
  }
}

Tagger.prototype.mouseDown = function(event) {
  var obj = this;
  
  this.oldMoveHandler = document.body.onmousemove;
  document.body.onmousemove = function(event) {
    obj.mouseMove(event);
  }
  
  this.oldUpHandler = document.body.onmouseup;
  document.body.onmouseup = function(event) {
    obj.mouseUp(event);
  }

  // Hide tag (help user to cancel the tag).
  this.tagElement.style.display = "none";
 
  // Set tag's top left point position.
  this.tagElement.style.left = event.pageX  + "px";
  this.tagElement.style.top = event.pageY + "px";

  // Set tag's width and height both to 0.
  this.tagElement.style.width = "0px";
  this.tagElement.style.height = "0px";
 
  this.isMouseDown = true;
  this.left = event.pageX;
  this.top = event.pageY;
}

Tagger.prototype.mouseMove = function(event) {
  if (!this.isMouseDown) {
    return;
  }
  
  // Show tag.
  this.tagElement.style.display = "inline";

  // Update tag's width and height.
  var pageX = Math.min(event.pageX, this.imgElement.offsetLeft + this.imgElement.width - 10);
  var pageY = Math.min(event.pageY, this.imgElement.offsetTop + this.imgElement.height - 10);
  this.tagElement.style.width = (pageX - this.left) + "px";
  this.tagElement.style.height = (pageY - this.top) + "px";
}

Tagger.prototype.mouseUp = function(event) {
  this.isMouseDown = false;
  document.body.onmousemove = this.oldMoveHandler;
  document.body.onmouseup = this.oldUpHandler;

  // Set tag's attributes for submitting to database.
  this.leftAttrElement.value = this.tagElement.style.left; 
  this.topAttrElement.value = this.tagElement.style.top; 
  this.widthAttrElement.value = this.tagElement.style.width; 
  this.heightAttrElement.value = this.tagElement.style.height;
}
