 //Importar Serial de comunicação para a Biblioteca
import processing.serial.*;

//Variavéis

Serial commPort;
float tempC;
float tempF;
int yDist;
PImage img;
String wg;
float[] tempHistory = new float[100];

void setup(){
  
 //Tamanho da Janela
  size(360,320); 
  img = loadImage("image2.png"); 
  
 //Porta de Cominicação com o Serial
   commPort = new Serial(this, "COM6", 9600);
   //fill tempHistory with default temps
       for(int index = 0; index<100; index++)
           tempHistory[index] = 0;
}

void draw(){
  
  //Obter Temperatura da Porta Serial
   while (commPort.available() > 0) {
   wg = commPort.readString();
   tempC = float(wg);

      background(#ffffff); //Atualizar a cor de fundo
      image(img, 25, 5);

  //Desenhar Gráfico
 
       for (int index = 0; index<100; index++)
       { 
       if(index == 99)
       tempHistory[index] = tempC;  
       else
       tempHistory[index] = tempHistory[index + 1];
       
 }

  //Desenho de um ponteiro em triângulo 
       yDist = int(160 - (160 * (tempC * 0.01)));
       stroke(0);
       triangle(120, yDist + 20, 130, yDist + 15, 130, yDist + 25);
  //Escrever a Temperatura em C e F

       fill(0,0,0);
       textAlign(LEFT);
       textSize(15);
       text(" Medidor de Temperatura \n", 150,25);
       textAlign(LEFT);
       text("Celsius e Fahrenheit ", 172,50);
       text(str(int(tempC)) + " ºC", 150, 150);
       tempF = ((tempC*9)/5) + 32;
       text(str(int(tempF)) + " ºF", 150, 110);
 }
}