$fn=50;

screwDistance=56;
holderX=screwDistance+5+5;
holderY=120+50; /* size of rpi display case */
holderZ=15;
mountThickness=2;
screwPrinterGap=8; /* distance of screw to front plate of the mpsm printer */
screwPrintergapExtra=5;
screwR=2;
extruderX=44;

module rpi_holder()
{
  difference()
  {
    cube([holderX,holderY,holderZ]);
    translate([0,mountThickness,holderZ-screwPrinterGap-screwPrintergapExtra])
      cube([holderX,holderY-mountThickness,screwPrinterGap+screwPrintergapExtra]);

    translate([(holderX-extruderX)/2,0,mountThickness])
      #cube([extruderX,mountThickness,screwPrinterGap+screwPrintergapExtra]);
  }
}

rpi_holder();
