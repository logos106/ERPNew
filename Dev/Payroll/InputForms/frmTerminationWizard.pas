unit frmTerminationWizard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseWizard, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton, AdvPicture, StdCtrls, Shader, ExtCtrls, DNMPanel,
  BusObjEmployeeTermination, BusObjBase, BaseInputForm, Mask, wwdbedit,
  Wwdotdot, Wwdbcomb, wwdbdatetimepicker, wwdblook, wwclearbuttongroup,
  wwradiogroup, AdvEdit, DBAdvEd, Grids, AdvObj, BaseGrid, AdvGrid, ComCtrls,
  ProgressDialog;

type
  TfmTerminationWizard = class(TBaseInputGUI)
    qryTermination: TERPQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    sbMain: TScrollBox;
    pnlWizEmployee: TDNMPanel;
    Label21: TLabel;
    cboName: TwwDBLookupCombo;
    Label1: TLabel;
    Label56: TLabel;
    dtpTerminationDate: TwwDBDateTimePicker;
    Label2: TLabel;
    Label8: TLabel;
    cboReason: TwwDBComboBox;
    pnlWizDeath: TDNMPanel;
    lblDeath: TLabel;
    cboDeathPaidTo: TwwDBComboBox;
    dsTermination: TDataSource;
    qryEmployees: TERPQuery;
    pnlWizPay: TDNMPanel;
    Label11: TLabel;
    rgPayStatus: TwwRadioGroup;
    lblPrepare: TLabel;
    btnPay: TDNMSpeedButton;
    lblReasonNote: TLabel;
    pnlWizUnusedAnnualLeaveDetail: TDNMPanel;
    edtAnnualLeaveAmount1: TDBAdvEdit;
    edtAnnualLeaveLoading1: TDBAdvEdit;
    edtAnnualLeaveTotal1: TDBAdvEdit;
    edtAnnualLeaveTax1: TDBAdvEdit;
    edtAnnualLeaveAmount2: TDBAdvEdit;
    edtAnnualLeaveLoading2: TDBAdvEdit;
    edtAnnualLeaveTotal2: TDBAdvEdit;
    edtAnnualLeaveTax2: TDBAdvEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    pnlWizUnusedAnnualLeaveTotal: TDNMPanel;
    Label12: TLabel;
    edtAnnualLeaveAmount: TDBAdvEdit;
    Label13: TLabel;
    edtAnnualLeaveLoading: TDBAdvEdit;
    Label14: TLabel;
    edtAnnualLeaveTotal: TDBAdvEdit;
    Label15: TLabel;
    edtAnnualLeaveTax: TDBAdvEdit;
    Label16: TLabel;
    rgTFNSupplied: TwwRadioGroup;
    rgResident: TwwRadioGroup;
    Label17: TLabel;
    dtStartDate: TwwDBDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cboReasonChange(Sender: TObject);
    procedure rgPayStatusChange(Sender: TObject);
    procedure rgPayStatusClick(Sender: TObject);
    procedure AdvStringGrid1GetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
  private
    procedure Initialise;
//    procedure HidePanels(PanelsToHide: string; PanelsNotToHide: string = '');
//    procedure ShowPanels(PanelsToShow: string; PanelsNotToShow: string = '');
    procedure SetPanelsReadOnly(aValue: boolean);
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    EmpTerm: TEmployeeTermination;
  end;

var
  fmTerminationWizard: TfmTerminationWizard;

implementation

{$R *.dfm}

uses
  BusObjConst, TypInfo;

procedure TfmTerminationWizard.AdvStringGrid1GetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  inherited;
  if (ACol = 0) and (ARow = 0) then
    ABrush.Style:= bsClear; // Color := DNMPanel2.Color;
end;

procedure TfmTerminationWizard.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmTerminationWizard.btnOKClick(Sender: TObject);
begin
  inherited;
  EmpTerm.PostDb;
  if empTerm.Save then begin
    self.CommitTransaction;
    Close;
  end;
end;

procedure TfmTerminationWizard.cboReasonChange(Sender: TObject);
begin
  inherited;
  if TwwDbComboBox(Sender).Focused then begin
    TwwDbComboBox(Sender).DataSource.DataSet.FieldByName(TwwDbComboBox(Sender).DataField).AsString :=
       TwwDbComboBox(Sender).Text;
  end;
end;

procedure TfmTerminationWizard.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TEmployeeTermination then TEmployeeTermination(Sender).Dataset := qryTermination;
  end
  else if (EventType = BusObjEvent_Change) or (EventType = BusObjEvent_OnDataIDChange) then begin
    if (EventType = BusObjEvent_OnDataIDChange) or (Value = 'TaxFileNumberProvided') then begin
      if EmpTerm.TaxFileNumberProvided then rgTFNSupplied.ItemIndex := 0
      else rgTFNSupplied.ItemIndex := 0;
    end;
    if (EventType = BusObjEvent_OnDataIDChange) or (Value = 'Resident') then begin
      if EmpTerm.Resident then rgResident.ItemIndex := 0
      else rgResident.ItemIndex := 0;
    end;
    if (EventType = BusObjEvent_OnDataIDChange) or (Value = 'DeathBenefit') then begin
      pnlWizDeath.Visible := EmpTerm.DeathBenefit;
    end;
    if (EventType = BusObjEvent_OnDataIDChange) or (Value = 'ReasonLeft') then begin
      lblReasonNote.Caption := EmpTerm.TerminationReasonNote;
    end;
    if (EventType = BusObjEvent_OnDataIDChange) or (Value = 'PayEntitled') then begin
      btnPay.Enabled := EmpTerm.PayEntitled;
    end;
  end;
end;

procedure TfmTerminationWizard.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmTerminationWizard.FormCreate(Sender: TObject);
begin
  inherited;
  EmpTerm:= TEmployeeTermination.Create(self);
  EmpTerm.Connection:= TMyDacDataConnection.Create(EmpTerm);
  EmpTerm.Connection.Connection := MyConnection;
  EmpTerm.BusObjEvent := DoBusinessObjectEvent;

end;

procedure TfmTerminationWizard.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    self.BeginTransaction;
    Initialise;
  finally
    EnableForm;
  end;
end;

//procedure TfmTerminationWizard.HidePanels(PanelsToHide,
//  PanelsNotToHide: string);
//var
//  HideList, NotToHideList: TStringList;
//  x: integer;
//begin
//  HideList := TStringList.Create;
//  NotToHideList := TStringList.Create;
//  try
//    HideList.CommaText := PanelsToHide;
//    NotToHideList.CommaText := PanelsNotToHide;
//    for x:= 0 to self.ComponentCount -1 do begin
//      if (self.Components[x] is TDNMPanel) and (Pos('pnlWiz',Components[x].Name) = 1) then begin
//        if (HideList.IndexOf(Components[x].Name) > -1) or
//           ((HideList.Count = 0) and (NotToHideList.IndexOf(Components[x].Name) = -1)) then
//          TDNMPanel(Components[x]).Visible := false;
//      end;
//    end;
//  finally
//    HideList.Free;
//    NotToHideList.Free;
//  end;
//end;

procedure TfmTerminationWizard.Initialise;
begin
//  HidePanels('','pnlWizEmployee');
  cboReason.Items.CommaText := EmpTerm.TerminationReasonsCommaText;
  cboDeathPaidTo.Items.CommaText := EmpTerm.DeathBenefitPaidToCommaText;
  lblReasonNote.Caption := '';
  CloseDB(qryEmployees);
  OpenDB(qryEmployees);
  if Self.KeyID <> 0 then begin
    EmpTerm.Load(Self.KeyID);
    if EmpTerm.Complete then begin
      SetPanelsReadOnly(true);

    end;
  end else begin
    EmpTerm.Load(0);
    EmpTerm.New;
  end;

end;

procedure TfmTerminationWizard.rgPayStatusChange(Sender: TObject);
begin
  inherited;
//  if rgPayStatus.Focused then
//    qryTermination.FieldByName('IsPayEntitled').AsBoolean := rgPayStatus.ItemIndex = 0;
end;

procedure TfmTerminationWizard.rgPayStatusClick(Sender: TObject);
begin
  inherited;
  qryTermination.FieldByName('IsPayEntitled').AsBoolean := rgPayStatus.ItemIndex = 0;
end;

procedure TfmTerminationWizard.SetPanelsReadOnly(aValue: boolean);
var
  x,y: integer;
  control: TControl;
begin
  for x := 0 to ComponentCount -1 do begin
    if (self.Components[x] is TDNMPanel) and (Pos('pnlWiz',Components[x].Name) = 1) then begin
      for y := 0 to TDNMPanel(Components[x]).ControlCount -1 do begin
        control := TDNMPanel(Components[x]).Controls[y];
        if (control is TLabel) then continue;
        if IsPublishedProp(control,'ReadOnly') then SetPropValue(control, 'ReadOnly', aValue)
        else if IsPublishedProp(control,'Enabled') then SetPropValue(control, 'Enabled', not aValue);


      end;
    end;
  end;
end;

//procedure TfmTerminationWizard.ShowPanels(PanelsToShow,
//  PanelsNotToShow: string);
//var
//  ShowList, NotToShowList: TStringList;
//  x: integer;
//begin
//  ShowList := TStringList.Create;
//  NotToShowList := TStringList.Create;
//  try
//    ShowList.CommaText := PanelsToShow;
//    NotToShowList.CommaText := PanelsNotToShow;
//    for x:= 0 to self.ComponentCount -1 do begin
//      if (self.Components[x] is TDNMPanel) and (Pos('pnlWiz',Components[x].Name) = 1) then begin
//        if (ShowList.IndexOf(Components[x].Name) > -1) or
//           ((ShowList.Count = 0) and (NotToShowList.IndexOf(Components[x].Name) = -1)) then
//          TDNMPanel(Components[x]).Visible := true;
//      end;
//    end;
//  finally
//    ShowList.Free;
//    NotToShowList.Free;
//  end;
//end;

initialization
  RegisterClass(TfmTerminationWizard);

end.
