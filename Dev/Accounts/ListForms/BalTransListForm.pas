unit BalTransListForm;

interface

uses
  Windows, Messages, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, BaseInputForm, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TBalTransListType = (btlAll =1, btlCogsAdjOnly = 2, btlCogsAdjEx =3);

  TBalTransListGUI = class(TBaseListingGUI)
    qryMainTransID: TIntegerField;
    qryMainDate: TDateField;
    qryMainType: TWideStringField;
    qryMainSaleID: TIntegerField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainPaymentID: TIntegerField;
    qryMainAccountID: TIntegerField;
    qryMainAccountName: TWideStringField;
    qryMainProductDesc: TWideStringField;
    qryMainAccountType: TWideStringField;
    qryMainAmountEx: TFloatField;
    qryMainAmountInc: TFloatField;
    qryMainGlobal: TWideStringField;
    qryMainClientName: TWideStringField;
    qryMainNotes: TWideStringField;
    qryMainPrepaymentID: TIntegerField;
    qryMainFixedAssetID: TIntegerField;
    qryMainEmployeeID: TIntegerField;
    qryMainseqno: TFloatfield;
    qryMainInvAssetEntry: TWideStringField;
    qryMainProductName: TWideStringField;
    lblOptionMsg: TLabel;
    tmrMsg: TTimer;
    grpFiltersex: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure dtToChange(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    //procedure tmrMsgTimer(Sender: TObject);
    //procedure lblOptionMsgDblClick(Sender: TObject);
    procedure lblDateCommentsClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    { Private declarations }
    fFromTo: TDateTime;
    ListforInvAsset:Boolean;
    fsReportfilter: String;
    fbIsRetainedEarnings: Boolean;
    fbIsProfitAndLoss: boolean;
    Procedure SetReportfilter(Const Value:String);
    procedure initProductcostHistory(Sender: TObject);
    function BalTransListType: TBalTransListType;
    procedure MakeQryMain;

  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Procedure AssignKeyId(Popupform :TBaseInputGUI); Override;
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;

  public
    { Public declarations }
    property ToDate: TDateTime read fFromTo write fFromTo;
    Property Reportfilter :String read fsReportfilter write setReportfilter;
    Property IsProfitAndLoss:boolean read fbIsProfitAndLoss write fbIsProfitAndLoss;
    Property IsRetainedEarnings:Boolean read fbIsRetainedEarnings write fbIsRetainedEarnings;
    class function BalTransListSQL(const Reportfilter: String; FilterIndex :Integer = 2; BalTransListType : TBalTransListType = btlAll; IsRetainedEarnings :Boolean =False; IsProfitAndLoss :Boolean = False; IncludeOrderby:Boolean =TRue):String;
    class function InvAssetBalTransListSQL(fddateto:TDateTime):String;
  end;


implementation
     
uses SysUtils, CommonLib, busobjStockMovement, FastFuncs,
  BusobjStockAdjustEntry, busobjstockTransferentry, Forms, BusObjClient,
  BusObjBase, tcConst, BusObjSaleBase, SalesConst, tcDataUtils, CommonFormLib,
  ProductcostHistory, LogLib, TimedHint, AppEnvironment, dateutils, DNMLib,
  MySQLConst, DbSharedObjectsObj, CommonDbLib, BalanceSheetForm;
{$R *.dfm}

procedure TBalTransListGUI.ReadnApplyGuiPrefExtra;
var
  x:Integer;
begin
      inherited;
      if GuiPrefs.Node.Exists('GrpfiltersEx') then begin
        x := GuiPrefs.Node['GrpfiltersEx.ItemIndex'].asInteger;
        if x > 0 then GrpfiltersEx.ItemIndex := x - 1;
      end;
end;

procedure TBalTransListGUI.RefreshQuery;
begin
  try
    qryMain.Close;
    qryMain.Params.ParamByName('txtfrom').asDate                    := filterdateFrom;
    qryMain.Params.ParamByName('txtto').asDate                      := filterdateto(*dtto.DateTime*);

    if IsRetainedEarnings then begin
      qryMain.Params.ParamByName('RetainedEarningFrom').asDateTime  := filterdateFrom;
      qryMain.Params.ParamByName('RetainedEarningTo').asDateTime    := IncSecond(IncDay(dateof(GetCurrentFiscalYearStart(FilterdateTo)), 1), -1);//IncDay(GetCurrentFiscalYearStart(FilterdateTo), - 1)
    end;
    if IsProfitAndLoss then begin
      qryMain.Params.ParamByName('Pnlfrom').asDateTime              := iif(dateof(FilterdateTo) <= Appenv.Companyprefs.SummarisedTransDate(*ClosingDate*) , filterDateFrom ,  GetCurrentFiscalYearStart(FilterdateTo));
      qryMain.Params.ParamByName('Pnlto').asDateTime                := filterDateTo;
    end;


    doshowProgressbar(3, WaitMSg);
    try
      DoStepProgressbar;
      inherited;
      clog(qrymain.SQLtext);
    finally
      DoHideProgressbar;
    end;
  except
  end;
end;

procedure TBalTransListGUI.RefreshTotals;
begin
  CalcnshowFooter;
(*var
  oRecPointer: TBookmark;
  dAmountEx, dAmountInc: currency;
begin
  dAmountInc := 0;
  dAmountEx := 0;

  qryMain.DisableControls;
  oRecPointer := qryMain.GetBookmark;
  Try
    qryMain.First;
    while not qryMain.Eof do begin
      dAmountEx  := dAmountEx + qryMain.FieldByName('Amount (Ex)').AsFloat;
      dAmountInc := dAmountInc + qryMain.FieldByName('Amount (Inc)').AsFloat;
      qryMain.Next;
    end;
  Finally
    qryMain.GoToBookmark(oRecPointer);
    qryMain.FreeBookmark(oRecPointer);
    qryMain.EnableControls;
  end;
  grdMain.ColumnByName('Amount (Ex)').FooterValue := FloatToStrF(dAmountEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Amount (Inc)').FooterValue := FloatToStrF(dAmountInc, ffCurrency, 15, CurrencyRoundPlaces);*)
end;
Function TBalTransListGUI.BalTransListType : TBalTransListType;
begin
       if grpFiltersex.ItemIndex = 0 then result := btlAll
  else if grpFiltersex.ItemIndex = 1 then result := btlCogsAdjOnly
  else result := btlCogsAdjEx;
end;
procedure TBalTransListGUI.SetReportfilter(const Value: String);
begin
  fsReportfilter := Value;
  MakeQryMain;
end;
(*procedure TBalTransListGUI.tmrMsgTimer(Sender: TObject);
begin
  inherited;
  lblOptionMsg.visible := False;
  grpFiltersex.parentcolor := True;
  tmrMsg.enabled:= False;
end;*)

procedure TBalTransListGUI.MakeQryMain;
begin
  CloseDB(Qrymain);
  Qrymain.disablecontrols;
  try
    Qrymain.SQL.clear;
    Qrymain.SQl.add(BalTransListSQL(fsReportfilter, grpFilters.itemindex , BalTransListType ,IsRetainedEarnings , IsProfitAndLoss));
    RefreshOrignalSQL;
  finally
    Qrymain.Enablecontrols;
  end;
end;
procedure TBalTransListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['GrpfiltersEx.ItemIndex'].asInteger := GrpfiltersEx.ItemIndex + 1;
end;
class function TBalTransListGUI.InvAssetBalTransListSQL(fddateto:TDateTime):String;
var
  qry: TERPQuery;
  s:String;
begin
  result := TBalTransListGUI.BalTransListSQL('(' +TBalanceSheetGUI.BalTransListfilter('Inventory Asset','OCASSET', fddateto)+ ')');

  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    //qry.SQL.text := 'Select distinct C.accountId, ASSETACCNT , c.AccountType  from tblparts P inner join tblchartofaccounts c on P.ASSETACCNT = c.AccountName';
    //qry.SQL.text := 'Select AccountName  from tblchartofaccounts where accounttype ="OCASSET" order by AccountName ';
    qry.SQL.text := 'Select distinct accountname  from tbltransactions where accounttype  = ''OCASSET'' and type <> ''Journal Entry''';
    qry.open;
    if qry.recordcount >0 then begin
      Qry.first;
      While Qry.EOF =False do begin
        if s<> '' then s := s + ' OR ';
        s := s + ' (AccountName = ' + Quotedstr(Qry.FieldByName('Accountname').AsString)+') ';
        qry.next;
      end;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
  if s <> '' then REsult := replacestr(REsult  ,'and ((AccountType = "OCASSET" AND AccountName = ''Inventory Asset''))' , ' and ( AccountType = "OCASSET"  and (' + s+')) '  );
end;

Class function TBalTransListGUI.BalTransListSQL(const Reportfilter: String; FilterIndex :Integer = 2; BalTransListType : TBalTransListType = btlAll; IsRetainedEarnings :Boolean =False; IsProfitAndLoss :Boolean = False; IncludeOrderby:Boolean =TRue):String;
var
  st:TStringlist;
const
  AmountEx = 'If((AccountType = "AR" OR AccountType = "OASSET" OR AccountType = "BANK" OR AccountType = "OCASSET"),DebitsEx - CreditsEx,CreditsEx - DebitsEx)';
  amountinc = 'If((AccountType = "AR" OR AccountType = "OASSET" OR AccountType = "BANK" OR AccountType = "OCASSET"),DebitsInc - CreditsInc,CreditsInc - DebitsInc)';
begin
  st:= TStringlist.create;
  try
    St.Add('SELECT');
    St.Add('if(round(seqno)  in (11,12,25,26,27,55,71,84,87,88) , "T" , "F") as InvAssetEntry,');
    St.Add('ProductName as ProductName,');
    St.Add('Seqno as seqno,');
    St.Add('TransID as TransID,');
    St.Add('Date as Date,');
    St.Add('Type as Type,');
    St.Add('GlobalRef as "Global #",');
    St.Add('ClientName as ClientName,');
    St.Add('SaleID as SaleID,');
    St.Add('PurchaseOrderID as PurchaseOrderID,');
    St.Add('PaymentID as PaymentID,');
    St.Add('PrepaymentID as PrepaymentID,');
    St.Add('FixedAssetID as FixedAssetID,');
    St.Add('AccountID as AccountID,');
    St.Add('AccountName as "Account Name",');
    St.Add('ProductDesc as ProductDesc,');
    St.Add('AccountType as "Account Type",');
    if FilterIndex <>0 then St.Add('GROUP_CONCAT( Distinct concat(if(round(seqno)<>seqno,"(COGS Adjustment) " , ""), ifnull(Notes,""))) as Notes,')
    else St.Add('GROUP_CONCAT( Distinct Notes) as Notes,');
    St.Add('sum(' + AmountEx +') as "Amount (Ex)",');
    St.Add('sum(' + amountinc +') as "Amount (Inc)",');
    St.Add('EmployeeID as EmployeeID');
    St.Add('FROM tblTransactions TRANS');
    //St.Add('WHERE type <> "Closing Date Summary" /*Trans.Seqno < 100*/ and TRANS.Date Between :txtfrom AND :txtto');
    St.Add('WHERE /*type <> "Closing Date Summary"*/ Trans.Seqno < 100 and TRANS.Date Between :txtfrom AND :txtto');
         if BalTransListType = btlAll         then St.Add('and (round(seqno)= seqno or  ' + AmountEx +' <>0 or ' + amountinc +'<>0)')
    else if BalTransListType = btlCogsAdjOnly then St.Add('and (round(seqno)<> seqno and  (' + AmountEx +' <>0 or ' + amountinc +'<>0))')
    else if BalTransListType = btlCogsAdjEx   then St.Add('and (round(seqno)= seqno )');
    if Reportfilter <> '' then St.Add('and ' + Reportfilter);

    if IsRetainedEarnings then St.Add('AND Date Between :RetainedEarningFrom AND :RetainedEarningTo');
    if IsProfitAndLoss    then St.Add('AND Date Between :Pnlfrom             AND :Pnlto');


    if FilterIndex = 0 then
      St.Add('Group by date , type ,if(PurchaseOrderID<>0 ,PurchaseOrderID , if(PaymentID<>0 ,PaymentID , if(PrepaymentID<>0 ,PrepaymentID , if(FixedAssetID<>0 ,FixedAssetID ,if(SaleID<>0 ,SaleID ,0 ))))) , Productname')
    else if FilterIndex = 1 then
      St.Add('Group by date , type ,if(PurchaseOrderID<>0 ,PurchaseOrderID , if(PaymentID<>0 ,PaymentID , if(PrepaymentID<>0 ,PrepaymentID , if(FixedAssetID<>0 ,FixedAssetID ,if(SaleID<>0 ,SaleID ,0 ))))) , Productname,Seqno')
    else if FilterIndex = 2 then
      St.Add('Group by TransID');
    St.Add('union all');
    St.Add('SELECT');
    St.Add('if(round(seqno)  in (11,12,25,26,27,55,71,84,87,88) , "T" , "F") as InvAssetEntry,');
    St.Add('ProductName as ProductName,');
    St.Add('100+Seqno as seqno,');
    St.Add('TransID as TransID,');
    St.Add('Date as Date,');
    St.Add('Type as Type,');
    St.Add('GlobalRef as "Global #",');
    St.Add('ClientName as ClientName,');
    St.Add('SaleID as SaleID,');
    St.Add('PurchaseOrderID as PurchaseOrderID,');
    St.Add('PaymentID as PaymentID,');
    St.Add('PrepaymentID as PrepaymentID,');
    St.Add('FixedAssetID as FixedAssetID,');
    St.Add('AccountID as AccountID,');
    St.Add('AccountName as "Account Name",');
    St.Add('ProductDesc as ProductDesc,');
    St.Add('AccountType as "Account Type",');
    if FilterIndex <>0 then St.Add('GROUP_CONCAT( Distinct concat(if(round(seqno)<>seqno,"(COGS Adjustment) " , ""), ifnull(Notes,""))) as Notes,')
    else St.Add('GROUP_CONCAT( Distinct Notes) as Notes,');
    St.Add('sum(' + AmountEx +') as "Amount (Ex)",');
    St.Add('sum(' + amountinc +') as "Amount (Inc)",');
    St.Add('EmployeeID as EmployeeID');
    St.Add('FROM tbltransactionsummarydetails TRANS');
    St.Add('WHERE type <> "Closing Date Summary" and TRANS.Date Between :txtfrom AND :txtto');
         if BalTransListType = btlAll         then St.Add('and (round(seqno)= seqno or  ' + AmountEx +' <>0 or ' + amountinc +'<>0)')
    else if BalTransListType = btlCogsAdjOnly then St.Add('and (round(seqno)<> seqno and  (' + AmountEx +' <>0 or ' + amountinc +'<>0))')
    else if BalTransListType = btlCogsAdjEx   then St.Add('and (round(seqno)= seqno )');
    if Reportfilter <> '' then St.Add('and ' + Reportfilter);

    if IsRetainedEarnings then St.Add('AND Date Between :RetainedEarningFrom AND :RetainedEarningTo');
    if IsProfitAndLoss    then St.Add('AND Date Between :Pnlfrom             AND :Pnlto');


    if FilterIndex = 0 then
      St.Add('Group by date , type ,if(PurchaseOrderID<>0 ,PurchaseOrderID , if(PaymentID<>0 ,PaymentID , if(PrepaymentID<>0 ,PrepaymentID , if(FixedAssetID<>0 ,FixedAssetID ,if(SaleID<>0 ,SaleID ,0 ))))) , Productname')
    else if FilterIndex = 1 then
      St.Add('Group by date , type ,if(PurchaseOrderID<>0 ,PurchaseOrderID , if(PaymentID<>0 ,PaymentID , if(PrepaymentID<>0 ,PrepaymentID , if(FixedAssetID<>0 ,FixedAssetID ,if(SaleID<>0 ,SaleID ,0 ))))) , Productname,Seqno')
    else if FilterIndex = 2 then
      St.Add('Group by TransID');
    if IncludeOrderby then St.Add('Order by date desc, type ,if(PurchaseOrderID<>0 ,PurchaseOrderID , if(PaymentID<>0 ,PaymentID , if(PrepaymentID<>0 ,PrepaymentID , if(FixedAssetID<>0 ,FixedAssetID ,0 )))) , Productname, seqno desc; ' );
    Result := St.text;
  finally
    freeandnil(st);
  end;
end;

procedure TBalTransListGUI.SetGridColumns;
begin
  inherited;
  if not devmode then RemoveFieldfromGrid('Seqno');
  if not (listforInvAsset) then   RemoveFieldfromGrid('InvAssetEntry');

end;

procedure TBalTransListGUI.FormShow(Sender: TObject);
begin
  if fFromTo <> 0 then begin
     dtTo.DateTime := fFromTo;
     fbDateRangeSupplied:= True;
  end;
  if grpFilters.itemindex   <0 then grpFilters.itemindex   := 2;
  if grpFiltersex.itemindex <0 then grpFiltersex.itemindex := 0;
  Reportfilter:= fsReportfilter;
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('TransID,SaleID,PurchaseOrderID,PaymentID,AccountID,PrePaymentId,FixedAssetID,EmployeeID');
  //grpFiltersex.color :=   $00CECEFF;
  //lblOptionMsg.visible := True;
  //tmrMsg.enabled := True;
  grpFiltersex.hint:= 'Please select the correct option.'+NL+
                      '"COGS Agj" will only show the adjustment postings and '+NL+
                      '"Ex COGS Adj" will exclude the Adjustment Postings';
    grpFiltersex.visible := False;
    grpFiltersex.itemindex := 0;

end;
procedure TBalTransListGUI.initProductcostHistory(Sender: TObject);
begin
  if not (Sender is   TProductcostHistoryGUI) then exit;
  TProductcostHistoryGUI(Sender).ProductID := tcdatautils.GetProduct(Qrymainproductname.AsString);
end;

procedure TBalTransListGUI.lblDateCommentsClick(Sender: TObject);
begin
  inherited;

end;

(*procedure TBalTransListGUI.lblOptionMsgDblClick(Sender: TObject);
begin
  inherited;
  tmrMsgTimer(tmrMsg);
end;*)

procedure TBalTransListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if (Field = qryMainGlobal) and (grpFilters.ItemIndex < 2) then
    AFont.Color := ABrush.Color;
end;

procedure TBalTransListGUI.grdMainDblClick(Sender: TObject);
var
  form: TBaseInputGUI;
begin
       if (Sysutils.SameText(qryMainType.asString , TStockAdjustEntry.Transtype))   then SubsequentID := Chr(95) + AdjustType(QrymainSaleID.asInteger)   +  'StockAdjustEntry'
  else if (Sysutils.SameText(qryMainType.asString , TStockTransferEntry.Transtype)) then SubsequentID := Chr(95) + TransferType(QrymainSaleID.asInteger) +  'StockTransferEntry'
  else SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Type').AsString;
  if sametext(ActiveFieldname , Qrymainproductname.fieldname) then
    if trim(Qrymainproductname.fieldname) <> '' then begin
      OpenERPListForm('TProductcostHistoryGUI' , initProductcostHistory, nil);
      exit;
    end;

  if SameText(qryMain.Fields.FieldByName('Type').AsString,'Cash Sale') then begin
    case TSalesBase.GetSaleType(qryMain.Fields.FieldByName('SaleID').AsInteger) of
      stPOS,
      stPOSLayby,
      stPOSLaybyPayment,
      stPOSCashSale: SubsequentID := Chr(95) + 'POS';
    end;
  end;

  if qryMain.Fields.FieldByName('Type').AsString = 'Sales Points Opening Balance'  then begin
    if FormStillOpen('TfrmCustomer') then begin
      TForm(FindExistingComponent('TfrmCustomer')).Close;
      Application.ProcessMessages;
      if FormStillOpen('TfrmCustomer') then
        exit;
    end;
    form := TBaseInputGUI(GetComponentByClassName('TfrmCustomer'));
    if Assigned(form) then begin
      form.KeyID:= TClient.IDToggle(qryMainClientName.AsString);
      form.FormStyle := fsMDIChild;
      form.BringToFront;
      with TPageControl(FindChildComponent(form,'TabCtl20')) do begin
        ActivePageIndex:= 2; { accounts }
      end;
    end;
  end
  else
    inherited;
end;

procedure TBalTransListGUI.grpFiltersClick(Sender: TObject);
begin
  //inherited;
  MakeQryMain;
  if Assigned(screen.activecontrol.parent) and (screen.activecontrol.parent = grpFilters) or (screen.activecontrol.parent = grpFiltersex)  then begin
    RefreshQuery;
  end;
  //tmrMsgTimer(tmrMsg);
  Hidehint(Sender);
end;

procedure TBalTransListGUI.dtToChange(Sender: TObject);
begin
  dtFrom.Date:= dtTo.Date;
  inherited;
end;

procedure TBalTransListGUI.FormCreate(Sender: TObject);
begin
  ListforInvAsset:= False;
  fbEnableWebSearch := true;
  inherited;
  Addcalccolumn(qryMainAmountEx.fieldname , true);
  Addcalccolumn(qryMainAmountInc.fieldname , true);
  fbIsRetainedEarnings:=False;
  fbIsProfitAndLoss:=False;
end;

procedure TBalTransListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  //qryMain.IndexFieldNames := QuotedStr('Date') + ' DESC CIS';
  ListforInvAsset :=  pos(uppercase('AND ((AccountType = "OCASSET" AND AccountName = ''Inventory Asset''))') , uppercase(Qrymain.SQL.text))>0;
  {11:PO
       12:uninvoicedPO
       25:invoice
       26:CashSale/POS
       27:refund
       55:StockAdjustment
       71:Manufacture
      }
end;

procedure TBalTransListGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  Popupform.KeyId := 0;
  if (Sysutils.SameText(qryMainType.asString , TStockTransferEntry.Transtype)) or
            (Sysutils.SameText(qryMainType.asString , TStockAdjustEntry.Transtype))  then begin
     (*Popupform.KeyId := TStockMovement.TransactionID(QrymainSaleID.asInteger);*)
     Popupform.KeyId := QrymainSaleID.asInteger;
  end;
  if Popupform.KeyId = 0 then inherited;
end;

initialization
  RegisterClassOnce(TBalTransListGUI);

end.
