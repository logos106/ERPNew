unit EmployeeSuperFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,BusObjEmployeePay, ExtCtrls, DNMPanel, Mask, wwdbedit, Wwdotdot,
  Wwdbcomb, wwdbdatetimepicker, StdCtrls, wwdblook, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, BusObjBase, frmBase,BaseInputForm, ProgressDialog, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts;

type
  TEmployeeSuper = Class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DSSuperannuation: TDataSource;
    qrySuperType: TERPQuery;
    qrySuppliers: TERPQuery;
    qryDepartment: TERPQuery;
    StringField1: TWideStringField;
    StringField2: TWideStringField;
    AutoIncField1: TAutoIncField;
    grdSuperannuation: TwwDBGrid;
    grdSuperannuationIButton: TwwIButton;
    cboSuperType: TwwDBLookupCombo;
    cboSuperFund: TwwDBLookupCombo;
    DateJoined: TwwDBDateTimePicker;
    cboDP: TwwDBComboBox;
    cboSuperDepartment: TwwDBLookupCombo;
    edAmount: TwwDBEdit;
    DSPension: TDataSource;
    qryUkPensionType: TERPQuery;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    cboAreaCode: TwwDBLookupCombo;
    procedure SetSubEmpPay(Const Value :Temployeepay );
    procedure cboSuperFundCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboPensionFundCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure wwIButton1Click(Sender: TObject);
    procedure cboSuperFundNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; var Accept: Boolean);
    procedure grdSuperannuationIButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fSubEmpPay:Temployeepay;
//    procedure HandleEmployeeSuperErrors;
  public
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);override;
  end;


implementation

{$R *.dfm}
uses
  BusObjConst,CommonLib,BusObjSuperannuation,frmSupplier,MessageConst;

procedure TEmployeeSuper.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;
end;

//procedure TEmployeeSuper.HandleEmployeeSuperErrors;
//var
//  FatalStatusItem: TResultStatusItem;
//begin
//  if not Assigned(SubEmpPay) then exit;
//  FatalStatusItem := SubEmpPay.EmployeeDetails.ResultStatus.GetLastFatalStatusItem;
//  if Assigned(FatalStatusItem) then begin
//    case FatalStatusItem.Code of
//      BOR_EmployeeSuper_Err_NoType            : begin
//                                                  grdSuperannuation.SetActiveField('SuperType');
//                                                  SetControlFocus(cboSuperType);
//                                                end;
//      BOR_EmployeeSuper_Err_NoAmount          : begin
//                                                  grdSuperannuation.SetActiveField('Amount');
//                                                  SetControlFocus(edAmount);
//                                                end;
//      BOR_EmployeeSuper_Err_DateJoined        : begin
//                                                  grdSuperannuation.SetActiveField('DateJoined');
//                                                  SetControlFocus(DateJoined);
//                                                end;
//      BOR_EmployeeSuper_Err_NoDepartment      : begin
//                                                  grdSuperannuation.SetActiveField('ClassName');
//                                                  SetControlFocus(cboSuperDepartment);
//                                                end;
//      BOR_EmployeeSuper_Err_NoCalcBy          : begin
//                                                  grdSuperannuation.SetActiveField('CalcBy');
//                                                  SetControlFocus(cboDP);
//                                                end;
//      BOR_EmployeeSuper_Err_NoFund            : begin
//                                                  grdSuperannuation.SetActiveField('SuperFund');
//                                                  SetControlFocus(cboSuperFund);
//                                                end;
//    end;
//  end;
//end;

procedure TEmployeeSuper.cboSuperFundCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not modified then exit;
  Tsuperannuation(SubEmpPay.Superannuation).Clientid := LookupTable.FieldByName('ClientID').AsInteger;
end;

procedure TEmployeeSuper.cboPensionFundCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
 // Tukpension(SubEmpPay.Superannuation).Clientid := LookupTable.FieldByName('ClientID').AsInteger;
end;

procedure TEmployeeSuper.wwIButton1Click(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not Assigned(SubEmpPay) then exit;
      SubEmpPay.Superannuation.Delete;
    finally
    end;
  end;
end;

procedure TEmployeeSuper.cboSuperFundNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
  var
  frm:TComponent;
begin
  inherited;
  frm := nil;
  Accept := false;
  if CommonLib.MessageDlgXP_Vista('This supplier is not in the list.Do you wish to add it?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      Processingcursor(True);
      frm := GetComponentByClassName('TfmSupplier',false);
      if Assigned(frm) then begin
        with TfmSupplier(frm) do begin
          KeyID := 0;
          NewCompanyName := NewValue; 
          if ShowModal = mrOK then begin
           qrySuppliers.Close;
           qrySuppliers.Open;
         end;
        end;
      end;
    finally
      if NewValue <> '' then begin
        if qrySuppliers.Locate('Company', NewValue, [loCaseInsensitive]) then begin
          cboSuperFund.Text := NewValue;
          cboSuperFund.PerformSearch;
        end;
        Accept := true;
        if FormStillOpen('TfrmEmployee') then frm := FindExistingComponent('TfrmEmployee');
        if Assigned(frm) then PostMessage(TForm(frm).Handle, SX_InvalidatePanelHolderFrm, 0, 0);
      end;
      Processingcursor(False);
    end;
  end else cboSuperFund.SetFocus;
end;

procedure TEmployeeSuper.grdSuperannuationIButtonClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not Assigned(SubEmpPay) then exit;
      SubEmpPay.Superannuation.Delete;
      SubEmpPay.Superannuation.Dirty := True;
    finally
    end;
  end;
end;

procedure TEmployeeSuper.DoBusinessObjectEvent( const Sender: TDatasetBusObj; const EventType, Value: string);
var
  ErrorCode: integer;
begin
  inherited;
  if Value = BusobjEventVal_FailedSuperannuationValidateData then begin
//    HandleEmployeeSuperErrors;
    ErrorCode := StrToIntDef(EventType,0);
    case ErrorCode of
      BOR_EmployeeSuper_Err_NoType            : begin
                                                  grdSuperannuation.SetActiveField('SuperType');
                                                  SetControlFocus(cboSuperType);
                                                end;
      BOR_EmployeeSuper_Err_NoAmount          : begin
                                                  grdSuperannuation.SetActiveField('Amount');
                                                  SetControlFocus(edAmount);
                                                end;
      BOR_EmployeeSuper_Err_DateJoined        : begin
                                                  grdSuperannuation.SetActiveField('DateJoined');
                                                  SetControlFocus(DateJoined);
                                                end;
      BOR_EmployeeSuper_Err_NoDepartment      : begin
                                                  grdSuperannuation.SetActiveField('ClassName');
                                                  SetControlFocus(cboSuperDepartment);
                                                end;
      BOR_EmployeeSuper_Err_NoCalcBy          : begin
                                                  grdSuperannuation.SetActiveField('CalcBy');
                                                  SetControlFocus(cboDP);
                                                end;
      BOR_EmployeeSuper_Err_NoFund            : begin
                                                  grdSuperannuation.SetActiveField('SuperFund');
                                                  SetControlFocus(cboSuperFund);
                                                end;
    end;
  end;
end;

procedure TEmployeeSuper.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := true;
  AllowGridSorting := True;
  inherited;
end;

initialization
  RegisterClassOnce(TEmployeeSuper);
end.
