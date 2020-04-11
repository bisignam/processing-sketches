public class Automaton {
  
  private int x;
  private int y;
  private Color colorz;
  private boolean active;
  
  Automaton(int x, int y, Color colorz){
   this.x = x;
   this.y = y;
   this.colorz = colorz;
  }
  
  Automaton(int x, int y){
   this.x = x;
   this.y = y;
  }
  
  public int getX(){
   return this.x; 
  }
  
  public int getY(){
   return this.y; 
  }
  
  public Color getColor(){
    return this.colorz;
  }
  
  public void setColor(Color colorz){
    this.colorz = colorz;
  }
  
  public void setActive(boolean active){
    this.active=active;
  }
  
  public boolean isActive(){
     return this.active; 
  }
}
