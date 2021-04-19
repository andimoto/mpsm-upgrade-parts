$fn=40;

holderX=40;
holderY=40;
holderZ=57;

edgeR=0.5;

fanOuterXY=40;
fanOuterH=11;

fanInnerR=36/2; /* noctua 40mm fan is about 38mm fan blade radius */

nozzleBlowOutX=15;
nozzleBlowOutZPos=1;

coolerBlowOutX=25;
coolerBlowOutZPos=nozzleBlowOutZPos+22;
coolerBlowInPos=fanOuterXY/2 + 13;

screwR=3/2; //3mm screws
screwH=6; // fan height=10 + screwH=6 >> use M3x16
screwDistance=32; // each screw has a distance of 32mm to next screw (noctua 40mm fan)

module fanMock(fanXY=40,fanH=11)
{
  difference() {
    cube([fanXY,fanXY,fanH]);
    translate([fanOuterXY/2,fanOuterXY/2,-0.1]) cylinder(r=fanInnerR+1,h=fanOuterH+0.2,center=false);
  }
}


module sled()
{
  translate([-15-2,0,0]) cube([2,25,1.7]);
  translate([15,0,0]) cube([2,25,1.7]);
  translate([-25/2,25+7,0]) cube([25,2,1.7]);
}
/* sled(); */


module fanScrews()
{
  translate([-screwDistance/2,0,0]) cylinder(r=screwR, h=screwH, center=false);
  translate([screwDistance/2,0,0]) cylinder(r=screwR, h=screwH, center=false);
  translate([-screwDistance/2,screwDistance,0]) cylinder(r=screwR, h=screwH, center=false);
  translate([screwDistance/2,screwDistance,0]) cylinder(r=screwR, h=screwH, center=false);
}
/* fanScrews(); */

module fanHolder(screwedTopFan=false, screwedPartFan=false) {

    difference() {

    minkowski() {
      union()
      {
        translate([-holderX/2+edgeR,edgeR,edgeR]) cube([holderX-edgeR*2,holderY-edgeR*2,holderZ-edgeR*2]);
        translate([-holderX/2+edgeR-4,edgeR,edgeR]) cube([10,holderY-edgeR*2,13]);
        translate([-(nozzleBlowOutX+2)/2,-5+edgeR,edgeR]) cube([nozzleBlowOutX+2,5,3]);
      }
      sphere(r=edgeR);
    }


    union()
    {
      hull()
      {
        translate([-nozzleBlowOutX/2,0,nozzleBlowOutZPos]) cube([nozzleBlowOutX,1,2]);
        translate([0,40-1+0.1,coolerBlowInPos]) rotate([-90,0,0]) cylinder(r=fanInnerR, h=1, center=false);
      }
      hull()
      {
        translate([-nozzleBlowOutX/2,-5,1]) cube([nozzleBlowOutX,1,2]);
        translate([-nozzleBlowOutX/2,0,1]) cube([nozzleBlowOutX,1,2]);
      }
    }

    union()
    {
      hull()
      {
        translate([0,holderX/2,holderZ-1+0.1]) cylinder(r=fanInnerR, h=1, center=false);
        translate([-coolerBlowOutX/2,-0.1,coolerBlowOutZPos]) cube([coolerBlowOutX,1,coolerBlowOutX]);
      }
    }

    /* using screws (screws provided by noctua are not long enougth) */
    if(screwedTopFan == true)
    {
      translate([0,(fanOuterXY-screwDistance)/2,holderZ-screwH+0.1]) fanScrews();
    }
    if(screwedPartFan == true)
    {
      translate([0,fanOuterXY+0.1,coolerBlowInPos-screwDistance/2]) rotate([90,0,0]) fanScrews();
    }

    /* nozzleCam place holder */
    translate([-19,45,9]) rotate([95,-40,4]) cylinder(r=4,h=50,center=false);

  }

  /* sled for holding holder in place!  */
  translate([0,0.3,coolerBlowOutZPos]) rotate([90,0,0]) sled();

  /* using noctua rubber strings provided with the fans (easy to mount, no screws needed)  */
  if(screwedTopFan == false)
  {

  }

}

/* fanMock(); */
translate([0,0,0]) fanHolder(screwedTopFan=true,screwedPartFan=true);
/* translate([-holderX/2,0,holderZ+1]) color("brown") fanMock();
translate([-holderX/2,holderY+1,fanOuterXY]) rotate([-90,0,0]) color("brown") fanMock(); */
