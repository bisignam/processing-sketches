public class SimpleDiffusionActivationRule implements AutomatonActivationRule {

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
    nextAutomatonsToActivate.add(new Automaton(automataX + 1, automataY));
    nextAutomatonsToActivate.add(new Automaton(automataX - 1, automataY));
    nextAutomatonsToActivate.add(new Automaton(automataX, automataY + 1));
    nextAutomatonsToActivate.add(new Automaton(automataX, automataY - 1));
    return nextAutomatonsToActivate;
  }
}
