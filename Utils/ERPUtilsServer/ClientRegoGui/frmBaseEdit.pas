unit frmBaseEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, ActnList, DNMSpeedButton, ExtCtrls, DB, DBAccess,
  MyAccess, StdCtrls;

type
  TfmBaseEdit = class(TfmBase)
    pnlBottom: TPanel;
    alMain: TActionList;
    actOk: TAction;
    actCancel: TAction;
    TransConnection: TMyConnection;
    btnOk: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fDirty: boolean;
  protected
    function GetKeyId: integer; virtual;
    procedure SetKeyId(const Value: integer); virtual;
  public
    property KeyID: integer read GetKeyId write SetKeyId;
    property Dirty: boolean read fDirty write fDirty;
  end;

var
  fmBaseEdit: TfmBaseEdit;

implementation

uses
  AppDatabaseObj;

{$R *.dfm}

procedure TfmBaseEdit.FormCreate(Sender: TObject);
begin
  fDirty:= false;
  inherited;
  AppDatabase.AssignConnectionProps(TransConnection);
end;

function TfmBaseEdit.GetKeyId: integer;
begin
  result:= 0;
end;

procedure TfmBaseEdit.SetKeyId(const Value: integer);
begin
  Dirty:= false;
end;

procedure TfmBaseEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
  if TransConnection.InTransaction then
    TransConnection.Rollback;
end;

end.
