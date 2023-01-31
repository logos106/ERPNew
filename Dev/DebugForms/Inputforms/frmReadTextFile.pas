unit frmReadTextFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, ProgressDialog;

type
  TfmReadTextFile = class(TBaseInputGUI)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib,  FastFuncs;

{$R *.dfm}

procedure TfmReadTextFile.Button1Click(Sender: TObject);
var
  F: TextFile;
  filename, s:String;
  st:TStringlist;
begin
  inherited;
  if OpenDialog1.Execute then        filename := Opendialog1.Filename    else exit;
  AssignFile(F, filename);
  try
    try
      {$I-}
      Reset(F);
      {$I+}
      IOResult;
    except
      CommonLib.MessageDlgXP_Vista('File is Already in Use!', mtWarning, [mbOK], 0);
    end;

    st:= TStringlist.create;
    try
      Readln(F , s);
      while not Eof(F) do begin
        st.clear;
        Split(s , ',' , st);
        Readln(F , s);
      end;
    finally
      freeandNil(st);
    end;
  finally
    CloseFile(F);
  end;

end;
initialization
  RegisterClassOnce(TfmReadTextFile);
end.

