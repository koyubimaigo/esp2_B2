import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim       minim;
AudioPlayer voice;
FFT         fft;

void setup()
{
  size(513, 400);
  
  minim = new Minim(this);
  voice = minim.loadFile("FOY0303JOY3.wav", 1024);
  voice.loop();
  
  fft = new FFT(voice.bufferSize(), voice.sampleRate());
  WindowFunction newWindow = FFT.HANN;
  fft.window(newWindow);
  
  colorMode(HSB, 360, 100, 100);
  background(240, 100, 100);
}

void draw()
{
  fft.forward(voice.left);
  loadPixels();
  
  for(int x = 0; x < width; x++)
  {
    for(int y = 0; y < height; y++)
      {
        if(x < width - 1)
        {
          pixels[y * width + x] = pixels[y * width + x + 1];
        }
        else
        {
          float bandDB = 20* log(2 * fft.getBand(height - 1 - y) / fft.timeSize());
          float hue = 240 - map(bandDB, -60, -150, 360, 0);
          
          if(hue < 0)
            hue = 0;
          if(hue > 240)
            hue = 240;
            
          pixels[y * width + x] = color(hue, 100, 100);
        }
      }
  }
  
  updatePixels();
}
