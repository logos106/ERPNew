unit EmployeeBenefitsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwdblook, Buttons, Wwdbigrd, Grids, Wwdbgrid, DB,BusObjBase,
  MemDS, DBAccess, MyAccess,ERPdbComponents, ExtCtrls, DNMPanel,BusObjEmployeePay, frmBase,BaseInputForm, ProgressDialog, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts;

type
  TfrmEmployeeBenefits = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    dsFBT: TDataSource;
    qryDepartment: TERPQuery;
    StringField1: TWideStringField;
    StringField2: TWideStringField;
    AutoIncField1: TAutoIncField;
    grdFBT: TwwDBGrid;
    grdFBTIButton: TwwIButton;
    cboFBTDepartment: TwwDBLookupCombo;
    lblMsg: TLabel;
    procedure grdFBTIButtonClick(Sender: TObject);
    procedure SetSubEmpPay(Const Value :Temployeepay );
    procedure FormCreate(Sender: TObject);
    procedure grdFBTEnter(Sender: TObject);
  private
    fSubEmpPay:Temployeepay;
//    procedure HandleEmployeeFBTErrors;
  public
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);override;
  end;

implementation

{$R *.dfm}

uses
  BusObjConst,CommonLib, AppEnvironment, tcTypes, tcConst;

  procedure TfrmEmployeeBenefits.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;
end;

//procedure TfrmEmployeeBenefits.HandleEmployeeFBTErrors;
//var
//  FatalStatusItem: TResultStatusItem;
//begin
//  if not Assigned(SubEmpPay) then exit;
//  FatalStatusItem := SubEmpPay.FringeBenefits.ResultStatus.GetLastFatalStatusItem;
//  if Assigned(FatalStatusItem) then begin
//    case FatalStatusItem.Code of
//      BOR_EmployeePay_Err_FBTNoDepartment  : begin
//                                               grdFBT.SetActiveField('ClassName');
//                                             end;
//      BOR_EmployeePay_Err_FBTNoAmount      : begin
//                                               grdFBT.SetActiveField('Amount');
//                                             end;
//      BOR_EmployeePay_Err_FBTNoYearEnding  : begin
//                                               grdFBT.SetActiveField('YearEnding');
//                                             end;
//    end;
//  end;
//end;

procedure TfrmEmployeeBenefits.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := true;
  AllowGridSorting := True;
  inherited;
  if Appenv.RegionalOptions.RegionType = rAust then begin
    grdFBT.Hint:=  'The FBT year runs from 1 April to 31 March.' + NL +'Ref : https://www.ato.gov.au/Rates/FBT/'+NL;
    grdFBT.Showhint := True;
  end;
end;

procedure TfrmEmployeeBenefits.grdFBTEnter(Sender: TObject);
begin
  inherited;
  if Appenv.RegionalOptions.RegionType = rAust then TimerMsg(lblMsg , 'The FBT year runs from 1 April to 31 March.' + NL +'Ref : https://www.ato.gov.au/Rates/FBT/');
end;

procedure TfrmEmployeeBenefits.grdFBTIButtonClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then begin
    try
      if not Assigned(SubEmpPay) then exit;
      SubEmpPay.FringeBenefits.Delete;
      SubEmpPay.FringeBenefits.RefreshDB;
    finally
    end;
  end;
end;

procedure TfrmEmployeeBenefits.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
var
  ErrorCode: integer;
begin
  inherited;
  if Value = BusobjEventVal_FailedFringe_BenefitsValidateData then begin
//    HandleEmployeeFBTErrors;
    ErrorCode := StrToIntDef(EventType,0);
    case ErrorCode of
      BOR_EmployeePay_Err_FBTNoDepartment  : begin
                                               grdFBT.SetActiveField('ClassName');
                                             end;
      BOR_EmployeePay_Err_FBTNoAmount      : begin
                                               grdFBT.SetActiveField('Amount');
                                             end;
      BOR_EmployeePay_Err_FBTNoYearEnding  : begin
                                               grdFBT.SetActiveField('YearEnding');
                                             end;
    end;
  end;
end;

initialization
  RegisterClassOnce(TfrmEmployeeBenefits);
end.
