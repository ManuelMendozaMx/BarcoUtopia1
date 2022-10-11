//variables utilidades
int nElementos = 6;
//Carga de archivos
//Archivo JSON
JSONArray elementosJson;
//Arreglo de imagenes
PImage[] imagenesElementos = new PImage[nElementos];
//Areglo de clase elemento
Elemento[] elementos = new Elemento[nElementos];
boolean movimiento = true;
int tocados = 0;

float xCentral, yCentral;
float tam =0;
boolean centralActivado = false;
int indiceSeleccionado = 0;
float tamTexto =1;

//Imagenes
PImage iconoCerrar;
float tamIcono =0;
PImage mujer;
float tamMujer =0;

void setup() {
  //set
  //size(960, 540);
  textAlign(CENTER);
  fullScreen();
  //Carga de archivos
  //JSON
  elementosJson = loadJSONArray("elementos.json");
  //imagenes
  for (int i = 0; i < nElementos; i++) {
    //imagenesElementos[i] = loadImage(elementosJson.getJSONObject(i).getString("imagen")+".png");
    StringList ejemplos = elementosJson.getJSONObject(i).getStringList("ejemplos");
    //println(ejemplos.get(0));
    elementos[i] = new Elemento(i, elementosJson.getJSONObject(i).getString("texto"), elementosJson.getJSONObject(i).getString("titulo"), ejemplos);
  }
  //variables
  xCentral = width/2;
  yCentral = height/2;
  //imagenes
  imageMode(CENTER);
  iconoCerrar = loadImage("cerrar.png");
  mujer = loadImage("mujer.png");
}

void draw() {
  background(255);
  for (int i = 0; i < nElementos; i++) {
    elementos[i].dibujar();
    elementos[i].mover();
    if (centralActivado==false) {
      if (dist(mouseX, mouseY, elementos[i].x, elementos[i].y)<elementos[i].anchoElemento/2) {
        elementos[i].seleccionado = true;
        elementos[i].seleccionado();

        if (mousePressed) {
          centralActivado = true;
          indiceSeleccionado = i;
        }
      } else {
        elementos[i].seleccionado = false;
        elementos[i].noSeleccionado();
      }
    }
  }
  boolean selec = false;
  for (int i = 0; i < nElementos; i++) {

    if (elementos[i].seleccionado) {
      selec = true;
    }

    if (selec) {
      for (int j = 0; j < nElementos; j++) {
        elementos[j].vel = 0.02;
      }
    } else {
      for (int j = 0; j < nElementos; j++) {
        elementos[j].vel = 0.1;
      }
    }
  }
  //Central circulo


  if (centralActivado) {
    //Desactivar seleccion
    if (tam==width/2) {
      if (mousePressed&&dist((width/10)*7, (height/10)*2, mouseX, mouseY)<tamIcono/2) {
        centralActivado = false;
      }
    }
    if (tam<width/2) {
      tam+=10;
    }
    if (tamIcono<50) {
      tamIcono+=1;
    }

    if (tamTexto<20) {
      tamTexto+=.5;
    }

    if (tamMujer<300) {
      tamMujer+=5;
    }

    fill(255, 128);
    rect(0, 0, width, height);
    elementoCentral();
  } else {

    if (tamTexto>0.6) {
      tamTexto-=0.5;
    }
    if (tam>0) {
      tam-=10;
    }
    if (tamMujer>0) {
      tamMujer-=5;
    }
    if (tamIcono>0) {
      tamIcono-=1;
    }
    elementoCentral();
  }
}


void elementoCentral() {
  fill(#D7F5F1);
  stroke(#D7F5F1);
  ellipse(xCentral, yCentral, tam, tam);
  //icono cerrar
  image(iconoCerrar, (width/10)*7, (height/10)*2, tamIcono, tamIcono);

  fill(0);
  textSize(tamTexto);
  text(elementos[indiceSeleccionado].titulo, xCentral, (height/10)*1);
  text("EJEMPLOS VIOLENCIA EN MUJERES ADULTAS:", xCentral, (height/10)*2);
  for (int i = 0; i < elementos[indiceSeleccionado].ejemplos.size(); i++) {
    text(elementos[indiceSeleccionado].ejemplos.get(i), xCentral, map(i, 0, elementos[indiceSeleccionado].ejemplos.size()-1, (height/10)*3, (height/10)*8));
  }
  //mujer
  image(mujer, (width/10)*2, (height/10)*7, tamMujer, tamMujer);
}
