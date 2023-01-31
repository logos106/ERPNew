unit x12;

interface

uses
  JsonObject, classes, Types, ConTnrs;

type

  TX12 = class(TObject)
  private
    fJson: TJsonObject;
    fSegmentTerminator: string;
    fDataElementSeparator: string;
    RawData: array of TStringDynArray;
    FG, TS, Line, SAC, N9, N1, CTT, LineN9, HL: TJsonObject;
    fTestData: boolean;
    fComponentElementSeparator: string;
    procedure DoOnReadSegment(dataArr: TStringDynArray);
  public
    constructor Create;
    destructor Destroy; override;
    property DataElementSeparator: string read fDataElementSeparator write fDataElementSeparator;
    property SegmentTerminator: string read fSegmentTerminator write fSegmentTerminator;
    property ComponentElementSeparator: string read fComponentElementSeparator write fComponentElementSeparator;
    property TestData: boolean read fTestData write fTestData;
    property Data: TJsonObject read fJson;
    procedure Read(stream: TStream); overload;
    procedure Read(aFileName: string); overload;
    procedure ReadString(aStr: string);
    procedure Write(stream: TStream); overload;
    procedure Write(aFileName: string); overload;
  end;

implementation

(*  X12 Message Format

  ISA (Interchange Envelope) ---------
     GS (Functional Group 1) ------    |
        ST (Transaction Set 1) --   |  |
                                 |  |  |
        SE ----------------------   |  |
        ST (Transaction Set 2) --   |  |
                                 |  |  |
        SE ----------------------   |  |
     GE ---------------------------    |
     GS (Functional Group 2) ------    |
        ST (Transaction Set 3) --   |  |
                                 |  |  |
        SE ----------------------   |  |
     GE ---------------------------    |
  IEA --------------------------------

*)

uses
  StrUtils, SysUtils;

{ TX12 }

constructor TX12.Create;
begin
  FG := nil;
  TS := nil;
  Line := nil;

  SAC := nil;
  N9 := nil;
  N1 := nil;
  CTT := nil;
  LineN9 := nil;
  HL := nil;
  fJson := JO;
  fDataElementSeparator := '*';
  fSegmentTerminator := #13#10;
  fComponentElementSeparator := '}';
  fTestData := false;
end;

destructor TX12.Destroy;
begin
  fJson.Free;
  inherited;
end;

procedure TX12.DoOnReadSegment(dataArr: TStringDynArray);
var
  o: TJsonObject;

  function NewSegment(arr: TStringDynArray): TJsonObject;
  var
    I: Integer;
    s: string;
  begin
    result := JO;
    for I := Low(arr) + 1 to High(arr) do begin
      s := IntToStr(I);
      if Length(s) < 2 then s := '0' + s;
      result.S[arr[0] + s] := arr[I];
    end;
  end;

begin
  if SameText(dataArr[0], 'ISA')  then begin
    data.O['ISA'] := NewSegment(dataArr);
  end else if SameText(dataArr[0], 'IEA') then begin
    data.O['IEA'] := NewSegment(dataArr);
  end else if SameText(dataArr[0], 'GS') then begin
    { new functional group .. }
    TS := nil;
    Line := nil;
    SAC := nil;
    N9 := nil;
    N1 := nil;
    CTT := nil;
    LineN9 := nil;
    HL := nil;
    FG := JO;
    FG.O['GS'] := NewSegment(dataArr);
    data.A['GS'].Add(FG);
  end else if SameText(dataArr[0], 'GE') then begin
    { end functional group .. }
    FG.O['GE'] := NewSegment(dataArr);
  end else if SameText(dataArr[0], 'ST') then begin
    { Transaction Set Start }
    Line := nil;
    SAC := nil;
    N9 := nil;
    N1 := nil;
    CTT := nil;
    LineN9 := nil;
    HL := nil;
    TS := JO;
    TS.O['ST'] := NewSegment(dataArr);
    FG.A['ST'].Add(TS);
  end else if SameText(dataArr[0], 'SE') then begin
    { Transaction Set End }
    TS.O['SE'] := NewSegment(dataArr);
  end else if SameText(dataArr[0], 'BEG') then begin
    { new Purchase Order }
    TS.O['BEG'] := NewSegment(dataArr);
  end else if SameText(dataArr[0], 'BIG') then begin
    { new Purchase Order }
    TS.O['BIG'] := NewSegment(dataArr);
  end else if SameText(dataArr[0], 'PO1') then begin
    { New Line }
    Line := JO;
    Line.O['PO1'] := NewSegment(dataArr);
    TS.A['PO1'].Add(Line);
  end else if SameText(dataArr[0], 'IT1') then begin
    { New Line }
    Line := JO;
    Line.O['IT1'] := NewSegment(dataArr);
    TS.A['IT1'].Add(Line);
  end else if SameText(dataArr[0], 'HL') then begin
    { New Hierarchical Level }
    HL := JO;
    HL.O['HL'] := NewSegment(dataArr);
    TS.A['HL'].Add(HL);
  end else if Assigned(HL) and (Pos(dataArr[0],'TD1,TD5,TD3,REF,PER,DTM,FOB,NI,PRF,MAN,LIN,SN1,PO4,PID') > 0) then begin
    if SameText(dataArr[0], 'N1') then begin
      N1 := JO;
      N1.O['N1'] := NewSegment(dataArr);
      HL.A['N1'].Add(N1);
      // N2, N3 and N4 added below
    end else if (Pos(dataArr[0],'TD1,TD5,TD3,REF,PER,DTM,MAN,PID') > 0) then begin
      // arrays
      o := JO;
      o.O[dataArr[0]] := NewSegment(dataArr);
      HL.A[dataArr[0]].Add(o);
    end else begin
      // single instance
      HL.O[dataArr[0]] := NewSegment(dataArr);
    end;
  end else if (Pos(dataArr[0],'CUR,REF,PER,FOB,CTP,CSH,SAC,ITD,DTM,TD5,TXI,N9,MTX,N1,N2,N3,N4,BAK,BSN') > 0) and (not Assigned(Line)) then begin
   { doc header fields }
   if SameText(dataArr[0], 'SAC') then begin
     SAC := JO;
     SAC.O['SAC'] := NewSegment(dataArr);
     TS.A['SAC'].Add(SAC);
   end else if SameText(dataArr[0], 'N9') then begin
     { new N9 Loop }
     N9 := JO;
     N9.O['N9'] := NewSegment(dataArr);
     TS.A['N9'].Add(N9);
   end else if SameText(dataArr[0], 'MTX') then begin
     { part of N9 }
     o := JO;
     o.O[dataArr[0]] := NewSegment(dataArr);
//     N9.A['MTX'].Add(NewSegment(dataArr));
     N9.A['MTX'].Add(o);
   end else if SameText(dataArr[0], 'N1') then begin
     N1 := JO;
     N1.O['N1'] := NewSegment(dataArr);
     TS.A['N1'].Add(N1);
   end else if (Pos(dataArr[0],'N2,N3') > 0) then begin
     { N1 data }
     o := JO;
     o.O[dataArr[0]] := NewSegment(dataArr);
     N1.A[dataArr[0]].Add(o);
   end else if (Pos(dataArr[0],'N4') > 0) then begin
     N1.O[dataArr[0]] := NewSegment(dataArr);
   end else if (Pos(dataArr[0],'REF,PER,FOB,CTP,CSH,ITD,DTM,TD5,TXI') > 0) then begin
     { all arrays }
     o := JO;
     o.O[dataArr[0]] := NewSegment(dataArr);
//     TS.A[dataArr[0]].Add(NewSegment(dataArr));
     TS.A[dataArr[0]].Add(o);
   end else begin
     { all other header segments }
     TS.O[dataArr[0]] := NewSegment(dataArr);
   end;
  end else if Assigned(Line) and (Pos(dataArr[0],'CTP,PID,PO4,REF,SAC,SDQ,DTM,MTX,TXI,N9,ACK') > 0) then begin
    { line fields }
    if (Pos(dataArr[0],'N9') > 0) then begin    // 855 PO Ack has N9 Loop on line
      LineN9 := JO;
      LineN9.O['N9'] := NewSegment(dataArr);
      Line.A['N9'].Add(LineN9);
    end else if (Pos(dataArr[0],'MTX') > 0) and Assigned(LineN9) then begin
      o := JO;
      o.O[dataArr[0]] := NewSegment(dataArr);
      LineN9.A['MTX'].Add(o);
    end else if (Pos(dataArr[0],'CTP,PID,SAC,PO4,REF,SDQ,MTX,ACK') > 0) then begin
      o := JO;
      o.O[dataArr[0]] := NewSegment(dataArr);
      Line.A[dataArr[0]].Add(o);
    end else begin
      Line.O[dataArr[0]] := NewSegment(dataArr);
    end
  end else if (Pos(dataArr[0],'CTT,AMT') > 0) then begin
    { summary }
    TS.O[dataArr[0]] := NewSegment(dataArr);
    (*
    if SameText(dataArr[0], 'CTT') then begin
      CTT := JO;
      CTT.O['CTT'] := NewSegment(dataArr);
      TS.A['CTT'].Add(CTT);
    end
    else begin
       CTT.O[dataArr[0]] := NewSegment(dataArr);
    end;
    *)
  end
end;

procedure TX12.Read(aFileName: string);
var
  stream: TFileStream;
begin
  stream := TFileStream.Create(aFileName, fmOpenRead);
  try
    Read(stream);
  finally
    stream.Free;
  end;
end;

procedure TX12.ReadString(aStr: string);
var
  stream: TStringStream;
begin
  stream := TStringStream.Create;
  try
    stream.WriteString(aStr);
    stream.Position := 0;
    Read(stream);
  finally
    stream.Free;
  end;
end;

procedure TX12.Write(aFileName: string);
var
  stream: TFileStream;
begin
  stream := TFileStream.Create(aFileName, fmCreate);
  try
    Write(stream);
  finally
    stream.Free;
  end;
end;

procedure TX12.Write(stream: TStream);
var
  Writer: TStreamWriter;

  procedure DoWrite(json: TJsonObject);
  var
    I: integer;
    pair: TJsonValuePair;
    x: Integer;
  begin
    for I := 0 to Json.Count - 1 do begin
      pair := Json[I];
      if pair.ValueType = valObject then begin
        Writer.Write(pair.Name);
        for x := 0 to pair.Value.AsObject.Count -1 do begin
          Writer.Write(DataElementSeparator);
          Writer.Write(pair.Value.AsObject.Items[x].Value.AsString);
        end;
        Writer.Write(SegmentTerminator);
      end
      else if pair.ValueType = valArray then begin
        for x := 0 to TJsonArray(pair.Value).Count -1 do begin
          if TJsonArray(pair.Value)[x].ValueType = valObject then
            DoWrite(TJsonArray(pair.Value)[x].AsObject);
        end;
      end;
    end;
  end;

begin
  Writer := TStreamWriter.Create(stream);
  try
    DoWrite(Data);
  finally
    Writer.Free;
  end;
end;

procedure TX12.Read(stream: TStream);
var
  Reader: TStreamReader;
  arr: TStringDynArray;
  SegDone: boolean;
  s: string;
begin
  fJson.Clear;
  Reader:= TStreamReader.Create(stream);
  try
    SetLength(RawData,0);
    SetLength(arr,0);
    s := '';
    SegDone := false;
    while Reader.Peek > -1 do begin
      if Length(arr) = 0 then begin
        SetLength(arr,1);
        SegDone := false;
      end;
      s := s + Char(Reader.Read);
      if RightStr(s, Length(DataElementSeparator)) = DataElementSeparator then begin
        arr[Length(arr)-1] := arr[Length(arr)-1] + Copy(s,1,Length(s) - Length(DataElementSeparator));
        SetLength(arr,Length(arr)+1);
        s := '';
      end
      else if RightStr(s, Length(SegmentTerminator)) = SegmentTerminator then begin
        arr[Length(arr)-1] := arr[Length(arr)-1] + Copy(s,1,Length(s) - Length(SegmentTerminator));
        DoOnReadSegment(arr);
        SetLength(arr,0);
        SegDone := true;
        s := '';
      end;
    end;
    if Length(arr) > 0 then begin
      if s <> '' then
        arr[Length(arr)-1] := arr[Length(arr)-1] + s;
      if not SegDone then
        DoOnReadSegment(arr);
    end;
  finally
    Reader.Free;
  end;
  //RawToJson;
end;

end.
