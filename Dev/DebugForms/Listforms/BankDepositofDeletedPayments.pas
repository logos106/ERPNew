unit BankDepositofDeletedPayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TBankDepositofDeletedPaymentsGUI = class(TBaseListingGUI)
    qryMainType: TWideStringField;
    qryMainDepositID: TIntegerField;
    qryMainDepositdate: TDateField;
    qryMainClassname: TWideStringField;
    qryMainNotes: TWideStringField;
    qryMainDeposit: TFloatField;
    qryMainReconciled: TWideStringField;
    qryMainCategory: TLargeintField;
    qryMainPaymentID: TIntegerField;
    qryMainCompanyname: TWideStringField;
    qryMainReferenceno: TWideStringField;
    qryMainAmount: TFloatField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses BusObjPayments, tcConst, BusObjBase, CommonDbLib, CommonLib;

{$R *.dfm}

procedure TBankDepositofDeletedPaymentsGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  TitleLabel.caption := 'Un-deleted Bank Deposits of' + NL+
                         'Deleted Supplier Payments';
end;

procedure TBankDepositofDeletedPaymentsGUI.grdMainDblClick(Sender: TObject);
begin
  //inherited;
  if QrymainCategory.asInteger = 1 then begin
    With TSuppPayments.CreateWithNewConn(Self) do try
      Connection.Connection := GetNewMyDacConnection(self);
      Load(qryMainPaymentID.AsInteger);
      if count =0 then exit;
      if not(Deleted) then exit;
      if not(Userlock.Lock(GetBusObjectTablename, qryMainPaymentID.asInteger)) then begin
        MessageDlgXP_Vista(replaceStr(Userlock.lockMessage, 'Unable to update data.' , 'Unable to update Supplier Payment #' + inttostr(qryMainPaymentID.AsInteger)+'.'), mtWarning, [mbOK], 0);
        Exit;
      end;
      try
        connection.BeginTransaction;
        try
           updateBankdeposit(true);
           if not PostList.Execute then begin
              Connection.RollbackTransaction;
              Exit;
           end;
           connection.CommitTransaction;
           RefreshQuery;
           Exit;
        Except
          on E:Exception do begin
            Connection.RollbackTransaction;
          end;
        end;
      finally
        Unlock;
      end;
    finally
      Connection.Free;
      Free;
    end;
  end;


  if QrymainCategory.asInteger = 2 then begin
    With TCustPayments.CreateWithNewConn(Self) do try
      Connection.Connection := GetNewMyDacConnection(self);
      Load(qryMainPaymentID.AsInteger);
      if count =0 then exit;
      if not(Deleted) then exit;
      if not(Userlock.Lock(GetBusObjectTablename, qryMainPaymentID.asInteger)) then begin
        MessageDlgXP_Vista(replaceStr(Userlock.lockMessage, 'Unable to update data.' , 'Unable to update Customer Payment #' + inttostr(qryMainPaymentID.AsInteger)+'.'), mtWarning, [mbOK], 0);
        Exit;
      end;
      try
        connection.BeginTransaction;
        try
           updateBankdeposit(true);
           connection.CommitTransaction;
           RefreshQuery;
           Exit;
        Except
          on E:Exception do begin
            Connection.RollbackTransaction;
          end;
        end;
      finally
        Unlock;
      end;
    finally
      Connection.Free;
      Free;
    end;
  end;
end;

procedure TBankDepositofDeletedPaymentsGUI.RefreshQuery;
begin
  Qrymain.ParamByName('SuppPaytype').AsString := TSuppPayments.GetTranstype;
  //Qrymain.ParamByName('CustPaytype').AsString := TCustPayments.GetTranstype;
  inherited;
end;

procedure TBankDepositofDeletedPaymentsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymaincategory.fieldname);
  RemoveFieldfromGrid(qryMainDepositID.fieldname);
  RemoveFieldfromGrid(qryMainDeposit.fieldname);
end;

initialization
  RegisterClassOnce(TBankDepositofDeletedPaymentsGUI);

end.

