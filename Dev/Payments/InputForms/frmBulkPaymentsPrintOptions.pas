unit frmBulkPaymentsPrintOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, DB,  StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel,
  Menus, AdvMenus, Shader, ImgList, ProgressDialog, MemDS, Mask;

type
  PPrintOptions = ^TPrintOptions;
  TPrintOptions = record
    Receipts: boolean;
    Cheques: boolean;
    Screen: boolean;
    Email:Boolean;
    startingchequeNo:String;
  end;

type
  TfrmPrintOptionsGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    btnClose: TDNMSpeedButton;
    btnOK: TDNMSpeedButton;
    chkReceipts: TCheckBox;
    chkCheques: TCheckBox;
    chkScreen: TCheckBox;
    Label4: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    chkEmail: TCheckBox;
    lblStartingchequeno: TLabel;
    edtStartingchequeno: TMaskEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure chkChequesClick(Sender: TObject);

  private
    { Private declarations }
    oPrintOptions: PPrintOptions;
    fbViaBulkCustomerPayments: boolean;
    procedure UpdateResults;
    procedure CancelResults;
    Procedure RefreshOptions;
  public
    { Public declarations }
    property ViaBulkCustomerPayments: boolean read fbViaBulkCustomerPayments write fbViaBulkCustomerPayments stored false;
    property Results: PPrintOptions read oPrintOptions write oPrintOptions;
  end;

implementation

{$R *.dfm}

uses
  DNMExceptions, CommonLib;
  
{ TfrmPrintOptionsGUI }

procedure TfrmPrintOptionsGUI.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;

  inherited;
end;

procedure TfrmPrintOptionsGUI.btnOKClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    UpdateResults;
    Close;
  finally
    EnableForm;
  end;
end;

procedure TfrmPrintOptionsGUI.UpdateResults;
begin
  if Assigned(Results) then begin
    oPrintOptions^.Receipts := chkReceipts.Checked;
    oPrintOptions^.Cheques  := chkCheques.Checked;
    oPrintOptions^.Screen   := chkScreen.Checked;
    oPrintOptions^.Email   := chkEmail.Checked;
    oPrintOptions^.startingchequeNo := trim(edtStartingchequeno.text);
  end;
end;

procedure TfrmPrintOptionsGUI.CancelResults;
begin
  if Assigned(Results) then begin
    oPrintOptions^.Receipts := false;
    oPrintOptions^.Cheques  := false;
    oPrintOptions^.Screen   := false;
  end;
end;

procedure TfrmPrintOptionsGUI.chkChequesClick(Sender: TObject);
begin
  inherited;
  lblStartingchequeno.Visible := chkCheques.visible and chkCheques.Checked ;
  edtStartingchequeno.Visible := chkCheques.visible and chkCheques.Checked;
end;

procedure TfrmPrintOptionsGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      if fbViaBulkCustomerPayments then begin
        chkCheques.Visible := false;
        chkEmail.Visible   := false;
        chkScreen.Top      := 75;
        chkReceipts.Top    := 43;
      end;

      RefreshOptions;


      lblStartingchequeno.Visible := chkCheques.visible and chkCheques.Checked ;
      edtStartingchequeno.Visible := chkCheques.visible and chkCheques.Checked;

      // Do our base stuff.
      inherited;

      // Do this to clear results by default.
      CancelResults;

      // Exception Handler
    except
      // Handle these known exceptions.
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmPrintOptionsGUI.RefreshOptions;
begin
  if assigned(oPrintOptions) then begin
      chkReceipts.Checked := oPrintOptions^.Receipts  ;
      chkCheques.Checked := oPrintOptions^.Cheques   ;
      chkScreen.Checked := oPrintOptions^.Screen    ;
      chkEmail.Checked := oPrintOptions^.Email    ;
      edtStartingchequeno.text := oPrintOptions^.startingchequeNo  ;
  end;
end;

procedure TfrmPrintOptionsGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
(*  Action := caFree;*)
  inherited;
end;

procedure TfrmPrintOptionsGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  CancelResults;
  Close;
end;

initialization
  RegisterClassOnce(TfrmPrintOptionsGUI);

end.
