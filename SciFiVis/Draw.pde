void draw() {
  bg.resize(screenWidth, screenHeight);

  //todo: implement background image on web
  background(bg);
  //  background(0);

  beginCamera();

  camera(camX, camY, 0, 
  camX, height/2, -2000, 
  0.0, 1.0, 0.0);


  //translate to center
  pushMatrix();//0

  translate(width/2, height/2, -2000);

  pushMatrix();//1

  //pan
  translate(panX, 0, zoom);

  pushMatrix();

  rotateX(radians(-20));

  //draw center
  pushMatrix();//2a
  rotateY(radians(yRot));
  noStroke();

  //draw planets

  drawPlanets();



  popMatrix();//2a

  //draw ellipse
  pushMatrix();//2b
  rotateX(radians(90));
  noFill();
  stroke(255);
  ellipseMode(CENTER);
  ellipse(0, 0, 2400, 2400);
  popMatrix();//2b


  //draw nodes
  nodeHandler.drawNodes();

  popMatrix();

  endCamera();

  popMatrix();//1

  popMatrix();//0

  //  camera();//reset camera so UI can be drawn accurately

  pushMatrix();
  ui.draw();
  popMatrix();




  yRot = yRot + 0.5;
}

void drawPlanets() {
  pushMatrix();
  earth.draw();
  translate(0, 300, 0);
  moon.draw();
  translate(300, 0, 0);
  mars.draw();
  popMatrix();
}

