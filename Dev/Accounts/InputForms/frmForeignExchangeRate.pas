unit frmForeignExchangeRate;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 13/05/05  1.00.01 IJB  Relabled Hedging Formula parameters to reflect their
  //                        use in the hedging formula (see ForeignExchangeObj
  //                        unit for notes on the Hedging formula).
  // 25/08/05  1.00.02 IJB  Added code to enforce user to enter Buy and Sell rates
  // 19/10/05  1.00.03 DLS  Added RegisterClass
  // 12/04/07  1.00.04 DSP  Fixed bug where exception occurred when New button
  //                        is pressed with no entries.

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  StdCtrls,
  Mask, DBCtrls, ExtCtrls, DNMPanel, wwcheckbox, Buttons, DNMSpeedButton, DBAccess,
  MyAccess,ERPdbComponents, ComCtrls,AdvOfficeStatusBar, DataState, Menus, AdvMenus, MemDS, Shader,
  ImgList, BusObjCurrency, BusObjBase, ActnList, wwdblook, ProgressDialog, DAScript, MyScript;

type
  TForeignExchangeRateGUI = class(TBaseInputGUI)
    qryCurrencyConversions: TERPQuery;
    cmdOk: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    DSCurrencyConversions: TDataSource;
    Label11: TLabel;
    chkActive: TwwCheckBox;
    qryCurrencyConversionsCurrencyID: TAutoIncField;
    qryCurrencyConversionsCountry: TWideStringField;
    qryCurrencyConversionsCurrency: TWideStringField;
    qryCurrencyConversionsCode: TWideStringField;
    qryCurrencyConversionsBuyRate: TFloatField;
    qryCurrencyConversionsActive: TWideStringField;
    qryCurrencyConversionsRateLastModified: TDateField;
    qryCurrencyConversionsSellRate: TFloatField;
    PageControl1: TPageControl;
    tabGeneral: TTabSheet;
    tabHedgingFormula: TTabSheet;
    DNMPanel1: TDNMPanel;
    DNMPanel3: TDNMPanel;
    Bevel3: TBevel;
    Description_Label: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel2: TBevel;
    Label1: TLabel;
    edtDescription: TDBEdit;
    Code: TDBEdit;
    txtBuyRate: TDBEdit;
    cbocountry: TwwDBLookupCombo;
    txtSellRate: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    Label9: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Bevel1: TBevel;
    qryCurrencyConversionsFixedRate: TFloatField;
    qryCurrencyConversionsUpperVariation: TFloatField;
    qryCurrencyConversionsLowerVariation: TFloatField;
    Label10: TLabel;
    DBEdit4: TDBEdit;
    Bevel4: TBevel;
    qryCurrencyConversionsTriggerPriceVariation: TFloatField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label13: TLabel;
    txtCurrencySymbol: TDBEdit;
    qryCurrencyConversionsCurrencySymbol: TWideStringField;
    ActionList: TActionList;
    actSave: TAction;
    actNew: TAction;
    actCancel: TAction;
    qryCountry: TERPQuery;
    qryCountryCountryId: TIntegerField;
    qryCountryCountry: TWideStringField;
    qryCurrencyConversionsGlobalRef: TWideStringField;
    qryCurrencyConversionsEditedFlag: TWideStringField;
    qryCurrencyConversionsmsTimeStamp: TDateTimeField;
    qryCurrencyConversionsCountryID: TLargeintField;
    qryCountryCurrencyDesc: TWideStringField;
    lblBuyratedesc: TLabel;
    lblSellratedesc: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryCurrencyConversionsBuyRateChange(Sender: TField);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure cbocountryCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure ignoreScriptError(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
    procedure BeforeExecuteScript(Sender: TObject; var SQL: string; var Omit: Boolean);
    procedure txtBuyRateExit(Sender: TObject);
    procedure txtSellRateExit(Sender: TObject);
    procedure qryCurrencyConversionsAfterOpen(DataSet: TDataSet);
    procedure txtCurrencySymbolExit(Sender: TObject);
  private
    fSaveClick: Boolean;
    Currency: TCurrency;
    function SaveData: boolean;
    procedure HandleValidationErrors;
    procedure AddCurrencyFieldstoTransactionTable;
    procedure RefreshBuyRateDesc;
    procedure RefreshSellRateDesc;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;

implementation

uses
  FormFactory, DNMExceptions, frmPurchaseOrders,
  CommonLib, AppEnvironment, BusObjConst, tcConst, TransactionsTable, CommonDbLib, EmployeeAccesses,
  LogLib;

{$R *.dfm}

{ TForeignExchangeRateGUI }

procedure TForeignExchangeRateGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      // Roll back any existing transaction
      RollbackTransaction;


      // Put our Database Connection into transaction mode.
      BeginTransaction;

     // qryProcResource.ParamByName('ProcResourceId').asInteger := KeyID;

      if KeyID = 0 then begin
        Currency.New;
        cbocountry.ButtonWidth := 0; // enable by setting default button width
        cbocountry.AutoDropDown:= true;
      end else begin
        Currency.Load(KeyId);
        cbocountry.ButtonWidth:= -1;
      end;
      openQueries;
      SetControlFocus(cbocountry);
      // Exception Handler
    except
      // Handle these known exceptions.
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TForeignExchangeRateGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FormStillOpen('TPurchaseGUI') then begin
    with TPurchaseGUI(GetComponentByClassName('TPurchaseGUI')) do begin
      if AppEnv.CompanyPrefs.UseForeignCurrencyonPO then begin
        UpdateExchangeRate;
      end;
    end
  end;
  RollbackTransaction;
  Action := caFree;
  inherited;
end;

procedure TForeignExchangeRateGUI.qryCurrencyConversionsAfterOpen(
  DataSet: TDataSet);
begin
  inherited;
  RefreshBuyRateDesc;
  RefreshSellRateDesc;
end;

procedure TForeignExchangeRateGUI.qryCurrencyConversionsBuyRateChange(Sender: TField);
begin
  inherited;
  qryCurrencyConversionsRateLastModified.AsDateTime := Now;
end;

procedure TForeignExchangeRateGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  //PostDB(qryCurrencyConversions);
  if Currency.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveData then begin
            self.CommitTransaction;
            CanClose:= true;
          end
          else begin
            CanClose:= false;
          end;
        end;
      mrNo:
        begin
          self.RollbackTransaction;
          CanClose:= true;
        end;
      mrCancel:
        begin
          Exit;
        end;
    end;
  end;
end;

procedure TForeignExchangeRateGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fSaveClick := False;
  Currency:= TCurrency.Create(self);
  Currency.Connection := TMyDacDataConnection.Create(Currency);
  Currency.Connection.MyDacConnection := MyConnection;
  Currency.BusObjEvent := DoBusinessObjectEvent;
end;
procedure TForeignExchangeRateGUI.RefreshBuyRateDesc;
begin
  lblBuyratedesc.caption :=  '1 X ' + uppercase(iif(qryCurrencyConversionsCode.asString='', qryCurrencyConversionsCurrency.asString ,qryCurrencyConversionsCode.asString )) +' = ' +
                              Floattostr(Round(qryCurrencyConversionsBuyRate.asFloat,3)) + ' ' +Appenv.RegionalOptions.ForeignExDefault+NL+
                             uppercase(iif(qryCurrencyConversionsCode.asString='', qryCurrencyConversionsCurrency.asString ,qryCurrencyConversionsCode.asString )) +' To ' +uppercase(Appenv.RegionalOptions.ForeignExDefault);
  Showcontrolhint(lblBuyratedesc,'1 X ' + qryCurrencyConversionsCurrency.asString  +' = ' +
                              Floattostr(Round(qryCurrencyConversionsBuyRate.asFloat,3)) + ' ' +Appenv.RegionalOptions.ForeignExDefault+NL+
                             qryCurrencyConversionsCurrency.asString  +' To ' +uppercase(Appenv.RegionalOptions.ForeignExDefault));
  logtext(lblBuyratedesc.caption);
  lblBuyratedesc.visible := true;
end;
procedure TForeignExchangeRateGUI.RefreshSellRateDesc;
begin
  lblSellratedesc.caption :=  '1 X ' + Appenv.RegionalOptions.ForeignExDefault+' = ' +
                              Floattostr(Round(qryCurrencyConversionsBuyRate.asFloat,3)) + ' ' +uppercase(iif(qryCurrencyConversionsCode.asString='', qryCurrencyConversionsCurrency.asString ,qryCurrencyConversionsCode.asString )) +NL+
                             uppercase(Appenv.RegionalOptions.ForeignExDefault)+ ' To ' + uppercase(iif(qryCurrencyConversionsCode.asString='', qryCurrencyConversionsCurrency.asString ,qryCurrencyConversionsCode.asString )) ;


  ShowcontrolHint(lblSellratedesc, '1 X ' +  Appenv.RegionalOptions.ForeignExDefault+' =  ' + Floattostr(Round(qryCurrencyConversionsSellRate.asFloat,3))+' ' + qryCurrencyConversionsCurrency.asString+NL+
                              uppercase(Appenv.RegionalOptions.ForeignExDefault) +' To ' + uppercase(qryCurrencyConversionsCurrency.asString) );
  logtext(lblSellratedesc.caption);
  lblSellratedesc.visible := true;
end;
procedure TForeignExchangeRateGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TCurrency then
      TCurrency(Sender).DataSet:= qryCurrencyConversions;
  end
end;

procedure TForeignExchangeRateGUI.BeforeExecuteScript(Sender: TObject; var SQL: string; var Omit: Boolean);
begin
  inherited;
  stepProgressbar;
end;

function TForeignExchangeRateGUI.SaveData: boolean;
begin
  result:= true;
  { validate data and return tru if all ok }
  if Currency.Dirty then begin
    if not Currency.Save then
      result:= false;
  end;
end;
procedure TForeignExchangeRateGUI.txtBuyRateExit(Sender: TObject);
begin
  inherited;
  RefreshBuyRateDesc;
end;

procedure TForeignExchangeRateGUI.txtCurrencySymbolExit(Sender: TObject);
begin
  inherited;
  RefreshBuyRateDesc;
  RefreshSellRateDesc;
end;

procedure TForeignExchangeRateGUI.txtSellRateExit(Sender: TObject);
begin
  inherited;
  RefreshSellRateDesc;
end;

procedure TForeignExchangeRateGUI.ignoreScriptError(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
begin
  inherited;
  Action := eaContinue;
end;

procedure TForeignExchangeRateGUI.AddCurrencyFieldstoTransactionTable;
begin
  With TempMyScript do try
    onError := ignoreScriptError;
    BeforeExecute:= BeforeExecuteScript;
    SQL.clear;
    SQL.add('alter table tbltransactions add column ' + Currency.Code +'_FCRate double;');
    SQL.add('alter table tbltransactions add column ' + Currency.Code +'_SellDebitsEx double;');
    SQL.add('alter table tbltransactions add column ' + Currency.Code +'_SellCreditsEx double;');
    SQL.add('alter table tbltransactions add column ' + Currency.Code +'_SellDebitsInc double;');
    SQL.add('alter table tbltransactions add column ' + Currency.Code +'_SellCreditsInc double;');

    SQL.add('alter table rpt_tbltransactions add column ' + Currency.Code +'_FCRate double;');
    SQL.add('alter table rpt_tbltransactions add column ' + Currency.Code +'_SellDebitsEx double;');
    SQL.add('alter table rpt_tbltransactions add column ' + Currency.Code +'_SellCreditsEx double;');
    SQL.add('alter table rpt_tbltransactions add column ' + Currency.Code +'_SellDebitsInc double;');
    SQL.add('alter table rpt_tbltransactions add column ' + Currency.Code +'_SellCreditsInc double;');
    ShowProgressbar(WAITMSG , 10, False);
    try
      execute;
    finally
      HideProgressbar;
    end;
  finally
    Free;
  end;
end;
procedure TForeignExchangeRateGUI.actSaveExecute(Sender: TObject);
var
  TransactionTableObj: TTransactionTableObj;
  msg:String;

begin
  inherited;
  //PostDb(qryCurrencyConversions);
  if not SaveData then begin
    HandleValidationErrors;
    Exit;
  end;
  if (currency.CleanActive =false) and (Currency.active) then begin
    if MessageDlgXP_Vista('For the Reports with ''Foreign currency'' customisation enabled to work,  '+
                       'the ''Closing Date Refresh'' has to be done after reactivating any inactive ''Foreign Exchange Rate''.'+NL+
                       //'Changes cannot be saved until ''Closing Date Refresh''  is done. ' +NL+ NL+
                       'Do you like to run ''Closing Date Refresh'' now? ', mtconfirmation, [mbyes,mbno], 0)  = mrno then begin
        AddCurrencyFieldstoTransactionTable;
    end else begin
      TransactionTableObj := TTransactionTableObj.Create(False);
      try
        if not(TransactionTableObj.Lock('Update Batch / Report')) then begin
          Currency.active := false;
          Exit;
        end;
        if not CanChangeClosingDate then begin
          CommonLib.MessageDlgXP_Vista('You don''t have access to ' + AppEnv.AccessLevels.GetFormDescription('FnChangeClosingDate'), mtInformation, [mbOK], 0);
          Currency.active := false;
          Exit;
        end;
        if not AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing a Closing Date Update') then begin
          CommonLib.MessageDlgXP_Vista('Unable to run ''Closing Date Refresh'' at This Time, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
          Currency.active := false;
          Exit;
        end;
        try
          CommitTransaction;
          if not TransactionTableObj.CleanRefreshTrnsTable(true, false, true,true) then begin
            MessageDlgXP_Vista('''Closing Date Refresh''  Failed.'+
                          'Make sure ''Closing Date Refresh''  is run before you use reports with ''Foreign Currency''.', mtInformation, [mbok], 0);
            AddCurrencyFieldstoTransactionTable;
          end;
        finally
          AppEnv.UtilsClient.UnlockLogon;
        end;
      finally
        TransactionTableObj.unLock('Update Batch / Report');
        FreeandNil(TransactionTableObj);
      end;
    end;
  end;
  CommitTransaction;
  Notify;
  Close;
end;

procedure TForeignExchangeRateGUI.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TForeignExchangeRateGUI.actNewExecute(Sender: TObject);
begin
  inherited;
  //PostDB(qryCurrencyConversions);
  if Currency.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if not SaveData then Exit;
          self.CommitTransaction;
        end;
      mrNo:
        begin

        end;
      mrCancel:
        begin
          Exit;
        end;
    end;
  end;

  KeyID := 0;
  FormShow(nil);
  Currency.Dirty := false;
end;

procedure TForeignExchangeRateGUI.HandleValidationErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  FatalStatusItem := Currency.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    case FatalStatusItem.Code of
      BOR_Currency_BuyRateInvalid :
        begin
          PageControl1.ActivePage:= tabGeneral;
          SetControlFocus(txtBuyRate);
        end;
      BOR_Currency_SellRateInvalid :
        begin
          PageControl1.ActivePage:= tabGeneral;
          SetControlFocus(txtSellRate);
        end;
      BOR_Currency_No_Country :
        begin
          PageControl1.ActivePage:= tabGeneral;
          SetControlFocus(cbocountry);
        end;
      BOR_Currency_No_Currency :
        begin
          PageControl1.ActivePage:= tabGeneral;
          SetControlFocus(edtDescription);
        end;
      BOR_Currency_No_Code :
        begin
          PageControl1.ActivePage:= tabGeneral;
          SetControlFocus(Code);
        end;
    end;
  end;
end;

procedure TForeignExchangeRateGUI.cbocountryCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
   qryCurrencyConversionsCountryID.asInteger := qryCountryCountryId.asInteger;
   qryCurrencyConversionsCountry.asString := qryCountryCurrencyDesc.asString;
end;

initialization
  RegisterClassOnce(TForeignExchangeRateGUI);
  with FormFact do begin
    RegisterMe(TForeignExchangeRateGUI, 'TForeignExchangeRatesListGUI_*=CurrencyID');
    RegisterControl(TForeignExchangeRateGUI, '*_cboForeignCurrencyCode=CurrencyID');
  end;
end.

