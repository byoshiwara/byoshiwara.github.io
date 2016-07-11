var ver='6.1.2EnStd';
var dynLoad=0;
var dynPref='sitemap';
var version = parseInt (navigator.appVersion) ;
Opera=(navigator.userAgent.indexOf('Opera')!=-1)||(navigator.appName.indexOf('Opera')!=-1)||(window.opera);
Opera7=(Opera&&document.createElement!=null&&document.addEventListener!=null);
NS4 = (document.layers) ? true : false ;
IE4 = ((document.all) && (version >= 4) && !Opera) ? true : false ;
DOM=document.documentElement&&!NS4&&!Opera;
ver4 = NS4 || IE4 || DOM || Opera;

if (NS4||Opera)
	{
	origWidth = innerWidth;
	origHeight = innerHeight;
	if(Opera)setTimeout("reDo()", 500);
	}
function reDo()
	{
	if (innerWidth != origWidth || innerHeight != origHeight){location.reload();}else {if(Opera)setTimeout("reDo()",500);}
	}
if (NS4)
	onresize = reDo;

var firstItem = 0 ;
var lastItem ;
if (NS4)
	lastItem = document.layers.length - 1 ;
if (IE4)
	lastItem = document.all.tags ("DIV").length - 1 ;

function onClicked (elm,lev,el) {}
function onExpandAll () {}
function onCollapseAll () {}

function getIndexIE (el)
	{
	ind = -1 ;
	tempColl = document.all.tags ("DIV") ;
	for (i = 0 ; i < tempColl.length ; i++)
		{
		var theItem = tempColl (i) ;
		if (theItem == el)
			{
			ind = i ;
			break ;
			}
		}
	return ind ;
	}

function getFntSize(s)
	{
	if(!IE4&&!Opera)
		{
		if (s=="xx-small")
			return "x-small";
		if (s=="x-small")
			return "small";
		if (s=="small")
			return "medium";
		if (s=="medium")
			return "large";
		if (s=="large")
			return "x-large";
		if (s=="x-large")
			return "xx-large";
		}
	return s;
	}

if (ver4)
  {
  with (document)
	{
	write ("<STYLE TYPE='text/css'>");
	write (".SXLR,.SXR {color:White; font-weight:bold; font-family:Verdana,Arial,Helvetica; font-size:"+getFntSize("10px")+"; }") ;
	write (".SXLP0,.SXP0 {color:White; font-weight:bold; font-family:Arial,Helvetica; font-size:"+getFntSize("11px")+"; text-decoration:none; }") ;
	write (".SXLC0,.SXC0 {color:White; font-weight:bold; font-family:Arial,Helvetica; font-size:"+getFntSize("11px")+"; text-decoration:none; }") ;
	write (".SXLP1,.SXP1 {color:White; font-weight:bold; font-family:Verdana,Arial,Helvetica; font-size:"+getFntSize("10px")+"; }") ;
	if(NS4&&!dynLoad)
		{
		write (".TP {position:"+(Opera?"absolute":"relative")+"}");
		leftpos = 10 ;
		toppos = 40 ;
		
		write (".below {left:"+leftpos+";position:absolute; visibility:hidden}") ;
		write (".im {vertical-align:top}") ;
		write (".SXP0 {left:"+leftpos+";position:absolute; visibility:hidden}") ;
		write (".SXR {left:"+leftpos+";position:absolute;top:"+toppos+";visibility:hidden}") ;
		write (".SXP1 {left:"+leftpos+";position:absolute; visibility:hidden}") ;
		write (".SXC0 {left:"+leftpos+";position:absolute;visibility:hidden}") ;		
		// write ("A{text-decoration:none}") ;
		// write ("A:hover{text-decoration:underline}") ;
		}
	if(DOM||Opera7)
		{
		write (".tbl {width='100%'}") ;
		write (".SXP1{display:none}");
		write (".SXC0{display:none}");
		// write ("A{text-decoration:none}") ;
		// write ("A:hover{text-decoration:underline}") ;
		}

	write("</style>");
	}
  }
