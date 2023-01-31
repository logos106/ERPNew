unit ColoursPrefsObj;

interface

uses
  Classes, Contnrs, Graphics, DataSourcePrefs;

type
  TColorGroup = class (TObject)
    ColorGroup: String;
    Colour: Tcolor;
    GradIntensity: Integer;
  end;

  TSkinsGroup = class (TObject)
    FormName: String;
    SkinsGroup: String;
  end;

  TColoursPrefsObj = class(TObject)
  private
    fColorGroupList: TObjectList;
    fSkinsGroupList: TObjectList;
    DataSourcePrefs: TDataSourcePrefs;
    procedure LoadColorGroupList;
    procedure LoadSkinsGroupList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure PopulateMe;
    Function GetSkinsGroup(const ClassStr: String):String;
    Function GetColour(Const ColorGroup:String):TColor;
    Function GetColourForindex(index :Integer):TColor;
    Function GetGradIntensity(Const ColorGroup:String):Integer;

  end;

implementation

uses
  SysUtils, CommonDbLib, tcConst, MyAccess,ERPdbComponents;

constructor TColoursPrefsObj.Create;
begin
  inherited;
  fColorGroupList := TObjectList.Create(True);
  fSkinsGroupList := TObjectList.Create(True);
end;

destructor TColoursPrefsObj.Destroy;
begin
  FreeandNil(fColorGroupList);
  FreeandNil(fSkinsGroupList);
  inherited;
end;

function TColoursPrefsObj.GetColour(const ColorGroup: String): TColor;
var
  x: integer;
begin
  result:= clBtnFace;
  for x:= 0 to fColorGroupList.Count -1 do begin
    if Sysutils.SameText(TColorGroup(fColorGroupList[x]).ColorGroup,ColorGroup) then begin
      result:= TColorGroup(fColorGroupList[x]).Colour;
      break;
    end;
  end;
end;

function TColoursPrefsObj.GetColourForindex(index: Integer): TColor;
begin
  While Index>= fSkinsGroupList.Count do
    index := index -fSkinsGroupList.Count;

  REsult := Getcolour(TSkinsGroup(fSkinsGroupList[Index]).SkinsGroup) ;

end;

function TColoursPrefsObj.GetGradIntensity(const ColorGroup: String): Integer;
var
  x: integer;
begin
  result:= 0;
  for x:= 0 to fColorGroupList.Count -1 do begin
    if Sysutils.SameText(TColorGroup(fColorGroupList[x]).ColorGroup,ColorGroup) then begin
      result:= TColorGroup(fColorGroupList[x]).GradIntensity;
      break;
    end;
  end;
end;

procedure TColoursPrefsObj.LoadColorGroupList;
var
  Index: Integer;
  tmpColGrp: TColorGroup;
begin
  fColorGroupList.Clear;
  for Index := 1 to cMaxColorMap do begin
  try
    If Sysutils.SameText(cColorMapping[Index].Name,'AboutBackground') then Continue;
    tmpColGrp := TColorGroup.Create;
    tmpColGrp.ColorGroup := cColorMapping[Index].Name;
    tmpColGrp.Colour := TColor(DataSourcePrefs.FieldByName('Colour'+tmpColGrp.ColorGroup).asInteger);
    tmpColGrp.GradIntensity := DataSourcePrefs.FieldByName('GradIntensity'+tmpColGrp.ColorGroup).asInteger;
    fColorGroupList.Add(tmpColGrp);
  Except

  end;
  end;
end;

procedure TColoursPrefsObj.LoadSkinsGroupList;
var
  qry: TERPQuery;
  tmpSkinGrp: TSkinsGroup;
begin
  fSkinsGroupList.Clear;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.SQL.Text := 'SELECT FormID,FormName,SkinsGroup FROM tblforms;';
    qry.Open;
    qry.First;
    while Not qry.eof do begin
      tmpSkinGrp := TSkinsGroup.Create;
      tmpSkinGrp.FormName := qry.FieldByName('FormName').asString;
      tmpSkinGrp.SkinsGroup := qry.FieldByName('SkinsGroup').asString;
      fSkinsGroupList.Add(tmpSkinGrp);
      qry.Next;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TColoursPrefsObj.GetSkinsGroup(const ClassStr: String): String;
var
  x: integer;
begin
  result:= '';
  for x:= 0 to fSkinsGroupList.Count -1 do begin
    if Sysutils.SameText(TSkinsGroup(fSkinsGroupList[x]).FormName,ClassStr) then begin
      result:= TSkinsGroup(fSkinsGroupList[x]).SkinsGroup;
      break;
    end;
  end;
end;


procedure TColoursPrefsObj.PopulateMe;
begin
  DataSourcePrefs := TDataSourcePrefs.Create(nil);
  Try
    DataSourcePrefs.Connection := GetSharedMyDacConnection;
    DataSourcePrefs.FieldNames.Add('ColourAccounts');
    DataSourcePrefs.FieldNames.Add('GradIntensityAccounts');
    DataSourcePrefs.FieldNames.Add('ColourAppointments');
    DataSourcePrefs.FieldNames.Add('GradIntensityAppointments');
    DataSourcePrefs.FieldNames.Add('ColourCRM');
    DataSourcePrefs.FieldNames.Add('GradIntensityCRM');
    DataSourcePrefs.FieldNames.Add('ColourEmployee');
    DataSourcePrefs.FieldNames.Add('GradIntensityEmployee');
    DataSourcePrefs.FieldNames.Add('ColourFixedAssets');
    DataSourcePrefs.FieldNames.Add('GradIntensityFixedAssets');
    DataSourcePrefs.FieldNames.Add('ColourGeneral');
    DataSourcePrefs.FieldNames.Add('GradIntensityGeneral');
    DataSourcePrefs.FieldNames.Add('ColourGoogle');
    DataSourcePrefs.FieldNames.Add('ColourHire');
    DataSourcePrefs.FieldNames.Add('GradIntensitygoogle');
    DataSourcePrefs.FieldNames.Add('GradIntensityHire');
    DataSourcePrefs.FieldNames.Add('ColourInventory');
    DataSourcePrefs.FieldNames.Add('GradIntensityInventory');
    DataSourcePrefs.FieldNames.Add('ColourMainBackground');
    DataSourcePrefs.FieldNames.Add('GradIntensityMainBackground');
    DataSourcePrefs.FieldNames.Add('ColourManufacturing');
    DataSourcePrefs.FieldNames.Add('GradIntensityManufacturing');
    DataSourcePrefs.FieldNames.Add('ColourMiscellaneous');
    DataSourcePrefs.FieldNames.Add('GradIntensityMiscellaneous');
    DataSourcePrefs.FieldNames.Add('ColourPayroll');
    DataSourcePrefs.FieldNames.Add('GradIntensityPayroll');
    DataSourcePrefs.FieldNames.Add('ColourPurchases');
    DataSourcePrefs.FieldNames.Add('GradIntensityPurchases');
    DataSourcePrefs.FieldNames.Add('ColourReturns');
    DataSourcePrefs.FieldNames.Add('GradIntensityReturns');
    DataSourcePrefs.FieldNames.Add('ColourSales');
    DataSourcePrefs.FieldNames.Add('GradIntensitySales');
    DataSourcePrefs.FieldNames.Add('ColourSalesOrder');
    DataSourcePrefs.FieldNames.Add('GradIntensitySalesOrder');
    DataSourcePrefs.FieldNames.Add('ColourUtilities');
    DataSourcePrefs.FieldNames.Add('GradIntensityUtilities');
    DataSourcePrefs.FieldNames.Add('ColourTraining');
    DataSourcePrefs.FieldNames.Add('GradIntensityTraining');
    DataSourcePrefs.FieldNames.Add('Colourbanking');
    DataSourcePrefs.FieldNames.Add('GradIntensitybanking');
    DataSourcePrefs.FieldNames.Add('ColourDelivery');
    DataSourcePrefs.FieldNames.Add('GradIntensityDelivery');
    DataSourcePrefs.FieldNames.Add('ColourPayments');
    DataSourcePrefs.FieldNames.Add('GradIntensityPayments');
    DataSourcePrefs.FieldNames.Add('ColourPOS');
    DataSourcePrefs.FieldNames.Add('GradIntensityPOS');
    DataSourcePrefs.FieldNames.Add('ColourRepairs');
    DataSourcePrefs.FieldNames.Add('GradIntensityRepairs');
    DataSourcePrefs.FieldNames.Add('ColourEBay');
    DataSourcePrefs.FieldNames.Add('GradIntensityEbay');
    DataSourcePrefs.Active := True;
    LoadSkinsGroupList;
    LoadColorGroupList;
    DataSourcePrefs.Active := False;
  Finally
    DataSourcePrefs.Free;
  end;
end;

end.

