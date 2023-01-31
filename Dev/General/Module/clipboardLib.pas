unit clipboardLib;

interface

Uses ERPdbComponents, db ;

type
  TOnImportEvent = function (const aQry:TERPQuery; aField :TField):Boolean of Object;

procedure QryToClipBoard(Qry:TERPQuery);
procedure ClipBoardtoQry(Qry:TERPQuery; OnNewRecord:TOnImportEvent=nil; OnBeforeFieldChange :TOnImportEvent=nil; OnAfterFieldChange :TOnImportEvent=nil);

implementation

uses ClipBrd, CommonLib , Types , StringUtils, CommonDbLib, SysUtils, Dialogs;

procedure ClipBoardtoQry(Qry:TERPQuery; OnNewRecord:TOnImportEvent=nil; OnBeforeFieldChange :TOnImportEvent=nil; OnAfterFieldChange :TOnImportEvent=nil);
var
  Buff: string;
  lines, line, header: TStringDynArray;
  x,y: integer;
  field: TField;
begin

  Buff:= Clipboard.asText;
  if Buff = '' then Exit;
  lines := StringUtils.SplitString(Buff,#13#10);
  header := StringUtils.SplitString(lines[Low(lines)],#9);
  Qry.Last;
  for x := Low(Lines) +1 to High(lines) do begin
    if Assigned(OnNewRecord) then if not OnNewRecord(qry , nil) then continue;
    line := nil;
    line := StringUtils.SplitString(lines[x],#9);
    if length(line) <= 1 then continue;

    Qry.Append;
    for y := Low(header) to High(header) do begin
      field := Qry.FindField(StripQuotes(header[y]));
      if Assigned(field) and (StripQuotes(line[y]) <> '') and (StripQuotes(line[y]) <> '0') then begin
        try
          if assigned(OnBeforeFieldChange) then if not OnBeforeFieldChange(Qry, Field) then continue;
          EditDb(Qry);
          field.AsString := StripQuotes(line[y]);
          if assigned(OnAfterFieldChange) then if not OnAfterFieldChange(Qry, Field) then continue;
        except
          on e: exception do begin
            CommonLib.MessageDlgXP_Vista('Error setting value: ' + e.Message, mtWarning, [mbOK], 0);
          end;
        end;
      end;
    end;
    PostDb(Qry);
  end;
end;

procedure QryToClipBoard(Qry:TERPQuery);
var
  Buff: String;
  bm: TBookmark;
  x: integer;
  s: string;

  function DateToString(aDate: TDateTime): string;
  begin
    result := '';
    if aDate = 0 then exit;
    result := DateToStr(aDate);
  end;

begin
  Buff := '';
  for x := 0 to Qry.Fields.Count -1 do begin
    if Qry.Fields[x].Visible then begin
      if Buff <> '' then Buff := Buff + #9;
      Buff := Buff + '"' + Qry.Fields[x].FieldName + '"';
    end;
  end;

  bm := Qry.GetBookmark;
  try
    Qry.DisableControls;
    try
      Qry.First;
      while not Qry.EOF do begin
        s := '';
        for x := 0 to Qry.Fields.Count -1 do begin
          if Qry.Fields[x].Visible then begin
            if s <> '' then s := s + #9;
            s := s + '"' + Qry.Fields[x].AsString + '"';
          end;
        end;
        Buff := Buff + #13#10 + s;
        Qry.Next;
      end;
      Qry.GotoBookmark(bm);
    finally
      Qry.EnableControls;
    end;
  finally
    Qry.FreeBookmark(bm);
  end;

  Clipboard.asText:= Buff;
end;


end.
