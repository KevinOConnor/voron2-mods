// Side hinge to work with slightly oversized door panels
//
// Copyright (C) 2021  Kevin O'Connor <kevin@koconnor.net>
//
// This file may be distributed under the terms of the GNU GPLv3 license.

screw_dia = 3.0;
pivot_dia = 5.5;
door_width = 40;
door_grip_height = 3;
door_grip_length = 15;
door_rail_length_overlap = 8;
door_hinge_height_offset = 2.5;
door_hinge_length_offset = 12;
hinge_width = 25;
panel_height = 3;
panel_grip_height = 2;
panel_grip_length = 7;
rail_length = 20;
rail_insert_length = 6;
insert_pillar_width = 5;
insert_pillar_height = 5;
screw_head_dia = 5.7;
CUT=.01;
$fs = 0.5;

//
// Hinge attached to door panel
//

module door_hinge() {
    full_length = door_grip_length + door_hinge_length_offset;
    full_height = pivot_dia;
    module grip() {
        // XXX - add corner filet?
        cube([door_width, full_length, door_grip_height]);
    }
    module brace() {
        cube([door_width, door_hinge_length_offset, full_height]);
    }

    module pivot() {
        translate([0, 0, pivot_dia/2])
            rotate([0, 90, 0])
                cylinder(d=pivot_dia, h=door_width);
    }
    module screwcut() {
        translate([-CUT, 0, pivot_dia/2])
            rotate([0, 90, 0])
                cylinder(d=screw_dia, h=door_width+2*CUT);
    }

    module hingecut() {
        brace_length_remaining = 5;
        x_offset = (door_width - hinge_width)/2;
        y = pivot_dia/2 + door_hinge_length_offset - brace_length_remaining;
        translate([x_offset, -(pivot_dia/2)-CUT, -CUT])
            cube([hinge_width, y+2*CUT, full_height+2*CUT]);
    }

    difference() {
        union() {
            grip();
            brace();
            pivot();
        }
        screwcut();
        hingecut();
    }
}

//
// Hinge attached to 2020 frame
//

module frame_hinge() {
    full_width = hinge_width - .5;
    beam_length_offset = (rail_length - rail_insert_length)/2;
    base_length = (door_hinge_height_offset + beam_length_offset
                   + rail_insert_length);
    base_height = panel_grip_height + panel_height;
    full_length = base_length + panel_grip_length;
    module panel_grip() {
        cube([full_width, full_length, panel_grip_height]);
    }
    module base() {
        cube([full_width, base_length, base_height]);
    }
    module rail_guide_pillars() {
        pillar_y = base_length - rail_insert_length;
        pillar_x = 0;
        height = panel_grip_height + panel_height + insert_pillar_height;
        translate([pillar_x, pillar_y, 0])
            cube([insert_pillar_width, rail_insert_length, height]);
        pillar_x2 = full_width - insert_pillar_width;
        translate([pillar_x2, pillar_y, 0])
            cube([insert_pillar_width, rail_insert_length, height]);
    }

    pivot_y = -(pivot_dia/2);
    pivot_rail_overlap = door_rail_length_overlap + door_hinge_length_offset;
    pivot_z = rail_length - pivot_rail_overlap + base_height;
    module pivot() {
        module main() {
            translate([0, pivot_y, pivot_z])
                rotate([0, 90, 0])
                    cylinder(d=pivot_dia, h=full_width);
        }
        extra_base_length = 2;
        hull() {
            main();
            translate([0, -extra_base_length, 0])
                cube([full_width, extra_base_length+CUT, base_height]);
        }
    }
    module pivotcut() {
        translate([-CUT, pivot_y, pivot_z])
            rotate([0, 90, 0])
                cylinder(d=screw_dia, h=full_width+2*CUT);
    }
    module screwcut() {
        x = full_width / 2;
        y = base_length - rail_insert_length/2;
        top_seal_height = panel_grip_height + panel_height;
        translate([x, y, -CUT])
            cylinder(d=screw_dia, h=top_seal_height+2*CUT);
        bury = 3;
        translate([x, y, -CUT])
            cylinder(d=screw_head_dia, h=bury+CUT);
        translate([x, y, bury-CUT])
            cylinder(d1=screw_head_dia, d2=screw_dia, h=1.5+CUT);
    }

    difference() {
        union() {
            panel_grip();
            base();
            rail_guide_pillars();
            pivot();
        }
        pivotcut();
        screwcut();
    }
}

//
// Object selection
//

door_hinge();
//frame_hinge();
