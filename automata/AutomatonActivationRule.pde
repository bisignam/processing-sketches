public interface AutomatonActivationRule {
 
  public abstract List<Automaton> reachWidthBound(int automataX, int automataY);
  
  public abstract List<Automaton> reachHeightBound(int automataX, int automataY);
  
  public abstract List<Automaton> alreadyActiveAutomaton(int automataX, int automataY);
  
  public abstract List<Automaton> diffuse(int automataX, int automataY);

}
