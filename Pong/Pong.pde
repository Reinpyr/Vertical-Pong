// Pong

//Pallo
float pallox = 400,palloy = 400;
float xmuutos; //x-koordinaatin muutos
float ymuutos; //y-koordinaatin muutos
boolean pomppu = false; //Voiko pallo pompata alalaatasta
boolean ylapomppu = false; //Voiko pallo pompata ylälaatasta
float nopeus = 1; //Pallon nopeuden lisäys joka kierroksella
//Peli paalle
boolean peli = false; //Onko peli päällä vai ei (lukitsee laatat ja pallon)
boolean restart = false; //Voiko pelin restartata "R" napilla
float alas, ylos;
//Alalaatta
float leveys = 180; //Alalaatan leveys
float paksuus = 20; //Alalaatan paksuus
float alax = 310; //Alalaatan vasen yläkulma
float alalaatankeskipiste = 400; //Alalaatan keskipisteen x-koordinaatti
//Ylälaatta
float ylaleveys = 180; //Ylälaatan leveys
float ylax = 310; // Ylälaatan vasen alakulma
float ylakeski = 400; // Ylälaatan keskipisteen x-koordinaattti
//Molemmat laatat
float laatannopeus = 5; //Laattojen liikkumisnopeus 
//Pisteet
int n,p; //Pelaajan 1 pisteet, Pelaajan 2 pisteet
int k = 1; //Pistelaskun whilesilmukan numero

//Piirtoikkunan koko yms. muut
void setup()
{
  size (800,800);
  frameRate(30);
  colorMode(HSB,100);
  background(0);
  smooth();
  textAlign(CENTER,CENTER);
  textSize(64);
}

void mousePressed() //Käynnistää pelin
{
  if (peli == false) //Pallo valitsee muuttujat vain kun peli ei ole päällä
  {
    xmuutos = random(-4,4);
    ymuutos = random(-4,4);
  }
  peli = true;
}

void keyPressed ()
{
    //Alalaatta oikealle
    if ((key == 'd') && (alax <= width-leveys) && (peli == true))
      {
        alax = alax + laatannopeus;
        alalaatankeskipiste = alalaatankeskipiste + laatannopeus;
      } //Alalaatta vasemmalle
    if ((key == 'a') && (alax > 0) && (peli == true))
      {
        alax = alax - laatannopeus;
        alalaatankeskipiste = alalaatankeskipiste - laatannopeus;
      }
    //Ylälaatta vasemmalle
    if ((key == 'j') && (ylax > 0) && (peli == true))
    {
      ylax = ylax - laatannopeus;
      ylakeski = ylakeski - laatannopeus;
    } //Ylälaatta oikealle
    if ((key == 'l') && (ylax < width-ylaleveys) && (peli == true))
     {
       ylax = ylax + laatannopeus;
       ylakeski = ylakeski + laatannopeus;
     } //R-nappi käynnistää pelin uudestaan, jos siihen on lupa
    if ((key == 'r') && (restart == true))
    { //Asettaa default arvot
      xmuutos = 0;
      ymuutos = 0;
      pallox = 400;
      palloy = 400;
      alax = 330;
      alalaatankeskipiste = 400;
      ylax = 330;
      ylakeski = 400;
      peli = false;
      pomppu = false;
      ylapomppu = false;
      laatannopeus = 5;
      nopeus = 0;
      restart = false;
      k = 1;
    }
}

void draw()
{
//Pallon liike
  pallox = pallox + xmuutos;
  palloy = palloy + ymuutos;
//Pallon kimpoaminen seinistä
  {
    if (pallox >= width)
      xmuutos = - 3;
    if (pallox <= 0)
      xmuutos = 3;
   }
//Pallon kimpoaminen alalaatasta
  if (palloy >= 780)
   {
     pomppu = true;
   }
  if ((pomppu == true) && (dist(alalaatankeskipiste,height-paksuus,pallox,palloy) <= 90))
   {
     ymuutos = -ymuutos + nopeus;
     pomppu = false;
     laatannopeus = laatannopeus + 0.5;
   }
//Pallon kimpoaminen ylälaatasta
  if (palloy <= 20)
  {
    ylapomppu = true;
  }
 if ((ylapomppu == true) && dist(ylakeski,paksuus,pallox,palloy) <= 90)
  {
    ymuutos = -ymuutos + nopeus;
    ylapomppu = false;
    laatannopeus = laatannopeus + 0.5;
  }
//Tarkistaa pitääkö nopeutta lisätäksi nopeus arvoa lisätä vai vähentää yhdellä
 if (ymuutos < 0)
 {
   nopeus = 1;
 }
 if (ymuutos > 0)
 {
   nopeus = -1;
 }
//Piirtäminen ja konsoli 
  {
    background(0);
    rect(alax,height-20,leveys,20);
    rect(ylax,0,ylaleveys,20);
    circle(pallox,palloy,30);
    println(ylax,ylakeski,alax,alalaatankeskipiste);
  }
//Pallon meneminen ulos pelialueelta
  if ((palloy < -31) || (palloy >= height + 31))
  {
    while ((k > 0) && (palloy < -31)) //Laskee pelaajan 2 pisteet
    {
      n = n + 1;
      k = k - 1;
    }
    while ((k > 0) && (palloy >= height + 31)) //Laskee pelaajan 1 pisteet
    {
      p = p + 1;
      k = k - 1;
    }
    text("Game over",400,200);
    text ("Press R to restart",400,250);
    restart = true; //Antaa oikeiden käynnistää pelin uudestaan
    text(n,360,330);
    text(p,440,330);
  }
//Tekstit
  if (peli == false)
  {
    text("Click to start",400,200);
  }
}
