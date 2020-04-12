public interface AutomatonActivationRule {
 
  public List<Automaton> reachWidthBound(int automataX, int automataY);
  
  public List<Automaton> reachHeightBound(int automataX, int automataY);
  
  public List<Automaton> alreadyActiveAutomaton(int automataX, int automataY);
  
  public List<Automaton> diffuse(int automataX, int automataY);
  
  public int numberOfautomatonsForStep();

}
