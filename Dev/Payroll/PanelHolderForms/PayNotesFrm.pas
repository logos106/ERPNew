unit PayNotesFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DNMPanel, StdCtrls, DBCtrls, DB, MemDS,
  DBAccess, MyAccess,ERPdbComponents,BusObjPaybase, frmPayFormsBase, BusObjBase, Menus,
  ProgressDialog, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog;

type
  TfrmPayNotes = Class(TfmPayFormsBase)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    DSPayNotes: TDataSource;
    PayMemo: TDBMemo;
    Label13: TLabel;
    procedure SetSubPay(Const Value :Tpaybase );
  private
    fSubPay:Tpaybase;
  public
    property SubPay:Tpaybase  read fSubPay write SetSubPay ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  end;

implementation

uses
  CommonLib, BusObjConst;

{$R *.dfm}

procedure TfrmPayNotes.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if Value = BusobjEventVal_FailedPay_NotesValidateData then begin
    // HandleEmployeeCommissionErrors; {No Need For Error Handling Yet ?? }
  end;
end;

procedure TfrmPayNotes.SetSubPay(Const Value :Tpaybase);
begin
  fSubPay := Value;
end;

initialization
RegisterClassOnce(TfrmPayNotes);
end.

