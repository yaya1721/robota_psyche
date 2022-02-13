// A Mover and an Attractor
Mover m;
Attractor a;
Ball b;
Boolean show_ball = false;

void setup() {
  size(1280,720);
  m = new Mover();
  a = new Attractor();
  b = new Ball();
}

void draw() {
  background(255);

  // Apply the attraction force from the Attractor on the Mover.
  PVector force = a.attract(m);
  
  force = force.mult(1.5);
  m.applyForce(force);
  
  a.update();
  m.update();
  b.update();
 
  a.display();
  m.display();
  if(show_ball == true){
    b.display();
    force = b.attract(m);
    force = force.mult(1.8);
  }
}

class Attractor {
  float mass;
  PVector location;
  float G;

  Attractor() {
    location = new PVector(width/2,height/2);
    mass = 20;
    G = 0.4;
  }
  Attractor(float x, float y, int m) {
    location = new PVector(x,y);
    mass = m;
    G = 0.4;
  }

  PVector attract(Mover m) {
    PVector force = PVector.sub(location,m.location);
    float distance = force.mag();
    // Remember, we need to constrain the distance
    // so that our circle doesn’t spin out of control.
    distance = constrain(distance,5.0,25.0);


    force.normalize();
    float strength = (G * mass * m.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }
  void update(){
    location.x = mouseX;
    location.y = mouseY;
  }
  void display() {
    stroke(0);
    fill(175,200);
    ellipse(location.x,location.y,mass*2,mass*2);
    
  }
}


// Mover class copied from section 2.1:
// with some modifications in checkEdges
class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  // The object now has mass!
  float mass;

  Mover() {
    // And for now, we’ll just set the mass equal to 1 for simplicity.
    mass = 1.5;
    location = new PVector(random(30),random(30));
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }

  // Newton’s second law.
  void applyForce(PVector force) {
    //[full] Receive a force, divide by mass, and add to acceleration.
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
    //[end]
  }

  void update() {
    //[full] Motion 101 from Chapter 1
    velocity.add(acceleration);
    location.add(velocity);
    //[end]
    // Now add clearing the acceleration each time!
    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    fill(175);
    //[offset-down] Scaling the size according to mass.
    checkEdges();
    ellipse(location.x,location.y,mass*16,mass*16);
  }

  // With this code an object bounces when it hits the edges of a window.
  // Alternatively objects could vanish or reappear on the other side
  // or reappear at a random location or other ideas

  void checkEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1;
    }

    if (location.y > height) {
      location.y = height;
      velocity.y *= -1;
    } else if (location.y < 0) {
      location.y = 0;
      velocity.y *= -1;
    }
  }
}

class Ball{
  PVector location;
  PVector velocity;
  PVector acceleration;
  // The object now has mass!
  float mass;
  float G = 0.8;

  Ball() {
    // And for now, we’ll just set the mass equal to 1 for simplicity.
    mass = 1;
    location = new PVector(width/2,height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }

  // Newton’s second law.
  void applyForce(PVector force) {
    //[full] Receive a force, divide by mass, and add to acceleration.
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
    //[end]
  }
  
  PVector attract(Mover m) {
    PVector force = PVector.sub(location,m.location);
    float distance = force.mag();
    // Remember, we need to constrain the distance
    // so that our circle doesn’t spin out of control.
    distance = constrain(distance,5.0,25.0);

    force.normalize();
    float strength = (G * mass * m.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }

  void update() {
    //[full] Motion 101 from Chapter 1
    velocity.add(acceleration);
    location.add(velocity);
    //[end]
    // Now add clearing the acceleration each time!
    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    fill(175);
    //[offset-down] Scaling the size according to mass.
    checkEdges();
    ellipse(location.x,location.y,mass*16,mass*16);
  }

  // With this code an object bounces when it hits the edges of a window.
  // Alternatively objects could vanish or reappear on the other side
  // or reappear at a random location or other ideas

  void checkEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1;
    }

    if (location.y > height) {
      location.y = height;
      velocity.y *= -1;
    } else if (location.y < 0) {
      location.y = 0;
      velocity.y *= -1;
    }
  }
  
}

void mouseClicked(){
  if(show_ball == false){
    show_ball = true;
  }
}
