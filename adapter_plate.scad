// Main dimensions
margin = 5;  // margin around holes
plate_thickness = 3;
corner_radius = 5;

// Corner holes
corner_hole_diameter = 7;
corner_holes_width = 90;
corner_holes_height = 71;

// Center holes
center_hole_diameter = 4;
center_holes_width = 62;
center_holes_height = 82;

module complexBorder() {
    minkowski() {
        union() {
            // Outer rectangle based on corner holes
            translate([-(corner_holes_width/2 + margin), -(corner_holes_height/2 + margin)])
            square([corner_holes_width + 2*margin, corner_holes_height + 2*margin]);
            
            // Inner rectangle based on center holes
            translate([-(center_holes_width/2 + margin), -(center_holes_height/2 + margin)])
            square([center_holes_width + 2*margin, center_holes_height + 2*margin]);
        }
        circle(r=corner_radius, $fn=32);
    }
}

// Create the base plate with complex border
difference() {
    // Main plate
    translate([110/2, 85/2, 0])  // Center the shape
    linear_extrude(height=plate_thickness)
    complexBorder();
    
    // Corner holes
    for(x = [0,1], y = [0,1]) {
        translate([
            (110 - corner_holes_width)/2 + x*corner_holes_width,
            (85 - corner_holes_height)/2 + y*corner_holes_height,
            -1
        ])
        cylinder(d=corner_hole_diameter, h=plate_thickness+2, $fn=32);
    }
    
    // Center holes
    for(x = [0,1], y = [0,1]) {
        translate([
            (110 - center_holes_width)/2 + x*center_holes_width,
            (85 - center_holes_height)/2 + y*center_holes_height,
            -1
        ])
        cylinder(d=center_hole_diameter, h=plate_thickness+2, $fn=32);
    }
}
