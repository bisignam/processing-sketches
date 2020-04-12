public class RandomDiffusionActivationRule extends AutomatonActivationRule {

  public List<Automaton> outsideWidthBound(int automataX, int automataY) {
    return new LinkedList();
  }

  public List<Automaton> outsideHeightBound(int automataX, int automataY) {
    return new LinkedList();
  }  

  public List<Automaton> alreadyActiveAutomaton(int automataX, int automataY) {
    return new LinkedList();
  }

  public List<Automaton> diffuse(int automataX, int automataY) {
    List<Automaton> nextAutomatonsToActivate = new LinkedList();
    int randomX1 = automataX + (int)random(grid.getGridWidth());
    int randomX2 = automataX + (int)random(grid.getGridWidth());
    int randomY1 = automataY + (int)random(grid.getGridHeight());
    int randomY2 = automataY + (int)random(grid.getGridHeight());
    nextAutomatonsToActivate.add(
      new Automaton(randomX1 > grid.getGridWidth()-1 ? (int)random(grid.getGridWidth()) : randomX1, automataY));
    nextAutomatonsToActivate.add(
      new Automaton(randomX2 > grid.getGridWidth()-1 ? (int)random(grid.getGridWidth()) : randomX2, automataY));
    nextAutomatonsToActivate.add(
      new Automaton(automataX, randomY1 > grid.getGridHeight()-1 ? (int)random(grid.getGridHeight()) : randomY1));
    nextAutomatonsToActivate.add(
      new Automaton(automataX, randomY2 > grid.getGridHeight()-1 ? (int)random(grid.getGridHeight()) : randomY2));
    return nextAutomatonsToActivate;
  }
  
}
