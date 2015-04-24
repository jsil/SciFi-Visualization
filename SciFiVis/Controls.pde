
// Use arrow keys to change detail settings
void keyPressed() {
  //  if (keyCode == ENTER) saveFrame();
  //  if (keyCode == UP) ptsH++;
  //  if (keyCode == DOWN) ptsH--;
  //  if (keyCode == LEFT) ptsW--;
  //  if (keyCode == RIGHT) ptsW++;
  //  if (ptsW == 0) ptsW = 1;
  //  if (ptsH == 0) ptsH = 2;
  //  // Parameters below are the number of vertices around the width and height
  //  initializeSphere(ptsW, ptsH);
//  if (keyCode == RIGHT) {
//    camX = camX + 35;
//  } else if (keyCode == LEFT) {
//    camX = camX - 35;
//  }
if (keyCode == RIGHT) {
    panX = panX + 5;
  } else if (keyCode == LEFT) {
    panX = panX - 5;
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  zoom += 3.5*e;
  if(zoom > 1500)
    zoom = 1500;
  else if(zoom < -2500)
    zoom = -2500;
  println("zoom: " + zoom);
}

void mousePressed() {
  dragY = mouseY;
  dragX = mouseY;
}

void mouseDragged() {
//  camY = (mouseY - dragY) * 5;
//  camX = -1-((mouseX - dragX));
  panY = panY + (mouseY - dragY);
  panX = panX + (mouseX - dragX);
}

