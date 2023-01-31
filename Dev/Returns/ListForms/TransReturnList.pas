unit TransReturnList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, BaseInputForm, DAScript,
  MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TTransReturnListGUI = class(TBaseListingGUI)
    qryMainId: TIntegerField;
    qryMainDate: TDateField;
    qryMainPeriod: TWideStringField;
    qryMainDateFrom: TDateField;
    qryMainDateto: TDateField;
    qryMainDescription: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainAccMethod: TWideStringField;
    qryMainallclass: TWideStringField;
    qryMainclassname: TWideStringField;
    qryMainCode: TWideStringField;
    qryMainAmount: TFloatField;
    qryMainTranstype: TWideStringField;
    qryMainTransref: TWideStringField;
    qryMainTransDate: TDateField;
    qryMainEmployeeID: TLargeintField;
    qryMainFixedAssetID: TLargeintField;
    qryMainPaymentID: TLargeintField;
    qryMainPrepaymentID: TLargeintField;
    qryMainPurchaseOrderID: TLargeintField;
    qryMainSaleID: TLargeintField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    fsTransRef  : STring;
    fsTransType : String;
    fiID: Integer;
    fsReturnCode: String;
  Protected
    procedure RefreshTotals; override;
    procedure AssignKeyId(Popupform: TBaseInputGUI); Override;
    Procedure SetGridColumns;Override;
  public
    Property TransRef:String  read fsTransRef   write fsTransRef;
    Property TransType:String read fsTransType  write fsTransType;
    Property ID:Integer read fiID write fiID;
    Property ReturnCode :String read fsReturnCode write fsReturnCode;
    (* Class Procedure TransReturnList(fTransRef  : STring;fTransType : String; basID:Integer = 0; fReturnCode:String= ''; form:TComponent = nil);Virtual; *)
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib, AppEnvironment , tcTypes, busobjstockTransferentry,
  BusobjStockAdjustEntry, BUsObjSaleBase, SalesConst, tcDataUtils;

{$R *.dfm}
(* Class Procedure TTransReturnListGUI.TransReturnList(fTransRef  : STring;fTransType : String; basID:Integer = 0; fReturnCode:String= '';Form :tcomponent = nil);
begin
  if FormStillOpen('TTransReturnListGUI') then begin
    Form :=   FindExistingComponent('TTransReturnListGUI');
    if Assigned(Form) then begin
      TTransReturnListGUI(Form).Close;
      Application.ProcessMessages;
    end;
  end;
  form := getcomponentByclassname('TTransReturnListGUI');
  if not (Assigned(Form)) then exit;
  TTransReturnListGUI(Form).TransType  := fTransType;
  TTransReturnListGUI(form).transRef   := fTransref;
  TTransReturnListGUI(form).ID         := basID;
  TTransReturnListGUI(form).ReturnCode    := fReturnCode;
  TTransReturnListGUI(form).formstyle  := fsmdiChild;
  TTransReturnListGUI(form).bringTofront;
end; *)
procedure TTransReturnListGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  Popupform.KeyId := 0;
  if (Sysutils.SameText(qryMainTRansType.asString ,TStockTransferEntry.Transtype)) or
            (Sysutils.SameText(qryMainTRansType.asString , TStockAdjustEntry.Transtype))  then begin
     Popupform.KeyId := QrymainSaleID.asInteger;
  end;
  if Popupform.KeyId = 0 then inherited;
end;

procedure TTransReturnListGUI.FormCreate(Sender: TObject);
begin
    if AppEnv.RegionalOptions.RegionType = rNZ then begin
      Qrymain.SQL.text := replaceStr(Qrymain.SQL.text , 'tblBasReportLines' , 'tblnzreportlines');
      Qrymain.SQL.text := replaceStr(Qrymain.SQL.text , 'tblbasreports' , 'tblnzreturns');
    end else if AppEnv.RegionalOptions.RegionType = rUK then begin
      Qrymain.SQL.text := replaceStr(Qrymain.SQL.text , 'tblBasReportLines' , 'tblvatreportlines');
      Qrymain.SQL.text := replaceStr(Qrymain.SQL.text , 'tblbasreports' , 'tblvatreturns');
    end;
  inherited;
  fsTransRef := '';
  fsTransType:= '';
  fsReturnCode := '';
  fiID := 0;
  AddCalccolumn('Amount', True);
end;

procedure TTransReturnListGUI.FormShow(Sender: TObject);
var
  fsCaption:STring;
begin
  fsCaption :='BAS Return Details ';
  qryMainId.DisplayLabel := 'BAS Return ID';
  if AppEnv.RegionalOptions.RegionType = rNZ then begin
    fsCaption :='GST Return Details ';
    qryMainId.DisplayLabel := 'GST Return ID';
  end else if AppEnv.RegionalOptions.RegionType = rUK then begin
    fsCaption :='VAT Return Details ';
    qryMainId.DisplayLabel := 'VAT Return ID';
  end;
  if ID<> 0 then fsCaption := fsCaption  + ' # ' + inttostr(ID);
  if (Transtype <> '') and (TransRef<> '') then fsCaption := fsCaption  +' of ' +Transtype +' # ' + TransRef;
  if ReturnCode <> '' then fsCaption := fsCaption +' - ' + ReturnCode;
  Self.caption :=fsCaption ;
  TitleLabel.caption :=fsCaption ;
  inherited;
end;

procedure TTransReturnListGUI.grdMainDblClick(Sender: TObject);
begin
       if (Sysutils.SameText(qryMainTRansType.asString , TStockAdjustEntry.Transtype))  then SubsequentID := Chr(95) + AdjustType(QrymainSaleID.asInteger)   +  'Stock Adjustment'
  else if (Sysutils.SameText(qryMainTRansType.asString ,TStockTransferEntry.Transtype)) then SubsequentID := Chr(95) + TransferType(QrymainSaleID.asInteger) +  'Stock Transferment'
  else SubsequentID := Chr(95) + qryMainTransType.AsString;

  if SameText(qryMainTransType.AsString,'Cash Sale') then begin
    case TSalesBase.GetSaleType(qryMainSaleID.AsInteger) of
      stPOS,
      stPOSLayby,
      stPOSLaybyPayment,
      stPOSCashSale: SubsequentID := Chr(95) + 'POS';
    end;
  end;
  inherited;

end;

procedure TTransReturnListGUI.RefreshQuery;
begin
  Qrymain.Disablecontrols;
  try
    closeDB(Qrymain);
    Qrymain.Parambyname('Transglobalref').asString := TransRef;
    Qrymain.Parambyname('Transtype').asString := TransType;
    Qrymain.Parambyname('code').asString := ReturnCode;
    Qrymain.Parambyname('ID').asInteger := ID;
    if ReturnCode <> '' then RemoveFieldfromGrid('Code');
    inherited;
  finally
    Qrymain.enablecontrols;
  end;
end;

procedure TTransReturnListGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TTransReturnListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainEmployeeID.fieldName);
  RemoveFieldfromGrid(QrymainFixedAssetID.fieldName);
  RemoveFieldfromGrid(qryMainPaymentID.fieldName);
  RemoveFieldfromGrid(QrymainPrepaymentId.fieldName);
  RemoveFieldfromGrid(qryMainPurchaseOrderID.fieldName);
  RemoveFieldfromGrid(QrymainSaleID.fieldName);
end;

end.

