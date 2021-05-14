import java.util.*;

List<Cell> cells = new ArrayList<Cell>();
List<Flower> flowers = new ArrayList<Flower>();

int w = 100;
int h = 72;
float[][] dna = {{1, 17, 10, 255, 255, 255} , {0.5,11, 10, 0, 0, 0} };
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
    
    for (int i = 0; i < width / 10 - 1; i++) {
        for (int j = 0; j < (height / 10) - 1; j++) {
            Cell a = cells.get(index[i][j]);
            Cell b = cells.get(index[i][j + 1]);
            a.nb.add(b);
            b.nb.add(a);
        }
    }
    
    for (int i = 0; i < height / 10 - 1; i++) {
        for (int j = 0; j < (width / 10) - 1; j++) {
            Cell a = cells.get(index[j][i]);
            Cell b = cells.get(index[j + 1][i]);
            a.nb.add(b);
            b.nb.add(a);
        }
    }
    
    for (int i = 10; i < height / 20 - 1; i++) {
        for (int j = 40; j < (width / 10) - 30; j++) {
            Cell c = cells.get(index[j][i]);
            c.mass = 50;
            c.temp = 10;
        }
    }
    
    for (int i = 0; i < 500; i++) { 
        int j = floor(random(cells.size()));
        Cell c = cells.get(j);
        
        int species = floor(random(2));
        Flower f = new Flower(dna[species]);
        while(!c.addFlower(f)) {
            j = floor(random(cells.size()));
            c = cells.get(j);
        }
        flowers.add(f);
    }
}

void mousePressed() {
    int x = constrain(mouseX / 10,0,w - 1);
    int y = constrain(mouseY / 10,0,h - 1);
    
    Cell c = cells.get(index[x][y]);
    if (c.f != null) {
        Flower f = c.f;
        print("Temp:",(int)c.temp, "  DNA:");
        for (int i = 0; i < c.f.dna.length; i++) {
            print(f.dna[i], "/");
        }
        println();
    } else{
        println("Temp:",(int)c.temp);
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
            f.display();
            
            if (f.dead()) {
                flowers.remove(i);        
            }
    }
}
