use "hw3_q2_def.sml";

functor Kernel1D (Elt : KERNEL1D_SIG) = struct 
  local
    fun dd [h, m, t] = [Elt.kernel h m t]
      | dd (h::m::t::xs) = (dd [h,m,t])@(dd (m::t::xs));
  in
    fun runKernel [] = []
      | runKernel ls = dd ([Elt.default (hd ls)]@ls@[Elt.default (hd ls)]);
  end;
end;

local 
  fun are_same_length l1 l2 l3 = if (List.length l1) = (List.length l2) then if (List.length l2) = (List.length l3) then true else false else false;
  fun tt (e1,e2,e3,l) = l@[(e1,e2,e3)];
  fun tl ([],[],[], ls) = ls
    | tl ([l1], [l2], [l3], ls) = ls@[(l1,l2,l3)]
    | tl ((l1::xs1), (l2::xs2), (l3::xs3), ls) = [(l1,l2,l3)]@(tl (xs1,xs2,xs3,ls));
in 
  exception SizeNotEqual;
fun zip l1 l2 l3 = if (are_same_length l1 l2 l3) then (tl (l1,l2,l3,[])) else raise SizeNotEqual;
end;

local 
  fun still_i_left (a,0,ls) = ls
    | still_i_left (a,i,ls) = still_i_left (a, i-1, [a]@ls);
in
  exception NegativeLength;
  fun fill a i = if i < 0 then raise NegativeLength else still_i_left (a, i, []);
end;


functor Kernel2D (Elt2 : KERNEL2D_SIG) = struct 
local
  fun defo_list (a :Elt2.source list)  = [Elt2.default (hd a)];
  fun defo_listt (a :Elt2.source list)  = fill (Elt2.default (hd a)) (length a);
    structure Ker1Dzip = Kernel1D(struct
      type source = Elt2.source list
      type target = (Elt2.source * Elt2.source * Elt2.source) list
      val kernel = zip
      fun default s = defo_listt s
  end);
  
  fun defo_tup ( (a,b,c) : Elt2.source * Elt2.source * Elt2.source) = (Elt2.default a, Elt2.default  b, Elt2.default c);
  structure Ker1Dker = Kernel1D(struct
      type source = (Elt2.source * Elt2.source * Elt2.source)
      type target = Elt2.target
      val kernel = Elt2.kernel
      fun default s = defo_tup s
  end);
  in
  fun runKernel [] = []
    | runKernel ls = map Ker1Dker.runKernel (Ker1Dzip.runKernel ls);
  end;
   
end;