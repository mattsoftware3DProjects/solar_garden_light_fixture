$fn = 180;

solar_light_radius = 54.8 / 2 + 0.25; // plus a little room for putting the light in the hole
solar_light_height = 30.5;
solar_led_width = 8.5;

railing_width = 38.62;
railing_height = 25.8;

wall_thickness = 5;
gap = 0.5;
hook_width = solar_light_radius * 2 + wall_thickness;

solar_light_offset = 15;
solar_light_height_offset = -2;
top_thickness = wall_thickness + 10;

module railing(length = 100) {
    translate([-length/2, 0, 0]) cube([length,railing_width,railing_height]);
}
module solar_light () {
    projection = solar_light_radius*2;
    cylinder(r=solar_light_radius, h=solar_light_height);
    translate([0, 0, -projection]) cylinder(r1 = projection, r2 = solar_led_width, h=solar_light_radius*2);
}

module hook () {
    height = railing_height + top_thickness + wall_thickness;
    width = railing_width + wall_thickness * 2;
    translate([-hook_width/2, width-wall_thickness, -wall_thickness]) {
        rotate([0,90,0]) {
            linear_extrude(hook_width) {
                polygon(
                    points = [
                        [0,0],
                        [-height, 0], // top corner
                        [-height, -width], // other top corner
                        [-height+top_thickness, -width],
                        [-height+top_thickness+wall_thickness, -width+wall_thickness],
                        [-height+top_thickness, -width+wall_thickness], // inside corner
                        [-height+top_thickness, -wall_thickness], // other inside corner
                        [-wall_thickness, -wall_thickness], // other inside corner
                        [-wall_thickness, -wall_thickness*2],
                        [0, -wall_thickness*2]
                    ]
                );
            }
        }
    }
}
module platform(length = 100) {
    translate([-hook_width/2, -length, railing_height]) cube([hook_width, length, top_thickness]);
}
difference () {
    union () {
        hook();
        platform(solar_light_radius+5+solar_light_offset);
        %railing(200);
    }
    #translate([0, -solar_light_offset, (railing_height+top_thickness/2)+solar_light_height_offset]) rotate([-10,0,0]) solar_light();
}

