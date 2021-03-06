import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
AudioPlayer voice;
FFT         fft;
String      windowName;

void setup()
{
  size(512, 400);
  
  minim = new Minim(this);
  voice = minim.loadFile("FOY0303JOY3.wav", 1024);
  println(voice.length());
  voice.loop();
  
  fft = new FFT(voice.bufferSize(), voice.sampleRate());
  
  WindowFunction newWindow = FFT.HANN;
  fft.window(newWindow);
}

void draw()
{
  background(0);
  stroke(255);
  
  fft.forward(voice.left);
  for(int i = 0; i < fft.specSize(); i++)
  {
    float bandDB = 20 * log(fft.getBand(i) / fft.timeSize());
    float bandHeight = map(bandDB, 0, -250, 0, height);
    
    line(i, height, i, bandHeight);
  }
  
  fill(255);
}
