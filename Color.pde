static class Color{
  
  int r;
  int g;
  int b;
  float therm; 
  
  Color(int r, int g, int b){
    this.r = r;
    this.g = g;
    this.b = b;
    this.therm = (float)(r + g + g) / 765;
  }
  
   Color(Color c){
    this.r = c.r;
    this.g = c.g;
    this.b = c.b;
    this.therm = (float)(r + g + g) / 765;
  }
}
