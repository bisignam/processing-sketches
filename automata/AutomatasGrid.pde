public class AutomatasGrid { //<>//

  private int gridWidth;
  private int gridHeight;
  private int automataSize;
  private boolean initialized = false;
  private AutomatonActivationRule rule;

  private Automaton[][] automatas = new Automaton[][]{};

  AutomatasGrid(int automataSize, AutomatonActivationRule rule) {
    this.gridWidth = width/automataSize;
    this.gridHeight = height/automataSize;
    this.automataSize = automataSize;
    this.rule = rule;
    automatas = new Automaton[gridWidth][gridHeight];
  }

  private void drawAutomatas() {
    for (int i=0; i<gridWidth; i+=1) {
      for (int j=0; j<gridHeight; j+=1) {
        drawAutomata(i, j);
      }
    }
  }

  public void drawAutomatas(ColorPalette colorPalette) {
    for (int i=0; i<gridWidth; i+=1) {
      for (int j=0; j<gridHeight; j+=1) {
        automatas[i][j] = new Automaton(i, j, colorPalette.currentColor());
        drawAutomata(i, j);
      }
      colorPalette.nextColor();
    }
    initialized = true;
  }

  private void drawAutomata(int automataX, int automataY) {
    // System.out.println("Draw automata "+automataX+" "+automataY);
    pushMatrix();
    Color automataColor = automatas[automataX]
      [automataY].getColor();
    fill(automataColor.getRed(), 
      automataColor.getGreen(), 
      automataColor.getBlue(), 
      automataColor.getAlpha());
    square(automataSize*automataX, automataSize*automataY, automataSize);
    popMatrix();
  }

  public void setAndDrawAutomata(Automaton automaton) {
    automatas[automaton.getX()][automaton.getY()] = automaton;
    drawAutomatas();
  }

  public Map<Integer, List<Automaton>> computeActivatedAutomatons(int activationX, int activationY, int numberOfGenerations) {
    Map<Integer, List<Automaton>> activatedAutomatonsMap = new HashMap<Integer, List<Automaton>>(); //<>//
    internalActivateAutomaton(activationX, activationY, 1, numberOfGenerations, activatedAutomatonsMap); //<>//
    return activatedAutomatonsMap; //<>//
  }

  private List<Automaton> internalActivateAutomaton(int automataX, int automataY, int step, 
    int numberOfGenerations, Map<Integer, List<Automaton>> automatonsMap) {
    // System.out.println("Loop X Y "+loop +" "+automataX + " "+automataY);
    List<Automaton> activatedAutomatons = new LinkedList<Automaton>();
    if (step == numberOfGenerations) {
      //System.out.println("Reached number of generations. STOP");
      automatonsMap.put(step, new LinkedList<Automaton>());
      return new LinkedList<Automaton>();
    }
    if (automatas[automataX][automataY].isActive()) {
      //System.out.println("Already active");
      List<Automaton> alreadyActiveList = rule.alreadyActiveAutomaton(automataX, automataY);
      automatonsMap.put(step, alreadyActiveList);
      return alreadyActiveList;
    }

    //Activate the automaton
    Color activeAutomatonColor = new Color(255, 255, 255);
    automatas[automataX][automataY].setActive(true);
    Automaton activatedAutomaton = new Automaton(automataX, automataY, activeAutomatonColor);
    activatedAutomatons.add(activatedAutomaton);
    if (automatonsMap.get(step) == null) {
      automatonsMap.put(step, new LinkedList<Automaton>());
    }
    automatonsMap.get(step).add(activatedAutomaton); //<>//

    //Manage X boundary
    if (automataX == 0 || automataX == gridWidth-1) {
      List<Automaton> xBoundReachedActivatedAutomatons = rule.reachWidthBound(automataX, automataY);
      automatonsMap.put(step, xBoundReachedActivatedAutomatons);
      return xBoundReachedActivatedAutomatons;
    }
    //Manage Y boundary
    if (automataY == 0 || automataY == gridHeight-1) {      
      List<Automaton> yBoundReachedActivatedAutomatons = rule.reachHeightBound(automataX, automataY);
      automatonsMap.put(step, yBoundReachedActivatedAutomatons);
      return yBoundReachedActivatedAutomatons;
    }

    List<Automaton> nextAutomatonsToActivate = rule.diffuse(automataX, automataY);
    int automatonsAddedForStep = 1;
    int stepForAutomatonAdd = step;
    for (Automaton automatonToActivate : nextAutomatonsToActivate) {
      if (automatonsAddedForStep >= rule.numberOfautomatonsForStep()) { //<>//
        stepForAutomatonAdd++;
        if(stepForAutomatonAdd >= numberOfGenerations) {
          break;
        }
        automatonsAddedForStep = 1;
      }
      activatedAutomatons.addAll(internalActivateAutomaton(automatonToActivate.getX(), 
        automatonToActivate.getY(), stepForAutomatonAdd, numberOfGenerations, automatonsMap));
      automatonsAddedForStep++;
    }

    return activatedAutomatons;
  }

  boolean isInitialized() {
    return this.initialized;
  }

  int getGridWidth() {
    return this.gridWidth;
  }

  int getGridHeight() {
    return this.gridHeight;
  }
}
