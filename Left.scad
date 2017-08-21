MEASURE_TO_BE_REWRITTEN = 10;

module base_curved(width, depth, height) {
    
    SLICE_HEIGHT = 0.5; // This value is the part we add to the sfere to be cutted. It's adjusted empirically
    
    difference() {
    
        difference() {
            resize(newsize=[width,depth,(height+SLICE_HEIGHT)*2])
                sphere(r=MEASURE_TO_BE_REWRITTEN);            

            translate( [0,0, width/2] ) 
                cube( size = width, center = true);
        }
    
        translate([0,0,-height/2 - height])
                    cube([width,depth,height],true);
    }
}

module base_spring_dock() {
    EXTERNAL_RADIUS = 7;
    INTERNAL_RADIUS = 6; 
    HEIGHT = 1;
    DISPLACEMENT = 1;
    difference() {
        translate([0,0,-1]) cylinder(h=HEIGHT+DISPLACEMENT,r=EXTERNAL_RADIUS);
        translate([0,0,-DISPLACEMENT]) cylinder(h=HEIGHT+2*DISPLACEMENT,r=INTERNAL_RADIUS);
    }
}

module piece() {
    
    BASE_WIDTH = 30;
    BASE_DEPTH = 16;
    BASE_CURVED_HEIGHT = 4;    // Height of the curved zone
    SHAFT_X = -5.2;              
    SHAFT_Y = -5.2;
    SHAFT_POSITION = [SHAFT_X,SHAFT_Y,0]; // Position of the shaft, relative to the center of the base
    
    base_curved(BASE_WIDTH,BASE_DEPTH,BASE_CURVED_HEIGHT);
    base_spring_dock();
    shaft(SHAFT_X,SHAFT_Y);
    
    LEFT_FLAP_X = -14;
    RIGHT_FLAP_X = 14;
    
    translate([LEFT_FLAP_X,0,0])
        flap();
   
    translate([RIGHT_FLAP_X,0,0])
        mirror()
            flap();
}



module shaft(x,y) {
    SHAFT_HEIGHT = 12;
    SHAFT_RADIUS = 1;
    
    translate([x,y,0])
        cylinder(r=SHAFT_RADIUS,h=SHAFT_HEIGHT,center=false);
}


module flap_hook(width,depth) {
   
    MARGIN = 1;
    
    size = [width, depth , width];
    radio = sqrt(2*pow(width,2));
    
    difference() {
        
        cube(size);

        translate([0,-MARGIN,0]) // To avoid surface connection
            rotate([0,-45,0])
                cube([radio,depth+2*MARGIN,radio],false);
    }
}

module flap_support(width,height,depth) {
    translate([-width,0,0])
        cube([width,depth,height]);  
}


module flap() {
    
    FLAP_HOOK_WIDTH = 3;
    FLAP_HOOK_HEIGHT = FLAP_HOOK_WIDTH; // Not tested with non square hooks
    FLAP_HOOK_DEPTH = 5;
    
    FLAP_SUPPORT_WIDTH = 2;
    FLAP_SUPPORT_HEIGHT = 7;
    FLAP_SUPPORT_DEPTH = FLAP_HOOK_DEPTH;
    
    translate([0,-FLAP_HOOK_DEPTH/2,0])
        mirror() {   
            translate([-FLAP_HOOK_WIDTH-FLAP_SUPPORT_WIDTH,0,FLAP_SUPPORT_HEIGHT-FLAP_HOOK_HEIGHT])
                flap_hook(FLAP_HOOK_WIDTH,FLAP_HOOK_DEPTH);
            flap_support(FLAP_SUPPORT_WIDTH,FLAP_SUPPORT_HEIGHT,FLAP_SUPPORT_DEPTH);
        }
}

$fn=100;

piece();









