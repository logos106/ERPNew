unit EmployeePaySetupDeductions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DNMPanel, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  Mask, wwdbedit, Wwdotdot, Wwdbcomb, wwdblook, Buttons, Wwdbigrd, Grids,
  Wwdbgrid,BusObjEmployeePay,BusObjBase, frmBase,MessageConst,BaseInputForm, ProgressDialog, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts;

type
  TEmpPaySetupDeductions = class(TBaseInputGUI)

    DNMPanel1: TDNMPanel;
    grdDeductions: TwwDBGrid;
    grdDeductionsIButton: TwwIButton;
    cboDeduction: TwwDBLookupCombo;
    cboDeductBasedOn: TwwDBLookupCombo;
    cboDeductCalcBy: TwwDBComboBox;
    cboDeductionClass: TwwDBLookupCombo;
    DSEmployeedeductions: TDataSource;
    MyConnectionDeductions: TERPConnection;
    qryDeductions: TERPQuery;
    qryBasedOn: TERPQuery;
    qryDepartment: TERPQuery;
    StringField1: TWideStringField;
    StringField2: TWideStringField;
    AutoIncField1: TAutoIncField;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    cboAreaCode: TwwDBLookupCombo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cboDeductionCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdDeductionsIButtonClick(Sender: TObject);
    procedure SetSubEmpPay(Const Value :Temployeepay );
    procedure cboDeductCalcByCloseUp(Sender: TwwDBComboBox;
      Select: Boolean);
    procedure cboDeductionNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    fSubEmpPay:Temployeepay;
    fNewDeductionAdded: boolean;
//    procedure HandleEmployeeDeductionErrors;
    procedure OnMyMessage(var Msg: TMessage); message WM_SetGridFocus;
  public
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  end;                  

implementation

{$R *.dfm}

uses
  BusObjConst,CommonLib,AppEnvironment,frmDeductionsFrm;

procedure TEmpPaySetupDeductions.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;
end;

//procedure TEmpPaySetupDeductions.HandleEmployeeDeductionErrors;
//var
//  FatalStatusItem: TResultStatusItem;
//begin
//  if not Assigned(SubEmpPay) then exit;
//  FatalStatusItem := SubEmpPay.EmployeeDeductions.ResultStatus.GetLastFatalStatusItem;
//  if Assigned(FatalStatusItem) then begin
//    SetControlFocus(grdDeductions);
//    case FatalStatusItem.Code of
//      BOR_EmployeePay_Err_EmpNoDeduction  : begin
//                                               grdDeductions.SetActiveField('Deduction');
//                                             end;
//      BOR_EmployeePay_Err_EmpDeductionNoQty: begin
//                                               grdDeductions.SetActiveField('Qty');
//                                             end;
//      BOR_EmployeePay_Err_EmpDeductionNoBasedOn : begin
//                                                    grdDeductions.SetActiveField('BasedOn');
//                                                  end;
//      BOR_EmployeePay_Err_EmpDeductionNoDepartment:begin
//                                                     grdDeductions.SetActiveField('ClassName');
//                                                   end;
//      BOR_EmployeePay_Err_EmpNoAmount             :begin
//                                                    grdDeductions.SetActiveField('Amount');
//                                                   end;
//    end;
//  end;
//end;

procedure TEmpPaySetupDeductions.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TEmpPaySetupDeductions.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := true;
  AllowGridSorting := True;
  inherited;
end;

procedure TEmpPaySetupDeductions.cboDeductionCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if (not modified) and (not fNewDeductionAdded) then Exit;
  if not Assigned(SubEmpPay) then exit;
  SubEmpPay.EmployeeDeductions.AddDeductionDetails;
  cboDeductCalcBy.Text := SubEmpPay.EmployeeDeductions.Calcby;
  fNewDeductionAdded:= false;
end;

procedure TEmpPaySetupDeductions.grdDeductionsIButtonClick(
  Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not Assigned(SubEmpPay) then exit;
      SubEmpPay.EmployeeDeductions.Delete;
      SubEmpPay.EmployeeDeductions.Dirty := True;
    finally
    end;
  end;
end;

procedure TEmpPaySetupDeductions.cboDeductCalcByCloseUp(
  Sender: TwwDBComboBox; Select: Boolean);
begin
  if cboDeductCalcBy.Text = '%' then exit;

  if cboDeductCalcBy.Text <> AppEnv.RegionalOptions.CurrencySymbol then begin
    //shouldn't get here but lets be safe
    SubEmpPay.EmployeeDeductions.Calcby := AppEnv.RegionalOptions.CurrencySymbol;
    CommonLib.MessageDlgXP_Vista('CalcBy cannot be a non regional currency.', mtWarning, [mbOK], 0); 
  end;
end;

procedure TEmpPaySetupDeductions.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
var
  ErrorCode: integer;
begin
  inherited ;
  if Value = BusobjEventVal_FailedDeductionsValidateData then begin
//    HandleEmployeeDeductionErrors;
    SetControlFocus(grdDeductions);
    ErrorCode := StrToIntDef(EventType,0);
    case ErrorCode of
      BOR_EmployeePay_Err_EmpNoDeduction  : begin
                                               grdDeductions.SetActiveField('Deduction');
                                             end;
      BOR_EmployeePay_Err_EmpDeductionNoQty: begin
                                               grdDeductions.SetActiveField('Qty');
                                             end;
      BOR_EmployeePay_Err_EmpDeductionNoBasedOn : begin
                                                    grdDeductions.SetActiveField('BasedOn');
                                                  end;
      BOR_EmployeePay_Err_EmpDeductionNoDepartment:begin
                                                     grdDeductions.SetActiveField('ClassName');
                                                   end;
      BOR_EmployeePay_Err_EmpNoAmount             :begin
                                                    grdDeductions.SetActiveField('Amount');
                                                   end;
    end;
  end;
end;

procedure TEmpPaySetupDeductions.cboDeductionNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
var
  frm:TComponent;
begin
  inherited;
  fNewDeductionAdded:= false;
  if CommonLib.MessageDlgXP_Vista('This Deduction does not exist. Do you want to create it?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    Processingcursor(True);
    try
      frm:=GetComponentByClassName('TfrmDeductions');
      if not assigned(frm) then exit;
      with TfrmDeductions(frm) do begin
         NewDescription := NewValue;
         if ShowModal = mrOK then begin
           qryDeductions.Close;
           qryDeductions.Open;
         end;
      end;
    finally
      if NewValue <> '' then begin
        if qryDeductions.Locate('Description', NewValue, [loCaseInsensitive]) then begin
          cboDeduction.Text := NewValue;
          cboDeduction.PerformSearch;
          fNewDeductionAdded:= true;
        end;
        Accept := true;
      end;
      Processingcursor(False);
    end;
  end else
    cboDeduction.SetFocus;
end;


procedure TEmpPaySetupDeductions.OnMyMessage(var Msg: TMessage);
begin
  grdDeductions.SetActiveField('Deduction');
end;

initialization
RegisterClassOnce(TEmpPaySetupDeductions);
end.
