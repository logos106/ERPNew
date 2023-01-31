unit FuncTypesForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB, StdCtrls,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ExtCtrls, DNMPanel, 
  DBAccess, MyAccess, DataState, Menus, AdvMenus, MemDS, Shader;

type
  TFuncTypesGUI = class(TBaseInputGUI)
    grdFuncTypes: TwwDBGrid;
    grdResourcesIButton: TwwIButton;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    dsFuncTypes: TDataSource;
    qryFuncTypes: TMyQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdResourcesIButtonClick(Sender: TObject);
  private 
    FFuncTypeName: string;
    function SaveData: boolean;
    function GetFuncTypeName: string;
    procedure SetFuncTypeName(const Value: string);

  public
    property FuncTypeName: string read GetFuncTypeName write SetFuncTypeName;
  end;


implementation

uses
   DNMExceptions, DNMLib, CommonLib;

{$R *.dfm}

{ TFuncTypesGUI }

procedure TFuncTypesGUI.btnSaveClick(Sender: TObject);
begin
  inherited;
  if SaveData() then begin
    self.Close;
  end;
end;

procedure TFuncTypesGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  RollbackTransaction;
  Self.Close;
end;

function TFuncTypesGUI.SaveData: boolean;
begin
  Result := false;
  try
    if qryFuncTypes.Active and not (qryFuncTypes.State in [dsBrowse]) then begin
      qryFuncTypes.Post;
    end;
    CommitTransaction;
    Notify;
    Result := true;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TFuncTypesGUI.FormShow(Sender: TObject);
begin
  try
    inherited;
    BeginTransaction;
    OpenQueries;
    if not qryFuncTypes.Locate('FuncTypeName', FFuncTypeName, [loCaseInsensitive]) then begin
      if FFuncTypeName > '' then begin
        qryFuncTypes.Insert;
        qryFuncTypes.FieldByName('FuncTypeName').AsString := FFuncTypeName;
        qryFuncTypes.Post;
      end;
    end;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
end;

procedure TFuncTypesGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not ErrorOccurred then begin
    FFuncTypeName := qryFuncTypes.FieldByName('FuncTypeName').AsString;
    CloseQueries;
  end;
  
  Action := caFree;
//  FuncTypesGUI := nil;
  inherited;
end;

procedure TFuncTypesGUI.grdResourcesIButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryFuncTypes);
end;

function TFuncTypesGUI.GetFuncTypeName: string;
begin
  Result := FFuncTypeName;
end;

procedure TFuncTypesGUI.SetFuncTypeName(const Value: string);
begin
  FFuncTypeName := Value;
end;

initialization
  RegisterClassOnce(TFuncTypesGUI);
end.
