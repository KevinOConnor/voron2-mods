// Simple cylinder plugs for the misumi blind corner screw holes
//
// Copyright (C) 2021  Kevin O'Connor <kevin@koconnor.net>
//
// This file may be distributed under the terms of the GNU GPLv3 license.

plug_dia = 7.0;
plug_height = 12.0;
$fs = 0.5;

module plug() {
    cylinder(d=plug_dia, h=plug_height);
}

plug();
