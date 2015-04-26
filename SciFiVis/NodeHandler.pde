/* TAGS:
1 - Earth
2 - Mars
3 - Moon
4 - solar system
5 - OSS (outside solar system)
6 - MWG (milky way galaxy)


*/


//functions have to be outside of class for javascript to "see" it. todo: fix
void addNode(String novel, String author, int published, String dateOfAction, String locationOfAction, int[] tags) {
  nodeHandler.addNode(novel,author,published,dateOfAction,locationOfAction,tags);
}

String[] searchNodes(String search) {
  return nodeHandler.searchNodes(search); 
}

class NodeHandler {

  ArrayList<Node> nodes = new ArrayList<Node>();

  int earthCount = 0;
  int novelCount = 0;

  NodeHandler() {
  }

  void drawNodes() {
    for (int i=0; i<nodes.size (); i++) {
      pushMatrix();
      nodes.get(i).draw(); 
      popMatrix();
    }
  }

  void addNode(String novel, String author, int published, String dateOfAction, String locationOfAction, int[] tags) {
    //to do: incorperate dateOfAction work/user
    nodes.add(new Node(novel, author, published, dateOfAction, dateOfAction, locationOfAction, tags));
    if (DEBUG) {
      println("N: " + novel + " A: " + author + " P: " + published + " L: " + locationOfAction);
    }
    novelCount++;
  }

  void parseTable(String tableName) {
    Table table = loadTable(tableName, "header");

    for (TableRow row : table.rows ()) {
      String novel = row.getString(0);
      String author  = row.getString(1);
      int published = row.getInt(2);
      String dateOfAction = row.getString(3);
      String locationOfAction = row.getString(4);

      String tagsString = row.getString(5);
      int[] tags = new int[1];
      if (tagsString.indexOf("1") != -1) {
        tags[0] = 1;
      }  

      //to do: incorperate dateOfAction work/user
      nodes.add(new Node(novel, author, published, dateOfAction, dateOfAction, locationOfAction, tags));
      //println("added " + novel);
      novelCount++;
    }

    countEarthNodes();
  }

  String[] searchNodes(String search) {
    ArrayList<String> returnedStrings = new ArrayList<String>();
    for (int i=0; i<nodes.size (); i++) {
      if (nodes.get(i).contains(search)) {
        returnedStrings.add(nodes.get(i).getNovel());
      }
    }
    String[] convertedStrings = new String[returnedStrings.size()];
    for (int i=0; i<returnedStrings.size (); i++) {
      convertedStrings[i] = returnedStrings.get(i);
    }

    return convertedStrings;
  }

  float analyzeNodes() {
    //  to do:
    return 0;
  }

  int countEarthNodes() {
    int count = 0;
    for (int i=0; i<nodes.size (); i++) {
      if (nodes.get(i).isEarthNode()) {
        count++;
      }
    }
    println(count);
    earthCount = count;
    return count;
  }
}

