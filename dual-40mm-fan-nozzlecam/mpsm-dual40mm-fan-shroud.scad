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

screwR=2.8/2; //3mm screws
screwH=6; // fan height=10 + screwH=6 >> use M3x16
screwDistance=32; // each screw has a distance of 32mm to next screw (noctua 40mm fan)

sideScrewR=3/2;
sideScrewH=3;

nozzleCamCylinderX=-55;
nozzleCamCylinderY=45;
nozzleCamCylinderZ=25;

nozzleCamRotateX=120;
nozzleCamRotateY=-40;
nozzleCamRotateZ=20;

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


module sideCutout()
{
  translate([0,25/2,0])
  rotate([0,-90,180])
  union()
  {
    translate([25/2,0,0]) cylinder(r=25/2, h=2, center=false);
    cube([25,25/2,2]);
  }
}
/* translate([-holderX/2,0,coolerBlowOutZPos]) sideCutout(); */


module rubberCutout(rad=5)
{
  intersection() {
    sphere(r=rad);
    cube([rad*2,rad*2,rad]);
  }

}

module fanScrews(screwR=1.4)
{
  translate([-screwDistance/2,0,0]) cylinder(r=screwR, h=screwH, center=false);
  translate([screwDistance/2,0,0]) cylinder(r=screwR, h=screwH, center=false);
  translate([-screwDistance/2,screwDistance,0]) cylinder(r=screwR, h=screwH, center=false);
  translate([screwDistance/2,screwDistance,0]) cylinder(r=screwR, h=screwH, center=false);
}
/* fanScrews(); */
/* translate([-holderX/2,0,5]) rotate([50,0,0]) cube([holderX,holderY/2,8]); */

module fanHolder(screwedTopFan=false, screwedPartFan=false, nozzleCam=true) {

  difference() {

    minkowski() {
      union()
      {
        difference() {
          translate([-holderX/2+edgeR,edgeR,edgeR]) cube([holderX-edgeR*2,holderY-edgeR*2,holderZ-edgeR*2]);
          translate([-holderX/2,0,-17]) rotate([20,0,0]) cube([holderX,holderY*2,15]);
          translate([-holderX/2,0,7]) rotate([45,0,0]) cube([holderX,10,10]);
        }
        /* translate([-holderX/2+edgeR-4,edgeR,edgeR]) cube([10,holderY-edgeR*2,13]); */
        /* nozzle side */
        hull()
        {
          translate([-nozzleBlowOutX/2-0.5,0,1]) cube([nozzleBlowOutX+1,1,3]);
          translate([-nozzleBlowOutX/2-0.5,-4,-1.5]) rotate([15,0,0]) cube([nozzleBlowOutX+1,1,3]);
        }
      }
      sphere(r=edgeR);
    }

    /* nozzle blow out */
    union()
    {
      /* fan side */
      hull()
      {
        translate([-nozzleBlowOutX/2,0,nozzleBlowOutZPos]) cube([nozzleBlowOutX,1,2]);
        translate([0,40-1+0.1,coolerBlowInPos]) rotate([-90,0,0]) cylinder(r=fanInnerR, h=1, center=false);
      }
      /* nozzle side */
      hull()
      {
        translate([-nozzleBlowOutX/2,0,1]) cube([nozzleBlowOutX,1,2]);
        translate([-nozzleBlowOutX/2,-5-edgeR-1,-2]) rotate([14,0,0]) cube([nozzleBlowOutX,1,2]);
      }
    }

    /* cooler blow out */
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
      translate([0,(fanOuterXY-screwDistance)/2,holderZ-screwH+0.1]) fanScrews(screwR=1.4);
    }
    if(screwedPartFan == true)
    {
      translate([0,fanOuterXY+0.1,coolerBlowInPos-screwDistance/2]) rotate([90,0,0]) fanScrews(screwR=1.4);
    }

    /* nozzleCam place holder */
    /* translate([-19,45,9]) rotate([95,-40,4]) cylinder(r=4,h=50,center=false); */

    translate([-holderX/2,0,coolerBlowOutZPos]) sideCutout();
    translate([holderX/2-2,0,coolerBlowOutZPos]) sideCutout();

    /* screw holes for clamps */
    translate([holderX/2-sideScrewH-2,3,coolerBlowOutZPos+coolerBlowOutZPos/2+sideScrewR/2]) rotate([0,90,0])
    cylinder(r=sideScrewR, h=sideScrewH,center=false);

    translate([-holderX/2+2,3,coolerBlowOutZPos+coolerBlowOutZPos/2+sideScrewR/2]) rotate([0,90,0])
    cylinder(r=sideScrewR, h=sideScrewH,center=false);


    /* using noctua rubber strings provided with the fans (easy to mount, no screws needed)  */
    if(screwedTopFan == false)
    {
      translate([0,(fanOuterXY-screwDistance)/2,holderZ-screwH+0.1]) fanScrews(screwR=2);

      translate([20,1,holderZ-1]) rotate([0,180,0]) rubberCutout(rad=7);
      translate([-20,1,holderZ-1]) rotate([0,180,-90]) rubberCutout(rad=7);
      translate([-20,holderY-1,holderZ-1]) rotate([0,180,180]) rubberCutout(rad=9);
      translate([20,holderY-1,holderZ-1]) rotate([0,180,90]) rubberCutout(rad=9);
    }
    if(screwedPartFan == false)
    {
      translate([0,fanOuterXY+0.1,coolerBlowInPos-screwDistance/2]) rotate([90,0,0]) fanScrews(screwR=2);

      translate([20,holderY-1,coolerBlowOutZPos-1-8]) rotate([180,180,0]) rubberCutout(rad=8);
      translate([-20,holderY-1,coolerBlowOutZPos-1-8]) rotate([180,180,90]) rubberCutout(rad=8);
    }

    if(nozzleCam == true)
    {
      translate([nozzleCamCylinderX,nozzleCamCylinderY,nozzleCamCylinderZ]) rotate([nozzleCamRotateX,nozzleCamRotateY,nozzleCamRotateZ]) cylinder(r=4,h=65,center=false);
    }
    translate([-holderX+11,0,-20]) rotate([45,0,0]) cube([holderX/2,holderX/2,holderX/2]);
    translate([9,0,-20]) rotate([45,0,0]) cube([holderX/2,holderX/2,holderX/2]);


    /* reduce weight */
    /* translate([-holderX/2,0,7]) rotate([45,0,0]) cube([holderX,10,10]); */
  }

  /* sled for holding holder in place!  */
  translate([0,0.3,coolerBlowOutZPos]) rotate([90,0,0]) sled();

  if(nozzleCam == true)
  {
    difference() {
      translate([nozzleCamCylinderX,nozzleCamCylinderY,nozzleCamCylinderZ]) rotate([nozzleCamRotateX,nozzleCamRotateY,nozzleCamRotateZ])
      union()
      {
        difference() {
          cylinder(r=6,h=60,center=false);
          cylinder(r=4,h=60,center=false);
          translate([0,0,30]) rotate([0,-90,0]) cylinder(r=1.5,h=8,center=false);
        }
      }
      translate([-holderX-20,holderY,5]) cube([holderX,holderX,holderX]);
      translate([-holderX+11,0,-20]) cube([holderX/2,holderX/2,holderX/2]);
      translate([-holderX+11,0,-20]) rotate([45,0,0]) cube([holderX/2,holderX/2,holderX/2]);
    }
  }
}



/* #translate([0,0,2]) rotate([115,0,0]) cylinder(r=1, h=50, center=false);
#translate([-35,50,20]) rotate([117,-40,4]) cylinder(r=1, h=100, center=false); */

/* fanMock(); */
translate([0,0,0]) fanHolder(screwedTopFan=true,screwedPartFan=true, nozzleCam=true);
/* translate([-holderX/2,0,holderZ+1]) color("brown") fanMock();
translate([-holderX/2,holderY+1,fanOuterXY]) rotate([-90,0,0]) color("brown") fanMock(); */
