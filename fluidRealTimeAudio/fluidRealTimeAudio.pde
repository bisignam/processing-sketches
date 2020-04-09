import ddf.minim.*;
import ddf.minim.analysis.*;
import java.util.Arrays;
import com.thomasdiewald.pixelflow.java.DwPixelFlow;
import com.thomasdiewald.pixelflow.java.fluid.DwFluid2D;

// fluid simulation
DwFluid2D fluid;

// render target
PGraphics2D pg_fluid;

Minim minim;
AudioInput input;
BeatDetect beat;
FFT fft;
ColorPalette colorPalette1;
ColorPalette colorPalette2;

public void setup() {
  size(1024, 768, P3D);
  
  background(0);

  colorPalette1 = new ColorPalette(
    Arrays.asList(new Color(74, 39, 37), 
    new Color(214, 112, 107), 
    new Color(138, 72, 69), 
    new Color(150, 79, 75), 
    new Color(112, 59, 56), 
    new Color(256, 20, 30))); //easter egg :)

  colorPalette2 =  new ColorPalette(
    Arrays.asList(new Color(70, 36, 79), 
    new Color(195, 99, 219), 
    new Color(128, 65, 143), 
    new Color(138, 70, 156), 
    new Color(104, 53, 117), 
    new Color(256, 0, 0))); //easter egg :)

  minim = new Minim(this);
  input = minim.getLineIn();

  beat = new BeatDetect(input.bufferSize(), input.sampleRate());

  fft = new FFT( input.bufferSize(), input.sampleRate() );

  // library context
  DwPixelFlow context = new DwPixelFlow(this);

  // fluid simulation
  fluid = new DwFluid2D(context, width, height, 1);

  // some fluid parameters
  fluid.param.dissipation_velocity = 0.70f;
  fluid.param.dissipation_density  = 0.75f;

  // adding data to the fluid simulation
  fluid.addCallback_FluiData(new  DwFluid2D.FluidData() {
    public void update(DwFluid2D fluid) {
      updateFluid(fluid);
    }
  }
  );

  pg_fluid = (PGraphics2D) createGraphics(width, height, P2D);
}


public void draw() {    

  beat.detect(input.mix);

  // update simulation
  fluid.update();

  // clear render target
  pg_fluid.beginDraw();
  pg_fluid.background(0); //clear screen
  pg_fluid.endDraw();

  // render fluid stuff
  // Ultima variabile è display_mode, dalla doc: 
  // 0 ... 1px points, 1 = sprite texture,  2 ... falloff points
  fluid.renderFluidTextures(pg_fluid, 0);

  // display
  image(pg_fluid, 0, 0);

  //go to next palette color
  goToNextColor();
}

float[] getTopTenFrequencies(FFT fft) {
  fft.forward(input.mix);
  float[] topFreqs = new float[fft.specSize()];
  for (int i = 0; i<fft.specSize(); i++) {
    topFreqs[i] = fft.getBand(i);
  }
  topFreqs = sort(topFreqs);
  topFreqs = reverse(topFreqs);
  return topFreqs;
}

Color getCurrentColor() {
  return beat.isKick() ? colorPalette1.currentColor() : colorPalette2.currentColor();
}

void updateFluid(DwFluid2D fluid) {
  Color currentPaletteColor = getCurrentColor();
  float px     = width/2-input.left.level()*10000+input.right.level()*10000;
  float py     = height/2+getTopTenFrequencies(fft)[(int)random(0, 10)];
  float vx     = 0;
  float vy     = 100;
  fluid.addVelocity(px, py, 14, vx, vy);
  fluid.addDensity (px, py, beat.isKick() ? random(20, 40) : random(1, 10), 
    map(currentPaletteColor.getRed(), 0, 256, 0, 1), 
    map(currentPaletteColor.getGreen(), 0, 256, 0, 1), 
    map(currentPaletteColor.getBlue(), 0, 256, 0, 1), 1);
  if (beat.isKick()) {

    Color upFlowColor = colorPalette1.getRandomColor();
    for (int i=0; i<width; i+=10) {
      fluid.addVelocity(i, height, 14, vx, -vy);
      fluid.addDensity (i, height, 30, 
        map(upFlowColor.getRed(), 0, 256, 0, 1), 
        map(upFlowColor.getGreen(), 0, 256, 0, 1), 
        map(upFlowColor.getBlue(), 0, 256, 0, 1), 1);
    }

    Color downFlowColor = colorPalette2.getRandomColor();
    for (int i=0; i<width; i+=10) {
      fluid.addVelocity(i, 0, 14, vx, vy);
      fluid.addDensity (i, 0, 30, 
        map(downFlowColor.getRed(), 0, 256, 0, 1), 
        map(downFlowColor.getGreen(), 0, 256, 0, 1), 
        map(downFlowColor.getBlue(), 0, 256, 0, 1), 1);
    }
  }
} 

void goToNextColor() {
  if (beat.isKick()) {
    colorPalette1.nextColor();
  } else {
    colorPalette2.nextColor();
  }
}
