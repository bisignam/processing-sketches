import java.util.*;

int cropWidth = 725;
int cropHeight = 1024;
boolean storeImage = false;
int squareHeight = 48;
int squareWidth = 145;
//int squareHeight = 512;
//int squareWidth = 145;
boolean thresholdFilter = true;
boolean grayFilter = false;
float threshold = 0.51;
float thresholdForPainting = 100;
float thresholdForOne = 40;
String processedImageName = "1.jpeg";
String imageToSaveName = "cross_9";
boolean step = false;
boolean moveX = false;
boolean movey = false;
List<Slot> usedSlots = new LinkedList();
List<PImage> imagesToMix = new LinkedList();
List<PImage> croppedImagesToMix = new LinkedList();

public class Slot {
  Float x;
  Float y;
  
  Slot(Float x, Float y) {
    this.x = x;
    this.y = y;
  }
 
  public String toString() {
    return "Slot[ x: "+x+", y: "+y+"]"; 
  }
}

void setup() {
  size(725, 816);
  background(255, 255, 255);
  imagesToMix.add(loadImage("1.jpeg"));
  imagesToMix.add(loadImage("2.jpeg"));
  imagesToMix.add(loadImage("3.jpeg"));
  imagesToMix.add(loadImage("4.jpeg"));
}

void draw() {
 
  if(!step){
    
      decideCropWidthAndHeight();
  
      println("CropWidth: "+cropWidth);
      println("CropHeight: "+cropHeight);
  
      if(cropHeight % squareHeight != 0) {
         throw new RuntimeException("The squareHeight parameter with value "+squareHeight+ " should be a divisor of cropHeight with value "+cropHeight);
      }
  
      if(cropWidth % squareWidth != 0) {
         throw new RuntimeException("The squareWidth parameter with value "+squareWidth+" should be a divisor of cropWidth with value "+cropWidth);
      }
      
      mixImages(imagesToMix);
  }
  step = true;
  //print("Used slots: "+usedSlots);
}

void decideCropWidthAndHeight(){
  cropHeight = Integer.MAX_VALUE;
  cropWidth = Integer.MAX_VALUE;
  for(PImage image: imagesToMix) {
    cropHeight = java.lang.Math.min(cropHeight, image.height);
    cropWidth = java.lang.Math.min(cropWidth, image.width);
  }
}

public void mixImages(List<PImage> imagesToMix) {
  for(PImage imageToMix: imagesToMix) {
    croppedImagesToMix.add(imageToMix.get(0, 0, cropWidth, cropHeight));
  }
  for (int i=0; i<cropWidth; i+=squareWidth) {
    for (int j=0; j<cropHeight; j+=squareHeight) {
      //println("Loop: x: "+i+" y: "+j);
      PImage randomImageForMix = getRandomImage();
      PImage puzzlePiece = randomImageForMix.get(i, j, squareWidth, squareHeight);
      Slot slot = generateSlotUntilNew(randomImageForMix, i, j);
      image(puzzlePiece, slot.x, slot.y);
      usedSlots.add(slot);
    }
  }
}

PImage getRandomImage() {
   return croppedImagesToMix.get(int(random(croppedImagesToMix.size())));
}


public Slot generateSlotUntilNew(PImage image, float x, float y) {
  Slot slot = null;
   do {
     float slotHeight;
     float slotWidth;
     
     if(moveX) {
      float rand = random(0, image.width/squareWidth);
      slotWidth =  ceil(rand==0.0d?rand:rand-1)*squareWidth; 
     } else {
      slotWidth = x;
     }
     
     if(movey) {
       float rand = random(0, image.height/squareHeight);
       slotHeight = ceil(rand==0.0d?rand:rand-1)*squareHeight;
     } else {
      slotHeight = y; 
     }
     
     slot = new Slot(slotWidth, slotHeight);
   } while(alreadyUsed(slot));
 //  println("Used slots: "+usedSlots);
  // println("Generated "+slot);
   return slot;
}

//Don't kno why but hashcode and equals are not working correctly
// so we need a custom function for finding if the given slot is in the used slots array
public boolean alreadyUsed(Slot slot) {
 for(Slot slotz: usedSlots) {
   if(slotz.x.equals(slot.x) && slotz.y.equals(slot.y)) {
       return true;
   }
 }
 return false;
}
