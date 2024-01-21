$fn=50;
bottom_pillar_width=8;
top_pillar_width=12;
pillar_height=10;

pillar_sep_x=18;
pillar_sep_y=55;
pillar_pos_height=15;

cavity_diameter=40;

holder_size_x=30;
holder_size_y=70;

holder_size_x_bottom=70;

holder_height=25;

hole_diam=6.5;
top_thickness=5;

module pillar(tolerance =0){
    hull(){
        translate([-bottom_pillar_width/2-tolerance/2,-bottom_pillar_width/2-tolerance/2,0])cube([bottom_pillar_width+tolerance,bottom_pillar_width+tolerance,0.0001]);
        translate([-top_pillar_width/2-tolerance/2,-top_pillar_width/2-tolerance/2,pillar_height])cube([top_pillar_width+tolerance,top_pillar_width+tolerance,0.0001]);
    }
};


module suck(){
    difference(){
translate([-holder_size_x/2,-holder_size_y/2,holder_height])cube([holder_size_x,holder_size_y,top_thickness]);  
       cylinder(r=hole_diam/2,h=100); 
    } 
translate([pillar_sep_x/2,pillar_sep_y/2,pillar_pos_height]) pillar();
    translate([pillar_sep_x/2,-pillar_sep_y/2,pillar_pos_height]) pillar();
    translate([-pillar_sep_x/2,pillar_sep_y/2,pillar_pos_height]) pillar();
    translate([-pillar_sep_x/2,-pillar_sep_y/2,pillar_pos_height]) pillar();
    
}
suck();

module holder(){
    difference(){
    translate([-holder_size_x_bottom/2,-holder_size_y/2,0])cube([holder_size_x_bottom,holder_size_y,holder_height]);
        cylinder(r=cavity_diameter/2,h=100);
         translate([pillar_sep_x/2,pillar_sep_y/2,pillar_pos_height]) #pillar(tolerance=0.3);
        translate([-pillar_sep_x/2,pillar_sep_y/2,pillar_pos_height]) #pillar(tolerance=0.3);
        translate([-pillar_sep_x/2,-pillar_sep_y/2,pillar_pos_height]) #pillar(tolerance=0.3);
        translate([pillar_sep_x/2,-pillar_sep_y/2,pillar_pos_height]) #pillar(tolerance=0.3);
    }
}
    
   
    
//translate([0,0,-10])  holder();

