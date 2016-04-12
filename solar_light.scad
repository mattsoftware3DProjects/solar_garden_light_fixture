$fn = 180;

solar_light_radius = 54.8 / 2;
solar_light_height = 30.5;
solar_led_width = 8.5;

railing_width = 38.62;
railing_height = 25.8;

wall_thickness = 10;
hook_width = solar_light_radius * 2 + wall_thickness;

solar_light_offset = 15;
solar_light_height_offset = -2;
top_thickness = wall_thickness - solar_light_height_offset + 2;

module railing(length = 100, gap = 1) {
    translate([-length/2,-gap,-gap]) cube([length,railing_width+gap*2,railing_height+gap]);
}
module solar_light () {
    projection = solar_light_radius*2;
    cylinder(r=solar_light_radius, h=solar_light_height);
    translate([0, 0, -projection]) cylinder(r1 = projection, r2 = solar_led_width, h=solar_light_radius*2);
}

module hook () {
    gap = 1;
    translate([0, wall_thickness+gap, 0]) {
        difference() {
            translate([-hook_width/2, -wall_thickness-gap, 0]) cube([hook_width,railing_width + (wall_thickness+gap) * 2, railing_height + top_thickness]);
            #railing(200, gap);
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
    }
    #translate([0, -solar_light_offset, (railing_height+top_thickness/2)+solar_light_height_offset]) rotate([-10,0,0]) solar_light();
}

