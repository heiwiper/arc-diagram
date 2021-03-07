public class Node
{
  private String name;
  private int index;
  private double distance;
  private ArrayList<Node> neighbors = new ArrayList<Node>();
  
  //--------------------------------------
  //  CONSTRUCTOR
  //--------------------------------------
  
  public Node (String name, int index){
    this.name = name;
    this.index = index;
    distance = 1;
  }

  public void setIndex(int index) {
    this.index = index;
  }


  public void addNeighbor(Node node) {
    neighbors.add(node);
    updateDistance();
  }

  public void addNeighbors(Node[] nodes) {
    for (Node node : nodes){
      neighbors.add(node);
    }
  }

  public void printNeighbors() {
    print("\nNeighbors of "+name+" :\n");
    for (Node node : neighbors){
      print(node.name+" ");
    }
  }

  public void updateDistance() {
    double sum = index;
    for (Node node : neighbors){
      sum += node.index;
    }
    this.distance = sum / (neighbors.size()+1);
  }
}
