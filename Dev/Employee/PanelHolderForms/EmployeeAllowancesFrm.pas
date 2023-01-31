unit EmployeeAllowancesFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DNMPanel, Wwdotdot, Wwdbcomb, Mask,
  wwdbedit, StdCtrls, wwdblook, Buttons, Wwdbigrd, Grids, Wwdbgrid, DB,
  MemDS, DBAccess, MyAccess,ERPdbComponents,BusObjEmployeePay,BusObjBase, frmBase,MessageConst,BaseInputForm, ProgressDialog, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts;

type
  TfrmEmployeeAllowances = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DSEmployeeallowances: TDataSource;
    qryAllowances: TERPQuery;
    qryBasedOn: TERPQuery;
    qryCustomers: TERPQuery;
    qryDepartment: TERPQuery;
    StringField1: TWideStringField;
    StringField2: TWideStringField;
    AutoIncField1: TAutoIncField;
    grdAllowances: TwwDBGrid;
    grdAllowancesIButton: TwwIButton;
    cboAllowance: TwwDBLookupCombo;
    AllowQty: TwwDBEdit;
    cbpAllowanceBasedOn: TwwDBLookupCombo;
    AllowAmount: TwwDBEdit;
    cboAllowCalcBy: TwwDBComboBox;
    cboAllowanceJob: TwwDBLookupCombo;
    cboAllowanceDept: TwwDBLookupCombo;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    cboAreaCode: TwwDBLookupCombo;
    procedure cboAllowanceCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdAllowancesIButtonClick(Sender: TObject);
    procedure SetSubEmpPay(Const Value :Temployeepay );
    procedure cboAllowanceNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    fSubEmpPay:Temployeepay;
//    procedure HandleEmployeeAllowanceErrors;
    procedure OnMyMessage(var Msg: TMessage); message WM_SetGridFocus;
  public
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);override;
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
  end;

implementation

{$R *.dfm}

uses
  BusObjConst, CommonLib, AppEnvironment, tcTypes, frmAllowancesFrm, frmAllowancesFrmUSA;

procedure TfrmEmployeeAllowances.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;
end;

procedure TfrmEmployeeAllowances.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
var
  ErrorCode: integer;
begin
  inherited;
  if Value = BusobjEventVal_FailedAllowancesValidateData then begin
    ErrorCode := StrToIntDef(EventType,0);
    case ErrorCode of
      BOR_EmployeeAllowance_Err_NoDescription : begin
                                                  grdAllowances.SetActiveField('Allowance');
                                                end;
      BOR_EmployeeAllowance_Err_NoAmount      : begin
                                                  grdAllowances.SetActiveField('Amount');
                                                end;
      BOR_EmployeeAllowance_Err_NoBasedOnID   : begin
                                                  grdAllowances.SetActiveField('BasedOn');
                                                end;
      BOR_EmployeeAllowance_Err_NoDepartment  : begin
                                                  grdAllowances.SetActiveField('ClassName');
                                                end;
      BOR_EmployeeAllowance_Err_NoCalcBy      : begin
                                                  grdAllowances.SetActiveField('CalcBy');
                                                end;
    end;
  end;
end;

procedure TfrmEmployeeAllowances.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := true;
  AllowGridSorting := True;
  inherited;
end;

//procedure TfrmEmployeeAllowances.HandleEmployeeAllowanceErrors;
//var
//  FatalStatusItem: TResultStatusItem;
//begin
//  if not Assigned(SubEmpPay) then exit;
//  FatalStatusItem := SubEmpPay.EmployeeAllowances.ResultStatus.GetLastFatalStatusItem;
//  if Assigned(FatalStatusItem) then begin
//    SetControlFocus(grdAllowances);
//    case FatalStatusItem.Code of
//      BOR_EmployeeAllowance_Err_NoDescription : begin
//                                                  grdAllowances.SetActiveField('Allowance');
//                                                end;
//      BOR_EmployeeAllowance_Err_NoAmount      : begin
//                                                  grdAllowances.SetActiveField('Amount');
//                                                end;
//      BOR_EmployeeAllowance_Err_NoBasedOnID   : begin
//                                                  grdAllowances.SetActiveField('BasedOn');
//                                                end;
//      BOR_EmployeeAllowance_Err_NoDepartment  : begin
//                                                  grdAllowances.SetActiveField('ClassName');
//                                                end;
//      BOR_EmployeeAllowance_Err_NoCalcBy      : begin
//                                                  grdAllowances.SetActiveField('CalcBy');
//                                                end;
//    end;
//  end;
//end;

procedure TfrmEmployeeAllowances.cboAllowanceCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  if not Assigned(SubEmpPay) then exit;
  SubEmpPay.EmployeeAllowances.Allowance := lookuptable.fieldbyname('description').asString;
  SubEmpPay.EmployeeAllowances.AddAllowanceDetails;
end;

procedure TfrmEmployeeAllowances.grdAllowancesIButtonClick(
  Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not Assigned(SubEmpPay) then exit;
      SubEmpPay.EmployeeAllowances.Delete;
      SubEmpPay.EmployeeAllowances.Dirty := True;
    finally
    end;
  end;
end;

procedure TfrmEmployeeAllowances.cboAllowanceNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
var
  frm:TComponent;
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This Allowance does not exist. Do you want to create it?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    Processingcursor(True);
    try

      if AppEnv.RegionalOptions.RegionType = rUSA then
      begin
         frm:=GetComponentByClassName('TfrmAllowancesUSA');

         if not assigned(frm) then exit;
         with TfrmAllowancesUSA(frm) do begin
            NewName := NewValue;
            if ShowModal = mrOK then begin
              qryAllowances.Close;
              qryAllowances.Open;
            end;
         end;

      end
      else
      begin
         frm:=GetComponentByClassName('TfrmAllowances');

         if not assigned(frm) then exit;
         with TfrmAllowances(frm) do begin
            NewName := NewValue;
            if ShowModal = mrOK then begin
              qryAllowances.Close;
              qryAllowances.Open;
            end;
         end;

      end;



    finally
      if NewValue <> '' then begin
        if qryAllowances.Locate('Description', NewValue, [loCaseInsensitive]) then begin
          cboAllowance.Text := NewValue;
          cboAllowance.PerformSearch;
          cboAllowanceCloseUp(cboAllowance ,cboAllowance.Lookuptable, cboAllowance.datasource.dataset , True);
        end;
        Accept := true;
      end;
      Processingcursor(False);
    end;
  end else
    cboAllowance.SetFocus;
end;

procedure TfrmEmployeeAllowances.OnMyMessage(var Msg: TMessage);
begin
  grdAllowances.SetActiveField('Allowance');
end;


initialization
  RegisterClassOnce(TfrmEmployeeAllowances);

end.
