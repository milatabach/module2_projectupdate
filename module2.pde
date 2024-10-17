/*
  Serial Joystick
  Takes in X,Y,Z serial input from a joystick
*/

import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port

boolean game = false;
boolean ballInCup = false;

int canvasSize = 500;
int analogMax = 4095;

void setup()
{
  size(canvasSize, canvasSize);
  printArray(Serial.list());
  String portName = Serial.list()[6];
  println(portName);
  myPort = new Serial(this, portName, 9600);
}

/*
void whole() {
  while (game==false){
    background(0, 0, 0);
    text("Rage Cage", canvasSize/2, canvasSize/2);
  } 
  draw();
}
*/

void draw()
{
  // Reading data from the joystick   
  if (myPort.available() > 0) {  // If data is available,
    val = myPort.readStringUntil('\n');  // Read it and store it in val
  }
  val = trim(val);
  if (val != null) {
     
    // Setting up the string
    background(173, 216, 230);  // light blue 
    println(val);
    int[] xyz = int(split(val, ','));
    
    // start the game
    
    
    // Check serial input length to prevent ArrayIndexOutOfBounds errors
    if (xyz.length == 3) {
      int x = xyz[0];
      int y = xyz[1];
      int z = xyz[2];  // pressed or not - should throw the ball

      // Draw the Solo cup, centered on the screen
      drawSoloCup(canvasSize / 2, canvasSize / 2 + 50);  // Cup remains centered
    }
  }
}

void game(int x, int y, int z) {
  int cup_x = int(random(50, canvasSize-50));
  int cup_y = int(random(50, canvasSize-50));
  drawBall(x);
  drawSoloCup(cup_x, cup_y);  // Cup remains centered
}



//FIGURES:


// Draws a red Solo cup at position x, y
void drawSoloCup(float x, float y) {
  float cupWidth = 80;
  float cupHeight = 100;
  float cupBottomWidth = 65;

  // Draw the cup's body (rectangle) using the bottom width and top width for tapered effect
  fill(140, 1, 1);  // Red color
  beginShape();
  vertex(x - cupBottomWidth / 2, y);            // Bottom left
  vertex(x + cupBottomWidth / 2, y);            // Bottom right
  vertex(x + cupWidth / 2, y - cupHeight);      // Top right
  vertex(x - cupWidth / 2, y - cupHeight);      // Top left
  endShape(CLOSE);

  // Draw the cup's lip (circle)
  fill(255, 255, 255);  // white
  ellipse(x, y - cupHeight, 88, 28);  // Ellipse for the lip
  fill(255,255, 255);  // Red color
  ellipse(x, y - cupHeight, 80, 20);  // Ellipse for the lip
}


void drawBall(int x) {
      float circleX = map(x, 0, analogMax, 0, canvasSize);  // Joystick X-axis for ball
      float circleY = map(245, 0, analogMax, 0, canvasSize);  // Joystick Y-axis for ball
      int fillColor = 255;  // White color for the ball

      // Draw the ball
      fill(fillColor);
      circle(circleX, circleY, 25);
}
