unit POSProcessGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts,
  DB,  StdCtrls, DBCtrls, dbcgrids, MemDS, Grids, Wwdbigrd, Wwdbgrid,
  BaseGrid, AdvGrid, frameProcessList, ExtCtrls, DNMPanel, Buttons, DNMSpeedButton,
  DataState, Menus, AdvMenus, Shader, ImgList;

type
  TPOSProcessFrm = class(TBaseInputGUI)
    pnlTop: TDNMPanel;
    pnlBottom: TDNMPanel;
    pnlLeft: TDNMPanel;
    pnlRight: TDNMPanel;
    pnlMain: TPanel;
    ProcessList: TfrProcessList;
    btnConfigure: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfigureClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure ProcessListTimerTimer(Sender: TObject);
  private
    { Private declarations }
    Initialising: boolean;
  public
    { Public declarations }
    procedure UpdateCaption;
  end;


implementation

{$R *.dfm}

uses FastFuncs,DnMExceptions, POSProcessConfigGUI, CommonLib;

var
  ProcessOrderCheckIntervalSecs: integer = 5;

procedure TPOSProcessFrm.FormCreate(Sender: TObject);
begin
  inherited;
  Self.WindowState := wsMaximized;

  Initialising := true;
  try

  finally
    Initialising := false;
  end;
end;

procedure TPOSProcessFrm.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      // Set a non zero KeyID so BaseInputForm does not throw an exception
      // if access is read only
      Self.KeyID := 1;
      inherited;

      // set controlls based on access level
      { 1  - (Full Access)
        2  - (Full Access, No Delete)
        3  - (Create + Read)
        5  - (Read Only)
        6  - (No Access)  }
      if Self.AccessLevel < 3 then
        ProcessList.CanEdit := true
      else
        ProcessList.CanEdit := false;

      Self.OpenQueries;

      UpdateCaption;

      // Exception handler.
    except
      on EABort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TPOSProcessFrm.FormDestroy(Sender: TObject);
begin
  //
  inherited;
end;

procedure TPOSProcessFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self.CloseQueries;
  Action := caFree;
//  POSProcessFrm := nil;
  inherited;
end;

procedure TPOSProcessFrm.UpdateCaption;
var
  s: string;
begin
  // set the caption to show currently selected steps
  if ProcessList.ShowAllSteps then
    TitleLabel.Caption := 'Orders for: All'
  else begin
    s := ProcessList.ProcessStepList.CommaText;
    s := StringReplace(s, '"', '', [rfReplaceAll,rfIgnoreCase]);
    TitleLabel.Caption := 'Orders for: ' + s;
  end;
end;

procedure TPOSProcessFrm.btnConfigureClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TPOSProcessConfigFrm');
  If not Assigned(tmpComponent) then Exit;
  with TPOSProcessConfigFrm(tmpComponent) do begin
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TPOSProcessFrm.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TPOSProcessFrm.ProcessListTimerTimer(Sender: TObject);
begin
  inherited;
  ProcessList.TimerTimer(Sender);
end;

initialization
  RegisterClassOnce(TPOSProcessFrm);
end.
