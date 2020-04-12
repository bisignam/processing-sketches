public class ExplosionsActivationRule implements AutomatonActivationRule {

  private boolean alreadyExploded = false;
  private int numberOfAutomatonsForStep;
  private Automaton explosionKernel;

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
    if (!alreadyExploded) {
      nextAutomatonsToActivate.add(new Automaton(automataX + 1, automataY));
      nextAutomatonsToActivate.add(new Automaton(automataX - 1, automataY));
      nextAutomatonsToActivate.add(new Automaton(automataX, automataY + 1));
      nextAutomatonsToActivate.add(new Automaton(automataX, automataY - 1));
      nextAutomatonsToActivate.add(new Automaton(automataX - 1, automataY - 1));
      nextAutomatonsToActivate.add(new Automaton(automataX - 1, automataY + 1));
      nextAutomatonsToActivate.add(new Automaton(automataX + 1, automataY - 1));
      nextAutomatonsToActivate.add(new Automaton(automataX + 1, automataY + 1));
      alreadyExploded = true;
    } else {
      if (explosionKernel.getX() < automataX && explosionKernel.getY() < automataY) {
        //go down right
        nextAutomatonsToActivate.add(new Automaton(automataX + 1, automataY + 1));
      } else if (explosionKernel.getX() < automataX && explosionKernel.getY() > automataY) {
        //go top right
        nextAutomatonsToActivate.add(new Automaton(automataX + 1, automataY - 1));
      } else if (explosionKernel.getX() > automataX && explosionKernel.getY() < automataY) {
        //go down left
        nextAutomatonsToActivate.add(new Automaton(automataX - 1, automataY + 1));
      } else if (explosionKernel.getX() > automataX && explosionKernel.getY() > automataY) {
        //go top left
        nextAutomatonsToActivate.add(new Automaton(automataX - 1, automataY - 1));
      } else if (explosionKernel.getX() > automataX && explosionKernel.getY() == automataY) {
        //go  left
        nextAutomatonsToActivate.add(new Automaton(automataX - 1, automataY));
      } else if (explosionKernel.getX() < automataX && explosionKernel.getY() == automataY) {
        //go right
        nextAutomatonsToActivate.add(new Automaton(automataX +1, automataY));
      } else if (explosionKernel.getX() == automataX && explosionKernel.getY() > automataY) {
        //go top
        nextAutomatonsToActivate.add(new Automaton(automataX, automataY - 1));
      }  else if (explosionKernel.getX() == automataX && explosionKernel.getY() < automataY) {
        //go down
        nextAutomatonsToActivate.add(new Automaton(automataX, automataY + 1));
      }
    }
    return nextAutomatonsToActivate;
  }

  public void resetExplosion(int x, int y) {
    this.explosionKernel = new Automaton(x, y);
    this.alreadyExploded = false;
  }
  
  public int numberOfautomatonsForStep(){
    return 0;
  }
}
