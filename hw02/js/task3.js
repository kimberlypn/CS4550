// Set the onclick function of the three link texts
document.getElementById('lorem-link').onclick = function() { showText('lorem') };
document.getElementById('bottles-link').onclick = function() { showText('bottles') };
document.getElementById('third-link').onclick = function() { showText('third') };

// Replaces the text in the right column with the text corresponding to the id
function showText(id) {
  var texts = ['lorem', 'bottles', 'third'];
  document.getElementById(id).style.display = "inline";
  for (var i = 0; i < texts.length; i++) {
    if (texts[i] != id) {
      document.getElementById(texts[i]).style.display = "none";
    }
  }
}
