public abstract class AutomatonActivationRule {
 
  protected AutomatasGrid grid;
  
  public abstract List<Automaton> outsideWidthBound(int automataX, int automataY);
  
  public abstract List<Automaton> outsideHeightBound(int automataX, int automataY);
  
  public abstract List<Automaton> alreadyActiveAutomaton(int automataX, int automataY);
  
  public abstract List<Automaton> diffuse(int automataX, int automataY);
  
  public void setupRule(int automataX, int automataY){
     //do nothing 
  }
  
  public void setGrid(AutomatasGrid grid){
    this.grid = grid;
  }

}
