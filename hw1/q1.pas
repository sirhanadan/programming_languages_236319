program PascalTriangle;    
    function bin(n: integer; m: integer): integer;
        begin    
            if m = 0 then bin := 1
            else
                if (n = 1) and (m <= 1) then bin := 1
                else
                    if n = m then bin := 1
                    else
                        bin := (bin(n-1, m-1) + bin(n-1, m));
        end;    
            
            
var n: integer;
var i: integer;
var j: integer;

begin
ReadLn(n);
for i := 0 to n-1 do
    begin
        for j := 0 to i do
            begin
                Write(bin(i,j));
                Write(' ')
            end;
            WriteLn('');
    end;
end.
