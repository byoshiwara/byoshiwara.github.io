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

Last modified: February 15, 2006

************************************************************************ */

import edu.uriship.math.parametric2d.*;

class edu.uriship.math.parametric2d.RangeParserTwo {
	
		
	public function RangeParserTwo(){
		
		
		
	}
	
	
	public function parseRange(a:String,b:String):RangeObject {
		
		var strArray:Array;
		
		var i:Number;
		
		var roRange:RangeObject=new RangeObject();
		
		var mpParser:MathParser=new MathParser([]);
		
		var compOb:CompiledObject;
		
		strArray=[a,b];
		
		for(i=0;i<2;i++){
			
			if(strArray[i]==undefined){
				
			roRange.errorStatus=1;
			roRange.errorMes="Check your variables ranges.";
			roRange.Values=[];
			return roRange;
								
			}
			
		}
		
		
		for(i=0;i<2;i++){
			
			strArray[i]=strArray[i].toLowerCase();
			
			if(strArray[i].indexOf("pi")==-1){
				
				strArray[i]=Number(strArray[i]);
						
		if(isNotLegal(strArray[i])){
			
			roRange.errorStatus=1;
			roRange.errorMes="Check your variables ranges.";
			roRange.Values=[];
			return roRange;
						
		} else {
			
			roRange.Values[i]=strArray[i];
						
		}
			
			} else {
				
			 compOb=mpParser.doCompile(strArray[i]);
			 
			 if(compOb.errorStatus==1){
				 
		    roRange.errorStatus=1;
			roRange.errorMes="Check your variables ranges.";
			roRange.Values=[];
			return roRange;
				 
				 
			 } else {
				 				 
				roRange.Values[i]=mpParser.doEval(compOb.PolishArray,[]);
				
				if(isNotLegal(roRange.Values[i])){
											 
					roRange.errorStatus=1;
			        roRange.errorMes="Check your variables ranges.";
			        roRange.Values=[];
			        return roRange;
											 											 
											 }
				 
			 }
							
				
			}
			
		}
		
		
		if(roRange.Values[0]>=roRange.Values[1]){
			
			roRange.errorStatus=1;
			roRange.errorMes="Check your variables ranges.";
			roRange.Values=[];
			return roRange;
			
			
		} else {
			
			roRange.errorStatus=0;
			roRange.errorMes="";
			return roRange;
			
		}
		
		
	}
	
	
	
	
	private function isNotLegal(n:Number):Boolean {
		
		if(typeof(n)!="number" || isNaN(n) || !isFinite(n)){
			
			return true; } 
			
			else {return false;}
		
	}
	
	
	
}