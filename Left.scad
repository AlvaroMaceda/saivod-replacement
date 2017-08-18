module base_curved(width, depth, height) {
    difference() {
        resize(newsize=[width,depth,height])
            sphere(r=10);            

        translate( [0,0, width/2] ) 
            cube( size = width, center = true);
    }
}

module base_straight(width, depth, height, margin) {
    resize(newsize=[width-margin,depth-margin,height])
        cylinder(h=10,r=10);
}

module base() {
    
    BASE_WIDTH = 60;
    BASE_DEPTH = 30;
    BASE_CURVED_HEIGHT = 10;    // Height of the curved zone
    BASE_STRAIGHT_HEIGHT = 3;  // Height of the straight zone
    BASE_STRAIGHT_MARGIN = 5;   // Margin of the straight zone
    
    base_curved(BASE_WIDTH,BASE_DEPTH,BASE_CURVED_HEIGHT);
    base_straight(BASE_WIDTH,BASE_DEPTH,BASE_STRAIGHT_HEIGHT,BASE_STRAIGHT_MARGIN);
}


module test() {
    color("red");
    //resize(newsize=[60,30,10])
    // cylinder(h=10,r=10);
    //translate([0,0,2.5])
    //    cube([60,30,5],true);
}



base();
test();