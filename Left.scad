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

module shaft(x,y) {
    SHAFT_HEIGHT = 12;
    SHAFT_RADIUS = 1;
    
    translate([x,y,0])
        cylinder(r=SHAFT_RADIUS,h=SHAFT_HEIGHT,center=false);
}


module test() {
    
}

$fn=50;

piece();
//test();