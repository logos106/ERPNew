unit FrmShowImage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel,
  DBCtrls, db, AdvPicture;

type
  TfmShowImage = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdClose: TDNMSpeedButton;
    advPicture: TAdvPicture;
    LblDescription: TLabel;
    lblfooter: TLabel;
    procedure cmdCloseClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure RefreshDB(Datasource: Tdatasource; fieldname: string);
  public
  end;

Procedure showImage(OwnerForm :Tform ; fcolor :TColor; Datasource:Tdatasource; fieldname:string;  formCaption , ImageCaption :String; Description:String = ''; footerDesc :String = '');


implementation

uses ImagesLib, CommonLib;

{$R *.dfm}

Procedure showImage(OwnerForm :Tform ; fcolor :TColor; Datasource:Tdatasource; fieldname:string;  formCaption , ImageCaption :String; Description:String = ''; footerDesc :String = '');
var
  form: TfmShowImage;
begin
  form:= TfmShowImage.Create(OwnerForm);
  try
     form.Caption := formCaption;
     form.TitleLabel.caption :=  ImageCaption;
     form.refreshDB(datasource, FieldName);
     form.color := fcolor;
     form.LblDescription.Visible:=  Trim(Description)<> '';
     form.LblDescription.Caption:=  Trim(Description);
     form.lblfooter.Visible     :=  Trim(footerDesc)<> '';
     form.lblfooter.Caption     :=  Trim(footerDesc);
     form.showmodal;
     form.Color := OwnerForm.Color;
  finally
    FreeandNil(form);
  end;
end;


Procedure TfmShowImage.RefreshDB(Datasource:Tdatasource; fieldname:string);
var
  Stream :TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    try
      DBFieldtoJPEg(Stream , datasource.dataset, fieldname);
      Stream.Position := 0;
      advPicture.Picture.LoadFromStream(Stream);
    Except
      on E:Exception do begin
        if devmode then
          MessageDlgXP_Vista('Exception : '+ E.message, mtWarning, [mbOK], 0);
      end;
    end;
  finally
    FreeandNil(Stream);
  end;

end;
procedure TfmShowImage.cmdCloseClick(Sender: TObject);
begin
  inherited;
      if fsModal in FormState then modalresult:= mrCancel
      else Self.close;
end;

procedure TfmShowImage.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_ESCAPE then Begin
      Key := 0;
      if fsModal in FormState then modalresult:= mrCancel
      else Self.close;
  end else inherited;
end;

end.

