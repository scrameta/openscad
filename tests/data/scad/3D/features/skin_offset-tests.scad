skin(segments=20)
{
    offset(r=2)
    square(10,center=true);
    translate([0,0,50])
    square(10,center=true);
}

// Extra length in one part of a contour must not shift every subsequent
// correspondence. The rays divide the perimeter into local interpolation
// regions, keeping the right-hand corners aligned despite the zig-zag.
translate([280,0,0])
skin(align_angle=0)
{
    polygon([[0,0], [40,0], [40,40], [0,40]]);
    translate([0,0,30])
    polygon([[0,0], [40,0], [40,40], [30,38], [25,42], [20,38], [15,42], [10,38], [0,40]]);
}

module square_manual(sz)
{
    difference()
    {
        square(sz,center=true);
        square(sz-2,center=true);
    }
}

translate([30,0,0])
skin(segments=20)
{
    square_manual(10);
    translate([0,0,50])
    square_manual(20);
}

module square_offset(sz)
{
    difference()
    {
        square(sz,center=true);
        offset(-2)
        square(sz,center=true);
    }
}

translate([60,0,0])
skin(segments=20, interpolate = false)
{
    square_offset(10);
    translate([0,0,50])
    square_offset(20);
}


translate([90,0,0])
skin(segments=20)
{
    square(10);
    translate([0,0,50])
    circle(10);
}

module circle_offset(sz)
{
    difference()
    {
        circle(sz);
        offset(-2)
        circle(sz);
    }
}

translate([120,0,0])
skin(segments=20)
{
    square_offset(10);
    translate([0,0,50])
    circle_offset(10);
}

// An alignment ray must not select the opposite side of an asymmetric
// contour. Doing so makes adjacent hollow profiles twist through each other.
translate([160,0,0])
skin(segments=20, align_angle=45)
{
    difference() {
        polygon([[2,0], [89,0], [91,5], [91,20], [79,23], [12,23], [0,20], [0,5]]);
        offset(r=-1.2)
        polygon([[2,0], [89,0], [91,5], [91,20], [79,23], [12,23], [0,20], [0,5]]);
    }
    translate([0,0,20])
    difference() {
        square([91,23]);
        offset(r=-1.2) square([91,23]);
    }
    translate([0,0,30])
    difference() {
        offset(r=1.2) square([57.5,32.5]);
        square([57.5,32.5]);
    }
}
