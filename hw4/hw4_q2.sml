
use "hw4_q2_def.sml";


local
fun isLeftLeaf tr = case tr of Nil => false
  | (Br (v, Nil, Nil)) => true
  | (Br (v , Nil, _) ) => true
  | (Br (v , _ , _) ) => false;

fun isLeafSwichToRightNode (Br (v, l , r)) rightNodes res = (
case rightNodes of [] => res 
  | _ =>
let
  val nextRightNode = hd rightNodes;
  
in
  case (nextRightNode) of Nil => isLeafSwichToRightNode (Br (v, l , r)) (tl rightNodes) res
    | _ => isNotLeafKeepGoingLeft nextRightNode (tl rightNodes) res
end
)

and isNotLeafKeepGoingLeft (Br (v, l, r) ) rightNodes res = 
let
  val newRightNodes = case r of Nil => rightNodes | _ => (r::rightNodes);
  val newRes = v::res;
in 
  case (isLeftLeaf (Br (v, l , r))) of false => (isNotLeafKeepGoingLeft (l) newRightNodes newRes)
    | true => isLeafSwichToRightNode (Br (v, l , r)) newRightNodes newRes
end;





fun flatten_aux Nil = []
  | flatten_aux (Br (v, Nil, Nil)) = [v]
  | flatten_aux (Br (v, Nil, r)) = isLeafSwichToRightNode (Br (v, Nil, r)) [r] [v]
  | flatten_aux (Br (v, l , r)) = isNotLeafKeepGoingLeft (Br (v, l , r)) [] [];
in
fun flatten tr =  List.rev (flatten_aux tr);
end;



local

fun map_aux f (Nil, _, _) ((Nil, kLeft, kRight)::rest) = Nil
  | map_aux f (Nil, _, _) (((Br (pv, pl, pr)), kLeft, kRight)::rest) = map_aux f ((Br (pv, pl, pr)), kLeft, kRight) rest

  | map_aux f ((Br (v, l, r)), true, true) [] = (Br (f v, l, r))
  | map_aux f ((Br (v, l, r)), false, false) rest = map_aux f (l, false, false) ( ((Br (v, l, r)), true, false)::rest)
  | map_aux f ((Br (v, l, r)), true, false) rest = map_aux f (r, false, false) ( ((Br (v, l, r)), true, true)::rest)
  | map_aux f ((Br (v, l, r)), true, true) (((Br (pv, pl, pr)), true, false)::rest) = 
(let 
  val newParent = ((Br (pv, (Br (f v, l, r)), pr)), true, false);
in 
  map_aux f newParent rest
end)
  | map_aux f ((Br (v, l, r)), true, true) (((Br (pv, pl, pr)), true, true)::rest) = 
(let 
  val newParent = ((Br (pv, pl, (Br (f v, l, r)))), true, true);
in 
  map_aux f newParent rest
end);
in
  
fun map f tr = map_aux f (tr, false, false) [];
  
end;


