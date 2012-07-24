int last_point_x = 0;
int last_point_y = 0;
int mycolor = 0;
boolean goingup = true;
String drawingtype = "line";

void setup(){
	size(1280, 768);
	stroke(255);
	background(0, 152, 128, 128);
}

void draw(){
	smooth();
	fill(mycolor, mycolor, mycolor, 256);
	stroke(mycolor, mycolor, mycolor, 256);
	if(drawingtype == "line"){
		line(last_point_x, last_point_y, mouseX, mouseY);
	} else if (drawingtype == "ellipse") {
		ellipse(last_point_x, last_point_y, mouseX, mouseY);
	}
	
	last_point_x = mouseX;
	last_point_y = mouseY;
	if(goingup == true){
		if(mycolor >= 255){
			mycolor = mycolor-1;
			goingup = false;	
		}else{
			mycolor = mycolor+1;	
		}
	} else {
		if(mycolor <= 0){
			goingup = true;
			mycolor = 0;
		}else{
			mycolor = mycolor - 1;
		}
	}	
}

void mousePressed(){
	if(drawingtype == "line"){
		drawingtype = "ellipse";
	} else {
		drawingtype = "line";
	}
	background(0, 152, 128, 128);
}