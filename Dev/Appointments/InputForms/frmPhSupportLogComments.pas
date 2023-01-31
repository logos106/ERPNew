unit frmPhSupportLogComments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SelectionDialog, Menus, ExtCtrls, StdCtrls, DNMPanel,
  DB, MemDS, DBAccess, MyAccess, ERPdbComponents, Grids, Wwdbigrd, Wwdbgrid,
  Shader, frmPhSupportLog, wwdblook, DNMSpeedButton,BaseInputForm,
  ProgressDialog, ImgList, AdvMenus, DataState, AppEvnts, Buttons, Mask,
  wwdbedit;

type
  TfmPhSupportLogComments = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    dsLogLines: TDataSource;
    Qryentered: TERPQuery;
    QryenteredEmployeeName: TWideStringField;
    QryenteredEmployeeID: TIntegerField;
    cboEmployeeName: TwwDBLookupCombo;
    QryAssignTo: TERPQuery;
    WideStringField1: TWideStringField;
    IntegerField1: TIntegerField;
    cboAssignTo: TwwDBLookupCombo;
    btnCancel: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    grdTransactions: TwwDBGrid;
    btnDelete: TwwIButton;
    edtComments: TwwDBEdit;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    function getPhSupportLog: TPhSupportLogGUI;
  public
    Class Procedure PhSupportLogComments(AOwner: TForm(*; ds:TDataset*));
    Property PhSupportLog : TPhSupportLogGUI read getPhSupportLog;
  end;


implementation


{$R *.dfm}

{ TfmPhSupportLogComments }

procedure TfmPhSupportLogComments.btnCancelClick(Sender: TObject);
begin
  inherited;
  Try
    PhSupportLog.PhoneSupportLog.Lines.CancelDb;
     PhSupportLog.PhoneSupportLog.connection.RollbacknestedTransaction;
  Except
    // kill the exception
  End;
  Self.close;
end;

procedure TfmPhSupportLogComments.btnSaveClick(Sender: TObject);
begin
  inherited;
  Try
    PhSupportLog.PhoneSupportLog.Lines.PostDb;
     PhSupportLog.PhoneSupportLog.connection.commitnestedTransaction;
  Except
    // kill the exception
  End;
  Self.close;
end;

procedure TfmPhSupportLogComments.FormShow(Sender: TObject);
begin
  inherited;
  Try
     PhSupportLog.PhoneSupportLog.connection.BeginTransaction;
     PhSupportLog.PhoneSupportLog.connection.beginnestedTransaction;
     dsLogLines.dataset := PhSupportLog.PhoneSupportLog.Lines.Dataset;
     if PhSupportLog.PhoneSupportLog.Lines.count =0 then PhSupportLog.PhoneSupportLog.Lines.New;
  Except
    // kill the exception
  End;
  OpenQueries;
end;

function TfmPhSupportLogComments.getPhSupportLog: TPhSupportLogGUI;
begin
  REsult := Nil;
  if Assigned (Owner) then
    if Owner is TPhSupportLogGUI then
      Result := TPhSupportLogGUI(Owner);
end;

class procedure TfmPhSupportLogComments.PhSupportLogComments(AOwner: TForm(*;  ds: TDataset*));
begin
  With TfmPhSupportLogComments.create(AOWner) do begin
    //dsLogLines.dataset := ds;
    Showmodal;
  end;
end;

end.
