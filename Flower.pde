class Flower{
    float x;
    float y;
    List<Cell> myGrass = new ArrayList<Cell>();
    
    int[] clr = new int[3];
    float[] dna;
    
    float hp;
    float maxHp;
    float idealTemp;
    float sensitivity;
    
    
    Flower(float[] dna) {
        // this.maxHp = 1.5
        // this.idealTemp = 18;
        // this.sensitivity = 6;
        // this.clr[1] = 255;
        // this.clr[2] = 255;
        // this.clr[0] = 255;
        
        this.dna = dna;
        
        this.maxHp = dna[0];
        this.idealTemp = dna[1];
        this.sensitivity = dna[2];
        this.clr[0] = (int)dna[3];
        this.clr[1] = (int)dna[4];
        this.clr[2] = (int)dna[5];
        
        this.hp = maxHp / 2;
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
                    this.hp /= 4;
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
        if (this.hp > 0.6*this.maxHp) {
            return new Flower(this.mutate());
        }
        return null;
    }

    float[] mutate(){
      float[] dna = new float[6];
      for(int i = 0; i < dna.length; i++){
        dna[i] += this.dna[i];
      }
      
      if(random(1)<0.001){
        dna[0] = this.dna[0] + (random(1)-0.5)*0.1;
      }
      if(random(1)<0.001){
        dna[1] = this.dna[1] + (random(1)-0.5)*1;
      }
      if(random(1)<0.001){
        dna[2] = this.dna[2] + (random(1)-0.5)*1;
      }
      if(random(1)<0.0001){
        dna[3] = constrain(this.dna[3] + (random(1)-0.5)*200, 0, 255);
      }
      if(random(1)<0.0001){
        dna[4] = constrain(this.dna[4] + (random(1)-0.5)*200, 0, 255);
      }
      if(random(1)<0.001){
        dna[5] = constrain(this.dna[5] + (random(1)-0.5)*200, 0, 255);
      }
 
      return dna;
    }
    
    boolean dead() {
        return this.hp == 0;
    }
    
    void display() {
        strokeWeight(1);
        fill(clr[0], clr[1], clr[2]);
        ellipse(this.x, this.y, 10 * this.hp / this.maxHp, 10 * this.hp / this.maxHp);
    }
}
