import java.util.Arrays;
import java.util.LinkedList;

int automataSize = 5;
AutomatasGrid automatasGrid;
List<Automaton> steps = new LinkedList<Automaton>();
ExplosionsActivationRule explosionsActivationRule = new ExplosionsActivationRule();
int currentStepIndex = 0;

public void setup(){
 size(1000, 1000, P2D); 
 colorMode(RGB);

 //Code for simple activation rule x +/- 1, y +/- 1
 //automatasGrid = new AutomatasGrid(automataSize,  new SimpleDiffusionActivationRule());

 //Code for random activation Rule
 RandomDiffusionActivationRule randomDiffusionActivationRule = new RandomDiffusionActivationRule();
 automatasGrid = new AutomatasGrid(automataSize, randomDiffusionActivationRule);
 randomDiffusionActivationRule.setAutomatasGrid(automatasGrid);

//Code for explosions activation rule
 //automatasGrid = new AutomatasGrid(automataSize, explosionsActivationRule);
 
 stroke(1); //<>//
 strokeWeight(1); //<>//
}

public void draw() {
  //background(0);
  if(!automatasGrid.isInitialized()){
    automatasGrid.drawAutomatas(new SalmonColorPalette());
  } else {
    if(steps.isEmpty() || currentStepIndex > steps.size()-1) {
      currentStepIndex = 0; //<>//
      //reset and regenerate steps
      automatasGrid.drawAutomatas(new SalmonColorPalette());
      int activationX = (int)random(automatasGrid.getGridWidth()-1);
      int activationY = (int)random(automatasGrid.getGridHeight()-1);
      
      //Note: this is only needed when you activate the explosions activation rule
      // in other cases it has no effect
      explosionsActivationRule.resetExplosion(activationX, activationY);
      
      steps = automatasGrid.activateAutomaton(activationX, activationY, 1, 10);
    }
    
    //Draw step
    if(!steps.isEmpty() && currentStepIndex < steps.size()) {
      automatasGrid.setAndDrawAutomata(steps.get(currentStepIndex)); //<>//
    }
    
    //Advance
    currentStepIndex++; //<>//
  }
}
