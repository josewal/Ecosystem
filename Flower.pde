class Flower{
    float x;
    float y;
    List<Cell> myGrass = new ArrayList<Cell>();
    
    int[] clr = new int[3];
    int type;
    
    float hp;
    float maxHp;
    float idealTemp;
    float sensitivity;
    
    
    Flower(int type) {
        
        this.type = type;
            
        switch(this.type) {
            case 1:
                this.maxHp = 1.5;
                this.hp = maxHp/2;
                this.clr[0] = 0;
                this.idealTemp = 11;
                this.sensitivity = 6;
                break;
            case 2:
                this.maxHp = 1;
                this.hp = maxHp/2;
                this.clr[1] = 255;
                this.clr[2] = 255;
                this.clr[0] = 255;
                this.idealTemp = 18;
                this.sensitivity = 6;
                break;
            
            default :
            this.clr[2] = 255;
            this.idealTemp = 25;
            this.sensitivity = 0.2;
            break;	
        }
    }
    
    void update() {
        float avgTemp = 0;
        for (int i = 0; i < myGrass.size(); i++) {
            Cell c = myGrass.get(i);
            avgTemp += c.temp;
        }
        
        avgTemp /= myGrass.size();
        float tempDiff = idealTemp - avgTemp;
        
        if (abs(tempDiff)<this.sensitivity) {
            this.hp += 0.002;
            
            Cell nb =  myGrass.get(0).freeNb();
            if (nb != null) {
                Flower nF = this.clone();
                if (nF != null) {
                    this.hp /= 2;
                    nb.addFlower(nF);
                    nb.newF = true;
                }
            }
            
            
        } else{
            this.hp += -0.001;
        }
        this.hp = constrain(this.hp, 0, this.maxHp);
    }
    
    Flower clone() {
        if (this.hp > 3*this.maxHp/4) {
            return new Flower(this.type);
        }
        return null;
    }
    
    boolean dead() {
        return this.hp == 0;
    }
    
    void display() {
        strokeWeight(1);
        fill(clr[0], clr[1], clr[2]);
        fill(clr[0], clr[1], clr[2]);
        ellipse(this.x, this.y, 10 * this.hp / this.maxHp, 10 * this.hp / this.maxHp);
    }
}
