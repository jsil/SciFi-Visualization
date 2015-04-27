//todo: fix earth "growing" on web

class Planet {

  PImage image;
  
  float radius = 200;

  Planet() {
  }

  Planet(PImage image) {
    this.image = image;
  }

  void draw() {
    pushMatrix();
    textureSphere(radius, radius, radius, image); 
    popMatrix();
  } 

  void say() {
    println("I'm a generic planet!");
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

class Moon extends Planet {
  Moon() {
    radius = 55;
  }

  Moon(PImage image) {
    this.image = image;
    radius = 55;
  }

  void say() {
    println("I'm the Moon, I like to hang out with the best planet ever!");
  }
}

class Mars extends Planet {
  Mars() {
    radius = 107;
  }

  Mars(PImage image) {
    this.image = image;
    radius = 107;
  }

  void say() {
    println("I'm Mars! In about 300 years, I'll be the best planet ever!");
  }
}

