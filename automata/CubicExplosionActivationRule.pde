public class CubicExplosionActivationRule extends AutomatonActivationRule {

  private Automaton explosionKernel;
  private int iteration = 1;

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
    //right down angle
    nextAutomatonsToActivate.add(new Automaton(explosionKernel.getX() + iteration, explosionKernel.getY() + iteration));
    
    for(int x=0; x<iteration*2; x++){
      nextAutomatonsToActivate.add(new Automaton(explosionKernel.getX() - iteration + x, explosionKernel.getY() + iteration));
    }
    
    //left down angle
    nextAutomatonsToActivate.add(new Automaton(explosionKernel.getX() - iteration, explosionKernel.getY() + iteration));
    
    for(int y=0; y<iteration*2; y++){
      nextAutomatonsToActivate.add(new Automaton(explosionKernel.getX() - iteration, explosionKernel.getY() - iteration + y));
    }
    
    //left top angle
    nextAutomatonsToActivate.add(new Automaton(explosionKernel.getX() - iteration, explosionKernel.getY() - iteration));
    
    for(int x=0; x<iteration*2; x++){
      nextAutomatonsToActivate.add(new Automaton(explosionKernel.getX() - iteration + x, explosionKernel.getY() - iteration));
    }
      
    //right top angle
    nextAutomatonsToActivate.add(new Automaton(explosionKernel.getX() + iteration, explosionKernel.getY() - iteration));
    
    for(int y=0; y<iteration*2; y++){
      nextAutomatonsToActivate.add(new Automaton(explosionKernel.getX() + iteration, explosionKernel.getY() - iteration + y));
    }
    
    iteration++;
    return nextAutomatonsToActivate;
  }

  public void setupRule(int x, int y) {
    this.iteration = 1; //<>//
    this.explosionKernel = new Automaton(x, y);
  }
  
  public void cleanupRule(int automataX, int automataY){
    this.grid.resetToInitialState(currentGridColorPalette); //<>//
  }
}
