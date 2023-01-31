unit EmployeePaySetupNotes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,BusObjEmployeePay, DB, StdCtrls, DBCtrls, ExtCtrls, DNMPanel,
  frmBase, BusObjBase, Menus;

type
  TfrmEmployeePaySetupNotes = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    DSEmployees: TDataSource;
    memPayNotes: TMemo;
    procedure memPayNotesExit(Sender: TObject);
  private
    fSubEmpPay:Temployeepay;
    procedure SetSubEmpPay(Const Value :Temployeepay );
  public
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  end;

implementation

uses
  CommonLib, BusObjConst;

{$R *.dfm}

procedure TfrmEmployeePaySetupNotes.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if Value = BusobjEventVal_FailedPay_NotesValidateData then begin
    // HandleEmployeeCommissionErrors; {No Need For Error Handling Yet ?? }
  end;
end;

procedure TfrmEmployeePaySetupNotes.memPayNotesExit(Sender: TObject);
begin
  inherited;
  fSubEmpPay.EmployeeDetails.PayNotes := memPayNotes.Lines.Text;
end;

procedure TfrmEmployeePaySetupNotes.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;
end;

initialization
  RegisterClassOnce(TfrmEmployeePaySetupNotes);
end.
