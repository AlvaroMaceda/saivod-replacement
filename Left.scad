MEASURE_TO_BE_REWRITTEN = 10;

module base_curved(width, depth, height) {
    difference() {
        resize(newsize=[width,depth,height])
            sphere(r=MEASURE_TO_BE_REWRITTEN);            

        translate( [0,0, width/2] ) 
            cube( size = width, center = true);
    }
}


// Not in use
module base_straight(width, depth, height, margin) {
    resize(newsize=[width-margin,depth-margin,height])
        cylinder(h=MEASURE_TO_BE_REWRITTEN,r=MEASURE_TO_BE_REWRITTEN);
}

module piece() {
    
    BASE_WIDTH = 60;
    BASE_DEPTH = 30;
    BASE_CURVED_HEIGHT = 10;    // Height of the curved zone
    //BASE_STRAIGHT_HEIGHT = 3;  // Height of the straight zone
    //BASE_STRAIGHT_MARGIN = 5;   // Margin of the straight zone
    SHAFT_X = -10;              
    SHAFT_Y = -10;
    SHAFT_POSITION = [SHAFT_X,SHAFT_Y,0]; // Position of the shaft, relative to the center of the base
    
    base_curved(BASE_WIDTH,BASE_DEPTH,BASE_CURVED_HEIGHT);
    //base_straight(BASE_WIDTH,BASE_DEPTH,BASE_STRAIGHT_HEIGHT,BASE_STRAIGHT_MARGIN);
    base_spring_dock();
    shaft(SHAFT_X,SHAFT_Y);
}

module base_spring_dock() {
    EXTERNAL_RADIUS = 13;
    INTERNAL_RADIUS = 12; 
    HEIGHT = 2;
    DISPLACEMENT = 2;
    difference() {
        translate([0,0,-1]) cylinder(h=HEIGHT+DISPLACEMENT,r=EXTERNAL_RADIUS);
        translate([0,0,-DISPLACEMENT]) cylinder(h=HEIGHT+2*DISPLACEMENT,r=INTERNAL_RADIUS);
    }
}

module shaft(x,y) {
    SHAFT_HEIGHT = 20;
    SHAFT_RADIUS = 1;
    
    translate([x,y,0])
        cylinder(r=SHAFT_RADIUS,h=SHAFT_HEIGHT,center=false);
}


module test() {
    color("red");
    //cylinder(r=1,h=40,center=false);
    //resize(newsize=[60,30,10])

    //translate([0,0,2.5])
    //    cube([60,30,5],true);
}

$fn=50;

piece();
test();