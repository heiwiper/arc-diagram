int width = 600;
int height = 600;

int[] table;

ArrayList<Node> nodes;
ArrayList<ArrayList<Node>> history = new ArrayList<ArrayList<Node>>();
int count = 0, INDEX = 0;

String str;
float strWidth;

PImage leftArrow, rightArrow;

void settings() {
  size(width, height);
}

void setup() {
  //                  .--------------------------------------.
  //------------------| Initialization of drawing parameters |------------------
  //                  '--------------------------------------'
  colorMode(HSB, 360, 100, 100);
  rightArrow = loadImage("right_arrow.png");
  leftArrow = loadImage("left_arrow.png");
  surface.setTitle("Projet VD");

  nodes = new ArrayList<Node>();
  fileToNodes();
  
  //                  .---------------------------------------.
  //------------------| Initialize nodes table using a matrix |-----------------
  //                  '---------------------------------------'
  // int[][] nodesMatrix = {{1, 1, 1, 0, 0, 0},
  //                        {1, 1, 1, 1, 0, 0},
  //                        {1, 1, 1, 0, 1, 1},
  //                        {0, 1, 0, 1, 0, 0},
  //                        {0, 0, 1, 0, 1, 0},
  //                        {0, 0, 1, 0, 0, 1}};

  // int[] tableTemp = {0, 2, 4, 5, 3, 1};
  // table = tableTemp;
  // nodes = matrixToNodes(nodesMatrix, table);
  
  //                   .------------------------------------.
  //-------------------| Initialize nodes table Node Object |-------------------
  //                   '------------------------------------'

  // Node node0 = new Node(0, 0, 6);
  // Node node2 = new Node(2, 1, 6);
  // Node node4 = new Node(4, 2, 6);
  // Node node5 = new Node(5, 3, 6);
  // Node node3 = new Node(3, 4, 6);
  // Node node1 = new Node(1, 5, 6);
  // node0.addNeighbor(node1);
  // node0.addNeighbor(node2);

  // node1.addNeighbor(node0);
  // node1.addNeighbor(node2);
  // node1.addNeighbor(node3);

  // node2.addNeighbor(node0);
  // node2.addNeighbor(node1);
  // node2.addNeighbor(node4);
  // node2.addNeighbor(node5);

  // node3.addNeighbor(node1);

  // node4.addNeighbor(node2);

  // node5.addNeighbor(node2);

  // nodes = new ArrayList<Node>();
  // nodes.add(node0);
  // nodes.add(node2);
  // nodes.add(node4);
  // nodes.add(node5);
  // nodes.add(node3);
  // nodes.add(node1);

  addToHistory();

  print("\n");
  for (Node node : nodes){
    print("("+node.getName()+", "+node.distance+") ");
  }

  boolean finished = false;
  while (!finished){
    finished = sortNodes(nodes);
    print("\n");
    for (int i = 0; i<nodes.size(); i++){
      nodes.get(i).setIndex(i);
      print("("+nodes.get(i).getName()+", "+nodes.get(i).distance+") ");
    }
    for (Node node : nodes){
        node.updateDistance();
    }

    if (!finished) {
      // Add new nodes table to history
      addToHistory();
    }
  }
  
}
void draw(){
  background(0);

  int step = width/nodes.size();
  int x = (width - step*(nodes.size()-1))/2;

  textSize(16);
  stroke(0, 0, 100);

  for (Node node : history.get(INDEX)){
    // Draw arcs
    for (Node neighbor : node.getNeighbors()){
      noFill();
      int distance = (neighbor.getIndex() - node.getIndex()) * step;
      int centerX = distance/2; 
      arc(centerX+x, height/2,
          distance, distance,
          PI, 2*PI);
    }
    
    fill(node.getColor());

    // Draw nodes
    ellipse(x, height/2, 10, 10);

    // Draw nodes IDs
    str = "v"+node.getId();
    strWidth = textWidth(str);
    text(str, x - strWidth/2, height/2 + 30); 
    str = String.format("d = %.02f", node.getDistance());
    strWidth = textWidth(str);
    text(str, x - strWidth/2, height/2 + 60); 

    x += step;
  }

  // Draw current Table ID and right left arrows
  fill(0, 0, 100);
  textSize(32);
  str = String.format("T"+INDEX);
  strWidth = textWidth(str);
  text(str, width/2 - strWidth/2, height - 125); 

  if (INDEX != 0) {
    image(leftArrow, width/2 - strWidth - 50 - leftArrow.width, height - 150);
  }
  if (INDEX != history.size()-1) {
    image(rightArrow, width/2 + strWidth + 50, height - 150);
  }
}

boolean sortNodes(ArrayList<Node> nodes) {
    Node temp = null;
    boolean sorted = true;


    for(int i = 0; i< nodes.size(); i++)
    { 
      for(int j = 0; j< nodes.size()-1; j++)
        {
          if(nodes.get(j+1).distance < nodes.get(j).distance)
            {
              sorted = false;
              temp = nodes.get(j+1);
              nodes.set(j+1, nodes.get(j));
              nodes.set(j, temp);  
            }
        }
    }
    return sorted;
}

ArrayList<Node> matrixToNodes(int[][] nodesMatrix, int[] table) {
  ArrayList<Node> nodes = new ArrayList<Node>();
  for (int i = 0; i<table.length; i++){
    Node node = new Node(table[i], i, table.length);
    nodes.add(node);
  }

  for (Node node : nodes){
    for (int i = 0; i<table.length; i++){
      if(nodesMatrix[node.getId()][i] == 1 & node.getId() != i)
        for (Node node2 : nodes){
          if (node2.getId() == i){
            node.addNeighbor(node2);
          }
        }
    }
  }
  return nodes;
} 

void addToHistory() {
  history.add(new ArrayList<Node>());

  ArrayList<Node> last = history.get(history.size()-1);
  for (int i = 0; i<nodes.size(); i++){
    last.add(new Node(nodes.get(i)));
  }
  print("size "+ history.get(0).size());
  for (int i = 0; i<nodes.size(); i++){
    for (Node neighbor : nodes.get(i).getNeighbors()){
      last.get(i).addNeighbor(last.get(neighbor.getIndex()));
    }
  }
}

void fileToNodes() {
  String[] lines = loadStrings("nodes.txt");
  // println("there are " + lines.length + " lines");
  for (int i = 0 ; i < lines.length; i++) {
    if(!lines[i].isEmpty())
      count++;
  }
  for (int i = 0 ; i < lines.length; i++) {
    if(!lines[i].isEmpty()) {
      // println(lines[i].indexOf(':'));
      
      String nodeIdStr = lines[i].substring(0, lines[i].indexOf(':'));
      int nodeId = Integer.parseInt(nodeIdStr);
      nodes.add(new Node(nodeId, nodes.size(), count));
    }
  }
  for (int i = 0 ; i < lines.length; i++) {
    if(!lines[i].isEmpty()) {
      // String nodeIdStr = lines[i].substring(0, lines[i].indexOf(':'));
      // int nodeId = Integer.parseInt();
      int lastOcc = lines[i].indexOf(':');
      int nextOcc = lines[i].indexOf(',', lastOcc);
      while (nextOcc > lastOcc+1) {
        String neighborIdStr = lines[i].substring(lastOcc+1, nextOcc);
        int nodeId = Integer.parseInt(neighborIdStr);
        for (Node node : nodes){
          if(node.getId() == nodeId)
            nodes.get(i).addNeighbor(node);
        }

        lastOcc = nextOcc;
        nextOcc = lines[i].indexOf(',', lastOcc+1);
      }
      String neighborIdStr = lines[i].substring(lastOcc+1);
      int nodeId = Integer.parseInt(neighborIdStr);
      for (Node node : nodes){
        if(node.getId() == nodeId)
          nodes.get(i).addNeighbor(node);
      }
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if(keyCode == LEFT){
      if(INDEX > 0)
        INDEX -= 1;
    }
    if(keyCode == RIGHT) {
      if (INDEX < history.size()-1)
        INDEX += 1;
    }
  }
}
