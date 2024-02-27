use "hw3_q1_def.sml";

fun mapState f list_of_lists = map (fn individual_lists => map f individual_lists) list_of_lists;

fun toString char_list = foldr (fn (singular_char, string_so_far) => (str singular_char)^string_so_far) "" char_list ;

fun frameToState list_of_strings = map (map (fn singular_char => singular_char = #"*")) (map (fn string_to_list => explode string_to_list) list_of_strings);

fun stateToFrame s = map (fn list_of_chars => toString( map toChar list_of_chars)) s;

fun printFrame f = print (foldr op^ "" (map (fn str1 => str1^"\n") f));
