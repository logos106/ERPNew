unit frmimages;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, ExtCtrls, StdCtrls, DNMSpeedButton, DNMPanel, Shader, GuiPrefsObj;

type
  Tfmimages = class(TfrmBaseGUI)
    DNMSpeedButton1: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    lblSmall: TLabel;
    lblLarge: TLabel;
    btnsmall: TDNMSpeedButton;
    btnlarge: TDNMSpeedButton;
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnsmallClick(Sender: TObject);
    procedure btnlargeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    smallIconsPath, largeIconspath:String;
    GuiPrefs: TFormGuiPrefs;
    procedure REfreshPath;
  public
    { Public declarations }
  end;


implementation

uses MainSwitchFrm2, dmMainGUI,ImgList,progressdialog, tcConst, CommonLib{$Warnings Off}, {$WARNINGS OFF}FileCtrl{$WARNINGS ON}{$Warnings On};

{$R *.dfm}

procedure Tfmimages.btnlargeClick(Sender: TObject);
begin
  inherited;
  selectdirectory(LargeIconsPath ,[sdAllowCreate, sdPerformCreate, sdPrompt] , 0);
  REfreshPath;

end;

procedure Tfmimages.btnsmallClick(Sender: TObject);
begin
  inherited;
  selectdirectory(smallIconsPath ,[sdAllowCreate, sdPerformCreate, sdPrompt] , 0);
  REfreshPath;
end;

procedure Tfmimages.DNMSpeedButton1Click(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  if   smallIconsPath= '' then begin
    MessageDlgXP_Vista('Please Select the directory for small icons', mtWarning, [mbOK], 0);
    Exit;
  end;
  if  not(Sysutils.DirectoryExists(smallIconsPath)) then begin
    MessageDlgXP_Vista(smallIconsPath +' doesn''t exists.  Please Select the directory for small icons', mtWarning, [mbOK], 0);
    Exit;
  end;
  if   LargeIconsPath= '' then begin
    MessageDlgXP_Vista('Please Select the directory for Large icons', mtWarning, [mbOK], 0);
    Exit;
  end;
  if  not(Sysutils.DirectoryExists(LargeIconsPath)) then begin
    MessageDlgXP_Vista(LargeIconsPath +' doesn''t exists.  Please Select the directory for Large icons', mtWarning, [mbOK], 0);
    Exit;
  end;
    DoShowProgressbar(dtmMainGUI.IMageListNew.Count ,  WAITMSG);
    try
      for ctr := 0 to dtmMainGUI.IMageListNew.Count-1 do begin
        dtmMainGUI.IMageListNew.GetBitmap(ctr, image1.Picture.Bitmap);
        image1.Picture.Bitmap.SaveToFile(LargeIconsPath+'\' +trim(inttostr(ctr))+'.bmp');;
        DoStepProgressbar;
      end;
    finally
      DoHideProgressbar;
    end;

    DoShowProgressbar(dtmMainGUI.IMageListSmlIcons.Count ,  WAITMSG);
    try
      for ctr := 0 to dtmMainGUI.IMageListSmlIcons.Count-1 do begin
        dtmMainGUI.IMageListSmlIcons.GetBitmap(ctr, image1.Picture.Bitmap);
        image1.Picture.Bitmap.SaveToFile(smallIconsPath+'\' +trim(inttostr(ctr))+'.bmp');;
        DoStepProgressbar;
      end;
    finally
      DoHideProgressbar;
    end;

end;
procedure Tfmimages.REfreshPath;
begin
   lblsmall.caption := '(' + smallIconsPath+')';
   lblLarge.caption := '(' + largeIconspath+')';
end;
procedure Tfmimages.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GuiPrefs.Node['smallIconsPath'].AsString:= smallIconsPath;
  GuiPrefs.Node['LargeIconsPath'].AsString:= LargeIconsPath;
  GuiPrefs.SavePrefs;
  inherited;
  action := caFree;
end;

procedure Tfmimages.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs:= TFormGuiPrefs.Create(Self);
  GuiPrefs.Active := True;
  smallIconsPath := GuiPrefs.Node['smallIconsPath'].AsString;
  LargeIconsPath := GuiPrefs.Node['LargeIconsPath'].AsString;
  REfreshPath;
end;

initialization
  RegisterClassOnce(Tfmimages);

end.

