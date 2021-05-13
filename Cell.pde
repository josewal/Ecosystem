class Cell{
    int x;
    int y;
    int w;

    float temp;

    Flower f = null;
    boolean newF;

    List<Cell> nb = new ArrayList<Cell>();

    Cell(int x, int y, int w){
        this.x = x;
        this.y = y;
        this.w = w;

        this.temp = 14+random(3)-1.5;
    }

    boolean addFlower(Flower f){
        if (this.f != null){
            return false;
        }

        //println(this.x, this.y, f!=null);
        f.x = this.x + this.w / 2;
        f.y = this.y + this.w / 2;
        this.f = f;
        f.myGrass.add(this);
        return true;
    }

    Cell freeNb(){
        List<Cell> freeNb = new ArrayList<Cell>();
        for(int i = 0; i < this.nb.size(); i++){
            Cell c = nb.get(i);
            if(c.f == null){
                freeNb.add(nb.get(i));
            }
        }
        if(freeNb.size() != 0){
            int r = floor(random(freeNb.size()));
            return freeNb.get(r);
        }
        return null;
    }

    void update(){
        this.temp -= 0.03;
        
        if (this.f != null && this.f.dead()){
            this.f = null;
        }

        if (this.f != null){
            temp += 0.05 + 1-this.f.clr[1]/255 * 0.01;
        }

        this.temp = constrain(this.temp, 8, 30);

        for(int i = 0; i < this.nb.size(); i++){
            Cell c = this.nb.get(i);
            float tempDiff = c.temp - this.temp;
            this.temp += (tempDiff)/100;
        }

    }

    

    void display(){
        fill(temp/30 * 255,  255 - temp/30 * 255, 0);
        noStroke();
        rect(x,y,w,w);
    }
}
