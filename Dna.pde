class Dna{
    float maxHp;
    float idealTemp;
    float sensitivity;
    int clr[] = new int[3];
    float aging;
    float cloneCost;
    String id;
    int numMutations  = 0;
    int numFlowers = 0;
    Dna parent;
    
    
    Dna(String id, float  mph, float ag, float clC, float iT, float sens, int r, int g, int b) {
        this.maxHp = mph;
        this.idealTemp = iT;
        this.sensitivity = sens;
        this.clr[0] = r;
        this.clr[1] = g;
        this.clr[2] = b;
        this.id = id;
        this.aging = ag;
        this.cloneCost = clC;
        
        Earth.dnas.add(this);
    }
    
    Dna cloneDna(){
      String mid = id+"|"+(numMutations+1);
      Dna cloned =  new Dna(mid, maxHp, aging, cloneCost, idealTemp, sensitivity, clr[0], clr[1], clr[2]);
      cloned.parent = this;
      return cloned;
    }
    
    
    Dna mutate() {
        Dna mutated = null;
        float rand = random(1);
        if (rand<0.001) {
           int gene = floor(rand*10000);
           float m = 2*(rand*10000 - gene) - 1;
           println(gene,m);
            switch(gene){
              case(0):
                mutated = this.cloneDna();
                mutated.maxHp = constrain(this.maxHp + m*0.1, 0.01, 10);
              break;
              case(1):
              mutated = this.cloneDna();
                mutated.aging = constrain(this.aging + m*0.5, 0.01, 10);
              break;
              case(2):
              mutated = this.cloneDna();
                mutated.cloneCost = constrain(this.cloneCost + m*0.1, 0.01, 2);
              break;
              case(3):
              mutated = this.cloneDna();
                mutated.idealTemp = this.idealTemp + m*3;
              break;
              case(4):
              mutated = this.cloneDna();
                mutated.sensitivity = this.sensitivity + m*1;
              break;
              case(5):
              mutated = this.cloneDna();
                mutated.clr[0] = constrain(this.clr[0] + (int)(m * 200), 0, 255);
              break;
              case(6):
              mutated = this.cloneDna();
                mutated.clr[1] = constrain(this.clr[1] + (int)(m * 200), 0, 255);
              break;
              case(7):
              mutated = this.cloneDna();
                mutated.clr[2] = constrain(this.clr[2] + (int)(m * 200), 0, 255);
              break;
            }
        }

        if (mutated !=  null) {
            println("NEW MUTATION: "+mutated);
            ++this.numMutations;
            return mutated;
        }
        
        return this;
    }
    
    public String toString(){
      return  numFlowers+ "\t" +id
        + "\t\t||" + String.format("%.2f", maxHp)
        + "|" + String.format("%.2f", aging) 
        + "|" + String.format("%.2f", cloneCost) 
        + "|" + String.format("%.2f", idealTemp) 
        + "|" + String.format("%.2f", sensitivity) 
        + "|"+ String.format("%.2f", ((float)(this.clr[0] + this.clr[1] + this.clr[2]) / 765f)) +"||"  ;
    }
    
    void printGenesisHist(){
      Dna c = this;
      int l = 0;
      while(c!=null){
        for(int i=0; i<l;i++)print(" ");
        println(c);        
        c = c.parent;
        ++l;
      }
    }
}
