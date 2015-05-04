class Planet {

  PImage image;
  float radius = 200;
  float rotation = 0;
  float rotationSpeed = .5;
  int nodeCount = 0;

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

  void countNodes() {
    //unimplemented in default Planet
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

  Earth() {
    countNodes();
  }

  Earth(PImage image) {
    this.image = image;
    countNodes();
  }

  void draw() {
    pushMatrix();
    rotateY(radians(rotation));
    noStroke();
    radius = (nodeCount * 4) + 100;
    textureSphere(radius, radius, radius, image); 
    popMatrix();

    rotatePlanet();
  }

  void say() {
    println("I'm the Earth, the best planet ever!");
  }

  void countNodes() {
    nodeCount = nodeHandler.getEarthCount();
  }
}

class Moon extends OrbitingPlanet {

  Moon() {
    radius = 55;
    rotationSpeed = 0;
    orbitAngle = 150;
    orbitHeight = 1200;
    orbitSpeed = .02;
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
    radius = (nodeCount * 25) + 50;
    textureSphere(radius, radius, radius, image); 
    popMatrix();

    incrementOrbit();
    rotatePlanet();
  }

  void countNodes() {
    nodeCount = nodeHandler.getMoonCount();
  }
}

class Mars extends OrbitingPlanet {

  Mars() {
    radius = 107;
    rotationSpeed = 0.4;
    orbitAngle = 85;
    orbitHeight = 6000;
    orbitSpeed = .003;
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
    translate(orbitHeight, 0, 0);

    rotateY(radians(rotation));
    noStroke();
    radius = (nodeCount * 15) + 200;
    textureSphere(radius, radius, radius, image); 
    popMatrix();

    rotatePlanet();
    incrementOrbit();
  }

  void say() {
    println("I'm Mars! In about 300 years, I'll be the best planet ever!");
  }

  void countNodes() {
    nodeCount = nodeHandler.getMarsCount();
  }
}

