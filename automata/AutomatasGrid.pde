public class AutomatasGrid { //<>// //<>//

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
    fill(RGB, automataColor.getRed(), 
      automataColor.getGreen(), 
      automataColor.getBlue());
    square(automataSize*automataX, automataSize*automataY, automataSize);
    popMatrix();
  }

  public void setAndDrawAutomata(Automaton automaton) {
    automatas[automaton.getX()][automaton.getY()] = automaton;
    drawAutomatas();
  }

  public List<Automaton> activateAutomaton(int automataX, int automataY, int loop, int numberOfGenerations) {
    LinkedList<Automaton> automatonsSteps = new LinkedList<Automaton>();
    // System.out.println("Loop X Y "+loop +" "+automataX + " "+automataY);
    if (loop == numberOfGenerations) {
      //System.out.println("Reached number of generations. STOP");
      return automatonsSteps;
    }
    if (automatas[automataX][automataY].isActive()) {
      //System.out.println("Already active");
      return rule.alreadyActiveAutomaton(automataX, automataY);
    }
    Color activeAutomatonColor = new Color(255, 255, 255);
    automatas[automataX][automataY].setActive(true);
    automatonsSteps.add(new Automaton(automataX, automataY, activeAutomatonColor));
    //Manage X boundary
    if (automataX == 0 || automataX == gridWidth-1) {
     return rule.reachWidthBound(automataX, automataY);
    }
    //Manage Y boundary
    if (automataY == 0 || automataY == gridHeight-1) {      
      return rule.reachHeightBound(automataX, automataY);
    }

    List<Automaton> nextAutomatons = rule.diffuse(automataX, automataY);
    for (Automaton automaton : nextAutomatons) {
      automatonsSteps.addAll(activateAutomaton(automaton.getX(), automaton.getY(), loop+1, numberOfGenerations));
    }

    return automatonsSteps;
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
