public class Node
{
  private int id;
  private int index;
  private double distance;
  private color c;
  private ArrayList<Node> neighbors = new ArrayList<Node>();
  
  //--------------------------------------
  //  CONSTRUCTOR
  //--------------------------------------
  
  public Node (int id, int index, int maxNodes){
    this.id = id;
    this.index = index;
    distance = 1;
    // c = color(random(0, 255), random(0, 255), random(0, 255));
    colorMode(HSB, 360, 100, 100);
    c = color((int)(index*360)/maxNodes, 50, 100);
  }
  public Node (Node another){
    this.id = another.getId();
    this.index = another.getIndex();
    this.distance = another.getDistance();
    this.c = another.getColor();
  }

  public void setIndex(int index) {
    this.index = index;
  }

  public int getId() {
    return id;
  }

  public int getIndex() {
    return index;
  }


  public String getName() {
    return "V"+id;
  }

  public double getDistance() {
    return distance;
  }

  public color getColor() {
    return c;
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
    print("\nNeighbors of "+getName()+" :\n");
    for (Node node : neighbors){
      print(node.getName()+" ");
    }
  }

  public ArrayList<Node> getNeighbors() {
    return neighbors;
  }

  public void updateDistance() {
    double sum = index;
    for (Node node : neighbors){
      sum += node.index;
    }
    this.distance = sum / (neighbors.size()+1);
  }
}
