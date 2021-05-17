 class Cell{
    int x;
    int y;
    int w;
    
    float cal;
    float cooling = -0.7;
    int alpha;
    
    int r;
    int g;
    int b;
    
    Flower f = null;
    boolean newF = false;
    
    List<Cell> nb = new ArrayList<Cell>();
    
    Cell(int x, int y, int w) {
        this.x = x;
        this.y = y;
        this.w = w;
        
        this.cal = 300;
    }
    
    void updateClr(){
      float temp = Earth.getTemp(cal);
      this.r = (int)map(temp, -20, 60, 0, 255);
      this.g = (int)map(temp, -20, 60, 255, 0);
      this.b = 0;
    }
    
    boolean addFlower(Flower f) {
        if (this.f != null) {
            return false;
        }
        
        //println(this.x, this.y, f!=null);
        f.x = this.x + this.w / 2;
        f.y = this.y + this.w / 2;
        this.f = f;
        f.c = this;
        return true;
    }
    
    Cell freeNb() {
        List<Cell> freeNb = new ArrayList<Cell>();
        for (int i = 0; i < this.nb.size(); i++) {
            Cell c = nb.get(i);
            if (c.f == null) {
                freeNb.add(nb.get(i));
            }
        }
        if (freeNb.size() != 0) {
            int r = floor(random(freeNb.size()));
            return freeNb.get(r);
        }
        return null;
    }
    
    void update() {
        float newC =  cooling ;
        
        if (this.f != null && this.f.dead()) {
            this.f = null;
        }
        
        if (this.f != null) {
            newC += this.f.dna.clr.cal;
        }

        for (int i = 0; i < this.nb.size(); i++) {
            Cell c = this.nb.get(i);
            float calDiff = c.cal - this.cal;
            newC += (calDiff)/100;
             
            c.cal -= (calDiff)/100;
            if(c.cal<0){
              c.cal=0;
            }
        }   
        
         this.cal  = (this.cal + newC) > 0 ? this.cal + newC : 0;

}
    
    
    void display(boolean dispCooling) {
        this.updateClr();
        if(dispCooling){          
          int cr = cooling > 0 ? (int) map( cooling, 0,             Earth.maxCool, 32, 250):0; 
          int cg = cooling < 0 ? (int) map( cooling, Earth.minCool, 0,             250, 32):0;
          fill(cr,cg, 0);
        }else{
          fill(r,g,b);
        }
        noStroke();
        rect(x,y,w,w);
    }
    
    float getTemp(){
      return Earth.getTemp(cal);
    }
    
}
