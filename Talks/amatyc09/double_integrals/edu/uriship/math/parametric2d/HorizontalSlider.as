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

class edu.uriship.math.parametric2d.HorizontalSlider{
	
	private var nLength:Number;
	
	private var mcContainer:MovieClip;
	
	private var mcTrack:MovieClip;
	
	private var mcKnob:MovieClip;
	
	private var nKnobColor:Number;
	
	private var nKnobRightLine:Number;
	
	private var nKnobLeftLine:Number;
	
	private var nTrackOutColor:Number;
	
	private var nTrackInColor:Number;
	
	private var sStyle:String;
	
	public var isPressed:Boolean;
	
	public function HorizontalSlider(target:MovieClip,dep:Number,
									 xpos:Number,ypos:Number,
									 len:Number,style:String){
		
		this.nLength=len;
		
		this.isPressed=false;
		
		this.nKnobColor=0x666666;
		
		this.nKnobRightLine=0x000000;
	
	    this.nKnobLeftLine=0xFFFFFF;
	
	    this.nTrackOutColor=0x333333;
	
	    this.nTrackInColor=0xFFFFFF;
		
		this.sStyle=style;
		
		mcContainer=target.createEmptyMovieClip("container",dep);
		
		mcContainer._x=xpos;
		
		mcContainer._y=ypos;
		
		mcTrack=mcContainer.createEmptyMovieClip("track",1);
		
		mcKnob=mcContainer.createEmptyMovieClip("knob",2);
		
		drawSlider();
		
		activateSlider();
		
		setKnobPos(0);
		
		
	}
	
	public function getSliderLen():Number{
		
		return nLength;
		
	}
	
	
	private function drawSlider():Void {
		
		mcTrack.clear();
		mcKnob.clear();
		
		mcTrack.lineStyle(0,nTrackOutColor,100);
		
		mcTrack.moveTo(0,3);
		mcTrack.lineTo(nLength,3);
		mcTrack.moveTo(nLength,0);
		mcTrack.lineTo(0,0);
		
		mcTrack.lineStyle(0,nTrackInColor,100);
		mcTrack.moveTo(1,1);
		mcTrack.lineTo(nLength,1);
		
		mcTrack.lineStyle(0,nTrackOutColor,100);
		mcTrack.moveTo(0,3);
		mcTrack.lineTo(0,-8);
		mcTrack.moveTo(nLength/2,0);
		mcTrack.lineTo(nLength/2,-8);
		mcTrack.moveTo(nLength,4);
		mcTrack.lineTo(nLength,-8);
		mcTrack.moveTo(nLength/4,0);
		mcTrack.lineTo(nLength/4,-5);
		mcTrack.moveTo(3*nLength/4,0);
		mcTrack.lineTo(3*nLength/4,-5);
		
		if(sStyle=="triangle"){
		
		mcKnob.lineStyle(0,nKnobLeftLine,100);
		mcKnob.beginFill(nKnobColor,100);
		mcKnob.moveTo(0,1);
		mcKnob.lineTo(-8,15);
		mcKnob.lineStyle(0,nKnobRightLine,100);
		mcKnob.lineTo(8,15);
		mcKnob.lineTo(0,1);
		mcKnob.endFill();
		
		} else if(sStyle=="rectangle"){
		
		mcKnob.lineStyle(0,nKnobLeftLine,100);
		mcKnob.beginFill(nKnobColor,100);
		mcKnob.moveTo(-6,10);
		mcKnob.lineTo(-6,-10);
		mcKnob.lineTo(6,-10);
		mcKnob.lineStyle(0,nKnobRightLine,100);
		mcKnob.lineTo(6,10);
		mcKnob.lineTo(-6,10);
		mcKnob.endFill();
		
		} else {    }
		
		
		
	}
	
	
	private function activateSlider(): Void {
		
		var Ref:HorizontalSlider=this;
		
		
		mcKnob.onPress=function(){
			
			Ref.isPressed=true;
			
			this.startDrag(false,0,0,Ref.nLength,0);
			
			
		}
		
		mcKnob.onRelease=function(){
			
			Ref.isPressed=false;
			
			this.stopDrag();
			
			
		}
		
		
		mcKnob.onReleaseOutside=function(){
			
			Ref.isPressed=false;
			
			this.stopDrag();
			
			
		}
			
		
	}
	
	public function changeKnobColor(colo:Number):Void {
		
		nKnobColor=colo;
		
		drawSlider();
		
	}
	
	public function changeTrackOutColor(colo:Number):Void {
		
		nTrackOutColor=colo;
		
		drawSlider();
		
	}
	
	public function changeTrackInColor(colo:Number):Void {
		
		nTrackInColor=colo;
		
		drawSlider();
		
	}
	
	public function changeKnobRightLine(colo:Number):Void {
		
		nKnobRightLine=colo;
		
		drawSlider();
		
	}
	
	public function changeKnobLeftLine(colo:Number):Void {
		
		nKnobLeftLine=colo;
		
		drawSlider();
		
	}
	
	
	
	public function setKnobPos(a:Number):Void {
		
		mcKnob._x=a;
		
	}
	
	
	
	public function getKnobPos():Number {
		
		return mcKnob._x;
		
		
	}
	
	public function destroy():Void {
		
		delete mcKnob.onPress;
		
		delete mcKnob.onRelease;
		
		delete mcKnob.onReleaseOutside;
		
		mcContainer.removeMovieClip();
		
		
	}
	
		
}