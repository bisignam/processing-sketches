public class RandomDiffusionActivationRule implements AutomatonActivationRule {

  private AutomatasGrid automatasGrid;

  public List<Automaton> reachWidthBound(int automataX, int automataY) {
    return new LinkedList();
  }

  public List<Automaton> reachHeightBound(int automataX, int automataY) {
    return new LinkedList();
  }  

  public List<Automaton> alreadyActiveAutomaton(int automataX, int automataY) {
    return new LinkedList();
  }

  public List<Automaton> diffuse(int automataX, int automataY) {
    List<Automaton> nextAutomatonsToActivate = new LinkedList();
    int randomX1 = automataX + (int)random(automatasGrid.getGridWidth());
    int randomX2 = automataX + (int)random(automatasGrid.getGridWidth());
    int randomY1 = automataY + (int)random(automatasGrid.getGridHeight());
    int randomY2 = automataY + (int)random(automatasGrid.getGridHeight());
    nextAutomatonsToActivate.add(new Automaton(randomX1 > automatasGrid.getGridWidth()-1 ? (int)random(automatasGrid.getGridWidth()) : randomX1, automataY));
    nextAutomatonsToActivate.add(new Automaton(randomX2 > automatasGrid.getGridWidth()-1 ? (int)random(automatasGrid.getGridWidth()) : randomX2, automataY));
    nextAutomatonsToActivate.add(new Automaton(automataX, randomY1 > automatasGrid.getGridHeight()-1 ? (int)random(automatasGrid.getGridHeight()) : randomY1));
    nextAutomatonsToActivate.add(new Automaton(automataX, randomY2 > automatasGrid.getGridHeight()-1 ? (int)random(automatasGrid.getGridHeight()) : randomY2));
    return nextAutomatonsToActivate;
  }
  
  public void setAutomatasGrid(AutomatasGrid automatasGrid){
    this.automatasGrid = automatasGrid;
  }
}
