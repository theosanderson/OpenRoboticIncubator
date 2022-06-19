use <helpers/gears.scad>
use <helpers/gear_grub.scad>
use <helpers/nemapedastal.scad>


 //  % everything_old();
    
    
    
    
 grub_length=11;
        
        motor_x = -3;
        motor_pos = [-20,0.1,95.4];
        cog_sep=1;
        cog_width=15;
        aperture_width = 110-3*2-2*2;
aperture_height = 60;
aperture_length = 50;


acrylic_thickness = 3;
compressed_gasket_thickness = 2.8;
door_thickness = 5;
        
        
door_frame_thickness = 2;
door_frame_depth = 30;
        $fn=50;
      door_hinge_pivot = 10; 
       
       pos1_vec = [0, -15.8, aperture_height + acrylic_thickness+8]; 
        cog2_width=20;
        pos2_vec = pos1_vec+[0,0,16.9];
        pos3_vec = pos2_vec+[0,4.9,15.1];
        
        door_hinge_hinge_thickness = 3;
        door_hinge_rod_radius=1.5;
        
        //translate(motor_pos) rotate([0,90,0]) cylinder(r=1, h=1000);
        
        module aperture() {
    #
    color("white") cube([aperture_width / 2, aperture_length, aperture_height]);

};

module doorframe() {
    difference() {
        translate([0, 0, -door_frame_thickness])
        cube([aperture_width / 2 + acrylic_thickness + door_frame_thickness, door_frame_depth, aperture_height + acrylic_thickness * 2 + door_frame_thickness * 2]);
        translate([0, door_frame_thickness, 0]) cube([aperture_width / 2 + acrylic_thickness, aperture_length - door_frame_thickness, aperture_height + acrylic_thickness * 2]);


        translate([0, 0, acrylic_thickness])
        cube([aperture_width / 2, aperture_length, aperture_height]);
    }
}


module half_door() {
    translate([0,0,-door_frame_thickness]) color("red") cube([aperture_width / 2 + acrylic_thickness+ door_frame_thickness, door_thickness, aperture_height + acrylic_thickness*2 + door_frame_thickness* 2]);



}



module door() {
    translate([0,-compressed_gasket_thickness-door_thickness,aperture_height/2])
   {
    translate([0, 0, -aperture_height / 2 ])half_door();
    translate([0, 0, -aperture_height / 2 ]) mirror([1,0,0]) half_door();
       
   }
  
}

module door_at_angle(angle){
  translate(pos1_vec) rotate([-angle,0,0]) translate(-pos1_vec) door();
    
}





module motor_cog() {
    translate(motor_pos+[24,0,0])rotate(90, [0, 1, 0])  gear_grub(hole_diameter=5.0,grub_diameter=20);
   color("blue") translate(motor_pos+[26,0,0])rotate(90, [0, 1, 0]) difference(){cylinder(r1=5,r2=3.3,h=4);
      cylinder(r=2.5,h=2);
      
       }; 
    
   translate(motor_pos+[30,0,0])  rotate(90, [0, 1, 0]) rotate(15, [0, 0, 1]) rotate(25)herringbone_gear(modul = 1, tooth_number = 9, width = cog_width, bore = 0, pressure_angle = 20, helix_angle = 20, optimized = true);

    
};



module top_cog() {
    translate(pos3_vec) rotate(90, [0, 1, 0]) difference(){ cylinder(r=5.3,h=16);cylinder(r=1.5,h=30);}; 
   translate(pos3_vec)  rotate(90, [0, 1, 0]) rotate(103, [0, 0, 1]) herringbone_gear(modul = 1, tooth_number = 18, width = cog_width, bore = 3, pressure_angle = 20, helix_angle = -20, optimized = true);
    translate(pos3_vec +[cog_width+cog_sep,0,0])
    rotate(90, [0, 1, 0]) rotate(21)herringbone_gear(modul = 1, tooth_number = 7, width = cog_width, bore = 3, pressure_angle = 20, helix_angle = 20, optimized = true);
    
};


module mid_cog() {
     translate(pos2_vec) translate([15,0,0]) rotate(90, [0, 1, 0]) difference(){ 
         cylinder(r=5,h=1);cylinder(r=1.5,h=30);}; 
   translate(pos2_vec)  rotate(90, [0, 1, 0]) rotate(41, [0, 0, 1]) herringbone_gear(modul = 1, tooth_number = 9, width = cog_width, bore = 3, pressure_angle = 20, helix_angle = -20, optimized = true);
    translate(pos2_vec +[cog_width+cog_sep,0,0])
    rotate(90, [0, 1, 0]) herringbone_gear(modul = 1, tooth_number = 25, width = cog_width, bore = 3, pressure_angle = 20, helix_angle = -20, optimized = true);
    
};



module bottom_cog() {
    //translate(pos1_vec) rotate(90, [0, 1, 0]) difference(){ cylinder(r=2.3,h=30);cylinder(r=1.5,h=30);}; 
    translate([-50,0,0]) translate(pos1_vec)rotate(90, [0, 1, 0]) difference(){ cylinder(r=7,h=10);  cylinder(r=1.5,h=10); }
    
   
    
    translate(pos1_vec)
    rotate(90, [0, 1, 0]) herringbone_gear(modul = 1, tooth_number = 25, width = cog_width, bore = 3, pressure_angle = 20, helix_angle = 20, optimized = true);

};


module hinge_base() {
    
    translate([0, 0, aperture_height + acrylic_thickness * 2 + door_frame_thickness * 1]) cube([door_hinge_hinge_thickness, 20, 20]);

    difference() {
        hull() {
              translate([0, -25, aperture_height + acrylic_thickness * 2 + door_frame_thickness * 1 + 10]) cube([door_hinge_hinge_thickness, 50, 45]);
            translate(pos1_vec)
            rotate(90, [0, 1, 0]) cylinder(r = 5, h = door_hinge_hinge_thickness);
            
            translate(pos2_vec)
            rotate(90, [0, 1, 0]) cylinder(r = door_hinge_rod_radius * 2, h = door_hinge_hinge_thickness);
            
            translate(pos3_vec)
            rotate(90, [0, 1, 0]) cylinder(r = door_hinge_rod_radius * 2, h = door_hinge_hinge_thickness);

        }

        translate(pos1_vec)# rotate(90, [0, 1, 0]) cylinder(r = door_hinge_rod_radius, h = door_hinge_hinge_thickness);
         translate(pos2_vec)# rotate(90, [0, 1, 0]) cylinder(r = door_hinge_rod_radius, h = door_hinge_hinge_thickness);
         translate(pos3_vec)# rotate(90, [0, 1, 0]) cylinder(r = door_hinge_rod_radius, h = door_hinge_hinge_thickness);
    }
    

};
module motor_mount() { 
    difference(){
    translate([motor_x,0,0]) hinge_base();
        
        
        translate(motor_pos)
        rotate(90,[0,1,0])rotate(0)  NEMA17_parallel_holes(
					height = 25,
					l_slot = 0,
					d_collar = 33,
					cc_mount = 31);  
        
        }
    };
    
module gear_side() { 
    difference(){
    translate([10,0,0]) hinge_base();
        
        translate(motor_pos-[motor_x,0,0])
        rotate(90,[0,1,0])rotate(0)  NEMA17_parallel_holes(
					height = 250,
					l_slot = 0,
					d_collar = 10,
					cc_mount = 31,d_mounts=9);  
        
     
    };
};

module top_piece(){
    translate([2,-20,120])
    cube([45,30,3]);
}
   




module frame_piece(){
    

doorframe_with_plate();
mirror([1,0,0]) doorframe_with_plate();

top_piece();
motor_mount();
    difference(){
    translate([-89,0,0])gear_side();
  translate([-60,-50,85])      cube([100,100,100]);
         
    }
#    translate([-80,0,67])      cube([80,25,5]);
    #    translate([-80,-20,120])      cube([80,25,5]);
translate([-grub_length,0,0])gear_side();
translate([cog_sep*3+cog_width*2+door_hinge_hinge_thickness,0,0])gear_side();

};

module door_complete(){
difference(){
translate([10+cog_sep+door_hinge_hinge_thickness,0,0])bottom_cog(); translate([-250,-10,19])   cube([500,50,50]);
    translate([-250,-5,19])   cube([500,65,55]);
     
}

translate([-5,-17,29]) 
    cube([10,10,10]);
translate([15,-17,29]) 
    cube([10,5,40]);
translate([-35,-17,29]) 
    cube([10,5,40]);
translate([-35,-20,29]) 
  #  cube([60,8,10]);


door_at_angle(0);
}

module mirror_copy(vec){
    children();
    mirror(vec) children();
};
module halfbox(){
    halfdist=110;
    translate([0,-halfdist,0])
    frame_piece();
    translate([0,-halfdist,0]) mirror_copy()
        difference() {
        translate([0, 0, -door_frame_thickness])
        cube([aperture_width / 2 + acrylic_thickness + door_frame_thickness, halfdist, aperture_height + acrylic_thickness * 2 + door_frame_thickness * 2]);
        translate([0, door_frame_thickness, 0]) cube([aperture_width / 2 + acrylic_thickness, halfdist, aperture_height + acrylic_thickness * 2]);


        translate([0, 0, acrylic_thickness])
        cube([aperture_width / 2, aperture_length, aperture_height]);
    }
}

module wholebox(){
    halfbox();
   mirror() mirror([0,1,0])  halfbox();
    }



centers_hole_spacing_for_frame=170;
    extra = 10;
    
plate_thickness=5;
    
    plate_z_offset = 30;
    plate_height=120;
    bolt_offset = -18;

module doorframe_with_plate(){
    doorframe();
    difference(){
        translate([0,door_frame_depth-plate_thickness,-plate_z_offset])
    cube([centers_hole_spacing_for_frame/2+extra,plate_thickness,plate_height]);
    #translate([0, 0, -door_frame_thickness])
        cube([aperture_width / 2 + acrylic_thickness + door_frame_thickness, door_frame_depth+20, aperture_height + acrylic_thickness * 2 + door_frame_thickness * 2]);
        
        
        translate([centers_hole_spacing_for_frame/2,0,bolt_offset
        ]) # rotate([-90,0,0])cylinder(r=2.5,h=100);
        
       translate([centers_hole_spacing_for_frame/2,0,bolt_offset+50
        ]) # rotate([-90,0,0])cylinder(r=2.5,h=100);
        
        translate([centers_hole_spacing_for_frame/2,0,bolt_offset+100
        ]) # rotate([-90,0,0])cylinder(r=2.5,h=100);
    
    
    translate([centers_hole_spacing_for_frame/2,15,bolt_offset+100
        ]) # rotate([-90,0,0])cylinder(r=6,h=10);
    }
    
  
}


    

modules = [0];

for(m = modules) {
    select(m) {
       

frame_piece();

door_complete();




color("blue") translate([10+cog_sep+door_hinge_hinge_thickness,0,0]) top_cog();
translate([cog_sep+door_hinge_hinge_thickness,0,0])motor_cog();

translate([10+cog_sep+door_hinge_hinge_thickness,0,0])color("red") mid_cog();



    }
}

module select(m) {
    children(m);
}  



