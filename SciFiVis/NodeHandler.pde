/* TAGS:
 01 - Earth
 02 - Mars
 03 - Moon
 04 - solar system
 05 - OSS (outside solar system)
 06 - MWG (milky way galaxy) *unimplemented*
 
 10 - Fictional Location
 
 M (21)- Male
 F (20)- Female
 
 30 - Past
 31 - Contemporary
 32 - Near Future
 33 - Distant Future
 34 - N/A
 
 40 - 20th Century & Earlier
 41 - Present (21st Century)
 42 - 22nd Century & Beyond
 */

//functions have to be outside of class for javascript to "see" it.
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

void published1() {
  println("hellooo");
  nodeHandler.togglePublished(1);
}

class NodeHandler {

  ArrayList<Node> nodes = new ArrayList<Node>();
  Filter theFilter = new Filter();
  boolean[] published = new boolean[3];//0 - pre-1969; 1 - 1969-1990; 2 - post-1990
  boolean[] dateOfActionWork = new boolean[4]; //0 - Contemporary, 1 - Near Future, 2 - Distant Future, 3 - Very Distant Future
  boolean[] dateOfActionUser = new boolean[4]; //0 - 20th Century, 1 - Present, 2 - 22nd Century and Beyond, 3 - Beyond the Next Millenium
  boolean[] filter = new boolean[3]; //0 - filter by published, 1 - filter by date for work, 2 - filter by date for user

  int novelCount = 0;
  int earthCount = 0;
  int moonCount = 0;
  int marsCount = 0;
  int insideSSCount = 0;
  int outsideSSCount = 0;
  int fictionCount = 0;
  int femaleCount = 0;
  int maleCount = 0;

  int pastCount = 0;
  int contemporaryCount = 0;
  int nearFutureCount = 0;
  int distantFutureCount = 0;
  int naCount = 0;

  int userPastCount = 0;
  int userPresentCount = 0;
  int userFutureCount = 0;

  NodeHandler() {
    published[0] = true;
    published[1] = true;
    published[2] = true;
    filter[0] = true;
    filter[1] = false;
    filter[2] = false;
  }

  void drawNodes() {
    for (int i=0; i<nodes.size (); i++) {
      pushMatrix();
      if (filter[0] == true) {
        if ((published[0] && theFilter.filterPublished(nodes.get(i)) == 0) ||
          (published[1] && theFilter.filterPublished(nodes.get(i)) == 1) ||
          (published[2] && theFilter.filterPublished(nodes.get(i)) == 2)) {
          nodes.get(i).draw();
        }
      } else if (filter[1] == true) {
        if ((dateOfActionWork[0] && theFilter.filterTimeForWork(nodes.get(i)) == "C") ||
          (dateOfActionWork[1] && theFilter.filterTimeForWork(nodes.get(i)) == "NF") ||
          (dateOfActionWork[2] && theFilter.filterTimeForWork(nodes.get(i)) == "DF") ||
          (dateOfActionWork[3] && theFilter.filterTimeForWork(nodes.get(i)) == "VDF")) {
          nodes.get(i).draw();
        }
      } else if (filter[2] == true) {
        if ((dateOfActionUser[0] && theFilter.filterTimeForUser(nodes.get(i)) == "20C") ||
          (dateOfActionUser[1] && theFilter.filterTimeForUser(nodes.get(i)) == "P") ||
          (dateOfActionUser[2] && theFilter.filterTimeForUser(nodes.get(i)) == "22C") ||
          (dateOfActionUser[3] && theFilter.filterTimeForUser(nodes.get(i)) == "BNM")) {
          nodes.get(i).draw();
        }
      }
      popMatrix();
    }
  }

  void addNode(String novel, String author, int published, String dateOfAction, String locationOfAction, int[] tags) {
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
      int[] tags = new int[15];
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
      if (tagsString.indexOf("F") != -1) {
        tags[6] = 20;
      } else if (tagsString.indexOf("M") != -1) {
        tags[6] = 21;
      }
      if (tagsString.indexOf("30") != -1) {
        tags[7] = 30;
      }
      if (tagsString.indexOf("31") != -1) {
        tags[8] = 31;
      }
      if (tagsString.indexOf("32") != -1) {
        tags[9] = 32;
      }
      if (tagsString.indexOf("33") != -1) {
        tags[10] = 33;
      }
      if (tagsString.indexOf("34") != -1) {
        tags[11] = 34;
      }
      if (tagsString.indexOf("40") != -1) {
        tags[12] = 40;
      }
      if (tagsString.indexOf("41") != -1) {
        tags[13] = 41;
      }
      if (tagsString.indexOf("42") != -1) {
        tags[14] = 42;
      }

      nodes.add(new Node(novel, author, published, dateOfAction, dateOfAction, locationOfAction, tags));
      if (DEBUG) {
        println("added " + novel);
      }
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
    if (novelCountFixed == 0) {
      novelCountFixed = 1;
    }

    String[] stats = new String[17];
    stats[0] = "Novels: " + novelCount;
    stats[1] = "Earth: " + earthCount + " (" + nf((((float)earthCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[2] = "Moon: " + moonCount + " (" + nf((((float)moonCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[3] = "Mars: " + marsCount + " (" + nf((((float)marsCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[4] = "Inside Solar System: " + insideSSCount + " (" + nf((((float)insideSSCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[5] = "Outside Solar System: " + outsideSSCount + " (" + nf((((float)outsideSSCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[6] = "Fictional Location: " + fictionCount + " (" + nf((((float)fictionCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[7] = "Female Author: " + femaleCount + " (" + nf((((float)femaleCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[8] = "Male Author: " + maleCount + " (" + nf((((float)maleCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[9] = "Past Work: " + pastCount + " (" + nf((((float)pastCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[10] = "Contemporary Work: " + contemporaryCount + " (" + nf((((float)contemporaryCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[11] = "Near Future Work: " + nearFutureCount + " (" + nf((((float)nearFutureCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[12] = "Distant Future Work: " + distantFutureCount + " (" + nf((((float)distantFutureCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[13] = "N/A Work: " + naCount + " (" + nf((((float)naCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[14] = "20th Century & Before: " + userPastCount + " (" + nf((((float)userPastCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[15] = "21st Century: " + userPresentCount + " (" + nf((((float)userPresentCount / novelCountFixed) * 100), 1, 2) + "%)";
    stats[16] = "22nd Century & Beyond: " + userFutureCount + " (" + nf((((float)userFutureCount / novelCountFixed) * 100), 1, 2) + "%)";
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
    femaleCount = 0;
    maleCount = 0;
    pastCount = 0;
    contemporaryCount = 0;
    nearFutureCount = 0;
    distantFutureCount = 0;
    naCount = 0;
    userPastCount = 0;
    userPresentCount = 0;
    userFutureCount = 0;

    for (int i=0; i<nodes.size (); i++) {
      if (checkFilters(nodes.get(i))) {

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
        if (nodes.get(i).getGender()) {
          maleCount++;
        } else {
          femaleCount++;
        }
        if (nodes.get(i).isPastWork()) {
          pastCount++;
        }
        if (nodes.get(i).isContemporaryWork()) {
          contemporaryCount++;
        }
        if (nodes.get(i).isNearFutureWork()) {
          nearFutureCount++;
        }
        if (nodes.get(i).isDistantFutureWork()) {
          distantFutureCount++;
        }
        if (nodes.get(i).isNAWork()) {
          naCount++;
        }
        if (nodes.get(i).isPastUser()) {
          userPastCount++;
        }
        if (nodes.get(i).isPresentUser()) {
          userPresentCount++;
        }
        if (nodes.get(i).isFutureUser()) {
          userFutureCount++;
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
      if ((published[0] && theFilter.filterPublished(nodes.get(i)) == 0) ||
        (published[1] && theFilter.filterPublished(nodes.get(i)) == 1) ||
        (published[2] && theFilter.filterPublished(nodes.get(i)) == 2)) {
        if (nodes.get(i).isEarthNode()) {
          earthNodes[count] = nodes.get(i);
          count++;
        }
      }
    }
    return earthNodes;
  }

  Node[] getMoonNodes() {
    Node[] moonNodes = new Node[moonCount];
    int count = 0;
    for (int i=0; i<nodes.size (); i++) {
      if ((published[0] && theFilter.filterPublished(nodes.get(i)) == 0) ||
        (published[1] && theFilter.filterPublished(nodes.get(i)) == 1) ||
        (published[2] && theFilter.filterPublished(nodes.get(i)) == 2)) {
        if (nodes.get(i).isMoonNode()) {
          moonNodes[count] = nodes.get(i);
          count++;
        }
      }
    }
    return moonNodes;
  }

  Node[] getMarsNodes() {
    Node[] marsNodes = new Node[marsCount];
    int count = 0;
    for (int i=0; i<nodes.size (); i++) {
      if ((published[0] && theFilter.filterPublished(nodes.get(i)) == 0) ||
        (published[1] && theFilter.filterPublished(nodes.get(i)) == 1) ||
        (published[2] && theFilter.filterPublished(nodes.get(i)) == 2)) {
        if (nodes.get(i).isMarsNode()) {
          marsNodes[count] = nodes.get(i);
          count++;
        }
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

  void toggleFilter (int selection) {
    filter[selection] = !filter[selection];
  }
  void togglePublished(int selection) {
    published[selection] = !published[selection];
    analyzeNodes();
  }

  void toggleTimeWork(int selection) {
    dateOfActionWork[selection] = !dateOfActionWork[selection];
    analyzeNodes();
  }

  void toggleTimeUser(int selection) {
    dateOfActionUser[selection] = !dateOfActionUser[selection];
    analyzeNodes();
  }

  boolean checkFilters(Node node) {
    if ((published[0] && theFilter.filterPublished(node) == 0) ||
      (published[1] && theFilter.filterPublished(node) == 1) ||
      (published[2] && theFilter.filterPublished(node) == 2)) { 
      if ((published[0] && theFilter.filterPublished(node) == 0) ||
        (published[1] && theFilter.filterPublished(node) == 1) ||
        (published[2] && theFilter.filterPublished(node) == 2)) {
          return true;
      }
      else return false;
    }
    else return false;
  }

}
