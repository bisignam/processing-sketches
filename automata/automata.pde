import java.util.Arrays; //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
import java.util.Map;
import java.util.LinkedList;

int automataSize = 5;
AutomatasGrid automatasGrid;
Map<Integer, List<Automaton>> steps = new HashMap<Integer, List<Automaton>>();
ExplosionsActivationRule explosionsActivationRule = new ExplosionsActivationRule();
int currentStep = 0;
int maxStep = 10;
int activationX = 0;
int activationY = 0;

public void setup() {
  size(1000, 1000);
  background(0);
  colorMode(RGB);

  //Code for simple activation rule x +/- 1, y +/- 1
  //automatasGrid = new AutomatasGrid(automataSize, new SimpleDiffusionActivationRule());

  //Code for random activation Rule
  automatasGrid = new AutomatasGrid(automataSize, new RandomDiffusionActivationRule());

  //Code for explosions activation rule
  //automatasGrid = new AutomatasGrid(automataSize, explosionsActivationRule);

  stroke(0);
  strokeWeight(0);
}

public void draw() {
  if (currentStep == 0 || currentStep == maxStep-1) {
    activationX = (int)random(automatasGrid.getGridWidth()-1);
    activationY = (int)random(automatasGrid.getGridHeight()-1);
    automatasGrid.drawAutomatas(new VioletteColorPalette());
    currentStep = 0;
  } else {
    automatasGrid.drawSteps(activationX, activationY, currentStep);
  }
  currentStep++;
}
