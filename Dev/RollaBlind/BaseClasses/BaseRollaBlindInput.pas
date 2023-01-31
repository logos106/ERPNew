unit BaseRollaBlindInput;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 18/05/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, DNMSpeedButton, DNMPanel,
  MemDS, StdCtrls, wwclearbuttongroup, wwradiogroup, wwdblook, wwdbedit,
  Mask, Wwdotdot, Wwdbcomb;

type
  TBaseRollaBlindInputGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    pnlTitle: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Bevel1: TBevel;
    qryMain: TMyQuery;
    dsMain: TDataSource;
    btnNew: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
  private
    procedure SaveData;
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib;

{$R *.dfm}

procedure TBaseRollaBlindInputGUI.FormShow(Sender: TObject);
begin
  inherited;

  if not DataState.IsActive then
    DataState.Activate;

  DataState.Dirty := False;
end;

procedure TBaseRollaBlindInputGUI.FormCreate(Sender: TObject);
begin
  TitleLabel.Caption := Caption;
  inherited;
  if not MyConnection.InTransaction then
    BeginTransaction;
end;

procedure TBaseRollaBlindInputGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Response: TModalResult;
begin
  inherited;

  if DataState.Dirty then
    Response := CommonLib.MessageDlgXP_Vista('Do you wish to keep the changes you made?', mtConfirmation, [mbNo, mbYes, mbCancel], 0)
  else
    Response := mrNo;

  if Response = mrCancel then
    Action := caNone
  else begin
    if MyConnection.InTransaction then begin
      if Response = mrYes then begin
        SaveData;
        CloseQueries;
        CommitTransaction;
        Notify;
      end
      else
        RollbackTransaction;
    end;

    Action := caFree;
  end;
end;

procedure TBaseRollaBlindInputGUI.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveData;
  CloseQueries;

  if MyConnection.InTransaction then
    CommitTransaction;

  Notify;
  Release;
end;

procedure TBaseRollaBlindInputGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TBaseRollaBlindInputGUI.SaveData;
var
  Index: Integer;
begin
  for Index := 0 to ComponentCount - 1 do begin
    if Components[Index] is TMyQuery then begin
      if TMyQuery(Components[Index]).State in [dsEdit, dsInsert] then
        TMyQuery(Components[Index]).Post;
    end;
  end;
end;

procedure TBaseRollaBlindInputGUI.btnNewClick(Sender: TObject);
begin
  inherited;
  SaveData;
  CloseQueries;

  if MyConnection.InTransaction then
    CommitTransaction;

  Notify;
  BeginTransaction;
  DataState.Dirty := False;
  OpenQueries;
  qryMain.Insert;
end;

end.
