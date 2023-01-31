unit DoorsLib;

interface

uses
  DB, QueryLoadObj;

type
  TDoors = class(TObject)
  private
    FDoorType: string;
    FDoorPlacement: Integer;
    FFacing: string;
    FDoorOneWidth: Integer;
    FDoorOneHeight: Integer;
    FDoorTwoWidth: Integer;
    FDoorTwoHeight: Integer;
    FDoorPairing: Integer;
    FDoorThickness: Integer;
    FOverPanel: Boolean;
    FOverPanelType :Integer;
    FOverPanelOneWidth: Integer;
    FOverPanelOneHeight: Integer;
    FOverPanelTwoWidth: Integer;
    FOverPanelTwoHeight: Integer;
    FLabourCost: Double;
    FSundriesCost: Double;
    FQueryLoad: TQueryLoad;
    tmptable_vwdoordetaillist :String;
  public
    constructor Create;
    destructor Destroy; override;
    function DoorTypeOpOneQt(const Width, Height: Integer): string;
    function DoorTypeQueryQt(const Width, Height: Integer): string;
    function GetSundryCost(const Code: string): Double;
    function GetStilesCost(const Code: string): Double;
    function NewDoorCost(const tcompref, tpos: string; const thghtmats, twidmats, tqty, tdwid, tdhght: Double): Double;
    function GetGlazingCost(const GlazingShape, GlazingType: string; const GlazingMats: string = ''): Double;
    function GetJoineryCost(const Description: string; out UnitOfCharge: string): Double;
    function GetNewDoorCost(const DType: string; const Width, Height: Double): Double;
    property DoorType: string read FDoorType write FDoorType;
    property DoorPlacement: Integer read FDoorPlacement write FDoorPlacement;
    property Facing: string read FFacing write FFacing;
    property DoorOneWidth: Integer read FDoorOneWidth write FDoorOneWidth;
    property DoorOneHeight: Integer read FDoorOneHeight write FDoorOneHeight;
    property DoorTwoWidth: Integer read FDoorTwoWidth write FDoorTwoWidth;
    property DoorTwoHeight: Integer read FDoorTwoHeight write FDoorTwoHeight;
    property DoorPairing: Integer read FDoorPairing write FDoorPairing;
    property DoorThickness: Integer read FDoorThickness write FDoorThickness;
    property OverPanel: Boolean read FOverPanel write FOverPanel;
    Property OverPanelType :Integer REad fOverPanelType Write fOverPanelType;
    property OverPanelOneWidth: Integer read FOverPanelOneWidth write FOverPanelOneWidth;
    property OverPanelOneHeight: Integer read FOverPanelOneHeight write FOverPanelOneHeight;
    property OverPanelTwoWidth: Integer read FOverPanelTwoWidth write FOverPanelTwoWidth;
    property OverPanelTwoHeight: Integer read FOverPanelTwoHeight write FOverPanelTwoHeight;
    property LabourCost: Double read FLabourCost;
    property SundriesCost: Double read FSundriesCost;
    property QueryLoad: TQueryLoad read FQueryLoad;
  end;

var
  Doors: TDoors;
  

implementation

uses
  CommonDbLib, MyAccess,ERPdbComponents, FastFuncs, SysUtils, Dialogs, CommonLib;

constructor TDoors.Create;
Var
  ErrStr:String;
begin
  tmptable_vwdoordetaillist := CommonDbLib.ViewToTmpTable('vwdoordetaillist');
  {Indexes}
  ExecuteDBCommand('ALTER TABLE `'+tmptable_vwdoordetaillist+'` ADD PRIMARY KEY(`GlobalRef`);',ErrStr);
  ExecuteDBCommand('ALTER TABLE `'+tmptable_vwdoordetaillist+'` ADD INDEX `1`(`ShortType`,`Finish`, `MaxWidth`, `MaxHeight`,`InternalExternal`)',ErrStr);
  Inherited;
  FDoorType := '';
  FDoorPlacement := 0;
  FFacing := '';
  FOverPanel := False;
  FDoorOneWidth := 0;
  FDoorOneHeight := 0;
  FDoorTwoWidth := 0;
  FDoorTwoHeight := 0;
  FDoorPairing := 0;
  FDoorThickness := 0;
  FLabourCost := 0;
  FSundriesCost := 0;
  FQueryLoad := TQueryLoad.Create;
  FQueryLoad.QueryGroup := 'DoorsLib';
end;

destructor TDoors.Destroy;
begin
  FreeAndNil(FQueryLoad);
  inherited;
  DestroyUserTemporaryTable(tmptable_vwdoordetaillist);
end;

function TDoors.DoorTypeQueryQt(const Width, Height: Integer): string;
var
  DataSet: TDataSet;
  (*Params: TVarParams;*)
  s :String;
begin
  Result := '';
    s := 'SELECT DISTINCTROW DoorType, ShortType, MaxWidth, MinWidth, MaxHeight, '+
        ' MinHeight,  LabCost, Sundries,Thickness  ' +
        ' FROM '+ tmptable_vwdoordetaillist +
        ' WHERE (ShortType = ' + QuotedStr(DoorType) +')' +
        ' AND (Finish = ' +QuotedStr(Facing) +')' +
        ' AND (' +Fastfuncs.InTtoStr(width)+' BETWEEN MinWidth AND MaxWidth) '+
        ' AND (' +Fastfuncs.InTtoStr(width)+' BETWEEN MinHeight AND MaxHeight) ' ;
     if DoorPlacement = 0 then
      s := s + ' ANd (InternalExternal = ' + QuotedStr('Internal')+')'
     else
     s := s + ' ANd (InternalExternal = ' + QuotedStr('External')+')'  ;
     Dataset := commondbLib.RetrieveDataset(s);

    if Assigned(DataSet) then begin
      try
        FLabourCost     := strValue(DataSet.FieldByName('LabCost').AsString);
        FSundriesCost   := strValue(DataSet.FieldByName('Sundries').AsString);
        FDoorThickness  := 0;
        if DataSet.FieldByName('Thickness').AsString <> '' then
            FDoorThickness  := FastFuncs.StrToInt(DataSet.FieldByName('Thickness').AsString);
        Result          := DataSet.FieldByName('DoorType').AsString;
      finally
        FreeAndNil(DataSet);
      end;
    end;
end;

function TDoors.DoorTypeOpOneQt(const Width, Height: Integer): string;
var
  DataSet: TDataSet;
  Params: TVarParams;
begin
  Result := '';
  Params := TVarParams.Create;

  try
    Params.Add('ShortType', QuotedStr(DoorType));
    Params.Add('Facing', QuotedStr(Facing));
    Params.Add('Width', Width);
    Params.Add('Height', Height);
    DataSet := QueryLoad.Execute('DoorTypeDefineOpOneQt', Params);

    if Assigned(DataSet) then begin
      try

        FLabourCost := strValue(DataSet.FieldByName('LabCost').AsString);
        FSundriesCost := strValue(DataSet.FieldByName('Sundries').AsString);
        Result := DataSet.FieldByName('DoorType').AsString;
      finally
        FreeAndNil(DataSet);
      end;
    end;
  finally
    FreeAndNil(Params);
  end;
end;

function TDoors.GetGlazingCost(const GlazingShape, GlazingType: string; const GlazingMats: string = ''): Double;
var
  DataSet: TDataSet;
  Params: TVarParams;
begin
  Result := 0;
  Params := TVarParams.Create;

  try
    Params.Add('GlazingShape', QuotedStr(GlazingShape));
    Params.Add('GlazingType', QuotedStr(GlazingType));

    if GlazingMats = '' then
      DataSet := QueryLoad.Execute('GlazingCost1', Params)
    else begin
      Params.Add('GlazingMats', QuotedStr(GlazingMats));
      DataSet := QueryLoad.Execute('GlazingCost2', Params);
    end;

    if Assigned(DataSet) then begin
      try
        Result := strValue(DataSet.FieldByName('GlazingCost').AsString);
      finally
        FreeAndNil(DataSet);
      end;
    end;
  finally
    FreeAndNil(Params);
  end;
end;

function TDoors.GetJoineryCost(const Description: string; out UnitOfCharge: string): Double;
var
  DataSet: TDataSet;
  Params: TVarParams;
begin
  Result := 0;
  UnitOfCharge := '';
  Params := TVarParams.Create;

  try
    Params.Add('Description', QuotedStr(Description));
    DataSet := QueryLoad.Execute('JoineryCost', Params);

    if Assigned(DataSet) then begin
      try
        Result := strValue(DataSet.FieldByName('Cost').AsString);
        UnitOfCharge := DataSet.FieldByName('UnitOfCharge').AsString;
      finally
        FreeAndNil(DataSet);
      end;
    end;
  finally
    FreeAndNil(Params);
  end;
end;

function TDoors.GetStilesCost(const Code: string): Double;
var
  DataSet: TDataSet;
  Params: TVarParams;
begin
  Result := 0;
  Params := TVarParams.Create;

  try
    Params.Add('Code', QuotedStr(Code));
    DataSet := QueryLoad.Execute('StilesCost', Params);

    if Assigned(DataSet) then begin
      try
        Result := strValue(DataSet.FieldByName('CostPerMetre').AsString);
      finally
        FreeAndNil(DataSet);
      end;
    end;
  finally
    FreeAndNil(Params);
  end;
end;

function TDoors.GetSundryCost(const Code: string): Double;
var
  DataSet: TDataSet;
  Params: TVarParams;
begin
  Result := 0;
  Params := TVarParams.Create;

  try
    Params.Add('Code', QuotedStr(Code));
    DataSet := QueryLoad.Execute('SundryCost', Params);

    if Assigned(DataSet) then begin
      try
        Result := strValue(DataSet.FieldByName('Cost').AsString);
      finally
        FreeAndNil(DataSet);
      end;
    end;
  finally
    FreeAndNil(Params);
  end;
end;

function TDoors.NewDoorCost(const tcompref, tpos: string; const thghtmats, twidmats, tqty, tdwid, tdhght: Double): Double;
var
  Index: Integer;
  dtol: Double;
  etol: Double;
  dompno: Integer;
  tcost: Double;
  ecost: Double;
  dcost: Double;
  drcost: Double;
  coreno: Double;
  corelen: Double;
  compwid: Double;
  amtused: Double;
  chkhght: Double;
  mathght: Double;
  tempwid: Double;
  temphght: Double;
  tempmeas: Double;
  temparea: Double;
  dfiltset: TERPQuery;
  efiltset: TERPQuery;
begin
  Result := 0;
  dfiltset := TERPQuery.Create(nil);
  efiltset := TERPQuery.Create(nil);

  try
    dfiltset.SQL.Text := 'SELECT DISTINCTROW * FROM vwDoorcompdetList ' +
                         'WHERE CompRef = ' + QuotedStr(tcompref) + ' ' +
                         'ORDER BY Height, Width';
    dfiltset.Connection := GetSharedMyDacConnection;
    efiltset.Connection := GetSharedMyDacConnection;
    dfiltset.Open;
    dompno := dfiltset.RecordCount;

    if dompno = 0 then begin
//      MessageDlgXP_Vista('No component data is available for ' + tcompref, mtInformation, [mbOK], 0);
    end
    else begin
      
      drcost := 0;

      if FastFuncs.SameText(tpos, 'Height') then begin
        dfiltset.First;
        temphght := tdhght + thghtmats;

        if dompno > 1 then begin
          while (not dfiltset.Eof) and (temphght > dfiltset.FieldByName('Height').AsInteger) do
            dfiltset.Next;
        end;

        dtol := dfiltset.FieldByName('Tolerance').AsFloat;
        dcost := dfiltset.FieldByName('Cost').AsFloat;
        tempmeas := dfiltset.FieldByName('Height').AsFloat / dtol;

        if dtol > 0 then begin
          if FastFuncs.SameText(dfiltset.FieldByName('Unit').AsString, 'each') then begin
            Index := 1;

            while (Index <= dtol) and (temphght > (tempmeas * Index)) do begin
              tcost := dcost / dtol * Index;
              drcost := drcost + (tcost * tqty);
              Inc(Index);
            end;
          end
          else if FastFuncs.SameText(dfiltset.FieldByName('Unit').AsString, 'lin m') then begin
            tcost := dcost * temphght / 1000;
            drcost := drcost + (tcost * tqty);
          end;
        end;
      end
      else if FastFuncs.SameText(tpos, 'Width') then begin
        dfiltset.First;
        temphght := tdwid + twidmats;

        if dompno > 1 then begin
          while (not dfiltset.Eof) and (temphght > dfiltset.FieldByName('Height').AsInteger) do
            dfiltset.Next;
        end;

        dtol := dfiltset.FieldByName('Tolerance').AsInteger;
        dcost := dfiltset.FieldByName('Cost').AsFloat;
        tempmeas := dfiltset.FieldByName('Height').AsFloat / dtol;

        if dtol > 0 then begin
          if FastFuncs.SameText(dfiltset.FieldByName('Unit').AsString, 'each') then begin
            Index := 1;

            while (Index <= dtol) and (temphght > (tempmeas * Index)) do begin
              tcost := dcost / dtol * Index;
              drcost := drcost + (tcost * tqty);
              Inc(Index);
            end;
          end
          else if FastFuncs.SameText(dfiltset.FieldByName('Unit').AsString, 'lin m') then begin
            tcost := dcost * temphght / 1000;
            drcost := drcost + (tcost * tqty);
          end;
        end;
      end
      else if FastFuncs.SameText(tpos, 'Area') then begin
        dfiltset.First;
        mathght := thghtmats;
        temphght := tdhght + mathght;

        if dompno > 1 then begin
          while (not dfiltset.Eof) and (temphght > dfiltset.FieldByName('Height').AsInteger) do
            dfiltset.Next;
        end;

        chkhght := dfiltset.FieldByName('Height').AsFloat;
        efiltset.SQL.Text := 'SELECT DISTINCTROW * FROM vwDoorcompdetList ' +
                             'WHERE (CompRef = ' + QuotedStr(tcompref) + ') AND (Height = ' + FloatToStr(chkhght) + ') ' +
                             'ORDER BY Height, Width';
        efiltset.Open;
        efiltset.First;
        tempwid := tdwid + twidmats;

        while (not efiltset.Eof) and (tempwid >= efiltset.FieldByName('Width').AsFloat) do
          efiltset.Next;

        if efiltset.Eof then begin
//          MessageDlgXP_Vista('No price is available for ' + tcompref, mtInformation, [mbOK], 0);
        end
        else begin
          etol := efiltset.FieldByName('Tolerance').AsFloat;
          ecost := efiltset.FieldByName('Cost').AsFloat;
          tempmeas := efiltset.FieldByname('Height').AsFloat * efiltset.FieldByname('Width').AsFloat / etol;
          temparea := temphght * tempwid;

          if etol > 0 then begin
            Index := 1;
            tcost := ecost;
            while (Index <= etol) and (temparea > (tempmeas * Index)) do begin
              if (tempwid > (efiltset.FieldByName('Width').AsFloat / etol * Index)) and
                 (temphght > (efiltset.FieldByname('Height').AsFloat / etol * Index)) then
                Inc(Index);

              tcost := ecost / etol * Index;
              Inc(Index);
            end;

            drcost := tcost * tqty;
          end;
        end;

        efiltset.Close;
      end
      else if FastFuncs.SameText(tpos, 'Core') then begin
        dfiltset.First;
        temphght := tdhght + thghtmats;
        dcost := dfiltset.FieldByName('Cost').AsFloat;
        coreno := temphght / dfiltset.FieldByName('Width').AsFloat;
        corelen := Trunc(coreno);

        if coreno > corelen then begin
          if (coreno - corelen) > 0.5 then
            corelen := corelen + 1
          else
            corelen := corelen + 0.5;
        end;

        tempwid := (tdwid + twidmats) / 1000;
        compwid := dfiltset.FieldByName('Width').AsFloat / 1000;
        amtused := corelen * compwid * tempwid;
        tcost := amtused * dcost;

        if tcost > 0 then
          drcost := drcost + tcost;
      end
      else if FastFuncs.SameText(tpos, 'Item') then begin
        dfiltset.First;
        tcost := dfiltset.FieldByName('Cost').AsFloat;
        drcost := drcost + (tcost * tqty);
      end;

      dfiltset.Close;
      Result := drcost;
    end;
  finally
    FreeAndNil(dfiltset);
    FreeAndNil(efiltset);
  end;
end;

function TDoors.GetNewDoorCost(const DType: string; const Width, Height: Double): Double;
var
  CompRef: string;
  Position: string;
  HeightMats: Double;
  WidthMats: Double;
  Quantity: Double;
  DataSet: TDataSet;
  Params: TVarParams;
begin
  Result := 0;
  Params := TVarParams.Create;

  try
    Params.Add('DoorType', QuotedStr(DType));
    Params.Add('Finish', QuotedStr(Facing));
    DataSet := QueryLoad.Execute('GetNewDoorCost', Params);

    if Assigned(DataSet) then begin
      try
        CompRef     := DataSet.FieldByName('CompRef').AsString;
        Position    := DataSet.FieldByName('Position').AsString;
        HeightMats  := strValue(DataSet.FieldByName('HghtMats').AsString);
        WidthMats   := strValue(DataSet.FieldByName('WidMats').AsString);
        Quantity    := strValue(DataSet.FieldByName('Quantity').AsString);
        Result      := NewDoorCost(CompRef, Position, HeightMats, WidthMats, Quantity, Width, Height);
      finally
        FreeAndNil(DataSet);
      end;
    end;
  finally
    FreeAndNil(Params);
  end;
end;
end.
