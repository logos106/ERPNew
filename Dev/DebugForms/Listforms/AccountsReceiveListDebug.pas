unit AccountsReceiveListDebug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AccountsReceiveListForm, Wwdbgrid, DAScript, MyScript,
  ERPdbComponents, DB, SelectionDialog, kbmMemTable, CustomInputBox, Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, wwDialog, Wwlocate,
  ExtCtrls, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons,
  Wwdbigrd, Grids, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton,
  Shader, DNMPanel, busobjsales, busobjbase, wwclearbuttongroup, wwradiogroup,
  GIFImg;

type
  TAccountsReceiveListDebugGUI = class(TAccountsReceiveListGUI)
    btnFix: TDNMSpeedButton;
    procedure btnFixClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
  end;


implementation

uses CommonLib, LogLib, tcConst, AppDatabase, math, DebugLib, CommonDbLib,
ERPVersionConst;

{$R *.dfm}

procedure TAccountsReceiveListDebugGUI.btnFixClick(Sender: TObject);
var
  s:String;
begin
  inherited;
  if MessageDlgXP_Vista('All Invoices in this list will be recalculated to ' + quotedstr(btnFix.Caption)+'.'+NL+NL+
                    'The Invoice total will be recalculated by '+ NL+'Rounding Line Totals and the difference will be adjusted  '+ NL+'with a Product ' + quotedstr(PART_MEMO)+'.', mtconfirmation , [mbyes,mbno], 0)  = mrno then exit;

  s:= DoBackuptables(['tblsales' ,'tblsaleslines'] ,'', False);
  DoshowProgressbar(Qrymain.RecordCount+1, '');
  try
    if s<> '' then executeSQL(s);
    DoStepProgressbar;
    clog('');
    iterateprocno := 1;
    iteraterecords;
  finally
    DoHideProgressbar;
  end;

end;

procedure TAccountsReceiveListDebugGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Wheresql :='(AR.AmountDue <= 0.04 and AR.AmountDue >= 0-0.04) ';
end;

procedure TAccountsReceiveListDebugGUI.FormShow(Sender: TObject);
begin
  inherited;
  highlightcontrol(btnFix);
  Timermsg(lblDateComments ,'Filter the list for the records to be fixed and Choose ' + quotedstr(btnFix.Caption)+' to fix the rounding issue.');
end;

procedure TAccountsReceiveListDebugGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
var
  fdAmt1, fdamtinc1, fdTax1:Double;
  fdAmt2, fdamtinc2, fdTax2:Double;
  inv :TInvoice;
begin
  inherited;
  if iterateprocno = 1 then begin

      if QrymainSaleId.AsInteger=0 then exit;
      if QrymainDetails.AsInteger<> 2 then exit;
      if not(sametext(Qrymaintype.AsString , 'Invoice')) then exit;
      DoStepProgressbar('Invoice # ' + inttostr(QrymainSaleId.AsInteger) );

      inv := TInvoice.CreateWithNewConn(self);
      try
        inv.Load(QrymainSaleId.AsInteger);
        if inv.count =0 then exit;
        inv.connection.BeginTransaction;
        try
          if Inv.Lines.Count = 0 then exit;

                    fdAmt1:= Inv.TotalAmount;
                    fdamtinc1:= Inv.totalAmountinc;
                    fdTax1:= Inv.TotalTax;
                    Inv.CalcAllLineTotals;
                    Inv.CalcOrderTotals;
                    fdAmt2:= Inv.TotalAmount;
                    fdamtinc2:= Inv.totalAmountinc;
                    fdTax2:= Inv.TotalTax;
                    if  not(samevalue(fdAmt1, fdAmt2, 0)) or
                        not(samevalue(fdamtinc1 , fdamtinc2, 0)) or
                        not(samevalue(fdTax1, fdTax2, 0)) then begin


                        Inv.Lines.New;
                        Inv.Lines.ProductName:= PART_MEMO;
                        Inv.Lines.ProductDescription  := 'Round fix :' + TABLE_VERSION;
                        Inv.Lines.QtySold    := 1;
                        Inv.Lines.QtyShipped := 1;
                        Inv.Lines.LinePrice           := 0;
                        Inv.Lines.LinePriceinc        := 0;
                        Inv.Lines.PostDB;
                        Inv.Lines.DoFieldChange := False;
                        try
                          Inv.Lines.TotalLineAmount     := fdAmt1- fdAmt2;
                          Inv.Lines.TotalLineAmountinc  := fdamtinc1 - fdamtinc2;
                          Inv.Lines.LineTaxTotal        := fdTax1- fdTax2;
                          Inv.Lines.LinePrice           := divzer(Inv.Lines.TotalLineAmount  , Inv.Lines.QtyShipped);
                          Inv.Lines.LinePriceinc        := divzer(Inv.Lines.TotalLineAmountinc , Inv.Lines.QtyShipped);
                          Inv.Lines.PostDB;
                          Logtext('2,'+inttostr(Inv.Lines.ID)+','+floattostr(Inv.Lines.LinePrice)+','+floattostr(Inv.Lines.LinePriceinc)+','+floattostr(Inv.Lines.LineTaxTotal)+','+floattostr(Inv.Lines.totallineamount)+','+floattostr(Inv.Lines.TotalLineAmountInc)+',' +
                                floattostr(divzer(Inv.TotalAmount , Inv.Lines.QtyShipped))+',' +
                                floattostr(divzer(Inv.TotalAmountinc , Inv.Lines.QtyShipped))+ ',' +
                                floattostr(fdTax1- Inv.TotalTax)+ ',' +
                                floattostr(fdAmt1- Inv.TotalAmount)+',' +
                                floattostr(fdamtinc1 - Inv.TotalAmountinc));
                        finally
                          Inv.Lines.DoFieldChange := True;
                          Inv.CalcOrderTotals;
                        end;
                    end;
                    inv.connection.CommitTransaction;
        Except
          on E:Exception do begin
            inv.connection.RollbackTransaction;
          end;
        end;
      finally
        FreeandNil(Inv);
      end;
  end;
end;

initialization
  RegisterClassOnce(TAccountsReceiveListDebugGUI);

end.
