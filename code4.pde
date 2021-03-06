import ddf.minim.*;
import ddf.minim.ugens.*;
import javax.sound.sampled.*;

Minim minim;
AudioSample wave;
float[] samples;

void setup()
{
  size(1024, 200);
  
  minim = new Minim(this);
  float waveFrequency  = 220f;
  float waveSampleRate = 48000f;
  float timeLength     = 1.0;
  int overtones        = 20;
  float amp            = 0.1f;
  float amp_max        = 0.0;
  
  samples = new float[(int)(waveSampleRate * timeLength)];
  
  for(int i = 0; i < samples.length; ++i)
  {
    float t = i / waveSampleRate;
    
    for(int j = 1; j <= overtones; j++)
    {
      float tmp = sin(2 * PI * (waveFrequency * j) * t) * (1.0 / j);
      samples[i] = samples[i] + tmp;
    }
    
    if(amp_max < abs(samples[i]))
    {
      amp_max = abs(samples[i]); 
    }
  }
  
  for(int i = 0; i < samples.length; ++i)
  {
    samples[i] = samples[i] / amp_max * amp; 
  }
  
  AudioFormat format = new AudioFormat
  (
    waveSampleRate,
    16,
    1,
    true,
    true
  );
  
  wave = minim.createSample
  (
    samples,
    format,
    1024
  );
}

void draw()
{
 background(0);
 stroke(255);
 
 for(int i = 0; i < wave.bufferSize() - 1; i++)
 {
   line(i, 100 - wave.left.get(i) * 50, i + 1, 100 - wave.left.get(i + 1) * 50); 
 }
}

void keyPressed()
{
  if(key == 't')
  {
    wave.trigger(); 
  }
  else if(key == 's')
  {
    
  }
}
