unit FuncStatusLabelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  StdCtrls,
  Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, Mask, wwdbedit, DBAccess, MyAccess,
  DataState, Menus, AdvMenus, MemDS, Shader;

type
  TFuncStatusLabelGUI = class(TBaseInputGUI)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryFuncStatuses: TMyQuery;
    dsFuncStatuses: TDataSource;
    edtLabel1: TwwDBEdit;
    edtLabel2: TwwDBEdit;
    edtLabel3: TwwDBEdit;
    edtLabel4: TwwDBEdit;
    edtLabel5: TwwDBEdit;
    edtLabel6: TwwDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    qryFuncStatusesStatus1: TStringField;
    qryFuncStatusesStatus2: TStringField;
    qryFuncStatusesStatus3: TStringField;
    qryFuncStatusesStatus4: TStringField;
    qryFuncStatusesStatus5: TStringField;
    qryFuncStatusesStatus6: TStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function SaveData: boolean;
  public
    { Public declarations }
    
  end;

implementation

uses
  CommonDbLib,  DNMExceptions, CommonLib;

{$R *.dfm}

{ TFuncStatusLabelsGUI }

procedure TFuncStatusLabelGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  qryFuncStatuses.Close;
  Action := caFree;
  inherited;
end;

procedure TFuncStatusLabelGUI.btnSaveClick(Sender: TObject);
begin
  inherited;
  if SaveData() then begin
    self.Close;
  end;
end;

procedure TFuncStatusLabelGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

function TFuncStatusLabelGUI.SaveData: boolean;
begin
  Result := false;
  try
    if Accesslevel > 4 then begin
      Result := true;
      Exit;
    end;  
    if qryFuncStatuses.Active and (qryFuncStatuses.State in [dsEdit, dsInsert]) then begin
      qryFuncStatuses.Post;
    end;
    Notify;
    Result := true;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TFuncStatusLabelGUI.FormShow(Sender: TObject);
begin
  try
    inherited;
    qryFuncStatuses.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryFuncStatuses.Open;
    EditNoAbort(qryFuncStatuses);
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end;

initialization
  RegisterClassOnce(TFuncStatusLabelGUI);
end.
