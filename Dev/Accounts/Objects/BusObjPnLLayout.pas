unit BusObjPnlLayout;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 22/09/30 1.00.01 Wang  Added TPNLLayout business object.
}

interface

uses
  MyAccess, ERPdbComponents, DB, Dialogs, SysUtils, Variants, Classes,
  BusObjBase, XMLDoc, XMLIntf, commonlib;

type

  TPNLLayout = class(TMSBusObj)
  private
    function GetLName         : String;
    function GetDescription   : String;
    function GetIsCurrent     : Boolean;

    procedure SetLName        (Const Value : String);
    procedure SetDescription  (Const Value : String);
    procedure SetIsCurrent    (Const Value : Boolean);

  protected
    function  DoAfterInsert(Sender: TDatasetBusObj)   : Boolean;    Override;
    function  DoAfterPost(Sender: TDatasetBusObj)     : Boolean;    Override;
    function  DoBeforePost(Sender: TDatasetBusObj)    : Boolean;    Override;
    function  GetSQL                                  : String;     Override;

  public
    Constructor     Create(AOwner: TComponent);             Override;
    destructor      Destroy;                                Override;
    procedure       DoFieldOnChange(Sender: TField);        Override;
    class function  GetBusObjectTablename: string;          Override;
    class function  GetIDField: string;                     Override;
    function        GetId: Integer;                                Override;
    procedure       LoadFromXMLNode(Const node: IXMLNode);  Override;
    procedure       SaveToXMLNode(Const node: IXMLNode);    Override;
    function        ValidateData :Boolean ;                 Override;
    function        Save :Boolean ;                         Override;

  Published
    property LName            : String        read GetLName         write SetLName;
    property Description      : String        read GetDescription   write SetDescription;
    property IsCurrentLayout  : Boolean       read GetIsCurrent     Write SetIsCurrent;

  end;

implementation

uses
   tcDataUtils, AppEnvironment, BusObjRegionalOptions,
   CommonDbLib, BusObjConst,  DNMLib, BusObjectListObj, BusObjSchemaLib,
   BusobjCountries, BusObjLocation, DbSharedObjectsObj, tcConst, Controls;


 { TPNLLayout }
Constructor TPNLLayout.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSql := 'SELECT * FROM tblpnllayouts WHERE LayoutID > 0';
  ExportExcludeList.Add('ID');
end;

destructor TPNLLayout.Destroy;
begin
  inherited;
end;

class function TPNLLayout.GetBusObjectTablename: string;
begin
  Result := 'tblpnllayouts';
end;

function TPNLLayout.GetSQL: string;
begin
  Log('Hi');
  Result := inherited GetSQL;
end;

class function  TPNLLayout.GetIDField :String;
begin
  Result := 'LayoutID';
end;

procedure TPNLLayout.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  inherited;
end;

function TPNLLayout.GetID:          Integer;    begin Result := GetIntegerField('LayoutID');    end;
function TPNLLayout.GetLName:       String;     begin Result := GetStringField('LName');        end;
function TPNLLayout.GetDescription: String;     begin Result := GetStringField('Description');  end;
function TPNLLayout.GetIsCurrent:   Boolean;    begin Result := GetBooleanField('IsCurrentLayout');  end;

procedure TPNLLayout.SetLName       (Const Value: String);     begin SetStringField('LName', Value);          end;
procedure TPNLLayout.SetDescription (Const Value: String);     begin SetStringField('Description', Value);    end;
procedure TPNLLayout.SetIsCurrent   (Const Value: Boolean);    begin SetBooleanField('IsCurrentLayout', Value);    end;

procedure TPNLLayout.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'LName');
  SetPropertyFromNode(Node,'Description');
  SetPropertyFromNode(Node,'IsCurrent');
end;

procedure TPNLLayout.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node , 'MEveryDay',        LName);
  AddXMLNode(node , 'MMonths',          Description);
  AddXMLNode(node , 'IsCurrentLayout',  IsCurrentLayout);
end;

function TPNLLayout.ValidateData : Boolean;
var
  CleanCodeName: string;
begin
  Result := inherited ValidateData;
  if not Result then Exit;

  Result := False;
  Resultstatus.Clear;

  Result := True;
end;

function TPNLLayout.Save: Boolean;
var
  TempQuery: TERPQuery;
  TempScript: TERPScript;
  Cnt: Integer;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;

  // Store LayoutData if not
  TempQuery := TERPQuery.Create(nil);
  try
    with TempQuery do begin
      Connection := CommonDbLib.GetSharedMyDacConnection;
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) AS Cnt FROM tblPnLLayoutData3 WHERE LayoutID=' + IntToStr(ID));
      Open;
      Cnt := FieldByName('Cnt').AsInteger;
      Close;

      if Cnt = 0 then begin
        // Duplicate standard layout
        TempScript := TERPScript.Create(nil);
        try
          with TempScript do begin
            Connection := CommonDbLib.GetSharedMyDacConnection;
            SQL.Clear;

            SQL.Add('INSERT INTO `tblpnllayoutdata3` (`Parent`, `Pos`, `Name`, `IsAccount`, `IsRoot`, `AccountID`, `LayoutID`, `msTimeStamp`) VALUES (0, "01", "Income", "F", "T", 0, ' + IntToStr(ID) + ', "2022-10-04 13:48:57");');
            SQL.Add('INSERT INTO `tblpnllayoutdata3` (`Parent`, `Pos`, `Name`, `IsAccount`, `IsRoot`, `AccountID`, `LayoutID`, `msTimeStamp`) VALUES (0, "02", "Cost of Goods Sold", "F", "T", 0, ' + IntToStr(ID) + ', "2022-10-04 19:17:14");');
            SQL.Add('INSERT INTO `tblpnllayoutdata3` (`Parent`, `Pos`, `Name`, `IsAccount`, `IsRoot`, `AccountID`, `LayoutID`, `msTimeStamp`) VALUES (0, "03", "Expense", "F", "T", 0, ' + IntToStr(ID) + ', "2022-10-04 19:17:21");');
            SQL.Add('INSERT INTO `tblpnllayoutdata3` (`Parent`, `Pos`, `Name`, `IsAccount`, `IsRoot`, `AccountID`, `LayoutID`, `msTimeStamp`) VALUES (0, "04", "Gross Profit", "F", "T", 0, ' + IntToStr(ID) + ', "2022-10-04 19:10:36");');
            SQL.Add('INSERT INTO `tblpnllayoutdata3` (`Parent`, `Pos`, `Name`, `IsAccount`, `IsRoot`, `AccountID`, `LayoutID`, `msTimeStamp`) VALUES (0, "05", "Net Income", "F", "T", 0, ' + IntToStr(ID) + ', "2022-10-04 19:17:30");');

            SQL.Add('INSERT INTO tblpnllayoutdata3 (Pos, Parent, IsRoot, IsAccount, LayoutID, `Name`, AccountID)');
            SQL.Add('SELECT CONCAT("01", LPAD(@row:=@row + 1, 2, 0)),');
            SQL.Add('(SELECT ID FROM tblpnllayoutdata3 WHERE IsRoot="T" AND `Name`="Income" AND LayoutID=0),');
            SQL.Add('"F", "T", ' + IntToStr(ID) + ', AccountName, AccountID');
            SQL.Add('FROM tblchartofaccounts, (SELECT @row:=0) Dummy');
            SQL.Add('WHERE AccountType = "EXINC" OR AccountType = "INC";');

            SQL.Add('INSERT INTO tblpnllayoutdata3 (Pos, Parent, IsRoot, IsAccount, LayoutID, `Name`, AccountID)');
            SQL.Add('SELECT CONCAT("02", LPAD(@row:=@row + 1, 2, 0)),');
            SQL.Add('(SELECT ID FROM tblpnllayoutdata3 WHERE IsRoot="T" AND `Name`="Cost of Goods Sold" AND LayoutID=0),');
            SQL.Add('"F", "T", ' + IntToStr(ID) + ', AccountName, AccountID');
            SQL.Add('FROM tblchartofaccounts, (SELECT @row:=0) Dummy');
            SQL.Add('WHERE AccountType = "COGS";');

            SQL.Add('INSERT INTO tblpnllayoutdata3 (Pos, Parent, IsRoot, IsAccount, LayoutID, `Name`, AccountID)');
            SQL.Add('SELECT CONCAT("03", LPAD(@row:=@row + 1, 2, 0)),');
            SQL.Add('(SELECT ID FROM tblpnllayoutdata3 WHERE IsRoot="T" AND `Name`="Expense" AND LayoutID=0),');
            SQL.Add('"F", "T", ' + IntToStr(ID) + ', AccountName, AccountID');
            SQL.Add('FROM tblchartofaccounts, (SELECT @row:=0) Dummy');
            SQL.Add('WHERE AccountType = "EXEXP" OR AccountType = "EXP";');

            Execute;
          end;
        finally
          TempScript.Free;
        end;
      end;
    end;
  finally
    TempQuery.Free;
  end;
end;

function TPNLLayout.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterInsert(Sender);
  if not Result then exit;
end;

function TPNLLayout.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;

function TPNLLayout.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not(Result) then Exit;
end;
initialization
  RegisterClassOnce(TPNLLayout);
end.

