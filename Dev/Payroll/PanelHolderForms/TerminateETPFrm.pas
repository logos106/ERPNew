unit TerminateETPFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DNMPanel, StdCtrls, wwclearbuttongroup, wwradiogroup,
  DB, MemDS, DBAccess, MyAccess,ERPdbComponents,BusObjTermination, frmBase,
  Menus;

type
  TfrmTerminateETP = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    Label17: TLabel;
    Bevel7: TBevel;
    lblMain: TLabel;
    rgETP: TwwRadioGroup;
    qryEmpTerminate: TERPQuery;
    qryEmpTerminateTerminationID: TIntegerField;
    qryEmpTerminateEmployeeID: TIntegerField;
    qryEmpTerminateGlobalRef: TWideStringField;
    qryEmpTerminateEmployeeName: TWideStringField;
    qryEmpTerminateStartDate: TDateTimeField;
    qryEmpTerminateEndDate: TDateTimeField;
    qryEmpTerminateDaysServicePre01071983: TIntegerField;
    qryEmpTerminateDaysServicePost30061983: TIntegerField;
    qryEmpTerminateETPpre071983: TFloatField;
    qryEmpTerminateETPpost061983Untaxed: TFloatField;
    qryEmpTerminateETPpost061994Component: TFloatField;
    qryEmpTerminateGrossTermination: TFloatField;
    qryEmpTerminateTaxWithheld: TFloatField;
    qryEmpTerminateETPAssessable: TFloatField;
    qryEmpTerminateDeathBenefit: TWideStringField;
    qryEmpTerminateTypeOfDeathBenefit: TWideStringField;
    qryEmpTerminateLumpSumA: TFloatField;
    qryEmpTerminateLumpSumB: TFloatField;
    qryEmpTerminateLumpSumD: TFloatField;
    qryEmpTerminateLumpSumE: TFloatField;
    qryEmpTerminateReasonLeft: TWideStringField;
    qryEmpTerminateGrossETP: TFloatField;
    qryEmpTerminateCDEP: TFloatField;
    qryEmpTerminateReportableFB: TFloatField;
    qryEmpTerminateTotalAllowances: TFloatField;
    qryEmpTerminateIsETPEntitled: TWideStringField;
    qryEmpTerminateDeathBeneficiaryHasTFN: TWideStringField;
    qryEmpTerminateIsPayEntitled: TWideStringField;
    qryEmpTerminateIsManualLongService: TWideStringField;
    qryEmpTerminateIsManualAnnualLeave: TWideStringField;
    qryEmpTerminateLongServicePre16081978: TFloatField;
    qryEmpTerminateLongServicePost16081978: TFloatField;
    qryEmpTerminateLongServicePost17081993: TFloatField;
    DSEmpTerminate: TDataSource;
//    procedure SetSubTerminate(Const Value :Temployeeterminations   );
    procedure rgETPClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
//    fSubTerminate:Temployeeterminations;
    fFinishCreatingForm:boolean;
  public
//    property SubTerminate:Temployeeterminations  read fSubTerminate write SetSubTerminate ;
    SubTerminate:Temployeeterminations;
    procedure Initialise;
  end;

implementation
//uses
//  BusObjConst;

//procedure TfrmTerminateETP.SetSubTerminate(Const Value :Temployeeterminations);
//begin
//  fSubTerminate := Value;
//
//  if fSubTerminate.IsETPEntitled then
//    rgETP.Itemindex:= 0
//  else
//    rgETP.Itemindex:= 1;
//end;

{$R *.dfm}

uses
  CommonLib, AppEnvironment;

procedure TfrmTerminateETP.FormCreate(Sender: TObject);
begin
  inherited;
  lblMain.Caption := 'ETP''s can include unused ' + Appenv.RegionalOptions.SLName +', pay in lieu of notice, unused RDO''s, Golden Handshakes,  compensation for unfair dismissal and invalidity.';
end;

procedure TfrmTerminateETP.Initialise;
begin
  if SubTerminate.IsETPEntitled then
    rgETP.Itemindex:= 0
  else
    rgETP.Itemindex:= 1;
end;

procedure TfrmTerminateETP.rgETPClick(Sender: TObject);
begin
  if not fFinishCreatingForm then begin  //don't reset main buttons on creating form
    fFinishCreatingForm := True;
    exit;
  end;  
  SubTerminate.IsETPEntitled := rgETP.Itemindex = 0;
end;  


initialization
RegisterClassOnce(TfrmTerminateETP);
end.
