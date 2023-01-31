unit EmployeeWorkcoverFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, wwdblook, StdCtrls, Mask, wwdbedit, Wwdotdot,
  Wwdbcomb, Buttons, Wwdbigrd, Grids, Wwdbgrid, DB, MemDS, DBAccess,
  MyAccess,ERPdbComponents, ExtCtrls, DNMPanel,BusObjEmployeePay, BusObjBase, frmBase,BaseInputForm, ProgressDialog, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts;

type
  TfrmEmployeeWorkcover = Class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DSworkerscompensation: TDataSource;
    qryDepartment: TERPQuery;                                                              
    StringField1: TWideStringField;
    StringField2: TWideStringField;
    AutoIncField1: TAutoIncField;
    grdCompo: TwwDBGrid;
    grdCompoIButton: TwwIButton;
    cboCompoType: TwwDBComboBox;
    cboCompoDepartment: TwwDBLookupCombo;
    edDescription: TwwDBEdit;
    edAmount: TwwDBEdit;
    Label1: TLabel;
    edtWorkerscompRate: TwwDBEdit;
    DSEmployeeCompRate: TDataSource;
    procedure grdCompoIButtonClick(Sender: TObject);
    procedure SetSubEmpPay(Const Value :Temployeepay );
    procedure FormCreate(Sender: TObject);
  private
    fSubEmpPay:Temployeepay;
//    procedure HandleWorkersCompErrors;
  public
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);override;
  end;

implementation

{$R *.dfm}

uses
  BusObjConst,CommonLib;

//procedure TfrmEmployeeWorkcover.HandleWorkersCompErrors;
//var
//  FatalStatusItem: TResultStatusItem;
//begin
//  if not Assigned(SubEmpPay) then exit;
//  FatalStatusItem := SubEmpPay.WorkersCompensation.ResultStatus.GetLastFatalStatusItem;
//  if Assigned(FatalStatusItem) then begin
//    SetControlFocus(grdCompo);
//    case FatalStatusItem.Code of
//      BOR_WorkersComp_Err_NoDetails : begin
//                                        grdCompo.SetActiveField('Description');
//                                      end;
//      BOR_WorkersComp_Err_NoDate    : begin
//                                        grdCompo.SetActiveField('WCDate');
//                                      end;
//      BOR_WorkersComp_Err_NoAmount  : begin
//                                        grdCompo.SetActiveField('Amount');
//                                      end;
//      BOR_WorkersComp_Err_NoDepartment : begin
//                                           grdCompo.SetActiveField('ClassName');
//                                         end;
//      BOR_WorkersComp_Err_NoType     : begin
//                                           grdCompo.SetActiveField('Type');
//                                         end;
//    end;
//  end;
//end;

procedure TfrmEmployeeWorkcover.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;
end;

procedure TfrmEmployeeWorkcover.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := true;
  AllowGridSorting := True;
  inherited;
end;

procedure TfrmEmployeeWorkcover.grdCompoIButtonClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not Assigned(SubEmpPay) then exit;
      SubEmpPay.WorkersCompensation.Delete;
    finally
    end;
  end;
end;

procedure TfrmEmployeeWorkcover.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
var
  ErrorCode: integer;
begin
  inherited;
  if Value = BusobjEventVal_FailedWorkcoverValidateData then begin
//    HandleWorkersCompErrors;
    SetControlFocus(grdCompo);
    ErrorCode := StrToIntDef(EventType,0);
    case ErrorCode of
      BOR_WorkersComp_Err_NoDetails : begin
                                        grdCompo.SetActiveField('Description');
                                      end;
      BOR_WorkersComp_Err_NoDate    : begin
                                        grdCompo.SetActiveField('WCDate');
                                      end;
      BOR_WorkersComp_Err_NoAmount  : begin
                                        grdCompo.SetActiveField('Amount');
                                      end;
      BOR_WorkersComp_Err_NoDepartment : begin
                                           grdCompo.SetActiveField('ClassName');
                                         end;
      BOR_WorkersComp_Err_NoType     : begin
                                           grdCompo.SetActiveField('Type');
                                         end;
    end;
  end;
end;

initialization
  RegisterClassOnce(TfrmEmployeeWorkcover);
end.
