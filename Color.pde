static class Color{
  
  int r;
  int g;
  int b;
  float cal; 
  
  Color(int r, int g, int b){
    this.r = r;
    this.g = g;
    this.b = b;
    this.cal = 2*(1.1 - (float)(r + g + b) / 765);
  }
  
   Color(Color c){
     this(c.r,c.g,c.b);
  }
}
