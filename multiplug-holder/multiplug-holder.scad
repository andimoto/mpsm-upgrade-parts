$fn=50;

plugX=100;
plugZ=41;

holderY=10;
wallThickness=3;
sideThickness=10;

cableHoleR=30/2;
temp=(plugX-cableHoleR*2)/2;

module multiplugHolder()
{
  difference() {

    union()
    {
      translate([0,holderY,0]) cube([temp+wallThickness,cableHoleR,wallThickness]);
      translate([70-2,holderY,0]) cube([temp+wallThickness,cableHoleR,wallThickness]);

      translate([wallThickness*2+20,holderY,0]) rotate([0,-90,0]) cube([temp+wallThickness*2,cableHoleR,wallThickness]);
      translate([plugX+wallThickness-20,holderY,0]) rotate([0,-90,0]) cube([temp+wallThickness*2,cableHoleR,wallThickness]);

      difference() {
        cube([plugX+wallThickness*2,holderY+wallThickness,plugZ+wallThickness]);
        translate([wallThickness,0,0]) cube([plugX,holderY,plugZ]);

        translate([0,holderY,0])
        hull()
        {
          translate([plugX/2+wallThickness-cableHoleR,0,0]) cube([cableHoleR*2,wallThickness,cableHoleR]);
          translate([plugX/2+wallThickness,0,cableHoleR]) rotate([-90,0,0]) cylinder(r=cableHoleR,h=wallThickness);
        }
      }
    }
    translate([wallThickness*2+10,holderY+5,42]) rotate([-20,0,0]) cube([cableHoleR,cableHoleR,wallThickness]);
    translate([plugX+wallThickness-30,holderY+5,42]) rotate([-20,0,0]) cube([cableHoleR,cableHoleR,wallThickness]);

    /* screw holes */
    #translate([10,holderY+wallThickness+6,0]) cylinder(r=3/2,h=wallThickness);
    translate([plugX+wallThickness*2-10,holderY+wallThickness+6,0]) cylinder(r=3/2,h=wallThickness);
  }


}


multiplugHolder();
