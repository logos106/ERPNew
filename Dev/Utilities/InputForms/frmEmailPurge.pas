unit frmEmailPurge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, wwdbdatetimepicker, DNMSpeedButton, Shader,
  DNMPanel;

type
  TfmEmailPurge = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnPurge: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    dtTo: TwwDBDateTimePicker;
    procedure FormShow(Sender: TObject);
    procedure btnPurgeClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEmailPurge: TfmEmailPurge;

implementation

{$R *.dfm}

uses
  BusObjCorrespondence, CommonLib;

procedure TfmEmailPurge.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmEmailPurge.btnPurgeClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This will permently delete all Emails prior to' + #13#10 +
    FormatDateTime('dd mmmm yyyy',dtTo.Date) + ', continue?',mtConfirmation,[mbYes,mbNo],0) = mrYes  then begin
    Processingcursor(True);
    self.DisableForm;
    try
      TCorrespondence.Purge(dtTo.Date,'Email');
      Notify;
    finally
      Processingcursor(False);
      self.EnableForm;
    end;
    close;
  end;
end;

procedure TfmEmailPurge.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmEmailPurge.FormShow(Sender: TObject);
var
  day, month, year: word;
begin
  inherited;
  DecodeDate(now,year,month,day);
  if month = 1 then begin
    month := 11;
    year:= year -1;
  end
  else if month = 2 then begin
    month := 12;
    year:= year -1;
  end
  else
    month := month -2;

  dtTo.Date := EncodeDate(year,month,1);
end;

initialization
  RegisterClass(TfmEmailPurge);

end.
