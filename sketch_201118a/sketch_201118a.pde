float x0 = 100;  //Start x
float y0 = 400;  //Start y

float x;         //Cirklens x
float y;         //Cirklens y

float L;         //Længden slangebøssen trækkes tilbage med
float v;         //Vinklen 
float t;         //Tid

float a;
float b;

boolean shoot = false;  // Så bolden skyder når man klikker, og vinklen/længden ikke påvirkes efter bolden er skudt

void setup(){
  size(800,500);
}

void draw(){
  if(shoot==false){
  a = mouseY-y0;
  b = mouseX-x0;
  }
  clear();
  
  lavCirkel();
  
  lavLinje();
  beregnLaengde();
  beregnVinkel();
  lavBane();
  
  text("a: " +a+ "   b: " +b, 20,30);  
  text("v: " + -degrees(v), 20,50);
  text("L: " + L, 20,70);
  text("Press R to reset", 20,90);
  
  if(shoot==false && mouseX<=x0){
  visPrikker();
  }
  
  if(shoot==true){
  beregnSkraaKast();
  }
  
}


void mousePressed(){
  shoot = true;

}

void keyPressed(){
  if(key=='r'||key=='R'){
  shoot = false;
  x = 0;
  y = 0;
  t = 0;
  }
}

void lavCirkel(){            //Laver cirklen. Laves ved x0,y0 hvis shoot==false, og ved x og y shoot==true, fordi i starten er x og y 0.
  if(shoot==false){      
  ellipse(x0,y0,20,20);
  }
  if(shoot==true){
  ellipse(x,y,20,20);
  }
}

void lavLinje(){            //Laver en linje hvis shoot==false så den ikke hele tiden er der
  if(shoot==false && mouseX<=x0){
  stroke(255);
  line(mouseX,mouseY,x0,y0);
  }
}

void beregnLaengde(){      //Beregner længden hvis shoot==false så bolden ikke påvirkes under skuddet
  if(shoot==false){
  L = dist(mouseX,mouseY,x0,y0)/10;
  }
}

void beregnVinkel(){      //Beregner vinklen hvis shoot==false så bolden ikke påvirkes under skuddet
  if(shoot==false){
  v = atan(a/b);
  }
}

void lavBane(){
  float b;
  
    
}

void visPrikker(){
  float EP;  //Skuddets affyringsenergi
  float AP;  //Skuddets affyringshældning
  EP = 0.5 * 100 * L * L;
  AP = tan(v);
  
  float u0P = sqrt( (2*EP) / (1*(1+AP*AP)) );       //Affyringshastighed (x)
  float v0P = AP * (sqrt( (2*EP) / (1*(1+AP*AP)) )); //Affyringshastighed (y)
  float gP = -9.82;
  
  ellipse(u0P * 4 + x0,-0.5 * gP * 4 * 4 + v0P * 4 + y0,1,1);
  ellipse(u0P * 3 + x0,-0.5 * gP * 3 * 3 + v0P * 3 + y0,3,3);
  ellipse(u0P * 2 + x0,-0.5 * gP * 2 * 2 + v0P * 2 + y0,4,4);
  ellipse(u0P * 1 + x0,-0.5 * gP * 1 * 1 + v0P * 1 + y0,5,5);

}

void beregnSkraaKast(){  //Her beregnes kastets x og y gennem tid.
  t = t+0.09;
  float E;  //Skuddets affyringsenergi
  float A;  //Skuddets affyringshældning
  E = 0.5 * 100 * L * L;
  A = tan(v);
  
  float m = 1;                                  //Fuglens masse
  float u0 = sqrt( (2*E) / (m*(1+A*A)) );       //Affyringshastighed (x)
  float v0 = A * (sqrt( (2*E) / (m*(1+A*A)) )); //Affyringshastighed (y)
  float g = -9.82;
  
  x = u0 * t + x0;
  y = -0.5 * g * t * t + v0 * t + y0;
  
}
