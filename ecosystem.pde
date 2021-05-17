import java.util.*;
import java.text.*;

List<Cell> cells = new ArrayList<Cell>();
private List<Flower> flowers = new ArrayList<Flower>();
  
long   shotInt = 10800;
int NUM_FLOWERS = 300;
int w = 150;
int h = 70;
int r = 10;

static{ 
  Earth.minCool = -2;
  Earth.maxCool = 2;
}
float increment = 0.04;
float detail = 0.5;

Color wh = new Color(220,220,220);
Color bl = new Color(100,100,100);

Dna white = new Dna("A", 0.5 , 0.5, 0.1,  25,  10 , wh, wh);
//Dna black = new Dna("B", 2   , 0.1, 0.25, 12, 17, bl, bl);
 Dna black = white;
boolean uniqColor = false;
boolean dispCooling = false;
boolean dispFlowers = true;

public void settings() {
    size(w * r, h * r);
}

int[][] index = new int[w][h];

void setup() {
    int n = 0;
    for (int i = 0; i < width; i += r) {
        for (int j = 0; j < height; j += r) {
            cells.add(new Cell(i,j,r));
            index[(i / r)][(j / r)] = n;
            n++; 
        }
    }
    
    for (int i = 0; i < width / r; i++) {
        for (int j = 0; j < (height / r) - 1; j++) {
            Cell a = cells.get(index[i][j]);
            Cell b = cells.get(index[i][j + 1]);
            a.nb.add(b);
            b.nb.add(a);
        }
    }
    
    for (int i = 0; i < height / r; i++) {
        for (int j = 0; j < (width / r) - 1; j++) {
            Cell a = cells.get(index[j][i]);
            Cell b = cells.get(index[j + 1][i]);
            a.nb.add(b);
            b.nb.add(a);
        }
    }
    

    
    //for (int i = 3*h/4; i < h; i++) {
    //    for (int j = 3*w/4; j < w; j++) {
    //        Cell c = cells.get(index[j][i]);
    //        c.cooling = 3;
    //    }
    //}
    
    float xoff = 0.0; // Start xoff at 0
    noiseDetail(8, detail);
  
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < w; x++) {
    xoff += increment;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < h; y++) {
      yoff += increment; // Increment yoff
      
      // Calculate noise and scale by 255
      float nn = noise(xoff, yoff);
      float cool = map(nn,0,1,Earth.minCool,Earth.maxCool);
      Cell c = cells.get(index[x][y]);
      c.cooling = cool;
      //println(cool);
  }
  }
    
    //    for (int i = 0; i < h/4; i++) {
    //    for (int j = 0; j < w/4; j++) {
    //        Cell c = cells.get(index[j][i]);
    //        c.cooling = -3;
    //    }
    //}
    
    for (int i = 0; i < NUM_FLOWERS; i++) { 
        int j = floor(random(cells.size()));
        Cell c = cells.get(j);
        
        Flower f = null;
        switch(floor(random(2))) {
            case 0:{
                f = new Flower(r,white);
                break;
            }
            case 1:{
                f = new Flower(r,black);
                break;
            }
            default:{}
            }
            if(f != null){
              while(!c.addFlower(f)) {
                  j = floor(random(cells.size()));
                  c = cells.get(j);
              }
              flowers.add(f);
            }
        }
    }
    
    void mousePressed() {
        int x = constrain(mouseX / r,0,w - 1);
        int y = constrain(mouseY / r,0,h - 1);
        
        Cell c = cells.get(index[x][y]);
        if (c.f != null && keyPressed && keyCode == SHIFT){
          c.f.dna.printGenesisHist();
        }else if (c.f != null) {
            print("Temp:",(int) c.getTemp(), "  DNA:", c.f.dna.toString());
            println();
        }else if(c.f == null){
            println("Temperature:",c.getTemp());
        }
    }
    
    int s = 1;
    void keyPressed() {
        if (keyCode == UP) {
            s = constrain(s *= 2, 1, 33000);
            println("**Rendering  every " + s + " frames.");
        } else if (keyCode == DOWN) {
            s = constrain(s /= 2, 1, 33000);
            println("**Rendering  every " + s  + " frames.");
         }else if (keyCode == 'C'){
            print(Earth.genomeCount(0));
        } else if (keyCode == 'V'){
            print(Earth.genomeCount(50));
            } else if (keyCode == 'B'){
              if(Earth.printNewM){
                Earth.printNewM = false;
                println("Printing new mutations: OFF");
            }else{
                  Earth.printNewM = true;
                println("Printing new mutations: ON");
            }
        }else if(keyCode == 'M'){
          if(uniqColor){
            uniqColor = false;
            println("Genome map: OFF");
          }else{
            Earth.assignUniqueClr(5);
            uniqColor = true;
            println("Genome map: ON");

          }
        }else if(keyCode == 'N'){
          if(dispCooling){
            dispCooling = false;
            println("Cooling map: OFF");

          }else{
            dispCooling = true;
                        println("Cooling map: ON");

          }
         }else if(keyCode == 'F'){
            if(dispFlowers){
            dispFlowers = false;
            println("Dispm FLOWERS: OFF");

          }else{
            dispFlowers = true;
            println("Dispm FLOWERS: ON");

          }
        }        
    }
    
    
    
    void draw() {
      for(int d = 0; d <= s; d++){
        //close when all dead
        //if(flowers.isEmpty())System.exit(0);
        
        Earth.age++;
        
        if( Earth.age % shotInt == 0){
          screenShot();
        }
        
        if (d == 0) {
            background(51);
        }
        for (int i = cells.size() - 1; i >= 0; i--) {
            Cell c = cells.get(i);
            c.update();
            if (d == 0) {
                c.display(dispCooling);
            }

            if (c.newF) {
                flowers.add(c.f);
                c.newF = false;
            }
        }
        
   
        for (int i = flowers.size() - 1; i >= 0; i--) {
            Flower f = flowers.get(i);

            f.update();
            if (d == 0 && dispFlowers) {
                f.display(uniqColor);
            }
            if (f.dead()) {
                --f.dna.numFlowers;
                flowers.remove(i);       
            }
        }
    }
    }
    
    void screenShot(){
     save("ecosys_" + Earth.formatAgeString(Earth.age) + ".jpg");
   }
   
