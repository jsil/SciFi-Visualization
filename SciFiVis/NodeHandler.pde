/* TAGS:
 01 - Earth
 02 - Mars
 03 - Moon
 04 - solar system
 05 - OSS (outside solar system)
 06 - MWG (milky way galaxy)
 
 10 - Fictional Location
 11 - Non-Fiction
 
 
 
 */


//functions have to be outside of class for javascript to "see" it. todo: fix
void addNode(String novel, String author, int published, String dateOfAction, String locationOfAction, int[] tags) {
  nodeHandler.addNode(novel, author, published, dateOfAction, locationOfAction, tags);
}

String[] searchNodes(String search) {
  return nodeHandler.searchNodes(search);
}

void analyzeNodes() {
  nodeHandler.analyzeNodes();
}

Node[] getEarthNodes() {
  return nodeHandler.getEarthNodes();
}

Node[] getMoonNodes() {
  return nodeHandler.getMoonNodes();
}

Node[] getMarsNodes() {
  return nodeHandler.getMarsNodes();
}

class NodeHandler {

  ArrayList<Node> nodes = new ArrayList<Node>();

  int novelCount = 0;
  int earthCount = 0;
  int moonCount = 0;
  int marsCount = 0;
  int insideSSCount = 0;
  int outsideSSCount = 0;

  int fictionCount = 0;

  Filter theFilter = new Filter();

  boolean[] published = new boolean[3];//0 - pre-1969; 1 - 1969-1990; 2 - post-1990


  NodeHandler() {
    published[0] = true;
    published[1] = true;
    published[2] = true;
  }

  void drawNodes() {
    for (int i=0; i<nodes.size (); i++) {
      pushMatrix();
      if ((published[0] && theFilter.filterPublished(nodes.get(i)) == 0) ||
        (published[1] && theFilter.filterPublished(nodes.get(i)) == 1) ||
        (published[2] && theFilter.filterPublished(nodes.get(i)) == 2)) {
        nodes.get(i).draw();
      }
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

    //dont keep this:
    //    analyzeNodes();
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
      int[] tags = new int[6];
      if (tagsString.indexOf("01") != -1) {
        tags[0] = 1;
      }
      if (tagsString.indexOf("02") != -1) {
        tags[1] = 2;
      } 
      if (tagsString.indexOf("03") != -1) {
        tags[2] = 3;
      } 
      if (tagsString.indexOf("04") != -1) {
        tags[3] = 4;
      } 
      if (tagsString.indexOf("05") != -1) {
        tags[4] = 5;
      } 
      if (tagsString.indexOf("10") != -1) {
        tags[5] = 10;
      } 

      //to do: incorperate dateOfAction work/user
      nodes.add(new Node(novel, author, published, dateOfAction, dateOfAction, locationOfAction, tags));
      //println("added " + novel);
      novelCount++;
    }

    analyzeNodes();
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

  String[] getStatistics() {
    float novelCountFixed = novelCount;
    if(novelCountFixed == 0) {
       novelCountFixed = 1; 
    }
    
    String[] stats = new String[7];
    stats[0] = "Novels: " + novelCount;
    stats[1] = "Earth: " + earthCount + " (" + nf((((float)earthCount / novelCountFixed) * 100), 0, 2) + "%)";
    stats[2] = "Moon: " + moonCount + " (" + nf((((float)moonCount / novelCountFixed) * 100), 0, 2) + "%)";
    stats[3] = "Mars: " + marsCount + " (" + nf((((float)marsCount / novelCountFixed) * 100), 0, 2) + "%)";
    stats[4] = "Inside Solar System: " + insideSSCount + " (" + nf((((float)insideSSCount / novelCountFixed) * 100), 0, 2) + "%)";
    stats[5] = "Outside Solar System: " + outsideSSCount + " (" + nf((((float)outsideSSCount / novelCountFixed) * 100), 0, 2) + "%)";
    stats[6] = "Occurs in Fictional Location: " + fictionCount + " (" + nf((((float)fictionCount / novelCountFixed) * 100), 0, 2) + "%)";
    return stats;
  }

  void analyzeNodes() {
    novelCount = 0;
    earthCount = 0;
    moonCount = 0;
    marsCount = 0;
    insideSSCount = 0;
    outsideSSCount = 0;
    fictionCount = 0;
    for (int i=0; i<nodes.size (); i++) {
      if ((published[0] && theFilter.filterPublished(nodes.get(i)) == 0) ||
        (published[1] && theFilter.filterPublished(nodes.get(i)) == 1) ||
        (published[2] && theFilter.filterPublished(nodes.get(i)) == 2)) {

        if (nodes.get(i).isEarthNode()) {
          earthCount++;
        }  
        if (nodes.get(i).isMoonNode()) {
          moonCount++;
        }  
        if (nodes.get(i).isMarsNode()) {
          marsCount++;
        }  
        if (nodes.get(i).isInsideSS()) {
          insideSSCount++;
        }  
        if (nodes.get(i).isOutsideSS()) {
          outsideSSCount++;
        }  
        if (nodes.get(i).isFictionalLocation()) {
          fictionCount++;
        }
        novelCount++;
      }
    }
  }

  //  Node[] getAllNodes() {
  //     return nodes;
  //  }

  Node[] getEarthNodes() {
    Node[] earthNodes = new Node[earthCount];
    int count = 0;
    for (int i=0; i<nodes.size (); i++) {
      if (nodes.get(i).isEarthNode()) {
        earthNodes[count] = nodes.get(i);
        count++;
      }
    }
    return earthNodes;
  }

  Node[] getMoonNodes() {
    Node[] moonNodes = new Node[moonCount];
    int count = 0;
    for (int i=0; i<nodes.size (); i++) {
      if (nodes.get(i).isMoonNode()) {
        moonNodes[count] = nodes.get(i);
        count++;
      }
    }
    return moonNodes;
  }

  Node[] getMarsNodes() {
    Node[] marsNodes = new Node[marsCount];
    int count = 0;
    for (int i=0; i<nodes.size (); i++) {
      if (nodes.get(i).isMarsNode()) {
        marsNodes[count] = nodes.get(i);
        count++;
      }
    }
    return marsNodes;
  }
  //
  //  Node[] getInsideSSNodes() {
  //  }
  //
  //  Node[] getOutsideSSNodes() {
  //  }
  //
  //  Node[] getFictionalNodes() {
  //  }

  int getEarthCount() {
    return earthCount;
  }

  int getMoonCount() {
    return moonCount;
  }

  int getMarsCount() {
    return marsCount;
  }

  void togglePublished(int selection) {
    published[selection] = !published[selection];
    analyzeNodes();
  }
}

