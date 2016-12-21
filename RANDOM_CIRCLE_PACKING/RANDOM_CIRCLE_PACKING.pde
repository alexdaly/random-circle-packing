ArrayList <PVector> circles = new ArrayList <PVector> ();
float diameter = 100;
 
void setup() {
  size(1280, 720);
  colorMode(HSB, 360, 100, 100);
  noStroke();
  smooth();
}
 
void draw() {
  background(0);
  addCircle();
  for (int i=0; i<circles.size(); i++) {
    PVector p = circles.get(i);
    fill(i % 360, 100, 100);
    ellipse(p.x, p.y, p.z, p.z);
  }
  if (diameter < 0.1) {
    println("Done!");
    noLoop();
  }
}
 
void mousePressed() {
  removeCircle();
}
 
void mouseDragged() {
  removeCircle();
}
 
void addCircle() {
  PVector c = randomVector();
  int tries = 10000;
  while (overlap(c) && tries > 0) {
    c = randomVector();
    tries--;
  }
  if (!overlap(c)) {
    circles.add(c);
  } else {
    diameter *= 0.9;
    addCircle();
  }
}
 
void removeCircle() {
  for (int i=circles.size()-1; i>=0; i--) {
    PVector p = circles.get(i);
    if (dist(mouseX, mouseY, p.x, p.y) < p.z*0.5) {
      circles.remove(i);
    }
  }
}
 
PVector randomVector() {
  return new PVector(random(width), random(height), diameter);
}
 
boolean overlap(PVector c) {
  for (PVector p : circles) {
    if (dist(c.x, c.y, p.x, p.y) < (c.z + p.z)*0.5) {
      return true;
    }
  }
  return false;
}