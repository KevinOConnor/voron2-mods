// Max Z stop for Voron 2.4 printers
//
// Copyright (C) 2021  Kevin O'Connor <kevin@koconnor.net>
//
// This file may be distributed under the terms of the GNU GPLv3 license.

// extrusion width = 20mm ; rail width = 9mm, rail depth = 6.5mm
// spring nut length = 13mm ; voron xy parts above carriage = 60mm
// m5 nut dia = 4.9mm ; m5 button head dia = 9.25

block_width = 19.5;
block_depth = 7.4;
railcut_length = 60;
block_length = railcut_length + 7 + 15 + 5 + 2;
railcut_width = 9.5;
railcut_depth = 6.8;
screw_dia = 5.5;
screw_head_dia = 10;
CUT = 0.01;
$fs = 0.5;

//
// Z stop
//

module z_stop() {
    module screwcut(x) {
        translate([x, 0, -CUT])
            cylinder(d=screw_dia, h=block_depth+2*CUT);
        bury = 3;
        translate([x, 0, -CUT])
            cylinder(d=screw_head_dia, h=bury+CUT);
        translate([x, 0, bury-CUT])
            cylinder(d1=screw_head_dia, d2=screw_dia, h=1.5+CUT);
    }
    module block() {
        difference() {
            translate([0, -block_width/2, 0])
                cube([block_length, block_width, block_depth]);
            translate([-CUT, -railcut_width/2, block_depth-railcut_depth])
                cube([railcut_length+CUT, railcut_width, railcut_depth+CUT]);
            screw1_x = railcut_length + screw_head_dia/2 + 2;
            screw2_x = screw1_x + 15;
            screwcut(screw1_x);
            screwcut(screw2_x);
        }
    }
    block();
}

//
// Object selection
//

z_stop();
