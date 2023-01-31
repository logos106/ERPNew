unit POSPrefs;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 26/07/06  1.00.01 DSP  First version.

}

{$I ERP.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwclearbuttongroup, wwradiogroup, Mask, wwdbedit,
  Wwdotdot, Wwdbcomb, wwcheckbox, ExtCtrls, DNMPanel, DB, DataSourcePrefs,
  DBAccess, MyAccess,ERPdbComponents, DBCtrls, MessageConst, DNMSpeedButton, frmBase, Menus, BasePrefs,
  Wwdbspin, MemDS, wwdblook, AdvScrollBox;

type
  TPOSPrefsGUI = class(TBasePrefsGUI)
    lblWidth: TLabel;
    MyConnection: TERPConnection;
    dsPrefs: TDataSourcePrefs;
    mnuPOSRewardPointTemplate: TPopupMenu;
    CustomerName1: TMenuItem;
    SaleDate1: TMenuItem;
    OpeningBalancePoints1: TMenuItem;
    RedeemedPoints1: TMenuItem;
    SalePoints1: TMenuItem;
    CompanyName1: TMenuItem;
    gryIncomeAccountLookup: TERPQuery;
    DNMPanel3: TDNMPanel;
    Bevel3: TBevel;
    Bevel8: TBevel;
    Label11: TLabel;
    lblPCCPath: TLabel;
    Label50: TLabel;
    Label57: TLabel;
    Label49: TLabel;
    Label51: TLabel;
    Label48: TLabel;
    Label52: TLabel;
    lblPOSBliandBalanceVarianceAccount: TLabel;
    Label55: TLabel;
    wwCheckBox5: TwwCheckBox;
    wwCheckBox9: TwwCheckBox;
    wwCheckBox15: TwwCheckBox;
    wwCheckBox16: TwwCheckBox;
    wwCheckBox10: TwwCheckBox;
    wwCheckBox18: TwwCheckBox;
    wwCheckBox19: TwwCheckBox;
    wwCheckBox22: TwwCheckBox;
    chkUseBlindBalance: TwwCheckBox;
    wwCheckBox24: TwwCheckBox;
    wwCheckBox25: TwwCheckBox;
    wwCheckBox26: TwwCheckBox;
    wwCheckBox27: TwwCheckBox;
    wwCheckBox28: TwwCheckBox;
    edtPCCPathToVC: TwwDBEdit;
    btnPCCPathSelect: TDNMSpeedButton;
    wwCheckBox12: TwwCheckBox;
    wwCheckBox11: TwwCheckBox;
    wwCheckBox13: TwwCheckBox;
    wwCheckBox14: TwwCheckBox;
    wwCheckBox17: TwwCheckBox;
    chkPOSPrintAfterSave: TwwCheckBox;
    edtValue: TwwDBEdit;
    chkRoundLotsnfrom: TwwCheckBox;
    spedtRoundLotsOf: TwwDBSpinEdit;
    edtRoundUp: TwwDBSpinEdit;
    wwCheckBox20: TwwCheckBox;
    chkCombineQuantity: TwwCheckBox;
    wwCheckBox21: TwwCheckBox;
    chkPOSPostBlindBalanceVariance: TwwCheckBox;
    cboPOSBliandBalanceVarianceAccount: TwwDBLookupCombo;
    wwCheckBox23: TwwCheckBox;
    wwCheckBox29: TwwCheckBox;
    wwDBSpinEdit1: TwwDBSpinEdit;
    wwCheckBox30: TwwCheckBox;
    DNMPanel2: TDNMPanel;
    Bevel2: TBevel;
    Label8: TLabel;
    wwCheckBox7: TwwCheckBox;
    wwCheckBox8: TwwCheckBox;
    DNMPanel1: TDNMPanel;
    Bevel7: TBevel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label6: TLabel;
    lblUSBPrinter: TLabel;
    wwCheckBox1: TwwCheckBox;
    wwCheckBox2: TwwCheckBox;
    wwCheckBox3: TwwCheckBox;
    wwCheckBox6: TwwCheckBox;
    wwCheckBox4: TwwCheckBox;
    cboReceiptPrinterType: TwwDBComboBox;
    grpPrnPorts: TwwRadioGroup;
    cboUSBPrinter: TDBComboBox;
    chkPrintPOSTemplateReport: TwwCheckBox;
    DNMPanel4: TDNMPanel;
    Bevel5: TBevel;
    Label33: TLabel;
    lblIgnore1: TLabel;
    lblIgnore2: TLabel;
    DBMemo1: TDBMemo;
    DNMPanel5: TDNMPanel;
    Bevel6: TBevel;
    Label38: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label35: TLabel;
    lblIgnore3: TLabel;
    lblIgnore4: TLabel;
    Label39: TLabel;
    Label42: TLabel;
    POSRewardPointTemplate: TDBMemo;
    DBMemo2: TDBMemo;
    pnlspecialbarcode: TDNMPanel;
    Bevel10: TBevel;
    Bevel4: TBevel;
    Label14: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label32: TLabel;
    lblamounthint: TLabel;
    lblSampleCodehint: TLabel;
    Label56: TLabel;
    edtSpecialBarcodeProductPos: TwwDBEdit;
    edtSpecialBarcodeAmountPos: TwwDBEdit;
    edtSpecialBarcodeLen: TwwDBEdit;
    edtSpecialBarcodeProductLen: TwwDBEdit;
    edtSpecialBarcodeAmountLen: TwwDBEdit;
    edtSampleBarCode: TEdit;
    DNMPanel6: TDNMPanel;
    Bevel9: TBevel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    wwDBComboBox1: TwwDBComboBox;
    wwCheckBox31: TwwCheckBox;
    wwDBComboBox2: TwwDBComboBox;
    wwCheckBox32: TwwCheckBox;
    wwCheckBox33: TwwCheckBox;
    wwDBEdit1: TwwDBEdit;
    wwDBComboBox3: TwwDBComboBox;
    procedure edtSpecialBarcodeLenExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboReceiptPrinterTypeChange(Sender: TObject);
    procedure CompanyName1Click(Sender: TObject);
    (*procedure chkRoundLotsClick(Sender: TObject);
    procedure chkRoundLotsExit(Sender: TObject);*)
    (*procedure chkRoundup5CentsClick(Sender: TObject);
    procedure chkRoundup5CentsExit(Sender: TObject);*)
    procedure cboUSBPrinterExit(Sender: TObject);
    (*procedure chkRoundLotsnfromExit(Sender: TObject);
    procedure chkRoundLotsnfromClick(Sender: TObject);*)
    procedure cboRoundUpEnter(Sender: TObject);
    procedure chkRoundLotsnfromExit(Sender: TObject);
    procedure chkPOSPostBlindBalanceVarianceClick(Sender: TObject);
  private
    fPreferencesForm: TForm;
    Procedure Printersetting;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
    procedure PopulateroundLotsOf;
    function getSpecialBarcodeAmountLen: Integer;
    function getSpecialBarcodeAmountPos: Integer;
    function getSpecialBarcodeLen: Integer;
    function getSpecialBarcodeProductLen: Integer;
    function getSpecialBarcodeProductPos: Integer;
    Procedure SetSpecialBarcodeAmountLen(Const Value :Integer);
    Procedure SetSpecialBarcodeAmountPos(Const Value :Integer);
    Procedure SetSpecialBarcodeLen(Const Value :Integer);
    Procedure SetSpecialBarcodeProductLen(Const Value :Integer);
    Procedure SetSpecialBarcodeProductPos(Const Value :Integer);
    procedure PopulateSampleBarcode(Sender :TwwDBEdit =nil);
    procedure SetPrefvalue(const Value: Integer; fieldname: String);
    (*procedure POSroundOption(Sender: Twwcheckbox);*)
  Protected
      procedure StartupProcess(var Msg: TMessage); Override;
      procedure FinishProcess(var Msg: TMessage); Override;
  public
    constructor Create(AOwner:TComponent); override;
    Property SpecialBarcodeAmountLen  : Integer read getSpecialBarcodeAmountLen   write setSpecialBarcodeAmountLen;
    Property SpecialBarcodeAmountPos  : Integer read getSpecialBarcodeAmountPos   write setSpecialBarcodeAmountPos;
    Property SpecialBarcodeLen        : Integer read getSpecialBarcodeLen         write setSpecialBarcodeLen;
    Property SpecialBarcodeProductLen : Integer read getSpecialBarcodeProductLen  write setSpecialBarcodeProductLen;
    Property SpecialBarcodeProductPos : Integer read getSpecialBarcodeProductPos  write setSpecialBarcodeProductPos;
  end;

implementation

uses CommonLib, printers, FastFuncs, DNMLib, AppEnvironment, tcConst;

{$R *.dfm}

{ TPOSPrefsGUI }
Procedure TPOSPrefsGUI.PopulateroundLotsOf;
(*var
  fiDecimalPlaces, ctr:Integer;*)
begin
  (*cboroundLotsof.Items.Clear;
  fiDecimalPlaces := System.round(Appenv.RegionalOptions.DecimalValue);
  if fiDecimalPlaces =0 then fiDecimalPlaces := 100;
  for ctr:= 0 to fiDecimalPlaces do cboroundLotsof.Items.add(inttostr(ctr));*)
  spedtRoundLotsOf.MinValue:=0;
  spedtRoundLotsOf.Maxvalue :=Appenv.RegionalOptions.DecimalValue;
  if spedtRoundLotsOf.Maxvalue =0 then spedtRoundLotsOf.Maxvalue := 100;
end;
procedure TPOSPrefsGUI.FormCreate(Sender: TObject);
(*var
  ctr:Integer;*)
begin
  inherited;
  lblamounthint.Caption :='(Please note that the currency ' +quotedstr(Appenv.RegionalOptions.ForeignExDefault)+' has '+ inttostr(Appenv.RegionalOptions.DecimalPlaces)+' places for  ' +Quotedstr(Appenv.RegionalOptions.DecimalCurrencyName)+'.'+
                          'So '+ inttostr(Appenv.RegionalOptions.DecimalPlaces)+' digits on the right side will be considered as ' +Quotedstr(Appenv.RegionalOptions.DecimalCurrencyName) +')';
  fPreferencesForm := nil;
  PopulateRoundLotsOf;
  cboUSBPrinter.Items.Clear;
  POSRewardPointTemplate.ShowHint := true;
  POSRewardPointTemplate.hint := 'Value for the field names are dynamically updated while printing.' +chr(13) +
                                 'Field names should be given within "<>". ' +chr(13) +
                                 'Right click inside  to get the list of field names.';
(*  for ctr := 0 to Printer.Printers.Count-1 do
    cboUSBPrinter.Items.Add(Printer.Printers[ctr]);*)
  (*cboUSBPrinter.Items.CommaText :=   Printer.Printers.CommaText;*)
  {$IFDEF DevMode}
       cboReceiptPrinterType.Items.add('Log file'	+ #9 + 'Log file');
       cboReceiptPrinterType.ApplyList;
  {$ENDIF}
  PopulatePrintertypes(cboReceiptPrinterType);
end;
function TPOSPrefsGUI.getSpecialBarcodeLen        :Integer ;begin  result := dsPrefs.DataSet.FieldByName('SpecialBarcodeLen').AsInteger; end;
function TPOSPrefsGUI.getSpecialBarcodeProductPos :Integer ;begin  result := dsPrefs.DataSet.FieldByName('SpecialBarcodeProductPos').AsInteger; end;
function TPOSPrefsGUI.getSpecialBarcodeProductLen :Integer ;begin  result := dsPrefs.DataSet.FieldByName('SpecialBarcodeProductLen').AsInteger; end;
function TPOSPrefsGUI.getSpecialBarcodeAmountPos  :Integer ;begin  result := dsPrefs.DataSet.FieldByName('SpecialBarcodeAmountPos').AsInteger; end;
function TPOSPrefsGUI.getSpecialBarcodeAmountLen  :Integer ;begin  result := dsPrefs.DataSet.FieldByName('SpecialBarcodeAmountLen').AsInteger; end;

Procedure TPOSPrefsGUI.setSpecialBarcodeLen        (Const Value:Integer) ;begin SetPrefvalue(Value, 'SpecialBarcodeLen'); end;
Procedure TPOSPrefsGUI.setSpecialBarcodeProductPos (Const Value:Integer) ;begin SetPrefvalue(Value, 'SpecialBarcodeProductPos'); end;
Procedure TPOSPrefsGUI.setSpecialBarcodeProductLen (Const Value:Integer) ;begin SetPrefvalue(Value, 'SpecialBarcodeProductLen'); end;
Procedure TPOSPrefsGUI.setSpecialBarcodeAmountPos  (Const Value:Integer) ;begin SetPrefvalue(Value, 'SpecialBarcodeAmountPos'); end;
Procedure TPOSPrefsGUI.setSpecialBarcodeAmountLen  (Const Value:Integer) ;begin SetPrefvalue(Value, 'SpecialBarcodeAmountLen'); end;
Procedure TPOSPrefsGUI.SetPrefvalue(Const Value:Integer;fieldname:String) ;
begin
  if dsPrefs.DataSet.FieldByName(fieldname).AsInteger       <> Value then begin
    EditDB(dsPrefs.DataSet);
    dsPrefs.DataSet.FieldByName(fieldname).AsInteger:= Value;
  end;
end;
Procedure TPOSPrefsGUI.PopulateSampleBarcode(Sender :TwwDBEdit =nil);
var
  sProduct, sprice:String;
function defaultvalue(cnt:Integer; isno:Boolean):String;
begin
  result := '';
  while true do begin
    if isno then
      result := result +  '123456789'
    else result := result +  'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if length(result)>=cnt then begin
      result := copy(result, 1,cnt);
      break;
    end;
  end;
end;
begin
  edtSampleBarCode.Text := '';
  lblSampleCodehint.Caption := 'Product : ' +NL + 'Price:';
  if (SpecialBarcodeLen  =0) then exit;

  if (SpecialBarcodeProductLen  = 0)  and  (SpecialBarcodeAmountLen  =0)  then    SpecialBarcodeProductLen := Trunc(SpecialBarcodeLen/2);
  if SpecialBarcodeAmountLen    = 0   then SpecialBarcodeAmountLen  :=  SpecialBarcodeLen - SpecialBarcodeProductLen;
  if SpecialBarcodeProductLen   = 0   then SpecialBarcodeProductLen :=  SpecialBarcodeLen - SpecialBarcodeAmountLen;

  if SpecialBarcodeAmountLen+SpecialBarcodeProductLen <> SpecialBarcodeLen then
    if (Sender  =nil) or (Sender <>  edtSpecialBarcodeLen) then SpecialBarcodeLen :=SpecialBarcodeAmountLen+SpecialBarcodeProductLen
    else SpecialBarcodeAmountLen := SpecialBarcodeLen - SpecialBarcodeProductLen;
    (*else if sender = edtSpecialBarcodeProductLen then SpecialBarcodeAmountLen := SpecialBarcodeLen - SpecialBarcodeProductLen
    else if sender = edtSpecialBarcodeAmountLen then SpecialBarcodeProductLen := SpecialBarcodeLen -SpecialBarcodeAmountLen;*)


  if SpecialBarcodeAmountLen < Appenv.RegionalOptions.DecimalPlaces+2 then begin
      SpecialBarcodeAmountLen :=Appenv.RegionalOptions.DecimalPlaces+2;
      SpecialBarcodeLen := SpecialBarcodeAmountLen+ SpecialBarcodeProductLen;
  end;

  if (SpecialBarcodeProductPos  = 0)  and  (SpecialBarcodeAmountPos=0) then SpecialBarcodeProductPos:= 1;
  if SpecialBarcodeAmountPos    = 0   then  SpecialBarcodeAmountPos := SpecialBarcodeProductLen;
  if (SpecialBarcodeProductPos  = 0)  or    (SpecialBarcodeProductLen  =0) or (SpecialBarcodeAmountPos  =0) or (SpecialBarcodeAmountLen  =0) then exit;


  if (SpecialBarcodeProductPos <>1) and (SpecialBarcodeAmountPos<> 1) then
    if (sender = nil) or (Sender = edtSpecialBarcodeAmountPos) then  SpecialBarcodeProductPos :=1
    else SpecialBarcodeAmountPos := 1;

  if SpecialBarcodeProductPos =1 then SpecialBarcodeAmountPos := SpecialBarcodeProductLen+1
  else SpecialBarcodeProductPos := SpecialBarcodeAmountLen+1;

  sProduct := defaultvalue(SpecialBarcodeProductLen, false);
  sprice := defaultvalue(SpecialBarcodeAmountLen , true);


  if SpecialBarcodeLen <> 0 then begin
    if SpecialBarcodeProductPos <SpecialBarcodeAmountPos then begin
      //edtSampleBarCode.Text := ReplicateStr('x', SpecialBarcodeProductLen)+' - ' +ReplicateStr('9', SpecialBarcodeAmountLen - Appenv.RegionalOptions.DecimalPlaces) +'.' + ReplicateStr('9', Appenv.RegionalOptions.DecimalPlaces);
      edtSampleBarCode.Text := sproduct+sprice;
    end else begin
      //edtSampleBarCode.Text := ReplicateStr('9', SpecialBarcodeAmountLen - Appenv.RegionalOptions.DecimalPlaces) +'.' + ReplicateStr('9', Appenv.RegionalOptions.DecimalPlaces) + ' - ' + ReplicateStr('x', SpecialBarcodeProductLen);
      edtSampleBarCode.Text := sprice + sproduct;
    end;
    sPrice := appenv.RegionalOptions.CurrencySymbol+' '+
              copy(sprice,1,SpecialBarcodeAmountLen - Appenv.RegionalOptions.DecimalPlaces)+'.'+
              copy(sprice,SpecialBarcodeAmountLen - Appenv.RegionalOptions.DecimalPlaces+1, length(sprice));
    lblSampleCodehint.Caption := 'Product: '+sproduct +NL+
                                   'Price  :'+sprice;
  end;
end;


procedure TPOSPrefsGUI.edtSpecialBarcodeLenExit(Sender: TObject);
begin
  if Sender is TwwDBEdit then begin
    PopulateSampleBarcode(TwwDBEdit(Sender));
    if Assigned(fPreferencesForm) and (fPreferencesForm.ActiveControl.Name <> 'btnCancel') then begin
      with dsPrefs.DataSet do begin
        if (FieldByName('SpecialBarcodeLen').AsInteger > 0) or (FieldByName('SpecialBarcodeProductPos').AsInteger > 0) or
           (FieldByName('SpecialBarcodeAmountPos').AsInteger > 0) then begin
          if ((FieldByName('SpecialBarcodeProductPos').AsInteger +
               FieldByName('SpecialBarcodeProductLen').AsInteger - 1) > FieldByName('SpecialBarcodeLen').AsInteger) or
             ((FieldByName('SpecialBarcodeAmountPos').AsInteger - 1) > FieldByName('SpecialBarcodeLen').AsInteger) then
            CommonLib.MessageDlgXP_Vista('Position + Length extend Entire Length. Please adjust.', mtInformation, [mbOK], 0);
        end;
      end;
    end;
  end;
end;

constructor TPOSPrefsGUI.create(AOwner: TComponent);
var
  ctr: Integer;
begin
  inherited create(AOwner);
  for ctr := 0 to Printer.Printers.Count-1 do
    cboUSBPrinter.Items.Add(Printer.Printers[ctr]);

end;

procedure TPOSPrefsGUI.Printersetting;
begin
  lblUSBPrinter.enabled          := dnmlib.IsUSBPrinter(cboReceiptPrinterType.text);
  cboUSBPrinter.enabled          := dnmlib.IsUSBPrinter(cboReceiptPrinterType.text);
  chkPrintPOSTemplateReport.enabled          :=(cboUSBPrinter.enabled) and (cboUSBPrinter.text <>'');
  grpPrnPorts.enabled            := not(dnmlib.IsUSBPrinter(cboReceiptPrinterType.text));
end;

procedure TPOSPrefsGUI.cboRoundUpEnter(Sender: TObject);
begin
  inherited;
  edtRoundUp.MinValue:= 0;
  edtRoundUp.MaxValue :=spedtRoundLotsOf.Value;
end;

procedure TPOSPrefsGUI.cboReceiptPrinterTypeChange(Sender: TObject);
begin
  inherited;
  Printersetting;
end;

procedure TPOSPrefsGUI.CompanyName1Click(Sender: TObject);
var
  fldname:String;
begin
  inherited;
  if not (Sender is TMenuItem) then Exit;
  fldname := '<' +TMenuItem(Sender).caption+'>';
  fldname := StringReplace(fldname , '&' , '' , [rfReplaceAll]);
  POSRewardPointTemplate.SelLength:=0;
  POSRewardPointTemplate.SelText:= fldname; 
end;

procedure TPOSPrefsGUI.cboUSBPrinterExit(Sender: TObject);
begin
  inherited;
  chkPrintPOSTemplateReport.enabled          :=(cboUSBPrinter.enabled) and (cboUSBPrinter.text <>'');
end;
procedure TPOSPrefsGUI.chkPOSPostBlindBalanceVarianceClick(Sender: TObject);
begin
  inherited;
  cboPOSBliandBalanceVarianceAccount.Enabled := chkPOSPostBlindBalanceVariance.Checked;
  lblPOSBliandBalanceVarianceAccount.Enabled := chkPOSPostBlindBalanceVariance.Checked;
  if chkPOSPostBlindBalanceVariance.Focused then begin
    if chkPOSPostBlindBalanceVariance.checked then
       chkUseBlindBalance.Checked := true;
  end;
end;

procedure TPOSPrefsGUI.chkRoundLotsnfromExit(Sender: TObject);
begin
  inherited;
  dsPrefs.DataSet.Edit;
  dsPrefs.FieldByName('RoundLotsnRoundup').asBoolean:= chkRoundLotsnfrom.checked;
  dsPrefs.DataSet.Post;
  dsPrefs.DataSet.Edit;
end;

(*procedure TPOSPrefsGUI.chkRoundLotsnfromClick (Sender: TObject);begin  Setcontrolfocus(chkRoundLots)      ;end;
procedure TPOSPrefsGUI.chkRoundLotsnfromExit  (Sender: TObject);begin  POSroundOption(chkRoundLotsnfrom)  ;end;*)
(*procedure TPOSPrefsGUI.chkRoundup5CentsExit   (Sender: TObject);begin  POSroundOption(chkRoundup5Cents)   ;end;
procedure TPOSPrefsGUI.chkRoundup5CentsClick  (Sender: TObject);begin  Setcontrolfocus(chkRoundLotsnfrom) ;end;*)
(*procedure TPOSPrefsGUI.chkRoundLotsClick      (Sender: TObject);begin  Setcontrolfocus(chkRoundup5Cents)  ;end;
procedure TPOSPrefsGUI.chkRoundLotsExit       (Sender: TObject);begin  POSroundOption(chkRoundLots)       ;end;*)

(*procedure TPOSPrefsGUI.POSroundOption(Sender :Twwcheckbox);
begin
  if Sender.checked = False then begin
              if sender = chkRoundLots      then begin chkRoundup5Cents.checked   := true; chkRoundLotsnfrom.checked := False;
     end else if sender = chkRoundup5Cents  then begin chkRoundLotsnfrom.checked  := true; chkRoundLots.checked      := False;
     end else if sender = chkRoundLotsnfrom then begin chkRoundLots.checked       := true; chkRoundup5Cents.checked  := False;
     end;
  end else begin
              if sender = chkRoundLots      then begin chkRoundup5Cents.checked   := False; chkRoundLotsnfrom.checked := False;
     end else if sender = chkRoundup5Cents  then begin chkRoundLotsnfrom.checked  := False; chkRoundLots.checked      := False;
     end else if sender = chkRoundLotsnfrom then begin chkRoundLots.checked       := False; chkRoundup5Cents.checked  := False;
     end;
  end;
  dsPrefs.DataSet.Edit;
  dsPrefs.FieldByName('RoundLots').asBoolean        := chkRoundLots.checked;
  dsPrefs.FieldByName('Roundup5Cents').asBoolean    := chkRoundup5Cents.checked;
  dsPrefs.FieldByName('RoundLotsnRoundup').asBoolean:= chkRoundLotsnfrom.checked;
  dsPrefs.DataSet.Post;
  dsPrefs.DataSet.Edit;
end;*)
procedure TPOSPrefsGUI.PerformFinish(var Msg: TMessage);
begin
DoPrefformFinish(Msg);
end;

procedure TPOSPrefsGUI.PerformStartup(var Msg: TMessage);
begin
  DoPerformStartup(Msg);
end;
procedure TPOSPrefsGUI.StartupProcess(var Msg: TMessage);
begin
  inherited;
  fPreferencesForm := TForm(FindControl(Msg.WParam));

  // PCC
  if dsPrefs.DataSet.FieldByName('UsePCC').AsBoolean then begin
    lblPCCPath.Enabled := True;
    edtPCCPathToVC.Enabled := True;
    btnPCCPathSelect.Enabled := True;

    if (not dsPrefs.DataSet.FieldByName('POSPrintReceiptOnlyOnCompleteSale').AsBoolean) then begin
      dsPrefs.DataSet.Edit;
      dsPrefs.DataSet.FieldByName('POSPrintReceiptOnlyOnCompleteSale').AsBoolean := True;
      CommonLib.MessageDlgXP_Vista('"Print Receipts On Complete Sale" '+#13+#10+
                 'Turned ON in POS section', mtWarning, [mbOK], 0);
    end;

    if (not dsPrefs.DataSet.FieldByName('POSPrintDescriptionMultipleLines').AsBoolean) then begin
      dsPrefs.DataSet.Edit;
      dsPrefs.DataSet.FieldByName('POSPrintDescriptionMultipleLines').AsBoolean := True;
      CommonLib.MessageDlgXP_Vista('"Multiple Lines For Description"'+#13+#10+
                 'Turned ON in POS section', mtWarning, [mbOK], 0);
    end;
  end else begin
    lblPCCPath.Enabled := False;
    edtPCCPathToVC.Enabled := False;
    btnPCCPathSelect.Enabled := False;
  end;
  Printersetting;
  PopulateSampleBarcode;

  cboPOSBliandBalanceVarianceAccount.Enabled := chkPOSPostBlindBalanceVariance.Checked;
  lblPOSBliandBalanceVarianceAccount.Enabled := chkPOSPostBlindBalanceVariance.Checked;
end;
procedure TPOSPrefsGUI.FinishProcess(var Msg: TMessage);
begin

end;

initialization
  RegisterClassOnce(TPOSPrefsGUI);
finalization
  UnRegisterClass(TPOSPrefsGUI);
end.

