"use strict";

class Calendar {

  constructor(div) {
    this.rows = 6
    this.cols = 7;

    // Record div element.
    this.div = document.getElementById(div);  
    this.div.innerHTML = "";

    // Create header element in div.
    var header = document.createElement("header");
    var textMonth = document.createElement("p");
    var textYear = document.createElement("p");
    var leftButton = document.createElement("button");
    leftButton.innerHTML = "<";
    leftButton.onclick = function() {
      var currDiv = document.getElementById(div);
      var ps = currDiv.getElementsByTagName("p");
      var month = parseInt(ps[0].innerHTML) - 1;
      var year = parseInt(ps[1].innerHTML);
      if (month == 0) {
        month = 12;
        year--;
      }
      var calendar = new Calendar(div);
      calendar.render(new Date(year, month - 1)); 
    }
    var rightButton = document.createElement("button");
    rightButton.innerHTML = ">";
    rightButton.onclick = function() {
      var currDiv = document.getElementById(div);
      var ps = currDiv.getElementsByTagName("p");
      var month = parseInt(ps[0].innerHTML) + 1;
      var year = parseInt(ps[1].innerHTML);
      if (month == 13) {
        month = 1;
        year++;
      }
      var calendar = new Calendar(div);
      calendar.render(new Date(year, month - 1));
    } 
    header.appendChild(leftButton);
    header.appendChild(rightButton);
    header.appendChild(textMonth);
    header.appendChild(textYear);
    this.div.appendChild(header);

    // Create table element in div.
    var table = document.createElement("table");
    this.div.appendChild(table);

    // 1. Make 1 row for weekdays description.
    const WEEKDAYS = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    var tr = document.createElement("tr");
    WEEKDAYS.map(function(day) {
      var td = document.createElement("td");
      td.innerHTML = day;
      tr.appendChild(td);      
    });
    table.appendChild(tr);

    // 2. Make 6 rows for days.
    for (var i = 0; i < this.rows; i++) {
      var tr = document.createElement("tr");
      for (var j = 0; j < this.cols; j++) {
        var td = document.createElement("td");
        tr.appendChild(td);
      }
      table.appendChild(tr); 
    }
  }

  render(date) {
    // Record year and month.
    var year = date.getFullYear(), month = date.getMonth();

    // Record all days in an array.
    var days = [];
 
    // 1. Get the days to show in previous month.
    // Get the weekday of 1st day in the month.
    var firstWeekday = (new Date(year, month, 1)).getDay();
    // Get the number of days in previous month.
    var prevMonthDays = (new Date(year, month, 0)).getDate();
    for (var i = 0; i < firstWeekday; i++) {
      //console.log("prevMonthDays: " + prevMonthDays + " firstWeekday: " + firstWeekday);
      days.push(prevMonthDays - (firstWeekday - 1 - i));
    }

    // 2. Get the days to show in current month.
    // Get the number of days in current month.
    var currMonthDays = (new Date(year, month + 1, 0)).getDate();
    for (var i = 0; i < currMonthDays; i++) {
      days.push(i + 1);
    }

    // 3. Get the days to show in next month.
    var restDays = this.rows * this.cols - days.length;
    for (var i = 0; i < restDays; i++) {
      days.push(i + 1);
    }

    // 4. Update all td elements.
    var tds = this.div.getElementsByTagName("td");
    // Differentiate current month with previous/next month by color,
    // and skip first row's td elements for weekdays description.
    var monthCount = (firstWeekday == 0) ? 0 : -1;
    for (var i = 0; i < this.rows * this.cols; i++) {
      var td = tds[i + this.cols];
      td.innerHTML = days[i];
      switch (monthCount) {
        case 0:
          td.style.color = "black";
          break;
        case -1:
        case 1:
          td.style.color = "gray";
          break;   
      }
      if (days[i + 1] == 1) {
        monthCount++;
      }
    }

    // 5.Update month and year to show in header.
    var ps = this.div.getElementsByTagName("p");
    ps[0].innerHTML = month + 1;
    ps[1].innerHTML = year;
  }
}
