unit frmProductCommission;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, ExtCtrls,
  StdCtrls, wwcheckbox, DNMSpeedButton, Shader, DNMPanel, ImgList, Menus,
  AdvMenus, DataState, SelectionDialog, AppEvnts, Mask, wwdbedit, wwdblook,
  busobjProductcommission, BusObjBase, Grids, Wwdbigrd, Wwdbgrid, DBCtrls,
  wwclearbuttongroup, wwradiogroup, ProgressDialog;

type
  TfmProductCommission = class(TBaseInputGUI)
    pnlTop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlBottom: TDNMPanel;
    Label50: TLabel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
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
    QryEmployee: TERPQuery;
    qryParts: TERPQuery;
    qryPartsPartsId: TIntegerField;
    qryPartsPartname: TWideStringField;
    QryEmployeeEmployeeID: TIntegerField;
    QryEmployeeemployeename: TWideStringField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblEmployee: TLabel;
    cboPartName: TwwDBLookupCombo;
    cboemployee: TwwDBLookupCombo;
    chkIsPercentage: TwwCheckBox;
    wwCheckBox2: TwwCheckBox;
    wwDBEdit1: TwwDBEdit;
    btnGenerate: TDNMSpeedButton;
    btnProdList: TDNMSpeedButton;
    dsProdcommission: TDataSource;
    qryProdcommissionEmployeeName: TWideStringField;
    optCommissionOnPaid: TwwRadioGroup;
    optCommissionInvoiceExPrice: TwwRadioGroup;
    lblOHbase: TLabel;
    edtOverheadbaserate: TDBEdit;
    Label5: TLabel;
    qryProdcommissionCommissionOnPaid: TWideStringField;
    qryProdcommissionCommissionInvoiceExPrice: TWideStringField;
    qryProdcommissionOverheadbaserate: TFloatField;
    DNMPanel2: TDNMPanel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    optCommissionOn: TwwRadioGroup;
    qryProdcommissionCommissionOn: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnProdListClick(Sender: TObject);
    procedure cboPartNameDblClick(Sender: TObject);
    procedure cboPartNameBeforeDropDown(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGenerateClick(Sender: TObject);
    procedure cboPartNameCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboemployeeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure chkIsPercentageClick(Sender: TObject);
    procedure edtOverheadbaserateEnter(Sender: TObject);
    procedure optCommissionOnChange(Sender: TObject);
  private
    Productcommission :TProductCommission;


    Procedure DisableLinksifmodal;
    procedure ProductGridDataSelect(Sender: TwwDbGrid);
    Procedure ApplyPercentage;
  Protected
    Procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;


implementation

uses DNMExceptions, BusObjConst, CommonLib, ProductListExpressForm,
  frmPartsFrm, ProductListForm, FormFactory, frmProductCommissions;


{$R *.dfm}

procedure TfmProductCommission.FormCreate(Sender: TObject);
begin
  inherited;
  if ErrorOccurred then Exit;
  Productcommission :=TProductCommission.create(Self);
  Productcommission.connection := TMyDacDataConnection.create(Productcommission);
  Productcommission.connection.Connection := MyConnection;
  Productcommission.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmProductCommission.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  RollbackTransaction;
  Action := caFree;

end;

procedure TfmProductCommission.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if ErrorOccurred then Exit;
      Productcommission.Load(KeyID);
      if keyId = 0 then Productcommission.New;
      OpenQueries;
    if KeyID=0 then begin
      cboPartName.ReadOnly := false;
    end else begin
      cboPartName.ReadOnly := true;
      ApplyPercentage;
    end;
    DisableLinksifmodal;

    except
      // Handle these known exceptions.
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmProductCommission.btnSaveClick(Sender: TObject);
begin
  inherited;
  if not Productcommission.Save then exit;
  CommitTransaction;
  Notify;
  Close;

end;

procedure TfmProductCommission.btnNewClick(Sender: TObject);
begin
  inherited;
  if Productcommission.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if not Productcommission.Save then
          else begin
            CommitTransaction;
            Notify;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
        end;
      mrCancel:
        begin
          Exit;
        end;
    end;
  end;
  Productcommission.new;
  cboPartName.ReadOnly := false;
end;

procedure TfmProductCommission.btnCancelClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfmProductCommission.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if Productcommission.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if Productcommission.Save then begin
            CommitTransaction;
            Notify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          CanClose := true;
        end;
      mrCancel: 
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
  end;

end;

procedure TfmProductCommission.DoBusinessObjectEvent(const Sender: TDatasetBusObj;
  const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TProductcommission then TProductcommission(Sender).Dataset := QryProdcommission;
  end else if (Eventtype = BusObjEvent_Change) and (Value =BusobjEventVal_IsPercentage) then begin
        if Productcommission.IsPercentage then begin
          QryProdcommissionCommissionRate.DisplayFormat := '###0.00###"%"';
        end else begin
          QryProdcommissionCommissionRate.DisplayFormat := '"$"####,###,###,##0.00';
        end;
        ApplyPercentage;
  end else if (Eventtype = BusObjEvent_Change) and (Value =BusobjEventVal_ForAllEmployees) then begin
    cboemployee.enabled := not Productcommission.ForAllEmployees;
    lblEmployee.enabled := not Productcommission.ForAllEmployees;
  end;
end;

procedure TfmProductCommission.btnProdListClick(Sender: TObject);
var
  Form:Tcomponent;
begin
  inherited;
  if (Productcommission.CleanID =0) or (QryProdcommissionPartsId.AsInteger =0) then begin
    if not FormStillOpen('TProductListExpressGUI') then begin
      with TProductListExpressGUI(GetComponentByClassName ('TProductListExpressGUI')) do begin
          OnGridDataSelect := ProductGridDataSelect;
          FormStyle        := fsMdiChild;
          BringToFront;
      end;
    end;
  end else begin
    if not FormStillOpen('TfrmParts') then begin
      Form := GetComponentByClassName('TfrmParts');
      if Assigned(Form) then begin //if has acess
        with TfrmParts(Form) do begin
          KeyId     := QryProdcommissionPartsId.AsInteger;
          FormStyle := fsMdiChild;
          BringToFront;
        end;
      end;
    end;
  end;
end;

procedure TfmProductCommission.cboPartNameDblClick(Sender: TObject);
begin
  inherited;
  btnProdList.Click;
end;

procedure TfmProductCommission.cboPartNameBeforeDropDown(Sender: TObject);
begin
  inherited;
  if cboPartName.ReadOnly then Abort;
end;

procedure TfmProductCommission.FormDestroy(Sender: TObject);
begin
  Freeandnil(Productcommission);
  inherited;
end;

procedure TfmProductCommission.btnGenerateClick(Sender: TObject);
begin
  inherited;
  if Productcommission.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if not Productcommission.Save then exit;
          CommitTransaction;
        end;
      mrNo:begin
        Productcommission.dirty := false;
        RollbackTransaction;
        end;
      mrCancel:exit;
    end;
  end;

  if not FormStillOpen('TfmProductCommissions') then begin
    with TfmProductCommissions(GetComponentByClassName('TfmProductCommissions', true)) do begin
      FormStyle := fsMdiChild;
      (*Productlistmode :=   tCommissionList;*)
      BringToFront;
    end;
    Application.ProcessMessages;
    Self.Close;
  end;
end;

procedure TfmProductCommission.cboPartNameCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  Productcommission.PartsId := qryPartsPartsId.asInteger;
  Productcommission.Partname := qryPartsPartName.asString;

end;

procedure TfmProductCommission.cboemployeeCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  Productcommission.EmployeeId := QryemployeeEmployeeID.asInteger;

end;

procedure TfmProductCommission.DisableLinksifmodal;
begin
  btnProdList.enabled := not(fsModal in FormState);
  btnNew.enabled := not(fsModal in FormState);
  btnProdList.enabled := not(fsModal in FormState);
  btnGenerate.enabled := not(fsModal in FormState);
  if FormStillOpen('TProductListGUI') then btnGenerate.enabled := False;
end;

procedure TfmProductCommission.ProductGridDataSelect(Sender: TwwDbGrid);
begin
  // Set the product combo to selected part
  if cboPartName.LookupTable.Locate('PartsId', Sender.DataSource.DataSet.FieldByName('PartsId').AsInteger, []) then begin
    cboPartName.Text := Sender.DataSource.DataSet.FieldByName('ProductName').AsString;
    // Set datafield value
    QryProdcommissionPartsId.AsInteger := Sender.DataSource.DataSet.FieldByName('PartsId').AsInteger;
    QryprodcommissionPartName.asString :=Sender.DataSource.DataSet.FieldByName('Partname').asString;
  end;
end;
procedure TfmProductCommission.chkIsPercentageClick(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = chkIsPercentage then  begin
    Productcommission.EditDB;
    Productcommission.IsPercentage :=chkIsPercentage.checked;
    Productcommission.PostDB;
    Productcommission.EditDB;
  end;
end;

procedure TfmProductCommission.ApplyPercentage;
begin
  optCommissionOn.enabled :=Productcommission.IsPercentage;
  optCommissionInvoiceExPrice.enabled :=Productcommission.IsPercentage;
  edtOverheadbaserate.enabled :=Productcommission.IsPercentage;
  lblOHbase.enabled :=Productcommission.IsPercentage;
end;

procedure TfmProductCommission.edtOverheadbaserateEnter(Sender: TObject);
begin
  inherited;
  if    (optCommissionOn.Value <> 'GO')
    and (optCommissionOn.Value <> 'LO') then
    SetControlFocus(optCommissionOn);
  edtOverheadbaserate.Enabled := (optCommissionOn.Value = 'GO') or (optCommissionOn.Value = 'LO');
  lblOHbase.Enabled           := (optCommissionOn.Value = 'GO') or (optCommissionOn.Value = 'LO');
end;

procedure TfmProductCommission.optCommissionOnChange(Sender: TObject);
begin
  inherited;
  edtOverheadbaserate.Enabled := (optCommissionOn.Value = 'GO') or (optCommissionOn.Value = 'LO');
  lblOHbase.Enabled           := (optCommissionOn.Value = 'GO') or (optCommissionOn.Value = 'LO');
end;

initialization
  RegisterClassOnce(TfmProductCommission);
  with FormFact do begin
    RegisterMe(TfmProductCommission, 'TProductCommissionListGUI_*=ProductCommissionId');
    RegisterMe(TfmProductCommission, 'TProductListGUI_CommissionRate=ProductCommissionId');
    RegisterMe(TfmProductCommission, 'TProductListGUI_CommIsPercent=ProductCommissionId');
    RegisterMe(TfmProductCommission, 'TProductQtylistGUI_CommissionRate=ProductCommissionId');
    RegisterMe(TfmProductCommission, 'TProductQtylistGUI_CommIsPercent=ProductCommissionId');
  end;
end.
