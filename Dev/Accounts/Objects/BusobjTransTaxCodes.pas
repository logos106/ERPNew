unit BusobjTransTaxCodes;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  01/08/11  1.00.00  bs  Initial Version.
}

interface

uses BusObjBase, DB, Classes, XMLIntf, BusObjTaxCodes;

type
  TTransTaxCodeLines = class(TMSBusObj)
  private

    function GetSubTaxID: Integer;
    function GetSubTaxCode: string;
    function GetPercentage: Double;
    function GetPercentageOn: string;
    function GetPercentageOnID: Integer;
    function GetTaxAmount: Double;

    procedure SetSubTaxID(const Value: Integer);
    procedure SetSubTaxCode(const Value: string);
    procedure SetPercentage(const Value: Double);
    procedure SetPercentageOn(const Value: string);
    procedure SetPercentageOnID(const Value: Integer);
    procedure SetTaxAmount(const Value: Double);
    function getTaxcode: STring;
    function GetAmountPerUnit: double;
    function GetThresholdAmount: double;
    function GetUOM: string;
    procedure SetAmountPerUnit(const Value: double);
    procedure SetThresholdAmount(const Value: double);
    procedure SetUOM(const Value: string);
  protected
    Function TransTaxCodeIDFieldname:String;virtual; abstract;
    function GetTransTaxCodeID: Integer; virtual;
    procedure SetTransTaxCodeID(const Value: Integer); virtual;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function GetCapAmount: double; virtual; abstract;
    procedure SetCapAmount(const Value: double); virtual; abstract;
    function TransDetails:String;
  public
    class function GetIDField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    property TransTaxCodeID: Integer read GetTransTaxCodeID write SetTransTaxCodeID;
    class function _Schema: string; override;
    Property Taxcode:STring read getTaxcode;

  published
    property SubTaxID: Integer read GetSubTaxID write SetSubTaxID;
    property SubTaxCode: string read GetSubTaxCode write SetSubTaxCode;
    property Percentage: Double read GetPercentage write SetPercentage;
    property PercentageOn: string read GetPercentageOn write SetPercentageOn;
    property PercentageOnID: Integer read GetPercentageOnID write SetPercentageOnID;
    property CapAmount: double read GetCapAmount write SetCapAmount;
    property AmountPerUnit: double read GetAmountPerUnit write SetAmountPerUnit;
    property UOM: string read GetUOM write SetUOM;
    property ThresholdAmount: double read GetThresholdAmount write SetThresholdAmount;
    property TaxAmount: Double read GetTaxAmount write SetTaxAmount;
  end;

  TTransTaxCode = class(TMSBusObj)
  private
    AllLinesSavedOK: boolean;
    function GetTaxCodeID: Integer;
    function GetTotalLineAmount: Double;
    function GetTotalTax: Double;
    function GetTotalLineAmountInc: Double;
    procedure SetTaxCodeID(const Value: Integer);
    procedure SetTotalLineAmount(const Value: Double);
    procedure SetTotalTax(const Value: Double);
    procedure SetTotalLineAmountInc(const Value: Double);
    function getTaxcode: string;
    procedure setTaxcode(const Value: string);
    function getTaxcodeObj: TTaxCode;
    procedure CalcTaxCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure DoCalcTax(fid: Integer; var fdTotalLineAmount: Double; var fdTax: Double);
    procedure TransTaxCodeLinesSaveCallbackProc(Const Sender: TBusObj; var Abort: boolean);
  protected
    function GetTransID: Integer; virtual; abstract;
    function GetTransLineID: Integer; virtual; abstract;
    procedure SetTransID(const Value: Integer); virtual; abstract;
    procedure SetTransLineID(const Value: Integer); virtual; abstract;
    function getLines: TTransTaxCodeLines; virtual; abstract;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function NewLineInstance: TTransTaxCodeLines; virtual; abstract;
    Function TransDetails:String; virtual;
  public
    class function GetIDField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    property TaxcodeObj: TTaxCode read getTaxcodeObj;
    function CalcTax: boolean;
    procedure CalcTaxFromLineTotalInc(const aLineTotalInc: double);
    function Delete: Boolean; override;
    function HasThresholdAmount: boolean;
    class function _Schema: string; override;
  published
    property TransID: Integer read GetTransID write SetTransID;
    property TransLineID: Integer read GetTransLineID write SetTransLineID;
    property TaxCode: string read getTaxcode write setTaxcode;
    property TaxCodeID: Integer read GetTaxCodeID write SetTaxCodeID;
    property TotalLineAmount: Double read GetTotalLineAmount write SetTotalLineAmount;
    property TotalTax: Double read GetTotalTax write SetTotalTax;
    property TotalLineAmountInc: Double read GetTotalLineAmountInc write SetTotalLineAmountInc;
    property Lines: TTransTaxCodeLines read getLines;
  end;

implementation

uses
  tcDataUtils, CommonLib, BusObjTrans, AppEnvironment, sysutils, DNMLib, BusObjSchemaLib,
  tcConst, BusObjOrderBase, BusObjSaleBase, ERPDbComponents,
  BusObjPurchaseTaxCodes, BusObjSalesTaxCodes;

{ TTransTaxCode }

function TTransTaxCode.CalcTax: boolean;
begin
  result := false;
  if (self.Dataset.State = dsBrowse) and (Count = 0) then exit;
  TotalTax := 0;
  TotalLineAmountInc := TotalLineAmount;
  if Lines.Count > 0 then
    result := true;
  Lines.Iteraterecords(CalcTaxCallback);
  PostDB;
end;

procedure TTransTaxCode.CalcTaxCallback(const Sender: TBusObj; var Abort: Boolean);
var
  fdTotalLineAmount: Double;
  fdTax: Double;
  LineUOM: string;
  LineUOMShipped: double;
  LineTotalEx, TransTotalEx: double;
  PercentOfTrans: double;
  qry: TERPQuery;
begin
  if not(Sender is TTransTaxCodeLines) then exit;
  if TTransTaxCodeLines(Sender).PercentageOnID = 0 then begin
    LineUOM := '';
    LineUOMShipped := 0;
    LineTotalEx := 0;
    TransTotalEx := 0;
    if (Owner is TOrderLineBase) then begin
      LineUOM := TOrderLineBase(Owner).UnitOfMeasure;
      LineUOMShipped := TOrderLineBase(Owner).UOMQtyShipped;
      LineTotalEx := TOrderLineBase(Owner).TotalLineAmount;
      TransTotalEx := TOrderBase(Owner.Owner).TotalAmount;
    end
    else if (Owner is TSalesLineBase) then begin
      LineUOM := TSalesLineBase(Owner).UnitOfMeasure;
      LineUOMShipped := TSalesLineBase(Owner).UOMQtyShipped;
      LineTotalEx := TSalesLineBase(Owner).TotalLineAmount;
      TransTotalEx := TSalesBase(Owner.Owner).TotalAmount;
    end;

    if (TTransTaxCodeLines(Sender).UOM <> '') and SameStr(TTransTaxCodeLines(Sender).UOM, LineUOM) then begin
      { Tax based on UOM qty shipped .. }
      TTransTaxCodeLines(Sender).TaxAmount := Round(LineUOMShipped * TTransTaxCodeLines(Sender).AmountPerUnit,CurrencyRoundPlaces);
    end else begin
      { straight percentage .. }
      TTransTaxCodeLines(Sender).TaxAmount :=
        Round(GetTaxAmount(LineTotalEx, TTransTaxCodeLines(Sender).Percentage / 100), CurrencyRoundPlaces);
      if (TTransTaxCodeLines(Sender).CapAmount > 0) then begin
        { check for cap .. }
        if (TTransTaxCodeLines(Sender).TaxAmount > TTransTaxCodeLines(Sender).CapAmount) then
          TTransTaxCodeLines(Sender).TaxAmount := TTransTaxCodeLines(Sender).CapAmount;

      end else if (TTransTaxCodeLines(Sender).ThresholdAmount > 0) then begin
        { if not cap .. check for threshold }

        if AppEnv.CompanyPrefs.SalesTaxThresholdWholeOrder then begin
         if (Abs(TransTotalEx) > TTransTaxCodeLines(Sender).ThresholdAmount) and (LineTotalEx <> 0) and (TransTotalEx <> 0) then begin
           { maximum tax amount for whole order .. }
           TTransTaxCodeLines(Sender).TaxAmount :=
             GetTaxAmount(TTransTaxCodeLines(Sender).ThresholdAmount, TTransTaxCodeLines(Sender).Percentage / 100);

           { now percent for this line .. }
           qry := TERPQuery.Create(nil);
           try
             qry.Connection := Connection.Connection;

             if (Owner is TOrderLineBase) then begin
               qry.SQL.Add('select distinct tl.SubTaxID, tl.SubTaxCode, SUM(t.TotalLineAmount) as TotalAmountEx');
               qry.SQL.Add('from tblpurchasetaxcodelines as tl');
               qry.SQL.Add('inner join tblpurchasetaxcodes as t on t.ID = tl.PurchaseTaxCodeID');
               qry.SQL.Add('where t.PurchaseOrderID = ' + IntToStr(TransID));
               qry.SQL.Add('and tl.thresholdamount > 0');
               qry.SQL.Add('and tl.SubTaxID = ' + IntToStr(TTransTaxCodeLines(Sender).SubTaxID));
             end
             else begin
               qry.SQL.Add('select distinct tl.SubTaxID, tl.SubTaxCode, SUM(t.TotalLineAmount) as TotalAmountEx');
               qry.SQL.Add('from tblsalestaxcodelines as tl');
               qry.SQL.Add('inner join tblsalestaxcodes as t on t.ID = tl.SalesTaxCodeID');
               qry.SQL.Add('where t.SaleID = ' + IntToStr(TransID));
               qry.SQL.Add('and tl.thresholdamount > 0');
               qry.SQL.Add('and tl.SubTaxID = ' + IntToStr(TTransTaxCodeLines(Sender).SubTaxID));
             end;
             qry.Open;
             if qry.FieldByName('TotalAmountEx').AsFloat <> 0 then begin
               PercentOfTrans := (LineTotalEx / qry.FieldByName('TotalAmountEx').AsFloat);
               TTransTaxCodeLines(Sender).TaxAmount :=
                 TTransTaxCodeLines(Sender).TaxAmount * PercentOfTrans;
             end;
           finally
             qry.Free;
           end;
           { round the tax }
           TTransTaxCodeLines(Sender).TaxAmount := Round(TTransTaxCodeLines(Sender).TaxAmount, CurrencyRoundPlaces);
         end;
        end else begin
          { just this line .. }
          if Abs(LineTotalEx) > TTransTaxCodeLines(Sender).ThresholdAmount then begin
            TTransTaxCodeLines(Sender).TaxAmount :=
              Round(GetTaxAmount(TTransTaxCodeLines(Sender).ThresholdAmount, TTransTaxCodeLines(Sender).Percentage / 100), CurrencyRoundPlaces);
            if LineTotalEx < 0 then
              TTransTaxCodeLines(Sender).TaxAmount := - TTransTaxCodeLines(Sender).TaxAmount;
          end;
        end;

      end;
    end;
  end
  else begin
    fdTotalLineAmount := TotalLineAmount;
    fdTax := 0;
    DoCalcTax(TTransTaxCodeLines(Sender).ID, fdTotalLineAmount, fdTax);
    TTransTaxCodeLines(Sender).TaxAmount := fdTax;
  end;
  TTransTaxCodeLines(Sender).PostDB;
  TotalTax := TotalTax + TTransTaxCodeLines(Sender).TaxAmount;
  TotalLineAmountInc := TotalLineAmountInc + TTransTaxCodeLines(Sender).TaxAmount;
end;
procedure TTransTaxCode.DoCalcTax(fid: Integer; var fdTotalLineAmount: Double; var fdTax: Double);
var
  Obj: TTransTaxCodeLines;
begin
  Obj := NewLineInstance;
  try
    Obj.connection := Self.connection;
    Obj.Load(fid);
    if Obj.PercentageOnID = 0 then begin
      fdtax := obj.taxamount;
      fdtotallineamount := fdtotallineamount +fdTax;
    end else begin
      DoCalcTax(Obj.PercentageOnID, fdTotalLineAmount, fdTax);
      fdTax := Round(GetTaxAmount(fdTotalLineAmount, Obj.Percentage / 100),CurrencyRoundPlaces);
      fdTotalLineAmount := fdTotalLineAmount + fdTax;
    end;
  finally
    Freeandnil(Obj);
  end;
end;

procedure TTransTaxCode.CalcTaxFromLineTotalInc(const aLineTotalInc: double);
var
  disc: double;
  taxVar, taxCap: double;
begin
  { because some sub taxes may have a cap amount it is difficult to work out
    tax based on line total inc .. so just discount the tax on each line }
  disc := DivZer(aLineTotalInc, self.TotalLineAmountInc);

  taxVar := 0;
  taxCap := 0;
  Lines.First;
  while not Lines.EOF do begin
    if Lines.CapAmount > 0 then
      taxCap := taxCap + Lines.TaxAmount
    else
      taxVar := taxVar + Lines.TaxAmount;
    Lines.Next;
  end;
  if taxCap > 0 then begin
    { we have a capped amount .. so for now will not try and back calculate this }
    { so increase the discount percentage for percentage tax items .. }
    disc := disc * (taxVar / (taxCap + taxVar));
  end;
  self.TotalLineAmountInc := aLineTotalInc;

  { we can only do this if we actually have some taxes with percentages .. }
  if taxVar > 0 then begin
    self.TotalTax := 0;

    Lines.First;
    while not Lines.EOF do begin
      if Lines.CapAmount = 0 then begin
        Lines.TaxAmount := Round(Lines.TaxAmount * disc,CurrencyRoundPlaces);
        Lines.PostDb;
      end;
      self.TotalTax := self.TotalTax + Lines.TaxAmount;
      Lines.Next;
    end;
    self.TotalLineAmount := self.TotalLineAmountInc - self.TotalTax;
  end;
end;

constructor TTransTaxCode.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fIsChild:= true;
  self.ExportExcludeList.Add('transid');
  self.ExportExcludeList.Add('translineid');
  self.ExportExcludeList.Add('taxcodeid');
end;

function TTransTaxCode.Delete: Boolean;
begin
  Lines.DeleteAll;
  REsult := inherited Delete;
end;

destructor TTransTaxCode.Destroy;
begin
  inherited;
end;

procedure TTransTaxCode.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'TransID');
  SetPropertyFromNode(node, 'TransLineID');
  SetPropertyFromNode(node, 'TaxCodeID');
  SetPropertyFromNode(node, 'Taxcode');
  SetPropertyFromNode(node, 'TotalLineAmount');
  SetPropertyFromNode(node, 'TotalTax');
  SetPropertyFromNode(node, 'TotalLineAmountInc');
end;

procedure TTransTaxCode.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'TransID', TransID);
  AddXMLNode(node, 'TransLineID', TransLineID);
  AddXMLNode(node, 'TaxCodeID', TaxCodeID);
  AddXMLNode(node, 'Taxcode', Taxcode);
  AddXMLNode(node, 'TotalLineAmount', TotalLineAmount);
  AddXMLNode(node, 'TotalTax', TotalTax);
  AddXMLNode(node, 'TotalLineAmountInc', TotalLineAmountInc);
end;

procedure TTransTaxCode.setTaxcode(const Value: string);
begin
  SetStringField('Taxcode', Value);
end;

function TTransTaxCode.ValidateData: Boolean;
var
  s:String;
begin
  REsult := True;
  Resultstatus.Clear;
  s:= TransDetails;
  if Taxcode <> '' then s:= s+ NL + 'Taxcode :' + Taxcode;

  if TransID = 0 then begin
    s:= s + NL +NL +'Transaction ID link missing';
    Result := false;
  end;
  if TransLineID = 0 then begin
    s:= s + NL +NL +'Transaction Line Link missing';
    Result := false;
  end;
  if (TaxCodeID = 0) then begin
    if Taxcode = '' then
          s:= s + NL +NL +'Tax Code should not be blank'
    else  s:= s + NL +NL +'Tax Code doesn''t Exists in the Taxcode List';
    Result := false;
  end;

  if not result then
    Resultstatus.AddItem(False, rssError, 0, s);
end;

class function TTransTaxCode._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TTaxCode','TaxCodeObj','TaxCodeID','ID');
  TBOSchema.AddRefType(result,'TTaxCode','TaxCodeObj','TaxCode','CodeName');
end;

function TTransTaxCode.Save: Boolean;
begin
  REsult := False;
  PostDB;
  if Count = 0 then begin
    result:= true;
    exit;
  end;

  if not ValidateData then exit;
  AllLinesSavedOK:= true;
  Lines.IterateRecords(TransTaxCodeLinesSaveCallbackProc, True);
  result:= AllLinesSavedOK;
  if result then
    result := inherited Save;
end;

procedure TTransTaxCode.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TTransTaxCode.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then exit; // we are only interested in data fields.
  inherited;
  if SameText(Sender.FieldName, 'taxcode') then begin
    TaxCodeID := GetGLTaxCodeIDForName(Taxcode);
  end;

end;

function TTransTaxCode.GetSQL: string;
begin
  REsult := inherited GetSQL;
end;

function TTransTaxCode.getTaxcode: string;
begin
  REsult := getStringField('Taxcode');
end;

class function TTransTaxCode.GetIDField: string;
begin
  REsult := 'ID'
end;

function TTransTaxCode.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not REsult then exit;
  if Assigned(Self.Owner) then
    if Self.Owner is TTranslinebase then begin
      TransID := TTranslinebase(Owner).HeaderId;
      TransLineID := TTranslinebase(Owner).ID;
    end;
end;

function TTransTaxCode.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TTransTaxCode.GetTaxCodeID: Integer;
begin
  REsult := GetIntegerField('TaxCodeID');
end;

function TTransTaxCode.getTaxcodeObj: TTaxCode;
begin
  REsult := TTaxCode(getContainerComponent(TTaxCode, 'TaxCodeID = ' + IntToStr(TaxCodeID)));
end;

function TTransTaxCode.GetTotalLineAmount: Double;
begin
  REsult := GetFloatField('TotalLineAmount');
end;

function TTransTaxCode.GetTotalTax: Double;
begin
  REsult := GetFloatField('TotalTax');
end;

function TTransTaxCode.HasThresholdAmount: boolean;
var
  qry: TERPQuery; 
begin
  result := false;
  if Lines.Count = 0 then exit;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := Connection.Connection;
    if self is TSalesTaxCode then
      qry.SQL.Text := 'select * from ' + Lines.GetBusObjectTablename + ' where SalesTaxCodeID = ' + IntToStr(ID)
    else
      qry.SQL.Text := 'select * from ' + Lines.GetBusObjectTablename + ' where PurchaseTaxCodeID = ' + IntToStr(ID);
    qry.SQL.Add('and IfNull(ThresholdAmount,0) > 0');
    qry.Open;
    result := not qry.IsEmpty;
  finally
    qry.Free;
  end;
  
end;

function TTransTaxCode.GetTotalLineAmountInc: Double;
begin
  REsult := GetFloatField('TotalLineAmountInc');
end;

procedure TTransTaxCode.SetTaxCodeID(const Value: Integer);
begin
  SetIntegerField('TaxCodeID', Value);
end;

procedure TTransTaxCode.SetTotalLineAmount(const Value: Double);
begin
  SetFloatField('TotalLineAmount', Value);
end;

procedure TTransTaxCode.SetTotalTax(const Value: Double);
begin
  SetFloatField('TotalTax', Value);
end;

procedure TTransTaxCode.TransTaxCodeLinesSaveCallbackProc(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not TTransTaxCodeLines(Sender).Save then begin
    AllLinesSavedOK:= false;
    Abort:= true;
  end;
end;

function TTransTaxCode.TransDetails: String;
begin
  Result := '';
  if Assigned(Owner) then
    if Owner is TTranslinebase then
      result := TTranslinebase(Owner).LineDesc;
end;

procedure TTransTaxCode.SetTotalLineAmountInc(const Value: Double);
begin
  SetFloatField('TotalLineAmountInc', Value);
end;
{ TTransTaxCodeLines }

constructor TTransTaxCodeLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQLOrder := 'PercentageOn';
  self.ExportExcludeList.Add('subtaxid');
  fIsList:= true;
end;

destructor TTransTaxCodeLines.Destroy;
begin
  inherited;
end;

procedure TTransTaxCodeLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'TransTaxCodeID');
  SetPropertyFromNode(node, 'SubTaxID');
  SetPropertyFromNode(node, 'SubTaxCode');
  SetPropertyFromNode(node, 'Percentage');
  SetPropertyFromNode(node, 'PercentageOn');
  SetPropertyFromNode(node, 'PercentageOnID');
  SetPropertyFromNode(node, 'TaxAmount');
  SetPropertyFromNode(node, 'CapAmount');
  SetPropertyFromNode(node, 'AmountPerUnit');
  SetPropertyFromNode(node, 'UOM');
  SetPropertyFromNode(node, 'ThresholdAmount');
end;

procedure TTransTaxCodeLines.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'TransTaxCodeID', TransTaxCodeID);
  AddXMLNode(node, 'SubTaxID', SubTaxID);
  AddXMLNode(node, 'SubTaxCode', SubTaxCode);
  AddXMLNode(node, 'Percentage', Percentage);
  AddXMLNode(node, 'PercentageOn', PercentageOn);
  AddXMLNode(node, 'PercentageOnID', PercentageOnID);
  AddXMLNode(node, 'TaxAmount', TaxAmount);
  AddXMLNode(node, 'CapAmount', CapAmount);
  AddXMLNode(node, 'AmountPerUnit', AmountPerUnit);
  AddXMLNode(node, 'UOM', UOM);
  AddXMLNode(node, 'ThresholdAmount', ThresholdAmount);
end;

function TTransTaxCodeLines.ValidateData: Boolean;
var
  s:STring;
begin
  REsult := True;
  Resultstatus.Clear;
  s:= TransDetails;
  if Taxcode <> '' then s:= s+ NL + 'Taxcode :' + Taxcode;


  if TransTaxCodeID = 0 then begin
    s:= s+ NL +'Tax code should not be blank';
    REsult := False;
  end;
  if SubTaxID = 0 then begin
    s:= s+ NL +'Sub Tax code should not be Blank';
    REsult := False;
  end;
  (*
  // avalara has subtaxcodes with 0 value, storing it for record
  if (Percentage = 0) and (UOM = '') then begin
    s:= s + NL +'Sub Tax Code Percentage or UOM should have a value';
    result := False;
  end;*)
  if PercentageOn = '' then
    PercentageOn := AMOUNT_EX;

  if (PercentageOnID = 0) then
    if PercentageOn <> AMOUNT_EX then begin
      s:= s+ NL +'sub Tax Code Percentage On  should not be blank';
      REsult := False;
    end;
  if not(result) then begin
    Resultstatus.AddItem(False, rssError, 0, s+NL +NL + 'Please fix this problem in the Taxcode and then recreate this transaction');
  end;

end;

class function TTransTaxCodeLines._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TTaxCode','SubTaxCodeObj','SubTaxID','ID');
  TBOSchema.AddRefType(result,'TTaxCode','SubTaxCodeObj','SubTaxCode','CodeName');
end;

function TTransTaxCodeLines.Save: Boolean;
begin
  REsult := False;
  if not ValidateData then exit;
  REsult := inherited Save;
end;

procedure TTransTaxCodeLines.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TTransTaxCodeLines.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then exit; // we are only interested in data fields.
  inherited;
  if SameText(Sender.FieldName, 'PercentageOn') then begin
    if not RawMode  then begin
      with GetNewDataset('select Id from ' + GetBusObjectTablename + ' where '+ TransTaxCodeIDFieldname +'= ' + inttostr(TransTaxCodeID)+
                                                                         ' and  SubTaxCode = ' + Quotedstr(PercentageOn), True) do
        try PercentageOnID := FieldByname('ID').asInteger;
        finally
          if active then close;
          Free;
        end;
    end;
  end;
end;

function TTransTaxCodeLines.GetSQL: string;
begin
  REsult := inherited GetSQL;
end;

function TTransTaxCodeLines.GetAmountPerUnit: double;
begin
  result := GetFloatField('AmountPerUnit');
end;

class function TTransTaxCodeLines.GetIDField: string;
begin
  REsult := 'ID'
end;

function TTransTaxCodeLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not REsult then exit;
  if Assigned(Owner) then
    if Owner is TTransTaxCode then TransTaxCodeID := TTransTaxCode(Owner).ID;
  PercentageOn := AMOUNT_EX;
end;

function TTransTaxCodeLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterPost(Sender);
end;

function TTransTaxCodeLines.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoBeforePost(Sender);
  if not REsult then exit;
end;

{ Property Functions }

function TTransTaxCodeLines.GetSubTaxID: Integer;
begin
  REsult := GetIntegerField('SubTaxID');
end;

function TTransTaxCodeLines.GetSubTaxCode: string;
begin
  REsult := getStringField('SubTaxCode');
end;

function TTransTaxCodeLines.GetPercentage: Double;
begin
  REsult := GetFloatField('Percentage');
end;

function TTransTaxCodeLines.GetPercentageOn: string;
begin
  REsult := getStringField('PercentageOn');
end;

function TTransTaxCodeLines.GetPercentageOnID: Integer;
begin
  REsult := GetIntegerField('PercentageOnID');
end;

function TTransTaxCodeLines.GetTaxAmount: Double;
begin
  REsult := GetFloatField('TaxAmount');
end;

function TTransTaxCodeLines.getTaxcode: STring;
begin
  Result := '';
  if assigned(Self.Owner) then
    if owner is TTransTaxCode then
      Result := TTransTaxCode(Owner).taxcode;
end;

function TTransTaxCodeLines.GetThresholdAmount: double;
begin
  result := GetFloatField('ThresholdAmount');
end;

function TTransTaxCodeLines.GetTransTaxCodeID: Integer;
begin
  result := Getintegerfield(TransTaxCodeIDFieldname);
end;

function TTransTaxCodeLines.GetUOM: string;
begin
  result := GetStringField('UOM');
end;

procedure TTransTaxCodeLines.SetSubTaxID(const Value: Integer);
begin
  SetIntegerField('SubTaxID', Value);
end;

procedure TTransTaxCodeLines.SetSubTaxCode(const Value: string);
begin
  SetStringField('SubTaxCode', Value);
end;

procedure TTransTaxCodeLines.SetAmountPerUnit(const Value: double);
begin
  SetFloatField('AmountPerUnit',Value);
end;

procedure TTransTaxCodeLines.SetPercentage(const Value: Double);
begin
  SetFloatField('Percentage', Value);
end;

procedure TTransTaxCodeLines.SetPercentageOn(const Value: string);
begin
  SetStringField('PercentageOn', Value);
end;

procedure TTransTaxCodeLines.SetPercentageOnID(const Value: Integer);
begin
  SetIntegerField('PercentageOnID', Value);
end;

procedure TTransTaxCodeLines.SetTaxAmount(const Value: Double);
begin
  SetFloatField('TaxAmount', Value);
end;

procedure TTransTaxCodeLines.SetThresholdAmount(const Value: double);
begin
  SetFloatField('ThresholdAmount',Value);
end;

procedure TTransTaxCodeLines.SetTransTaxCodeID(const Value: Integer);
begin
  Setintegerfield(TransTaxCodeIDFieldname , Value);
end;

procedure TTransTaxCodeLines.SetUOM(const Value: string);
begin
  SetStringField('UOM',Value);
end;

function TTransTaxCodeLines.TransDetails: String;
begin
  Result := '';
  if assigned(Owner) and (owner is TTransTaxCode) then
    Result := TTransTaxCode(Owner).TransDetails;
end;

end.
