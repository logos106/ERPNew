unit ProductOptionsInputGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, AppEvnts, DB,   StdCtrls,
  Buttons, DNMSpeedButton, wwdbdatetimepicker, ExtCtrls, DNMPanel, wwclearbuttongroup,
  wwradiogroup, Mask, DBCtrls, Wwdbigrd, Grids, Wwdbgrid, wwdblook,
  SelectionDialog, ActnList, Menus, AdvMenus, MyAccess,ERPdbComponents, MemDS, DBAccess,
  DataState, MessageConst, BusObjGeneral, Shader,
  BusObjBase, dmGUIStylers,  ImgList, ERPDbLookupCombo,
  ProgressDialog, wwcheckbox, wwdbedit, AdvEdit;

type
  TfrmProductOptionsINputGUI = class(TBaseInputGUI)
    lsTDNMSpeedButtonActions: TActionList;
    actMemTrans: TAction;
    actMemTransAuto: TAction;

    popMemTrans: TAdvPopupMenu;
    MemorizeTransaction1: TMenuItem;
    MemorizeAutoTransaction1: TMenuItem;
    mnuAuditTrail: TMenuItem;
    mnuCopyToClipboard: TMenuItem;
    mnuPasteFromClipboard: TMenuItem;
    Label1: TLabel;
    edOptionName: TEdit;
    Label2: TLabel;
    edOPtionAbbrev: TEdit;
    Label3: TLabel;
    edCost: TAdvEdit;
    Label4: TLabel;
    edPrice: TAdvEdit;
    Panel1: TDNMPanel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edOptionNameChange(Sender: TObject);

  private
    { Private declarations }
  Protected

  public
    { Public declarations }
  end;

implementation

uses
  DNMExceptions, FormFactory,   Math,   CommonDbLib, frmRepeat,  CommonLib,  AppEnvironment,
  FastFuncs, BaseFormForm, BusObjConst, tcConst, DNMLib, CommonFormLib,
   ClipBrd, Types, StringUtils, clipboardLib;


{$R *.dfm}

{ TfrmProductOptionsInputGUI }

procedure TfrmProductOptionsINputGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmProductOptionsINputGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmProductOptionsINputGUI.btnCloseClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    Close;
  finally
    EnableForm;
  end;
end;

procedure TfrmProductOptionsINputGUI.btnCompletedClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;


procedure TfrmProductOptionsINputGUI.edOptionNameChange(Sender: TObject);
begin
  inherited;
  edOptionAbbrev.Text := Copy(edOptionName.Text,1,25);
end;

initialization
  RegisterClassOnce(TfrmProductOptionsINputGUI);
end.
