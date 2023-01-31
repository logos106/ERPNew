unit frmTimeZoneEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, SelectionDialog, AppEvnts,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel;

type
  TfmTimeZoneEdit = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    cboTimeZone: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    edtOffset: TEdit;
    Label3: TLabel;
    edtShortName: TEdit;
    chkDST: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure cboTimeZoneChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TTimeZoneRec = class
  public
    Name: string;
    Display: string;
    Offset: double;
  end;

var
  fmTimeZoneEdit: TfmTimeZoneEdit;

  function SelectTimeZone(var aName, aDisplay, aShortName: string; var DST: boolean; var offset: double): boolean;


implementation

uses
  Registry, CommonLib, StrUtils, Types;

  const
  OneHour = 1 /24;

{$R *.dfm}


function SelectTimeZone(var aName, aDisplay, aShortName: string; var DST: boolean; var offset: double): boolean;
var
  form: TfmTimeZoneEdit;
  idx: integer;
  rec: TTimeZoneRec;
begin
  form := TfmTimeZoneEdit.Create(nil);
  try
    form.edtShortName.Text := aShortName;
    form.chkDST.Checked := DST;
    if Offset = 0 then
      form.edtOffset.Text := 'UTC'
    else if Offset < 0 then
      form.edtOffset.Text := 'UTC - ' + FormatDateTime('hh:nn', Abs(Offset) * OneHour)
    else
      form.edtOffset.Text := 'UTC + ' + FormatDateTime('hh:nn', Abs(Offset) * OneHour);
    if aName <> '' then begin
      for idx := 0 to form.cboTimeZone.Items.Count -1 do begin
        if TTimeZoneRec(form.cboTimeZone.Items.Objects[idx]).Name = aName then begin
          form.cboTimeZone.ItemIndex := idx;
          break;
        end;
      end;
    end;
    result := form.ShowModal = mrOk;
    if result then begin
      rec := TTimeZoneRec(form.cboTimeZone.Items.Objects[form.cboTimeZone.ItemIndex]);
      aName := rec.Name;
      aDisplay:= rec.Display;
      aShortName := form.edtShortName.Text;
      DST := form.chkDST.Checked;
      offset:= rec.Offset;
    end;
  finally
    form.Free;
  end;
end;


{ TfmTimeZoneEdit }

procedure TfmTimeZoneEdit.btnOKClick(Sender: TObject);
begin
  inherited;
  if cboTimeZone.ItemIndex < 0 then begin
    CommonLib.MessageDlgXP_Vista('Please select a time zone',mtInformation,[mbOk],0);
    exit;
  end;
  if Trim(edtShortName.Text) = '' then begin
    CommonLib.MessageDlgXP_Vista('Please enter a short name for the time zone',mtInformation,[mbOk],0);
    exit;
  end;

  ModalResult := mrOk;
end;

procedure TfmTimeZoneEdit.cboTimeZoneChange(Sender: TObject);
var
  rec: TTimeZoneRec;
begin
  inherited;
  if cboTimeZone.ItemIndex >= 0 then begin
    rec := TTimeZoneRec(cboTimeZone.Items.Objects[cboTimeZone.ItemIndex]);
    if rec.Offset = 0 then
      edtOffset.Text := 'UTC'
    else if rec.Offset < 0 then
      edtOffset.Text := 'UTC - ' + FormatDateTime('hh:nn', Abs(rec.Offset) * OneHour)
    else
      edtOffset.Text := 'UTC + ' + FormatDateTime('hh:nn', Abs(rec.Offset) * OneHour);
  end;
end;

procedure TfmTimeZoneEdit.FormCreate(Sender: TObject);
var
  reg : TRegistry;
  ts : TStrings;
  i : integer;
  rec: TTimeZoneRec;
  s: string;
  x: integer;
  list: TStringDynArray;
begin
  inherited;
  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  reg.OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones',false);
  if reg.HasSubKeys then begin
    ts := TStringList.Create;
    reg.GetKeyNames(ts);
    reg.CloseKey;
    for i := 0 to ts.Count -1 do begin
      reg.OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones\' +
         ts.Strings[i], false);
      rec := TTimeZoneRec.Create;
      rec.Offset := 0;
      rec.Name := ts.Strings[i];
      rec.Display := reg.ReadString('Display');
//      Memo1.Lines.Add(reg.ReadString('Display'));
//      Memo1.Lines.Add(reg.ReadString('Std'));
//      Memo1.Lines.Add(reg.ReadString('Dlt'));
      reg.CloseKey;
      x := Pos('(UTC',rec.Display);
      if x > 0 then begin
        s:= Copy(rec.Display,x+4,Length(rec.Display));
        x:= Pos(')',s);
        if x > 0 then begin
          s := Trim(Copy(s,1,x-1));
          if s <> '' then begin
            list := StrUtils.SplitString(s,':');
            rec.Offset := StrToFloat(list[0]);
            if High(list) > 0 then
              if StrToIntDef(list[1],0) > 0 then
                rec.Offset := rec.Offset + (StrToIntDef(list[1],0) / 60);
          end;
        end;
      end;
//      if rec.Offset = 0 then
//        edtOffset.Text := 'UTC'
//      else if rec.Offset < 0 then
//        edtOffset.Text := 'UTC - ' + FormatDateTime('hh:nn', Abs(rec.Offset) * OneHour)
//      else
//        edtOffset.Text := 'UTC + ' + FormatDateTime('hh:nn', Abs(rec.Offset) * OneHour);

      cboTimeZone.Items.AddObject(rec.Display,rec);
    end;
    ts.Free;
  end
  else
    reg.CloseKey;

  reg.free;
end;

procedure TfmTimeZoneEdit.FormDestroy(Sender: TObject);
var
  x: integer;
begin
  inherited;
  for x := 0 to cboTimeZone.Items.Count -1 do
    cboTimeZone.Items.Objects[x].Free;
end;

end.
