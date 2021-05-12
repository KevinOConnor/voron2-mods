// Reverse bowden tube guide for rear panel
//
// Copyright (C) 2021  Kevin O'Connor <kevin@koconnor.net>
//
// This file may be distributed under the terms of the GNU GPLv3 license.

nut_space_width = 15;
insert_pillar_width = 5;
insert_pillar_length = 5;
insert_pillar_height = 5;
top_length = 6;
bottom_length = 8;
panel_height = 6;
panel_grip_height = 3;
panel_grip_length = 7;
tube_guide_dia = 9;
tube_guide_height = 20;
tube_dia = 4.5;
screw_dia = 2.5;
screw_head_dia = 5.5;
CUT = 0.01;
$fs = 0.5;

module tube_guide() {
    total_width = nut_space_width + 2*insert_pillar_width + 2*panel_grip_length;
    total_length = (top_length + insert_pillar_length + bottom_length
                    + tube_guide_dia + panel_grip_length);
    module panel_grip() {
        cube([total_width, total_length, panel_grip_height]);
    }
    module top_seal() {
        top_seal_length = top_length + insert_pillar_length;
        top_seal_height = panel_grip_height + panel_height;
        cube([total_width, top_seal_length, top_seal_height]);
    }
    module rail_guide_pillars() {
        pillar_x = (total_width - nut_space_width) / 2 - insert_pillar_width;
        height = panel_grip_height + panel_height + insert_pillar_height;
        translate([pillar_x, top_length, 0])
            cube([insert_pillar_width, insert_pillar_length, height]);
        pillar_x2 = pillar_x + nut_space_width + insert_pillar_width;
        translate([pillar_x2, top_length, 0])
            cube([insert_pillar_width, insert_pillar_length, height]);
    }
    tube_x = total_width/2;
    tube_y = top_length + insert_pillar_length + bottom_length + tube_guide_dia/2;
    tube_height = panel_grip_height + tube_guide_height;
    module tube_guide() {
        // tube guide
        translate([tube_x, tube_y, 0])
            cylinder(d=tube_guide_dia, h=tube_height);
        // connect tube guide
        translate([(total_width - tube_guide_dia)/2, 0, 0])
            cube([tube_guide_dia, tube_y, panel_grip_height + panel_height]);
    }

    module tubecut() {
        translate([tube_x, tube_y, -CUT])
            cylinder(d=tube_dia, h=tube_height+2*CUT);
    }

    module screwcut() {
        x = total_width / 2;
        y = top_length + insert_pillar_length/2;
        top_seal_height = panel_grip_height + panel_height;
        translate([x, y, -CUT])
            cylinder(d=screw_dia, h=top_seal_height+2*CUT);
        bury = 3;
        translate([x, y, -CUT])
            cylinder(d=screw_head_dia, h=bury+CUT);
        translate([x, y, bury-CUT])
            cylinder(d1=screw_head_dia, d2=screw_dia, h=1.5+CUT);
    }

    module ziptiecut() {
        tie_length = 2;
        tie_height = 3;
        tie_dia = 5;
        tie_y = tube_y + (tie_dia + tube_dia)/2 + .5;
        tie_z_offset = 2;
        tie_z = tube_height - tie_z_offset - tie_height;
        translate([total_width/2, tie_y, tie_z])
            difference() {
               cylinder(h=tie_height, d=tie_dia + 2*tie_length);
                cylinder(h=tie_height, d=tie_dia);
            }
    }

    difference() {
        union() {
            panel_grip();
            top_seal();
            rail_guide_pillars();
            tube_guide();
        }
        tubecut();
        screwcut();
        ziptiecut();
    }
}

//
// Object selection
//

tube_guide();
