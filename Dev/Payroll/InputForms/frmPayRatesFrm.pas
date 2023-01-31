unit frmPayRatesFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, AppEvnts, DB, ExtCtrls, DNMPanel, wwdblook,
  Wwdotdot, Wwdbcomb, StdCtrls, DBCtrls, Mask, wwdbedit, Buttons, DNMSpeedButton, kbmMemTable,
  SelectionDialog, wwcheckbox, DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, MemDS,
  Shader, ImgList, BusObjPayRate,  BusObjBase, ProgressDialog  ;

type
  TfrmPayRates = class(TBaseInputGUI)
    qryPayRate: TERPQuery;
    DSPayRate: TDataSource;
    edtDescription: TwwDBEdit;
    Label1: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label2: TLabel;
    edtMultiplier: TwwDBEdit;
    cmdNew: TDNMSpeedButton;
    memQryPayRate: TkbmMemTable;
    Label3: TLabel;
    Bevel1: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    chkIsPayRate: TwwCheckBox;
    qryPayRateRateID: TAutoIncField;
    qryPayRateDescription: TWideStringField;
    qryPayRateMultiplier: TFloatField;
    qryPayRateEditedFlag: TWideStringField;
    qryPayRateIsPayRate: TWideStringField;
    memQryPayRateRateID: TAutoIncField;
    memQryPayRateDescription: TWideStringField;
    memQryPayRateMultiplier: TFloatField;
    memQryPayRateEditedFlag: TWideStringField;
    memQryPayRateIsPayRate: TWideStringField;
    Label143: TLabel;
    chkActive: TDBCheckBox;
    qryPayRateActive: TWideStringField;
    Label6: TLabel;
    cboParentRate: TwwDBLookupCombo;
    qryPayRates: TERPQuery;
    qryPayRateMultiplierParentID: TIntegerField;
    qryPayRateIsLeave: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryPayRateIsSuperEnabled: TWideStringField;
    chksuper: TwwCheckBox;
    Label7: TLabel;
    Label8: TLabel;
    chkAccrueLeave: TwwCheckBox;
    Label9: TLabel;
    Label10: TLabel;
    qryPayRateAccrueLeave: TWideStringField;
    qryPayRateExtraLeaveAccrual: TWideStringField;
    qryPayRateExtraLeaveMultiplier: TFloatField;
    Bevel2: TBevel;
    chkExtraLeaveAccrual: TwwCheckBox;
    Label11: TLabel;
    cboExtraLeaveType: TwwDBLookupCombo;
    qryLeaveTypes: TERPQuery;
    Label12: TLabel;
    Label13: TLabel;
    edtExtraLeaveMultiplier: TwwDBEdit;
    qryPayRateExtraLeaveTypeID: TIntegerField;
    Label14: TLabel;
    cboIncomeType: TwwDBComboBox;
    qryPayRateIncomeType: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure qryPayRateIsPayRateChange(Sender: TField);
    procedure chkIsPayRateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkExtraLeaveAccrualClick(Sender: TObject);
  private
    { Private declarations }
    fsNewDescription: string;
    fsIsLeave:String;
    PayRate :TPayRate;

    procedure EnableDisableMultiplier;
    procedure NewPayRate;
    procedure SetMultiplierPayRate;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Function GetMainTablename:String; override;

  public
    { Public declarations }
    
    property NewDescription: string read fsNewDescription write fsNewDescription;
    property IsLeave:string read fsIsLeave write fsIsLeave;
  end;

implementation

uses FormFactory, DnMExceptions, CommonDbLib, PayCommon, CommonLib,
  BusObjConst, AppEnvironment;

{$R *.dfm}

procedure TfrmPayRates.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Closequeries;
  Action := caFree;
  
end;

procedure TfrmPayRates.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmPayRates.btnSaveClick(Sender: TObject);
var
  qry: TERPCommand;
begin
  inherited;
  if Empty(edtDescription.Text) then begin
    CommonLib.MessageDlgXP_Vista('You must provide a Description', mtWarning, [mbOK], 0);
    SetControlFocus(edtDescription);
    Exit;
  end;
  if self.qryPayRateExtraLeaveAccrual.AsBoolean then begin
    if self.qryPayRateExtraLeaveTypeID.AsInteger < 1 then begin
      CommonLib.MessageDlgXP_Vista('You must select a Leave Type', mtWarning, [mbOK], 0);
      SetControlFocus(cboExtraLeaveType);
      Exit;
    end;
  end;

  qry := TERPCommand.Create(self);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT HIGH_PRIORITY INTO tblallowancebasedon (GlobalRef, BasedOnID, BasedOn, EditedFlag)');
    qry.SQL.Add('VALUES (NULL, NULL, ' + QuotedStr(edtDescription.Text) + ', "T")');
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;

  qryPayRate.Post;
  Notify;
  Close;
end;

procedure TfrmPayRates.FormShow(Sender: TObject);
var
  sName: string;
begin
  try
    inherited;
    if qryPayRate.Active then begin
      qryPayRate.Post;
      Notify;
      CloseQueries;
    end;

    (*qryPayRate.ParamByName('KeyID').asInteger := KeyID;*)

    PayRate.Load(KeyID);
    if (KeyId > 0) then begin
      (*if not PayRate.Lock then begin*)
        if AccessLevel =  5 then
        CommonLib.MessageDlgXP_Vista(PayRate.UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access has been changed to read-only.',
          mtWarning, [mbOK], 0);
    end;


    qryPayRates.ParamByName('xKeyID').asInteger := KeyID;
    OpenQueries;

    chkActive.Enabled := true;
    label143.Enabled := true;
    edtMultiplier.Enabled := true;
    Label2.Enabled := true;
    cboParentRate.Enabled := true;
    Label6.Enabled := true;


    if KeyID > 0 then begin
      edtDescription.Enabled := False;
      qryPayRate.Edit;
      EnableDisableMultiplier;

      sName := qryPayRateDescription.AsString;
      if (sName = 'Annual Leave') or
         //(sName = 'Sick Leave') or
         (sName = Appenv.RegionalOptions.SLName ) or
         (sName = 'Termination') or
         (sName = 'Long Service') or
         (sName = 'Normal Hours') then begin
        chkActive.Enabled := false;
        label143.Enabled := false;
        if (sName = 'Normal Hours') then begin
          edtMultiplier.Enabled := false;
          Label2.Enabled := false;
          cboParentRate.Enabled := false;
          Label6.Enabled := false;
        end;
      end;
    end else begin
      NewPayRate;
    end;
    SetMultiplierPayRate;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
  SetControlFocus(edtDescription);
end;

procedure TfrmPayRates.cmdNewClick(Sender: TObject);
begin
  inherited;
  if Empty(edtDescription.Text) then begin
    CommonLib.MessageDlgXP_Vista('You must provide a Description', mtWarning, [mbOK], 0);
    SetControlFocus(edtDescription);
  end else begin
    edtDescription.Enabled := True;
    NewPayRate;
  end;
end;

procedure TfrmPayRates.qryPayRateIsPayRateChange(Sender: TField);
begin
  EnableDisableMultiplier;
end;

procedure TfrmPayRates.EnableDisableMultiplier;
begin
  if qryPayRate.State in [dsInsert, dsBrowse] then begin
    edtMultiplier.Enabled := chkIsPayRate.Checked;
    if not edtMultiplier.Enabled then begin
      edtMultiplier.Color := clSilver;
      qryPayRate.FieldByName('Multiplier').AsFloat := 1.0;
      cboParentRate.Enabled := edtMultiplier.Enabled;
    end else begin
      edtMultiplier.Color := clWhite;
      cboParentRate.Enabled := edtMultiplier.Enabled;
    end;
  end;
end;

procedure TfrmPayRates.NewPayRate;
begin
  qryPayRate.Insert;
  qryPayRate.FieldByName('Multiplier').AsFloat := 1.0;
  qryPayRate.FieldByName('IsPayRate').AsString := 'T';
  EnableDisableMultiplier;

  if NewDescription <> '' then begin
    qryPayRate.FieldByName('Description').AsString := NewDescription;
    edtDescription.Text := fsNewDescription;
    qryPayRate.FieldByName('IsLeave').AsString := fsIsLeave;
  end;
  
  SetControlFocus(edtDescription);
end;

procedure TfrmPayRates.chkExtraLeaveAccrualClick(Sender: TObject);
begin
  inherited;
  if not chkExtraLeaveAccrual.Checked then begin
    if self.qryPayRate.Active then begin
      if self.qryPayRateExtraLeaveTypeID.AsInteger > 0 then begin
        EditDb(qryPayRate);
        self.qryPayRateExtraLeaveTypeID.AsInteger:= 0;
      end;
      if self.qryPayRateExtraLeaveMultiplier.AsFloat <> 0 then begin
        EditDb(qryPayRate);
        self.qryPayRateExtraLeaveMultiplier.AsFloat:= 0;
      end;
    end;
  end;
end;

procedure TfrmPayRates.chkIsPayRateClick(Sender: TObject);
begin
  inherited;
  EnableDisableMultiplier;
end;

procedure TfrmPayRates.FormCreate(Sender: TObject);
begin
  inherited;
  qryPayRates.Connection := CommonDbLib.GetSharedMyDacConnection;
  PayRate := TPayRate.Create(Self);
  PayRate.Connection :=TMyDacDataConnection.Create(PayRate);
  PayRate.Connection.Connection := Self.MyConnection;
  PayRate.BusObjEvent := DoBusinessObjectEvent;
  UserLock.Enabled := true; 
end;

procedure TfrmPayRates.SetMultiplierPayRate;
begin
  if (qryPayRate.FieldByName('MultiplierParentID').AsInteger = 0) and cboParentRate.Enabled then begin
    qryPayRate.Edit;
    qryPayRate.FieldByName('MultiplierParentID').AsInteger := GetPayRateID('Normal Hours');
  end;
end;

procedure TfrmPayRates.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited ;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TPayRate         then TPayRate(Sender).DataSet     := qryPayRate;
    end;
end;

function TfrmPayRates.GetMainTablename: String;
begin
  REsult := 'tblPayRates';
end;

initialization
  RegisterClassOnce(TfrmPayRates);
  FormFact.RegisterMe(TfrmPayRates, 'TfrmPayRateList_*=RateID');
  FormFact.RegisterControl(TfrmPayRates, 'TfrmEmployee_LeaveType=LeaveType');
end.
