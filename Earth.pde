static class Earth{
  static List<Dna> dnas = new ArrayList<Dna>();
  static List<Color> clrs = new ArrayList<Color>();
static{
  clrs.add(new Color(230, 25, 75 ));  
  clrs.add(new Color(60, 180, 75 ));    clrs.add(new Color(255, 225, 25 ));    clrs.add(new Color(0, 130, 200 ));    clrs.add(new Color(245, 130, 48 ));    clrs.add(new Color(145, 30, 180 ));    clrs.add(new Color(70, 240, 240 ));    clrs.add(new Color(240, 50, 230 ));    clrs.add(new Color(210, 245, 60 ));    clrs.add(new Color(250, 190, 212 ));    clrs.add(new Color(0, 128, 128 ));    clrs.add(new Color(220, 190, 255 ));    clrs.add(new Color(170, 110, 40 ));    clrs.add(new Color(255, 250, 200 ));    clrs.add(new Color(128, 0, 0 ));    clrs.add(new Color(170, 255, 195 ));    clrs.add(new Color(128, 128, 0 ));    clrs.add(new Color(255, 215, 180 ));    clrs.add(new Color(0, 0, 128 ));    clrs.add(new Color(128, 128, 128 )); clrs.add(new Color(255, 255, 255 ));
} 
  static Color black = new Color(0, 0, 0 );
  static  String genomeCount(int minN){
     String ret = "======================================================\n";
     for(Dna dna: Earth.dnas){
      if(dna.numFlowers>minN)
          ret += dna+"\n";
      }
      ret += "======================================================\n";
      return ret;
   }
   
   static void assignUniqueClr(int minN){
     int lastUsedI = 0;
 
     for(int i = 0; i < dnas.size(); i++){
       Dna d = dnas.get(i);
        if(d.numFlowers>minN){
            d.uniqClr = clrs.get(lastUsedI);
            lastUsedI++;
            if(lastUsedI == clrs.size()){
              lastUsedI=0;
            }
        }else{
            d.uniqClr = black;
        }
      }
   }
}
