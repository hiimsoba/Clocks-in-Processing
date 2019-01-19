import processing.sound.*;

// declare a clock
Clock clock0;
Clock clock1;

PImage clockbg;
SoundFile sfx;

void setup() {
  // create the window
  //size(800, 600, P2D);
  fullScreen(P2D);
  // for smooth edges
  smooth(12345);

  frameRate(10);

  clockbg = loadImage("bg.jpg");
  sfx = new SoundFile(this, "sfx.mp3");

  sfx.amp(1);

  // initialize the clock
  clock0 = new Clock(new PVector(width / 4, height / 2), Math.min(width * 0.9 * 0.5, height * 0.9));
  clock1 = new Clock(new PVector(3 * width / 4, height / 2), Math.min(width * 0.9 * 0.5, height * 0.9));
}

void draw() {
  // clean the background
  background(0);
  clock0.display0();
  clock1.display1();
}
