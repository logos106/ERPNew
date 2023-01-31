unit ContactList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, BaseTransForm, Generics.Collections,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TContactListGUI = class(TBaseListingGUI)
    qryMainContactID: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainContactTitle: TWideStringField;
    qryMainContactFirstName: TWideStringField;
    qryMainContactSurName: TWideStringField;
    qryMainContactAddress: TWideStringField;
    qryMainContactAddress2: TWideStringField;
    qryMainContactAddress3: TWideStringField;
    qryMainContactCity: TWideStringField;
    qryMainContactState: TWideStringField;
    qryMainContactPcode: TWideStringField;
    qryMainContactCountry: TWideStringField;
    qryMainContactPH: TWideStringField;
    qryMainContactAltPH: TWideStringField;
    qryMainContactMOB: TWideStringField;
    qryMainContactFax: TWideStringField;
    qryMainContactEmail: TWideStringField;
    qryMainNotes: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainCardNumber: TWideStringField;
    qryMainAccountNo: TWideStringField;
    qryMainJobTitle: TWideStringField;
    qryMainUseOnRun: TWideStringField;
    qryMainLogMeInComputerIPAddress: TWideStringField;
    qryMainLogMeInEmailPassword: TWideStringField;
    qryMainLogMeInUserName: TWideStringField;
    qryMainLogMeInPassword: TWideStringField;
    qryMainLogMeInERPUserName: TWideStringField;
    qryMainLogMeInERPPassword: TWideStringField;
    qryMainLogMeIncomputerPassword: TWideStringField;
    qryMainIsPrimarycontact: TWideStringField;
    qryMainClientName: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainContactIsCustomer: TWideStringField;
    qryMainContactIsSupplier: TWideStringField;
    qryMainContactIsOtherContact: TWideStringField;
    qryMainContactIsJob: TWideStringField;
    qryMainDoNotContact: TWideStringField;
    btnEmail: TDNMSpeedButton;
    qryMainMainContactforCashSale: TWideStringField;
    qryMainMainContactforVoucher: TWideStringField;
    qryMainMainContactforPOS: TWideStringField;
    qryMainMainContactforRefund: TWideStringField;
    qryMainMainContactforInvoice: TWideStringField;
    qryMainMainContactforSalesOrder: TWideStringField;
    qryMainMainContactforQuote: TWideStringField;
    qryMainMainContactforCheque: TWideStringField;
    qryMainMainContactforCredit: TWideStringField;
    qryMainMainContactforBill: TWideStringField;
    qryMainMainContactforPO: TWideStringField;
    qryMainMainContactforRA: TWideStringField;
    qryMainMainContactforRepair: TWideStringField;
    qryMainMainContactforStatements: TWideStringField;
    qryMainMainContactForSupplierPayment: TWideStringField;
    qryMainNotaMainContact: TWideStringField;
    procedure grdMainDblClick(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnEmailClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ficlientID :Integer;
    fCaller: TBaseTransGUI;
    fAcceptableList: TDictionary<string, string>;
    procedure beforeaddContact(Sender: TObject);
    procedure SetCaller(const Value: TBaseTransGUI);
    function MaincontactType(fldname: String): String;
    property AcceptableList : TDictionary<string,string> read fAcceptableList write fAcceptableList;
    Procedure InitListForCaller;
  Protected
    Procedure SetGridColumns;Override;

  public
    Property ClientID :Integer read fiClientID write ficlientID;
    Procedure RefreshQuery;Override;
    property Caller : TBaseTransGUI read fCaller write SetCaller;
  end;

implementation

uses CommonLib, CommonFormLib, frmContactFrm, EmailExtraUtils, tcConst,
  tcDataUtils;

{$R *.dfm}
{ TBaseListingGUI1 }

procedure TContactListGUI.RefreshQuery;
begin
  Qrymain.ParamByName('clientID').AsInteger := ClientID;
  if SameText(qryMain.SQL[qryMain.SQL.Count-1], 'LIMIT 0') then
    qryMain.SQL[qryMain.SQL.Count-1] := '';
  inherited;

end;

procedure TContactListGUI.SetCaller(const Value: TBaseTransGUI);
begin
  fCaller := Value;
  if not assigned(Value) then
    exit;

  if not AcceptableList.ContainsKey(Value.ClassName) then
  begin
    fCaller := nil;
    exit;
  end;

  btnEmail.Enabled := true;
  grdMain.Options := grdMain.Options + [dgMultiSelect];
end;

procedure TContactListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ClientID');
  RemoveFieldfromGrid('EmployeeID');
  RemoveFieldfromGrid('ContactId');
end;
Function TContactListGUI.MaincontactType(fldname:String):String;
begin
         if sametext(fldname , 'MainContactforCashSale'         ) then Result := 'Cash Sale Main Contact'
    else if sametext(fldname , 'CN.MainContactforVoucher'       ) then Result := 'Voucher Main Contact'
    else if sametext(fldname , 'MainContactforPOS'              ) then Result := 'POS Main Contact'
    else if sametext(fldname , 'MainContactforRefund'           ) then Result := 'Refund Main Contact'
    else if sametext(fldname , 'MainContactforInvoice'          ) then Result := 'Invoice Main Contact'
    else if sametext(fldname , 'MainContactforSalesOrder'       ) then Result := 'Sales Order Main Contact'
    else if sametext(fldname , 'MainContactforQuote'            ) then Result := 'Quote Main Contact'
    else if sametext(fldname , 'MainContactforCheque'           ) then Result := 'Cheque Main Contact'
    else if sametext(fldname , 'MainContactforCredit'           ) then Result := 'Credit Main Contact'
    else if sametext(fldname , 'MainContactforBill'             ) then Result := 'Bill Main Contact'
    else if sametext(fldname , 'MainContactforPO'               ) then Result := 'Purchase Order Main Contact'
    else if sametext(fldname , 'MainContactforRA'               ) then Result := 'Return Authority Main Contact'
    else if sametext(fldname , 'MainContactforRepair'           ) then Result := 'Repair Main Contact'
    else if sametext(fldname , 'MainContactforStatements'       ) then Result := 'Statements Main Contact'
    else if sametext(fldname , 'MainContactForSupplierPayment'  ) then Result := 'Supplier Payments Main Contact'
    else Result := '';

end;
procedure TContactListGUI.InitListForCaller;
var
  s :String;
  Function clientname:String;
  begin
    result := '';
    if ClientID <> 0 then result :=  ' of ' + getClientName(ClientID);
  end;
begin
  s:= '';
  if assigned(Caller) and AcceptableList.TryGetValue(Caller.ClassName, s) then s:= MaincontactType(s);
  if s <> '' then s := quotedstr(s)+' and ' + quotedstr('Primary Contact') + clientname +' are '
  else s := quotedstr('Primary Contact') +clientname + ' is ';
  s:= s + ' Highlighted in the List';
  ListTimerMsg(s, nil, 30);
  if assigned(Caller) and AcceptableList.TryGetValue(Caller.ClassName, s) then begin
    (*RemoveFieldfromGrid(qrymainMainContactforCashSale.FieldName       );
    RemoveFieldfromGrid(qrymainMainContactforVoucher.FieldName        );
    RemoveFieldfromGrid(qrymainMainContactforPOS.FieldName            );
    RemoveFieldfromGrid(qrymainMainContactforRefund.FieldName         );
    RemoveFieldfromGrid(qrymainMainContactforInvoice.FieldName        );
    RemoveFieldfromGrid(qrymainMainContactforSalesOrder.FieldName     );
    RemoveFieldfromGrid(qrymainMainContactforQuote.FieldName          );
    RemoveFieldfromGrid(qrymainMainContactforCheque.FieldName         );
    RemoveFieldfromGrid(qrymainMainContactforCredit.FieldName         );
    RemoveFieldfromGrid(qrymainMainContactforBill.FieldName           );
    RemoveFieldfromGrid(qrymainMainContactforPO.FieldName             );
    RemoveFieldfromGrid(qrymainMainContactforRA.FieldName             );
    RemoveFieldfromGrid(qrymainMainContactforRepair.FieldName         );
    RemoveFieldfromGrid(qrymainMainContactforStatements.FieldName     );
    RemoveFieldfromGrid(qrymainMainContactForSupplierPayment.FieldName);*)

             if sametext(s , qrymainMainContactforCashSale.FieldName)        then begin AddFieldtoGrid(qrymainMainContactforCashSale.Fieldname       );qrymainMainContactforCashSale.index       := qryMainIsPrimarycontact.Index;
    end else if sametext(s , qrymainMainContactforVoucher.FieldName)         then begin AddFieldtoGrid(qrymainMainContactforVoucher.Fieldname        );qrymainMainContactforVoucher.index        := qryMainIsPrimarycontact.Index;
    end else if sametext(s , qrymainMainContactforPOS.FieldName)             then begin AddFieldtoGrid(qrymainMainContactforPOS.Fieldname            );qrymainMainContactforPOS.index            := qryMainIsPrimarycontact.Index;
    end else if sametext(s , qrymainMainContactforRefund.FieldName)          then begin AddFieldtoGrid(qrymainMainContactforRefund.Fieldname         );qrymainMainContactforRefund.index         := qryMainIsPrimarycontact.Index;
    end else if sametext(s , qrymainMainContactforInvoice.FieldName)         then begin AddFieldtoGrid(qrymainMainContactforInvoice.Fieldname        );qrymainMainContactforInvoice.index        := qryMainIsPrimarycontact.Index;
    end else if sametext(s , qrymainMainContactforSalesOrder.FieldName)      then begin AddFieldtoGrid(qrymainMainContactforSalesOrder.Fieldname     );qrymainMainContactforSalesOrder.index     := qryMainIsPrimarycontact.Index;
    end else if sametext(s , qrymainMainContactforQuote.FieldName)           then begin AddFieldtoGrid(qrymainMainContactforQuote.Fieldname          );qrymainMainContactforQuote.index          := qryMainIsPrimarycontact.Index;
    end else if sametext(s , qrymainMainContactforCheque.FieldName)          then begin AddFieldtoGrid(qrymainMainContactforCheque.Fieldname         );qrymainMainContactforCheque.index         := qryMainIsPrimarycontact.Index;
    end else if sametext(s , qrymainMainContactforCredit.FieldName)          then begin AddFieldtoGrid(qrymainMainContactforCredit.Fieldname         );qrymainMainContactforCredit.index         := qryMainIsPrimarycontact.Index;
    end else if sametext(s , qrymainMainContactforBill.FieldName)            then begin AddFieldtoGrid(qrymainMainContactforBill.Fieldname           );qrymainMainContactforBill.index           := qryMainIsPrimarycontact.Index;
    end else if sametext(s , qrymainMainContactforPO.FieldName)              then begin AddFieldtoGrid(qrymainMainContactforPO.Fieldname             );qrymainMainContactforPO.index             := qryMainIsPrimarycontact.Index;
    end else if sametext(s , qrymainMainContactforRA.FieldName)              then begin AddFieldtoGrid(qrymainMainContactforRA.Fieldname             );qrymainMainContactforRA.index             := qryMainIsPrimarycontact.Index;
    end else if sametext(s , qrymainMainContactforRepair.FieldName)          then begin AddFieldtoGrid(qrymainMainContactforRepair.Fieldname         );qrymainMainContactforRepair.index         := qryMainIsPrimarycontact.Index;
    end else if sametext(s , qrymainMainContactforStatements.FieldName)      then begin AddFieldtoGrid(qrymainMainContactforStatements.Fieldname     );qrymainMainContactforStatements.index     := qryMainIsPrimarycontact.Index;
    end else if sametext(s , qrymainMainContactForSupplierPayment.FieldName) then begin AddFieldtoGrid(qrymainMainContactForSupplierPayment.Fieldname);qrymainMainContactForSupplierPayment.index:= qryMainIsPrimarycontact.Index;
    end;

    AddFieldtoGrid(qrymainISPrimarycontact.Fieldname);
  end;

end;

procedure TContactListGUI.btnEmailClick(Sender: TObject);
var
  Count,
  idx : integer;
  s : string;
  lSilent, lSecret : boolean;
begin
//
  if grdMain.SelectedList.Count = 0 then
  begin
    MessageDlgXP_Vista('You Have Not Selected Contacts To Send Email To', mtInformation, [mbOk], 0);
    exit;
  end;
  s := '';
  Count := 0;
  for idx := 0 to grdMain.SelectedList.Count - 1 do
  begin
    qryMain.GotoBookmark(grdMain.SelectedList[idx]);
    if qryMainContactEmail.AsString <> '' then
    begin
      if s = '' then
        s := qryMainContactEmail.AsString
      else
        s := s + ';' + qryMainContactEmail.AsString;
      Count := Count + 1;
    end;
  end;

  if Count = 0 then
  begin
    MessageDlgXP_Vista('Selected Contacts Do Not Have Email Addresses.'#13#10'Cannot Send Email', mtInformation, [mbOk], 0);
    exit;
  end;

  if Count <> grdMain.SelectedList.Count then
  begin
    if MessageDlgXP_Vista('Only ' + IntToStr(Count) + ' Contacts from ' + IntToStr(grdMain.SelectedList.Count) +
                          ' Selected Have Email Addresses.'#13#10'Do You Wish To Send Emails To Those Contacts?',
                          mtInformation, [mbYes, mbNo], 0) = mrNo then
      exit;
  end;

  if not EmailSilentSecret(Count, False, lSilent, lSecret) then
    exit;
  Caller.SendEmailCallback(s, lSilent, lSecret);
  grdmain.unselectall;
  Qrymain.first;
  Setcontrolfocus(grdmain);
end;

procedure TContactListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TfrmContact' , 0 , beforeaddContact);
  RefreshQuery;
end;
procedure TContactListGUI.beforeaddContact(Sender: TObject);
begin
  if not (Sender is  TfrmContact) then exit;
  TfrmContact(Sender).ClientId := clientID;
end;

procedure TContactListGUI.FormCreate(Sender: TObject);
begin
  ClientID:= 0;

  inherited;

  AcceptableList := TDictionary<String,String>.Create;
  AcceptableList.Add('TInvoiceGUI'      , 'MainContactForInvoice');
  AcceptableList.Add('TSalesOrderGUI'   , 'MainContactForSalesOrder');
  AcceptableList.Add('TQuoteGUI'        , 'MainContactForQuote');
  AcceptableList.Add('TPurchaseGUI'     , 'MainContactforPO');
  AcceptableList.Add('TReturnAGUI'      , 'MainContactforRA');
  AcceptableList.Add('TRefundGUI'       , 'MainContactforRefund');
  SearchMode := smFullList;
end;

procedure TContactListGUI.FormDestroy(Sender: TObject);
begin
  AcceptableList.Free;
  inherited;

end;

procedure TContactListGUI.FormShow(Sender: TObject);
begin
  inherited;
  cmdNew.Enabled := clientID<>0;
  InitListForCaller;
end;

procedure TContactListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
var
  lFieldName : string;
begin
  inherited;
  if qryMainIsPrimaryContact.AsBoolean then
    ABrush.Color := GridColhighLightGreen
  else  begin if assigned(Caller) and AcceptableList.TryGetValue(Caller.ClassName, lFieldName) then
      if qryMain.FieldByName(lFieldName).asBoolean then
        ABrush.Color := GridColhighLightGreen;
  end;

//
end;

procedure TContactListGUI.grdMainDblClick(Sender: TObject);
begin
         if qryMainContactIsCustomer.asboolean      then SubsequentID := Chr(95) + 'Customer'
    else if qryMainContactIsJob.asboolean           then SubsequentID := Chr(95) + 'Job'
    else if qryMainContactIsSupplier.asboolean      then SubsequentID := Chr(95) + 'Supplier'
    else if qryMainContactIsOtherContact.asboolean  then SubsequentID := Chr(95) + 'Other Contact';
  inherited;
end;

initialization
  RegisterClassOnce(TContactListGUI);

end.
