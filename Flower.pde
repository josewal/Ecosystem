 class Flower{
    float x;
    float y;
    Cell c;
    
    Dna dna;
      
    float hp;
    float age;
    float mSize;
    
    Flower(float mS, Dna dna) {
        this.age=random(0,0.3);
        this.mSize = mS;
        this.dna = dna;
        this.hp = dna.cloneCost*dna.maxHp;
        ++this.dna.numFlowers;
    }
    
    
    void update() {
        float temp = Earth.getTemp(c.cal);             
        
        float tempDiff = this.dna.idealTemp - temp;
        
        if (abs(tempDiff)<this.dna.sensitivity) {
            this.age += dna.aging/1000;
            this.hp += 0.001*(1-this.age);
            
            Cell nb =  c.freeNb();
            if (nb != null) {
                Flower nF = this.clone();
                if (nF != null) {
                    nb.addFlower(nF);
                    nb.newF = true;
                }
            }
            
            
        } else{
            this.hp += -0.0005;
        }
        this.hp = constrain(this.hp, 0, this.dna.maxHp);
    }
    
    Flower clone() {
        if (this.hp > 2*this.dna.cloneCost*this.dna.maxHp) {
            this.hp *= 1-this.dna.cloneCost;
            return new Flower(this.mSize,this.dna.mutate());
        }
        return null;
    }
    
    boolean dead() { 
      return this.hp == 0;
    }
    
    void display(boolean uniClr) {
        noStroke();
        if(uniClr){
            fill(this.dna.uniqClr.r, this.dna.uniqClr.g, this.dna.uniqClr.b);

        }else{
           fill(this.dna.clr.r, this.dna.clr.g, this.dna.clr.b);
        }
        ellipse(this.x, this.y, this.mSize * this.hp / this.dna.maxHp, this.mSize * this.hp / this.dna.maxHp);

    }
}
