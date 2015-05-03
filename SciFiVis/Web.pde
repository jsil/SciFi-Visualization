//This is so processing can 'see' javascript. idk if we need it
interface JavaScript {
  //list functions here
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;

void loadWeb(boolean isWeb) {
  if (isWeb) {
    earthImg=loadImage("img/world32k.jpg");
    moonImg=loadImage("img/moon.jpg");
    marsImg=loadImage("img/marsmap2k.jpg");
    bg=loadImage("img/starscape.jpg");
    screenWidth = 1280;
    screenHeight = 800;
    //bg.resize(800,600);
  } else {
    frame.setTitle("Visualizing Our Imaginative Universe - Haley Hiers, Kali Rupert, & Jordan Silver");
    earthImg=loadImage("world32k.jpg");
    moonImg=loadImage("moon.jpg");
    marsImg=loadImage("marsmap2k.jpg");
    bg=loadImage("starscape.jpg");
    screenWidth = displayWidth;
    screenHeight = displayHeight;
    bg.resize(screenWidth, screenHeight);
    nodeHandler.parseTable("pre1969.csv");
    nodeHandler.parseTable("post1969.csv");
    nodeHandler.parseTable("post1990.csv");
  }
}

