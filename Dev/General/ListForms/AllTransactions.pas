unit AllTransactions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript;

type
  TAllTransactionGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainTransDate: TDateField;
    qryMainDeleted: TWideStringField;
    qryMainTranstype: TWideStringField;
    qryMainTransNo: TIntegerField;
    grpOptions: TRadioGroup;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    SQLList:TStringList;
  public
    Procedure RefreshQuery; Override;
  end;

implementation

uses FastFuncs, CommonLib, MySQLConst;

{$R *.dfm}

Procedure TAllTransactionGUI.RefreshQuery;
var
    ctr :Integer;
    SalesType, deposittype , PurchaseType :STring;
begin
    DonotChangeGridLabels := True;
    With Qrymain do begin
        DisableControls;
        try
            if active then  close;
            SQL.clear;
            for ctr := 0 to SQLList.Count-1 do SQL.add(SQLList[ctr]);
            PurchaseType := 'if(ifnull(IsPO,"F")    = "T" , "PurchaseOrder" ,' +
                            'if(ifnull(IsRA,"F")    = "T" , "Return Authority" , ' +
                            'if(ifnull(IsBill,"F")  = "T" , "Bill" ,' +
                            'if(ifnull(IsCredit,"F")= "T" , "Credit" ,' +
                            'if(ifnull(IsCheque,"F")= "T" , "Cheque" ,' +
                            '"Unknown")))))';
            DepositType  := 'If(bdl.TrnsType        = "Deposit Entry", ' +
                            '"Deposit Entry", "Deposit")';
            SalesType    := 'if(Ifnull(IsPOS,"F")           = "T" , "POS" ,  ' +
                            'if(Ifnull(IsRefund,"F")        = "T" , "Refund" ,  ' +
                            'if(Ifnull(IsCashSale,"F")      = "T" , "CashSale" ,  ' +
                            'if(Ifnull(IsInvoice,"F")       = "T" , "Invoice" ,  ' +
                            'if(Ifnull(IsQuote,"F")         = "T" , "Quote" ,  ' +
                            'if(Ifnull(IsSalesOrder,"F")    = "T" , "SalesOrder" ,  ' +
                            'if(Ifnull(IsVoucher,"F")       = "T" , "Voucher" ,  ' +
                            'if(Ifnull(IsLayby,"F")         = "T" , "Layby" ,  ' +
                            'if(Ifnull(IsLaybyTOS,"F")      = "T" , "Layby-TOS" ,  ' +
                            'if(Ifnull(IsLaybyPayment,"F") = "T" , "LaybyPayment" ,  ' +
                            '"Unknown"))))))))))';
            for ctr := 0 to SQL.Count-1 do begin
                SQL[ctr] := StringReplace(SQL[ctr] , '[DateFrom]' , QuotedStr(FormatDateTime(MysqlDateFormat ,dtFrom.Date)) , [rfIgnoreCase]);
                SQL[ctr] := StringReplace(SQL[ctr] , '[DateTo]' , QuotedStr(FormatDateTime(MysqlDateFormat ,dtTo.Date)) , [rfIgnoreCase] );
                SQL[ctr] := StringReplace(SQL[ctr] , '[Deposittype]' ,deposittype , [rfIgnoreCase] );
                SQL[ctr] := StringReplace(SQL[ctr] , '[Salestype]' ,SalesType , [rfIgnoreCase] );
                SQL[ctr] := StringReplace(SQL[ctr] , '[PurchaseType]' , PurchaseType , [rfIgnoreCase] );
            end;
            inherited;
        finally
            EnableControls;
        end;
    end;
end;

procedure TAllTransactionGUI.grpFiltersClick(Sender: TObject);
var
    fsOptions :STring;
begin
         if grpFilters.ItemIndex = 0 then FilterString :='Deleted <> ' +quotedStr('T')
    else if grpFilters.ItemIndex = 1 then FilterString :='Deleted = ' +quotedStr('T')
    else FilterString := '';

    if grpOptions.ItemIndex = 0 then fsOptions :=   'Transtype =' +QuotedStr('PurchaseOrder') + ' or ' +
                                                    'Transtype =' +QuotedStr('Return Authority') + ' or ' +
                                                    'Transtype =' +QuotedStr('Bill') + ' or ' +
                                                    'Transtype =' +QuotedStr('Credit') + ' or ' +
                                                    'Transtype =' +QuotedStr('Cheque')
    else if grpOptions.ItemIndex = 1 then fsOptions :=  'Transtype =' +QuotedStr('POS') + ' or ' +
                                                    'Transtype =' +QuotedStr('Refund') + ' or ' +
                                                    'Transtype =' +QuotedStr('CashSale') + ' or ' +
                                                    'Transtype =' +QuotedStr('Invoice') + ' or ' +
                                                    'Transtype =' +QuotedStr('Quote') + ' or ' +
                                                    'Transtype =' +QuotedStr('SalesOrder') + ' or ' +
                                                    'Transtype =' +QuotedStr('Voucher') + ' or ' +
                                                    'Transtype =' +QuotedStr('Layby') + ' or ' +
                                                    'Transtype =' +QuotedStr('Layby-TOS') + ' or ' +
                                                    'Transtype =' +QuotedStr('LaybyPayment')
    else fsOptions := '';

    if fsOptions <> '' then
        if FilterString <> '' then FilterString := '(' + FilterString + ') and (' + fsOptions +')'
        else  FilterString := fsOptions ;
    inherited;
end;
procedure TAllTransactionGUI.grdMainDblClick(Sender: TObject);
begin
    SubsequentID := Chr(95) + qryMain.Fields.FieldByName('TransType').AsString;
    inherited;
end;

procedure TAllTransactionGUI.FormCreate(Sender: TObject);
begin
  inherited;
    SQLList:= TStringList.create;
    SQLList.Text := Qrymain.SQL.text;
end;

procedure TAllTransactionGUI.FormDestroy(Sender: TObject);
begin
    FreeandNil(SQLList);
  inherited;

end;

initialization
  RegisterClassOnce(TAllTransactionGUI);
end.
