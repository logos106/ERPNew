unit SOProgresspayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, BusObjBase, DAScript, MyScript, wwcheckbox,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSOProgresspaymentsGUI = class(TBaseListingGUI)
    qryMainSaleId: TIntegerField;
    qryMainSaleDate: TDateField;
    qryMaintotallineamountinc: TFloatField;
    qryMaintotalAmountinc: TFloatField;
    qryMainPaid: TWideStringField;
    qryMainPayment: TFloatField;
    qryMainBalance: TFloatField;
    qryMainForeignTotalLineAmount: TFloatField;
    qryMainForeignTotalAmount: TFloatField;
    qryMainForeignPaidAmount: TFloatField;
    qryMainForeignBalanceAmount: TFloatField;
    qryMainForeignExchangeCode: TWideStringField;
    ERPQuery1: TERPQuery;
    IntegerField1: TIntegerField;
    DateField1: TDateField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    StringField1: TWideStringField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    FloatField5: TFloatField;
    FloatField6: TFloatField;
    FloatField7: TFloatField;
    FloatField8: TFloatField;
    StringField2: TWideStringField;
    DataSource1: TDataSource;
    qryMainCategory: TLargeintField;
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject); override;
  private
    fsSOGlobalref: String;
    (*fNewProgresspayment: TGeneralProc;*)
    procedure NewProgresspayment;
  Protected
    Procedure CalcnShowFooter;override;
    Procedure SetGridColumns;override;
  public
    Property SOGlobalref :String read fsSOGlobalref Write fsSOGlobalref;
    Procedure RefreshQuery;Override;
    (*Property NewProgresspayment:TGeneralProc read fNewProgresspayment write fNewProgresspayment;*)

  end;


implementation

uses CommonLib, BusObjSales, CommonDbLib, CommonFormLib, FastFuncs,
  tcConst;

{$R *.dfm}
procedure TSOProgresspaymentsGUI.FormCreate(Sender: TObject);
begin
  Qrymain.SQL.clear;
  Qrymain.SQL.Add('Select ');
  Qrymain.SQL.Add('1                              as Category, ');
  Qrymain.SQL.Add('S.SaleId                       as SaleID, ');
  Qrymain.SQL.Add('S.SaleDate                     as SaleDate, ');
  Qrymain.SQL.Add('Sum(Sl.totallineamountinc)     as totallineamountinc,  ');
  Qrymain.SQL.Add('S.totalAmountinc               as totalAmountinc, ');
  Qrymain.SQL.Add('S.Paid                         as Paid,  ');
  Qrymain.SQL.Add('S.Payment                      as Payment,  ');
  Qrymain.SQL.Add('S.Balance                      as Balance,   ');
  Qrymain.SQL.Add('Sum(SL.ForeignTotalLineAmount) as ForeignTotalLineAmount ,  ');
  Qrymain.SQL.Add('S.ForeignTotalAmount           as ForeignTotalAmount,   ');
  Qrymain.SQL.Add('S.ForeignPaidAmount            as ForeignPaidAmount,  ');
  Qrymain.SQL.Add('S.ForeignBalanceAmount         as ForeignBalanceAmount,  ');
  Qrymain.SQL.Add('S.ForeignExchangeCode          as ForeignExchangeCode ');
  Qrymain.SQL.Add('from tblsales S ');
  Qrymain.SQL.Add('inner join tblSaleslines SL on S.SaleId = Sl.SaleId and SL.Productname = '+Quotedstr(PART_SOPROGRESSPAYMENT)  );
  Qrymain.SQL.Add('where ifnull(S.SOProgressPaymentGlobalRef,"") = :SOProgressPaymentGlobalRef' );
  Qrymain.SQL.Add('group by S.SaleId  ');
  Qrymain.SQL.Add('union  ');
  Qrymain.SQL.Add('Select  ');
  Qrymain.SQL.Add('2                              as Category,  ');
  Qrymain.SQL.Add('S.SaleId                       as SaleId,  ');
  Qrymain.SQL.Add('S.SaleDate                     as SaleDate,  ');
  Qrymain.SQL.Add('0                              as totallineamountinc ,  ');
  Qrymain.SQL.Add('S.totalAmountinc               as totalAmountinc,  ');
  Qrymain.SQL.Add('S.Paid                         as Paid,  ');
  Qrymain.SQL.Add('S.Payment                      as Payment,  ');
  Qrymain.SQL.Add('S.Balance                      as Balance,   ');
  Qrymain.SQL.Add('0                              as ForeignTotalLineAmount ,  ');
  Qrymain.SQL.Add('S.ForeignTotalAmount           as ForeignTotalAmount,   ');
  Qrymain.SQL.Add('S.ForeignPaidAmount            as ForeignPaidAmount,  ');
  Qrymain.SQL.Add('S.ForeignBalanceAmount         as ForeignBalanceAmount,  ');
  Qrymain.SQL.Add('S.ForeignExchangeCode          as ForeignExchangeCode ');
  Qrymain.SQL.Add('from tblsales S ');
  Qrymain.SQL.Add('where globalref = :SalesGlobalref  ');
  Qrymain.SQL.Add('order by category desc');
  NonSearchMode:= True;
  inherited;
  fsSOGlobalref:='';
  AddCalccolumn('totallineamountinc' , true);
  AddCalccolumn('ForeignTotalLineAmount' , false);
  (*fNewProgresspayment:= nil;*)
end;

procedure TSOProgresspaymentsGUI.RefreshQuery;
begin
  closeDB(Qrymain);
  Qrymain.Parambyname('SOProgressPaymentGlobalRef').asString := SOGlobalref;
  Qrymain.Parambyname('SalesGlobalref').asString := SOGlobalref;
  inherited;
  CalcnShowFooter;
end;

procedure TSOProgresspaymentsGUI.NewProgresspayment;
var
   d:double;
   invID:Integer;
   SalesOrder :TSalesorder;
   msg: string;
begin
  inherited;
  SalesOrder := TsalesOrder.Create(Self);
  try
    SalesOrder.connection := TMyDacDataConnection.Create(SalesOrder);
    SalesOrder.connection.connection := GetNewMyDacConnection(SalesOrder);
    SalesOrder.LoadSelect('globalref = ' + Quotedstr(SOGlobalref));
    if SalesOrder.count = 0  then begin
      MessageDlgXP_Vista('Sales Order # ' +SOGlobalref+ ' Cannot Be Located For Progress Payment', mtWarning, [mbok],0);
      exit;
    end;
    if SalesOrder.Converted then begin
      MessageDlgXP_Vista('Sales Order # ' +intToStr(SalesOrder.id)+ ' Is Already Converted To Invoice and Progress Payment Cannot Be Made for a Converted Sales Order', mtWarning, [mbok],0);
      exit;
    end;

    if not SalesOrder.Lock then begin
        MessageDlgXP_Vista(replacestr(replaceStr(Salesorder.UserLock.LockMessage , 'Unable to update data.' , 'Uncable to Create Progress Payment for Sales Order #' +IntToStr(salesorder.ID)) , 'this record ' , 'this Sales Order ') , mtWarning, [mbok],0);
        Exit;
    end;
    try
      SalesOrder.Connection.BeginTransaction;
      try
        d:= CustomInputFloat('Progress Payment' , 'Enter The Progress Payment Amount' , CurrToStr(SalesOrder.totalAmountinc-SalesOrder.TotalProgressPayments) );
        if d<=0 then exit;
        invID:= SalesOrder.MakeProgresspayment(d, msg);
        if invID=0 then begin
          Salesorder.Connection.RollbackTransaction;
          MessageDlgXP_Vista(msg, mtInformation, [mbOk] , 0);
          Exit;
        end;
        Salesorder.Connection.CommitTransaction;
        Salesorder.UserLock.Unlock(Salesorder.LockGroupName);
        if MessageDlgXP_Vista('Do You Wish to Open the Progress Payment Record?' , mtconfirmation, [mbyes,mbNo] , 0) = mryes then
            OpenERPForm('TInvoiceGUI' , invID);
      Finally
          salesOrder.UnLock;
      end;
    except
      on E:Exception do begin
        Salesorder.Connection.RollbackTransaction;
      end;
    end;
  finally
      Freeandnil(SalesOrder);
  end;
end;

procedure TSOProgresspaymentsGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  (*if assigned(fNewProgresspayment) then fNewProgresspayment;*)
  NewProgresspayment;
end;

procedure TSOProgresspaymentsGUI.CalcnShowFooter;
begin
  inherited;
  
end;

procedure TSOProgresspaymentsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Category');
  RemoveFieldfromGrid('Paid');
end;

procedure TSOProgresspaymentsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qryMainCategory.asInteger = 2 then begin
    ABrush.Color := clMoneyGreen;
    if (sameText(field.FieldName , 'totallineamountinc')) or
      (sameText(field.FieldName , 'Payment')) or
      (sameText(field.FieldName , 'Balance')) or
      (sameText(field.FieldName , 'ForeignPaidAmount')) or
      (sameText(field.FieldName , 'ForeignBalanceAmount')) or
      (sameText(field.FieldName , 'ForeignTotalLineAmount')) then
        Afont.color := Abrush.color
    else begin
      AFont.Color := clMaroon;
      Afont.Style := Afont.Style +[fsbold];
    end;

  end else begin
    AFont.Color := clblack;
    Afont.Style := Afont.Style -[fsbold];
  end;
end;

procedure TSOProgresspaymentsGUI.grdMainDblClick(Sender: TObject);
begin
  if qryMainCategory.asInteger = 2 then
  else inherited;

end;

initialization
  RegisterClassOnce(TSOProgresspaymentsGUI);

end.
