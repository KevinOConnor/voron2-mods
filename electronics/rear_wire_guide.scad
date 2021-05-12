// Clip to hold wires inside a 2020 extrusion
//
// Copyright (C) 2021  Kevin O'Connor <kevin@koconnor.net>
//
// This file may be distributed under the terms of the GNU GPLv3 license.

height = 15;
thick = 3;
slack = .250;
rail_length = 20 + slack;
rail_insert_length = 6 - slack;
CUT=.01;
$fs = 0.5;

module wire_guide() {
    rail_beam_length = (rail_length - rail_insert_length)/2;
    width = rail_beam_length + rail_insert_length + 2*thick;

    module base_guide() {
        difference() {
            cube([rail_length + 2*thick, width, height]);
            translate([thick, thick, -CUT])
                cube([rail_length, width-thick+CUT, height+2*CUT]);
        }
    }
    clip_inset = 1.25;
    module clip() {
        slope_length = 1;
        hull() {
            cube([CUT, rail_insert_length, height]);
            translate([clip_inset, slope_length, 0])
                cube([CUT, rail_insert_length - 2*slope_length, height]);
        }
    }

    base_guide();
    translate([rail_beam_length + thick, thick-CUT, 0])
        cube([rail_insert_length, clip_inset+CUT, height]);
    translate([thick-CUT, rail_beam_length + thick, 0])
        clip();
    translate([rail_length + thick + CUT, rail_beam_length + thick, 0])
        mirror([1, 0, 0])
            clip();
}

wire_guide();
