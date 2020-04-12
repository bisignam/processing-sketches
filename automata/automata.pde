import java.util.Arrays;
import java.util.Map;
import java.util.LinkedList;

int automataSize = 10;
AutomatasGrid automatasGrid;
Map<Integer, List<Automaton>> steps = new HashMap<Integer, List<Automaton>>();
ExplosionsActivationRule explosionsActivationRule = new ExplosionsActivationRule();
int currentStepIndex = 1;

public void setup() {
  size(1000, 1000);
  background(0);
  frameRate(10);
  colorMode(RGB);

  //Code for simple activation rule x +/- 1, y +/- 1
  //automatasGrid = new AutomatasGrid(automataSize,  new SimpleDiffusionActivationRule());

  //Code for random activation Rule
  /**RandomDiffusionActivationRule randomDiffusionActivationRule = new RandomDiffusionActivationRule();
  automatasGrid = new AutomatasGrid(automataSize, randomDiffusionActivationRule);
  randomDiffusionActivationRule.setAutomatasGrid(automatasGrid);**/

  //Code for explosions activation rule
  automatasGrid = new AutomatasGrid(automataSize, explosionsActivationRule);

  stroke(1); //<>//
  strokeWeight(0.1); //<>//
}

public void draw() {
  if (!automatasGrid.isInitialized()) {
    automatasGrid.drawAutomatas(new VioletteColorPalette());
  } else {
    if (steps.isEmpty() || currentStepIndex > steps.size()-1) {
      currentStepIndex = 1; //<>//
      //reset and regenerate steps
      automatasGrid.drawAutomatas(new VioletteColorPalette());
      int activationX = (int)random(automatasGrid.getGridWidth()-1);
      int activationY = (int)random(automatasGrid.getGridHeight()-1);

      //Note: this is only needed when you activate the explosions activation rule
      // in other cases it has no effect
      explosionsActivationRule.resetExplosion(activationX, activationY);

      steps = automatasGrid.computeActivatedAutomatons(activationX, activationY, 100);
    }

    //Draw step
    if (!steps.isEmpty() && currentStepIndex < steps.size()) { //<>//
      List<Automaton> automatonsForStep = steps.get(currentStepIndex);
      for(Automaton toDraw: automatonsForStep){ //<>//
        automatasGrid.setAndDrawAutomata(toDraw); //<>//
      }
    }

    //Advance //<>//
    currentStepIndex++;
  }
}
