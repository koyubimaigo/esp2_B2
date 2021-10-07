import ddf.minim.*;

Minim minim;
AudioPlayer player;

void setup()
{
  size(100, 100);
  
  minim = new Minim(this);
  player = minim.loadFile("FOY0303JOY3.wav");
  player.play();
}

void draw()
{
  
}
