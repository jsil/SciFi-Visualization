void loadWeb(boolean isWeb) {
  if (isWeb) {
    img=loadImage("img/world32k.jpg");
    bg=loadImage("img/starscape.jpg");
    screenWidth = 1280;
    screenHeight = 678;
    //bg.resize(800,600);
    
  } else {
    img=loadImage("world32k.jpg");
    bg=loadImage("starscape.jpg");
    screenWidth = displayWidth;
    screenHeight = displayHeight;
    bg.resize(screenWidth, screenHeight);
    nodeHandler.parseTable("pre1969.csv");
    nodeHandler.parseTable("post1969.csv");
    nodeHandler.parseTable("post1990.csv");
  }
  defaultFont = createFont("Facet", 18);
}
