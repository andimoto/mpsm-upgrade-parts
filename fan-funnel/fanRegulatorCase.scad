$fn=150;

pcbX=17.5;
pcbY=35;
pcbZ=4;
pcbThickness=1.5;

caseZ=15;

wallThickness=2;
extra=0.1;

potiZ=11;
potiY=10;

potiYtrans=12.5;

usbPort1Z=7;
usbPort2Z=4;

screwPlateY=10;
screwPlateZ=4;

screwR=3/2;
screwHeadR=5/2;

module fanRegCase()
{
  difference() {
    cube([pcbX+wallThickness*2,pcbY+wallThickness*2,caseZ+wallThickness]);
    translate([wallThickness,wallThickness,wallThickness]) cube([pcbX,pcbY,caseZ+wallThickness+extra]);

    /* poti cutout */
    translate([0,wallThickness+potiYtrans,wallThickness+pcbZ])
      cube([wallThickness,potiY,potiZ+wallThickness]);

    /* usb port cutout */
    translate([wallThickness,0,wallThickness+pcbZ])
      cube([pcbX,wallThickness,potiZ]);

    translate([wallThickness,pcbY+wallThickness,wallThickness+pcbZ-pcbThickness])
      cube([pcbX,wallThickness,potiZ+pcbThickness]);
  }

  translate([0,-screwPlateY,0]) screwPlate();
  translate([0,pcbY+wallThickness*2,0]) screwPlate();


}

module screwPlate()
{
  difference() {
    cube([pcbX+wallThickness*2,screwPlateY,wallThickness]);
    translate([(pcbX+wallThickness*2)/2,screwPlateY/2,wallThickness/2]) cylinder(r1=screwR,r2=screwHeadR,h=wallThickness/2);
    translate([(pcbX+wallThickness*2)/2,screwPlateY/2,0]) cylinder(r=screwR,h=wallThickness/2);
  }
}
/* translate([0,-screwPlateY,0]) screwPlate(); */

module fanRegLid()
{
  translate([0,0,caseZ+wallThickness]) cube([pcbX+wallThickness*2,pcbY+wallThickness*2,wallThickness]);
  translate([wallThickness,0,wallThickness+pcbZ+usbPort1Z]) cube([pcbX,potiYtrans,wallThickness*3]);
  translate([wallThickness,pcbY+wallThickness*2-potiYtrans,wallThickness+pcbZ+usbPort1Z]) cube([pcbX,potiYtrans,wallThickness*3]);
}


fanRegCase();
translate([0,0,20]) fanRegLid();
