unit AccountsPayListFormDebug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AccountsPayListForm, Wwdbgrid, DAScript, MyScript, ERPdbComponents,
  DB, SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls,
  ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd,
  Grids, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TAccountsPayListFormDebugGUI = class(TAccountsPayListGUI)
    btnfix1: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnfixClick(Sender: TObject);
  private
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
  end;


implementation

uses CommonLib, tcConst, DebugLib, CommonDbLib, LogLib, busobjOrders, math,
  AppDatabase, ERPVersionConst;

{$R *.dfm}

procedure TAccountsPayListFormDebugGUI.btnfixClick(Sender: TObject);
var
  s:String;
begin
  inherited;
  if MessageDlgXP_Vista('All POs in this list will be recalculated to ' + quotedstr(btnFix.Caption)+'.'+NL+NL+
                    'The PO total will be recalculated by '+ NL+'Rounding Line Totals and the difference will be adjusted  '+ NL+'with a Product ' + quotedstr(PART_MEMO)+'.', mtconfirmation , [mbyes,mbno], 0)  = mrno then exit;

  s:= DoBackuptables(['tblpurchaselines' ,'tblpurchaseorders'] ,'', False);
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

procedure TAccountsPayListFormDebugGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Wheresql :='(TT.AmountDue <= 0.04 and TT.AmountDue >= 0-0.04) ';
end;

procedure TAccountsPayListFormDebugGUI.FormShow(Sender: TObject);
begin
  inherited;
  highlightcontrol(btnfix1);
  Timermsg(lblDateComments ,'Filter the list for the records to be fixed and Choose ' + quotedstr(btnfix1.Caption)+' to fix the rounding issue.');
end;

procedure TAccountsPayListFormDebugGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
var
  fdAmt1, fdamtinc1, fdTax1:Double;
  fdAmt2, fdamtinc2, fdTax2:Double;
  PO :TPurchaseOrder;
begin
  inherited;
  if iterateprocno = 1 then begin

      if qryMainPurchaseOrderID.AsInteger=0 then exit;
      if QrymainDetails.AsInteger<> 2 then exit;
      if not(sametext(Qrymaintype.AsString , 'Invoice')) then exit;
      DoStepProgressbar('Invoice # ' + inttostr(qryMainPurchaseOrderID.AsInteger) );

      PO := TPurchaseOrder.CreateWithNewConn(self);
      try
        PO.Load(qryMainPurchaseOrderID.AsInteger);
        if PO.count =0 then exit;
        PO.connection.BeginTransaction;
        try
          if PO.Lines.Count = 0 then exit;

                    fdAmt1:= PO.TotalAmount;
                    fdamtinc1:= PO.totalAmountinc;
                    fdTax1:= PO.TotalTax;
                    PO.CalcAllLineTotals;
                    PO.CalcOrderTotals;
                    fdAmt2:= PO.TotalAmount;
                    fdamtinc2:= PO.totalAmountinc;
                    fdTax2:= PO.TotalTax;
                    if  not(samevalue(fdAmt1, fdAmt2, 0)) or
                        not(samevalue(fdamtinc1 , fdamtinc2, 0)) or
                        not(samevalue(fdTax1, fdTax2, 0)) then begin


                        PO.Lines.New;
                        PO.Lines.ProductName:= PART_MEMO;
                        PO.Lines.ProductDescription  := 'Round fix :' + TABLE_VERSION;
                        PO.Lines.QtySold    := 1;
                        PO.Lines.QtyShipped := 1;
                        PO.Lines.LineCost           := 0;
                        PO.Lines.LineCostinc        := 0;
                        PO.Lines.PostDB;
                        PO.Lines.DoFieldChange := False;
                        try
                          PO.Lines.TotalLineAmount     := fdAmt1- fdAmt2;
                          PO.Lines.TotalLineAmountinc  := fdamtinc1 - fdamtinc2;
                          PO.Lines.LineTaxTotal        := fdTax1- fdTax2;
                          PO.Lines.LineCost           := divzer(PO.Lines.TotalLineAmount  , PO.Lines.QtyShipped);
                          PO.Lines.LineCostinc        := divzer(PO.Lines.TotalLineAmountinc , PO.Lines.QtyShipped);
                          PO.Lines.PostDB;
                          Logtext('2,'+inttostr(PO.Lines.ID)+','+floattostr(PO.Lines.LineCost)+','+floattostr(PO.Lines.LineCostinc)+','+floattostr(PO.Lines.LineTaxTotal)+','+floattostr(PO.Lines.totallineamount)+','+floattostr(PO.Lines.TotalLineAmountInc)+',' +
                                floattostr(divzer(PO.TotalAmount , PO.Lines.QtyShipped))+',' +
                                floattostr(divzer(PO.TotalAmountinc , PO.Lines.QtyShipped))+ ',' +
                                floattostr(fdTax1- PO.TotalTax)+ ',' +
                                floattostr(fdAmt1- PO.TotalAmount)+',' +
                                floattostr(fdamtinc1 - PO.TotalAmountinc));
                        finally
                          PO.Lines.DoFieldChange := True;
                          PO.CalcOrderTotals;
                        end;
                    end;
                    PO.connection.CommitTransaction;
        Except
          on E:Exception do begin
            PO.connection.RollbackTransaction;
          end;
        end;
      finally
        FreeandNil(PO);
      end;
  end;end;
initialization
  RegisterClassOnce(TAccountsPayListFormDebugGUI);

end.
