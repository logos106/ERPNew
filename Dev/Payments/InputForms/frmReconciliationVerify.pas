unit frmReconciliationVerify;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ReconciliationForm, ActnList, DB, ProgressDialog, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, SelectionDialog,
  AppEvnts, Menus, ExtCtrls, StdCtrls, DBCtrls, wwcheckbox, Shader,
  wwdbdatetimepicker, wwdblook, Grids, AdvObj, BaseGrid, AdvGrid, Mask,
  wwdbedit, DNMSpeedButton, AdvSplitter, DNMPanel, sgcBase_Classes,
  sgcTCP_Classes, sgcWebSocket_Classes, sgcWebSocket_Classes_Indy,
  sgcWebSocket_Client, sgcWebSocket, CheckLst, AdvPanel;

type
  TfmReconciliationVerify = class(TReconciliationGUI)
    btnVerifyDeletion: TDNMSpeedButton;
    btnVerifySave: TDNMSpeedButton;
    procedure btnVerifyDeletionClick(Sender: TObject);
    procedure btnSaveCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnVerifySaveClick(Sender: TObject);
  private
    Deposittablename:String;
    Withdrawaltablename :String;
    QryDeposit:TErpQuery;
    QryWithdrawal :TErpQuery;
    Procedure MakeActivereclines;
    function AnylineRe_Reconciled(var Msg: String): Boolean;
  public
  end;


implementation

uses CommonLib, AppEnvironment, CommonDbLib, tcConst, frmMessage,
  frmMessageBase, FormFactory;

{$R *.dfm}
procedure TfmReconciliationVerify.btnSaveCloseClick(Sender: TObject);
begin
 if AppEnv.AccessLevels.GetEmployeeAccessLevel('TfmReconciliationReDelete')<>  1 then begin
    MessageDlgXP_vista('You don''t have enough access to ''Verify Deletion''', mtWarning, [mbOK], 0);
    Exit;
 end;


 inherited;
end;
Function TfmReconciliationVerify.AnylineRe_Reconciled(var Msg:String):Boolean;
var
  i:Integer;
begin
  Result := False;
  Deposittablename    := CommonDbLib.GetUserTemporaryTableName('Recon' )+'_deposit';
 Withdrawaltablename := CommonDbLib.GetUserTemporaryTableName('Recon' )+'_Withdraw';
 QryDeposit:= TempMyQuery;
 QryWithdrawal :=TempMyQuery;
 try
    MakeActivereclines;

     with grdDeposits do begin
      for i := 1 to RowCount - 1 do begin
        if Cells[COL_OK, i] = CheckTrue then begin
          if not(QryDeposit.Locate('Notes;depositId;DepositLineId' , varArrayof([Cells[COL_NOTES, i],Cells[COL_PAY_ID, i],Cells[COL_PAY_LineID, i]]), [])) then
          else if  (QryDeposit.fieldbyname('ReconciliationID').AsInteger =0)  then
          else begin
            REsult := True;
            if Msg <> '' then Msg := msg + NL;
            Msg := Msg + QryDeposit.FieldByName('Notes').AsString +' # ' + inttostr(QryDeposit.FieldByName('PaymentId').AsInteger);
            Msg := msg +','+' Rec # ' + inttostr(QryDeposit.FieldByName('ReconciliationID').AsInteger);
            if trim(QryDeposit.FieldByName('ReferenceNo').AsString) <> '' then Msg := msg +'(' +QryDeposit.FieldByName('ReferenceNo').AsString+')';

          end;
        end;
      end;
     end;

     with grdWithdrawals do begin
      for i := 1 to RowCount - 1 do begin
        if Cells[COL_OK, i] = CheckTrue then begin
          if not(QryWithdrawal.Locate('Notes;depositId;DepositLineId' , varArrayof([Cells[COL_NOTES, i],Cells[COL_PAY_ID, i],Cells[COL_PAY_LineID, i]]), [])) then
          else if  (QryWithdrawal.fieldbyname('ReconciliationID').AsInteger =0)  then
          else begin
            REsult := True;
            if Msg <> '' then Msg := msg + NL;
            Msg := Msg + QryWithdrawal.FieldByName('Notes').AsString +' # ' + inttostr(QryWithdrawal.FieldByName('PaymentId').AsInteger);
            Msg := msg+',' +' Rec # ' + inttostr(QryWithdrawal.FieldByName('ReconciliationID').AsInteger);
            if trim(QryWithdrawal.FieldByName('ReferenceNo').AsString) <> '' then Msg := msg +'(' +QryWithdrawal.FieldByName('ReferenceNo').AsString+')';
          end;
        end;
      end;
     end;


 finally
   FreeandNil(QryDeposit);
   FreeandNil(QryWithdrawal);
 end;
end;
procedure TfmReconciliationVerify.btnVerifyDeletionClick(Sender: TObject);
var
  Msg:String;
begin
  inherited;

  if MessageDlgXP_Vista('This will force flagging all the transactions selected here as ''NOT RECONCILED''.'+NL+
                        'It will happen only if none of these are NOT reconciled afterwards.'+Nl+NL+
                        'Do you want to continue? ', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;

  if not WasDeleted then begin
    MessageDlgXP_vista('This reconciliation record was not deleted. You cannot re-delete it', mtWarning, [mbOK], 0);
    Exit;
  end;
  if not qryReconsDeleted.asBoolean then begin
    MessageDlgXP_vista('This reconciliation record is not deleted. You cannot re-delete it', mtWarning, [mbOK], 0);
    Exit;
  end;

  if AnylineRe_Reconciled(Msg) then begin
      InitMsgParams;
      PopupMsgParams.Msgcaption    :='Reconciliation Deletion Verify';
      PopupMsgParams.MsgText       := Msg;
      PopupMsgParams.Custombuttons :='"Ok"' ;
      PopupMsgParams.Msg1          :='The Following Transactions are already reconciled after deleting this Reconciliation';
      PopupMsgParams.Msg2          :='It is not possible to verify deletion on this record again.';
      PopupMsgParams.MsgHeight     :=250;
      TfmMessage.MsgDlg;
    Exit;
  end;
  WasDeleted := False;
  btnSaveClose.click;
end;

procedure TfmReconciliationVerify.btnVerifySaveClick(Sender: TObject);
begin
  inherited;

  if MessageDlgXP_Vista('This will force flagging all the transactions selected here as ''RECONCILED''.'+NL+
                        'Do you want to continue? ', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;

  if WasDeleted then begin
    MessageDlgXP_vista('This reconciliation record was alredy deleted. You cannot Verify Save', mtWarning, [mbOK], 0);
    Exit;
  end;
  btnSaveClose.click;

end;

procedure TfmReconciliationVerify.FormShow(Sender: TObject);
begin
  inherited;
  btnVerifyDeletion.visible :=  qryReconsDeleted.AsBoolean;
  btnVerifySave.visible      :=  qryReconsFinished.AsBoolean and not(qryReconsDeleted.AsBoolean);
end;

Procedure TfmReconciliationVerify.MakeActivereclines;
begin
 With TempMyScript do try
    SQl.add('Drop table if exists ' + Deposittablename+';');
    SQl.add('Create table ' + Deposittablename);
    //SQL.add(LoadDepositQry(False, False)+';');
    SQL.add(ReconciliationObj.GuiDepositLines.SQL+';');
    SQl.add('Drop table if exists ' + Withdrawaltablename+';');
    SQl.add('Create table ' + Withdrawaltablename);
    //SQL.add(LoadWithdrawalQry(False, False)+';');
    SQL.add(ReconciliationObj.GuiWithdrawLines.SQL+';');
    SQL.text := replacestr(SQl.text , ':xAccountID' , inttostr(qryReconsAccountID.AsInteger));
    Execute;
 finally
    Free;
 end;
 QryDeposit.SQL.Text    :=  'Select T.*  , R.ReconciliationID  '+
                            ' from '+ Deposittablename +'  T '+
                            '  Left join (tblreconciliationdepositlines RDL inner join tblreconciliation R on R.ReconciliationID = RDL.ReconciliationID  and R.deleted ="F")   '+
                            '  on T.depositId = RDL.PaymentID and T.depositLineId = RDL.DepositLineID and T.Notes = RDL.Notes '+
                            '  /*where  (ifnull(R.ReconciliationID,0) = 0  or ifnull(R.deleted ,"F")="F" )*/';


 QryWithdrawal.SQL.Text :=  'Select T.*  , R.ReconciliationID '+
                            ' from '+ Withdrawaltablename +'  T '+
                            '  Left join (tblreconciliationwithdrawallines RWL inner join tblreconciliation R on R.ReconciliationID = RWL.ReconciliationID   and R.deleted ="F")   '+
                            '  on T.depositId = RWL.PaymentID and T.depositLineId = RWL.DepositLineID and T.Notes = RWL.Notes '+
                            '  /*where  (ifnull(R.ReconciliationID,0)=0 or ifnull(R.deleted ,"F")="F" )*/'+
                            '';
 QryDeposit.open;
 QryWithdrawal.open;
end;
initialization
  RegisterClassOnce(TfmReconciliationVerify);
  with FormFact do begin
    RegisterMe(TfmReconciliationVerify, 'TReconListGUI_*=ReconciliationID');
    RegisterMe(TfmReconciliationVerify, 'TTransRecListGUI_*=ReconciliationID');
  end;

end.
