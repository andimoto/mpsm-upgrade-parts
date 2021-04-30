$fn=50;

layerHeigth=0.2;

fanXY=80;
fanZ=18;

cutoutHoleR=36/2;

wallThickness=2;


module fanOut()
{
  difference() {

    union()
    {
      difference() {
        hull()
        {
          cube([fanXY,fanXY,fanZ]);
          translate([fanXY/2,0,fanZ]) rotate([-90,0,0]) cylinder(r=cutoutHoleR,h=fanXY);
        }
        hull()
        {
          translate([wallThickness,wallThickness,0]) cube([fanXY-wallThickness*2,fanXY-wallThickness*2,fanZ]);
          translate([fanXY/2,wallThickness,fanZ]) rotate([-90,0,0]) cylinder(r=cutoutHoleR-wallThickness/2,h=fanXY-wallThickness*2);

        }
      }
      translate([fanXY/2,-20,cutoutHoleR]) rotate([-90,0,0]) cylinder(r=cutoutHoleR,h=20);
    }
    translate([fanXY/2,-20,cutoutHoleR]) rotate([-90,0,0]) cylinder(r=cutoutHoleR-wallThickness,h=20+wallThickness-layerHeigth);
  }
}
fanOut();
