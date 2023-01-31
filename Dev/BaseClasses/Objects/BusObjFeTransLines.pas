unit BusObjFeTransLines;

interface

Uses
  busobjbase, db, classes , BusobjProductFormula , XMLDoc, XMLIntf;
type

  TFETransLinesRelatedPrs = class(TMSBusobj)
  private
    fbCalculatingShipped:Boolean;
    function GetFETransLineID: Integer;
    function GetProductID: Integer;
    function GetFormulaID: Integer;
    function GetFormula: string;
    function GetRelatedQty: Double;
    function GetRelatedShippedQty: Double;
    function GetDeleted: Boolean;

    procedure SetFETransLineID(const Value: Integer);
    procedure SetProductID(const Value: Integer);
    procedure SetFormulaID(const Value: Integer);
    procedure SetFormula(const Value: string);
    procedure SetRelatedQty(const Value: Double);
    procedure SetRelatedShippedQty(const Value: Double);
    procedure SetDeleted(const Value: Boolean);
    procedure DoGetParserVariable(Sender: TObject; const VarName: string; var Value: extended; var FieldFound: Boolean);
    procedure CalculateRelatedQty;
    function getProductName: string;
    procedure setProductName(const Value: string);
  protected
    function GetSQL: string; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetIsList: boolean; override;
    function FELineIDField :String;virtual;abstract;
  public
    constructor Create(AOwner: TComponent); override;
    function ValidateData: Boolean; override;
    property FETransLineID: Integer read GetFETransLineID write SetFETransLineID;
  published
    property ProductID: Integer read GetProductID write SetProductID;
    property FormulaID: Integer read GetFormulaID write SetFormulaID;
    property Formula: string read GetFormula write SetFormula;
    property RelatedQty: Double read GetRelatedQty write SetRelatedQty;
    property RelatedShippedQty: Double read GetRelatedShippedQty write SetRelatedShippedQty;
    property Deleted: Boolean read GetDeleted write SetDeleted;
    property ProductName: string read getProductName write setProductName;
  end;

  TFETransLines = class(TMSBusobj)
  private
    fFETranslinesRelatedPrs: TFETransLinesRelatedPrs;
    fbAllLinesValid: Boolean;
    function GetTransId: Integer;
    function GetTransLineID: Integer;
    function GetProductID: Integer;
    function GetFormulaId: Integer;
    function GetField1: Double;
    function GetField2: Double;
    function GetField3: Double;
    function Getfield4: Double;
    function GetField5: Double;
    function GetShippedField1: Double;
    function GetShippedField2: Double;
    function GetShippedField3: Double;
    function GetShippedField4: Double;
    function GetShippedField5: Double;
    function GetDeleted: Boolean;
    function getFieldEntrycount: Integer;
    function getProductName: string;

    procedure SetTransId(const Value: Integer);
    procedure SetTransLineID(const Value: Integer);
    procedure SetProductID(const Value: Integer);
    procedure SetFormulaId(const Value: Integer);
    procedure SetField1(const Value: Double);
    procedure SetField2(const Value: Double);
    procedure SetField3(const Value: Double);
    procedure Setfield4(const Value: Double);
    procedure SetField5(const Value: Double);
    procedure SetShippedField1(const Value: Double);
    procedure SetShippedField2(const Value: Double);
    procedure SetShippedField3(const Value: Double);
    procedure SetShippedField4(const Value: Double);
    procedure SetShippedField5(const Value: Double);
    procedure SetDeleted(const Value: Boolean);
    procedure setProductName(const Value: string);
    procedure SeTFETransLinesRelatedPrs(const Value: TFETransLinesRelatedPrs);
    procedure CalculateRelatedQty(const Sender: TBusObj; var Abort: Boolean);
    procedure LineValidateCallbackProc(const Sender: TBusObj; var Abort: Boolean);
    procedure updateFormulaIDCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure UpdateQtyCalcFormulaDetails;
    function getFormulaWithValueSold: String;
    function getFormulaWithValueShipped: String;
    function getFormula: TFormula;
  protected
    function GetSQL: string; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterClose(Sender: TDatasetBusObj): Boolean; override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetIsList: boolean; override;
    Function HeaderIdfield:String; virtual;abstract;
    Function LineIdfield:String; virtual;abstract;
    function geTFETransLinesRelatedPrs: TFETransLinesRelatedPrs;virtual;abstract;
  public
    destructor Destroy; override;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    constructor Create(AOwner: TComponent); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    function ProductformulaID: Integer;
    Property FormulaWithValueSold :String read getFormulaWithValueSold;
    Property FormulaWithValueShipped :String read getFormulaWithValueShipped;
    Property Formula :TFormula read getFormula;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;

  published
    property TransId: Integer read GetTransId write SetTransId;
    property TransLineID: Integer read GetTransLineID write SetTransLineID;
    property ProductID: Integer read GetProductID write SetProductID;
    property FormulaId: Integer read GetFormulaId write SetFormulaId;
    property Field1: Double read GetField1 write SetField1;
    property Field2: Double read GetField2 write SetField2;
    property Field3: Double read GetField3 write SetField3;
    property field4: Double read Getfield4 write Setfield4;
    property Field5: Double read GetField5 write SetField5;
    property ShippedField1: Double read GetShippedField1 write SetShippedField1;
    property ShippedField2: Double read GetShippedField2 write SetShippedField2;
    property ShippedField3: Double read GetShippedField3 write SetShippedField3;
    property ShippedField4: Double read GetShippedField4 write SetShippedField4;
    property ShippedField5: Double read GetShippedField5 write SetShippedField5;
    property Deleted: Boolean read GetDeleted write SetDeleted;
    property ProductName: string read getProductName write setProductName;
    property Lines: TFETransLinesRelatedPrs read geTFETransLinesRelatedPrs write SeTFETransLinesRelatedPrs;
    property FieldEntrycount: Integer read getFieldEntrycount;
  end;

  TFESalesLines = class(TFETransLines)
  Protected
    Function HeaderIdfield:String; Override;
    Function LineIdfield:String; Override;
    function geTFETransLinesRelatedPrs: TFETransLinesRelatedPrs;Override;
    procedure DoFieldOnChange(Sender: TField); override;
  Public
    constructor Create(AOwner: TComponent); override;
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;

  end;

  TFESalesLinesRelatedPrs = Class(TFETransLinesRelatedPrs)
  Protected
    function FELineIDField :String;Override;
  Public
    constructor Create(AOwner: TComponent); override;
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
  End;

  TFEPOLines = class(TFETransLines)
  Protected
    Function HeaderIdfield:String; Override;
    Function LineIdfield:String; Override;
    function geTFETransLinesRelatedPrs: TFETransLinesRelatedPrs;Override;
  Public
    constructor Create(AOwner: TComponent); override;
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;

  end;

  TFEPOLinesRelatedPrs = Class(TFETransLinesRelatedPrs)
  Protected
    function FELineIDField :String;Override;
  Public
    constructor Create(AOwner: TComponent); override;
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
  End;

implementation

uses BusObjSaleBase, tcDataUtils, sysutils, CommonLib, BusObjConst, ParserLib,
  BusObjStock, BusObjOrderBase;

{ TFETransLines }
function TFETransLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

function TFETransLines.GetIsList: boolean;
begin
  result:= false;
end;

procedure TFETransLines.CalculateRelatedQty(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TFETransLinesRelatedPrs) then Exit;
  TFETransLinesRelatedPrs(Sender).CalculateRelatedQty;
end;
Procedure TFETransLines.UpdateQtyCalcFormulaDetails;
begin
    if Assigned(Owner) then
      if Owner is TSaleslineBase then
      with TSaleslineBase(Owner).QtyCalcFormulaDetails do begin
        if count > 0 then begin
          PartCalcformula := tcDataUtils.GetFormula(Self.FormulaID);
          PostDB;
        end;
    end;
end;
procedure TFETransLines.DoFieldOnChange(Sender: TField);
var
  fsfieldName: string;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
  inherited;
  { fieldnames are all prefixed with 'Field' and followed by a number }
  if sametext(Sender.fieldname , 'FormulaID') then  begin
    if FormulaID<> 0 then
      if Formula.FormulaTypeId <> 0 then begin
        SendEvent(BusobjEvent_ToDo, BusObjEventVal_FormulaId, self);
        if (field1 =0) and (Formula.HasFe1DefaultValue) and (Formula.Fe1DefaultValue<>0) then Field1 :=Formula.Fe1DefaultValue;
        if (field2 =0) and (Formula.HasFe2DefaultValue) and (Formula.Fe2DefaultValue<>0) then Field2 :=Formula.Fe2DefaultValue;
        if (field3 =0) and (Formula.HasFe3DefaultValue) and (Formula.Fe3DefaultValue<>0) then Field3 :=Formula.Fe3DefaultValue;
        if (field4 =0) and (Formula.HasFe4DefaultValue) and (Formula.Fe4DefaultValue<>0) then Field4 :=Formula.Fe4DefaultValue;
        if (field5 =0) and (Formula.HasFe5DefaultValue) and (Formula.Fe5DefaultValue<>0) then Field5 :=Formula.Fe5DefaultValue;

        if (ShippedField1 =0) and (Formula.HasFe1DefaultValue) and (Formula.Fe1DefaultValue<>0) then ShippedField1 :=Formula.Fe1DefaultValue;
        if (ShippedField2 =0) and (Formula.HasFe2DefaultValue) and (Formula.Fe2DefaultValue<>0) then ShippedField2 :=Formula.Fe2DefaultValue;
        if (ShippedField3 =0) and (Formula.HasFe3DefaultValue) and (Formula.Fe3DefaultValue<>0) then ShippedField3 :=Formula.Fe3DefaultValue;
        if (ShippedField4 =0) and (Formula.HasFe4DefaultValue) and (Formula.Fe4DefaultValue<>0) then ShippedField4 :=Formula.Fe4DefaultValue;
        if (ShippedField5 =0) and (Formula.HasFe5DefaultValue) and (Formula.Fe5DefaultValue<>0) then ShippedField5 :=Formula.Fe5DefaultValue;

      end;
    Lines.DoFieldChangewhenDisabled := True;
    Lines.iteraterecords(updateFormulaIDCallback);
    updateQtyCalcFormulaDetails;
  end;
  fsfieldName := ReplaceStr(ReplaceStr(Lowercase(Sender.FieldName), 'ShippedField', ''), 'field', '');
  if isnumber(fsfieldName) or sametext(Sender.fieldname , 'FormulaID') then begin
    if not RawMode then begin
      Lines.IterateREcords(CalculateRelatedQty);
    end;

  end;
end;
procedure TFETransLines.updateFormulaIDCallback(Const Sender: TBusObj; Var Abort: Boolean);
begin
  if not(Sender is TFETransLinesRelatedPrs) then exit;
  TFETransLinesRelatedPrs(Sender).formulaId := FormulaID;
  TFETransLinesRelatedPrs(Sender).DoFieldOnChange(Sender.Dataset.findfield('FormulaID'));
  TFETransLinesRelatedPrs(Sender).PostDB;
end;

function TFETransLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;

  if Assigned(Self.Owner) then
    if Self.Owner is TSalesLineBase then begin
      Self.TransId := TSalesLineBase(Self.Owner).SaleId;
      Self.TransLineID := TSalesLineBase(Self.Owner).ID;
      Self.ProductID := TSalesLineBase(Self.Owner).ProductID;
    end else if Self.Owner is TOrderLineBase then begin
      Self.TransId := TOrderLineBase(Self.Owner).PurchaseOrderID;
      Self.TransLineID := TOrderLineBase(Self.Owner).ID;
      Self.ProductID := TOrderLineBase(Self.Owner).ProductID;
    end;
  Result := True;
end;
function TFETransLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;
function TFETransLines.DoAfterClose(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterClose(Sender);
  if not Result then Exit;
end;

function TFETransLines.GetTransId: Integer; begin  Result := GetIntegerField(HeaderIdfield);end;
function TFETransLines.GetTransLineID: Integer;begin  Result := GetIntegerField(LineIdfield);end;
function TFETransLines.GetProductID: Integer;begin  Result := GetIntegerField('ProductID');end;
function TFETransLines.GetFormulaId: Integer;begin  Result := GetIntegerField('FormulaId');end;
function TFETransLines.GetField1: Double;begin  Result := GetFloatField('Field1');end;
function TFETransLines.GetField2: Double;begin  Result := GetFloatField('Field2');end;
function TFETransLines.GetField3: Double;begin  Result := GetFloatField('Field3');end;
function TFETransLines.Getfield4: Double;begin  Result := GetFloatField('field4');end;
function TFETransLines.GetField5: Double;begin  Result := GetFloatField('Field5');end;
function TFETransLines.GetShippedField1: Double;begin  Result := GetFloatField('ShippedField1');end;
function TFETransLines.GetShippedField2: Double;begin  Result := GetFloatField('ShippedField2');end;
function TFETransLines.GetShippedField3: Double;begin  Result := GetFloatField('ShippedField3');end;
function TFETransLines.GetShippedField4: Double;begin  Result := GetFloatField('ShippedField4');end;
function TFETransLines.GetShippedField5: Double;begin  Result := GetFloatField('ShippedField5');end;
function TFETransLines.GetDeleted: Boolean;begin  Result := GetBooleanField('Deleted');end;
function TFETransLines.getProductName: string;begin  Result := GetStringField('ProductName');end;
procedure TFETransLines.SetTransId(const Value: Integer);begin SetIntegerField(HeaderIdfield, Value);end;
procedure TFETransLines.SetTransLineID(const Value: Integer);begin  SetIntegerField(LineIdfield, Value);end;
procedure TFETransLines.SetProductID(const Value: Integer);begin  SetIntegerField('ProductID', Value);end;
procedure TFETransLines.SetFormulaId(const Value: Integer);begin  SetIntegerField('FormulaId', Value);end;
procedure TFETransLines.SetField1(const Value: Double);begin  SetFloatField('Field1', Value);end;
procedure TFETransLines.SetField2(const Value: Double);begin  SetFloatField('Field2', Value);end;
procedure TFETransLines.SetField3(const Value: Double);begin  SetFloatField('Field3', Value);end;
procedure TFETransLines.Setfield4(const Value: Double);begin  SetFloatField('field4', Value);end;
procedure TFETransLines.SetField5(const Value: Double);begin  SetFloatField('Field5', Value);end;
procedure TFETransLines.SetShippedField1(const Value: Double);begin  SetFloatField('ShippedField1', Value);end;
procedure TFETransLines.SetShippedField2(const Value: Double);begin  SetFloatField('ShippedField2', Value);end;
procedure TFETransLines.SetShippedField3(const Value: Double);begin  SetFloatField('ShippedField3', Value);end;
procedure TFETransLines.SetShippedField4(const Value: Double);begin  SetFloatField('ShippedField4', Value);end;
procedure TFETransLines.SetShippedField5(const Value: Double);begin  SetFloatField('ShippedField5', Value);end;
procedure TFETransLines.SetDeleted(const Value: Boolean);begin  SetBooleanField('Deleted', Value);end;
procedure TFETransLines.setProductName(const Value: string);begin  SetStringField('ProductName', Value);end;
procedure TFETransLines.SeTFETransLinesRelatedPrs(const Value: TFETransLinesRelatedPrs);begin  fFETranslinesRelatedPrs := Value;end;

function TFETransLines.getFormulaWithValueSold: String;
begin
  Result := tcdatautils.getFormula(FormulaID);
  Result := ReplaceStr(Result , 'Field1', '[' + Floattostr(Field1)+']');
  Result := ReplaceStr(Result , 'Field2', '[' + Floattostr(Field2)+']');
  Result := ReplaceStr(Result , 'Field3', '[' + Floattostr(Field3)+']');
  Result := ReplaceStr(Result , 'Field4', '[' + Floattostr(Field4)+']');
  Result := ReplaceStr(Result , 'Field5', '[' + Floattostr(Field5)+']');
end;
function TFETransLines.getFormulaWithValueShipped: String;
begin
  Result := tcdatautils.getFormula(FormulaID);
  Result := ReplaceStr(Result , 'Field1', '[' + Floattostr(ShippedField1)+']');
  Result := ReplaceStr(Result , 'Field2', '[' + Floattostr(ShippedField2)+']');
  Result := ReplaceStr(Result , 'Field3', '[' + Floattostr(ShippedField3)+']');
  Result := ReplaceStr(Result , 'Field4', '[' + Floattostr(ShippedField4)+']');
  Result := ReplaceStr(Result , 'Field5', '[' + Floattostr(ShippedField5)+']');
end;

function TFETransLines.getFieldEntrycount: Integer;
var
  ctr: Integer;
begin
  Result := 0;
  for ctr := 0 to Dataset.fieldcount - 1 do
    if isnumeric(ReplaceStr(Dataset.Fields[ctr].FieldName, 'Field', '')) then Result := Result + 1;
end;


function TFETransLines.getFormula: TFormula;
begin
  Result := TFormula(getContainercomponent(TFormula, 'formulaId = ' + inttostr(formulaId)));
end;

constructor TFETransLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fFETranslinesRelatedPrs := nil;
  ExportExcludeList.Add('TransId');
  ExportExcludeList.Add('TransLineId');
  ExportExcludeList.Add('productid');
  ExportExcludeList.Add('fieldentrycount');
end;

function TFETransLines.Save: Boolean;
begin
  PostDB;
  Result := ValidateData;
end;

function TFETransLines.ValidateData: Boolean;
begin
  PostDB;
  result:= false;
  if self.TransId < 0 then  begin
    ResultStatus.AddItem(False, rssWarning, 0, 'Sale ID missing.');
    Exit;
  end;
  if self.TransLineId < 0 then  begin
    ResultStatus.AddItem(False, rssWarning, 0, 'Sale Line ID missing.');
    Exit;
  end;
  if self.ProductID  < 0 then  begin
    ResultStatus.AddItem(False, rssWarning, 0, 'Product ID missing.');
    Exit;
  end;

  fbAllLinesValid := True;
  Lines.PostDB;
  Lines.IterateREcords(LineValidateCallbackProc);
  Result := fbAllLinesValid;
end;

procedure TFETransLines.LineValidateCallbackProc(const Sender: TBusObj; var Abort: Boolean);
begin
  if not TFETransLinesRelatedPrs(Sender).ValidateData then fbAllLinesValid := False;
end;

destructor TFETransLines.Destroy;
begin
  if Assigned(fFETranslinesRelatedPrs) then begin
    if (not fFETranslinesRelatedPrs.ExternalDatasetAssigned) then FreeAndNil(fFETranslinesRelatedPrs)
    else fFETranslinesRelatedPrs.Dataset.close;
  end;
  inherited;
end;

procedure TFETransLines.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if Assigned(fFETranslinesRelatedPrs) then begin
    if (not fFETranslinesRelatedPrs.ExternalDatasetAssigned) then FreeAndNil(fFETranslinesRelatedPrs)
    else fFETranslinesRelatedPrs.Dataset.close;
  end;
  Lines; // to access the lines for the current record

end;

function TFETransLines.ProductformulaID: Integer;
begin
  with GetNewDataset('Select PartsID , formulaID from tblParts where partsId =' + inttostr(ProductID), True) do
    try Result := FieldByname('formulaID').asInteger;
    finally
      if Active then close;
      Free;
    end;
end;
procedure TFETransLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  (*SetPropertyFromNode(node,'TransID');
  SetPropertyFromNode(node,'TranslineId');
  SetPropertyFromNode(node,'ProductID');  *)
  SetPropertyFromNode(node,'FormulaId');
  SetPropertyFromNode(node,'Field1');
  SetPropertyFromNode(node,'Field2');
  SetPropertyFromNode(node,'Field3');
  SetPropertyFromNode(node,'field4');
  SetPropertyFromNode(node,'Field5');
  SetPropertyFromNode(node,'ShippedField1');
  SetPropertyFromNode(node,'ShippedField2');
  SetPropertyFromNode(node,'ShippedField3');
  SetPropertyFromNode(node,'ShippedField4');
  SetPropertyFromNode(node,'ShippedField5');
  SetBooleanPropertyFromNode(node,'Deleted');
  SetPropertyFromNode(node,'ProductName');
end;


procedure TFETransLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TransID' ,TransID);
  AddXMLNode(node,'TranslineId' ,TranslineId);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'FormulaId' ,FormulaId);
  AddXMLNode(node,'Field1' ,Field1);
  AddXMLNode(node,'Field2' ,Field2);
  AddXMLNode(node,'Field3' ,Field3);
  AddXMLNode(node,'field4' ,field4);
  AddXMLNode(node,'Field5' ,Field5);
  AddXMLNode(node,'ShippedField1' ,ShippedField1);
  AddXMLNode(node,'ShippedField2' ,ShippedField2);
  AddXMLNode(node,'ShippedField3' ,ShippedField3);
  AddXMLNode(node,'ShippedField4' ,ShippedField4);
  AddXMLNode(node,'ShippedField5' ,ShippedField5);
  AddXMLNode(node,'Deleted' ,Deleted);
  AddXMLNode(node,'ProductName' ,ProductName);
end;

{ TFETransLinesRelatedPrs }
function TFETransLinesRelatedPrs.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

function TFETransLinesRelatedPrs.GetIsList: boolean;
begin
  result:= true;
end;

function TFETransLinesRelatedPrs.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  if (ProductID = 0) and (FormulaID = 0) and (RelatedQty = 0) and (RelatedShippedQty = 0) then Dataset.delete;
  Result := True;

end;

function TFETransLinesRelatedPrs.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := True;
end;

constructor TFETransLinesRelatedPrs.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ExportExcludeList.Add('productid');
  fbCalculatingShipped:=False;
end;

function TFETransLinesRelatedPrs.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  if Assigned(Self.Owner) then
    if Self.Owner is TFETransLines then Self.FETransLineId := TFETransLines(Self.Owner).ID;
  Deleted := False;
  Result := True;
end;

procedure TFETransLinesRelatedPrs.DoGetParserVariable(Sender: TObject; const VarName: string; var Value: extended; var FieldFound: Boolean);
var
  fsFieldname:String;
begin
  Value := 0;
  fsfieldname := VarName;
  if fbCalculatingShipped then fsfieldname := 'Shipped'+   VarName;

  if Assigned(Self.Owner) then
    if Self.Owner is TFETransLines then
      if TFETransLines(Self.Owner).Dataset.findfield(fsfieldname) <> nil then begin
        Value := TFETransLines(Self.Owner).Dataset.FieldByname(fsfieldname).asFloat;
        FieldFound := True;
      end;
end;

procedure TFETransLinesRelatedPrs.CalculateRelatedQty;
var
  ErrMsg:String;
  fdParserValue :double;
begin
  RelatedQty := 0;
  PostDB;
  if (FormulaID  <> 0) and (Formula = tcDataUtils.GetFormula(FormulaId)) then else FormulaID := tcDataUtils.GetFormulaID(Formula);
  if (Formula <> '') and (Assigned(Self.Owner)) and (Self.Owner is TFETransLines) then begin

    fdParserValue := ParserValue(Self , DoGetParserVariable , Formula, errMsg);
    if errmsg <> '' then  ResultStatus.AddItem(False, rssWarning, 0, errmsg)
    else  RelatedQty :=round(fdParserValue,RoundPlacesGeneral);

    fbCalculatingShipped:=True;
    try
      fdParserValue := ParserValue(Self , DoGetParserVariable , Formula, errMsg);
      if errmsg <> '' then  ResultStatus.AddItem(False, rssWarning, 0, errmsg)
      else  RelatedShippedQty :=round(fdParserValue,RoundPlacesGeneral);
    finally
      fbCalculatingShipped:=False;
    end;

  end;
  SendEvent(BusobjEvent_ToDo, BusObjEventVal_FormulaValue, self);
end;

function TFETransLinesRelatedPrs.ValidateData: Boolean;
begin
  Result := False;
  if ProductID = 0 then begin
    ResultStatus.AddItem(False, rssWarning, 0, 'Product should not be blank');
    Exit;
  end;
  if (Formula = '') or (FormulaID = 0) then begin
    ResultStatus.AddItem(False, rssWarning, 0, 'Formula should not be blank');
    Exit;
  end;
  Result := True;
end;

procedure TFETransLinesRelatedPrs.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'Formula') then begin
    if not RawMode then begin

      CalculateRelatedQty;
    end;
  end
  else if Sysutils.SameText(Sender.FieldName, 'FormulaID') then begin
    Formula := tcDataUtils.GetFormula(Sender.Value);
    if not RawMode then begin
      DoFieldOnChange(Dataset.findfield('Formula'));
    end;
  end
  else if Sysutils.SameText(Sender.FieldName, 'ProductID') then begin
    if Sender.AsInteger > 1 then
      ProductName:= TProduct.IDToggle(Sender.AsInteger, Connection.Connection)
    else
      ProductName:= '';
  end
  else if Sysutils.SameText(Sender.FieldName, 'ProductName') then begin
    if Sender.AsString <> '' then
      ProductID:= TProduct.IDToggle(Sender.AsString, Connection.Connection)
    else
      ProductId:= 0;
  end;
end;

function TFETransLinesRelatedPrs.GetFETransLineId: Integer;begin  Result := GetIntegerField(FELineIDField);end;
function TFETransLinesRelatedPrs.GetProductID: Integer;begin  Result := GetIntegerField('ProductID');end;
function TFETransLinesRelatedPrs.getProductName: string;begin  Result := GetStringField('ProductName');end;
function TFETransLinesRelatedPrs.GetFormulaID: Integer;begin  Result := GetIntegerField('FormulaID');end;
function TFETransLinesRelatedPrs.GetFormula: string;begin  Result := GetStringField('Formula');end;
function TFETransLinesRelatedPrs.GetRelatedQty: Double;begin  Result := GetFloatField('RelatedQty');end;
function TFETransLinesRelatedPrs.GetRelatedShippedQty: Double;begin  Result := GetFloatField('RelatedShippedQty');end;
function TFETransLinesRelatedPrs.GetDeleted: Boolean;begin  Result := GetBooleanField('Deleted');end;
procedure TFETransLinesRelatedPrs.SetFETransLineId(const Value: Integer);begin  SetIntegerField(FELineIDField, Value);end;
procedure TFETransLinesRelatedPrs.SetProductID(const Value: Integer);begin  SetIntegerField('ProductID', Value);end;
procedure TFETransLinesRelatedPrs.setProductName(const Value: string);begin  SetStringField('ProductName', Value);end;
procedure TFETransLinesRelatedPrs.SetFormulaID(const Value: Integer);begin  SetIntegerField('FormulaID', Value);end;
procedure TFETransLinesRelatedPrs.SetFormula(const Value: string);begin  SetStringField('Formula', Value);end;
procedure TFETransLinesRelatedPrs.SetRelatedQty(const Value: Double);begin  SetFloatField('RelatedQty', Value);end;
procedure TFETransLinesRelatedPrs.SetRelatedShippedQty(const Value: Double);begin  SetFloatField('RelatedShippedQty', Value);end;
procedure TFETransLinesRelatedPrs.SetDeleted(const Value: Boolean);begin  SetBooleanField('Deleted', Value);end;

{ TFESalesLines }
function TFESalesLines.HeaderIdfield: String;begin  Result := 'SaleId'end;
function TFESalesLines.LineIdfield: String;begin  Result := 'SaleLineId'end;
constructor TFESalesLines.Create(AOwner: TComponent);begin  inherited;  fSQL := 'Select * from tblFESalesLines';end;
class function TFESalesLines.GetBusObjectTablename: string;begin  Result := 'tblFESalesLines';end;
class function TFESalesLines.GetIDField: string;begin  Result := 'FESalesLineID';end;
function TFESalesLines.geTFETransLinesRelatedPrs: TFETransLinesRelatedPrs;
begin
  if not Assigned(fFETranslinesRelatedPrs) then begin
    fFETranslinesRelatedPrs := TFESalesLinesRelatedPrs.Create(Self);
    fFETranslinesRelatedPrs.connection := Self.connection;
    fFETranslinesRelatedPrs.SilentMode := Self.SilentMode;
  end;
  if (fFETranslinesRelatedPrs.SQLSelect <> 'FESalesLineID = ' + inttostr(Self.ID)) or (fFETranslinesRelatedPrs.Dataset.Active = False) then
      fFETranslinesRelatedPrs.LoadSelect('FESalesLineID = ' + inttostr(Self.ID));
  Result := TFETransLinesRelatedPrs(fFETranslinesRelatedPrs);
end;
{ TFEPOLines }
function TFEPOLines.HeaderIdfield: String;begin  Result := 'POId'end;
function TFEPOLines.LineIdfield: String;begin  Result := 'POLineId'end;
constructor TFEPOLines.Create(AOwner: TComponent);begin  inherited;    fSQL := 'Select * from tblFEPOLines';end;
class function TFEPOLines.GetBusObjectTablename: string;begin  Result := 'tblFEPOLines';end;
class function TFEPOLines.GetIDField: string;begin  Result := 'FEPOLineID';end;
function TFEPOLines.geTFETransLinesRelatedPrs: TFETransLinesRelatedPrs;
begin
  if not Assigned(fFETranslinesRelatedPrs) then begin
    fFETranslinesRelatedPrs := TFEPOLinesRelatedPrs.Create(Self);
    fFETranslinesRelatedPrs.connection := Self.connection;
    fFETranslinesRelatedPrs.SilentMode := Self.SilentMode;
  end;
  if (fFETranslinesRelatedPrs.SQLSelect <> 'FEPOLineID = ' + inttostr(Self.ID)) or (fFETranslinesRelatedPrs.Dataset.Active = False) then
      fFETranslinesRelatedPrs.LoadSelect('FEPOLineID = ' + inttostr(Self.ID));
  Result := TFETransLinesRelatedPrs(fFETranslinesRelatedPrs);
end;
procedure TFESalesLines.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
  inherited;
  if sametext(Sender.fieldname , 'ProductId') then  begin
    if ProductId > 0 then
    With TProduct.CreateWithNewConn(nil) do try
      load(Self.ProductId);
      if count> 0 then begin
        Self.Field1 :=FormulaQtyValue1;
        Self.Field2 :=FormulaQtyValue2;
        Self.Field3 :=FormulaQtyValue3;
        Self.Field4 :=FormulaQtyValue4;
        Self.Field5 :=FormulaQtyValue5;
      end;
    finally
      connection.connection.Free;
      Free;
    end;

  end;
end;

{ TFESalesLinesRelatedPrs }
constructor TFESalesLinesRelatedPrs.Create(AOwner: TComponent);begin  inherited;  fSQL := 'Select * from tblFESaleslinesRelatedPrs';end;
function TFESalesLinesRelatedPrs.FELineIDField: String;begin  Result := 'FESalesLineID';end;
class function TFESalesLinesRelatedPrs.GetBusObjectTablename: string;begin  Result := 'tblFESaleslinesRelatedPrs';end;
class function TFESalesLinesRelatedPrs.GetIDField: string;begin  Result := 'FESaleslinesRelatedPrID';end;
{ TFEPOLinesRelatedPrs }
constructor TFEPOLinesRelatedPrs.Create(AOwner: TComponent);begin  inherited;  fSQL := 'Select * from tblFEPOlinesRelatedPrs';end;
function TFEPOLinesRelatedPrs.FELineIDField: String;begin  Result := 'FEPOLineID';end;
class function TFEPOLinesRelatedPrs.GetBusObjectTablename: string;begin  Result := 'tblFEPOlinesRelatedPrs';end;
class function TFEPOLinesRelatedPrs.GetIDField: string;begin  Result := 'FEPOlinesRelatedPrID';end;

initialization

RegisterClassOnce(TFESalesLinesRelatedPrs);
RegisterClassOnce(TFESalesLines);
RegisterClassOnce(TFEPOLinesRelatedPrs);
RegisterClassOnce(TFEPOLines);

end.
