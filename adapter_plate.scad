// Main dimensions
plate_width = 110;
plate_height = 85;
plate_thickness = 3;
corner_radius = 5;

// Corner holes
corner_hole_diameter = 7;
corner_holes_width = 90;
corner_holes_height = 71;

// Center holes
center_hole_diameter = 4;
center_holes_width = 62;  // Changed from 82 to 62
center_holes_height = 82; // Changed from 62 to 82

module roundedRect(width, height, radius) {
    hull() {
        translate([radius, radius, 0])
        circle(r=radius);
        
        translate([width-radius, radius, 0])
        circle(r=radius);
        
        translate([radius, height-radius, 0])
        circle(r=radius);
        
        translate([width-radius, height-radius, 0])
        circle(r=radius);
    }
}

// Create the base plate with rounded corners
difference() {
    // Main plate
    linear_extrude(height=plate_thickness)
    roundedRect(plate_width, plate_height, corner_radius);
    
    // Corner holes
    for(x = [0,1], y = [0,1]) {
        translate([
            (plate_width - corner_holes_width)/2 + x*corner_holes_width,
            (plate_height - corner_holes_height)/2 + y*corner_holes_height,
            -1
        ])
        cylinder(d=corner_hole_diameter, h=plate_thickness+2, $fn=32);
    }
    
    // Center holes
    for(x = [0,1], y = [0,1]) {
        translate([
            (plate_width - center_holes_width)/2 + x*center_holes_width,
            (plate_height - center_holes_height)/2 + y*center_holes_height,
            -1
        ])
        cylinder(d=center_hole_diameter, h=plate_thickness+2, $fn=32);
    }
}
