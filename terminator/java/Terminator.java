import java.awt.*;
import java.awt.event.*;
import java.applet.*;

/**
 * "Terminate the Terminator!" is an interactive math lesson 
 * implemeted as a game, designed by Bob Martinez of Los Angeles Pierce
 * College using the program Mathcad.  
 * This is an attempt to translate the game to Java by Bruce Yoshiwara
 * of Los Angeles Pierce College. 
 */
public class Terminator extends Applet {
    Panel controls = null;   // The controls 
    MyCanvas canvas = null;  // The drawing area to display gameboard

    public void init() {
      setBackground(Color.white);
	setLayout(new BorderLayout());
	canvas = new MyCanvas();
	add("Center", canvas);
	add("East", controls = new MyControls(canvas));
	int xT=50, yT=80;  // initial coordinates are not random
    }

    public void destroy() {
        remove(controls);
        remove(canvas);
    }

    public void start() {
	controls.setEnabled(true);
    }

    public void stop() {
	controls.setEnabled(false);
    }

    public void processEvent(AWTEvent e) {
        if (e.getID() == Event.WINDOW_DESTROY) {
            System.exit(0);
        }
    }

    public static void main(String args[]) {
	Frame f = new Frame("Terminator");
	Terminator Terminate = new Terminator();

	Terminate.init();
	Terminate.start();

	f.add("Center", Terminate);
	f.setSize(600, 400);
	f.show();
    }

    public String getAppletInfo() {
        return "An interactive math text to practice with radians \nand introduce notions of polar coordinates. Can be run \neither as a standalone application by typing 'java Terminator' \nor as an applet in the AppletViewer.";
    }
}

class MyCanvas extends Canvas {
    double pointRange = 2.5;
    double pointTheta = 1;
    boolean	fire = false;
    String button = "start";
    Font	font;
    int xT=50, yT=80;
    // Bob's explosion function
    double rexp(double x) {
	return (.7*Math.exp( .7 * (Math.sin(15*x + 2)*Math.sin(15*x + 2) 
						+ Math.cos(12*x)))); 
    }

    // board units to pixels
    int convert(double x) {
	Rectangle r = getBounds();
	int lines = Math.min(r.height / 10, r.width/10);
	double units = lines / 2.;
	return (int)(x*units);
    }


    public void paint(Graphics g) {
	Rectangle r = getBounds();
	int lines = Math.min(r.height / 10, r.width/10);
	int half = lines*5;  // square field
	int radius = lines / 5; // radius of gun
	double temp, temp2, temp3;
	int x[]=new int[4], y[]=new int[4];
	double pi = 3.14159265358979;
	int xT, yT, intRange, j,k;
	boolean angleLock, backAngleLock;

	int sx = r.width - 150;
	int sy =  55;

	xT = this.xT;
	yT = this.yT;
	button = this.button;

	//compute coordinates (j,k) where gun is pointing
	temp = this.pointRange*half/5;
	intRange = (int) temp;
	temp2 = temp *Math.cos(this.pointTheta) + half;
	j = (int) temp2;
	temp2 = -temp*Math.sin(this.pointTheta) + half;
	k = (int) temp2;

	//check if input angle is close
	temp = Math.sqrt((half-xT)*(half-xT)+(half-yT)*(half-yT))+3;
	temp2 = temp *Math.cos(this.pointTheta) + half;
	temp3 = -temp*Math.sin(this.pointTheta) + half;
	angleLock = ( (Math.sqrt( (xT-temp2)*(xT-temp2) + 
				(yT-temp3)*(yT-temp3) ) < 7) );
	temp2 = -temp *Math.cos(this.pointTheta) + half;
	temp3 = temp*Math.sin(this.pointTheta) + half;
	backAngleLock = ( (Math.sqrt( (xT-temp2)*(xT-temp2) + 
				(yT-temp3)*(yT-temp3) ) < 7) );

	// draw gridlines
	g.setColor(Color.pink);
	for (int i = 1; i <= 10; i++) {
	    g.drawLine(0, i * lines, 2*half, i * lines);
	}
	for (int i = 1; i <= 10; i++) {
	    g.drawLine(i * lines, 0, i * lines, 2*half);
	}

	// draw axes
	g.setColor(Color.black);
	g.setFont(font);
	g.drawLine(0, half , 2*half, half );
	g.drawLine(half , 0, half , 2*half);

	// draw pivot disk of gun
	g.setColor(Color.blue);
      g.fillArc(half-radius, half-radius, 2*radius, 2*radius, 0, 360);
	g.setColor(Color.white);
      g.fillArc(half-radius/4,half-radius/4,radius/2,radius/2,0,360);

	// define barrel of gun
	temp = Math.cos(this.pointTheta)*2.4*radius+half;
	x[0] = (int) temp;
	x[3] = x[0];
	temp = Math.cos(this.pointTheta+pi/2)* radius+half;
	x[1] = (int) temp;
	temp = Math.cos(this.pointTheta-pi/2)* radius+half;
	x[2] = (int) temp;

	// negating y because java uses positive down
	temp = -Math.sin(this.pointTheta)*2.4*radius+half;
	y[0] = (int) temp;
	y[3] = y[0];
	temp = -Math.sin(this.pointTheta+pi/2)* radius+half;
	y[1] = (int) temp;
	temp = -Math.sin(this.pointTheta-pi/2)* radius+half;
	y[2] = (int) temp;

	g.setColor(Color.black);
	g.fillPolygon(x,y,4);

	// draw range circle
	g.setColor(Color.magenta);
//	g.setLine("dotted");
	g.drawArc(half-Math.abs(intRange),half-Math.abs(intRange),
		2*Math.abs(intRange), 2*Math.abs(intRange), 0,360);

	// react to buttons
	if (button.equals("start") ) {
		fire = false;
		angleLock = false;
		backAngleLock = false;
	} else if (button.equals("Quit") ) {
		return;
	} else if (button.equals("field") ) {
		fire = false;
	} else if (button.equals("Fire")) {
		fire = true;
	// reset:
      } else {
		fire = false;
		angleLock = false;
		backAngleLock = false;
		temp = newCoordinate()*newSign()*lines;
		xT = (int)(temp + half);
		this.xT = xT;

		if (Math.abs(temp) > lines) {   // Terminator is far from gun

		  yT = (int) (newCoordinate()*lines + half);

		} else {  // Terminator might be too close to gun

		  yT = (int) ((Math.random()*4 + 1)*lines*newSign() + half);
		}
		this.yT = yT;
	}

	// draw the explosion if on target
	g.setColor(Color.red);
	if (fire && (Math.sqrt( (xT-j)*(xT-j) + (yT-k)*(yT-k) ) < 7)) {
	  temp = 0;
	  while (temp <= 2*pi) {
	    temp2 = .05+temp;
	    g.drawLine(xT+(int)(Math.cos(temp)*convert(rexp(temp))),
			yT+(int)(Math.sin(temp)*convert(rexp(temp))), 
			xT+(int)(Math.cos(temp2)*convert(rexp(temp2))), 
			yT+(int)(Math.sin(temp2)*convert(rexp(temp2))));
	    temp = temp2;
	  } 
	} else {
	  // draw the Terminator
	  g.setColor(Color.red);
	  g.fillArc(xT-radius,yT-radius, 2*radius, 2*radius,0, 360);
	  g.setColor(Color.white);
	  g.fillArc(xT-radius/4,yT-radius/4,radius/2,radius/2,0,360);
	}

	// draw the beam
	g.setColor(Color.red);
	if (fire) {
	    g.drawLine(x[0],y[0], j,k);
	}

	//show angle lock
	g.setColor(Color.red);
	if(angleLock) {
	  MyControls.setLockOn();
	} else if(backAngleLock) {
	  MyControls.setBackLockOn();
	} else {
	  MyControls.setBlank();
	}
    }

    public void redraw(String button, double range, double theta) {
	this.button = button;
	this.pointRange = range;
	this.pointTheta = theta;
	repaint();
    }

    public double newCoordinate() {
		double temp;
		temp = Math.random()* 5;
		return temp;
    }

    public double newSign() {
		double temp2;
		if (Math.random() < 0.5) {
		  temp2 = -1;
		} else {
		  temp2 = 1;
		}
		return temp2;
    }
}


class MyControls extends Panel
                  implements ActionListener {
    TextField r;
    TextField a;
    MyCanvas canvas;
    static Label angleMessage1, angleMessage2, angleMessage3, angleMessage4, angleMessage5, angleMessage0;
    static String blank = "";
    static String infoString1 = " Enter values of";
    static String infoString2 = " range and angle ";
    static String infoString3 = " above, then click";
    static String infoString4 = " on the 'Fire' ";
    static String infoString5 = " button below";
    static String lockOn = "  Angle lock is on!";
    static String backLockOn1 = " Back angle lock";
    static String backLockOn2 = "     is on!";
    static Panel inputBoxes=new Panel(), angleMessages=new Panel();
    Panel rangePanel=new Panel(), anglePanel=new Panel();
    Label rangeLabel=new Label("Range ="); 
    Label angleLabel=new Label("Angle ="); 
    Panel buttonPanel=new Panel();

    public MyControls(MyCanvas canvas) {  // controls for game
	Button b = null;
	this.canvas = canvas;

	this.setLayout(new BorderLayout());
      setBackground(Color.blue);
	inputBoxes.setLayout(new GridLayout(2,1));  // range and angle inputs
	rangePanel.add(rangeLabel);
	rangePanel.add(r = new TextField("2.5", 4));
	inputBoxes.add(rangePanel);

	anglePanel.add(angleLabel);
	anglePanel.add(a = new TextField("1.0", 4));
	inputBoxes.add(anglePanel);

	rangeLabel.setFont(new Font("Arial", Font.PLAIN,16));
	r.setFont(new Font("Arial", Font.PLAIN,16));
	angleLabel.setFont(new Font("Arial", Font.PLAIN,16));
	a.setFont(new Font("Arial", Font.PLAIN,16));

	this.add("North", inputBoxes);

	b = new Button("Fire");  // buttons at bottom 
	b.addActionListener(this);
	buttonPanel.add(b);
	b = new Button("Reset");
	b.addActionListener(this);
	buttonPanel.add(b);
	this.add("South", buttonPanel);

	angleMessages.setLayout(new GridLayout(9,1));  // messages

	angleMessage0 = new Label(blank);
	angleMessages.add(angleMessage0);

	angleMessage1 = new Label(infoString1);
	angleMessages.add(angleMessage1);

	angleMessage2 = new Label(infoString2);
	angleMessages.add(angleMessage2);

	angleMessage3 = new Label(infoString3);
	angleMessages.add(angleMessage3);

	angleMessage4 = new Label(infoString4);
	angleMessages.add(angleMessage4);

	angleMessage5 = new Label(infoString5);
	angleMessages.add(angleMessage5);

	angleMessage0 = new Label(blank);
	angleMessages.add(angleMessage0);

	angleMessage0 = new Label(blank);
	angleMessages.add(angleMessage0);

	angleMessage0 = new Label(blank);
	angleMessages.add(angleMessage0);

	angleMessages.setFont(new Font("Arial", Font.BOLD,16));
	this.add("Center", angleMessages);
    }

    public static void setLockOn() {
      angleMessage1.setText(lockOn);
      angleMessage2.setText(blank);
      angleMessage3.setText(blank);
      angleMessage4.setText(blank);
      angleMessage5.setText(blank);
//	angleMessages.setColor(Color.red);
    }

    public static void setBackLockOn() {
      angleMessage1.setText(backLockOn1);
      angleMessage2.setText(backLockOn2);
      angleMessage3.setText(blank);
      angleMessage4.setText(blank);
      angleMessage5.setText(blank);
//	angleMessages.setColor(Color.red);
    }

    public static void setBlank() {
      angleMessage1.setText(infoString1);
      angleMessage2.setText(infoString2);
      angleMessage3.setText(infoString3);
      angleMessage4.setText(infoString4);
      angleMessage5.setText(infoString5);
//	angleMessages.setColor(Color.black);
    }

    //react to range and angle fields
    public boolean handleEvent(Event evt) {
	double range=0, angle=0;
	if (evt.target instanceof TextField) {

	  try {
		range = stringToDouble(r.getText());
		angle = stringToDouble(a.getText());
	  } catch (NumberFormatException e) {
		range = 0;
		angle = 0;
	  } finally {

	    this.canvas.redraw("field",range, angle);
	  }
	}
	return super.handleEvent(evt);
    }

  public static double stringToDouble(String str) {
    Double x;
    try {
      x = Double.valueOf(str);
    } catch (NumberFormatException e) {
      return 0.0;
    }
    return x.doubleValue();
  }

    public void actionPerformed(ActionEvent ev) {
	String button = ev.getActionCommand();

	this.canvas.redraw(button,
	              stringToDouble(r.getText()),
	              stringToDouble(a.getText().trim()));
    }
}