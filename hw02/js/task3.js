
// Set the onclick function of the three link texts
document.getElementById('lorem-link').onclick = function() { showText('lorem') };
document.getElementById('bottles-link').onclick = function() { showText('bottles') };
document.getElementById('third-link').onclick = function() { showText('third') };


// Toggles the display of the corresponding text on the right side
function showText(id) {
  var flag = document.getElementById(id).style.display;
  if (flag === "none" || flag === "") {
    document.getElementById(id).style.display = "inline";
  }
  else {
    document.getElementById(id).style.display = "none";
  }
}
