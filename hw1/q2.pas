program newCyberPassword;  

var hist1: array [97..122] of integer;
    hist2: array [97..122] of integer;
    str1: string;
    str2: string;
    letter: char;
    number: byte;
    isLegal: string;
    i: integer;
    
begin
    ReadLn(str1);
    ReadLn(str2);
    isLegal := 'TRUE';
    for i := 97 to 122 do
    begin
        hist1[i] := 0;
        hist2[i] := 0
    end;
    
    for letter in str1 do
    begin
        number := ord(letter);
        hist1[number] := hist1[number] + 1;
    end;
    
    for letter in str2 do
    begin
        number := ord(letter);
        hist2[number] := hist2[number] + 1;
        if hist1[number] >= 1 then isLegal := 'FALSE';
    end;
    
    WriteLn(isLegal);
    i := 97;
for letter := 'a' to 'z' do
    begin
        if (hist1[i] + hist2[i]) > 0  then 
            begin
                Write(letter);
                Write(' ');
                WriteLn(hist1[i] + hist2[i]);
            end;
        i := i+1;
    end;

end.
