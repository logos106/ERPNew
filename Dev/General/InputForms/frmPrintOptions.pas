{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 15/07/05  Initial Version  BJ  The Print/Preview options can be selected here.
                        Public Property 'BitMapClass' defiens the background clolor
                        The default marble is 'bluemarble' if not specified.
                        Clicking on ok will close the form with modal result = mrok
                        and Cancel with mrCancel
                        Property PrintOption will hae 'P' if Print is selected
                        'S' for preview
                        Form is opened with Preview as the selected option unless
                        specified before opening.
                        The form doesn't need any access rights.
 18/07/05  1.00.02 BJ  Bug fixed: as the form doesn;t need any acces rights, it shows
                       no-access as a part of the form caption. Removed.
}
 unit frmPrintOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseInputForm, StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, DataState,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, DB, 
  wwclearbuttongroup, wwradiogroup, Menus, AdvMenus, Shader, ImgList, MemDS, ProgressDialog;

type
  TfmPrintOptions = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    cmdOK: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    PrintOptions: TwwRadioGroup;
    Bevel33: TBevel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure cmdOKClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PrintOptionsChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fbPrintOption: string;
  public
    { Public declarations }
    
    property PrintOption: string read fbPrintOption write fbPrintOption;
  end;

//var
//  fmPrintOptions: TfmPrintOptions;

implementation

uses
  Forms, CommonLib;

{$R *.dfm}

procedure TfmPrintOptions.cmdOKClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TfmPrintOptions.cmdCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfmPrintOptions.FormCreate(Sender: TObject);
begin
  inherited;
  PrintOptions.Value := 'S';
  PrintOptions.ItemIndex := 1;
  fbIgnoreAccessLevels := true;
end;

procedure TfmPrintOptions.PrintOptionsChange(Sender: TObject);
begin
  inherited;
  fbPrintOption := PrintOptions.Value;
end;

procedure TfmPrintOptions.FormShow(Sender: TObject);
begin
  inherited;
  self.Caption := 'Print Options';
   {as the form doesn;t need any acces rights, it shows no-access at the top.
   This is to remove it.}
end;

initialization
  RegisterClassOnce(TfmPrintOptions);

end.
