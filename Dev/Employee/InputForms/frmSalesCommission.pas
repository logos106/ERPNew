unit frmSalesCommission;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ImgList, Menus, AdvMenus, DataState, DB,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, Shader,
  MemDS, Buttons, Wwdbigrd, Grids, Wwdbgrid, DNMSpeedButton,
  wwdbdatetimepicker, BusObjBase, BusobjSalesCommission, DNMPanel, ComCtrls,
  (*ProgressDialog,*) Mask, wwdbedit, wwcheckbox, ProgressDialog;

type
  TfmSalesCommission = class(TBaseInputGUI)
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryMain: TERPQuery;
    qryMainglobalref: TWideStringField;
    qryMainID: TIntegerField;
    qryMainCommissionCalculatedOn: TDateTimeField;
    qryMainDateFrom: TDateTimeField;
    qryMainDateto: TDateTimeField;
    qryMainemployeeID: TIntegerField;
    qryMainmstimestamp: TDateTimeField;
    dsMain: TDataSource;
    qryMainEmployeeName: TWideStringField;
    DNMPanel1: TDNMPanel;
    Panel4: TDNMPanel;
    Bevel1: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    Label4: TLabel;
    dtFrom: TwwDBDateTimePicker;
    dtTo: TwwDBDateTimePicker;
    btnDoCalc: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    Label1: TLabel;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    chkAll: TCheckBox;
    Label7: TLabel;
    qryMainIgnoredateRange: TWideStringField;
    Label8: TLabel;
    chkignoredaterange: TwwCheckBox;
    procedure cmdCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDoCalcClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkAllClick(Sender: TObject);
  private

//    procedure doBusObjEvent(const Sender: TDatasetBusObj; const EventType, Value: string);virtual;
    function getDateFrom: TDatetime;
    function getDateTo: Tdatetime;
    function getSalesCommissionCalcInProgress:Boolean;
    Procedure SetsalescommissionCalcInProgress(const Value:Boolean);
    
  public
    Property Datefrom :TDatetime read getDateFrom;
    Property DateTo :Tdatetime read getDateTo;
    Property SalesCommissionCalcInProgress :Boolean read getSalesCommissionCalcInProgress write setSalesCommissionCalcInProgress;
    class function Updatesalescommission(DateFrom, Dateto:TDatetime; ignoreDates:Boolean):Boolean;

  end;

implementation

uses DNMExceptions, Dateutils, CommonLib, AppEnvironment, EmployeeObj, BusObjConst,
  CommonDbLib ;

{$R *.dfm}
procedure TfmSalesCommission.cmdCloseClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

//procedure TfmSalesCommission.doBusObjEvent(const Sender: TDatasetBusObj;
//  const EventType, Value: string);
//begin
//  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
//    //if Sender is TSalesCommissionUpdate         then TSalesCommissionUpdate(Sender).DataSet     := qryMain;
//  end;
//end;

procedure TfmSalesCommission.FormShow(Sender: TObject);
begin
  inherited;

  if qryMain.active = False then qryMain.open;
  if (qryMain.recordcount > 0) and (qryMainDateto.asDAteTime <> 0) then begin
    dtFrom.Date :=IncSecond(IncDay(qryMainDateto.asDAteTime, 1), -1);
  end else begin
    dtFrom.Date :=IncDay(IncMonth(Date, - 1));
  end;
  dtTo.Date := date;
  btnDoCalc.enabled := not(SalesCommissionCalcInProgress);

end;

function TfmSalesCommission.getDateFrom: TDatetime;
begin
  if chkAll.checked then result := 0
  else Result := IncSecond(IncDay(dtFrom.DateTime, -1), 1);
end;

function TfmSalesCommission.getDateTo: Tdatetime;
begin
  if chkAll.checked then result := 0
  else REsult := IncSecond(IncDay(dtTo.DateTime, 1), - 1);
end;

procedure TfmSalesCommission.btnDoCalcClick(Sender: TObject);
begin
  inherited;
  if not Updatesalescommission(Datefrom ,Dateto , chkall.checked) then
    btnDoCalc.enabled := False
  else BEGIN
    MessageDlgXP_Vista('Commissions updated' , mtWarning , [mbok], 0);
    Self.close;
  END;

  (*if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCalcSalescommission') <> 1 then begin
      CommonLib.MessageDlgXP_Vista('You do not have Access to this Function', mtInformation, [mbOK], 0);
          raise ENoAccess.Create('You do not have Access to this Function');
          Exit;
  end;
  if SalesCommissionCalcInProgress then begin
    btnDoCalc.enabled := False;
    Exit;
  end;
  SalesCommissionCalcInProgress := true;
  try
    SCUpdate.Connection.BeginTransaction;
    try
      SCUpdate.New;
      SCUpdate.CommissionCalculatedOn := Now;
      SCUpdate.DateFrom := Datefrom;
      SCUpdate.DateTo := Dateto;
      SCUpdate.employeeID := AppEnv.Employee.EmployeeID;
      SCUpdate.IgnoredateRange := chkall.checked;
      SCUpdate.PostDB;
      if not SCUpdate.doCalc then begin
        SCUpdate.Connection.RollbackTransaction;
        exit;
      end;
      SCUpdate.Connection.CommitTransaction;
      MessageDlgXP_Vista('Commissions updated' , mtWarning , [mbok], 0);
      Self.close;
    Except
        On E:Exception do begin
            MessageDlgXP_Vista('Update Failed' +chr(13) +chr(13) + E.Message , mtWarning , [mbok], 0);
            SCUpdate.Connection.RollbackTransaction;
        end;
    end;
  finally
      SalesCommissionCalcInProgress := false;
  end;*)
end;

procedure TfmSalesCommission.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;

  inherited;
end;


function TfmSalesCommission.getSalesCommissionCalcInProgress: Boolean;
begin
  result := Appenv.CompanyPrefs.SalesCommissionCalcInProgress;
end;

procedure TfmSalesCommission.SetsalescommissionCalcInProgress(const Value: Boolean);
begin
    AppEnv.CompanyPrefs.SalesCommissionCalcInProgress := Value;
end;

procedure TfmSalesCommission.chkAllClick(Sender: TObject);
begin
  inherited;
  dtFrom.Enabled := chkall.checked = False;
  dtTo.Enabled := chkall.checked = False;
end;

class function  TfmSalesCommission.Updatesalescommission(DateFrom,
  Dateto: TDatetime; ignoreDates: Boolean):Boolean ;
var
  SCUpdate :TSalesCommissionUpdate;
  fSalesCommissionCalcInProgress:Boolean;
begin
  Result := true;
  if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCalcSalescommission') <> 1 then begin
      CommonLib.MessageDlgXP_Vista('You do not have Access to run the Sales commission', mtInformation, [mbOK], 0);
          (*raise ENoAccess.Create('You do not have Access to run the Sales commission');*)
          Exit;
  end;
  if (Appenv.CompanyPrefs.SalesCommissionCalcInProgress) and
      (Appenv.CompanyPrefs.SalesCommissionCalcEmployeeID <> appenv.Employee.EmployeeID) then begin
    result := False;
    Exit;
  end;
  fSalesCommissionCalcInProgress := Appenv.CompanyPrefs.SalesCommissionCalcInProgress;
  SCUpdate :=TSalesCommissionUpdate.create(nil);
  try
    SCUpdate.connection := TMyDacDataConnection.create(SCUpdate);
    SCUpdate.Connection.Connection := CommonDbLib.GetNewMyDacConnection(SCUpdate);
    (*SCUpdate.ProgressDialog := TProgressDialog.create(nil);
    SCUpdate.ProgressDialog.Caption := 'Sales Commission Update';
    SCUpdate.ProgressDialog.Message := 'Updating......';
    SCUpdate.ProgressDialog.Step := 1;*)
    SCUpdate.Load(0);
    Appenv.CompanyPrefs.SalesCommissionCalcInProgress := true;
    Appenv.CompanyPrefs.SalesCommissionCalcEmployeeID :=Appenv.Employee.employeeId;
    try
      SCUpdate.Connection.BeginTransaction;
      try
        SCUpdate.New;
        SCUpdate.CommissionCalculatedOn := Now;
        SCUpdate.DateFrom := Datefrom;
        SCUpdate.DateTo := Dateto;
        SCUpdate.employeeID := AppEnv.Employee.EmployeeID;
        SCUpdate.IgnoredateRange := ignoreDates;
        SCUpdate.PostDB;
        SCUpdate.doCalc ;
        SCUpdate.Connection.CommitTransaction;
      Except
          On E:Exception do begin
              MessageDlgXP_Vista('Update Failed' +chr(13) +chr(13) + E.Message , mtWarning , [mbok], 0);
              SCUpdate.Connection.RollbackTransaction;
          end;
      end;
    finally
        Appenv.CompanyPrefs.SalesCommissionCalcInProgress := fSalesCommissionCalcInProgress;
        if not fSalesCommissionCalcInProgress  then
          Appenv.CompanyPrefs.SalesCommissionCalcEmployeeID := 0;
    end;
  finally
      Freeandnil(SCUpdate);
  end;
end;

initialization
  RegisterClassOnce(TfmSalesCommission);

end.
