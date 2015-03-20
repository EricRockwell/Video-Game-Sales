int plotX1 = 75;
int plotX2 = 725;
int plotY1 = 100;
int plotY2 = 950;
FloatTable data;
float dataMinSales = 0;
float dataMinRating = 0;
float dataMaxSales = 0;
float dataMaxRating = 0;
float dataAvgSales = 0;
float dataAvgRating = 0;
int currentYear = 2000; 
int[] years = { 2000,2001,2002,2003,2004,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015};
float volumeInterval = 5;
float volumeIntervalMinor = 2;

void setup() {
  background(255);
  size(600,800);
     textAlign(CENTER);
     plotX1 = 75;
plotX2 = width-75;
plotY1 = 100;
plotY2 = height-50;
  
}


void draw() {
  background(255);
   getInfo();
   drawVolumeLabels();
   drawOverlay();
   drawData();



  
  
  
}

void drawData() {
  textSize(20);
     for(int j =0; j<data.getRowCount(); j++) {
        float x = map(data.getFloat(j,0), 0, dataMaxSales, plotY2, plotY1);     
        float y = map(data.getFloat(j,1), dataMinRating, dataMaxRating, plotY2, plotY1); 
        fill(220);
        text(nf(data.getFloat(j,1),0,1),plotX2+40,y);
        strokeWeight(3);    
     
        if (mouseY-x +10< 20 && mouseY-x+10>0 && mouseX-plotX1+10 <20 && mouseX-plotX1+10>0 || mouseY-y +10< 20 && mouseY-y+10>0 && mouseX-plotX2+10 <20 && mouseX-plotX2+10>0) { 
           noStroke();
           fill(255);
           rect(0,height-40,width,width);  
           fill(0);
         text( data.getRowName(j)+" (" + data.getFloat(j,0) +"m units and "+ data.getFloat(j,1)+" rating)", width/2, height-20);
        strokeWeight(5);
       
      }
           if(data.getFloat(j,1)<dataAvgRating) {
          stroke(178,121,0);
        }
        else{
          stroke(0,81,191);  
        } 
        fill(0);
        textAlign(CENTER);
        
        
        
        line(plotX1,x,plotX2,y);
        noStroke();
        fill(0,54,127);
        ellipse(plotX1,x,20,20);
        ellipse(plotX2,y,20,20);
     }
}


void getInfo() {
  strokeWeight(2);
  data = new FloatTable("" + currentYear +".tsv");
  dataMinSales = data.getColumnMin(0);
  dataMaxSales = data.getColumnMax(0);
  dataMinRating = data.getColumnMin(1);
  dataMaxRating = data.getColumnMax(1);
      float temp1 = 0;
      float temp2 = 0;
  for(int i = 0; i<data.getRowCount(); i++) {
    temp1 += data.getFloat(i,0);
    temp2 += data.getFloat(i,1); 
  }
  dataAvgRating = temp2/data.getRowCount(); 
  dataAvgSales = temp1/data.getRowCount();
  
}

void drawOverlay() {
   stroke(178,156,18);
   line(plotX1,plotY1,plotX1,plotY2);
   line(plotX2,plotY1,plotX2,plotY2);
   fill(0);
   strokeWeight(2);
   text("Video Games Sales vs Review Score",width/2,30);
   textSize(30);
   fill(178,121,0);
   if(currentYear == 2015) {
        text("2000-2015",width/2,70);
   }
   else if(currentYear == 2000 ) {
       text(currentYear,width/2,70);
       textSize(15);
       text("Hover over dots for info, and right/left arrows to go through years",width/2,height-20);
   }
   else if(currentYear == 2001 ) {
       text(currentYear,width/2,70);
       textSize(15);
       text("The variation in the colors of the lines, correlates to AVG rating",width/2,height-20);
   }
   else{
        text(currentYear,width/2,70);
   }

   ellipse(plotX1,plotY1,5,5);
   ellipse(plotX1,plotY2,5,5);
   textSize(12);
   fill(200);
   text("Millions Units Sold",plotX1-10,plotY1-30);
   text("Average Rating",plotX2+20,plotY1-30);
   strokeWeight(5);



}
void drawVolumeLabels() {
  fill(220);
  textSize(20);
  
  stroke(220);
  strokeWeight(5);
 for(int j =0; j<data.getRowCount(); j++) {
        
    for (float v = 0; v <= dataMaxSales; v += volumeIntervalMinor) {
      float y = map(v,0,  dataMaxSales, plotY2, plotY1);  

        text(floor(v), plotX1-30, y+5 );
        line(plotX1 - 10, y, plotX1, y);
        // Draw major tick
        

        
      }
   }
}

void keyPressed() {
    if (keyCode == RIGHT) {
      if(currentYear == years[years.length-1]) {
        currentYear = years[0];
        
      }
      
      else {
       currentYear ++;
      }    
      
    }
    else if (keyCode == LEFT) {
       if(currentYear == years[0]) {
        currentYear = years[years.length-1];
        
      }
      else {
       currentYear --;
      }   
    
    }
  
}

