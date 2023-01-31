unit frmDocsPathFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, BaseInputForm, DB,  Mask, DBCtrls,
  kbmMemTable, MemDS, DBAccess, MyAccess,ERPdbComponents, Shader, DNMPanel, Menus,
  AdvMenus, DataState, SelectionDialog, AppEvnts, ImgList, ProgressDialog;

type
  TfrmDocsPath = class(TBaseInputGUI)
    Label69: TLabel;
    SpeedButton1: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    DSDocPath: TDataSource;
    tblDocPath: TMyTable;
    txtPath: TDBEdit;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FStart: string;
    FDirectory: string;
    FTitle: string;
    function IsDir(const DirPath: string): boolean;
    function SelectDocDirectory: boolean;
  public
    { Public declarations }
  end;

implementation
  {$WARN UNIT_PLATFORM OFF}

uses {$WARNINGS OFF}FileCtrl{$WARNINGS ON}, DNMExceptions, CommonLib;

{$R *.DFM}

procedure TfrmDocsPath.cmdCancelClick(Sender: TObject);
begin
  TfrmDocsPath(FindExistingComponent('TfrmDocsPath')).Close;

end;


procedure TfrmDocsPath.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmDocsPath.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if tblDocPath.Active then begin
        if not (tblDocPath.State in [dsBrowse]) then begin
          tblDocPath.Post;
        end;
      end;
      tblDocPath.Active := true;

      if tblDocPath.IsEmpty then begin
        tblDocPath.Insert;
      end else begin
        tblDocPath.First;
        tblDocPath.Edit;
      end;
      SetControlFocus(txtPath);
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

procedure TfrmDocsPath.btnCompletedClick(Sender: TObject);
begin
  inherited;
  try
    if not Empty(txtPath.Text) then begin
      if IsDir(ExtractFileDir(txtPath.Text)) then begin
        if not (tblDocPath.State in [dsBrowse]) then begin
          tblDocPath.Post;
        end;
        Self.Close;
      end else begin
        CommonLib.MessageDlgXP_Vista('Directory "' + ExtractFileDir(txtPath.Text) + '"' + #13 + ' Does Not Exist !', mtWarning, [mbOK], 0);
      end;
    end else begin
      CommonLib.MessageDlgXP_Vista(' Documents Folder Path cannot be blank.', mtWarning, [mbOK], 0);
      SetControlFocus(txtPath);
    end;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

function TfrmDocsPath.IsDir(const DirPath: string): boolean;
begin
  Result := SysUtils.DirectoryExists(DirPath);
end;

procedure TfrmDocsPath.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfrmDocsPath.SpeedButton1Click(Sender: TObject);
begin
  if SelectDocDirectory then begin
    txtPath.Text := FDirectory;
  end;
end;

function TfrmDocsPath.SelectDocDirectory: boolean;
begin
  FStart := '';
  FDirectory := txtPath.Text;
  Result := SelectDirectory(FTitle, FStart, FDirectory);
end;

procedure TfrmDocsPath.FormCreate(Sender: TObject);
begin
  inherited;
  tblDocPath.Connection := MyConnection;
end;

initialization
  RegisterClassOnce(TfrmDocsPath);
end.
