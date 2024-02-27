use "hw4_q3_def.sml";


(**Biseq = list of (index, x), index, max index so far, max sequence so far, isEmpty**)
datatype 'a biseq = Biseq of ((int*'a) list)*(int)*(int)*('a seq)*(bool);
exception SeqErr;


fun new Nil = Biseq ([], 0, ~1 ,Nil, true)
  | new (Cons (x, xf)) = Biseq ([(0,x)], 0, 0 ,(Cons (x, xf)), false);

local
(* Given the list, find index *)
fun findInList [] _ = raise SeqErr
  | findInList ((index, x)::xs) i = if (index = i) then x else (findInList xs i);


(* Given old sequence, and new sequence, update it *)
(* relies on the fact that we always move by 1 *)
fun inCaseIndexIsNewMax (Biseq (ls, index, max, (Cons(x, xf)), emp)) newMax = 
let
  val (Cons (xmax, xfmax)) = xf ();
  val newList = ((newMax, xmax)::ls);
  val newEmp = case (Cons (xmax, xfmax)) of Nil => true | (Cons (xmax, xfmax)) => false;
in
  (Biseq (newList, newMax, newMax, (Cons(xmax, xfmax)), newEmp))
end;


fun isMaxLast Nil = true
  | isMaxLast (Cons(x, xf)) = case (xf ()) of Nil => true | _ => false;


fun isMaxAndIsItLast (Biseq (ls, index, max, seqq , emp)) = if (index = max) andalso (isMaxLast (seqq)) then true else false;




in


fun curr (Biseq (ls, index, max, Nil, emp)) = raise SeqErr
  | curr (Biseq (ls, index, max, seqq, emp)) = findInList ls index;

fun empty (Biseq (ls, index, max, Nil, emp)) = true
  | empty (Biseq (ls, index, max, (Cons(x, xf)), emp)) = emp;

(* Given a biseq, return a new biseq with 
1. increased index 
2. a new list containing all the already passed elements
3. a new sequence that is the maximal sequence
4. don't forget to update max if neccessary *)

fun next (Biseq (ls, index, max, seqq, emp)) = if (empty (Biseq (ls, index, max, seqq, emp))) then (raise SeqErr) else let
  val newIndex = index + 1;
  val newMax = if (max > newIndex) then max else newIndex;
  val updateMax = if (newMax = max) then false else true;
  val newB = if updateMax then (inCaseIndexIsNewMax (Biseq (ls, index, max, seqq, emp)) (newIndex) ) else (Biseq (ls, newIndex, max, seqq, emp));
in 
  newB
end;

fun prev (Biseq (ls, index, max, seqq, emp)) = if index = 0 then raise SeqErr else (Biseq (ls, (index -1), max, seqq, emp));

end;
  
