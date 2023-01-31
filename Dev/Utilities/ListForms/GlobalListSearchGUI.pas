unit GlobalListSearchGUI;

{ Date     Version Who  What
 -------- -------- ---  ------------------------------------------------------
 12/01/06  1.00.01 IJB  Removed ClientType from report to improve list opening
                        speed.
 14/10/08          RM   Added Primary Key to temp table to improve speed

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList,
  Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, DNMPanel, DBAccess,
  MyAccess,ERPdbComponents, MemDS, wwdbdatetimepicker, kbmMemTable,
   wwdblook, Shader, ProgressDialog, DAScript, MyScript,
  wwcheckbox, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;
type
  TGlobalListSearchFrm = class(TBaseListingGUI)
    btnNewCustomer: TDNMSpeedButton;
    btnNewSupplier: TDNMSpeedButton;
    btnNewOtherContact: TDNMSpeedButton;
    qryClientType: TERPQuery;
    qryRep: TERPQuery;
    qryTerms: TERPQuery;
    qryClientTypeClientTypeID: TIntegerField;
    qryClientTypeTypeName: TWideStringField;
    qryRepEmployeeID: TIntegerField;
    qryRepEmployeeName: TWideStringField;
    qryTermsTermsID: TIntegerField;
    qryTermsTerms: TWideStringField;
    qryMainClientTypeID: TIntegerField;
    qryMainClientType: TWideStringField;
    qryMainRepID: TIntegerField;
    qryMainRep: TWideStringField;
    qryMainTermsID: TIntegerField;
    qryMainTerms: TWideStringField;
    qryMainID: TIntegerField;
    qryMainParentClientID: TLargeintField;
    qryMainGlobalRef: TWideStringField;
    qryMainType: TWideStringField;
    qryMainName: TWideStringField;
    qryMainBalance: TFloatField;
    qryMainContactName: TWideStringField;
    qryMainStreet: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainStreet3: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainState: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainJobName: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainCreationDate: TDateField;
    qryMainAccountNo: TWideStringField;
    qryMainGracePeriod: TWordField;
    qryMainStopCredit: TWideStringField;
    qryMainBillStreet: TWideStringField;
    qryMainBillStreet2: TWideStringField;
    qryMainBillStreet3: TWideStringField;
    qryMainBillSuburb: TWideStringField;
    qryMainBillState: TWideStringField;
    qryMainBillPostcode: TWideStringField;
    qryMainBillCountry: TWideStringField;
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
    qryMainCUSTDATE1: TDateField;
    qryMainCUSTDATE2: TDateField;
    qryMainCUSTDATE3: TDateField;
    lblSearch: TLabel;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure btnNewCustomerClick(Sender: TObject);
    procedure btnNewSupplierClick(Sender: TObject);
    procedure btnNewOtherContactClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    TempFileNameList: TStringList;
    Procedure CreateTempTable;
    procedure DoCreateTempTable(strSQL:String; SQLcount:Integer);
  protected
    tablename :String;
    procedure RefreshQuery; override;
    Procedure SetGridColumns;override;
    procedure MyScriptBeforeExecute(Sender: TObject; var SQL: String; var Omit: Boolean);
  public
    sPhone: string;
  published
    procedure AddPhoneNumberToClient;
    { Public declarations }
  end;

implementation

uses FastFuncs,frmCustomerFrm, CommonLib, frmSupplier, frmOtherContactFrm,
  AppEnvironment, CommonDbLib, GlobalListGUI, MessageConst,frmMarketingContact,
  ContactLib, tcConst, TempTableUtils;

{$R *.dfm}

procedure TGlobalListSearchFrm.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;

procedure TGlobalListSearchFrm.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.FieldByName('Type').AsString;
  inherited;
end;

procedure TGlobalListSearchFrm.FormCreate(Sender: TObject);
begin
  //fbEnableWebSearch := true;
  sPhone := '';
  //inherited;
//  if self is TGlobalListFrm then
//    Tablename := CommonDbLib.CreateUserTemporaryTable('tmp_globalList','full','Myisam')
//  else
//    Tablename := CommonDbLib.CreateUserTemporaryTable('tmp_globalList','Search','Myisam');
  TableName := UniqueTableName('GlobalList');
  CreateTemporyTableFromTemplate(CommonDbLib.GetSharedMyDacConnection,'tmp_globalList',TableName,'MYISAM');

  if Qrymain.active then Qrymain.close;
  Qrymain.SQL.clear;
  Qrymain.SQL.text := 'Select *' + #13#10 +  'from ' + tableName;// + #13#10 + 'limit 0';
  inherited;
  RefreshOrignalSQL;
  TempFileNameList := TStringList.Create;
end;

procedure TGlobalListSearchFrm.FormDestroy(Sender: TObject);
begin
  inherited;
  TempFileNameList.Free;
end;

procedure TGlobalListSearchFrm.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('Name') + ' ASC CIS';
  BaseIndexFieldNames := qryMain.IndexFieldNames;
end;

procedure TGlobalListSearchFrm.btnNewCustomerClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TfrmCustomer');
  If not Assigned(tmpComponent) then Exit;
  with TfrmCustomer(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TGlobalListSearchFrm.btnNewSupplierClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TfmSupplier');
  If not Assigned(tmpComponent) then Exit;
  with TfmSupplier(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TGlobalListSearchFrm.btnNewOtherContactClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TfrmOtherContact');
  If not Assigned(tmpComponent) then Exit;
  with TfrmOtherContact(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TGlobalListSearchFrm.AddPhoneNumberToClient;
Var
  qry: TERPQuery;
  cmd: TERPCommand;
begin
//  'Customer / Supplier' 'Customer' 'Other Contact'  'Supplier'  Type,
//  if qryMain.FieldByName('Type').AsString = 'Customer / Supplier';

  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  cmd := TERPCommand.Create(nil);
  try
    qry.Connection := qryMain.Connection;
    qry.SQL.Text :=
    ' SELECT ClientID, Phone ' +
    ' FROM tblClients ' +
    ' WHERE ClientID = ' + qryMain.FieldByName('ID').AsString;
    qry.Open;
    if qry.RecordCount > 0 then begin
      if qry.FieldByName('Phone').AsString = '' then begin
        qry.Edit;
        qry.FieldByName('Phone').AsString := sPhone;
        qry.Post;
      end
      else begin
        cmd.Connection := qryMain.Connection;
        cmd.SQL.Text :=
        'INSERT HIGH_PRIORITY INTO tblclientsotherphones (Phone, Comment, ClientID) '+
        ' VALUES (' + QuotedStr(sPhone) + ', "from Call Monitor",' + qryMain.FieldByName('ID').AsString + ') ';
        cmd.Execute;
      end;
    end
  finally
    FreeAndNil(qry);
    FreeandNil(cmd);
  end;
end;

procedure TGlobalListSearchFrm.RefreshQuery;
begin
  ProcessingCursor();
  try
    (*Qrymain.DisableControls;
    try*)
      CreateTempTable;
      inherited;
      PopulateFilterCombo;
    (*finally
      Qrymain.EnableControls;
    end;*)
  finally
    ProcessingCursor(False);
  end;
end;
procedure TGlobalListSearchFrm.CreateTempTable;
begin
  if not IsLimit0selection then
    contactLib.ContactList(tablename, DoCreateTempTable , TempFileNameList, Appenv.Companyprefs.ExcludeInactiveContactFromMessages);
end;
procedure TGlobalListSearchFrm.DoCreateTempTable(strSQL:String; SQLcount:Integer);
begin
    ShowProgressbar(WAITMSG , SQLCount);
    try
      ExecuteSQL(strSQL , nil,MyScriptBeforeExecute );
    Finally
        HideProgressbar;
    end;
end;

procedure TGlobalListSearchFrm.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if qryMainStopCredit.AsBoolean then begin
    AFont.Color := clRed;
  end;
end;

procedure TGlobalListSearchFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  x: integer;
begin
  inherited;
  if Qrymain.Active then Qrymain.Close;
  for x := 0 to TempFileNameList.count-1 do begin
    AppEnv.UtilsClient.DeleteServerFile(TempFileNameList[x]);
  end;
  TempFileNameList.Clear;

  TempTableUtils.DropTemporyTables(TableName, GetSharedMyDacConnection);
  AppEnv.UtilsClient.DeleteAllTempFilesForReportFromTempTable(TableName, CommonDbLib.GetSharedMyDacConnection);
end;

procedure TGlobalListSearchFrm.MyScriptBeforeExecute(Sender: TObject;
  var SQL: String; var Omit: Boolean);
begin
  if Assigned(ProgressDialogInst) then
    if copy(Sql, 1, 2) = '/*' then ProgressDialogInst.Message:= StringReplace(StringReplace(SQL, '/*' ,'', []), '*/' , '', []);

  DoStepProgressbar;
end;

procedure TGlobalListSearchFrm.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Cust');
end;

initialization
  RegisterClassOnce(TGlobalListSearchFrm);

end.
