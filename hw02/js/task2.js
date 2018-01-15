// Makes an "alert" popup with the current value of the counter
function showVal() {
  alert(document.getElementById('counter').innerHTML);
}

// Increments the current counter value by 1
function increment() {
  var current = document.getElementById('counter').innerHTML;
  document.getElementById('counter').innerHTML = Number(current) + 1;
}

// Appends a new paragraph containing the number to the bottom of the page
function append() {
  var paragraph = document.createElement('p');
  paragraph.innerHTML = document.getElementById('counter').innerHTML;
  paragraph.style.fontSize = "30px";
  document.getElementById('main').append(paragraph);
}
