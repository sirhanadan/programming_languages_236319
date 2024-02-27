program oneOfThreeCommands;
    Uses sysutils;
    var commands: array [1..5] of char;
        currentCommand: integer;
        results: array [1..5] of string;
        currentResult: integer;
        pDiff: integer;
        cNewLetter: char;
        cDiff: integer;
        gGrade: integer;

    var a: integer;
        b: integer;
        c: integer;
        letter: char;
        d: integer;
        hwAvg: integer;
        exam: integer;
        
        function pCommand(a: integer; b: integer; c: integer): string;
        begin
            pDiff:= a*a + b*b - c*c;
            if pDiff = 0 then pCommand := 'TRUE'
            else
                pCommand := 'FALSE';
        end;
        
        function cCommand(letter: char; d: integer): string;
        begin
            cDiff := (ord(letter) + d)mod(256);
            cNewLetter := chr(cDiff);
            cCommand := cNewLetter;
        end;
        
        function gCommand(hwAvg: integer; exam:integer): string;
        begin
            gGrade := 0;
            if exam < 55 then gGrade := exam;
            if exam >= 55 then gGrade := round(0.8*exam + 0.2*hwAvg);
            gCommand := IntToStr(gGrade);
        end;
        
    begin
        for currentCommand := 1 to 5 do
        begin
            ReadLn(commands[currentCommand]);
        end;
        
        currentResult := 1;
        for currentCommand := 1 to 5 do
        begin
            if commands[currentCommand] = 'P' then 
            begin
                ReadLn(a);
                ReadLn(b);
                ReadLn(c);
                results[currentResult] := pCommand(a,b,c);
            end;
            if commands[currentCommand] = 'C' then 
            begin
                ReadLn(letter);
                ReadLn(d);
                results[currentResult] := cCommand(letter, d);
            end;
            if commands[currentCommand] = 'G' then 
            begin
                ReadLn(hwAvg);
                ReadLn(exam);
                results[currentResult] := gCommand(hwAvg, exam);
            end;
            
            currentResult := currentResult+1;
        end;
        
        for currentResult := 5 downto 1 do
        begin
            WriteLn(results[currentResult]);
        end;
    
    end.