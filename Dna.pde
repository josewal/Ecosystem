 class Dna implements Comparable{
    float maxHp;
    float idealTemp;
    float sensitivity;
    Color clr;
    float aging;
    float cloneCost;
    String id;
    int numMutations  = 0;
    int numFlowers = 0;
    Color uniqClr;
    Dna parent;
    long age;
    
    
    Dna(String id, float  mph, float ag, float clC, float iT, float sens, Color clr, Color uniqClr) {
        this.maxHp = mph;
        this.idealTemp = iT;
        this.sensitivity = sens;
        this.clr  = clr;
        this.id = id;
        this.aging = ag;
        this.cloneCost = clC;
        this.uniqClr = uniqClr;
        Earth.dnas.add(this);
        this.age =  Earth.age;
    }
    
    Dna cloneDna(){
      String mid = id+"|"+(numMutations+1);
      Dna cloned =  new Dna(mid, maxHp, aging, cloneCost, idealTemp, sensitivity, clr, uniqClr);
      cloned.parent = this;
      return cloned;
    }
    
    
    Dna mutate() {
        Dna mutated = null;
        float rand = random(1);
        if (rand<0.001) {
           int gene = floor(rand*10000);
           float m = 2*(rand*10000 - gene) - 1;
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
                mutated.cloneCost = constrain(this.cloneCost + m*0.05, 0.01, 1);
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
              mutated.changeColor(constrain(this.clr.r + (int)(m * 200), 0, 255),clr.g,clr.b);
              break;
              case(6):
              mutated = this.cloneDna();
              mutated.changeColor(clr.r,constrain(this.clr.g + (int)(m * 200), 0, 255),clr.b);
              break;
              case(7):
              mutated = this.cloneDna();
              mutated.changeColor(clr.r,clr.g , constrain(this.clr.b + (int)(m * 200), 0, 255));
              break;
            }
        }

        if (mutated !=  null) {
          if(Earth.printNewM){
            println("NEW MUTATION: "+mutated);
          }
            ++this.numMutations;
            return mutated;
        }
        
        return this;
    }
    
    public void changeColor(int r, int g, int b){
      this.clr = new Color(r,g,b);
    }
    
    public String toString(){

      
      return  Earth.formatAgeString(age) + "  COUNT: "+ numFlowers
        + "\t||" + String.format("%.2f", maxHp)
        + "|" + String.format("%.2f", aging) 
        + "|" + String.format("%.2f", cloneCost) 
        + "|" + String.format("%.2f", idealTemp) 
        + "|" + String.format("%.2f", sensitivity) 
        + "|"+ String.format("%.2f", clr.therm )+ "||"  + "\t" +id;
    }
    
    void printGenesisHist(){
      Dna c = this;
      int l = 0;
      println();
      print("==============================================================================\n");
      while(c!=null){
        for(int i=0; i<l;i++)print(" ");
        println(c);        
        c = c.parent;
        ++l;
      }
      println("==============================================================================\n");
    }
    
    public int compareTo(Object o){
      if(o instanceof Dna){
        Dna d = (Dna) o;
        long diff = (this.age - d.age);
        if(diff==0) return 0;
        if(diff>0) return 1;
        if(diff<0) return -1;
      }
      return -1;
    }
    
      
}
