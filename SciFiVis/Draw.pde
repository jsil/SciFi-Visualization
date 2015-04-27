//todo: fix random flickering

void draw() {

  //todo: implement background image on web
  if(!web)
    background(bg);
  else
    background(0);

  beginCamera();

  camera(width/2, height/2, 0, 
  width/2, height/2, -2000, 
  0.0, 1.0, 0.0);


  //start drawing model
  pushMatrix();//0
  
  //translate to center of screen, and a far away perspective
  translate(width/2, height/2, -2000);

  //pan horizontal
  translate(panX, 0, zoom);

  //pan vertical 
  rotateX(radians(-20));
  translate(0,0,panY);

  drawPlanets();

  //draw nodes
  nodeHandler.drawNodes();

  //stop drawing model
  endCamera();
  popMatrix();
 
  camera();//reset camera so UI can be drawn accurately

  //draw UI
  ui.draw();
}

void drawPlanets() {
  pushMatrix();
  
  earth.draw();
  
//  translate(0, 300, 0);
  moon.draw();
  mars.draw();
  popMatrix();
}

