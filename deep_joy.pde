import processing.sound.*;

// Declare the processing sound variables 
SoundFile sample;
Amplitude rms;

// Declare a scaling factor
float scale=2;

// Declare a smooth factor
float smooth_factor=0.25;

// Used for smoothing
float sum;



float bg = 10;
float lineColor = 200;

float xoff = 0;
float yoff = 1000;

float u(float n) {
  return width/100 * n;
}

void setup() {
  size(500,500);
  //pixelDensity(displayDensity());
  
 
  background(bg);
  strokeWeight(2);
  stroke(lineColor);
  smooth();
  
  sample = new SoundFile(this, "Shadowplay.mp3");
    sample.loop();
    
    // Create and patch the rms tracker
    rms = new Amplitude(this);
    rms.input(sample);
  

  
}

void draw() {
    background(bg);


   
   fill(255,0,150);

 sum += (rms.analyze() - sum) * smooth_factor;  
   float rms_scaled=sum*(height/2)*scale;
   
   
   println(rms_scaled);
   float gai=map(rms_scaled,0,250,0,3);
  
  
 for(float y = height*0.1; y < height*0.9; y += u(1.5)) {
    pushMatrix();
    translate(0, y);
    noFill();
    beginShape();
     
    for(float x = width*0.1; x < width*0.9; x++) {
      //float ypos = map(noise(x/100 + xoff, y/100 + yoff), 0, 1, -100, 100);
      float ypos = map(noise(x/100 + xoff, y/100 + yoff), 0, 1, -100, 100);
      //float magnitude = x < width*0.9 ? map(x, width*0.1, width*0.5, 0, 1) : map(x, width*0.5, width*0.9, 1, 0) ;
      //ypos *= magnitude;
      float magnitude = x < width*0.9 ? gai : map(rms_scaled, 0, 250, 3, 0) ;
       ypos *= magnitude+.4;
      //ypos *=r_width;
      if(ypos > 0) ypos = 0;
      
  
      
      
      vertex(x, ypos);
    }
    
    
    
    endShape();
    popMatrix();
    
  }
    
      

  
  
  xoff += 0.01;
  yoff += -0.01;
}
