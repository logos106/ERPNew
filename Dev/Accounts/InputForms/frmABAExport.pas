Unit frmABAExport;

{

  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  ??/??/?? 1.00.01  ???  Initial Version
  19/12/05 1.00.02  AL   Removed "Instance",   *Task306*
}
Interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB, Wwdbdatetimepicker, StdCtrls, DBCtrls, Mask, Buttons,
  DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ExtCtrls, DNMPanel, Wwdblook, ActnList, ActnMan, DBAccess, MyAccess, ERPdbComponents, DataState, Wwcheckbox, ImgList, Menus, AdvMenus, MemDS, Shader,
  PlatformDefaultStyleActnCtrls, ProgressDialog;

Type
  TfrmABAExportGUI = Class(
    TBaseInputGUI)
    PnlDetail: TDNMPanel;
    GrdTransactions: TwwDBGrid;
    BtnDelete: TwwIButton;
    PnlHeader: TDNMPanel;
    BtnCompleted: TDNMSpeedButton;
    BtnClose: TDNMSpeedButton;
    TblMaster: TERPQuery;
    TblDetails: TERPQuery;
    DSMaster: TDataSource;
    DSDetails: TDataSource;
    TblMasterDescriptiveRecordID: TAutoIncField;
    TblMasterRecordType: TWideStringField;
    TblMasterBlank1: TWideStringField;
    TblMasterReelSequenceNumber: TWideStringField;
    TblMasterUserBankName: TWideStringField;
    TblMasterBlank2: TWideStringField;
    TblMasterDirectEntryUserName: TWideStringField;
    TblMasterDirectEntryUserID: TWideStringField;
    TblMasterTransactionDescription: TWideStringField;
    TblMasterProcessingIndicator: TWideStringField;
    TblMasterBlank3: TWideStringField;
    Label1: TLabel;
    LblUser: TLabel;
    Label3: TLabel;
    UserID: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    WwDBDateTimePicker1: TwwDBDateTimePicker;
    CboBankCode: TwwDBLookupCombo;
    TblDetailsDetailRecordID: TAutoIncField;
    TblDetailsDescriptiveRecordID: TIntegerField;
    TblDetailsRecordType: TWideStringField;
    TblDetailsBSB: TWideStringField;
    TblDetailsCreditDebitAccountNumber: TWideStringField;
    TblDetailsIndicator: TWideStringField;
    TblDetailsTransactionCode: TWideStringField;
    TblDetailsAccountName: TWideStringField;
    TblDetailsLodgementReferences: TWideStringField;
    TblDetailsUsersBSB: TWideStringField;
    TblDetailsUsersAccountNumber: TWideStringField;
    TblDetailsNameofRemitter: TWideStringField;
    TblDetailsAmountOfWithholdingTax: TWideStringField;
    TblDetailsAmount: TFloatField;
    QryBankCodes: TERPQuery;
    TblMasterProcessingDate: TDateField;
    QryTransDescription: TERPQuery;
    CboAccountQry: TERPQuery;
    LblAccount: TLabel;
    CboAccount: TwwDBLookupCombo;
    TblDetailsApply: TWideStringField;
    TblMasterAccountID: TIntegerField;
    CboTransactionCode: TwwDBLookupCombo;
    QryTransCodes: TERPQuery;
    CboTransDesc: TwwDBLookupCombo;
    BtnOptions: TDNMSpeedButton;
    TblMasterIncludeBalanceRecord: TWideStringField;
    TblMasterIncludeNetTotal: TWideStringField;
    TblMasterIncludeCreditTotal: TWideStringField;
    TblMasterIncludeDebitTotal: TWideStringField;
    TblDetailsAccountID: TIntegerField;
    TblDetailsTransType: TWideStringField;
    TblDetailsTransID: TIntegerField;
    TblDetailsTransCodeDesc: TWideStringField;
    PnlFooter: TDNMPanel;
    CboComments_Label: TLabel;
    BtnSelectAll: TDNMSpeedButton;
    ActionManager1: TActionManager;
    ActSelectAll: TAction;
    ImgPopup: TImageList;
    PnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    EdtUserName: TEdit;
    lblMsg: TLabel;
    Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    Procedure FormShow(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure BtnCloseClick(Sender: TObject);
    Procedure TblMasterAccountIDChange(Sender: TField);
    Procedure BtnCompletedClick(Sender: TObject);
    Procedure TblDetailsApplyChange(Sender: TField);
    Procedure CboAccountChange(Sender: TObject);
    Procedure BtnDeleteClick(Sender: TObject);
    Procedure GrdTransactionsExit(Sender: TObject);
    Procedure CboTransDescNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: Boolean);
    Procedure BtnOptionsClick(Sender: TObject);
    Procedure TblDetailsTransCodeDescChange(Sender: TField);
    Procedure BtnSelectAllClick(Sender: TObject);
    Procedure ActSelectAllUpdate(Sender: TObject);
    Procedure GrdTransactionsCalcTitleImage(Sender: TObject; Field: TField; Var TitleImageAttributes: TwwTitleImageAttributes);
    Procedure GrdTransactionsTitleButtonClick(Sender: TObject; AFieldName: String);
    Procedure GrdTransactionsCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryBankCodesBeforeOpen(DataSet: TDataSet);
    procedure cboBankCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
  Private
    { Private declarations }
    ExportFileMode :Integer;
    Function CheckIfValid: Boolean;
    Function SaveTransaction: Boolean;
    Procedure RefreshTotals;
    Function Exportfilename: String;
    Procedure InitEFTOptions(Sender: TObject);
    Procedure REadEFTOptions(Sender: TObject);
    Procedure ReadGuiprefs;
    Procedure SaveGuiprefs;
    procedure initABSOptions(Sender: TObject);
    procedure ReadABSOptions(Sender: TObject);
    function ExportFileModetostr(const Value: Integer): sTring;
  Public
    Constructor Create(AOwner: TComponent); Override;
  End;

Implementation

Uses
  FastFuncs, ABAObj, AuditObj, EFTOptionsPopup, DNMExceptions, CommonLib, AppEnvironment, TcConst, TcTypes, ACHObj, CommonFormLib, ASBObj, frmABSOptions;

{$R *.dfm}
{ TfrmABAExportGUI }

Procedure TfrmABAExportGUI.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
  Inherited;
  SaveGuiprefs;
  // Save our Column Information
  GrdTransactions.SaveToIniFile;

  // Close our Queries
  CloseQueries;

  // Free our form from memory.
  Action := CaFree;

End;

Procedure TfrmABAExportGUI.FormShow(Sender: TObject);
Var
  QueryNamesNotToOpen: Array Of String;
Begin
  DisableForm;
  Try
    ProcessingCursor(True);
    EdtUserName.Text (* lblUser.caption *) := AppEnv.Employee.LogonName;
    Try
      Try
        If Not UserLock.Lock('tblabadescriptiverecord', 0, 'Electronic Funds Transfer') Then Begin
          AccessLevel := 6; // read only
          CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Electronic Funds Transfer' + ' Access is Denied.', MtWarning, [MbOK], 0);
        End;
        Inherited;

        Setlength(QueryNamesNotToOpen, 2);
        QueryNamesNotToOpen[0] := 'tblMaster';
        QueryNamesNotToOpen[1] := 'tblDetails';
        OpenQueries(QueryNamesNotToOpen);

        BtnDelete.Enabled  := (AccessLevel = 1);
        BtnOptions.Enabled := (AccessLevel = 1) And
          ((Appenv.RegionalOptions.RegionType = RUSA) Or
          (Appenv.RegionalOptions.RegionType = RAust) Or
          (Appenv.RegionalOptions.RegionType = RnZ) or
          (Appenv.RegionalOptions.RegionType = rCAN));

        TblMaster.ParamByName('ID').AsInteger := KeyID;
        TblMaster.Open;
        TblDetails.ParamByName('ID').AsInteger := TblMasterAccountID.AsInteger;
        TblDetails.Open;

        If KeyID <> 0 Then Begin
          EditNoAbort(TblMaster);
          EditNoAbort(TblDetails);
        End Else Begin
          TblMaster.Insert;
          TblDetails.Insert;
        End;
        ReadGuiprefs;
      Finally
        ProcessingCursor(False);
        GrdTransactions.SetActiveField('Product');
      End;
    Except
      On EAbort Do HandleEAbortException;
      On E: ENoAccess Do HandleNoAccessException(E);
      Else
        Raise;
    End;
  Finally EnableForm;
  End;
End;

Procedure TfrmABAExportGUI.FormCreate(Sender: TObject);
Begin
  ProcessingCursor(True);
  Try
    Inherited;
    UserLock.Enabled := True;
    SetConnectionString(False);
    TblMaster.Connection   := MyConnection;
    TblDetails.Connection  := MyConnection;
    MyConnection.Connected := True;
    If Not MyConnection.Intransaction Then Begin
      BeginTransaction;
    End;
    If AccessLevel = 3 Then AccessLevel := 5;
  Finally ProcessingCursor(False);
  End;
End;

Procedure TfrmABAExportGUI.BtnCloseClick(Sender: TObject);
Begin
  Inherited;
  Self.Close;
End;

Procedure TfrmABAExportGUI.TblMasterAccountIDChange(Sender: TField);
Begin
  Inherited;
  TblMaster.Edit;
  TblMaster.FieldByName('DirectEntryUserName').AsString  := CboAccountQry.FieldByName('BankAccountName').AsString;
  TblMaster.FieldByName('UserBankName').AsString         := CboAccountQry.FieldByName('BankCode').AsString;
  TblMaster.FieldByName('DirectEntryUserID').AsString    := CboAccountQry.FieldByName('APCANo').AsString;
  TblMaster.FieldByName('IncludeBalanceRecord').AsString := CboAccountQry.FieldByName('IncludeBalanceRecord').AsString;
  TblMaster.FieldByName('IncludeNetTotal').AsString      := CboAccountQry.FieldByName('IncludeNetTotal').AsString;
  TblMaster.FieldByName('IncludeCreditTotal').AsString   := CboAccountQry.FieldByName('IncludeCreditTotal').AsString;
  TblMaster.FieldByName('IncludeDebitTotal').AsString    := CboAccountQry.FieldByName('IncludeDebitTotal').AsString;

  If (TblMaster.FieldByName('ProcessingDate').AsDateTime = 0) Then Begin
    TblMaster.FieldByName('ProcessingDate').AsDateTime := Date;
  End;
  TblMaster.Post;
  TblMaster.Edit;
End;

Function TfrmABAExportGUI.Exportfilename: String;
Var
  SaveDialog: TSaveDialog;
Begin
  SaveDialog                                                                 := TSaveDialog.Create(Nil);
  If (Appenv.RegionalOptions.RegionType = rUSA) or (Appenv.RegionalOptions.RegionType = rCAN) Then SaveDialog.DefaultExt                            := 'ach'
  Else If (Appenv.RegionalOptions.RegionType = RNZ) and (ExportFileMode<>3) Then SaveDialog.DefaultExt  := 'asb'
  Else If (Appenv.RegionalOptions.RegionType = RNZ) and (ExportFileMode=3) Then SaveDialog.DefaultExt   := 'afi'
  Else SaveDialog.DefaultExt                                                                        := 'aba';

       If (Appenv.RegionalOptions.RegionType = RUSA) or (Appenv.RegionalOptions.RegionType = rCAN) Then SaveDialog.Filter     := 'Electronic Funds Tranfer (*.ach)|*.ach|All Files (*.*)|*.*'
  Else If (Appenv.RegionalOptions.RegionType = RNZ) and (ExportFileMode<>3) Then SaveDialog.Filter := 'Electronic Funds Tranfer (*.asb)|*.asb|All Files (*.*)|*.*'
  Else If (Appenv.RegionalOptions.RegionType = RNZ) and (ExportFileMode=3)  Then SaveDialog.Filter := 'Electronic Funds Tranfer (*.afi)|*.afi|All Files (*.*)|*.*'
  Else SaveDialog.Filter                                                 := 'Electronic Funds Tranfer (*.aba)|*.aba|All Files (*.*)|*.*';
  If SaveDialog.Execute Then Begin
    Result := SaveDialog.FileName;
  End;
End;

Procedure TfrmABAExportGUI.BtnCompletedClick(Sender: TObject);
Var
  ABAObj  : TABAObj;
  ACHObj  : TACHObj;
  ASBObj  : TASBObj;
  ExportOk: Boolean;
  SSQL    : String;
  Filename: String;
Begin
  DisableForm;
  Try
    Inherited;
    Filename := Exportfilename;
    If Filename = '' Then Exit;

    If CheckIfValid Then Begin
      If Not SaveTransaction Then Exit;
      If MessageDlgXP_Vista('Do You Wish To Print?', MtConfirmation, [Mbyes, Mbno], 0) = MrYEs Then Begin
        SSQL                := '~|||~ where aba.DescriptiveRecordID = ' + IntToStr(TblMasterDescriptiveRecordID.AsInteger);
        FbReportSQLSupplied := False;
        PrintTemplateReport('EFT Report', SSQL, Not(Appenv.Employee.ShowPreview), 1);
      End;
{----}If (Appenv.RegionalOptions.RegionType = rUSA) or
         (Appenv.RegionalOptions.RegionType = rCAN) Then Begin
        ACHObj := TACHObj.Create;
        Try
          ACHObj.AccountID        := CboAccountQry.FieldByName('AccountID').AsInteger;
          ACHObj.ServiceClasscode := 200;
          ACHObj.QryData          := TblDetails;
          ACHObj.QryHeader := tblMaster;
          ACHObj.DoExport(Filename);
          If ACHObj.InvalidMsg <> '' Then Begin
            MessageDlgXP_Vista('Export Failed ' + NL + ACHObj.InvalidMsg, MtWarning, [MbOK], 0);
            ExportOK := False;
          End Else Begin
            MessageDlgXP_Vista('Data Exported into ' + Quotedstr(Filename), MtWarning, [MbOK], 0);
            ExportOK := True;
          End;
        Finally Freeandnil(ACHObj);
        End;
{----}End Else If Appenv.RegionalOptions.RegionType = RNZ Then Begin
        ASBObj := TASBObj.Create;
        Try
          ASBObj.AccountID := CboAccountQry.FieldByName('AccountID').AsInteger;
          ASBObj.QryData   := TblDetails;
          ASBObj.Qryheader := TblMaster;
          if ExportFileMode=3 then
              ASBObj.DoExportAFI(Filename)
          else if ExportFileMode=2 then
            ASBObj.DoExportMT9(Filename)
          else
            ASBObj.DoExportCSV(Filename);

          MessageDlgXP_Vista('Data Exported into ' + Quotedstr(Filename), MtWarning, [MbOK], 0);
          ExportOK := True;
        Finally Freeandnil(ASBObj);
        End;
{----}End Else Begin
        ABAObj       := TABAObj.Create;
        Try
          ABAObj.connection := TERPConnection(tblMaster.connection);
          ExportOk := ABAObj.ExportABAFile(Filename, TblMasterDescriptiveRecordID.AsInteger);
          if ExportOk  then
            MessageDlgXP_Vista('Data Exported into ' + Quotedstr(Filename), MtWarning, [MbOK], 0);
        Finally
          FreeandNil(ABAObj);
        End;
{----}End;
      If ExportOk Then Begin
        CommitTransaction;
        Notify;
        Self.Close;
      End Else Begin
        SetControlFocus(CboAccount);
      End;
    End;
  Finally EnableForm;
  End;
End;

Procedure TfrmABAExportGUI.SaveGuiprefs;
Begin
  GuiPrefs.Node['Grpfilters.ExportFileMode'].asInteger:= ExportFileMode;
  if devmode then begin
    GuiPrefs.Node['Grpfilters.AccountID'].asInteger:= tblmasterAccountID.asInteger ;
    GuiPrefs.Node['Grpfilters.UserBankName'].asString := tblmasterUserBankName.asString  ;
    GuiPrefs.Node['Grpfilters.TransactionDescription'].asString := tblmasterTransactionDescription.asString ;
  end;
End;

Function TfrmABAExportGUI.SaveTransaction: Boolean;
Begin
  Result := False;
  If (MyConnection.Intransaction) Then Begin
    Try
      With TblMaster Do
        Try
          If State <> DsBrowse Then Begin
            Post;
          End;
        Except Raise;
        End;

      With TblDetails Do
        Try
          If (GrdTransactions.Fields[0].AsString <> '') And (GrdTransactions.DataSource.DataSet.State In [DsInsert, DsEdit]) Then Begin
            GrdTransactions.DataSource.DataSet.Post;
          End;
        Except Raise;
        End;

    Except
      On E: Exception Do Begin
        Audit.AddEntry(E, Self);
        RollbackTransaction;
        Raise Exception.Create(E.Message + Chr(13) + 'Errors occured in ' + Self.ClassName);
      End;
    End;
    REsult := True;
  End;
End;

Procedure TfrmABAExportGUI.TblDetailsApplyChange(Sender: TField);
Begin
  Inherited;
  If TblDetailsApply.AsBoolean Then Begin
    TblDetails.Edit;
    TblDetailsDescriptiveRecordID.AsString := TblMasterDescriptiveRecordID.AsString;
    TblDetailsUsersBSB.AsString            := CboAccountQry.FieldByName('BSB').AsString;
    TblDetailsUsersAccountNumber.AsString  := CboAccountQry.FieldByName('BankAccountNumber').AsString;
    TblDetailsNameofRemitter.AsString      := CboAccountQry.FieldByName('BankAccountName').AsString;
  End Else Begin
    TblDetailsDescriptiveRecordID.AsString := '';
    TblDetailsUsersBSB.AsString            := '';
    TblDetailsUsersAccountNumber.AsString  := '';
    TblDetailsNameofRemitter.AsString      := '';
  End;
  RefreshTotals;
End;

Procedure TfrmABAExportGUI.CboAccountChange(Sender: TObject);
Begin
  Inherited;
  If TblDetails.Active Then Begin
    TblDetails.Close;
  End;
  TblDetails.ParamByName('ID').AsInteger := CboAccountQry.FieldByName('AccountID').AsInteger;
  TblDetails.Open;
End;
function TfrmABAExportGUI.ExportFileModetostr(Const Value:Integer):sTring;
begin
       if Value = 1 then Result := 'CSV'
  else if Value = 2 then result := 'MT9'
  else if Value = 3 then result := 'AFI'
  else result :='';
end;
procedure TfrmABAExportGUI.cboBankCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if qryBankCodes.FieldByName('bankcode').AsString ='BNZ' then
    if ExportFileMode <> 3 then
      if MessageDlg('You have selected a ''Bank of New Zealand'' and the export mode is ' + ExportFileModetostr(ExportFileMode) +'.'+NL+
      'Would you like to change this to ''AFI''?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
        ExportFileMode:= 3;
      end;
end;

Procedure TfrmABAExportGUI.BtnDeleteClick(Sender: TObject);
Begin
  Inherited;
  If CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', MtConfirmation, MbYesNoCancel, 0) = MrYes Then Begin
    Try TblDetails.Delete;
    Except
      { Do nothing - raise a silent exception }
    End;
  End;
End;

Procedure TfrmABAExportGUI.GrdTransactionsExit(Sender: TObject);
Begin
  Inherited;
  If TblDetails.RecordCount > 0 Then Begin
    TblDetails.Edit;
    TblDetails.Post;
    TblDetails.Edit;
  End;
End;

Function TfrmABAExportGUI.CheckIfValid: Boolean;
Begin
  Result := True;
  { ADD More In Future }
  If Empty(TblMasterTransactionDescription.AsString) Then Begin
    CommonLib.MessageDlgXP_Vista('Transaction Description Cannot Be Empty !', MtWarning, [MbOK], 0);
    Result := False;
    SetControlFocus(CboTransDesc);
    Exit;
  End;
End;

Constructor TfrmABAExportGUI.Create(AOwner: TComponent);
Begin
  Inherited;
End;

Procedure TfrmABAExportGUI.CboTransDescNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: Boolean);
Begin
  Inherited;
  LookupTable.Append;
  LookupTable.FieldByName('Description').AsString := NewValue;
  LookupTable.Post;
  LookupTable.Refresh;
  LookupTable.Locate('Description', NewValue, [LoCaseInsensitive]);
End;

Procedure TfrmABAExportGUI.BtnOptionsClick(Sender: TObject);
Begin
  Inherited;
  If (Appenv.RegionalOptions.RegionType = RUSA) or (Appenv.RegionalOptions.RegionType = rCAN) Then Begin
    OpenERPFormModal('TfmAchInfo', 0);
  end else If Appenv.RegionalOptions.RegionType = RNZ Then Begin
    OpenERPFormModal('TfmABSOptions', 0 , initABSOptions, true, ReadABSOptions);
  End Else Begin
    OpenERPFormModal('TEFTOptions', 0, InitEFTOptions, True, REadEFTOptions);
  End;
End;
Procedure TfrmABAExportGUI.initABSOptions(Sender: TObject);
begin
  If Not(Sender Is TfmABSOptions) Then Exit;
  TfmABSOptions(Sender).ExportFileMode := ExportFileMode;
end;
Procedure TfrmABAExportGUI.ReadABSOptions(Sender: TObject);
begin
  If Not(Sender Is TfmABSOptions) Then Exit;
  ExportFileMode:= TfmABSOptions(Sender).ExportFileMode;
end;
Procedure TfrmABAExportGUI.InitEFTOptions(Sender: TObject);
Begin
  If Not(Sender Is TEFTOptions) Then Exit;
  With TEFTOptions(Sender) Do Begin
    IncludeBalanceRecord := TblMasterIncludeBalanceRecord.AsBoolean;
    IncludeNetTotal      := TblMasterIncludeNetTotal.AsBoolean;
    IncludeCreditTotal   := TblMasterIncludeCreditTotal.AsBoolean;
    IncludeDebitTotal    := TblMasterIncludeDebitTotal.AsBoolean;
    Position             := PoScreenCenter;
  End;
End;

procedure TfrmABAExportGUI.qryBankCodesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  TERPQuery(Dataset).Params.ParamByName('XRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

Procedure TfrmABAExportGUI.REadEFTOptions(Sender: TObject);
Begin
  If Not(Sender Is TEFTOptions) Then Exit;
  With TEFTOptions(Sender) Do Begin
    TblMaster.Edit;
    TblMasterIncludeBalanceRecord.AsBoolean := IncludeBalanceRecord;
    TblMasterIncludeNetTotal.AsBoolean      := IncludeNetTotal;
    TblMasterIncludeCreditTotal.AsBoolean   := IncludeCreditTotal;
    TblMasterIncludeDebitTotal.AsBoolean    := IncludeDebitTotal;
  End;
End;

Procedure TfrmABAExportGUI.ReadGuiprefs;
Begin
  Guiprefs.Active := True;
  if Appenv.RegionalOptions.RegionType = rNz then begin
     ExportFileMode :=  GuiPrefs.Node['Grpfilters.ExportFileMode'].asInteger;
     if ExportFileMode =0 then ExportFileMode := 1;
     if ExportFileMode =1 then
      TimerMsg(lblMsg , 'Exporing file mode is set to ''CSV''. Select ''Options'' to change it to ''MT-9''.')
     else TimerMsg(lblMsg , 'Exporing file mode is set to ''MT-9''. Select ''Options'' to change it to ''CSV''.');
  end;
  if devmode then begin
    tblmasterAccountID.asInteger := GuiPrefs.Node['Grpfilters.AccountID'].asInteger;
    tblmasterUserBankName.asString := GuiPrefs.Node['Grpfilters.UserBankName'].asString;
    tblmasterTransactionDescription.asString := GuiPrefs.Node['Grpfilters.TransactionDescription'].asString;
  end;
End;

Procedure TfrmABAExportGUI.RefreshTotals;
Var
  TotalAmount: Currency;
  Bm         : TBookmark;
Begin
  TotalAmount := 0.00;
  If TblDetails.Active Then Begin
    If (TblDetails.RecordCount > 0) Then Begin
      Bm := TblDetails.GetBookmark;
      TblDetails.DisableControls;
      TblDetails.First;
      While Not TblDetails.Eof Do Begin
        If TblDetailsApply.AsBoolean Then TotalAmount := TotalAmount + TblDetailsAmount.AsCurrency;
        TblDetails.Next;
      End;
      TblDetails.EnableControls;
      TblDetails.GotoBookmark(Bm);
      TblDetails.FreeBookmark(Bm);
    End;
    GrdTransactions.ColumnByName('Amount').FooterValue := FloatToStrF(TotalAmount, FfCurrency, 15, CurrencyRoundPlaces);
  End;
End;

Procedure TfrmABAExportGUI.TblDetailsTransCodeDescChange(Sender: TField);
Begin
  Inherited;
  CboTransactionCode.LookupTable.Locate('TransCodeDescription', CboTransactionCode.Text, [LoCaseInsensitive]);
  If TblDetails.Active Then Begin
    TblDetails.Edit;
    TblDetailsTransactionCode.AsString := QryTransCodes.FieldByName('TransCode').AsString;
  End;
End;

Procedure TfrmABAExportGUI.BtnSelectAllClick(Sender: TObject);
Begin
  Inherited;
  TblDetails.First;
  While Not TblDetails.Eof Do Begin
    TblDetails.Edit;
    TblDetails.FieldByName('Apply').AsString := 'T';
    TblDetails.Next;
  End;
End;

Procedure TfrmABAExportGUI.ActSelectAllUpdate(Sender: TObject);
Begin
  Inherited;
  If CboAccount.Text = '' Then Begin
    BtnSelectAll.Enabled := False;
  End Else Begin
    BtnSelectAll.Enabled := True;
  End;
End;

Procedure TfrmABAExportGUI.GrdTransactionsCalcTitleImage(Sender: TObject; Field: TField; Var TitleImageAttributes: TwwTitleImageAttributes);
Begin
  Inherited;
  If FastFuncs.PosEx('[' + Field.FieldName + ']' + ' ASC', TblDetails.IndexFieldNames) > 0 Then Begin
    TitleImageAttributes.ImageIndex := 0;
  End
  Else If FastFuncs.PosEx('[' + Field.FieldName + ']' + ' DESC', TblDetails.IndexFieldNames) > 0 Then Begin
    TitleImageAttributes.ImageIndex := 1;
  End Else Begin
    TitleImageAttributes.ImageIndex := -1;
  End;
End;

Procedure TfrmABAExportGUI.GrdTransactionsTitleButtonClick(Sender: TObject; AFieldName: String);
Begin
  Inherited;
  If (TblDetails.FieldByName(AFieldName).FieldKind <> FkLookup) And (TblDetails.FieldByName(AFieldName).FieldKind <> FkCalculated) Then Begin
    If FastFuncs.PosEx('[' + AFieldName + ']' + ' ASC', TblDetails.IndexFieldNames) <> 0 Then Begin
      TblDetails.IndexFieldNames := '[' + AFieldName + ']' + ' DESC';
    End Else Begin
      TblDetails.IndexFieldNames := '[' + AFieldName + ']' + ' ASC';
    End;
  End;
End;

Procedure TfrmABAExportGUI.GrdTransactionsCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
Begin
  Inherited;

  If TblDetailsApply.AsBoolean Then ABrush.Color := $00C4FFE1;

End;

Initialization

RegisterClassOnce(TfrmABAExportGUI);

End.
