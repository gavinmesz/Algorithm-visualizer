//ANY REFERENCE MADE TO GUZY IS JUST THE PLAYER (line 13)
int screen=0;
boolean up; // movement stuff
boolean down;
boolean right;
boolean left;
PImage menu;
boolean next=false;
ArrayList<sortbloc> dudes = new ArrayList<sortbloc>(); //bubble sort arraylist
ArrayList<sortbloc> select = new ArrayList<sortbloc>(); //selection sort arraylist
button start;
particle[] stars=new particle[200]; //background stars
player guzy= new player((width/2), (height/2));
PFont sans; //comc sans :)
PImage bubblesort;
PImage selectionsort;
int sizeofarray=10;
int len=sizeofarray;
boolean bubon=false; // booleans to tell if the player is on or off a certain zone
boolean selon=false; // without, you could click a button without a screen being on the page
boolean seton=false;
boolean lowpower=false; //low power mode boolean

class wall { //player collides into the wall and can't go through. seen on main page and sorting pages
  int x, y, sx, sy;
  wall(int x, int y, int sx, int sy) {
    this.x=x;
    this.y=y;
    this.sx=sx;
    this.sy=sy;
  }

  void render() { //guzy COLLISIONS
    fill(0);
    stroke(255);
    line(this.x, this.y, this.x+this.sx, this.y);
    line(this.x, this.y, this.x, this.y+this.sy);
    line(this.x, this.y+this.sy, this.x+this.sx, this.y+this.sy);
    line(this.x+this.sx, this.y, this.x+sx, this.y+sy);
    if (collide()) {
      if (guzy.x<this.x+this.sx&&guzy.x>this.x+this.sx-5) {
        guzy.x=this.x+this.sx;
      } else if (guzy.x+guzy.size>this.x&&guzy.x+guzy.size<this.x+10) {
        guzy.x=this.x-guzy.size;
      }
      if (guzy.y<this.y+this.sy&&guzy.y>this.y+this.sy-5) {
        guzy.y=this.y+this.sy;
      } else if (guzy.y+guzy.size>this.y&&guzy.y+guzy.size<this.y+10) {
        guzy.y=this.y-guzy.size;
      }
    }
  }

  boolean collide() {
    boolean x=false; 
    if (guzy.x<this.x+this.sx&&guzy.x+guzy.size>this.x&&guzy.y+guzy.size>this.y&&guzy.y<this.y+this.sy) {
      x=true;
    }
    return x;
  }
}

//Any moving part mother class
class Mover {
  float x, y, sx, sy;
  Mover(float x, float y) {
    this.x=x;
    this.y=y;
  }

  void move() {
    this.x+=this.sx;
    this.y+=this.sy;
  }
}

class player extends Mover { //speaks for itself, controls the player
  int size;
  player(int x, int y) {
    super(x, y);
    this.sx=0;
    this.sy=0;
    this.size=20;
  }

  void render() {
    fill(255);
    rect(this.x, this.y, this.size, this.size);
    sy=0;
    sx=0;
    if (up) sy=-3;
    if (down) sy=3;
    if (left) sx=-3;
    if (right) sx=3;
    this.move();
    if (this.x>width-this.size) {
      this.x=width-this.size;
    } else if (this.x<0) {
      this.x=0;
    }
    if (this.y>height-this.size) {
      this.y=height-this.size;
    } else if (this.y<0) {
      this.y=0;
    }
  }
}

class particle extends Mover { //for the stars in the background. size relative to speed
  float sizex, sizey;
  particle(float x, float y) {
    super(x, y);
    this.sx=random(-1, -0.2);
    this.sizex=this.sx * 5;
    this.sizey=this.sx * 5;
  }

  void render() {
    fill(floor(random(255)), floor(random(255)), floor(random(255)));
    rect(this.x, this.y, this.sizex, this.sizey);
    this.move();
    if (this.x<=-7) {
      this.x=width+1;
      this.y=random(height);
    }
  }
}

//ALGORITHM BLOCKS
class sortbloc { //blocks that move in the sorting algorithms. Carries value and position
  int x, y, h, b, r, val, g, blu, sx, target;
  sortbloc(int x, int y, int h, int val, int target) {
    this.x=x;
    this.y=y;
    this.b=25;
    this.h=h;
    this.r=255;
    this.g=255;
    this.blu=255;
    this.val=val;
    this.sx=0;
    this.target=target;
  }

  void render() {
    this.x+=this.sx;
    fill(this.r, this.g, this.blu);
    rect(this.x, this.y, this.b, this.h);
    text(this.val, this.x+this.b/2 - (textWidth(str(this.val))/2), this.y+this.h+20);
    this.home();
  }

  void home() { //targets a spot and moves to it.
    if (this.x==this.target) {
      this.sx=0;
    }
    if (this.x<this.target) {
      this.sx=1;
    } else if (this.x>this.target) {
      this.sx=-1;
    }
  }
}


//given an array, can spit out new array with randomized numbers.
ArrayList<sortbloc> randosort(ArrayList<sortbloc> x) {
  for (int i=0; i<x.size(); i++) {
    x.get(i).val=floor(random(1, 10));
  }
  return x;
}

//Any clickable button
class button {
  int x, y, r, g, blu;
  int b, h;
  String text;
  int ts;
  button(int x, int y, int h, String text, int ts, int r, int g, int blu) {
    this.x=x;
    this.y=y;
    this.h=h;
    this.text=text;
    this.ts=ts;
    this.r=r;
    this.g=g;
    this.blu=blu;
    this.b=floor(textWidth(this.text))+100;
  }

  void render() {
    stroke(255);
    fill(this.r, this.g, this.blu);
    rect(this.x, this.y, this.b, this.h);
    stroke(0);
    textSize(this.ts);
    fill(255);
    text(this.text, this.x+(this.b/2)-(textWidth(this.text)/2), this.y + this.h/2+(this.ts/4));
  }

  void rendy() { // no stroke
    stroke(0);
    fill(this.r, this.g, this.blu);
    rect(this.x, this.y, this.b, this.h);
    stroke(0);
    textSize(this.ts);
    fill(255);
    text(this.text, this.x+(this.b/2)-(textWidth(this.text)/2), this.y + this.h/2+(this.ts/4));
  }

  boolean isOn() { //checks if the mosue is on the button.
    boolean bruh=false;
    if (mouseX>this.x&&mouseX<this.x+this.b&&mouseY>this.y&&mouseY<this.y+this.h) {
      bruh=true;
    }
    return bruh;
  }
}

class numberpicker { //pop-up asking how many numbers you want in the sorting array.
  int x, y;
  button up, down, okay;
  numberpicker(int x, int y) {
    this.x=x;
    this.y=y;
    up = new button(this.x+20, this.y+500-70, 50, " + ", 32, 0, 0, 0);
    down =  new button(this.x+470+floor(textWidth(" - ")/2)-105, this.y+500-70, 50, " - ", 32, 0, 0, 0);
    okay = new button(this.x+250-floor(textWidth("Okay")/2)-50, this.y+500-70, 50, "Okay", 32, 0, 0, 0);
  }

  void render() {
    fill(0);
    stroke(255);
    rect(this.x, this.y, 500, 500);
    textSize(32);
    fill(255);
    text("How many numbers in the array?", this.x+250-textWidth("How many numbers in the array?")/2, this.y+200);
    fill(0);
    up.render();
    down.render();
    okay.render();
    text(sizeofarray, this.x+250-textWidth(str(sizeofarray))/2, this.y+300);
  }
}

class setting { //pop-up for the settings options. By that I mean low power mode.
  int x, y;
  button yeorno;
  setting(int x, int y) {
    this.x=x;
    this.y=y;
    yeorno=new button(this.x+250-(floor((textWidth("YES")+100)/2)), this.y+300, 50, "NO", 32, 0, 0, 0);
  }

  void render() {
    fill(0);
    stroke(255);
    rect(this.x, this.y, 500, 500);
    yeorno.render();
    textSize(32);
    fill(255);
    text("LOW POWER MODE", this.x+250-textWidth("LOW POWER MODE")/2, this.y+200);
    if (lowpower==false) {
      yeorno.r=255;
      yeorno.g=0;
      yeorno.blu=0;
      yeorno.text="NO";
    } else if (lowpower==true) {
      yeorno.r=0;
      yeorno.g=255;
      yeorno.blu=0;
      yeorno.text="YES";
    }
  }
}

wall great;//these four walls are for the main screen with the "+" configuration
wall wall;
wall of;
wall china;
wall selection;//these four are for the walls where is u collide into them, you
wall bubble;// get transferred into another screen
wall menny;
wall settings;
wall edger; //these two are for the walls in the sorting screens.
wall edgel;
button moveins; //move instructions text
numberpicker bubb; //the way to increase of decrease the amount of numbers in the sorting array
setting lpm; //low power mode


void setup() { //initializing everything
  fullScreen();
  smooth();
  bubb = new numberpicker((width/2)-250, (height/2)-250);
  bubblesort=loadImage("bubsortpic.png");
  selectionsort=loadImage("sel.png");
  sans=createFont("Comic Sans MS", 40);
  for (int i=0; i<stars.length; i++) stars[i]=new particle(random(width), random(height));
  menu = loadImage("forp.png");
  start=new button((width/2), (height/2)+70, 50, "Start it up", 28, 0, 0, 0);
  textSize(28);
  start.x=(width/2)-(floor(textWidth(start.text)+50)/2);
  textSize(12);
  great = new wall(-1, -1, (width/2)-99, (height/2)-99);
  wall=new wall((width/2)+100, -1, (width/2)+101, (height/2)-99);
  of =new wall(-1, (height/2)+100, (width/2)-99, (height/2)-99);
  china = new wall((width/2)+100, (height/2)+100, (width/2)+101, (height/2)-99);
  bubble = new wall(-10, (height/2)-100, 11, 200);
  selection=new wall(width-1, (height/2)-100, 10, 200);
  menny = new wall(300, height-1, floor(dist(300, height-1, width-300, height-1)), 10);
  settings = new wall((width/2)-100, 1, 200, 10);
  moveins=new button(200, 100, 100, "    Move Instructions:\n(WASD type movement)", 30, 0, 0, 0);
  edgel=new wall(-1, -1, 300, height+1);
  edger=new wall((width-300), -1, 300, height+1);
  guzy.x=(width/2)-(guzy.size)/2;
  guzy.y=(height/2)-(guzy.size)/2;
  lpm=new setting ((width/2)-250, (height/2)-250);
}

/////////////////////////
/////////////////////////
/////////////////////////
//MAIN PROGRAM///////////
/////////////////////////
/////////////////////////
/////////////////////////

void draw() {
  fill(0);
  rect(0, 0, width, height);
  stroke(0);

  if (sizeofarray>=21) { //array can't go past 20 or 4.
    sizeofarray=20;
  }
  if (sizeofarray<=3) {
    sizeofarray=4;
  }

  if (screen==0) { //MAIN SCREEN
    fill(0);
    rect(0, 0, width, height);
    if (lowpower==false) { //low power mode turns off stars
      for (int i=0; i<stars.length; i++) stars[i].render();
    }
    image(menu, width/2-621/2, height/2-66/2); //sorting sim deluxe sign
    start.render();
  }

  if (screen==1) { // PLAYER SCREEN
    if (lowpower==false) {
      for (int i=0; i<stars.length; i++) stars[i].render();
    }

    if (dudes.size()>0) { //removes all blocks in bubble sort array if there is blocks
      for (int i = dudes.size() - 1; i >= 0; i--) {
        dudes.remove(i);
      }
    }
    if (select.size()>0) { //removes all blocks in selection sort array if there is blocks
      for (int i = select.size() - 1; i >= 0; i--) {
        select.remove(i);
      }
    }

    len=sizeofarray;
    fill(0); //aesthetic stuff for main page and instructions.
    rect(-1, (height/2)-100, width+1, 200);
    rect((width/2)-100, -1, 200, height+1);
    fill(255, 70);
    textFont(sans);
    textSize(40);
    text("<-- BUBBLE SORT", 100, (height/2)+20);
    text("SELECTION SORT -->", width-100-textWidth("SELECTION SORT -->"), (height/2)+20);
    text("MENU", (width/2)-(textWidth("MENU")/2), height-100);
    textSize(32);
    text("SETTINGS", (width/2)-(textWidth("SETTINGS")/2), 140);
    textSize(40);
    fill(255, 100);
    guzy.render();
    great.render();
    wall.render();
    of.render();
    china.render();
    stt=0;
    oldbestnum=0;
    if (bubble.collide()) { //bubble sort stuff, if the player hits the bubble sort wall
      //the numberpicker shows up and asks how many numbers you
      //want in the sorting array.
      bubon=true;
      bubb.render();
      if (next==true) {
        int temp=0;
        for (int i=0; i<sizeofarray; i++) { //creates array with specified amount of numbers.
          dudes.add(new sortbloc((width/2)-(((sizeofarray*30)/2)-30)+temp, (height/2)+50, 10, floor(random(1, 10)), 0));
          temp+=dudes.get(i).b+5;
          dudes.get(i).h=dudes.get(i).val*10;
          dudes.get(i).y=dudes.get(i).y-dudes.get(i).h;
          dudes.get(i).x-=dudes.get(i).b+5;
          dudes.get(i).target=dudes.get(i).x;
        }
        screen=2;
        guzy.x=width/2-10;
        guzy.y=height/2+300;
      }
      next=false;
    } else if (selection.collide()) { //same for selection sort as bubble sort.
      selon=true;
      bubb.render();
      if (next==true) {
        int temp=0;
        for (int i=0; i<sizeofarray; i++) { //creates array with specified amount of numbers.
          select.add(new sortbloc((width/2)-(((sizeofarray*30)/2)-30)+temp, (height/2)+50, 10, floor(random(1, 10)), 0));
          temp+=select.get(i).b+5;
          select.get(i).h=select.get(i).val*10;
          select.get(i).y=select.get(i).y-select.get(i).h;
          select.get(i).x-=select.get(i).b+5;
          select.get(i).target=select.get(i).x;
        }
        screen=3;
        guzy.x=width/2-10;
        guzy.y=height/2+300;
      }
      next=false;
    } else if (menny.collide()) { //menu wall brings user back to main screen
      screen=0;
      down=false;
    } else if (settings.collide()) { //settings wall pulls up settings
      lpm.render();
      seton=true;
    } else { //returns any boolean on true to false.
      seton=false;
      bubon=false;
      selon=false;
    }
    moveins.rendy();
  }

  if (screen==2) { /////BUBBLE SORT SCREEN
    textSize(12);
    if (lowpower==false) {
      for (int i=0; i<stars.length; i++) stars[i].render();
    }
    fill(0);
    rect(300, 0, dist(300, 0, width-300, 0), height);

    guzy.render();
    if (menny.collide()) {
      screen=1;
      guzy.x=(width/2)-10;
      guzy.y=(height/2)-10;
    }

    for (int i=0; i<dudes.size(); i++) { //render the array blocks
      dudes.get(i).render();
    }
    image(bubblesort, (width/2)-(width/8), 100, width/4, 100); //aesthetics.
    textSize(26);
    fill(255);
    text("(Click to go through 1 run)", (width/2)-(textWidth("(Click to go through 1 run)")/2), 250);
    edger.render();
    edgel.render();
    fill(255, 70);
    textSize(40);
    text("MENU", (width/2)-(textWidth("MENU")/2), height-100);
    stroke(0);
  }

  if (screen==3) { //SELECTION SORT SCREEN
    textSize(12);
    if (lowpower==false) {
      for (int i=0; i<stars.length; i++) stars[i].render();
    }
    fill(0);
    rect(300, 0, dist(300, 0, width-300, 0), height);

    for (int i=0; i<select.size(); i++) { //renders blocks in sorting array.
      select.get(i).render();
    }

    guzy.render();
    if (menny.collide()) {
      screen=1;
      guzy.x=(width/2)-10;
      guzy.y=(height/2)-10;
    }
    image(selectionsort, (width/2)-(width/4), 100, width/2, 100);//aesthetics.
    textSize(26);
    fill(255);
    text("(Click to go through 1 run)", (width/2)-(textWidth("(Click to go through 1 run)")/2), 250);
    edger.render();
    edgel.render();
    textSize(40);
    fill(255, 70);
    text("MENU", (width/2)-(textWidth("MENU")/2), height-100);
    stroke(0);
  }
}

//BUBBLE SORT (deals with volour changes too)
//If the block moves, it becomes red.
//the block is given a new target instead of swapping the places in the array.
//Thus, the block just moves to a new spot.
void bubsort() {
  sortbloc t;
  int tep;
  for (int i=0; i<dudes.size()-1; i++) {
    t=dudes.get(i);
    tep=dudes.get(i).target;
    if (dudes.get(i).val>dudes.get(i+1).val) {
      dudes.get(i).target=dudes.get(i+1).target;
      dudes.get(i+1).target=tep;
      dudes.set(i, dudes.get(i+1));
      dudes.set(i+1, t);
      dudes.get(i).g=0;
      dudes.get(i).blu=0;
      dudes.get(i+1).g=0;
      dudes.get(i+1).blu=0;
    } else if (dudes.get(i).val<=dudes.get(i+1).val) {
      dudes.get(i).g=255;
      dudes.get(i).blu=255;
      dudes.get(i+1).g=255;
      dudes.get(i+1).blu=255;
    }
    println(dudes.get(dudes.size()-1).r);
  }
  for (int i=0; i<dudes.size(); i++) { //makes sure all values have the correct heights.
    int temporaryplace=dudes.get(i).h;
    dudes.get(i).h=dudes.get(i).val*10;
    dudes.get(i).y+=(temporaryplace-dudes.get(i).h);
  }
  for (int i=len; i<dudes.size(); i++) { //turns green if in the correct place
    dudes.get(i).r=0;
    dudes.get(i).g=255;
    dudes.get(i).blu=0;
  }
  if (len>0) {
    len--;
  }
}

int oldbestnum; // old number that was the hgihest in the array
int stt=0; //stt is just the block that the array is currently on.

void selsort() { //Selection sort.
  select.get(oldbestnum).g=255;
  select.get(oldbestnum).blu=255;
  sortbloc t=select.get(stt);
  t.blu=0;
  t.g=0;
  if (stt>0) { // turns numbers in right spot to green.
    select.get(stt-1).g=255;
    select.get(stt-1).r=0;
    select.get(stt-1).blu=0;
  }
  if (stt==select.size()-1) {
    select.get(select.size()-1).g=255;
    select.get(select.size()-1).r=0;
  }
  int temp=select.get(stt).target;
  int bestindex=0;
  int bestval=0;
  for (int i=stt; i<select.size(); i++) {
    if (select.get(i).val>bestval) {
      bestindex=i;
      bestval=select.get(i).val;
    }
  }

  if (stt!=select.size()-1) {
    select.get(bestindex).g=0;
    select.get(bestindex).blu=0;
  }

  select.get(stt).target=select.get(bestindex).target;
  select.get(bestindex).target=temp;
  select.set(stt, select.get(bestindex));
  select.set(bestindex, t);

  oldbestnum=bestindex;
}



void mousePressed() {

  if (screen==0) {
    if (start.isOn()) {
      screen++;
      guzy.x=width/2-10;
      guzy.y=height/2-10;
    }
  }
  if (screen==1) {
    randosort(dudes); //randomizes any array
    randosort(select);
    for (int i=0; i<dudes.size(); i++) {
      dudes.get(i).r=255;
      dudes.get(i).g=255;
      dudes.get(i).blu=255;
    }
    for (int i=0; i<select.size(); i++) {
      select.get(i).r=255;
      select.get(i).g=255;
      select.get(i).blu=255;
    }
    for (int i=0; i<dudes.size(); i++) {
      int temporaryplace=dudes.get(i).h;
      dudes.get(i).h=dudes.get(i).val*10;
      dudes.get(i).y+=(temporaryplace-dudes.get(i).h);
    }
    for (int i=0; i<select.size(); i++) {
      int temporaryplace=select.get(i).h;
      select.get(i).h=select.get(i).val*10;
      select.get(i).y+=(temporaryplace-select.get(i).h);
    }
    if (selon) { //boolean stuff to make sure that nothing is clicked that isn't supposed to be clicked.
      if (bubb.okay.isOn()) {
        next=true;
      }
      if (bubb.up.isOn()&&selon) {
        sizeofarray++;
      } else if (bubb.down.isOn()) {
        sizeofarray--;
      }
    } else if (bubon) {
      if (bubb.okay.isOn()) {
        next=true;
      }
      if (bubb.up.isOn()&&bubon) {
        sizeofarray++;
      } else if (bubb.down.isOn()) {
        sizeofarray--;
      }
    } else if (seton) {
      if (lpm.yeorno.isOn()) {
        if (lowpower==true) {
          lowpower=false;
        } else if (lowpower==false) {
          lowpower=true;
        }
      }
    }
  }
  if (screen==2) {
    bubsort();
  }

  if (screen==3) {
    selsort();
    if (stt<select.size()-1) {
      stt++;
    }
  }
}

void keyPressed() {
  if (keyCode==87) { //movement
    up=true;
  }
  if (keyCode==83) {
    down=true;
  }
  if (keyCode==68) {
    right=true;
  }
  if (keyCode==65) {
    left=true;
  }
}

void keyReleased() {
  if (keyCode==87) {
    up=false;
  }
  if (keyCode==83) {
    down=false;
  }
  if (keyCode==68) {
    right=false;
  }
  if (keyCode==65) {
    left=false;
  }
}
