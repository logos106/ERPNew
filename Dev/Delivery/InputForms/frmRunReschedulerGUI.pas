///////////////////////////////////////////////////////////////
  // This form should be opened in modal mode only!
  ///////////////////////////////////////////////////////////////
  //
  // Besure you also set the ReturnResult property before showing
  // this form.
  //
  ///////////////////////////////////////////////////////////////
unit frmRunReschedulerGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DBAccess, MyAccess, SelectionDialog, AppEvnts,
  DB,  StdCtrls, ComCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, DeliveryObj,
  DataState, Menus, AdvMenus;

type
  TfrmRunRescheduler = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    cmdOK: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    dtRescheduleDate: TDateTimePicker;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);

  private
    { Private declarations }
    recResult: PDateReturn;
    
  public
    { Public declarations }
    
    property ReturnResult: PDateReturn read recResult write recResult;
  end;

//var
//  frmRunRescheduler: TfrmRunRescheduler;

implementation

uses CommonLib;

{$R *.dfm}

{ TfrmRunRescheduler }

procedure TfrmRunRescheduler.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmRunRescheduler.FormShow(Sender: TObject);
begin
  inherited;
  Self.fbIgnoreAccessLevels := true;
end;

procedure TfrmRunRescheduler.cmdOKClick(Sender: TObject);
begin
  inherited;
  ReturnResult^.Date := dtRescheduleDate.DateTime;
end;

procedure TfrmRunRescheduler.cmdCancelClick(Sender: TObject);
begin
  inherited;
  ReturnResult^.Date := 0;
end;

initialization
  RegisterClassOnce(TfrmRunRescheduler);

end.
