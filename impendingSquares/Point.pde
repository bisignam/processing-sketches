public class Point {
 
  private final float x;
  private final float y;
  private final float z;
  
  Point(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  public float getX(){
    return this.x;
  }
  
  public float getY(){
     return this.y; 
  }
  
  public float getZ(){
     return this.z; 
  }
  
  @Override
  public String toString(){
    return "{ x: "+x+", y: "+y+", z: "+z+" }";
  }
}
