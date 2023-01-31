unit EFTOptionsPopup;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 ??/??/?? 1.00.01  ???  Initial Version
 19/12/05 1.00.02  AL   Removed "Instance", added RegisterClass  *Task306*
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB,  SelectionDialog, AppEvnts, StdCtrls,
  Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, wwcheckbox, DBAccess, MyAccess,ERPdbComponents, DataState,
  Menus, AdvMenus, Shader, ImgList, ProgressDialog, MemDS;

type
  TEFTOptions = class(TBaseInputGUI)
    cboIncludeBalanceRecord: TwwCheckBox;
    Label1: TLabel;
    cboIncludeNetTotal: TwwCheckBox;
    Label2: TLabel;
    cboIncludeCreditTotal: TwwCheckBox;
    Label3: TLabel;
    cboIncludeDebitTotal: TwwCheckBox;
    Label4: TLabel;
    Bevel1: TBevel;
    cmdCancel: TDNMSpeedButton;
    cmdOk: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    fIncludeBalanceRecord,
    fIncludeNetTotal,
    fIncludeCreditTotal,
    fIncludeDebitTotal: boolean;
  public
    { Public declarations }
    
    property IncludeBalanceRecord: boolean read fIncludeBalanceRecord write fIncludeBalanceRecord;
    property IncludeNetTotal: boolean read fIncludeNetTotal write fIncludeNetTotal;
    property IncludeCreditTotal: boolean read fIncludeCreditTotal write fIncludeCreditTotal;
    property IncludeDebitTotal: boolean read fIncludeDebitTotal write fIncludeDebitTotal;
  end;


implementation

uses MAIN, CommonLib;

{$R *.dfm}

procedure TEFTOptions.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TEFTOptions.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TEFTOptions.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    Top := ((MainForm.ClientHeight - MainForm.MainToolBar.Height - MainForm.StatusBar.Height) - Self.Height) div 2;
    Left := (MainForm.ClientWidth - Self.Width) div 2;
    cboIncludeBalanceRecord.Checked := fIncludeBalanceRecord;
    cboIncludeNetTotal.Checked := fIncludeNetTotal;
    cboIncludeCreditTotal.Checked := fIncludeCreditTotal;
    cboIncludeDebitTotal.Checked := fIncludeDebitTotal;
  finally
    EnableForm;
  end;   
end;

procedure TEFTOptions.cmdOkClick(Sender: TObject);
begin
  inherited;
  fIncludeBalanceRecord := cboIncludeBalanceRecord.Checked;
  fIncludeNetTotal := cboIncludeNetTotal.Checked;
  fIncludeCreditTotal := cboIncludeCreditTotal.Checked;
  fIncludeDebitTotal := cboIncludeDebitTotal.Checked;
end;

procedure TEFTOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
  
end;

Initialization
  RegisterClassOnce(TEFTOptions);

end.

