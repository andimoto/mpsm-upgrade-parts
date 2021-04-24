$fn=80;


piCaseX=56;
piCaseY=120;

piCaseHoleY=110;
piCaseHoleDist=30;

screwDistance=56;
holderX=screwDistance+5+5;
holderY=piCaseY+50; /* size of rpi display case */
holderZ=20;
mountThickness=5;
screwPrinterGap=8; /* distance of screw to front plate of the mpsm printer */
screwPrintergapExtra=5;
plateThickness=holderZ-screwPrinterGap-screwPrintergapExtra;

screwR=1.6;
extruderX=44;

fanScrewR=2.8/2; //3mm screws
fanScrewH=plateThickness; // fan height=10 + screwH=6 >> use M3x16
fanScrewDistance=32; // each screw has a distance of 32mm to next screw (noctua 40mm fan)
fanSizeXY=40;

module fanScrews(screwR=1.4)
{
  translate([0,0,0]) cylinder(r=fanScrewR, h=fanScrewH, center=false);
  translate([fanScrewDistance,0,0]) cylinder(r=fanScrewR, h=fanScrewH, center=false);
  translate([0,fanScrewDistance,0]) cylinder(r=fanScrewR, h=fanScrewH, center=false);
  translate([fanScrewDistance,fanScrewDistance,0]) cylinder(r=fanScrewR, h=fanScrewH, center=false);
}



module rpi_holder()
{
  difference()
  {
    cube([holderX,holderY,holderZ]);

    translate([0,mountThickness,holderZ-screwPrinterGap-screwPrintergapExtra])
      cube([holderX,holderY-mountThickness,screwPrinterGap+screwPrintergapExtra]);

    translate([(holderX-extruderX)/2,0,plateThickness])
      cube([extruderX,mountThickness,screwPrinterGap+screwPrintergapExtra]);

    /* case frame mounting holes */
    translate([(holderX-extruderX)/4-1,mountThickness,plateThickness+screwPrinterGap])
    union()
    {
      rotate([90,0,0]) cylinder(r=screwR,h=mountThickness);
      translate([screwDistance,0,0]) rotate([90,0,0]) cylinder(r=screwR,h=mountThickness);
    }
    /* reduse the mountThickness of the left mounting plate */
    translate([0,mountThickness-1,plateThickness]) cube([(holderX-extruderX)/2,1,screwPrinterGap+screwPrintergapExtra]);

    /* piCase mounting screws */
    translate([(holderX-piCaseHoleDist)/2,holderY-piCaseHoleY,0])
    union()
    {
      cylinder(r=1.5,h=plateThickness);
      translate([30,0,0]) cylinder(r=1.5,h=plateThickness);
    }



    /* cutouts for cooling and filament saving */
    translate([(holderX-fanSizeXY)/2,10,0]) cube([fanSizeXY,fanSizeXY,holderZ-screwPrinterGap-screwPrintergapExtra]);
    translate([(holderX-fanSizeXY)/2,70,0]) cube([fanSizeXY,fanSizeXY,holderZ-screwPrinterGap-screwPrintergapExtra]);

    /* fan */
    translate([(holderX)/2,holderY-fanSizeXY/2-10,0]) cylinder(r=(fanSizeXY-2)/2, h=10);
    translate([(holderX-fanSizeXY)/2+(fanSizeXY-fanScrewDistance)/2,holderY-fanSizeXY-6,0]) fanScrews();
    /* #translate([(holderX-fanSizeXY)/2,holderY-fanSizeXY-10,4]) cube([fanSizeXY,fanSizeXY,holderZ-screwPrinterGap-screwPrintergapExtra]); */

    /* air cutouts */
    translate([(holderX)/2-5,holderY-15,plateThickness-5]) cube([10,15,5]);
    translate([(holderX)/2-5,holderY-20-fanSizeXY,plateThickness-5]) cube([10,15,5]);

    translate([0,holderY-10-fanSizeXY/2-5,plateThickness-5]) cube([15,10,5]);
    translate([holderX-15,holderY-10-fanSizeXY/2-5,plateThickness-5]) cube([15,10,5]);

    translate([0,fanSizeXY-15,plateThickness-5]) cube([15,10,5]);
    translate([holderX-15,fanSizeXY-15,plateThickness-5]) cube([15,10,5]);

    translate([0,70+fanSizeXY/2-5,plateThickness-5]) cube([15,10,5]);
    translate([holderX-15,70+fanSizeXY/2-5,plateThickness-5]) cube([15,10,5]);
  }
}


rpi_holder();


/* test */
/* difference() {
  rpi_holder();
  translate([0,10,0]) cube([holderX,holderY,30]);
} */
