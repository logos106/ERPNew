unit SupplierListForm;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 }                   

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ImgList, Menus, AdvMenus, ComCtrls,AdvOfficeStatusBar, ActnList,
  PrintDAT, wwDialog, Wwlocate, SelectionDialog, DNMPanel,
  MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,
   wwdblook, Shader, kbmMemTable, BaseListDetails, DAScript, MyScript, wwcheckbox, CustomInputBox, DNMAction,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSupplierListGUI = class(TBaseListDetailsGUI)
    qryMainClientID: TAutoIncField;
    qryMainSupplierName: TWideStringField;
    qryMainBalance: TFloatField;
    qryMainContactName: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainBankAccountName: TWideStringField;
    qryMainBankAccountBSB: TWideStringField;
    qryMainBankAccountNo: TWideStringField;
    qryMainStreet: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainState: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    N1: TMenuItem;
    Merge1: TMenuItem;
    qryMainCreationDate: TDateField;
    qryMainMobile: TWideStringField;
    qryMainCUSTDATE1: TDateField;
    qryMainCUSTDATE2: TDateField;
    qryMainCUSTDATE3: TDateField;
    qryMainGlobalRef: TWideStringField;
    qryMainARBalance: TFloatField;
    qryMainAPBalance: TFloatField;
    qryMainStreet2: TWideStringField;
    qryMainStreet3: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainFirstname: TWideStringField;
    qryMainLastname: TWideStringField;
    qryMainContactdetails: TWideStringField;
    qryMainABN: TWideStringField;
    qryMainprintname: TWideStringField;
    qryMainEmail: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actMergeExecute(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
  private
    LastSelectedID: integer;
  protected
    procedure RefreshQuery; override;
    Procedure SetGridColumns;override;
    Function ExpressDetailListName:String;override;
  public
    { Public declarations }
  end;

  //var
  //  SupplierListGUI: TSupplierListGUI;

implementation

uses FastFuncs,frmSupplier, MergeObj, DnmLib, {tcMessaging,} MAIN, 
  CommonLib,AccountsPayListForm,AccountsReceiveListForm, dmMainGUI,
  AppEnvironment, tcDataUtils, UserUtilsClientObj, CommonFormLib;

{$R *.dfm}

procedure TSupplierListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;

procedure TSupplierListGUI.RefreshQuery;
begin
  inherited;
(*  replaceCustFlds;*)
  qryMain.First;
end;

procedure TSupplierListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if self.fbFormOpenedOk then begin
    grpFiltersClick(Sender);
  end;
end;

procedure TSupplierListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  //  SupplierListGUI := nil;
end;

procedure TSupplierListGUI.cmdNewClick(Sender: TObject);
(*var
  Form: TComponent;*)
begin
  inherited;
  OpenERPForm('TfmSupplier' , 0);
(*  Form := GetComponentByClassName('TfmSupplier');
  if Assigned(Form) then begin
    with TfmSupplier(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
  //  MainForm.Supplier1Click(Sender);*)
end;

function TSupplierListGUI.ExpressDetailListName: String;
begin
  REsult := 'TSupplierExpressListGUI';
end;

procedure TSupplierListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  //  fbUseFetchProgress:=True;
  inherited;
  ShowChartViewOnPopup := True;
  LastSelectedID:= 0;
end;

procedure TSupplierListGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  LastSelectedID := qryMain.FieldByName('ClientID').AsInteger;
end;

procedure TSupplierListGUI.actMergeExecute(Sender: TObject);
var 
  i: integer;
  MergeObj: TMergeObj;
  PrincipleName: string;
  PrincipleID: integer;
  SecordaryName: string;
  SecordaryID: integer;
  msg: string;
begin
  inherited;
  if grdMain.SelectedList.Count > 1 then begin
    qryMain.DisableControls;
    qryMain.Locate('ClientID', LastSelectedID,[]);
    PrincipleName := GetClientName(qryMain.FieldByName('ClientID').AsInteger);
    PrincipleID   := qryMain.FieldByName('ClientID').AsInteger;
    if CommonLib.MessageDlgXP_Vista('Are you sure you wish to merge these Suppliers into ' + PrincipleName, mtConfirmation,
      [mbYes, mbNo], 0) = mrYes then begin
      for i := 0 to grdMain.SelectedList.Count - 1 do begin
        qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
        if qryMain.FieldByName('ClientID').AsInteger = PrincipleID then
          continue;
        SecordaryName := GetClientName(qryMain.FieldByName('ClientID').AsInteger);
        SecordaryID := qryMain.FieldByName('ClientID').AsInteger;
        // Ensure there is only one user connected to the database.  That is You only!
        if AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing a Merge Supplier') then begin
          try
            MergeObj := TMergeObj.Create;
            try
              MergeObj.Merge(mClient, PrincipleName, PrincipleID, SecordaryName, SecordaryID);
            finally
              MergeObj.Free;
            end;
          finally
            AppEnv.UtilsClient.UnlockLogon;
          end;
        end
        else begin
          if msg = USERS_IN_SYSTEM_MESSAGE then begin
            MainForm.GetCurrentUserCount;
            dtmMainGUI.dlgCurrentUsers.Caption := qryMain.Connection.Database + ' Merge Supplier';
            dtmMainGUI.dlgCurrentUsers.Color := pnlHeader.Color;
            dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
            dtmMainGUI.dlgCurrentUsers.Execute;
          end
          else begin
            MessageDlgXP_Vista('Unable to merge Suppliers, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
          end;
        end;
      end;
    end;
    grdMain.SelectedList.Clear;
    qryMain.EnableControls;
    UpdateMe;
  end else begin
    CommonLib.MessageDlgXP_Vista('Please select at least two (2) Suppliers.' + #13 + #10 +
      '(Hold down ''CTRL'' and click on row to toggle selection.)',
      mtInformation, [mbOK], 0);
  end;
end;

procedure TSupplierListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('SupplierName') + ' ASC CIS';
  BaseIndexFieldNames := qryMain.IndexFieldNames;
end;

procedure TSupplierListGUI.grdMainDblClick(Sender: TObject);
Var
  Form : TComponent;
begin
  if (grdMain.GetActiveField = qryMainARBalance) then begin
    if FormStillOpen('TAccountsReceiveListGUI') then TAccountsReceiveListGUI(FindExistingComponent('TAccountsReceiveListGUI')).Close;
    Application.ProcessMessages;
    if not FormStillOpen('TAccountsReceiveListGUI') then begin
      Form := GetComponentByClassName('TAccountsReceiveListGUI');
      if Assigned(Form) then begin
        with TAccountsReceiveListGUI(Form) do begin
          ARClientID := Self.qryMain.FieldByName('ClientID').AsInteger;
          FormStyle := fsMDIChild;
          BringToFront;
        end;
      end;
    end;
    Application.ProcessMessages;
  end else if (grdMain.GetActiveField = qryMainAPBalance) then begin
    if FormStillOpen('TAccountsPayListGUI') then TAccountsReceiveListGUI(FindExistingComponent('TAccountsPayListGUI')).Close;
    Application.ProcessMessages;
    if not FormStillOpen('TAccountsPayListGUI') then begin
      Form := GetComponentByClassName('TAccountsPayListGUI');
      if Assigned(Form) then begin
        with TAccountsPayListGUI(Form) do begin
          TAccountsPayListGUI(Form).APClientID := Self.qryMain.FieldByName('ClientID').AsInteger;
          FormStyle := fsMDIChild;
          BringToFront;
        end;
      end;
    end;
    Application.ProcessMessages;
  end else
    inherited;

end;

procedure TSupplierListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainclientID.Fieldname);
  RemoveFieldfromGrid(qryMainGlobalref.Fieldname);
  SetUpcustomFields('Supp');
end;

initialization
  RegisterClassOnce(TSupplierListGUI);

finalization
  UnRegisterClass(TSupplierListGUI);
end.
