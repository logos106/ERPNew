unit frmProductCommissions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ImgList, Menus, AdvMenus, DataState, DB,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, DBCtrls,
  StdCtrls, wwclearbuttongroup, wwradiogroup, Mask, wwdbedit, wwcheckbox,
  wwdblook, MemDS, Shader, DNMSpeedButton, Grids, Wwdbigrd, Wwdbgrid,
  DNMPanel, BusObjConst, BusObjBase, BusObjEmployeepay, ProgressDialog ;

type
  TfmProductCommissions = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    Bevel5: TBevel;
    t: TwwDBGrid;
    btnProdList: TDNMSpeedButton;
    pnlTop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryProdcommissions: TERPQuery;
    qryProdcommissionsProductCommissionId: TIntegerField;
    qryProdcommissionsPartsId: TIntegerField;
    qryProdcommissionsGlobalRef: TWideStringField;
    qryProdcommissionsIsPercentage: TWideStringField;
    qryProdcommissionsCommissionRate: TFloatField;
    qryProdcommissionsActive: TWideStringField;
    qryProdcommissionsmsTimeStamp: TDateTimeField;
    qryProdcommissionsEmployeeId: TLargeintField;
    qryProdcommissionsPartname: TWideStringField;
    qryProdcommissionsForAllEmployees: TWideStringField;
    qryProdcommissionsEmployeeName: TWideStringField;
    qryProdcommissionsCommissionOnPaid: TWideStringField;
    qryProdcommissionsCommissionInvoiceExPrice: TWideStringField;
    qryProdcommissionsOverheadbaserate: TFloatField;
    dsProdcommissions: TDataSource;
    DNMPanel2: TDNMPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblEmployee: TLabel;
    lblOHbase: TLabel;
    Label5: TLabel;
    cboemployee: TwwDBLookupCombo;
    chkIsPercentage: TwwCheckBox;
    wwCheckBox2: TwwCheckBox;
    wwDBEdit1: TwwDBEdit;
    btnGenerate: TDNMSpeedButton;
    optCommissionOnPaid: TwwRadioGroup;
    optCommissionInvoiceExPrice: TwwRadioGroup;
    qryParts: TERPQuery;
    qryPartsPArtname: TWideStringField;
    qryPartsPARTSID: TIntegerField;
    dsParts: TDataSource;
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    QryEmployee: TERPQuery;
    QryEmployeeemployeename: TWideStringField;
    QryEmployeeEmployeeID: TIntegerField;
    qryProdcommission: TERPQuery;
    qryProdcommissionProductCommissionId: TIntegerField;
    qryProdcommissionPartsId: TIntegerField;
    qryProdcommissionGlobalRef: TWideStringField;
    qryProdcommissionIsPercentage: TWideStringField;
    qryProdcommissionCommissionRate: TFloatField;
    qryProdcommissionActive: TWideStringField;
    qryProdcommissionmsTimeStamp: TDateTimeField;
    qryProdcommissionEmployeeId: TLargeintField;
    qryProdcommissionPartname: TWideStringField;
    qryProdcommissionForAllEmployees: TWideStringField;
    qryProdcommissionCommissionOnPaid: TWideStringField;
    qryProdcommissionCommissionInvoiceExPrice: TWideStringField;
    qryProdcommissionOverheadbaserate: TFloatField;
    qryProdcommissionCommissionOn: TWideStringField;
    Bevel3: TBevel;
    Bevel2: TBevel;
    qryProdcommissionsCommissionOn: TWideStringField;
    optCommissionOn: TwwRadioGroup;
    edtOverheadbaserate: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dodatachanged(Sender: TObject);
    procedure btnProdListClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cboemployeeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure optCommissionOnChange(Sender: TObject);
    procedure qryProdcommissionsAfterInsert(DataSet: TDataSet);
    procedure chkIsPercentageClick(Sender: TObject);
    procedure edtOverheadbaserateEnter(Sender: TObject);

  private
    datachanged :Boolean;

    fsTablename:String;
    (*fRefreshCommission: TGeneralProc;*)
    fEmployeepay: TEmployeepay;
    fbForAllEmployees: Boolean;
    procedure ProductGridDataSelect(Sender: TwwDBGrid);
    Procedure REfreshPart(Ids:String);
    function ValidtoGenerate:Boolean;
    function Setcommission(const Closewhendone:Boolean = False) :Boolean;
    Procedure ApplyPercentage;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    (*Property RefreshCommission :TGeneralProc read fRefreshCommission write fRefreshCommission;*)
    Property Employeepay :TEmployeepay Read fEmployeepay write fEmployeepay;
    Property ForAllEmployees :Boolean read fbForAllEmployees Write fbForAllEmployees;
  end;


implementation

uses CommonLib, ProductListForm,
  CommonDbLib, FastFuncs, busobjProductcommission;

{$R *.dfm}
procedure TfmProductCommissions.dodatachanged(Sender: TObject);
begin
  datachanged := True;
end;

procedure TfmProductCommissions.FormCreate(Sender: TObject);
begin
  inherited;
  datachanged := False;
  fsTablename := CommonDbLib.CreateUserTemporaryTable('tblproductcommission' , 'tmp_' , 'MYISAM');
  closeDB(qryProdcommissions);
  qryProdcommissions.SQL.text := StringReplace(qryProdcommissions.SQL.text ,'tblproductcommission' , fsTablename , [rfIgnoreCase] );
  (*fRefreshCommission := nil;*)
  fEmployeepay := nil;
  fbForAllEmployees := False;
end;

procedure TfmProductCommissions.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fstablename);
  inherited;

end;

procedure TfmProductCommissions.ProductGridDataSelect(Sender: TwwDBGrid);
var
  IdStr: string;
  i: integer;
  ProgressDialog: TProgressDialog;
begin
  IdStr := '';
ProgressDialog:= TProgressDialog.create(self);
TwwDBGrid(Sender).datasource.dataset.disablecontrols;
try
  With TwwDBGrid(Sender).datasource.dataset do begin
          ProgressDialog.Caption := 'Please Wait .......';
      ProgressDialog.MinValue := 0;
      ProgressDialog.MaxValue := TwwDBGrid(Sender).SelectedList.Count;
      ProgressDialog.Step := 1;
      ProgressDialog.Execute;

    for i := 0 to TwwDBGrid(Sender).SelectedList.Count - 1 do begin
      GotoBookmark(TwwDBGrid(Sender).SelectedList.Items[i]);
      if fieldbyname('PARTSID').AsInteger <> 0 then begin
        if IdStr <> '' then IdStr := IdStr + ',';
        IdStr := IdStr + Trim(fieldbyname('PARTSID').AsString);
      end;
      ProgressDialog.Stepit;
    end;
  end;

  if IDstr <> '' then begin
    REfreshPart(IDstr);

    dodatachanged(nil);
  end;
finally
    TwwDBGrid(Sender).datasource.dataset.enablecontrols;
    Freeandnil(ProgressDialog);
end;
end;

procedure TfmProductCommissions.REfreshPart(Ids: String);
begin
  if Ids = '' then IDS := '0';
  closedb(QryParts);
  QryParts.SQL.text := 'SELECT Distinct P.PARTSID,P.PARTNAME' +
                      ' FROM tblparts AS P ' +
                      ' WHERE' +
                      ' P.Active =  "T" AND' +
                      ' P.PARTSID IN  ( '+ Ids +')';
  openDB(QryParts);
end;

procedure TfmProductCommissions.btnProdListClick(Sender: TObject);
var
  Form:TComponent;
begin
  inherited;
  Form := getcomponentByclassname('TProductListGUI');
  if not Assigned(Form) then exit;
  if TProductListGUI(Form).visible then begin
    CommonLib.MessageDlgXP_Vista('Product List is already opened. Please close the List and select the option.' , mtInformation , [mbok], 0);
    Exit;
  end else begin
    TProductListGUI(Form).OnGridDataSelect := ProductGridDataSelect;
    TProductListGUI(Form).Productlistmode := tMultiplecommission;
    TProductListGUI(Form).FormStyle := fsMdiChild;
    TProductListGUI(Form).BringToFront;
  end;
end;

procedure TfmProductCommissions.btnSaveClick(Sender: TObject);
begin
  inherited;
  if not ValidtoGenerate then begin
    CommonLib.MessageDlgXP_Vista('Update Failed - Insufficiant information.' , mtWarning, [mbok], 0);
    exit;
  end;
  SetCommission(true);
end;

function TfmProductCommissions.ValidtoGenerate: Boolean;
begin
  Result := False;
  if Qryparts.RecordCount = 0 then begin
    commonLib.MessageDlgXP_Vista('Please select the parts to set the commission for' , mtWarning, [mbok],0 );
    Exit;
  end;
  if qryProdcommissionsForAllEmployees.asBoolean= false then begin
      if qryProdcommissionsemployeeid.asInteger = 0 then begin
         commonLib.MessageDlgXP_Vista('Employee should not be blank' , mtWarning, [mbok],0 );
         Exit;
      end;
  end;
  if   (qryProdcommissionsCommissionOn.asString = 'GO')
    or (qryProdcommissionsCommissionOn.asString = 'LO') then begin
      if qryProdcommissionsOverheadbaserate.asFloat = 0 then begin
         commonLib.MessageDlgXP_Vista('Overhead base should not be blank' , mtWarning, [mbok],0 );
         Exit;
      end;
  end;
  Result := True;
end;

function TfmProductCommissions.Setcommission(  const Closewhendone: Boolean): Boolean;
var
  PC:TProductCommission;
  Ids:String;
  updatedone :Boolean;
  ProgressDialog: TProgressDialog;
  s:String;
begin
  updateDone :=False;
  REsult := False;
  if not ValidtoGenerate then Exit;
  ProgressDialog:= TProgressDialog.create(self);
  PC:= TProductCommission.create(Self);
  TRy
    PC.connection := TMyDacDataConnection.create(PC);
    PC.connection.Connection := MyConnection;
    PC.BusObjEvent := DoBusinessObjectEvent;
    PC.Load(KeyID);
    PC.Connection.BeginTransaction;
    PC.SilentMode := true;
    Try
      qryParts.first;
      Ids := '0';

      ProgressDialog.Caption := 'Please Wait .......';
      ProgressDialog.MinValue := 0;
      ProgressDialog.MaxValue := qryParts.recordcount;
      ProgressDialog.Step := 1;
      ProgressDialog.Execute;
      s:= '';
      PostDB(qryProdcommissions);
      while qryParts.eof = False do begin
        ProgressDialog.StepIt;
        PC.Connection.BeginNestedTransaction;
        try
        PC.AddNewifMissing(qryPartsPARTSID.asInteger , qryProdcommissionsEmployeeID.asInteger, qryProdcommissionsforallemployees.asString);
          PC.PartsId             := qryPartsPARTSID.asInteger;
          PC.Partname            := qryPartsPartname.asString;
          PC.ForAllEmployees     := qryProdcommissionsForAllEmployees.asBoolean;
          PC.EmployeeId          := qryProdcommissionsEmployeeId.asInteger;
          PC.IsCommissiononpaidInvoice  := qryProdcommissionsCommissionOnPaid.asBoolean;
          PC.Commissioninvoiceexprice := qryProdcommissionsCommissionInvoiceExPrice.asBoolean;
          Pc.Commissionon         := qryProdcommissionsCommissionOn.asString;
          PC.CommissionRate       := qryProdcommissionsCommissionRate.asFloat;
          PC.IsPercentage := qryProdcommissionsIsPercentage.asBoolean;
          PC.Overheadbaserate := qryProdcommissionsOverheadbaserate.asfloat;

        if PC.ValidateData then begin
          PC.PostDB;
          updateDone:= True;
          PC.Connection.commitNestedTransaction;
        end else begin
          PC.Connection.RollbackNestedTransaction;
            if s <> '' then s := s + chr(13);
            s:= PC.ResultStatus.GetLastFatalStatusItem.Message;
            ids := ids +',';
            Ids := ids + qryPartsPartsId.AsString;
            if PC.dataset.State = dsinsert then
              PC.cancel
            else begin
              if PC.dataset.State = dsEdit then
                PC.Cancel;
              PC.Delete;
            end;
        end;
        except
            PC.Connection.RollbackNestedTransaction;
        end;

        QryParts.Next;
      end;

      PC.Connection.CommitTransaction;
      Result := true;

      if Ids<> '0' then begin
        (*lblTitle2.caption := 'Reward points are not created for the following products'*)
      end else begin
        datachanged := False;
        if updatedone and Closewhendone then begin
          CommonLib.MessageDlgXP_Vista('Product Commissions Are Updated.' , mtWarning, [mbok], 0);
          Self.Close;
          exit;
        end else begin
          (*lblTitle2.caption :='Zero Products To Update';*)
          qryProdcommissions.delete;
          qryProdcommissions.Append;
        end;
      end;
      if Ids<> '0' then
        CommonLib.MessageDlgXP_Vista('Product Commission Update Failed for the products in the list box as there are already existing Reward Point record(s) for overlaping period.' ,  mtWarning, [mbok], 0)
      else if updatedone then
        CommonLib.MessageDlgXP_Vista('Product Commission Are Updated.' , mtWarning, [mbok], 0) ;
    Except
        on E:Exception do begin
            MessageDlgXP_Vista('Update failed :' +E.message , mtWarning , [mbOk], 0);
            PC.Connection.RollbackTransaction;
        end;
    end;
    (*if assigned(fRefreshCommission) then fRefreshCommission;*)
      REfreshPart(Ids);
  finally
    if assigned(fEmployeepay) then
      if ForAllEmployees then
        fEmployeepay.AllemployeeProductcommission.RefreshDb
      else
      fEmployeepay.employeeProductcommission.refreshdb;
      Freeandnil(PC);
      FreeandNil(ProgressDialog);
  end;
end;

procedure TfmProductCommissions.cboemployeeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  qryProdcommissionsEmployeeId.asInteger := QryEmployeeEmployeeID.asInteger;
  qryProdcommissionsEmployeeName.asString := QryEmployeeemployeename.asString;
end;

procedure TfmProductCommissions.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TProductCommission then TProductCommission(Sender).Dataset:= qryProdcommission;
  end;

end;

procedure TfmProductCommissions.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  inherited;
  Setlength(QueryNamesNotToOpen, 1);
  QueryNamesNotToOpen[0] := 'qryProdcommission';
  OpenQueries(QueryNamesNotToOpen);
  qryProdcommissions.append;
  if (assigned(fEmployeepay)) and (fbForAllEmployees = False) then begin
          qryProdcommissionsForAllEmployees.asBoolean         :=False ;
          qryProdcommissionsEmployeeId.asInteger              := fEmployeepay.EmployeeDetails.Id;
          qryProdcommissionsCommissionOnPaid.asBoolean        := fEmployeepay.EmployeeDetails.IsCommissiononpaidInvoice       ;
          qryProdcommissionsCommissionInvoiceExPrice.asBoolean:= fEmployeepay.EmployeeDetails.Commissioninvoiceexprice;
          qryProdcommissionsCommissionOn.asString             := fEmployeepay.EmployeeDetails.Commissionon;
          qryProdcommissionsOverheadbaserate.asfloat          := fEmployeepay.EmployeeDetails.Overheadbaserate;
  end else begin
    qryProdcommissionsForAllEmployees.asBoolean         :=true;
  end;
end;

procedure TfmProductCommissions.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
  
end;

procedure TfmProductCommissions.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmProductCommissions.optCommissionOnChange(Sender: TObject);
begin
  inherited;
  dodatachanged(Sender);
  edtOverheadbaserate.Enabled := (optCommissionOn.Value = 'GO') or (optCommissionOn.Value = 'LO');
  lblOHbase.Enabled           := (optCommissionOn.Value = 'GO') or (optCommissionOn.Value = 'LO');
end;

procedure TfmProductCommissions.qryProdcommissionsAfterInsert(
  DataSet: TDataSet);
begin
  inherited;
  qryProdcommissionsForAllEmployees.asBoolean         :=False ;
  qryProdcommissionsEmployeeId.asInteger              := 0;
  qryProdcommissionsCommissionOnPaid.asBoolean        := True;
  qryProdcommissionsCommissionInvoiceExPrice.asBoolean:= False;
  qryProdcommissionsCommissionOn.asString             := 'I';
  qryProdcommissionsOverheadbaserate.asfloat          := 0;
end;

procedure TfmProductCommissions.ApplyPercentage;
begin
  optCommissionOn.enabled :=qryProdcommissionsIsPercentage.asBoolean;
  optCommissionInvoiceExPrice.enabled :=qryProdcommissionsIsPercentage.asBoolean;
  edtOverheadbaserate.enabled :=qryProdcommissionsIsPercentage.asBoolean;
  lblOHbase.enabled :=qryProdcommissionsIsPercentage.asBoolean;
end;

procedure TfmProductCommissions.chkIsPercentageClick(Sender: TObject);
begin
  inherited;
  dodatachanged(Sender);
  if screen.ActiveControl = chkIsPercentage then begin
    editdb(qryProdcommissions);
    qryProdcommissionsIsPercentage.asBoolean := chkIsPercentage.checked;
    postdb(qryProdcommissions);
    editdb(qryProdcommissions);
  end;
  ApplyPercentage;
end;

procedure TfmProductCommissions.edtOverheadbaserateEnter(Sender: TObject);
begin
  inherited;
  if    (optCommissionOn.Value <> 'GO')
    and (optCommissionOn.Value <> 'LO') then
    SetControlFocus(optCommissionOn);
  edtOverheadbaserate.Enabled := (optCommissionOn.Value = 'GO') or (optCommissionOn.Value = 'LO');
  lblOHbase.Enabled           := (optCommissionOn.Value = 'GO') or (optCommissionOn.Value = 'LO');
end;

initialization
  RegisterClassOnce(TfmProductCommissions);

end.
