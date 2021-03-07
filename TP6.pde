int width = 600;
int height = 400;

void settings() {
  size(width, height);
}

void setup() {
  // int distances[] = new int[10];
  // int nodes[][] = new int[6][6];
  int[][] nodesMatrix = {{1, 1, 1, 0, 0, 0},
                         {1, 1, 1, 1, 0, 0},
                         {1, 1, 1, 0, 1, 1},
                         {0, 1, 0, 1, 0, 0},
                         {0, 0, 1, 0, 1, 0},
                         {0, 0, 1, 0, 0, 1}};

  Node node0 = new Node("V0", 0);
  Node node2 = new Node("V2", 1);
  Node node4 = new Node("V4", 2);
  Node node5 = new Node("V5", 3);
  Node node3 = new Node("V3", 4);
  Node node1 = new Node("V1", 5);
  node0.addNeighbor(node1);
  node0.addNeighbor(node2);
  node0.printNeighbors();

  node1.addNeighbor(node0);
  node1.addNeighbor(node2);
  node1.addNeighbor(node3);
  node1.printNeighbors();

  node2.addNeighbor(node0);
  node2.addNeighbor(node1);
  node2.addNeighbor(node4);
  node2.addNeighbor(node5);
  node2.printNeighbors();

  node3.addNeighbor(node1);
  node3.printNeighbors();

  node4.addNeighbor(node2);
  node4.printNeighbors();

  node5.addNeighbor(node2);
  node5.printNeighbors();

  ArrayList<Node> nodes = new ArrayList<Node>();
  nodes.add(node0);
  nodes.add(node2);
  nodes.add(node4);
  nodes.add(node5);
  nodes.add(node3);
  nodes.add(node1);


  print("\n");
  for (Node node : nodes){
    print("("+node.name+", "+node.distance+") ");
  }

  boolean finished = false;
  while (!finished){
    finished = sortNodes(nodes);
    print("\n");
    for (int i = 0; i<nodes.size(); i++){
      nodes.get(i).setIndex(i);
      print("("+nodes.get(i).name+", "+nodes.get(i).distance+") ");
    }
    for (Node node : nodes){
        node.updateDistance();
    }
  }

}

void draw(){
  
}

boolean sortNodes(ArrayList<Node> nodes) {
    // double minval = distances[0];
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

// ArrayList<Node> matrixToNodes(int[][] nodesMatrix) {
  
//   for (Node node : nodesMatrix){
    
//   }

// } 
