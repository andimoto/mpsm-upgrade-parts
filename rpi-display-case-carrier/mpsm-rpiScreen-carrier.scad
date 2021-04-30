$fn=80;

extra=0.1;

piCaseX=56;
piCaseY=120;

piCaseHoleY=110;
piCaseHoleDist=32;

screwDistance=56;
holderX=screwDistance+5+5;
holderY=piCaseY+20; /* size of rpi display case */
holderZ=20;
mountThickness=7;
screwPrinterGap=8; /* distance of screw to front plate of the mpsm printer */
screwPrintergapExtra=5;
plateThickness=holderZ-screwPrinterGap-screwPrintergapExtra;

screwR=1.6;
extruderX=44;

fanScrewR=2.8/2; //3mm screws
fanScrewH=plateThickness; // fan height=10 + screwH=6 >> use M3x16
fanScrewDistance=32; // each screw has a distance of 32mm to next screw (noctua 40mm fan)
fanSizeXY=40;
fanSizeZ=10;

module fanScrews(screwR=1.4)
{
  translate([0,0,0]) cylinder(r=fanScrewR, h=fanScrewH, center=false);
  translate([fanScrewDistance,0,0]) cylinder(r=fanScrewR, h=fanScrewH, center=false);
  translate([0,fanScrewDistance,0]) cylinder(r=fanScrewR, h=fanScrewH, center=false);
  translate([fanScrewDistance,fanScrewDistance,0]) cylinder(r=fanScrewR, h=fanScrewH, center=false);
}



module carrier()
{
  difference()
  {
    cube([holderX,holderY,holderZ]);

    translate([0,mountThickness,holderZ-screwPrinterGap-screwPrintergapExtra])
      cube([holderX,holderY-mountThickness,screwPrinterGap+screwPrintergapExtra+extra]);

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
    translate([0,mountThickness-2,plateThickness]) cube([(holderX-extruderX)/2,2,screwPrinterGap+screwPrintergapExtra]);

    /* piCase mounting screws */
    translate([(holderX-piCaseHoleDist)/2,holderY-piCaseHoleY,0])
    union()
    {
      cylinder(r=1.5,h=plateThickness);
      translate([piCaseHoleDist,0,0]) cylinder(r=1.4,h=plateThickness);
    }

    /* cutouts for cooling and filament saving */
    translate([(holderX-fanSizeXY)/2,10,0]) cube([fanSizeXY,fanSizeXY/4,holderZ-screwPrinterGap-screwPrintergapExtra]);
    translate([(holderX-fanSizeXY)/2,40,0]) cube([fanSizeXY,fanSizeXY,holderZ-screwPrinterGap-screwPrintergapExtra]);

    /* fan */
    translate([(holderX)/2,holderY-fanSizeXY/2-10,0]) cylinder(r=(fanSizeXY-2)/2, h=10);
    translate([(holderX-fanSizeXY)/2+(fanSizeXY-fanScrewDistance)/2,holderY-fanSizeXY-6,0]) fanScrews();
    /* #translate([(holderX-fanSizeXY)/2,holderY-fanSizeXY-10,4]) cube([fanSizeXY,fanSizeXY,holderZ-screwPrinterGap-screwPrintergapExtra]); */

    /* air cutouts */
    translate([(holderX)/2-5,holderY-15,plateThickness-3]) cube([10,15,3]);
    translate([(holderX)/2-5,holderY-20-fanSizeXY,plateThickness-3]) cube([10,15,3]);

    translate([0,holderY-10-fanSizeXY/2-5,plateThickness-3]) cube([15,10,3]);
    translate([holderX-15,holderY-10-fanSizeXY/2-5,plateThickness-3]) cube([15,10,3]);

    /* translate([0,fanSizeXY-15,plateThickness-5]) cube([15,10,5]);
    translate([holderX-15,fanSizeXY-15,plateThickness-5]) cube([15,10,5]); */

    translate([0,40+fanSizeXY/2-5,plateThickness-3]) cube([15,10,3]);
    translate([holderX-15,40+fanSizeXY/2-5,plateThickness-3]) cube([15,10,3]);

    /* tool holder for hex keys */
    translate([holderX/2,0,plateThickness/2]) rotate([-90,0,0]) cylinder(r=4/2,h=50);
  }
}



adapterZ=4;

module adapterarm()
{
  hull()
  {
    cube([14,100,adapterZ]);
    translate([14/2,100,0]) cylinder(r=14/2, h=adapterZ);
  }
}

module rpiCaseHoles()
{
  union()
  {
    cylinder(r=1.4,h=adapterZ+0.1);
    translate([14+55+7,0,0]) cylinder(r=1.4,h=adapterZ+0.1);
  }

  translate([0,75,0])
  union()
  {
    cylinder(r=1.4,h=adapterZ+0.1);
    translate([14+55+7,0,0]) cylinder(r=1.4,h=adapterZ+0.1);
  }
}



module adapter()
{
  difference() {
    union()
    {
      adapterarm();
      translate([62+14,0,0]) adapterarm();
      translate([14,0,0]) cube([55+7,10,adapterZ]);

      /* stab */
      translate([14,25,0])
      hull()
      {
        cylinder(r=14/2,h=adapterZ);
        translate([0,50,0]) cylinder(r=14/2,h=adapterZ);
      }
      /* stab */
      translate([14+55+7,25,0])
      hull()
      {
        cylinder(r=14/2,h=adapterZ);
        translate([0,50,0]) cylinder(r=14/2,h=adapterZ);
      }

    }
    translate([14+(55+7-32)/2,5,0])
    union()
    {
      cylinder(r=1.5,h=adapterZ+0.1);
      translate([piCaseHoleDist,0,0]) cylinder(r=1.6,h=adapterZ+0.1);
    }
    translate([7,25,0]) rpiCaseHoles();
  }
}

module leftOffsetAdapter()
{
  translate([0,mountThickness-2,plateThickness])
  difference() {
    cube([(holderX-extruderX)/2,2,screwPrinterGap+screwPrintergapExtra]);
    translate([(holderX-extruderX)/4-1,0,(screwPrinterGap+screwPrintergapExtra)/2+1.5]) rotate([-90,0,0]) cylinder(r=1.6, h=10, center=false);
  }
}


/* translate([100,0,0]) */
adapter();

/* normal size */
/* carrier(); */

/* printable on MPSM print bed */
/* translate([-100,0,0])
difference() {
  carrier();
  translate([0,110,0]) cube([holderX,holderY,30]);
} */
