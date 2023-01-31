unit ExceptionEmailGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, StdCtrls, Buttons,
  ExtCtrls, DNMPanel, Mask, wwdbedit, DBCtrls, wwcheckbox, wwdblook,
  ComCtrls, DNMSpeedButton, Shader, AdvPageControl;

type
  TExceptionEmail = class(TBaseInputGUI)
    qryMasterExceptionID: TLargeintField;
    qryMasterVersion: TStringField;
    qryMasterCompany: TStringField;
    qryMasterUser: TStringField;
    qryMasterDate: TStringField;
    qryMasterExceptionType: TStringField;
    qryMasterExceptionMessage: TStringField;
    qryMasterModule: TStringField;
    qryMasterSource: TStringField;
    qryMasterSourceProcedure: TStringField;
    qryMasterCallStackUnit: TStringField;
    qryMasterCallStackProcedure: TStringField;
    qryMasterLogFile: TBlobField;
    qryMasterDone: TStringField;
    Label13: TLabel;
    wwCheckBox1: TwwCheckBox;
    Label15: TLabel;
    wwDBEdit5: TwwDBEdit;
    qryMasterOccurrences: TLargeintField;
    qryMasterResult: TStringField;
    qryMasterSourceLine: TLargeintField;
    qryMasterCallStackLine: TLargeintField;
    qryMasterNotes: TMemoField;
    qryResultLookup: TMyQuery;
    PageControl: TAdvPageControl;
    Details: TAdvTabSheet;
    LogFile: TAdvTabSheet;
    DBMemo1: TDBMemo;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel1: TBevel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label14: TLabel;
    Label18: TLabel;
    UserName: TwwDBEdit;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    wwDBEdit6: TwwDBEdit;
    wwDBEdit7: TwwDBEdit;
    wwDBEdit8: TwwDBEdit;
    wwDBEdit9: TwwDBEdit;
    wwDBEdit10: TwwDBEdit;
    wwDBEdit11: TwwDBEdit;
    DBMemo2: TDBMemo;
    cboResult: TwwDBLookupCombo;
    wwDBEdit12: TwwDBEdit;
    wwDBEdit13: TwwDBEdit;
    DBMemo3: TDBMemo;
    Label19: TLabel;
    wwDBEdit14: TwwDBEdit;
    qryMasterFocusedForm: TStringField;
    qryMasterFocusedControl: TStringField;
    Label20: TLabel;
    wwDBEdit15: TwwDBEdit;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Instance: TBaseInputGUI; override;     
  end;

implementation

uses FormFactory,FuncLib,GraphUtil;

{$R *.dfm}

var
  ExceptionEmail: TExceptionEmail;

procedure TExceptionEmail.FormShow(Sender: TObject);
begin
  qryMaster.Params.ParseSQL(qryMaster.SQL.Text, True);
  qryMaster.Params.ParamByName('xID').asInteger := KeyID;
  inherited;
  qryResultLookup.Open;
end;

class function TExceptionEmail.Instance: TBaseInputGUI;
begin
  if ExceptionEmail = nil then begin
    ExceptionEmail := TExceptionEmail.Create(Application);
  end;
  result := ExceptionEmail;
end;

procedure TExceptionEmail.FormDestroy(Sender: TObject);
begin
  inherited;
  ExceptionEmail := Nil;
end;

procedure TExceptionEmail.PrintClick(Sender: TObject);
begin
  ReportName:='Exception Email';
  Preview:=True;
  Dataset:=qryMaster;
  inherited;
end;

procedure TExceptionEmail.FormCreate(Sender: TObject);
begin
  inherited;
  PageControl.TabBackGroundColor := clWhite;
  Details.Color := clWhite;
  Details.ColorTo := cDefaultGradientColor;
  LogFile.Color := Details.Color;
  LogFile.ColorTo := cDefaultGradientColor;
end;

Initialization
  with FormFact do begin
    RegisterMe(TExceptionEmail, 'TExceptionEmailsList_*=ExceptionID');
  end;
end.
