static class Earth{
  static List<Dna> dnas = new ArrayList<Dna>();
  static  String genomeCount(){
     String ret = "======================================================\n";
     for(Dna dna: Earth.dnas){
      if(dna.numFlowers>50)
          ret += dna+"\n";
      }
      ret += "======================================================\n";
      return ret;
   }
}
