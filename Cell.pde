class Cell{
    int x;
    int y;
    int w;
    
    float temp;
    int maxTemp = 40;
    float mass = 10;
    int alpha;
    
    Flower f = null;
    boolean newF = false;
    
    List<Cell> nb = new ArrayList<Cell>();
    
    Cell(int x, int y, int w) {
        this.x = x;
        this.y = y;
        this.w = w;
        
        this.temp = 16;
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
        this.temp += -0.7/mass;
        
        if (this.f != null && this.f.dead()) {
            this.f = null;
        }
        
        if (this.f != null) {
            temp += (1 * (1.2 - (this.f.dna.clr[0] + this.f.dna.clr[1] + this.f.dna.clr[2]) / 765))/mass;
        }
        
        this.temp = constrain(this.temp, 0, maxTemp);
        
        for (int i = 0; i < this.nb.size(); i++) {
            Cell c = this.nb.get(i);
            float tempDiff = c.temp - this.temp;
            this.temp += (tempDiff)/mass;
        }
    }
    
    void display() {
        fill(temp / maxTemp * 255,  255 - temp / maxTemp * 255, 0, alpha);
        noStroke();
        rect(x,y,w,w);
    }
}
