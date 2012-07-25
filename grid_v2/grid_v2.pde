Grid grid;

// Click mouse to change between sensor type

void setup(){
	size(1200, 200);
	grid = new Grid(4,16,20, true, "column"); // type can also be individual
	
}

void draw(){
	grid.display();
	grid.track();

	// Vertical Line
	stroke(255,0,0);
	line(mouseX, 0, mouseX, height);

}

class Grid {
	Lightbulb[][] bulb;
	int rows, cols, diameter;
	int spacing_x = 0;
	int spacing_y = 0;
	int xpos, ypos;
	boolean debug = false;
	int[][] hoverzones;
	String sensor_type;

	Grid(int tmpRows, int tmpCols, int tmpDiameter, boolean tmpDebug, String tmp_sensor_type){
		rows 			= tmpRows;
		cols 			= tmpCols;
		diameter 		= tmpDiameter;
		debug 			= tmpDebug;
		sensor_type 	= tmp_sensor_type;
		spacing_x 		= (width - (diameter * cols)) / (cols + 1);
		spacing_y 		= (height - (diameter * rows)) / (rows + 1);
		hoverzones 		= new int[cols + 1][2];
		bulb 			= new Lightbulb[this.rows][this.cols];
		
	}

	void display(){
		background(255);
		ypos = spacing_y + (diameter / 2);
		for (int i = 0; i<rows; i++){	
			xpos = spacing_x + (diameter / 2);
			for (int j = 0; j<cols; j++){
				bulb[i][j] = new Lightbulb(xpos, ypos, diameter, false, this.sensor_type);
				bulb[i][j].isActive(mouseX, mouseY);
				bulb[i][j].display();
				xpos = xpos + diameter + spacing_x;
			}
			ypos = ypos + diameter + spacing_y;		
		}

		// Create the hover zones
		if(debug == true){
			displayHoverZones();
		}

		setHoverZones();

		if(mousePressed == true){
			if(this.sensor_type == "column"){
				this.sensor_type = "individual";	
			}else if (this.sensor_type == "individual") {
				this.sensor_type = "column";
			}
			println(this.sensor_type);
		}
	}


	void setHoverZones(){

		if(this.sensor_type == "column"){
			int hover_x = (spacing_x / 2);
			int old_x;
			for (int i = 0; i<cols + 1; i++){
				old_x = hover_x;
				hover_x = hover_x + spacing_x + diameter;
				hoverzones[i][0] = old_x;
				hoverzones[i][1] = hover_x;
			}			
		}else if (this.sensor_type == "individual") {
			for (int i = 0; i<rows; i++){
				for (int j = 0; j<cols; j++){
					noFill();
					int tmp_indiv_x = bulb[i][j].x - (diameter / 2);
					int tmp_indiv_y = bulb[i][j].y - (diameter / 2);
					rect(tmp_indiv_x, tmp_indiv_y, diameter, diameter);
				}
			}
		}

	}

	void displayHoverZones(){
		if(this.sensor_type == "column"){
			for (int i = 0; i<hoverzones.length; i++){
				line(hoverzones[i][0], 0, hoverzones[i][0], height);
			}			
		}

	}

}



class Lightbulb {

	int x, y; //coordinatees
	float diameter;
	boolean highlighted = false;
	String selection_type = "column";


	Lightbulb(int tmpx, int tmpy, float tmpdiameter, boolean highlighted, String tmp_selection_type){
		x 				= tmpx;
		y 				= tmpy;
		selection_type 	= tmp_selection_type;
		diameter 		= tmpdiameter;
	}
	
	void display(){
		stroke(0);
		if(this.highlighted == true){
			fill(255, 0, 0);	
		}else{
			fill(255, 255, 255);	
		}
		ellipse(x, y, diameter, diameter);

	}

	void isActive(int mx, int my){
		if(this.selection_type == "column"){
			if(mx > (this.x - 50) && mx < (this.x + 50)){
				this.highlighted = true;
			}else{
				this.highlighted = false;	
			}			
		}else if (this.selection_type == "individual") {
			if(mx > (this.x - (this.diameter / 2)) && mx < (this.x + (this.diameter / 2)) && my > (this.y - (this.diameter / 2)) && my < (this.y + (this.diameter / 2))){
				this.highlighted = true;
			}else{
				this.highlighted = false;	
			}			
		}
	}

}

