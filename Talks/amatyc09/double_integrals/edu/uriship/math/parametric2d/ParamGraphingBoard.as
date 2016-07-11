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

class edu.uriship.math.parametric2d.ParamGraphingBoard {
	
	private var nSize:Number;
	
	private var mcContainer:MovieClip;
	
	private var mcGraphs:MovieClip;
	
	private var mcBorder:MovieClip;
	
	private var mcBack:MovieClip;
	
	private var mcArrow:MovieClip;
	
	private var mcUser:MovieClip;
	
	private var mcAxes:MovieClip;
	
	private var mcBoxHolder:MovieClip;
	
	private var mcMask:MovieClip;
	
	private var nAxesColor:Number;
	
	private var nArrowColor:Number;
	
	private var nArrowSize:Number;
	
	private var nXmin:Number;
	
	private var nXmax:Number;
	
	private var nYmin:Number;
	
	private var nYmax:Number;
	
	private var bIsRangeSet:Boolean;
	
	private var bAreCoordsOn:Boolean;
	
	private var CoordsFormat:TextFormat;
	
	private var CoordsBox:TextField;
	
	private var bIsErrorBoxOn:Boolean;
	
	private var ErrorFormat:TextFormat; 
	
	public var ErrorBox:TextField;
	
	private var bIsTraceOn:Boolean;
	
	
	public function ParamGraphingBoard(a:Number,b:Number,h:Number,target:MovieClip,depth:Number){
		
		this.nSize=h;
		
		this.nAxesColor=0x000000;
		
		this.nArrowColor=0x000000;
		
		this.nArrowSize=10;
		
		this.nXmin=null;
		
		this.nXmax=null;
		
		this.nYmin=null;
		
		this.nYmax=null;
		
		this.CoordsBox=null;
		
		this.ErrorBox=null;
				
		this.bIsRangeSet=false;
		
		mcContainer=target.createEmptyMovieClip("container",depth);
		
		mcContainer._x=a;
		
		mcContainer._y=b;
		
		mcBorder=mcContainer.createEmptyMovieClip("border",3);
		
		mcBack=mcContainer.createEmptyMovieClip("back",1);
		
		mcBoxHolder=mcContainer.createEmptyMovieClip("boxholder",5);
		
		mcUser=mcContainer.createEmptyMovieClip("user",4);
		
		mcAxes=mcBack.createEmptyMovieClip("axes",0);
			
		mcGraphs=mcBack.createEmptyMovieClip("graphs",1);
		
		mcArrow=mcBack.createEmptyMovieClip("arrow",2);
		
		mcMask=mcContainer.createEmptyMovieClip("maskgraph",2);
		
		mcBack.setMask(mcMask);
		
	    drawBack(0xFFFFFF);
		
		drawBorder(0x000000);
		
		enableErrorBox();
		
		enableCoordsDisplay();
		
		arrowVisible(false);
		
		enableTrace(true);
		
		Mouse.addListener(this);
		
	}
	
	public function enableTrace(b:Boolean):Void {
		
		bIsTraceOn=b;
	
	if(b){		
		    drawArrow();
			
	        }
		
	}
	
	
	public function arrowVisible(b:Boolean):Void {
		
		mcArrow._visible=b;
		
	}
	
	
	
	public function setArrowPos(a:Number,b:Number,c:Number):Void {
		
		mcArrow._x=a;
		
		mcArrow._y=b;
		
		mcArrow._rotation=c;
		
	}
	
	private function drawArrow():Void {
		
	    mcArrow.clear();
		mcArrow.beginFill(nArrowColor,100);
		mcArrow.moveTo(0,0);
		mcArrow.lineTo(-nArrowSize/2,nArrowSize);
		mcArrow.lineTo(nArrowSize/2,nArrowSize);
		mcArrow.lineTo(0,0);
		mcArrow.endFill();
		
		mcArrow._x=0;
		mcArrow._y=0;
		
	}
	
	
	private function onMouseMove():Void {
		
		var dispx:String="";
		
		var dispy:String="";
			
		if(bAreCoordsOn && bIsRangeSet){
					
			if(mcBack._ymouse>=0 && mcBack._ymouse<=nSize && mcBack._xmouse>=0 && mcBack._xmouse<=nSize){
		
			  dispx=String(Math.round(xtoFun(mcBack._xmouse)*100)/100);
			  
			  dispy=String(Math.round(ytoFun(mcBack._ymouse)*100)/100);
			  
			  CoordsBox._visible=true;
			  
			  CoordsBox.text="x="+dispx+"\n"+"y="+dispy;
			
			} else {CoordsBox._visible=false;}
					
			
		}
		
		
	}
	
	
	
	
	public function enableCoordsDisplay(): Void {
				
		bAreCoordsOn=true;
					
		mcBoxHolder.createTextField("txtCoordsBox",1,20,Math.max(nSize-50,0),60,40);
			
		CoordsBox=mcBoxHolder["txtCoordsBox"];	
		
		CoordsBox.type="dynamic";
		
		CoordsBox.wordWrap=true;
		
		CoordsBox.border=true;
				
		CoordsBox.background=true;
		
		setCoordsBoxFormat(0xFFFFFF,0xFFFFFF,0x000000,12);
			
		CoordsBox._visible=false;
		
				
	}
	
	public function setCoordsBoxFormat(colo1:Number,colo2:Number,colo3:Number,size:Number): Void {
		
		if(bAreCoordsOn){
		
		CoordsFormat=new TextFormat("_sans",size,colo3);
		
		CoordsBox.backgroundColor=colo1;
		
		CoordsBox.borderColor=colo2;
		
		CoordsBox.setNewTextFormat(CoordsFormat);
		
		}
		
	}
	
	public function disableCoordsDisplay(): Void {
				
		mcBoxHolder["txtCoordsBox"].removeTextField();
		
		CoordsBox=null;
		
		bAreCoordsOn=false;
		
				
	}
	
	
	public function setCoordsBoxSizeAndPos(w:Number,h:Number,x:Number,y:Number): Void {
		
		if(bAreCoordsOn){
		
		CoordsBox._width=w;
		
		CoordsBox._height=h;
		
		CoordsBox._x=x;
		
		CoordsBox._y=y;
		
		}
		
	}
	
	
	public function enableErrorBox(): Void {
		
		bIsErrorBoxOn=true;
					
		mcBoxHolder.createTextField("txtErrorBox",2,20,20,250,100);
			
		ErrorBox=mcBoxHolder["txtErrorBox"];	
			
		ErrorBox.type="dynamic";
		
		ErrorBox.wordWrap=true;
		
		ErrorBox.border=true;
				
		ErrorBox.background=true;
		
		setErrorBoxFormat(0xFFFFFF,0xFFFFFF,0x000000,12);
			
		ErrorBox._visible=false;
				
	}
	
	public function disableErrorBox(): Void {
		
		mcBoxHolder["txtErrorBox"].removeTextField();
		
		ErrorBox=null;
		
		bIsErrorBoxOn=false;
		
	}
	
	public function enableUserDraw(colo,thick): Void {
		
		var size:Number=nSize;
		
		var depth:Number=0;
		
		var mcHolder:MovieClip=null;
		
		var bIsPressed:Boolean=false;
		
		mcUser.onMouseDown=function(){
					
			if(this._ymouse>0 && this._ymouse<size && this._xmouse>0 && this._xmouse<size){
			
			bIsPressed=true;
			
			depth=this.getNextHighestDepth();
			
			mcHolder=this.createEmptyMovieClip("mcHolder"+depth,depth);
			
			mcHolder.lineStyle(thick,colo,100);
			
			mcHolder.moveTo(this._xmouse,this._ymouse);
			
			}
			
			}
			
		mcUser.onMouseMove=function(){
					
			if(bIsPressed && this._ymouse>0 && this._ymouse<size && this._xmouse>0 && this._xmouse<size){
		
			  mcHolder.lineTo(this._xmouse,this._ymouse);
		     
			  updateAfterEvent();
			
			}
			
			}
			
			
		
	    mcUser.onMouseUp=function(){
			
			if(!bIsPressed){return;}
			
			else {bIsPressed=false;}
			
			
			}
		
	}
	
	public function eraseUserDraw(): Void {
		
		for(var elem in mcUser){
			
			if(mcUser[elem] instanceof MovieClip){
			
			mcUser[elem].removeMovieClip();
			
		}	
		
		}
		
		
	}
	
	
	public function disableUserDraw(): Void {
		
		delete mcUser.onMouseDown;
		
		delete mcUser.onMouseUp;
		
		delete mcUser.onMouseMove;
			
		
				
	}
	
	
	
	
	public function changeBorderColor(colo:Number): Void {
		
		
		drawBorder(colo);
		
	}
	
	public function changeBackColor(colo:Number): Void {
		
		drawBack(colo);
		
	}
	
	public function setAxesColor(colo:Number): Void {
		
		nAxesColor=colo;
		
		
	}
	
	public function changeArrowColor(colo:Number): Void {
		
		nArrowColor=colo;
		
		drawArrow();
		
	}
	
	
	
	public function setErrorBoxFormat(colo1:Number,colo2:Number,colo3:Number,size:Number): Void {
		
		if(bIsErrorBoxOn){
		
		ErrorFormat=new TextFormat("_sans",size,colo3);
		
		ErrorBox.backgroundColor=colo1;
		
		ErrorBox.borderColor=colo2;
		
		ErrorBox.setNewTextFormat(ErrorFormat);
		
		}
		
	}
	
	
	public function setErrorBoxSizeAndPos(w:Number,h:Number,x:Number,y:Number): Void {
		
		if(bIsErrorBoxOn){
		
		ErrorBox._width=w;
		
		ErrorBox._height=h;
		
		ErrorBox._x=x;
		
		ErrorBox._y=y;
		
		}
		
	}
	
	
	public function setVarsRanges(a,b,c,d): Void {
		
		
		if(isLegal(a) && isLegal(b) && isLegal(c) && isLegal(d)){
			
			if(a<b && c<d){
		
		          nXmin=a;
		
		          nXmax=b;
		
		          nYmin=c;
		
		          nYmax=d;
		
		          bIsRangeSet=true;
		
		     }
		
		}
	
		
	}
	
	public function getVarsRanges(): Array {
		
		return [nXmin,nXmax,nYmin,nYmax];
		
	}
	
	
	private function drawBorder(colo:Number): Void {
		
		mcBorder.clear();
		mcBorder.lineStyle(1,colo,100);
		mcBorder.moveTo(0,0);
		mcBorder.lineTo(0,nSize);
		mcBorder.lineTo(nSize,nSize);
		mcBorder.lineTo(nSize,0);
		mcBorder.lineTo(0,0);
		
	}
		
		
	
	
	private function drawBack(colo:Number): Void {
		
		mcBack.clear();
		mcBack.lineStyle(1,colo,100);
		mcBack.moveTo(0,0);
		mcBack.beginFill(colo,100);
		mcBack.lineTo(0,nSize);
		mcBack.lineTo(nSize,nSize);
		mcBack.lineTo(nSize,0);
		mcBack.lineTo(0,0);
		mcBack.endFill();
		
		mcMask.clear();		
		mcMask.moveTo(0,0);		
		mcMask.beginFill(0x666666,100);
		mcMask.lineTo(0,nSize+1);
		mcMask.lineTo(nSize+1,nSize+1);
		mcMask.lineTo(nSize+1,0);
		mcMask.lineTo(0,0);
		mcMask.endFill();
		
		
	}
	
	public function xtoPix(a:Number): Number {
		
		var xconv:Number=nSize/(nXmax-nXmin);
		
		return (a-nXmin)*xconv;
		
		
		
	}
	
	public function ytoPix(a:Number): Number {
		
		var yconv:Number=nSize/(nYmax-nYmin);
		
		return nYmax*yconv-a*yconv;	
		
	}
	
	public function xtoFun(a:Number): Number {
		
		var xconv:Number=nSize/(nXmax-nXmin);
		
		return a/xconv+nXmin;
		
		
		
	}
	
	public function ytoFun(a:Number): Number {
		
		var yconv:Number=nSize/(nYmax-nYmin);
		
		return nYmax-a/yconv;	
		
	}
	
	
	public function drawAxes(): Void {
		
		var yzero:Number;
		var xzero:Number;
		
		if(bIsRangeSet){
		
		mcAxes.clear();
		mcAxes.lineStyle(1,nAxesColor,100);
		yzero=ytoPix(0);		
	    xzero=xtoPix(0);
	    mcAxes.moveTo(0, yzero);
	    mcAxes.lineTo(nSize,yzero);
	    mcAxes.moveTo(xzero,0);
	    mcAxes.lineTo(xzero,nSize);
		
		}
	           		
	}
	
	public function drawGraph(dep:Number,aVals:Array,colo:Number): Array {
		
		var i:Number;
		
		var pixVals:Array=[];
		
		var ang:Number=0;
		
		var diff:Array=[0,-1];
		
		var valLen:Number=aVals.length;
		
		var aArrowVals:Array=[];
		
		if(bIsRangeSet){
		
		for(i=0;i<valLen;i++){
			
			pixVals[i]=[xtoPix(aVals[i][0]),ytoPix(aVals[i][1])];
			
		}
			
			if(bIsTraceOn){
				
				for(i=0;i<valLen;i++){
			
			if(isDrawable(pixVals[i][0]) && isDrawable(pixVals[i][1])){
				
				if(i!=valLen-1){
				
				diff=[pixVals[i+1][0]-pixVals[i][0],pixVals[i+1][1]-pixVals[i][1]];
				
				               } else {diff=[0,0];}
							   
							   
				if(diff[0]==0 && diff[1]==0){
					
					ang+=0;
					
				} else {
				
				ang=calcAngle(diff);
				
				}
				 
			    aArrowVals[i]=pixVals[i].concat(ang);
			
		       } else {aArrowVals[i]=[nSize+nArrowSize,nSize+nArrowSize,0];}
			
		}
			
			}
		
		
		
		if(mcGraphs["graph"+dep]==undefined){
		
		mcGraphs.createEmptyMovieClip("graph"+dep,dep);
		
		} else { mcGraphs["graph"+dep].clear(); }
		
		
		mcGraphs["graph"+dep].lineStyle(1,colo,100);
		
		for(i=0;i<aVals.length-1;i++){
			
			if(isDrawable(pixVals[i][1]) && isDrawable(pixVals[i+1][1])
				&& isDrawable(pixVals[i][0]) && isDrawable(pixVals[i+1][0])){
		
		mcGraphs["graph"+dep].moveTo(pixVals[i][0],pixVals[i][1]);
		
	    mcGraphs["graph"+dep].lineTo(pixVals[i+1][0],pixVals[i+1][1]);
		
		   }
		
		}
		
		}
		
		return aArrowVals;
	}
	
	private function calcAngle(v:Array):Number {
		
		var v1=v[0];
		
		var v2=v[1];
		
		var val:Number=null;
		
		var vlen:Number=Math.sqrt(Math.pow(v1,2)+Math.pow(v2,2));
		
		if(vlen==0){
			
			return val;
			
		} else if (v1>=0){
					
			val=Math.acos(-v2/vlen)*180/Math.PI;
			
			return val;
						
		} else if(v1<0){
			
			val=-Math.acos(-v2/vlen)*180/Math.PI;
			
			return val;
			
		} else {return val;}
				
	}
	
	public function eraseGraphs(){
		
		
		for(var elem in mcGraphs){
			
			if(mcGraphs[elem] instanceof MovieClip){
			
			mcGraphs[elem].clear();
			
		}	
		
		}
		
		
		mcAxes.clear();
				
		nXmin=null;
		
		nXmax=null;
		
		nYmin=null;
		
		nYmax=null;
				
		bIsRangeSet=false;
		
		ErrorBox._visible=false;
			
		CoordsBox._visible=false;
		
	}
	
	
	public function isLegal(a):Boolean {
		
		
		if(typeof(a)!="number" || isNaN(a) || !isFinite(a)){
			
			return false; } 
			
		return true;
		
	}
	
	
	
	public function isDrawable(a):Boolean {
		
		
		if(typeof(a)!="number" || isNaN(a) || !isFinite(a)){
			
			return false; } 
			
			
		if(Math.abs(a)>=5000){
			
			return false;
		}
		
		
		return true;
		
	}
	
	
	public function destroy():Void {
		
		Mouse.removeListener(this);
		
		disableUserDraw();
		
		disableCoordsDisplay();
		
		disableErrorBox();
		
		mcContainer.removeMovieClip();
		
		
	}
		
	
}

