static class Earth{
  static boolean printNewM = false;
  static float minCool, maxCool;
  static long age = 0;
  
  static float TEMP_CONST = 3; 
  static float MIN_TEMP;
  static {
    MIN_TEMP  = TEMP_CONST*-29.9336062089;
  }
  static float getTemp(float cal){

    if(cal<=0.0000000000001){
      return MIN_TEMP;
    }
    return TEMP_CONST*log(cal);
  }
  
  static Set<Dna> dnas = 
    Collections.newSetFromMap(
        new WeakHashMap<Dna, Boolean>()
    );
    
  static List<Color> clrs = new ArrayList<Color>();
static{
  clrs.add(new Color(230, 25, 75 ));  
  clrs.add(new Color(60, 180, 75 ));    clrs.add(new Color(255, 225, 25 ));    clrs.add(new Color(0, 130, 200 ));    clrs.add(new Color(245, 130, 48 ));    clrs.add(new Color(145, 30, 180 ));    clrs.add(new Color(70, 240, 240 ));    clrs.add(new Color(240, 50, 230 ));    clrs.add(new Color(210, 245, 60 ));    clrs.add(new Color(250, 190, 212 ));    clrs.add(new Color(0, 128, 128 ));    clrs.add(new Color(220, 190, 255 ));    clrs.add(new Color(170, 110, 40 ));    clrs.add(new Color(255, 250, 200 ));    clrs.add(new Color(128, 0, 0 ));    clrs.add(new Color(170, 255, 195 ));    clrs.add(new Color(128, 128, 0 ));    clrs.add(new Color(255, 215, 180 ));    clrs.add(new Color(0, 0, 128 ));    clrs.add(new Color(128, 128, 128 )); clrs.add(new Color(255, 255, 255 ));
} 
  static Color black = new Color(0, 0, 0 );
  static SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH-mm");
  static String formatAgeString(long a){
      Date dt = new Date(1000*a);
      return simpleDateFormat.format(dt);
  }
  static List<Dna> getSortedDnas(){
         List<Dna> sortedDnas = new ArrayList<Dna>();
     Iterator<Dna> it =  dnas.iterator();
     while(it.hasNext()){
       sortedDnas.add(it.next());
     }
    Collections.sort(sortedDnas);  
    return sortedDnas;
  }
  
  static  String genomeCount(int minN){
     String ret = "================================= "+  Earth.formatAgeString(Earth.age)+" =================================\n";
 
     for(Dna dna: getSortedDnas()){
      if(dna.numFlowers>minN)
          ret += dna+"\n";
      }
      ret += "====================================================================================\n";
      return ret;
   }
   
   static void assignUniqueClr(int minN){
     int lastUsedI = 0;
 
     List<Dna> sortedDnas = getSortedDnas(); 
    
     for(int i = 0; i < sortedDnas.size(); i++){
       Dna d = sortedDnas.get(i);
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
