// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 13-10: Two-dimensional array of objects

// 2D Array of objects
Cell[][] grid; 

// Number of columns and rows in the grid
int cols 			= 5;
int rows 			= 5;
int windowwidth 	= 200;
int windowheight 	= 200;
// Calculate cell w & h
int cellheight 	= windowheight / rows;
int cellwidth 	= windowwidth / cols;

void setup() {
  size(windowwidth,windowheight);
  grid = new Cell[cols][rows];

  // The counter variables i and j are also the column and row numbers
  // In this example, they are used as arguments to the constructor for each object in the grid.
  for (int i = 0; i < cols; i ++ ) {
    for (int j = 0; j < rows; j ++ ) {
      // Initialize each object
      grid[i][j] = new Cell(i*cellwidth,j*cellheight,cellwidth,cellheight,j,i,255,i + j);
    }
  }
}

void draw() {
  background(0);
  for (int i = 0; i < cols; i ++ ) {     
    for (int j = 0; j < rows; j ++ ) {
      grid[i][j].mouseOver();
      grid[i][j].display();

      if(grid[i][j].mouseover == true){
      	Highlight(i);
      }else {
      	Unhighlight(i);
      }
    }
  }
}

void Highlight(int value){
	for (int i = 0; i<grid[value].length; i++){
		grid[value][i].bgcolor = 0;
	}
}

void Unhighlight(int value){
	var noneSelected = true;
	for (int i = 0; i<grid[value].length; i++){
		grid[value][i].bgcolor = 255;
	}		
}



// A Cell object
class Cell {
  // A cell object knows about its location in the grid as well as its size with the variables x,y,w,h.
  float x,y;   // x,y location
  float w,h;   // width and height
  int r,c, bgcolor;		// row and column
  float angle; // angle for oscillating brightness
  boolean mouseover = false;

  // Cell Constructor
  Cell(float tempX, float tempY, float tempW, float tempH, int tempR, int tempC, int tempColor, float tempAngle) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    r = tempR; //row num
    c = tempC; //coll num
    bgcolor = tempColor;
    angle = tempAngle;
  } 
  
  // Oscillation means increase angle
  void oscillate() {
    angle += 0.01; 
  }

  public void mouseOver(){
  	if(mouseX >= this.x && mouseX <= (this.x + cellwidth) && mouseY <= (this.y + cellheight) && mouseY >= this.y){	
  		mouseover = true;
  	}else{
  		mouseover = false;
  	}
  }

  void display() {
    stroke(0);
    fill(bgcolor);
    rect(x,y,w,h); 
  }

}