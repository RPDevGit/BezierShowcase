point dragpoint = null;
ArrayList points;

int radius = 10;

point la1;
point la2;

point lb1;
point lb2;

point op;

int i = 102;

cline linea;
cline lineb;
cline linec;

boolean draw = true;
boolean drawm = false;

int supn;

void setup() {
  size(800, 600);
  background(51);
  noStroke();
  frameRate(500);
  
 
  smooth();
  
  stroke(255);
  
  points = new ArrayList();
  
  points.add(new point(50, 50, radius)); //la1
  points.add(new point(100, 350, radius)); //la2
  
  points.add(new point(550, 550, radius)); //lb1
  points.add(new point(350, 50, radius)); //lb2
  
  linea = new cline(la1, la2);
  linec = new cline(la2, lb1);
  lineb = new cline(lb1, lb2);
  
  
  
}

void draw() {
  
  
  
  if(i >= 102){

    i = 0;
    clear();
    
    la1 = (point) points.get(0);
    la2 = (point) points.get(1);
    
    lb1 = (point) points.get(2);
    lb2 = (point) points.get(3);
    
    linea = new cline(la1, la2);
    linec = new cline(la2, lb1);
    lineb = new cline(lb1, lb2);
    
    stroke(255);
  
    linea.draw();
    linec.draw();
    lineb.draw();
    
    op = la1;
    
  }
 
  
  stroke(255);
  

  
  
  while(i <= 100 && draw == true){
    
    float cof = i / 100.0f;
    
    cline linema = new cline(linea.progress(cof), linec.progress(cof));
    cline linemb = new cline(linec.progress(cof), lineb.progress(cof));
    
    cline linemc = new cline(linema.progress(cof), linemb.progress(cof));
    
    point dp = linemc.progress(cof);
    
    stroke(255, 0, 0);
    drawline(op, dp);
    
    if(i == supn && drawm == true){
      
      stroke(0, 255, 0);
      
      linema.draw();
      linemb.draw();
      linemc.draw();
      
    }
    
    
    op = dp;
    i++;
    
  }
  
}


class point {
  public float x, y, r;
  point(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }
  void draw() {
    ellipse(x, y, r * 2f, r * 2f);
  }
  boolean contains(float x, float y) {
    float dx = this.x - x;
    float dy = this.y - y;
    return sqrt(dx * dx + dy * dy) <= r;
  }
}

class cline {
  
  public point a;
  public point b;
  
  cline (point ia, point ib){
   
    a = ia;
    b = ib;
    
  }
  
  
  point dist(){
    
     point dist = new point(aw(a.x - b.x), aw(a.y - b.y), radius );
     
     return dist;
    
  }
  
  point progress(float cof){
    
    int x;
    int y;
    
    if(a.x <= b.x){ x = int( a.x + this.dist().x * cof) ; } 
    else{ x = int( a.x - this.dist().x * cof) ; }
    
    if(a.y <= b.y){ y = int( a.y + this.dist().y * cof) ; } 
    else{ y = int( a.y - this.dist().y * cof) ; } 
    
    point progress = new point(x, y, radius);
    
    return progress;
    
  }
  
  
  
  point invprogress(float cof){
    
    int x;
    int y;
    
    if(a.x <= b.x){ x = int( b.x - this.dist().x * cof) ; } 
    else{ x = int( b.x + this.dist().x * cof) ; }
    
    if(a.y <= b.y){ y = int( b.y + this.dist().y * cof) ; } 
    else{ y = int( b.y - this.dist().y * cof) ; } 
    
    point progress = new point(x, y, radius);
    
    return progress;
    
  }
  
  void draw(){
    
    line(a.x, a.y, b.x, b.y );
    
  }
  
  
  
  
}




int aw(float input){
  
 float aw =  sqrt(pow(input, 2));
 int awr = (int) aw;
 
 return awr;
  
}

void drawline(point a, point b){
  
  line(a.x, a.y, b.x, b.y);
  
}

void drawtangent(point a, point b){
  
  PVector currentV = new PVector(a.x, a.y);
  PVector nextV = new PVector(b.x, b.y);
  PVector tangent = new PVector(nextV.y - currentV.y, currentV.x - nextV.x);
  tangent.normalize();
  tangent.mult(10);
  stroke(0, 0, 255);
  line(a.x -tangent.x, a.y - tangent.y, a.x + tangent.x, a.y + tangent.y);
  
}


void mouseReleased() {
  dragpoint = null;
  i = 102;
  draw = true;
  drawm = false;
}

void mousePressed() {
  //draw = false;
  
  
  
  dragpoint = null;
  point n;
  for (int i = 0; i < points.size(); i++) {
    n = (point) points.get(i);
    if (n.contains(mouseX, mouseY)) {
      dragpoint = n;
    }
  }
  
  if(dragpoint == null){
    
    drawm = true;
    supn = int(map(mouseX, 0, width, 0, 100));
    i = 102;
    
  }
}

void mouseDragged() {
  

  
  if (dragpoint != null) {
    
    drawm = false;
    
    if(i > 100){ i = 102; }

    dragpoint.x = mouseX;
    dragpoint.y = mouseY;
    
    stroke(51);
    
    clear();
  
    stroke(255);
  
    linea.draw();
    linec.draw();
    lineb.draw();
    
    
  }
  else{
    
    drawm = true;
    supn = int(map(mouseX, 0, width, 0, 100));
    i = 102;
    
  }
  
  


}
