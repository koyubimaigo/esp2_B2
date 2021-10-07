for(int i = 0; i < (int)(samplePerFreq * 2); i++)
{
  line(i, 100 - samples[i] * 50, i + 1, 100 - samples[i + 1] * 50) ;
}
