function showVal() {
  alert(document.getElementById('counter').innerHTML);
}

function increment() {
  var current = document.getElementById('counter').innerHTML;
  document.getElementById('counter').innerHTML = Number(current) + 1;
}

function append() {
  var paragraph = document.createElement('p');
  paragraph.innerHTML = document.getElementById('counter').innerHTML;
  paragraph.style.fontSize = "30px";
  document.getElementById('main').append(paragraph);
}
