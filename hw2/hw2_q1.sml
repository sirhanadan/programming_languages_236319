fun sig1 x y g = hd [g (x,y) , y];
fun sig2 (x,y) g = if g( real x/y ) = "a" then true else false;
fun sig3 g x y z = g x y;
fun sig4 x y z w = z+w+4;
fun sig5 g x f = f( g x , g x );
fun sig6 () () = 6;
fun sig7 x (y,z) = hd [x, y, z];
fun sig8 (x, y, z) = (x+8, y, y^z);
