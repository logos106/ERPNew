unit frmSearchField;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls;

type
  TfmSearchField = class(TBaseInputGUI)
    fldName: TEdit;
    Button1: TButton;
    Qrytables: TERPQuery;
    QryFields: TERPQuery;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSearchField: TfmSearchField;

implementation

uses AppDatabase, CommonLib, tcConst;

{$R *.dfm}

procedure TfmSearchField.Button1Click(Sender: TObject);

begin
  inherited;
  if fldname.Text = '' then exit;
  ListBox1.Items.Clear;
  Qrytables.Open;
  Qrytables.First;
  DoShowProgressbar(Qrytables.recordcount , WaitMSG);
  try
    While Qrytables.Eof = False do begin
      closedb(QryFields);
      QryFields.SQL.Text := 'Desc ' + Qrytables.Fields[0].AsString;
      QryFields.open;
      if QryFields.recordcount >0 then begin
        QryFields.first;
        While QryFields.Eof = FAlse do begin
          if pos(uppercase(fldName.Text)  , uppercase(QryFields.fields[0].AsString))>0 then
            ListBox1.Items.Add(Qrytables.Fields[0].AsString +'.' +QryFields.fields[0].AsString);
          QryFields.Next;
        end;
      end;
      DoStepProgressbar(Qrytables.Fields[0].AsString);
      Qrytables.Next;
    end;
  finally
    DoHideProgressbar;
  end;

end;
procedure TfmSearchField.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

initialization
  RegisterClassOnce(TfmSearchField);

end.

