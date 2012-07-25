Grid grid;

// Click mouse to change between sensor type

void setup(){
	size(400, 400);
	grid = new Grid(5,5,20, true, "eq"); // type can be column, row, individual
	
}

void draw(){
	grid.display();

	// Vertical Line
	stroke(255,0,0);
	line(mouseX, 0, mouseX, height);
	line(0, mouseY, width, mouseY);	
}

void keyPressed(){
	if(keyCode == 49){
		grid.sensor_type = "individual";	
	}else if (keyCode == 50) {
		grid.sensor_type = "row";
	}else if (keyCode == 51) {
		grid.sensor_type = "eq";
	}else if (keyCode == 52) {
		grid.sensor_type = "column";
	}
}

class Grid {
	Lightbulb[][] bulb;
	int rows, cols, diameter;
	int spacing_x = 0;
	int spacing_y = 0;
	int xpos, ypos;
	boolean debug = false;
	String sensor_type;

	Grid(int tmpRows, int tmpCols, int tmpDiameter, boolean tmpDebug, String tmp_sensor_type){
		rows 			= tmpRows;
		cols 			= tmpCols;
		diameter 		= tmpDiameter;
		debug 			= tmpDebug;
		sensor_type 	= tmp_sensor_type;
		spacing_x 		= (width - (diameter * cols)) / (cols + 1);
		spacing_y 		= (height - (diameter * rows)) / (rows + 1);
		bulb 			= new Lightbulb[this.rows][this.cols];
		
	}

	void display(){
		background(255);
		ypos = spacing_y + (diameter / 2);
		for (int i = 0; i<rows; i++){	
			xpos = spacing_x + (diameter / 2);
			for (int j = 0; j<cols; j++){
				bulb[i][j] = new Lightbulb(xpos, ypos, diameter, false, this.sensor_type, this.spacing_x, this.spacing_y);
				bulb[i][j].isActive(mouseX, mouseY);
				bulb[i][j].display();
				xpos = xpos + diameter + spacing_x;
			}
			ypos = ypos + diameter + spacing_y;		
		}

		// Create the hover zones
		if(debug == true){
			setHoverZones();
		}



		// Change between type
	}


	void setHoverZones(){

		if(this.sensor_type == "column"){
			int hover_x = (spacing_x / 2);
			int old_x;
			for (int i = 0; i<this.cols + 1; i++){
				old_x = hover_x;
				hover_x = hover_x + spacing_x + diameter;
				line(old_x, 0, old_x, height);
			}			
		}else if (this.sensor_type == "individual") {
			for (int i = 0; i<this.rows; i++){
				for (int j = 0; j<this.cols; j++){
					noFill();
					int tmp_indiv_x = bulb[i][j].x - (diameter / 2) - (this.spacing_x / 2);
					int tmp_indiv_y = bulb[i][j].y - (diameter / 2) - (this.spacing_y / 2);
					rect(tmp_indiv_x, tmp_indiv_y, this.spacing_x + diameter, this.spacing_y + diameter);
				}
			}
		}else if (this.sensor_type == "row") {
			int myspace = this.spacing_y - (this.diameter / 2);
			for (int i = 0; i<this.rows + 1; i++){
				line(0, myspace, width, myspace);
				myspace = myspace + this.spacing_y + this.diameter;
				println(this.spacing_y);
			}	
		}

	}
}



class Lightbulb {

	int x, y; //coordinatees
	float diameter;
	boolean highlighted = false;
	String selection_type = "column";
	int padding_x, padding_y;


	Lightbulb(int tmpx, int tmpy, float tmpdiameter, boolean highlighted, String tmp_selection_type, int tmp_padding_x, int tmp_padding_y){
		x 				= tmpx;
		y 				= tmpy;
		selection_type 	= tmp_selection_type;
		diameter 		= tmpdiameter;
		padding_x 		= tmp_padding_x;
		padding_y 		= tmp_padding_y;
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
			if(mx > (this.x - this.padding_x) && mx < (this.x + this.padding_x)){
				this.highlighted = true;
			}else{
				this.highlighted = false;	
			}			
		}else if (this.selection_type == "individual") {

			// Determine the hover bounds
			float low_x 	= this.x - (diameter / 2) - (this.padding_x / 2);
			float high_x 	= this.x - (diameter / 2) - (this.padding_x / 2) + this.padding_x + this.diameter;
			float low_y 	= this.y - (diameter / 2) - (this.padding_y / 2);
			float high_y 	= this.y - (diameter / 2) - (this.padding_y / 2) + this.padding_y + this.diameter;

			if(mx > low_x && mx < high_x && my > low_y && my < high_y){
				this.highlighted = true;
			}else{
				this.highlighted = false;	
			}			
		}else if(this.selection_type == "row"){
			if(my > (this.y - this.padding_y) && my < (this.y + this.padding_y)){
				this.highlighted = true;
			}else{
				this.highlighted = false;	
			}			
		}else if (this.selection_type == "eq") {
			// Determine the hover bounds
			float low_x 	= this.x - (diameter / 2) - (this.padding_x / 2);
			float high_x 	= this.x - (diameter / 2) - (this.padding_x / 2) + this.padding_x + this.diameter;
			// float low_y 	= this.y - (diameter / 2) - (this.padding_y / 2);
			float high_y 	= this.y - (diameter / 2) - (this.padding_y / 2) + this.padding_y + this.diameter;

			if(mx > low_x && mx < high_x && my < high_y){
				this.highlighted = true;
			}else{
				this.highlighted = false;	
			}						
		}
	}

}

