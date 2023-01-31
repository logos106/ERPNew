unit SQLHelperForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Dialogs, Controls, StdCtrls,
  Buttons, DNMSpeedButton, DB,  DBCtrls, Grids, DBGrids, DBTables, BaseInputForm,
  ExtCtrls, DNMPanel, Shader, Menus, AdvMenus, DataState, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, MemDS, ImgList,
  ProgressDialog;

type
  TSqlHelperGUI = class(TBaseInputGUI)
    lstFields: TListBox;
    lblTables: TLabel;
    DstLabel: TLabel;
    lstTables: TListBox;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    lblCurrentTable: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure lstTablesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
{$R *.dfm}

uses
  DNMExceptions, CommonDbLib, CommonLib;

procedure TSqlHelperGUI.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
  MyConnection.GetTableNames(lstTables.Items);
end;

procedure TSqlHelperGUI.lstTablesClick(Sender: TObject);
begin
  CommonDbLib.GetFieldNames(lstTables.Items[lstTables.ItemIndex], lstFields.Items);
  lblCurrentTable.Caption := '<' + lstTables.Items[lstTables.ItemIndex] + '>';
end;

procedure TSqlHelperGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TSqlHelperGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      lstTables.ItemIndex := 0;
      lstTablesClick(Sender);
      lstFields.ItemIndex := 0;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

initialization
  RegisterClassOnce(TSqlHelperGUI);
end.
