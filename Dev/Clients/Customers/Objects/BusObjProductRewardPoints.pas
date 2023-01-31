unit BusObjProductRewardPoints;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  16/09/09  1.00.00  A.  Initial Version.
}

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type
  TProductRewardPoints = class(TMSBusObj)
  private
    function GetPartsId: Integer;
    function GetPartname: string;
    function GetPoints: Double;
    function GetValue: Double;
    function GetUseDate: Boolean;
    function GetUseExpiryDate: Boolean;
    function GetDateFrom: TDateTime;
    function GetRewardPointExpiresOn: TDateTime;
    function GetDateTo: TDateTime;
    function GetActive: Boolean;
    function GetDateCreated: TDateTime;
    procedure SetPartsId(const Value: Integer);
    procedure SetPartname(const Value: string);
    procedure SetPoints(const Value: Double);
    procedure SetValue(const Value: Double);
    procedure SetUseDate(const Value: Boolean);
    procedure SetUseExpiryDate(const Value: Boolean);
    procedure SetDateFrom(const Value: TDateTime);
    procedure SetRewardPointExpiresOn(const Value: TDateTime);
    procedure SetDateTo(const Value: TDateTime);
    procedure SetActive(const Value: Boolean);
    procedure SetDateCreated(const Value: TDateTime);
    function getUOM: string;
    function getUOMID: Integer;
    procedure SetUOM(const Value: string);
    procedure setUOMID(const Value: Integer);
    function CheckRecordExists: Boolean;
//    function GetProduct: TProduct;
    function GetUOMMultiplier: Double;
    procedure setUOMMultiplier(const Value: Double);
    function getUseUOM: Boolean;
    procedure setUseUOM(const Value: Boolean);
    function getExpiresOnNoOfMonthsAfterPurchase: Integer;
    procedure setExpiresOnNoOfMonthsAfterPurchase(const Value: Integer);
    function getClientTypeID: Integer;
    procedure setClientTypeID(const Value: Integer);
    function GetClientTypeName: string;
    procedure SetClientTypeName(const Value: string);
    function GetUOMUnitProductKeyName: string;
    procedure SetUOMUnitProductKeyName(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
//    property Product: TProduct read GetProduct;
//    class function PointsExpireDate(const SLPAlias: string = 'SLP'): string;
    function Locaterecord(Partname: string; UseDate: Boolean; DateFrom: TDateTime; DateTo: TDateTime; ClientTypeID: Integer; UseUOM: Boolean; UOMID: Integer): Boolean;
    class function _Schema: string; override;
  published
    property PartsId: Integer read GetPartsId write SetPartsId;
    property PartName: string read GetPartname write SetPartname;
    property ClientTypeID: Integer read getClientTypeID write setClientTypeID;
    property ClientTypeName: string read GetClientTypeName write SetClientTypeName;
    property Points: Double read GetPoints write SetPoints;
    property Value: Double read GetValue write SetValue;
    property UseDate: Boolean read GetUseDate write SetUseDate;
    property UseExpiryDate: Boolean read GetUseExpiryDate write SetUseExpiryDate;
    property DateFrom: TDateTime read GetDateFrom write SetDateFrom;
    property DateTo: TDateTime read GetDateTo write SetDateTo;
    property RewardPointExpiresOn: TDateTime read GetRewardPointExpiresOn write SetRewardPointExpiresOn;
    property ExpiresOnNoOfMonthsAfterPurchase: Integer read getExpiresOnNoOfMonthsAfterPurchase write setExpiresOnNoOfMonthsAfterPurchase;
    property Active: Boolean read GetActive write SetActive;
    property DateCreated: TDateTime read GetDateCreated write SetDateCreated;
    property UseUOM: Boolean read getUseUOM write setUseUOM;
    property UOMID: Integer read getUOMID write setUOMID;
    property UOM: string read getUOM write SetUOM;
    property UOMMultiplier: Double read GetUOMMultiplier write setUOMMultiplier;
    property UOMUnitProductKeyName: string read GetUOMUnitProductKeyName write SetUOMUnitProductKeyName;
  end;

implementation

uses tcDataUtils, CommonLib, sysutils, BusObjSaleBase, AppEnvironment,
  CompanyPrefObj, BusObjCommon, BusObjSchemaLib, BusObjUOM, BusObjStock, SystemLib;

{ TProductRewardPoints }

constructor TProductRewardPoints.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'ProductRewardPoints';
  fSQL := 'SELECT * FROM tblproductrewardpoints';
  self.ExportExcludeList.Add('partsid');
  self.ExportExcludeList.Add('clienttypeid');
  self.ExportExcludeList.Add('uomid');
  if Assigned(Owner) and (Owner is TProduct) then begin
    self.IsList:= true;
    self.ExportExcludeList.Add('partname');
  end;
end;

destructor TProductRewardPoints.Destroy;
begin
  inherited;
end;

procedure TProductRewardPoints.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'PartsId');
  SetPropertyFromNode(node, 'ClientTypeID');
  SetPropertyFromNode(node, 'Points');
  SetPropertyFromNode(node, 'Value');
  SetPropertyFromNode(node, 'Partname');
  SetBooleanPropertyFromNode(node, 'UseDate');
  SetBooleanPropertyFromNode(node, 'UseUOM');
  SetBooleanPropertyFromNode(node, 'UseExpiryDate');
  SetDateTimePropertyFromNode(node, 'DateFrom');
  SetDateTimePropertyFromNode(node, 'RewardPointExpiresOn');
  SetPropertyFromNode(node, 'ExpiresOnNoOfMonthsAfterPurchase');
  SetDateTimePropertyFromNode(node, 'DateTo');
  SetBooleanPropertyFromNode(node, 'Active');
  SetDateTimePropertyFromNode(node, 'DateCreated');
  SetPropertyFromNode(node, 'UOM');
  SetPropertyFromNode(node, 'UOMID');
  SetPropertyFromNode(node, 'UOMMultiplier');
end;

procedure TProductRewardPoints.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'PartsId', PartsId);
  AddXMLNode(node, 'ClientTypeID', ClientTypeID);
  AddXMLNode(node, 'Points', Points);
  AddXMLNode(node, 'Value', Value);
  AddXMLNode(node, 'Partname', Partname);
  AddXMLNode(node, 'UseDate', UseDate);
  AddXMLNode(node, 'UseUOM', UseUOM);
  AddXMLNode(node, 'UseExpiryDate', UseExpiryDate);
  AddXMLNode(node, 'DateFrom', DateFrom);
  AddXMLNode(node, 'RewardPointExpiresOn', RewardPointExpiresOn);
  AddXMLNode(node, 'ExpiresOnNoOfMonthsAfterPurchase', ExpiresOnNoOfMonthsAfterPurchase);
  AddXMLNode(node, 'DateTo', DateTo);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'DateCreated', DateCreated);
  AddXMLNode(node, 'UOM', UOM);
  AddXMLNode(node, 'UOMID', UOMID);
  AddXMLNode(node, 'UOMMultiplier', UOMMultiplier);
end;

function TProductRewardPoints.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if (PartsId = 0) or (Partname = '') then begin
    Resultstatus.addItem(False, rssError, 0, 'Product should not be blank');
    Exit;
  end;
  if Points = 0 then begin
    Resultstatus.addItem(False, rssError, 0, 'Points should not be blank');
    Exit;
  end;
  if Value = 0 then begin
    Resultstatus.addItem(False, rssError, 0, 'Value should not be blank');
    Exit;
  end;
  if UseDate then begin
    if (DateFrom = 0) or (DateTo = 0) then begin
      Resultstatus.addItem(False, rssError, 0, 'Date from and Date to should not be blank');
      Exit;
    end;
  end;
  if UseUOM then begin
    if UOMID = 0 then begin
      Resultstatus.addItem(False, rssError, 0, 'Unit of measure should not be blank');
      Exit;
    end;
  end;
  if UseExpiryDate then begin
    if (RewardPointExpiresOn = 0) and (ExpiresOnNoOfMonthsAfterPurchase = 0) then begin
      Resultstatus.addItem(False, rssError, 0, 'Points expirs on date/ expires months after should not be blank');
      Exit;
    end;
  end;
  if ClientTypeID < 0 then begin
    Resultstatus.addItem(False, rssError, 0, 'Client Type not found');
    Exit;
  end;
  if CheckRecordExists then begin
    Exit;
  end;
  Result := True;
end;

class function TProductRewardPoints._Schema: string;
begin
  TBOSchema.AddRefType(result,'TClientType','ClientTypeObj','ClientTypeID','ID');
  TBOSchema.AddRefType(result,'TClientType','ClientTypeObj','ClientTypeName','TypeName');
  TBOSchema.AddRefType(result,'TProductWeb','ProductObj','PartsID','ID');
  TBOSchema.AddRefType(result,'TProductWeb','ProductObj','PartName','ProductName');
  TBOSchema.AddRefType(result,'TUnitOfMeasure','UomObj','UOMID','ID');
  TBOSchema.AddRefType(result,'TUnitOfMeasure','UomObj','UOMUnitProductKeyName','UnitProductKeyName');
end;

function TProductRewardPoints.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TProductRewardPoints.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TProductRewardPoints.DoFieldOnChange(Sender: TField);
var
  Prod: TProduct;
  UomObj: TUnitOfMeasure;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if sysutils.SameText(Sender.Fieldname, 'Partname') then begin
    PartsId := TProduct.IDToggle(Partname, Connection.Connection);
    if not RawMode then begin
      if Assigned(Owner) and (Owner is TProduct) then
        UOMID:= TProduct(Owner).UOMSalesID
      else begin
        Prod:= TProduct.Create(nil);
        try
          Prod.Connection:= self.Connection;
          Prod.Load(PartsID, true);
          UOMID:= Prod.UOMSalesID;
        finally
          Prod.Free;
        end;
      end;
      DoFieldOnChange(Dataset.findfield('UOMID'));
    end;
  end
  else if sysutils.SameText(Sender.Fieldname, 'UOMID') then begin
    if not RawMode then begin
      UomObj:= TUnitOfMeasure.Create(nil);
      try
        UomObj.Connection:= Connection;
        UomObj.Load(UOMID);
        UOM:= UomObj.UOMName;
        UOMMultiplier:= UomObj.Multiplier;
      finally
        UomObj.Free;
      end;
      UseUOM := True;
    end;
  end
  else if sysutils.SameText(Sender.Fieldname, 'PartsID') then begin
    PartName := TProduct.IDToggle(PartsID, Connection.Connection);
    if not RawMode then begin
      if Assigned(Owner) and (Owner is TProduct) then
        UOMID:= TProduct(Owner).UOMSalesID
      else begin
        Prod:= TProduct.Create(nil);
        try
          Prod.Connection:= self.Connection;
          Prod.Load(PartsID, true);
          UOMID:= Prod.UOMSalesID;
        finally
          Prod.Free;
        end;
      end;
      DoFieldOnChange(Dataset.findfield('UOMID'));
    end;
  end
  else if sysutils.SameText(Sender.Fieldname, 'DateFrom') then begin
    if not RawMode then begin
      if (DateTo = 0) or (DateTo < DateFrom) then DateTo := DateFrom;
      if (DateFrom <> 0) then UseDate := True;
    end;
  end
  else if sysutils.SameText(Sender.Fieldname, 'Dateto') then begin
    if not RawMode then begin
      if (DateFrom = 0) or (DateTo < DateFrom) then DateFrom := DateTo;
      if (DateFrom <> 0) then UseDate := True;
    end;
  end
  else if sysutils.SameText(Sender.Fieldname, 'RewardPointExpiresOn') then begin
    if not RawMode then begin
      if (RewardPointExpiresOn < DateTo) and (RewardPointExpiresOn <> 0) then RewardPointExpiresOn := DateTo;
      if RewardPointExpiresOn <> 0 then UseExpiryDate := True;
    end;
  end
  else if sysutils.SameText(Sender.Fieldname, 'ExpiresOnNoOfMonthsAfterPurchase') then begin
    if not RawMode then begin
      if ExpiresOnNoOfMonthsAfterPurchase <> 0 then UseExpiryDate := True;
    end;
  end
  else if sysutils.SameText(Sender.Fieldname, 'UseUOM') then begin
    if not RawMode then begin
      if not UseUOM then begin
        UOMID := 0;
        UOM := '';
        UOMMultiplier := 0;
        PostDB;
      end;
    end;
  end
  else if sysutils.SameText(Sender.Fieldname, 'UseDate') then begin
    if not RawMode then begin
      if not UseDate then begin
        DateFrom := 0;
        DateTo := 0;
      end;
    end;
  end
  else if sysutils.SameText(Sender.Fieldname, 'UseExpiryDate') then begin
    if not RawMode then begin
      if not UseExpiryDate then begin
        RewardPointExpiresOn := 0;
        ExpiresOnNoOfMonthsAfterPurchase := 0;
      end;
    end;
  end;
end;

function TProductRewardPoints.CheckRecordExists: Boolean;
var
  strSQL: string;
begin
  Result := False;
  if UseDate then begin
    strSQL := ' PartsId = ' + IntToStr(PartsId) + ' AND Active = "T" ' + ' AND UOMID = ' + IntToStr(UOMID) + ' and useUOM = ' + QuotedStr(BooleanToStr(UseUOM)) + ' AND (UseDate = "T" ' +
      ' AND ClientTypeID = ' + IntToStr(ClientTypeID) + ' AND (((DateFrom >= ' + QuotedStr(FormatDateTime('yyyy/mm/dd', DateFrom)) + ')' + ' AND   (DateFrom <= ' +
      QuotedStr(FormatDateTime('yyyy/mm/dd', DateTo)) + '))' + ' OR   ((DateTo   >= ' + QuotedStr(FormatDateTime('yyyy/mm/dd', DateFrom)) + ')' + ' AND   (DateTo   <= ' +
      QuotedStr(FormatDateTime('yyyy/mm/dd', DateTo)) + '))' + ' OR   ((DateTo   >= ' + QuotedStr(FormatDateTime('yyyy/mm/dd', DateTo)) + ')' + ' AND   (DateFrom <= ' +
      QuotedStr(FormatDateTime('yyyy/mm/dd', DateTo)) + '))' + ' ))';
  end else begin
    strSQL := ' PartsId = ' + IntToStr(PartsId) + ' AND Active = "T" ' + ' AND ClientTypeID = ' + IntToStr(ClientTypeID) + ' AND UOMID = ' + IntToStr(UOMID) + ' and useUOM = ' +
      QuotedStr(BooleanToStr(UseUOM)) + ' AND UseDate = "F" ';
  end;
  if not IsUnique(ID, strSQL) then begin
    Result := True;
    Resultstatus.addItem(False, rssError, 0, 'There is already an existing Reward Point record for ' + Partname + ' for overlaping period.');
  end;
end;

function TProductRewardPoints.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TProductRewardPoints.GetIDField: string;
begin
  Result := 'ProductRewardPointsId'
end;

class function TProductRewardPoints.GetBusObjectTablename: string;
begin
  Result := 'tblproductrewardpoints';
end;

function TProductRewardPoints.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TProductRewardPoints.GetPartsId: Integer;
begin
  Result := GetIntegerField('PartsId');
end;

function TProductRewardPoints.GetPartname: string;
begin
  Result := GetStringField('Partname');
end;

function TProductRewardPoints.GetPoints: Double;
begin
  Result := GetFloatField('Points');
end;

function TProductRewardPoints.GetValue: Double;
begin
  Result := GetFloatField('Value');
end;

function TProductRewardPoints.GetUseDate: Boolean;
begin
  Result := GetBooleanField('UseDate');
end;

function TProductRewardPoints.GetUseExpiryDate: Boolean;
begin
  Result := GetBooleanField('UseExpiryDate');
end;

function TProductRewardPoints.GetDateFrom: TDateTime;
begin
  Result := GetDateTimeField('DateFrom');
end;

function TProductRewardPoints.GetRewardPointExpiresOn: TDateTime;
begin
  Result := GetDateTimeField('RewardPointExpiresOn');
end;

function TProductRewardPoints.GetDateTo: TDateTime;
begin
  Result := GetDateTimeField('DateTo');
end;

function TProductRewardPoints.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TProductRewardPoints.GetClientTypeName: string;
begin
  if ClientTypeID > 0 then
    result:= TClientType.IDToggle(ClientTypeID, Connection.Connection)
  else
    result:= '';
end;

function TProductRewardPoints.GetDateCreated: TDateTime;
begin
  Result := GetDateTimeField('DateCreated');
end;

function TProductRewardPoints.getUseUOM: Boolean;
begin
  Result := GetBooleanField('UseUOM');
end;

function TProductRewardPoints.GetUOMMultiplier: Double;
begin
  Result := GetFloatField('UOMMultiplier');
end;

function TProductRewardPoints.GetUOMUnitProductKeyName: string;
begin
  result:= TUnitOfMeasure.IDToggle(UOMID, Connection.Connection);
end;

function TProductRewardPoints.getUOM: string;
begin
  Result := GetStringField('UOM');
end;

function TProductRewardPoints.getUOMID: Integer;
begin
  Result := GetIntegerField('UOMID');
end;

procedure TProductRewardPoints.SetPartsId(const Value: Integer);
begin
  SetIntegerField('PartsId', Value);
end;

procedure TProductRewardPoints.SetPartname(const Value: string);
begin
  SetStringField('Partname', Value);
end;

procedure TProductRewardPoints.SetPoints(const Value: Double);
begin
  SetFloatField('Points', Value);
end;

procedure TProductRewardPoints.SetValue(const Value: Double);
begin
  SetFloatField('Value', Value);
end;

procedure TProductRewardPoints.SetUOMUnitProductKeyName(const Value: string);
var
  UomObj: TUnitOfMeasure;
begin
  if Value <> '' then begin
    UomObj:= TUnitOfMeasure.Create(nil);
    try
      UomObj.Connection:= self.Connection;
      UomObj.LoadSelect('UnitProductKeyName = ' + QuotedStr(Value));
      if UomObj.Count > 0 then begin
        UOMID:= UomObj.ID;
        UOM:= UomObj.UOMName;
        UOMMultiplier:= UomObj.Multiplier;
      end
      else begin
        UOMID:= 0;
        UOM:= '';
        UOMMultiplier:= 1;
      end;
    finally
      UomObj.Free;
    end;
  end
  else begin
    UOMID:= 0;
    UOM:= '';
    UOMMultiplier:= 1;
  end;
end;

procedure TProductRewardPoints.SetUseDate(const Value: Boolean);
begin
  SetBooleanField('UseDate', Value);
end;

procedure TProductRewardPoints.SetUseExpiryDate(const Value: Boolean);
begin
  SetBooleanField('UseExpiryDate', Value);
end;

procedure TProductRewardPoints.SetDateFrom(const Value: TDateTime);
begin
  SetDateTimeField('DateFrom', Value);
end;

procedure TProductRewardPoints.SetRewardPointExpiresOn(const Value: TDateTime);
begin
  SetDateTimeField('RewardPointExpiresOn', Value);
end;

procedure TProductRewardPoints.SetDateTo(const Value: TDateTime);
begin
  SetDateTimeField('DateTo', Value);
end;

procedure TProductRewardPoints.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TProductRewardPoints.SetClientTypeName(const Value: string);
begin
  if Value <> '' then begin
    ClientTypeID:= TClientType.IDToggle(Value, Connection.Connection);
    if ClientTypeID = 0 then
      ClientTypeID:= -1
  end
  else
    ClientTypeID:= 0;
end;

procedure TProductRewardPoints.SetDateCreated(const Value: TDateTime);
begin
  SetDateTimeField('DateCreated', Value);
end;

procedure TProductRewardPoints.SetUOM(const Value: string);
begin
  SetStringField('UOM', Value);
end;

procedure TProductRewardPoints.setUOMID(const Value: Integer);
begin
  SetIntegerField('UOMID', Value);
end;

procedure TProductRewardPoints.setUOMMultiplier(const Value: Double);
begin
  SetFloatField('UOMMultiplier', Value);
end;

procedure TProductRewardPoints.setUseUOM(const Value: Boolean);
begin
  SetBooleanField('UseUOM', Value);
end;

function TProductRewardPoints.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  if Assigned(Owner) and (owner is TProduct) then begin
    self.PartsId:= TProduct(Owner).ID;
    self.PartName:= TProduct(Owner).ProductName;
  end;
  DateCreated := now;
  if Appenv.CompanyPrefs.ExpiresOnNoOfMonthsAfterPurchase <> 0 then begin
    UseExpiryDate := True;
    ExpiresOnNoOfMonthsAfterPurchase := Appenv.CompanyPrefs.ExpiresOnNoOfMonthsAfterPurchase;
  end;
end;

function TProductRewardPoints.getExpiresOnNoOfMonthsAfterPurchase: Integer;
begin
  Result := GetIntegerField('ExpiresOnNoOfMonthsAfterPurchase');
end;

procedure TProductRewardPoints.setExpiresOnNoOfMonthsAfterPurchase(const Value: Integer);
begin
  SetIntegerField('ExpiresOnNoOfMonthsAfterPurchase', Value);
end;

//class function TProductRewardPoints.PointsExpireDate(const SLPAlias: string): string;
//begin
//  Result := 'if(Ifnull(' + SLPAlias + '.PointExpiresOn,0)<> 0 , ' + SLPAlias + '.PointExpiresOn , ' + ' if(ifnull(' + SLPAlias + '.ExpiresOnNoOfMonthsAfterPurchase,0)  <> 0, ' +
//    ' Date_Add(S.SaleDate , Interval   ExpiresOnNoOfMonthsAfterPurchase MONTH),' + ' 0 )) ';
//
//end;

function TProductRewardPoints.getClientTypeID: Integer;
begin
  Result := GetIntegerField('ClientTypeID');
end;

procedure TProductRewardPoints.setClientTypeID(const Value: Integer);
begin
  SetIntegerField('ClientTypeID', Value);
end;

function TProductRewardPoints.Locaterecord(Partname: string; UseDate: Boolean; DateFrom, DateTo: TDateTime; ClientTypeID: Integer; UseUOM: Boolean; UOMID: Integer): Boolean;
var
  strSQL: string;
begin
  Result := False;
  if UseDate then begin
    strSQL := 'Select  ' + IDfieldname + ' from ' + BusObjectTableName + ' where ' + ' PartName = ' + QuotedStr(Partname) + ' AND Active = "T" ' + ' AND UOMID = ' + IntToStr(UOMID) + ' and useUOM = '
      + QuotedStr(BooleanToStr(UseUOM)) + ' AND UseDate = "T" ' + ' AND ClientTypeID = ' + IntToStr(ClientTypeID) + ' AND DateFrom = ' + QuotedStr(FormatDateTime('yyyy/mm/dd', DateFrom)) +
      ' AND DateTo = ' + QuotedStr(FormatDateTime('yyyy/mm/dd', DateTo));

    (* ' AND (((DateFrom >= ' +QuotedStr(FormatDateTime('yyyy/mm/dd', Datefrom)) + ')' +
      ' AND   (DateFrom <= ' +QuotedStr(FormatDateTime('yyyy/mm/dd', DateTo  )) + '))' +
      ' OR   ((DateTo   >= ' +QuotedStr(FormatDateTime('yyyy/mm/dd', Datefrom)) + ')' +
      ' AND   (DateTo   <= ' +QuotedStr(FormatDateTime('yyyy/mm/dd', DateTo  )) + '))' +
      ' OR   ((DateTo   >= ' +QuotedStr(FormatDateTime('yyyy/mm/dd', DateTo  )) + ')' +
      ' AND   (DateFrom <= ' +QuotedStr(FormatDateTime('yyyy/mm/dd', DateTo  )) + '))' +
      ' ))'; *)
  end else begin
    strSQL := 'Select  ' + IDfieldname + ' from ' + BusObjectTableName + ' where ' + ' PartName = ' + QuotedStr(Partname) + ' AND Active = "T" ' + ' AND ClientTypeID = ' + IntToStr(ClientTypeID) +
      ' AND UOMID = ' + IntToStr(UOMID) + ' and useUOM = ' + QuotedStr(BooleanToStr(UseUOM)) + ' AND UseDate = "F" ';
  end;
  with getNewdataset(strSQL, True) do
    try
      if recordcount > 0 then begin
        Load(Fieldbyname(IDfieldname).asInteger);
        Result := True;
      end;
    finally

    end;
end;

initialization

RegisterClass(TProductRewardPoints);

end.
