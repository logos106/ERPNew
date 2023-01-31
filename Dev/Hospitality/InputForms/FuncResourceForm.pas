unit FuncResourceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  ExtCtrls,
  DNMPanel, StdCtrls, Buttons, DNMSpeedButton, Grids, Wwdbigrd, Wwdbgrid, DBAccess,
  MyAccess, DataState, Menus, AdvMenus, MemDS, Shader;

type
  TFuncResourceGUI = class(TBaseInputGUI)
    qryResources: TMyQuery;
    dsResources: TDataSource;
    grdResources: TwwDBGrid;
    btnCancel: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    grdResourcesIButton: TwwIButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure grdResourcesIButtonClick(Sender: TObject);
  private
    { Private declarations }
    function SaveData: boolean;
  public
    { Public declarations }
  end;


implementation

uses
   DNMExceptions, DNMLib, CommonLib;


{$R *.dfm}

{ TTFuncResourceGUI }

procedure TFuncResourceGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbTabSettingEnabled := false;
end;

procedure TFuncResourceGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseQueries;
  Action := caFree;
  inherited;
end;

procedure TFuncResourceGUI.FormShow(Sender: TObject);
begin
  try
    inherited;
    BeginTransaction;
    OpenQueries;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
end;

procedure TFuncResourceGUI.btnSaveClick(Sender: TObject);
begin
  inherited;
  if SaveData() then begin
    self.Close;
  end;
end;

procedure TFuncResourceGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  RollbackTransaction;
  Self.Close;
end;

function TFuncResourceGUI.SaveData: boolean;
begin
  Result := false;
  try
    if qryResources.Active and not (qryResources.State in [dsBrowse]) then begin
      qryResources.Post;
    end;
    CommitTransaction;
    Notify;
    Result := true;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TFuncResourceGUI.grdResourcesIButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryResources);
end;

initialization
  RegisterClassOnce(TFuncResourceGUI);
end.
