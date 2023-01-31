unit frmPopupSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel,
  Mask, wwdbedit, Wwdotdot, Wwdbcomb , db;

type
  TfmPopupSelect = class(TBaseForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSelect: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    cboSelect: TwwDBComboBox;
    lbltitle: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure MakeDatabselist;
    { Private declarations }
  public
    { Public declarations }
  end;

  function SelectDatabase(var aDatabase: string): boolean;
  function SelectValue(Title1, title2,Valuelist,DefaultValue:String):String;
  function SelectRecord(Title1, title2:String; ds:Tdataset; defaultValue, displayfield :String; resultField:String =''):String;

implementation

{$R *.dfm}

uses
  CommonDbLib, CommonLib;

function SelectRecord(Title1, title2:String; ds:Tdataset; defaultValue, displayfield :String; resultField:String =''):String;
var
  form: TfmPopupSelect;
begin
  result:= '';
  form := TfmPopupSelect.Create(nil);
  try
    with Form do begin
      Caption := title1;
      TitleLabel.Caption:= Title1;
      lbltitle.Caption  := title2;
      cboSelect.Items.clear;
      if resultField='' then resultField := displayfield;
      cboSelect.mapList := not(sametext(displayfield, resultField));
        if ds.Active = False then ds.Open;
        if ds.RecordCount>0 then begin
          ds.First;
          while ds.Eof = False do begin
            if sametext(displayfield, resultField) then
              cboSelect.Items.Add(ds.fieldbyname(displayfield).asString)
            else
              cboSelect.Items.Add(ds.fieldbyname(displayfield).asString + #9 +ds.fieldbyname(Resultfield).asString);
            ds.Next;
          end;
        end;
      cboSelect.ItemIndex := cboSelect.Items.IndexOf(DefaultValue);
      if ShowModal = mrOk then begin
         if cboSelect.Text <> '' then begin
           Result := cboSelect.Value;
         end;
       end;
    end;
  finally
    Freeandnil(Form);
  end;
end;
function SelectValue(Title1, title2,Valuelist,DefaultValue:String):String;
var
  form: TfmPopupSelect;
  ctr:Integer;
  st:TStringlist;
begin
  result:= '';
  form := TfmPopupSelect.Create(nil);
  try
    with Form do begin
      Caption := title1;
      TitleLabel.Caption:= Title1;
      lbltitle.Caption  := title2;
      cboSelect.Items.clear;
      st:= TStringlist.Create;
      try
        for ctr:= 0 to st.Count-1 do
          cboSelect.Items.Add(st[ctr]);
      finally
        Freeandnil(St);
      end;
      cboSelect.ItemIndex := cboSelect.Items.IndexOf(DefaultValue);
      if ShowModal = mrOk then begin
         if cboSelect.Text <> '' then begin
           Result := cboSelect.Text;
         end;
       end;
    end;
  finally
    Freeandnil(Form);
  end;
end;

function SelectDatabase(var aDatabase: string): boolean;
var
  form: TfmPopupSelect;
begin
  result:= false;
  form := TfmPopupSelect.Create(nil);
  try
   form.MakeDatabselist;
   form.cboSelect.ItemIndex := form.cboSelect.Items.IndexOf(aDatabase);
   if form.ShowModal = mrOk then begin
     if form.cboSelect.Text <> '' then begin
       aDatabase := form.cboSelect.Text;
       result:= true;
     end;
   end;
  finally
    form.Free;
  end;
end;


procedure TfmPopupSelect.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//  Action := caFree;
end;

procedure TfmPopupSelect.MakeDatabselist;
var
  idx: integer;
begin
  inherited;
  CommonDbLib.GetSharedMyDacConnection.GetDatabaseNames(cboSelect.Items);
  if cboSelect.Items.Count > 1 then begin
    idx := cboSelect.Items.IndexOf('erpnewdb');
    if idx >= 0 then
      cboSelect.Items.Delete(idx);
    cboSelect.ItemIndex := 0;
  end;
end;

end.
