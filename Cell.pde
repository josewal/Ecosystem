 class Cell{
    int x;
    int y;
    int w;
    
    float temp;
    int maxTemp = 70;
    int minTemp = -30;
    float cooling = -0.7;
    float mass = 100;
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
        
        this.temp = 16;
    }
    
    void updateClr(){
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
        f.myGrass.add(this);
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
        this.temp += cooling/mass;
        
        if (this.f != null && this.f.dead()) {
            this.f = null;
        }
        
        if (this.f != null) {
            temp += (1 * (1.1 - this.f.dna.clr.therm ) )/mass;
        }
        

        for (int i = 0; i < this.nb.size(); i++) {
            Cell c = this.nb.get(i);
            float tempDiff = c.temp - this.temp;
            this.temp += (tempDiff)/mass;
        }
        
        this.temp = constrain(this.temp, minTemp, maxTemp);
    }
    
    void display(boolean dispCooling) {
        this.updateClr();
        if(dispCooling){          
          int cr = cooling > 0 ? (int) map( cooling   , 0, Earth.maxCool, 32, 250):0; 
          int cg = cooling < 0 ? (int) map( cooling, Earth.minCool, 0, 250, 32):0;
          fill(cr,cg, 0);
        }else{
          fill(r,g,b);
        }
        noStroke();
        rect(x,y,w,w);
    }
    
}
