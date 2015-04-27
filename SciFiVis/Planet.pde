//todo: fix earth "growing" on web

class Planet {

  PImage image;

  float radius = 200;

  float rotation = 0;
  float rotationSpeed = 1;

  Planet() {
  }

  Planet(PImage image) {
    this.image = image;
  }

  void draw() {
    pushMatrix();
    rotateY(radians(rotation));
    noStroke();
    textureSphere(radius, radius, radius, image); 
    popMatrix();

    rotatePlanet();
  } 

  void say() {
    println("I'm a generic planet!");
  }

  void rotatePlanet() {
    rotation += rotationSpeed;
    if (rotation >= 360) {
      rotation = 0;
    }
  }
}

class OrbitingPlanet extends Planet {
  float orbitAngle;
  float orbitHeight;
  float orbitSpeed;

  OrbitingPlanet() {
  }

  void draw() {
    pushMatrix();
    rotateY(radians(rotation));
    noStroke();
    textureSphere(radius, radius, radius, image); 
    popMatrix();

    rotatePlanet();
    incrementOrbit();
  }

  OrbitingPlanet(PImage image) {
    this.image = image;
  }

  void incrementOrbit() {
    orbitAngle += orbitSpeed;
    if (orbitAngle >= 360) {
      orbitAngle = 0;
    }
  }
}


class Earth extends Planet {

  int nodeCount;

  //radius?

  Earth() {
  }

  Earth(PImage image) {
    this.image = image;
  }

  void say() {
    println("I'm the Earth, the best planet ever!");
  }
}

class Moon extends OrbitingPlanet {


  Moon() {
    radius = 55;
    rotationSpeed = 0;
    orbitAngle = 150;
    orbitHeight = 1200;
    orbitSpeed = .25;
  }

  Moon(PImage image) {
    this.image = image;
    radius = 55;
    rotationSpeed = 0;
    orbitAngle = 150;
    orbitHeight = 1200;
    orbitSpeed = .25;
  }

  void say() {
    println("I'm the Moon, I like to hang out with the best planet ever!");
  }

  void draw() {
    pushMatrix();


    pushMatrix();

    rotateX(radians(90));

    ellipseMode(CENTER);
    noFill();
    stroke(255);
    ellipse(0, 0, orbitHeight*2, orbitHeight*2);

    popMatrix();

    rotateY(radians(orbitAngle));
    translate(orbitHeight, 0, 0);

    rotateY(radians(60));

    noStroke();
    textureSphere(radius, radius, radius, image); 
    popMatrix();

    incrementOrbit();
    rotatePlanet();
  }

}

class Mars extends OrbitingPlanet {
  Mars() {
    radius = 107;
    rotationSpeed = 0.4;
    orbitAngle = 85;
    orbitHeight = 6000;
    orbitSpeed = .03;
  }

  Mars(PImage image) {
    this.image = image;
    radius = 107;
    rotationSpeed = 0.4;
    orbitAngle = 85;
    orbitHeight = 6000;
    orbitSpeed = .03;
  }

  void draw() {

    pushMatrix();
    translate(2500, 0, 2000);

    pushMatrix();

    rotateX(radians(90));

    ellipseMode(CENTER);
    noFill();
    stroke(255);
    ellipse(0, 0, orbitHeight*2, orbitHeight*2);

    popMatrix();
    
    rotateY(radians(orbitAngle));
    translate(orbitHeight,0,0);

    rotateY(radians(rotation));
    noStroke();
    textureSphere(radius, radius, radius, image); 
    popMatrix();

    rotatePlanet();
    incrementOrbit();
  }

  void say() {
    println("I'm Mars! In about 300 years, I'll be the best planet ever!");
  }
}

