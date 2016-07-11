
/*
dropdown menu based on a HTML list
 Frankenstein modification of the work of Dave Lindquist (http://www.gazingus.org)
 and Nick Rigby, Patrick Griffiths, and Dan Webb (http://www.alistapart.com)
 */
 
 /* this script is necessary for ie to display dropdown.  ie mac & nn6 win do not work.  mozilla will go fine on css alone */
 
 /* this whole thing relies on a sitemap if the dropdowns do not appear (link info provided in xml) */
 
startList = function() {
if (document.all&&document.getElementById) {
navRoot = document.getElementById("menubox");

for (i=0; i<navRoot.childNodes.length; i++) {
node = navRoot.childNodes[i];
	
	if (node.nodeName=="LI") {			
		node.onmouseover=function() {
		this.className+=" over";
		}
		node.onmouseout=function() {
		this.className=this.className.replace	(" over", "");
		}
		
		for (ii=0; ii<node.childNodes.length; ii++) {
		subnode = node.childNodes[ii];
			if (subnode.nodeName=="UL") {
					
				for (iii=0; iii<subnode.childNodes.length; iii++) {
				subsubnode = subnode.childNodes[iii];
				if (subsubnode.nodeName=="LI") {				
					subsubnode.onmouseover=function() {
					this.className+=" over";
					}
					subsubnode.onmouseout=function() {
					this.className=this.className.replace	(" over", "");
					}
				 }// if subsubnode.nodeName=="LI"
				}// for subnode.childNodes
			
	 }// if subnode.nodeName=="UL"
	}// for node.childNodes
   }// if node.nodeName=="LI"
  }// for navRoot.childNodes
 }//if getElementById
}//function
window.onload=startList;