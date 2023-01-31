unit AwardTimesheetFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs,Forms, ExtCtrls, DNMPanel,BusObjAwards, wwdbdatetimepicker,
  Mask, wwdbedit, Wwdotdot, Wwdbcomb, StdCtrls, wwdblook, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, frmBase;

type
  TfrmAwardTimesheet = class(TfrmBaseGUI)
    DNMPanel2: TDNMPanel;
    Bevel2: TBevel;
    DSAwardShifts: TDataSource;
    wwDBGrid1: TwwDBGrid;
    PayRate: TwwDBLookupCombo;
    qryPayRates: TERPQuery;
    qryPayRatesDescription: TWideStringField;
    qryPayRatesRateID: TAutoIncField;
    qryPayRatesMultiplier: TFloatField;
    PayRate1: TwwDBLookupCombo;
    qryPayRatesOnly: TERPQuery;
    procedure SetSubAward(Const Value :TAward);
  private
    fSubAward:TAward;
  public
    property SubAward:TAward read fSubaward write SetSubAward ;
    procedure HandleAwardTimesheetErrors;
  end;


implementation

uses
  CommonLib;

procedure TfrmAwardTimesheet.SetSubAward(Const Value :TAward);
begin
  fSubAward := Value;
end;

{$R *.dfm} 

procedure TfrmAwardTimesheet.HandleAwardTimesheetErrors ;
//var
//  FatalStatusItem: TResultStatusItem;
begin
 // if not Assigned(Award) then exit;
  //try
    //FatalStatusItem :=  Award.ResultStatus.GetLastFatalStatusItem;
    //if Assigned(FatalStatusItem) then begin
      //case FatalStatusItem.Code of
        //BOR_PayAllowance_Err_NoDescription  : begin
//                                               grdAllowances.SetActiveField('Allowance');
//                                               SetControlFocus(grdAllowances);
//                                               exit;
//                                             end;
//        BOR_PayAllowance_Err_NoQty         : begin
//                                               grdAllowances.SetActiveField('Qty');
//                                               SetControlFocus(grdAllowances);
//                                               exit;
//                                             end;

 //     end;
    end;

    
initialization
RegisterClassOnce(TfrmAwardTimesheet);
end.
