import java.util.*;

List<Cell> cells = new ArrayList<Cell>();
private List<Flower> flowers = new ArrayList<Flower>();
  

int w = 100;
int h = 64;
int r = 10;

Dna white = new Dna("A", 1 ,1, 0.6,  25,  13  , 255, 255, 255);
Dna black = new Dna("B", 0.5, 0.1, 0.6, 12, 11, 0, 0 ,0);
boolean debug = true;

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
    
    for (int i = 0; i < h/5; i++) {
        for (int j = 0; j < w/5; j++) {
            Cell c = cells.get(index[j][i]);
            c.cooling = -1.5;
        }
    }
    
    //float xoff = 0.0; // Start xoff at 0
  //  float detail = 0.5;
  //  noiseDetail(8, detail);
  //  float increment = 0.02;
  
  //// For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  //for (int x = 0; x < w; x++) {
  //  xoff += increment;   // Increment xoff 
  //  float yoff = 0.0;   // For every xoff, start yoff at 0
  //  for (int y = 0; y < h; y++) {
  //    yoff += increment; // Increment yoff
      
  //    // Calculate noise and scale by 255
  //    float mass = noise(xoff, yoff) * 10;
  //    Cell c = cells.get(index[x][y]);
  //    c.mass = mass;
  //    c.alpha = (int)(255-255*mass/10);
  //    c.temp = 20;
  //}
  //}
    
    for (int i = 0; i < 500; i++) { 
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
            print("Temp:",(int)c.temp, "  DNA:", c.f.dna.toString());
            println();
        }else if(c.f == null){
            println("Temp:",(int)c.temp);
        }
    }
    
    int s = 0;
    int d = 0;
    void keyPressed() {
        if (keyCode == UP) {
            s = constrain(s += 5, 0, 100000);
            println(s);
        } else if (keyCode == DOWN) {
            s = constrain(s -= 5, 0, 100000);
            println(s);
        } else if (keyCode == ENTER){
            print(Earth.genomeCount());
        }
    }
    
    
    
    void draw() {
        if (d >= s) {
            background(51);
        }
        float avgTemp = 0;
        for (int i = cells.size() - 1; i >= 0; i--) {
            Cell c = cells.get(i);
            c.update();
            avgTemp += c.temp;
            if (d >= s) {
                c.display();
            }

            if (c.newF) {
                flowers.add(c.f);
                c.newF = false;
            }
        }
        
        avgTemp /= cells.size();
        //println(flowers.size(), avgTemp);
        
        for (int i = flowers.size() - 1; i >= 0; i--) {
            Flower f = flowers.get(i);

            f.update();
            if (d >= s) {
                f.display();
            }
            if (f.dead()) {
                --f.dna.numFlowers;
                flowers.remove(i);       
            }
        }
        
        if (d >= s) {
            d = 0;
        } else{
            d++;
        }
    }
    
