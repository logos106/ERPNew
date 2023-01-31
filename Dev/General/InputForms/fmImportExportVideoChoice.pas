unit fmImportExportVideoChoice;

interface

Uses TypesLib,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, DNMSpeedButton, ExtCtrls , busobjbase, StdCtrls,
  SelectionDialog, Menus;

type
  TfrmImportExportVideoChoice = class(TBaseForm)
    btnVideo: TDNMSpeedButton;
    btndoit: TDNMSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnVideoClick(Sender: TObject);
    procedure btndoitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    fDOImportExport:TGeneralBooleanFunc;
  public
    Class Procedure OpenForm(Sender:TObject; DOImportExport: TGeneralBooleanFunc);


  end;


implementation

uses CommonLib, FastFuncs, frmVideoPlayer, DNMLib,systemlib;

{$R *.dfm}
{ TfrmImportExportVideoChoice }

class procedure TfrmImportExportVideoChoice.OpenForm(Sender:TObject; DOImportExport: TGeneralBooleanFunc);
var
  form :TComponent;
begin
  if not(sender is TDNMSpeedButton) then exit;
  Form := GetComponentByClassName('TfrmImportExportVideoChoice');
  if not Assigned(Form) then exit;
  TfrmImportExportVideoChoice(Form).fDOImportExport :=DOImportExport;
  TfrmImportExportVideoChoice(Form).btndoit.caption := TDNMSpeedButton(Sender).Caption;
  TfrmImportExportVideoChoice(Form).btndoit.hint  := TfrmImportExportVideoChoice(Form).btndoit.caption +' the Data';
  TfrmImportExportVideoChoice(Form).formstyle := fsStayontop;
  TfrmImportExportVideoChoice(Form).show;
  TfrmImportExportVideoChoice(Form).Width := 360;
  TfrmImportExportVideoChoice(Form).height :=190;
  TfrmImportExportVideoChoice(Form).bringTofront;
end;

procedure TfrmImportExportVideoChoice.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmImportExportVideoChoice.btnVideoClick(Sender: TObject);
var
  fsvideofilename :String;
begin
  inherited;
  if SameText(btndoit.Caption , 'Import') then fsvideofilename := 'Importing_Data_Small.avi' else fsvideofilename := 'Export_Data_Small.avi';
  PlayERPVideo(exedir+'videos\'+fsvideofilename);
end;

procedure TfrmImportExportVideoChoice.btndoitClick(Sender: TObject);
begin
  inherited;
  try
  if Assigned(fDOImportExport) then begin
    Hide;
    if fDOImportExport then Self.Close
    else show;
  end;
  Except
    On E:Exception do begin
      if btndoit.Caption = 'Export' then
        CommonLib.MessageDlgXP_Vista('Error Exporting data with message:' + E.Message, mtInformation, [mbOK], 0)
      else
        CommonLib.MessageDlgXP_Vista('Error Importing data with message:' + E.Message, mtInformation, [mbOK], 0);
    end;
  end;
end;

procedure TfrmImportExportVideoChoice.FormCreate(Sender: TObject);
begin
  inherited;
  fDOImportExport:= nil;
end;

procedure TfrmImportExportVideoChoice.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = VK_ESCAPE then Self.close;
end;

initialization
  RegisterClassOnce(TfrmImportExportVideoChoice);
end.
