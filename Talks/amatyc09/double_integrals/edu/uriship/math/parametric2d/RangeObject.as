/* ***********************************************************************
The templates and the materials presented in this article
as well as the underlying classes in the package
edu.uriship.math.parametric2d were created by

Barbara Kaskosz of the University of Rhode Island
(bkaskosz@math.uri.edu) and
Douglas E. Ensley of Shippensburg University
(deensl@ship.edu).

The materials are a part of the ongoing series 
"Flash Tools for Developers" by the authors.

This work is supported in part by the National Science Foundation
under the grant DUE-0535327.

Feel free to use and modify the templates and the classes to create
your own Flash applications for educational purposes under the
following two conditions:

1) Please include a line acknowledging this work and the authors
with your application. 

2) If you choose to modify the classes in the package 
edu.uriship.math.parametric2d, put them into a package different from
the original. In this case too, please acknowledge this work.

Last modified: February 5, 2006

************************************************************************ */

class edu.uriship.math.parametric2d.RangeObject {
	
	public var Values:Array;
	
	public var errorMes:String;
	
	public var errorStatus:Number;
	
	
	public function RangeObject(){
		
		this.Values=[];
		
		this.errorMes="";
		
		this.errorStatus=0;
			
	}
		
}