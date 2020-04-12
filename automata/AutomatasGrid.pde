public class AutomatasGrid { //<>// //<>// //<>// //<>// //<>// //<>// //<>//

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
    rule.setGrid(this);
    this.rule = rule;
    automatas = new Automaton[gridWidth][gridHeight];
  }

  public void setAndDrawAutomatas(List<Automaton> automatons) {
    for (Automaton automaton : automatons) {
      automatas[automaton.getX()][automaton.getY()] = automaton;
    }
    drawAutomatas();
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

  private void drawAutomata(int x, int y) {
    pushMatrix();
    stroke(0);
    strokeWeight(0);
    Color automataColor = automatas[x]
      [y].getColor();
    fill(automataColor.getRed(), 
      automataColor.getGreen(), 
      automataColor.getBlue(), 
      automataColor.getAlpha());
    square(automataSize*x, automataSize*y, automataSize);
    popMatrix();
  }

  public boolean isActive(int x, int y) {
    return automatas[x]
      [y].isActive();
  }

  public Map<Integer, List<Automaton>> drawSteps(int x, int y, int stepToCompute) {
    rule.setupRule(x, y);
    Map<Integer, List<Automaton>> activatedAutomatonsMap = new HashMap<Integer, List<Automaton>>();
    recursiveActivateAutomaton(x, y, 0, stepToCompute, activatedAutomatonsMap);
    return activatedAutomatonsMap;
  }

  private void activateAutomaton(int x, int y, int currentStep, 
    Map<Integer, List<Automaton>> automatonsMap) {
    //Manage X boundary
    if (x < 0 || x > gridWidth-1) {
      if (automatonsMap.get(currentStep) == null) {
        automatonsMap.put(currentStep, new LinkedList<Automaton>());
      }
      return;
    }
    //Manage Y boundary
    if (y < 0 || y > gridHeight-1) {
      if (automatonsMap.get(currentStep) == null) {
        automatonsMap.put(currentStep, new LinkedList<Automaton>());
      }
      return;
    }
    Color activeAutomatonColor = new Color(255, 255, 255);
    Automaton activatedAutomaton = new Automaton(x, y, activeAutomatonColor);
    activatedAutomaton.setActive(true);
    automatas[x][y] = activatedAutomaton;
    drawAutomata(x, y);
    if (automatonsMap.get(currentStep) == null) {
      automatonsMap.put(currentStep, new LinkedList<Automaton>());
    }
    automatonsMap.get(currentStep).add(activatedAutomaton);
  }

  private void activateAutomatons(List<Automaton> automatons, int currentStep, 
    Map<Integer, List<Automaton>> automatonsMap) {
    for (Automaton automatonToActivate : automatons) {
      activateAutomaton(automatonToActivate.getX(), automatonToActivate.getY(), 
        currentStep, automatonsMap);
    }
  }

  private void recursiveActivateAutomaton(int x, int y, int currentStep, 
    int targetStep, Map<Integer, List<Automaton>> automatonsMap) {
    if (currentStep > targetStep) {
      return;
    }
    //Manage X boundary
    if (x < 0 || x > gridWidth-1) {
      activateAutomatons(rule.outsideWidthBound(x, y), currentStep, automatonsMap); 
      return;
    }
    //Manage Y boundary
    if (y < 0 || y > gridHeight-1) {      
      activateAutomatons(rule.outsideHeightBound(x, y), currentStep, automatonsMap);  //<>//
      return;
    }
    List<Automaton> nextAutomatonsToActivate = rule.diffuse(x, y);
    for (Automaton automatonToActivate : 
      nextAutomatonsToActivate) {
      activateAutomaton(automatonToActivate.getX(), automatonToActivate.getY(), 
        currentStep, automatonsMap);
    }
    //Go forward with normal automatons activation
    for (Automaton automatonToActivate : nextAutomatonsToActivate) {
      recursiveActivateAutomaton(automatonToActivate.getX(), 
        automatonToActivate.getY(), currentStep+1, targetStep, automatonsMap);
    }
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
