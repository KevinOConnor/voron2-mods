This document describes some minor customizations of a Voron2.4
enclosure.

# No exhaust fan

I did not deploy the standard Voron exhaust filter / fan.  The rear
coroplast panel only has a small hole for the "reverse bowden" ptfe
tube.

I designed a [tube guide](tube_guide.stl) to support the filament
tube.  It is mounted near the center of the rear top horizontal
aluminum extrusion.

# Separate filament spool holder

I did not deploy the standard Voron spool holder.  I use a separate
[spool holder in a ziplock
bag](https://github.com/KevinOConnor/zipspool).

# Polycarbonate panels

I ordered polycarbonate panels (from TAP Plastics) instead of the
standard acrylic panels.

The panels were slightly larger than requested.  This caused an issue
with the standard Voron hinges.  I designed a custom door hinge
([hinge for frame](hinge_frame.stl) and [hinge for
door](hinge_door.stl)) so that I could mount the slightly over-sized
front door panels.

# Other

The Misumi "blind corner joints" have screw holes in the vertical
extrusions.  These screw holes provide a hole into the internal
chamber.  I designed simple plastic [plugs](screw-plug.stl) to fill
these holes (both to reduce air flow through the hole and for improved
aesthetic).

I deployed [Voron2.2
handles](https://github.com/VoronDesign/Voron-2/blob/Voron2.2/STLs/VORON2.2/Panel_Mounting/Handles_Panel_Rests_Misc/handle_3mm_x2_Rev1.stl)
to make it easier to move the printer.

The standard Voron deck panel calls for a hole to route the bed wires
through.  I did not make this hole in the coroplast.  Instead, I route
all wires (toolhead, corexy, and bed) through a single hole at the
rear of the deck panel.
