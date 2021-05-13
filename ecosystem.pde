import java.util.*;

List<Cell> cells = new ArrayList<Cell>();
List<Flower> flowers = new ArrayList<Flower>();

int w = 100;
int h = 72;

boolean debug = true;

public void settings() {
    size(w * 10, h * 10);
}

int[][] index = new int[w][h];

void setup() {
    int n = 0;
    for (int i = 0; i < width; i += 10) {
        for (int j = 0; j < height; j += 10) {
            cells.add(new Cell(i,j,10));
            index[(i / 10)][(j / 10)] = n;
            n++; 
        }
    }
    
    for (int i = 0; i < width/20; i++) {
              for (int j = 0; j < height/20; j++) {
                Cell c = cells.get(index[i][j]);
                c.temp = 25;
              }
    }


    for (int i = 0; i < width/10 - 1; i++){
        for (int j = 0; j < (height/10) - 1; j++){
            Cell a = cells.get(index[i][j]);
            Cell b = cells.get(index[i][j+1]);
            a.nb.add(b);
            b.nb.add(a);
        }
    }

    for (int i = 0; i < height/10 - 1; i++){
        for (int j = 0; j < (width/10) - 1; j++){
            Cell a = cells.get(index[j][i]);
            Cell b = cells.get(index[j+1][i]);
            a.nb.add(b);
            b.nb.add(a);
        }
    }
    
    for (int i = 0; i < 1000; i++) { 
        int j = floor(random(cells.size()));
        Cell c = cells.get(j);
        
        int clr = ceil(random(2));
        Flower f = new Flower(clr);
        while(!c.addFlower(f)) {
            j = floor(random(cells.size()));
            c = cells.get(j);
        }
        flowers.add(f);
    }
}



void draw() {
    background(51);
    float avgTemp = 0;
    for (int i = cells.size() - 1; i >= 0; i--) {
        Cell c = cells.get(i);
        c.update();
        avgTemp += c.temp;
        c.display();
        if(c.newF){
          flowers.add(c.f);
          c.newF = false;
        }
    }
    
    avgTemp /= cells.size();
    println(flowers.size(), avgTemp);
   
    
    for (int i = flowers.size() - 1; i >= 0; i--) {
        Flower f = flowers.get(i);
        f.update();
        f.display();
        
        if (f.dead()) {
            flowers.remove(i);        
        }
    }
}
