"use strict";

class TableScan {

  static sumColumn(id, col) {
    // Find table element.
    var table = document.getElementById(id);
    if (table == undefined) {
      return 0;
    }

    // Search for column's name.
    var idx, firstRow = table.rows[0].cells;
    for (idx = 0; idx < firstRow.length; idx++) {
      if (firstRow[idx].innerHTML == col) {
        break;
      }
    }

    // If column's name is not found, return 0.
    if (idx == firstRow.length) {
      return 0;
    }

    // Add all values in the column.
    var sum = 0;
    for (var i = 1; i < table.rows.length; i++) {
      if (idx >= table.rows[i].cells.length) {
        continue;
      }
      var v = Number(table.rows[i].cells[idx].innerHTML);
      if (!isNaN(v)) {
        sum += v;
      }
    }
    return sum;
  } 
}
