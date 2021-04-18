$fn=50;

holderX=40;
holderY=40;
holderZ=55;

fanOuterXY=40;
fanOuterH=11;

fanInnerR=36/2; /* noctua 40mm fan is about 38mm fan blade radius */

nozzleBlowOutX=15;
nozzleBlowOutZPos=1;

coolerBlowOutX=25;
coolerBlowOutZPos=nozzleBlowOutZPos+20;


screwR=3/2; //3mm screws
screwH=12; // fan height=10 + screwH=12 >> use M3x20
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
  translate([-15-2,0,0]) cube([2,25,1.6]);
  translate([15,0,0]) cube([2,25,1.6]);
  translate([-25/2,25+7,0]) cube([25,2,1.6]);
}
/* sled(); */


module fanScrews()
{
  translate([-screwDistance/2,0,0]) cylinder(r=screwR, h=12, center=false);
  translate([screwDistance/2,0,0]) cylinder(r=screwR, h=12, center=false);
  translate([-screwDistance/2,screwDistance,0]) cylinder(r=screwR, h=12, center=false);
  translate([screwDistance/2,screwDistance,0]) cylinder(r=screwR, h=12, center=false);
}
/* fanScrews(); */

module fanHolder(screwedVersion=false) {

  difference() {
    translate([-holderX/2,0,0]) cube([holderX,holderY,holderZ]);

    union()
    {
      hull()
      {
        translate([-nozzleBlowOutX/2,10,nozzleBlowOutZPos]) cube([nozzleBlowOutX,1,2]);
        translate([0,40-1+0.1,fanOuterXY/2]) rotate([-90,0,0]) cylinder(r=fanInnerR, h=1, center=false);
      }
      hull()
      {
        translate([-nozzleBlowOutX/2,-0.1,1]) cube([nozzleBlowOutX,1,2]);
        translate([-nozzleBlowOutX/2,10,1]) cube([nozzleBlowOutX,1,2]);
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
    if(screwedVersion == true)
    {
      translate([0,(fanOuterXY-screwDistance)/2,holderZ-screwH+0.1]) fanScrews();
      translate([0,fanOuterXY+0.1,(fanOuterXY-screwDistance)/2]) rotate([90,0,0]) fanScrews();
    }
  }

  /* sled for holding holder in place!  */
  translate([0,0,coolerBlowOutZPos]) rotate([90,0,0]) sled();

  /* using noctua rubber strings provided with the fans (easy to mount, no screws needed)  */
  if(screwedVersion == false)
  {

  }

}

/* fanMock(); */
translate([0,0,0]) fanHolder(screwedVersion=true);
/* translate([-holderX/2,0,holderZ+1]) color("brown") fanMock();
translate([-holderX/2,holderY+1,fanOuterXY]) rotate([-90,0,0]) color("brown") fanMock(); */
