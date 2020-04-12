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
AudioPlayer input;
BeatDetect beat;
FFT fft;
ColorPalette salmonColorPalette;
ColorPalette violetteColorPalette;
ColorPalette greyColorPalette;
float songPositionMultiplier = 1000000;

public void setup() {
  size(1024, 768, P3D);

  background(0);

  salmonColorPalette = new SalmonColorPalette();
  violetteColorPalette = new VioletteColorPalette();
  greyColorPalette = new GreyColorPalette();

  minim = new Minim(this);
  input = minim.loadFile("track.mp3");

  beat = new BeatDetect(input.bufferSize(), input.sampleRate());

  fft = new FFT( input.bufferSize(), input.sampleRate() );

  // library context
  DwPixelFlow context = new DwPixelFlow(this);

  // fluid simulation
  fluid = new DwFluid2D(context, width, height, 1);

  // some fluid parameters
  fluid.param.dissipation_velocity = 0.8f;
  fluid.param.dissipation_density  = 0.9f;

  // adding data to the fluid simulation
  fluid.addCallback_FluiData(new  DwFluid2D.FluidData() {
    public void update(DwFluid2D fluid) {
      updateFluid(fluid);
    }
  });

  pg_fluid = (PGraphics2D) createGraphics(width, height, P2D);

  input.play();
}


public void draw() {    

  beat.detect(input.mix);

  // update simulation
  fluid.update();

  // clear render target
  pg_fluid.beginDraw();
  //pg_fluid.background(0); //clear screen
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

void updateFluid(DwFluid2D fluid) {
  Color currentPaletteColor = getCurrentColor();
  float topFrequency = getTopTenFrequencies(fft)[0];
  float px     = width/2-input.left.level()*10000+input.right.level()*10000;
  float py     = height/2+topFrequency;
  float vx     = 10000;
  float multiplier = frameCount % 2 == 0 ? -1 : 1;
  float vy = multiplier*int(map(input.position(), 0, input.length(), 0, height))*songPositionMultiplier;
  fluid.addVelocity(px, py, 14, vx, vy);
  fluid.addDensity (px, py, beat.isKick() ? random(10, 12) : random(5, 7), 
    map(currentPaletteColor.getRed(), 0, 256, 0, 1), 
    map(currentPaletteColor.getGreen(), 0, 256, 0, 1), 
    map(currentPaletteColor.getBlue(), 0, 256, 0, 1), 1);
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
  if (beat.isKick()) {
    return salmonColorPalette.currentColor();
  } else if (beat.isSnare()) {
    return violetteColorPalette.currentColor();
  } else {
    return greyColorPalette.currentColor();
  }
}

void goToNextColor() {
  if (beat.isKick()) {
    salmonColorPalette.nextColor();
  } else if (beat.isSnare()) {
    violetteColorPalette.nextColor();
  } else {
    greyColorPalette.nextColor();
  }
}
