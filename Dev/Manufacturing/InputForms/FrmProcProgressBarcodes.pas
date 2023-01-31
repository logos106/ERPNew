unit FrmProcProgressBarcodes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls, Shader,
  DNMPanel , ProcProgressBarcodes, DNMSpeedButton, ActnList, DNMAction, ImageDLLLib , ProcProgressLib;

type
  TFmProcProgressBarcodes = class(TBaseForm)
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlReport: TDNMPanel;
    pnlFooter: TDNMPanel;
    Actions: TActionList;
    actPrint: TDNMAction;
    actclose: TDNMAction;
    pnlButtons: TDNMPanel;
    pnlAdvPrinting: TDNMPanel;
    chkPreview: TCheckBox;
    DNMPanel1: TDNMPanel;
    ChkShowCurrentOnly: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actPrintExecute(Sender: TObject);
    procedure actcloseExecute(Sender: TObject);
    procedure ChkShowCurrentOnlyClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    fProcProgressBarcodes: TProcProgressBarcodesGUI;
    fiSaleLineId: Integer;
    fiEmployeeId: Integer;
    btn_Print : TERPMainSwitchButton;
    btn_close : TERPMainSwitchButton;
    fiProcessEmployeeId: Integer;

    Procedure Makebuttons;
  public
    Property SaleLineId :Integer read fiSaleLineId write fisaleLineId;
    Property EmployeeId :Integer read fiEmployeeId write fiEmployeeId;
    Property ProcessEmployeeId :Integer read fiProcessEmployeeId write fiProcessEmployeeId;
    Function PrintBuildReport(InId: Integer; DoneQtytype : tDoneQtytype):Boolean ;
  end;


implementation

uses CommonLib, tcConst, tcDataUtils, frmProcProgress ;

{$R *.dfm}

procedure TFmProcProgressBarcodes.actcloseExecute(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TFmProcProgressBarcodes.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not Assigned(fProcProgressBarcodes) then exit;
  fProcProgressBarcodes.chkAdvancedPrinting.checked := True;
  fProcProgressBarcodes.chkPreview.checked := chkPreview.checked ;
  fProcProgressBarcodes.ChkChooseRpt.checked := False;//ChkChooseRpt.checked ;
  fProcProgressBarcodes.btnprintbarcode.click;
end;

procedure TFmProcProgressBarcodes.ChkShowCurrentOnlyClick(Sender: TObject);
begin
  inherited;
  fProcProgressBarcodes.ChkShowCurrentOnly.Checked := ChkShowCurrentOnly.Checked;
end;

procedure TFmProcProgressBarcodes.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TFmProcProgressBarcodes.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  fProcProgressBarcodes.Close;
end;

procedure TFmProcProgressBarcodes.FormCreate(Sender: TObject);
begin
  inherited;
  fProcProgressBarcodes:= TProcProgressBarcodesGUI.Create(self);
  //fProcProgressBarcodes.filterString := 'qty_4>0';
  Makebuttons;
end;

procedure TFmProcProgressBarcodes.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Assigned(fProcProgressBarcodes) then fProcProgressBarcodes.OnKeyUp(fProcProgressBarcodes,Key,Shift);
end;

procedure TFmProcProgressBarcodes.FormShow(Sender: TObject);
begin
  inherited;
          fProcProgressBarcodes.Parent := pnlReport;
          fProcProgressBarcodes.align := alclient;
          fProcProgressBarcodes.BorderStyle := Forms.bsNone;
          fProcProgressBarcodes.fbIgnoreQuerySpeed := true;
          try
            fProcProgressBarcodes.SaleLineId := SaleLineId;
            fProcProgressBarcodes.EmployeeId := EmployeeId;
            fProcProgressBarcodes.ProcessEmployeeId := fiProcessEmployeeId;
            fProcProgressBarcodes.NonSearchMode := True;
            fProcProgressBarcodes.Show;
            ChkShowCurrentOnly.Checked := fProcProgressBarcodes.ChkShowCurrentOnly.Checked; // this is saved in list's gui prefs
            fProcProgressBarcodes.HeaderPanel.Visible := False;
            fProcProgressBarcodes.GridinLargefont;
            fProcProgressBarcodes.ChkShowCurrentOnlyClick(nil);
          except
            FreeAndNil(fProcProgressBarcodes);
          end;
    if fiProcessEmployeeId <> 0 then
         ChkShowCurrentOnly.caption :=  '  Show List of '+(*+NL+ '  '+ *)tcdatautils. getemployeeName(fiProcessEmployeeId )
    else ChkShowCurrentOnly.caption := '  Show Current'+(*NL+*)' Only';

end;

procedure TFmProcProgressBarcodes.Makebuttons;
  Procedure MakeButton(Button  : TERPMainSwitchButton; btnname :String; aAction :TDnmAction; aParentPanel :TDnmPanel; aAlign :  TAlign = alleft);
  begin
    With Button do begin
      Name      := MakeName(Self,btnname);
      Parent    := aParentPanel;
      DnmAction := aACtion;
      align     := aAlign;
      width     := 175;
      height    := 175;
      AlignwithMargins:= True;
      Margins.Left    := 3;
      Margins.right   := 3;
      Margins.top     := 3;
      Margins.bottom  := 3;
      Parentfont      := True;
      Wordwrap        := True;
    end;
  end;
begin
  btn_close	    := TERPMainSwitchButton.create(Self);  MakeButton(btn_close   ,'btn_close'   , actclose      , pnlButtons, alright);
  btn_Print	    := TERPMainSwitchButton.create(Self);  MakeButton(btn_Print   ,'btn_Print'   , actPrint      , pnlButtons, alleft);
  btn_close.Left := self.width;
end;

function TFmProcProgressBarcodes.PrintBuildReport(InId: Integer; DoneQtytype: tDoneQtytype): Boolean;
begin
  result := False;
  if Assigned(Owner) and (Owner is TfmProcProgress) then
    REsult := TfmProcProgress(Owner).PrintBuildReport(InId , DoneQtytype) ;

end;

initialization
  RegisterClassOnce(TFmProcProgressBarcodes);

end.
