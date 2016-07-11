function jump2form() {
	document.search_form.q.select();
	document.search_form.q.focus();
}

function isblank(s) {
	for(var i = 0; i < s.length; i++) {
		var c = s.charAt(i);
		if ((c != ' ') && (c != '\n') && (c != '\t')) {
			return false;
		}
	}
	return true;
}
