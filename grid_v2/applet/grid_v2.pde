Grid grid;
Lightbulb[][] bulb;


void setup(){
	size(1200, 200);
	grid = new Grid(4,16,20, true);
	bulb = new Lightbulb[4][16];
}

void draw(){
	grid.display();
	grid.track();

	// Vertical Line
	stroke(255,0,0);
	line(mouseX, 0, mouseX, height);

}

class Grid {
	
	int rows, cols, diameter;
	int spacing_x = 0;
	int spacing_y = 0;
	int xpos, ypos;
	boolean debug = false;
	int[][] hoverzones;

	Grid(int tmpRows, int tmpCols, int tmpDiameter, boolean tmpDebug){
		rows = tmpRows;
		cols = tmpCols;
		diameter = tmpDiameter;
		debug = tmpDebug;
		spacing_x = (width - (diameter * cols)) / (cols + 1);
		spacing_y = (height - (diameter * rows)) / (rows + 1);
		hoverzones = new int[cols + 1][2];
		setHoverZones();
	}


	void display(){
		background(255);
		ypos = spacing_y + (diameter / 2);
		for (int i = 0; i<rows; i++){	
			xpos = spacing_x + (diameter / 2);
			for (int j = 0; j<cols; j++){
				bulb[i][j] = new Lightbulb(xpos, ypos, diameter, false);
				bulb[i][j].isActive(mouseX);
				bulb[i][j].display();
				xpos = xpos + diameter + spacing_x;
			}
			ypos = ypos + diameter + spacing_y;		
		}

		// Create the hover zones
		
	}

	void setHoverZones(){

		int hover_x = (spacing_x / 2);
		int old_x;
		for (int i = 0; i<cols + 1; i++){
			old_x = hover_x;
			hover_x = hover_x + spacing_x + diameter;
			hoverzones[i][0] = old_x;
			hoverzones[i][1] = hover_x;
		}
	}


	void track(){
				
	}

}



class Lightbulb {

	int x, y; //coordinatees
	float diameter;
	boolean highlighted = false;

	Lightbulb(int tmpx, int tmpy, float tmpdiameter, boolean highlighted){
		x = tmpx;
		y = tmpy;
		diameter = tmpdiameter;
	}
	
	void display(){
		stroke(0);
		if(this.highlighted == true){
			fill(255, 0, 0);
		}else{
			fill(255);	
		}
		ellipse(x, y, diameter, diameter);
	}

	void isActive(int mx){
		if(mx > (this.x - 50) && mx < (this.x + 50)){
			this.highlighted = true;
		}else{
			this.highlighted = false;	
		}
	}

}

