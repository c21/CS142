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
function Dragger(id) {
    this.isMouseDown = false;
    this.element = document.getElementById(id);
    var obj = this;
    this.element.onmousedown = function(event) {
        obj.mouseDown(event);
    }
}

Dragger.prototype.mouseDown = function(event) {
    var obj = this;
    this.oldMoveHandler = document.body.onmousemove;
    document.body.onmousemove = function(event) {
        obj.mouseMove(event);
    }
    this.oldUpHandler = document.body.onmouseup;
    document.body.onmouseup = function(event) {
        obj.mouseUp(event);
    }
    this.oldX = event.pageX;
    this.oldY = event.pageY;
    this.isMouseDown = true;
}

Dragger.prototype.mouseMove = function(event) {
    if (!this.isMouseDown) {
        return;
    }
    this.element.style.left = (this.element.offsetLeft
            + (event.pageX - this.oldX)) + "px";
    this.element.style.top = (this.element.offsetTop
            + (event.pageY - this.oldY)) + "px";
    this.oldX = event.pageX;
    this.oldY = event.pageY;
}

Dragger.prototype.mouseUp = function(event) {
    this.isMouseDown = false;
    document.body.onmousemove = this.oldMoveHandler;
    document.body.onmouseup = this.oldUpHandler;
}
