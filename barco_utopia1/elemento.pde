class Elemento {
  int indice;
  float anchoElemento=width/(3*nElementos);
  int altoElemento=height/5;
  float x;
  float y;
  String texto;
  String titulo;
  //PImage imagen;
  color colorElemento = #5B89E8;
  boolean seleccionado = false;
  float giro =0;
  float vel = 0.05;
  float crecimiento =0;
  StringList ejemplos;

  Elemento(int indice, String texto, String titulo, StringList ejemplos) {
    // this.imagen=imagen;
    this.indice=indice;
    this.texto=texto;
    this.titulo=titulo;
    this.x = width/2 + (sin(radians(indice*360/nElementos))*(width/2-100));
    this.y = height/2+( cos(radians(indice*360/nElementos))*(height/2-100));
    this.ejemplos=ejemplos;
  }

  void dibujar() {
    fill(colorElemento);
    stroke(colorElemento);
    ellipse(x, y, anchoElemento, anchoElemento);
    fill(0);
    textSize(20-(nElementos*1));
    text(titulo, x, y-(height/50));
    textSize(19-(nElementos*1));
    text(texto, x -(width/14), y+(height/70), 200, 100);
    //text(texto, x, y+20, 200, 320);
    //image(imagen, x-(anchoElemento*1.2), y, width/11, width/11);
  }
  void mover() {
    //mover x y y ciclicamente
    x = width/2 + (sin(radians(indice*360/nElementos+giro))*(width/2-100));
    y = height/2+( cos(radians(indice*360/nElementos+giro))*(height/2-100));
    giro+=vel;
  }

  void seleccionado() {
    colorElemento = #FF0000;
    anchoElemento = width/(3*nElementos)+crecimiento;
    if (crecimiento<10) {
      crecimiento+=1.5;
    }
  }
  void noSeleccionado() {
    colorElemento = #5B89E8;
    anchoElemento = width/(3*nElementos);
  }
}
