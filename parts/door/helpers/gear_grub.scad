/*---------------------------------------------------------\
|     From: Ekobots Innovation Ltda - www.ekobots.com      |
|       by: Juan Sirgado y Antico - www.jsya.com.br        |
|----------------------------------------------------------|
|            Program Gear Grub - 2013/08/13                |
|               All rights reserved 2013                   |
|---------------------------------------------------------*/
// Derivation of:
// Parametric Pulley by droftarts January 2012
//---------------------------------------------------------|
//gear_grub();
//---------------------------------------------------------|
module gear_grub
(
   // Grub parameters
   grub_height = 10,    // grub height
   grub_diameter =  17, // grub diameter
   grub_hole = 1,       // grub hole 0=No, 1=Yes
   hole_diameter = 5,   // grub hole (motor shaft diameter)

   // Nut home parameters
   no_of_nuts = 1,         // number of nuts
   nut_angle = 120,        // angle between nuts, use (360/no_of_nuts) for symetric nuts
   nut_elevation = 0,      // elevation of nuts
   nut_shaft_distance = 0, // nuts motor shaft distance

   // Nut parameters
   m3_diameter = 3,   // m3 screw diameter
   m3_nut_hex = 1,    // m3 nut hex (0=square nut 1=hex nut)
   m3_nut_size = 6,   // m3 nut size
   m3_nut_height = 3  // m3 nut height
)
{
   difference() 
   {
      //grub base      
      union()
      {
         translate([0,0,-.5])
           cylinder(grub_height-1, grub_diameter/2, grub_diameter/2, center=true, $fn=90);
         translate([0,0,(grub_height/2)-.5])
            cylinder(1, (grub_diameter/2)-1, (grub_diameter/2)-1, center=true, $fn=90);
         translate([0,0,(grub_height/2)-1])
            rotate_extrude($fn=60)
               translate([(grub_diameter/2)-1,0,0]) circle(1,$fn=60);
      }
      //grub hole      
      if ( grub_hole == 1 ) 
         cylinder(grub_height+1.2, hole_diameter/2, hole_diameter/2, center=true, $fn=30);
   
      //captive nut and grub screw holes
      if ( grub_height < m3_nut_size ) 
            {
         echo ("CAN'T DRAW CAPTIVE NUTS, HEIGHT LESS THAN NUT DIAMETER!");
      } 
         else 
      {
         if ( (grub_diameter - hole_diameter)/2 < m3_nut_height + 1 ) 
         {
            echo ("CAN'T DRAW CAPTIVE NUTS, DIAMETER TOO SMALL FOR NUT DEPTH!"); 
         }         
         else 
         {    
            for(nut_num=[1:no_of_nuts])
            { 
               screw_nut_hole(nut_num, nut_angle, nut_elevation, nut_shaft_distance, 
                              m3_nut_height, m3_nut_size, m3_nut_hex, m3_diameter, 
                              grub_height, grub_diameter, hole_diameter);
            }
         }
      }     
   }
}
//---------------------------------------------------------|
module screw_nut_hole(nut_num, nut_angle, nut_elevation, nut_shaft_distance, 
                      m3_nut_height, m3_nut_size, m3_nut_hex, m3_diameter, 
                      grub_height, grub_diameter, hole_diameter)
{
   rotate([0,0,nut_num*nut_angle])
      translate([0,0,nut_elevation])
         rotate([90,0,0])
            union()
            {
               //entrance
               translate([0,-grub_height/4-0.5,hole_diameter/2+m3_nut_height/2+nut_shaft_distance]) 
                  cube([m3_nut_size,grub_height/2+1,m3_nut_height],center=true);
               //nut
               if ( m3_nut_hex > 0 )
               {
                  // hex nut
                  translate([0,0.25,hole_diameter/2+m3_nut_height/2+nut_shaft_distance]) 
                     rotate([0,0,30]) 
                        cylinder(r=m3_nut_size/1.73,h=m3_nut_height,center=true,$fn=6);
               } 
               else 
               {
                  // square nut
                  translate([0,0.25,hole_diameter/2+m3_nut_height/2+nut_shaft_distance])
                     cube([m3_nut_size,m3_nut_size,m3_nut_height],center=true);
               }
               //grub screw hole
               rotate([0,0,22.5])cylinder(r=m3_diameter/2,h=grub_diameter/2+1,$fn=20);
            }
}

gear_grub();
//---------------------------------------------------------|