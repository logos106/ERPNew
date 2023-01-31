unit ExportImportUtils;

interface

  function IsPDIFormatFile(FileName: string; var msg: string; var OpenedOk: boolean): boolean;

implementation

uses
  StrUtils,types, SysUtils;

(*
  ERP PDI files have following tab delimited format

  $EntityName_1  ColumnName_1 ColumnName_2 ColumnName_n
  EntityName_1  Data_1  Data_2  Data_n
  EntityName_1  Data_1  Data_2  Data_n
  ... etc
  FINALEntityName_1
  $EntityName_2  ColumnName_1 ColumnName_n
  EntityName_2  Data_1  Data_n
  EntityName_2  Data_1  Data_n
  ... etc
  FINALEntityName_2
*)

function IsPDIFormatFile(FileName: string; var msg: string; var OpenedOk: boolean): boolean;
var
  F: TextFile;
  s: string;
  startFound: boolean;
  line: TStringDynArray;
  colCount: integer;
  recType: string;
  lineNo: integer;
begin
  result := true;
  OpenedOk := true;
  lineNo := 0;
  colCount := 0;
  AssignFile(F, FileName);
  try
    {$I-}
    Reset(F);
    {$I+}
    if IOResult = 0 then begin
      try
        startFound := false;
        while not Eof(F) do begin
          Inc(lineNo);
          Readln(F,s);
          if s <> '' then begin
            if not startFound then begin
              line := SplitString(s,#9);
              colCount := High(line) + 1;
              if colCount < 2 then begin
                result := false;
                msg:= 'The file does not contain any columns of data.';
                exit;
              end;
              if Pos('$',Line[0]) <> 1 then begin
                result := false;
                msg:= 'Invalid structure ($ missing for first record on first line).';
                exit;
              end;
              recType := Copy(line[0],2,Length(line[0]));
              if recType = '' then begin
                result := false;
                msg:= 'Invalid structure (Record type name missing after $ character).';
                exit;
              end;
              startFound := true;
            end
            else begin
              { start already found }
              line := SplitString(s,#9);
              if SameText(line[0], 'FINAL' + recType) then begin
                { end of section }
                startFound := false;
                recType := '';
                colCount := 0;
              end
              else begin
                if (High(line) + 1) <> colCount then begin
                  result := false;
                  msg:= 'Invalid number of columns on line ' + IntToStr(lineNo) + ', found ' + IntToStr(High(line) + 1) + ' should be ' + IntToStr(colCount) + '.';
                  exit;
                end;
              end;
            end;
          end;
        end;
      finally
        CloseFile(F);
      end;
    end
    else begin
      result := false;
      OpenedOk := false;
      msg := 'Unable to open the file, it may be in use by another application.';
    end;
  except
    on e: exception do begin
      result := false;
      msg := 'File is already in use by another application.';
    end;
  end;
end;

end.
