/* mpsm_mini_tool_holder.scad
Author: andimoto@posteo.de
----------------------------
for placing assambled parts and
single parts go to end of this file!
 */
$fn=50;

wallThickness = 1; //mm
xSize = 10;
ySize = 15;
zSize = 100;
mpsmScrewRadius=1.55;
screwDepth=ySize-9;

rAllenKey=1.3;
cylinderHeight=10;
extra=5;

pinHeigth=15;

module tool_holder()
{
  difference() {
    cube([xSize,ySize,zSize]);
    cube([xSize, ySize-wallThickness, zSize-wallThickness]);

    /* mounting hole */
    translate([(xSize/2),screwDepth,zSize-wallThickness]) cylinder(r=mpsmScrewRadius,h=wallThickness);

    #translate([0,0,zSize-wallThickness/2]) rotate([0,0,45]) cube([4,4,wallThickness],center=true);
    #translate([xSize,0,zSize-wallThickness/2]) rotate([0,0,45]) cube([4,4,wallThickness],center=true);
  }

  /* allenkey holder */
  translate([xSize/2,ySize+rAllenKey,zSize-cylinderHeight-extra])
  union()
  {
    difference()
    {
      cylinder(r=rAllenKey+1,h=cylinderHeight,center=false);
      cylinder(r=rAllenKey,h=cylinderHeight,center=false);
    }
  }

  translate([xSize/2,ySize+pinHeigth,zSize/6]) rotate([90,0,0]) pins();

}

/* extra pins */
module pins()
{
  cylinder(r=2, h=pinHeigth);
  cylinder(r=2+1, h=3);
}


tool_holder();
