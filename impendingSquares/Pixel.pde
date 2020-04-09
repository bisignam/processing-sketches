public class Pixel {
  
 private final float x;
 private final float y;
 private final float frequency;

 Pixel(float x, float y, float frequency){
   this.x = x;
   this.y = y;
   this.frequency = frequency;
 }
 
 float getFrequency(){
   return this.frequency;
 }
 
 void draw(){
    square(x, y, frequency);
 }
 
}
