unit frmFaxJobFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, DNMPanel, DB,   StdCtrls,
  DBCtrls, wwdbedit, Wwdotdot, Wwdbcomb, wwdbdatetimepicker, Mask, Buttons, DNMSpeedButton,
  wwcheckbox, SelectionDialog, AppEvnts, DBAccess, MyAccess,ERPdbComponents, DataState,
  MemDS, Menus, AdvMenus, Shader;

type
  TFaxJobGUI = class(TBaseInputGUI)
    cmdOK: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    qryFaxJob: TERPQuery;
    DSFaxJob: TDataSource;
    qryFaxJobFaxSpoolID: TAutoIncField;
    qryFaxJobEmployeeName: TWideStringField;
    qryFaxJobFaxNumber: TWideStringField;
    qryFaxJobDateSpooled: TDateTimeField;
    qryFaxJobTransType: TWideStringField;
    qryFaxJobTransGlobal: TWideStringField;
    qryFaxJobDateStarted: TDateTimeField;
    qryFaxJobStatus: TWideStringField;
    qryFaxJobDateCompleted: TDateTimeField;
    qryFaxJobRetryCount: TIntegerField;
    qryFaxJobRetryInMins: TIntegerField;
    qryFaxJobPriority: TIntegerField;
    qryFaxJobCancelled: TWideStringField;
    qryFaxJobSentOk: TWideStringField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    qryFaxJobClientName: TWideStringField;
    Label10: TLabel;
    DBEdit10: TDBEdit;
    Label11: TLabel;
    Label12: TLabel;
    DBEdit12: TDBEdit;
    Label13: TLabel;
    DBEdit13: TDBEdit;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    wwDBDateTimePicker2: TwwDBDateTimePicker;
    wwDBDateTimePicker3: TwwDBDateTimePicker;
    cboPickingPriority: TwwDBComboBox;
    wwCheckBox2: TwwCheckBox;
    wwCheckBox1: TwwCheckBox;
    FaxLog: TDBMemo;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    DBMemo2: TDBMemo;
    wwCheckBox3: TwwCheckBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    BitBtn1: TDNMSpeedButton;
    qryFaxJobDescription: TWideMemoField;
    qryFaxJobUseCoverSheet: TWideStringField;
    qryFaxJobCoverSheetNotes: TWideMemoField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    
  end;

//var
//  FaxJobGUI: TFaxJobGUI;

implementation
  
uses FormFactory, CommonLib;
{$R *.dfm}

{ TFaxJobGUI }

procedure TFaxJobGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
//  FaxJobGUI := nil;
end;

procedure TFaxJobGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    qryFaxJob.ParamByName('ID').asInteger := KeyID;
    OpenQueries;
    if KeyID <> 0 then begin
      qryFaxJob.Edit;
    end else begin
      Close;
    end;
  finally
    EnableForm;
  end;   
end;

procedure TFaxJobGUI.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFaxJobGUI.cmdOKClick(Sender: TObject);
begin
  inherited;
  if qryFaxJob.State <> dsBrowse then begin
    qryFaxJob.Post;
    Notify;
  end;
  Self.Close;
end;

procedure TFaxJobGUI.BitBtn1Click(Sender: TObject);
begin
  inherited;
  if qryFaxJobSentOk.AsString <> 'T' then begin
    qryFaxJob.Edit;
    qryFaxJobDescription.AsString    := '';
    qryFaxJobDateStarted.AsVariant   := Null;
    qryFaxJobDateCompleted.AsVariant := Null;
    qryFaxJobStatus.AsString         := 'Spooled';
    qryFaxJobRetryCount.AsInteger    := 0;
    qryFaxJobRetryInMins.AsInteger   := 0;
    qryFaxJobCancelled.AsString      := 'F';
    qryFaxJob.Post;
    Close;
  end;
end;

procedure TFaxJobGUI.FormActivate(Sender: TObject);
begin
  inherited;
  FaxLog.SelStart := FaxLog.GetTextLen;
  FaxLog.Perform(EM_SCROLLCARET, 0, 0);
end;

initialization
  RegisterClassOnce(TFaxJobGUI);
  with FormFact do begin
    RegisterMe(TFaxJobGUI, 'TFaxSpoolListingGUI_*_Refund=FaxSpoolID');
    RegisterMe(TFaxJobGUI, 'TFaxSpoolListingGUI_*_Mail Merge Fax=FaxSpoolID');
    RegisterMe(TFaxJobGUI, 'TFaxSpoolListingGUI_*_Invoice=FaxSpoolID');
    RegisterMe(TFaxJobGUI, 'TFaxSpoolListingGUI_*_Sales Order=FaxSpoolID');
    RegisterMe(TFaxJobGUI, 'TFaxSpoolListingGUI_*_Quote=FaxSpoolID');
    RegisterMe(TFaxJobGUI, 'TFaxSpoolListingGUI_*_Purchase Order=FaxSpoolID');
    RegisterMe(TFaxJobGUI, 'TFaxSpoolListingGUI_*_Return Authority=FaxSpoolID');
    RegisterMe(TFaxJobGUI, 'TFaxSpoolListingGUI_*_Statement=FaxSpoolID');
  end;
end.
