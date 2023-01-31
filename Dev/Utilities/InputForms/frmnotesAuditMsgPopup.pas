unit frmnotesAuditMsgPopup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls, ExtCtrls, DNMPanel, DNMSpeedButton, db, Shader,
  Menus;

type
  TfmnotesAuditMsgPopup = class(TfrmBaseGUI)
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    memoOld: TMemo;
    cmdClose: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel4: TDNMPanel;
    memonew: TMemo;
    lblFrom: TLabel;
    Label1: TLabel;
    DNMPanel5: TDNMPanel;
    lblChangedby: TLabel;
    EdtChangedby: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmdCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    Class Procedure Memopopup(ds:TDataset);
  end;

implementation

{$IFDEF DevMode}
uses
  CommonLib;
{$ENDIF}

{$R *.dfm}

{ TfmnotesAuditMsgPopup }

procedure TfmnotesAuditMsgPopup.cmdCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmnotesAuditMsgPopup.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmnotesAuditMsgPopup.FormCreate(Sender: TObject);
begin
  inherited;
  MemoNew.Lines.Clear;
  MemoOld.Lines.Clear;
  TitleLabel.Caption := '';
  Self.Caption := 'Change Details';
end;

procedure TfmnotesAuditMsgPopup.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Self.Close  else inherited;
end;

class procedure TfmnotesAuditMsgPopup.Memopopup(ds:TDataset);
var
  fMemoDialog :TfmnotesAuditMsgPopup;
  s:String;
begin
    fMemoDialog:= TfmnotesAuditMsgPopup.create(nil);
    try
      try
        //fMemoDialog.Memo.Text := memotext;
        if Ds.findfield('NoteschangedValue') <> nil then fMemoDialog.MemoNew.Lines.Text := Ds.findfield('NoteschangedValue') .asString;
        if Ds.findfield('NotesOldValue') <> nil then fMemoDialog.MemoOld.Lines.Text := Ds.findfield('NotesOldValue') .asString;

        s:= '';
        if ds.findfield('TransType')<> nil then s:= ds.findfield('TransType').asString;
        if ds.findfield('TransGlobalRef')<> nil then s:= s+ ' #' + ds.findfield('TransGlobalRef').asString;
        fMemoDialog.Caption := s;

        s:= '';
        if ds.findfield('FieldName')<> nil then s:= ds.findfield('Fieldname').asString ;
        fMemoDialog.TitleLabel.Caption := s;

        if ds.findfield('EmployeeName')<> nil then s:=ds.findfield('EmployeeName').asString;
        fMemoDialog.EdtChangedby.text := s;

        fMemoDialog.ShowModal;
      except
         {$IFDEF DevMode}
        on E:Exception do begin
            MessageDlgXP_Vista(E.Message , mterror, [mbok],0);
        end;
         {$ENDIF}
      end;
    finally
      Freeandnil(fMemoDialog);
    end;


end;

end.

