datatype cell = empty | alive;
local
fun sum_alive (empty, empty , empty) = 0
  | sum_alive (alive, empty , empty) = 1
  | sum_alive (empty, alive , empty) = 1
  | sum_alive (empty, empty , alive) = 1
  | sum_alive (alive, alive , empty) = 2
  | sum_alive (empty, alive , alive) = 2
  | sum_alive (alive, empty , alive) = 2
  | sum_alive (alive, alive, alive) = 3;

fun sum_of_all (cell1, cell2, cell3) (cell4, cell5, cell6) (cell7, cell8, cell9) = sum_alive(cell1, cell2, cell3) + sum_alive(cell4, cell5, cell6) + sum_alive(cell7, cell8, cell9);

fun result_for_alive_cell 3 = alive
  | result_for_alive_cell 4 = alive
  | result_for_alive_cell _ = empty;

fun result_for_empty_cell 3 = alive
  | result_for_empty_cell _ = empty;

fun call_for_correct_result (cell5,sum) = if cell5 = alive then result_for_alive_cell sum else result_for_empty_cell sum;

in
 fun is_alive (cell1, cell2, cell3) (cell4, cell5, cell6) (cell7, cell8, cell9) = call_for_correct_result( cell5, sum_of_all (cell1, cell2, cell3) (cell4, cell5, cell6) (cell7, cell8, cell9) );
end;
