unit MessagePrefs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BasePrefs, ExtCtrls, StdCtrls, wwcheckbox, DBCtrls, Mask, wwdbedit,
  DB, DataSourcePrefs, DNMPanel, Menus, AdvMenus, MessageConst, SMSConfigObj, DNMSpeedButton,
  AdvScrollBox;

type
  TMessagePrefsGUI = class(TBasePrefsGUI)
    lblWidth: TLabel;
    dsPrefs: TDataSourcePrefs;
    mnuMsgText: TAdvPopupMenu;
    pnlVoucherSalePrint: TDNMPanel;
    Bevel24: TBevel;
    Label62: TLabel;
    Label184: TLabel;
    Label185: TLabel;
    Label186: TLabel;
    Label187: TLabel;
    Label188: TLabel;
    Label189: TLabel;
    Label190: TLabel;
    edtVoucherSalePrintEmailSubject: TwwDBEdit;
    memVoucherSalePrintEmailText: TDBMemo;
    chkEnableVoucherSalePrintEmail: TwwCheckBox;
    chkEnablVoucherSalePrintSMS: TwwCheckBox;
    memVoucherSalePrintSMSText: TDBMemo;
    pnlSMSConfig: TDNMPanel;
    Bevel9: TBevel;
    Label61: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label81: TLabel;
    lblSMSEnabled: TLabel;
    chkSMSEnabled: TwwCheckBox;
    edtSMSUserName: TEdit;
    edtSMSPassword: TEdit;
    edtPhoneNumber: TEdit;
    btnSMSrates: TDNMSpeedButton;
    pnlShippingContainer: TDNMPanel;
    Bevel10: TBevel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    edtShipContainerChangeEmailSubject: TwwDBEdit;
    memShipContainerChangeEmailText: TDBMemo;
    chkEnableShipContainerChangeEmail: TwwCheckBox;
    chkEnablShipContainerChangeSMS: TwwCheckBox;
    memShipContainerChangeSMSText: TDBMemo;
    pnlSalesOrderShipChange: TDNMPanel;
    Bevel15: TBevel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    edtSOShipChangeEmailSubject: TwwDBEdit;
    memSOShipChangeEmailText: TDBMemo;
    chkEnableSOShipChangeEmail: TwwCheckBox;
    chkEnableSOShipChangeSMS: TwwCheckBox;
    memSOShipChangeSMSText: TDBMemo;
    pnlSalesOrderSave: TDNMPanel;
    Bevel6: TBevel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    edtSOSaveEmailSubject: TwwDBEdit;
    memSOSaveEmailText: TDBMemo;
    chkEnableSOSaveEmail: TwwCheckBox;
    chkEnableSOSaveSMS: TwwCheckBox;
    memSOSaveSMSText: TDBMemo;
    pnlSalesOrderPrint: TDNMPanel;
    Bevel5: TBevel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    edtSOPrintEmailSubject: TwwDBEdit;
    memSOPrintEmailText: TDBMemo;
    chkEnableSOPrintEmail: TwwCheckBox;
    chkEnableSOPrintSMS: TwwCheckBox;
    memSOPrintSMSText: TDBMemo;
    DNMPanel1: TDNMPanel;
    Bevel19: TBevel;
    pnlRAPrint: TLabel;
    Label145: TLabel;
    Label146: TLabel;
    Label147: TLabel;
    Label148: TLabel;
    Label150: TLabel;
    Label151: TLabel;
    Label152: TLabel;
    edtRAPrintEmailSubject: TwwDBEdit;
    memRAPrintEmailText: TDBMemo;
    chkEnableRAPrintEmail: TwwCheckBox;
    chkEnableRAPrintSMS: TwwCheckBox;
    memRAPrintSMSText: TDBMemo;
    pnlRepairPrint: TDNMPanel;
    Bevel17: TBevel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    Label128: TLabel;
    Label129: TLabel;
    edtRepairPrintEmailSubject: TwwDBEdit;
    memRepairPrintEmailText: TDBMemo;
    chkEnableRepairPrintEmail: TwwCheckBox;
    chkEnableRepairPrintSMS: TwwCheckBox;
    memRepairPrintSMSText: TDBMemo;
    pnlRepairInvoiced: TDNMPanel;
    Bevel30: TBevel;
    Label208: TLabel;
    Label209: TLabel;
    Label210: TLabel;
    Label211: TLabel;
    Label212: TLabel;
    Label213: TLabel;
    Label214: TLabel;
    Label215: TLabel;
    wwDBEdit1: TwwDBEdit;
    DBMemo1: TDBMemo;
    wwCheckBox1: TwwCheckBox;
    wwCheckBox2: TwwCheckBox;
    DBMemo2: TDBMemo;
    pnlRefundPrint: TDNMPanel;
    Bevel16: TBevel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    edtRefundPrintEmailSubject: TwwDBEdit;
    memRefundPrintEmailText: TDBMemo;
    chkEnableRefundPrintEmail: TwwCheckBox;
    chkEnableRefundPrintSMS: TwwCheckBox;
    memRefundPrintSMSText: TDBMemo;
    pnlQuoteSave: TDNMPanel;
    Bevel8: TBevel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    edtQuoteSaveEmailSubject: TwwDBEdit;
    memQuoteSaveEmailText: TDBMemo;
    chkEnableQuoteSaveEmail: TwwCheckBox;
    chkEnableQuoteSaveSMS: TwwCheckBox;
    memQuoteSaveSMSText: TDBMemo;
    pnlQuote: TDNMPanel;
    Bevel7: TBevel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    edtQuotePrintEmailSubject: TwwDBEdit;
    memQuotePrintEmailText: TDBMemo;
    chkEnableQuotePrintEmail: TwwCheckBox;
    chkEnableQuotePrintSMS: TwwCheckBox;
    memQuotePrintSMSText: TDBMemo;
    pnlPOPrint: TDNMPanel;
    Bevel18: TBevel;
    Label133: TLabel;
    Label134: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    Label143: TLabel;
    edtPOPrintEmailSubject: TwwDBEdit;
    memPOPrintEmailText: TDBMemo;
    chkEnablePOPrintEmail: TwwCheckBox;
    chkEnablePOPrintSMS: TwwCheckBox;
    memPOPrintSMSText: TDBMemo;
    pnlPOSOReceipt: TDNMPanel;
    Bevel12: TBevel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    edtPOReceiveSOEmailSubject: TwwDBEdit;
    memPOReceiveSOEmailText: TDBMemo;
    chkEnablePOReceiveSOEmail: TwwCheckBox;
    chkEnablePOReceiveSOSMS: TwwCheckBox;
    memPOReceiveSOSMSText: TDBMemo;
    pnlPOInvoiceReceipt: TDNMPanel;
    Bevel13: TBevel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    edtPOReceiveInvEmailSubject: TwwDBEdit;
    memPOReceiveInvEmailText: TDBMemo;
    chkEnablePOReceiveInvEmail: TwwCheckBox;
    chkEnablePOReceiveInvSMS: TwwCheckBox;
    memPOReceiveInvSMSText: TDBMemo;
    pnlPOCreate: TDNMPanel;
    Bevel29: TBevel;
    Label203: TLabel;
    Label204: TLabel;
    Label205: TLabel;
    Label206: TLabel;
    Label207: TLabel;
    edtPOCreateEmailSubject: TwwDBEdit;
    memPOCreateEmailText: TDBMemo;
    chkEnablePOCreateEmail: TwwCheckBox;
    pnlPrintStatementsSMS: TDNMPanel;
    Bevel26: TBevel;
    Label195: TLabel;
    Label201: TLabel;
    Label202: TLabel;
    memPrintStatementsSMSText: TDBMemo;
    pnlPOSCashSalePrint: TDNMPanel;
    Bevel23: TBevel;
    Label175: TLabel;
    Label176: TLabel;
    Label177: TLabel;
    Label178: TLabel;
    Label179: TLabel;
    Label180: TLabel;
    Label181: TLabel;
    Label182: TLabel;
    edtPOSCashSalePrintEmailSubject: TwwDBEdit;
    memPOSCashSalePrintEmailText: TDBMemo;
    chkEnablePOSCashSalePrintEmail: TwwCheckBox;
    chkEnablePOSCashSalePrintSMS: TwwCheckBox;
    memPOSCashSalePrintSMSText: TDBMemo;
    DNMPanel3: TDNMPanel;
    Bevel28: TBevel;
    Label199: TLabel;
    wwCheckBox3: TwwCheckBox;
    pnlInvoiceShipChange: TDNMPanel;
    Bevel14: TBevel;
    Label98: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    edtInvShipChangeEmailSubject: TwwDBEdit;
    memInvShipChangeEmailText: TDBMemo;
    chkEnableInvShipChangeEmail: TwwCheckBox;
    chkEnableInvShipChangeSMS: TwwCheckBox;
    memInvShipChangeSMSText: TDBMemo;
    pnlInvoiceSave: TDNMPanel;
    Bevel4: TBevel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    edtInvoiceSaveEmailSubject: TwwDBEdit;
    memInvoiceSaveEmailText: TDBMemo;
    chkEnableInvoiceSaveMail: TwwCheckBox;
    chkEnableInvoiceSaveSMS: TwwCheckBox;
    memInvoiceSaveSMSText: TDBMemo;
    pnlInvoicePrint: TDNMPanel;
    Bevel3: TBevel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    edtInvoiceMailSubject: TwwDBEdit;
    memInvoiceMailText: TDBMemo;
    chkEnableInvoiceMail: TwwCheckBox;
    chkEnableInvoicePrintSMS: TwwCheckBox;
    memInvoicePrintSMSText: TDBMemo;
    pnlInvoicePickingSlip: TDNMPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label135: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label149: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtInvoicePickEmailSubject: TwwDBEdit;
    memInvoicePickMailText: TDBMemo;
    chkEnableInvoicePickMail: TwwCheckBox;
    chkEnableInvoicePickSMS: TwwCheckBox;
    memInvoicePickSMSText: TDBMemo;
    pnlInvoiceEmailAttachment: TDNMPanel;
    Bevel25: TBevel;
    Label191: TLabel;
    Label192: TLabel;
    Label193: TLabel;
    Label194: TLabel;
    edtInvoiceEmailAttachmentSubject: TwwDBEdit;
    memInvoiceMailAttachmentBodyText: TDBMemo;
    pnlInvoiceDel: TDNMPanel;
    Bevel2: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtInvoiceDelMailSubject: TwwDBEdit;
    memInvoiceDelMailText: TDBMemo;
    chkEnableInvoiceDelMail: TwwCheckBox;
    chkEnableInvoiceDelSMS: TwwCheckBox;
    memInvoiceDelSMSText: TDBMemo;
    DNMPanel2: TDNMPanel;
    Bevel21: TBevel;
    pnlCreditPrint: TLabel;
    Label161: TLabel;
    Label162: TLabel;
    Label163: TLabel;
    Label164: TLabel;
    Label165: TLabel;
    Label166: TLabel;
    Label167: TLabel;
    edtCreditPrintEmailSubject: TwwDBEdit;
    memCreditPrintEmailText: TDBMemo;
    chkEnableCreditPrintEmail: TwwCheckBox;
    chkEnableCreditPrintSMS: TwwCheckBox;
    memCreditPrintSMSText: TDBMemo;
    pnlCashSalePrint: TDNMPanel;
    Bevel22: TBevel;
    Label160: TLabel;
    Label168: TLabel;
    Label169: TLabel;
    Label170: TLabel;
    Label171: TLabel;
    Label172: TLabel;
    Label173: TLabel;
    Label174: TLabel;
    edtCashSalePrintEmailSubject: TwwDBEdit;
    memCashSalePrintEmailText: TDBMemo;
    chkEnableCashSalePrintEmail: TwwCheckBox;
    chkEnableCashSalePrintSMS: TwwCheckBox;
    memCashSalePrintSMSText: TDBMemo;
    pnlBillPrint: TDNMPanel;
    Bevel20: TBevel;
    Label144: TLabel;
    Label153: TLabel;
    Label154: TLabel;
    Label155: TLabel;
    Label156: TLabel;
    Label157: TLabel;
    Label158: TLabel;
    Label159: TLabel;
    edtBillPrintEmailSubject: TwwDBEdit;
    memBillPrintEmailText: TDBMemo;
    chkEnableBillPrintEmail: TwwCheckBox;
    chkEnableBillPrintSMS: TwwCheckBox;
    memBillPrintSMSText: TDBMemo;
    pnlAppointment: TDNMPanel;
    Bevel11: TBevel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    Label132: TLabel;
    edtAppointmentPrintEmailSubject: TwwDBEdit;
    memAppointmentPrintEmailText: TDBMemo;
    chkEnableAppointmentPrintEmail: TwwCheckBox;
    chkEnableAppointmentPrintSMS: TwwCheckBox;
    memAppointmentPrintSMSText: TDBMemo;
    chkEnableAppointmentRepPrintSMS: TwwCheckBox;
    memAppointmentPrintRepSMSText: TDBMemo;
    pnlARSMSText: TDNMPanel;
    Bevel27: TBevel;
    Label196: TLabel;
    Label197: TLabel;
    Label198: TLabel;
    memARSMSText: TDBMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkSMSEnabledClick(Sender: TObject);
    procedure edtSMSUserNameChange(Sender: TObject);
    procedure edtSMSPasswordChange(Sender: TObject);
    procedure mnuMsgTextPopup(Sender: TObject);
    procedure btnSMSratesClick(Sender: TObject);
    procedure edtPhoneNumberChange(Sender: TObject);
  private
    SMSConfig: TSMSConfig;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
    procedure EmailConfigOptionsClick(Sender: TObject);
    function EmailConfigField(const Value: String): String;
  Protected
      procedure StartupProcess(var Msg: TMessage); Override;
      procedure FinishProcess(var Msg: TMessage); Override;
  public
    { Public declarations }
  end;

var
  MessagePrefsGUI: TMessagePrefsGUI;

implementation

uses
  CommonLib, SystemLib, ShellAPI, tcConst;

{$R *.dfm}

const
  EmailConfigOptions :Array [1..42] of array [1..3] of String  =
    (
      ('Sale #','#SaleID#','Sales'),                          { Sales          }
      ('Customer Name', '#CustomerName#','Sales'),            { Sales          }
      ('Company Name', '#CompanyName#','Sales'),              { Sales          }
      ('Shipping Address', '#ShippingAddress#','Sales'),      { Sales          }
      ('Products', '#Products#','Sales'),                     { Sales          }
      ('Contact Title', '#Title#','Sales'),                   { Sales          }
      ('Contact First Name', '#FirstName#','Sales'),          { Sales          }
      ('Contact Last Name', '#LastName#','Sales'),            { Sales          }
      ('Contact Name', '#ContactName#','Sales'),              { Sales          }

      ('Container Name', '#ContainerName#','ShippingContainer'),          { Shipping Container     }
      ('Vesel Name', '#VeselName#','ShippingContainer'),                  { Shipping Container     }
      ('Departure Point', '#DeparturePoint#','ShippingContainer'),        { Shipping Container     }
      ('Arrival Point', '#ArrivalPoint#','ShippingContainer'),            { Shipping Container     }
      ('Est Time Departure', '#EstTimeDeparture#','ShippingContainer'),   { Shipping Container     }
      ('Est Time Arrival', '#EstTimeArrival#','ShippingContainer'),       { Shipping Container     }
      ('Status', '#Status#','ShippingContainer'),                         { Shipping Container     }

      ('Company', '#Company#','Appointment'),                       { Appointment            }
      ('Date', '#Date#','Appointment'),                             { Appointment            }
      ('Start Time', '#StartTime#','Appointment'),                  { Appointment            }
      ('End Time', '#EndTime#','Appointment'),                      { Appointment            }

      ('Repair #','#RepairID#','Repair'),                      { Repair                 }
      ('Address', '#Address#','Repair'),                       { Repair                 }
      ('Products', '#Products#','Repair'),                     { Repair                 }
      ('First Name', '#FirstName#','Repair'),                  { Repair                 }

      ('PO #','#POID#','PO'),                              { PO                     }
      ('Shipping Address', '#ShippingAddress#','PO'),      { PO                     }
      ('Products', '#Products#','PO'),                     { PO                     }
      ('First Name', '#FirstName#','PO'),                  { PO                     }

      ('RA #','#RAID#','RA'),                              { RA                     }
      ('Return Address', '#ReturnAddress#','RA'),          { RA                     }
      ('Products', '#Products#','RA'),                     { RA                     }
      ('First Name', '#FirstName#','RA'),                  { RA                     }

      ('Bill #','#BillID#','Bill'),                          { Bill                   }
      ('Address', '#Address#','Bill'),                       { Bill                   }
      ('First Name', '#FirstName#','Bill'),                  { Bill                   }

      ('Credit #','#CreditID#','Credit'),                      { Credit                 }
      ('Address', '#Address#','Credit'),                       { Credit                 }
      ('First Name', '#FirstName#','Credit'),                  { Credit                 }

      ('Company','#Company#','CustStatement'),              { Print Statements       }
      ('Balance', '#Balance#','CustStatement'),              { Print Statements       }

      ('Company','#Company#','AR'),              { Accounts Receivable    }
      ('Balance', '#Balance#','AR')              { Accounts Receivable    }
    );


procedure TMessagePrefsGUI.btnSMSratesClick(Sender: TObject);
begin
  inherited;
  try
    if not(FileExists(SystemLib.ExeDir + SMS_RATES_FILE)) then begin
      MessageDlgXP_vista('Unable to open the SMS Rates - the file is missing.', mtWarning, [mbOK], 0);
      Exit;
    end;
    Processingcursor(true);
    try
      ShellExecute(0,'open',PChar(SystemLib.ExeDir + SMS_RATES_FILE),nil,nil,SW_SHOWNORMAL);
    finally
      Processingcursor(False);
    end;
  except
    on E:Exception do begin
      MessageDlgXP_vista('Unable to open the SMS Rates.' + NL+ E.message, mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TMessagePrefsGUI.chkSMSEnabledClick(Sender: TObject);
begin
  if not TwwCheckBox(Sender).Focused then exit;
  chkSMSEnabled.OnClick := nil;
  try
    inherited;
    if TwwCheckBox(Sender).Checked then begin
      if (SMSConfig.SMSUser = '') or (SMSConfig.SMSPass = '') then begin
        TwwCheckBox(Sender).Checked := false;
        MessageDlgXP_Vista('Please enter User and Password details before enabling SMS support.',mtInformation,[mbOk],0);
      end;
    end;
    SMSConfig.SMSEnabled := TwwCheckBox(Sender).Checked;
  finally
    chkSMSEnabled.OnClick := chkSMSEnabledClick;
  end;

    if chkSMSEnabled.Checked then
      lblSMSEnabled.Caption := 'Enabled'
    else
      lblSMSEnabled.Caption := 'Disabled';

end;

procedure TMessagePrefsGUI.edtPhoneNumberChange(Sender: TObject);
begin
  inherited;
  if not TEdit(Sender).Focused then exit;
  SMSConfig.PhoneNumber := TEdit(Sender).Text;

end;

procedure TMessagePrefsGUI.edtSMSPasswordChange(Sender: TObject);
begin
  inherited;
  if not TEdit(Sender).Focused then exit;
  SMSConfig.SMSPass := TEdit(Sender).Text;
//  if (SMSConfig.SMSUser = '') or (SMSConfig.SMSPass = '') then begin
//    TwwCheckBox(Sender).Checked := false;
//    SMSConfig.SMSEnabled := TwwCheckBox(Sender).Checked;
//  end;
end;

procedure TMessagePrefsGUI.edtSMSUserNameChange(Sender: TObject);
begin
  if not TEdit(Sender).Focused then exit;
  SMSConfig.SMSUser := TEdit(Sender).Text;
//  if (SMSConfig.SMSUser = '') or (SMSConfig.SMSPass = '') then begin
//    TwwCheckBox(Sender).Checked := false;
//    SMSConfig.SMSEnabled := TwwCheckBox(Sender).Checked;
//  end;
end;

function TMessagePrefsGUI.EmailConfigField(const Value: String): String;
var
  ctr:Integer;
begin
  result:= '';
   for ctr:= low(EmailConfigOptions) to high(EmailConfigOptions) do begin
     if sameText(EmailConfigOptions[ctr,1],StringReplace(Value, '&' , '', [rfReplaceAll, rfIgnoreCase])) then begin
      result:= EmailConfigOptions[ctr,2];
      exit;
     end;
   end;
end;

procedure TMessagePrefsGUI.EmailConfigOptionsClick(Sender: TObject);
begin
  if Screen.ActiveControl is TDBMemo then
    EditDB(dsPrefs.DataSet);
    with TDBMemo(Screen.ActiveControl) do begin
      TDBMemo(Screen.ActiveControl).Seltext:= Emailconfigfield(TMenuItem(Sender).Caption);
    end;
end;

procedure TMessagePrefsGUI.FormCreate(Sender: TObject);
//var
//  NewItem : TMenuItem;
//  ctr:Integer;
begin
  inherited;
//  for ctr:= low(EmailconfigOptions) to high(EmailconfigOptions) do begin
//    NewItem := TMenuItem.Create(mnuMsgText);
//    NewItem.Caption := EmailconfigOptions[ctr,1];
//    NewItem.OnClick := EmailconfigOptionsclick;
//    mnuMsgText.Items.Add(NewItem);
//  end;
  SMSConfig := TSMSConfig.Create;
end;

procedure TMessagePrefsGUI.FormDestroy(Sender: TObject);
begin
  inherited;
  SMSConfig.Free;
end;

procedure TMessagePrefsGUI.mnuMsgTextPopup(Sender: TObject);
var
  NewItem : TMenuItem;
  ctr: Integer;
begin
  inherited;
  mnuMsgText.Items.Clear;
  if (mnuMsgText.PopupComponent = memAppointmentPrintEmailText) or
     (mnuMsgText.PopupComponent = memAppointmentPrintSMSText) or
     (mnuMsgText.PopupComponent = edtAppointmentPrintEmailSubject) or
     (mnuMsgText.PopupComponent = memAppointmentPrintRepSMSText) then begin
    { Appointment }
    for ctr:= Low(EmailconfigOptions) to High(EmailconfigOptions) do begin
      if EmailconfigOptions[ctr,3] = 'Appointment' then begin
        NewItem := TMenuItem.Create(mnuMsgText);
        NewItem.Caption := EmailconfigOptions[ctr,1];
        NewItem.OnClick := EmailconfigOptionsclick;
        mnuMsgText.Items.Add(NewItem);
      end;
    end;
  end
  else if (mnuMsgText.PopupComponent = memShipContainerChangeEmailText) or
     (mnuMsgText.PopupComponent = memShipContainerChangeSMSText) or
     (mnuMsgText.PopupComponent = edtShipContainerChangeEmailSubject) then begin
    { Containers }
    for ctr:= Low(EmailconfigOptions) to High(EmailconfigOptions) do begin
      if EmailconfigOptions[ctr,3] = 'ShippingContainer' then begin
        NewItem := TMenuItem.Create(mnuMsgText);
        NewItem.Caption := EmailconfigOptions[ctr,1];
        NewItem.OnClick := EmailconfigOptionsclick;
        mnuMsgText.Items.Add(NewItem);
      end;
    end;
  end
  else if (mnuMsgText.PopupComponent = memRepairPrintEmailText) or
     (mnuMsgText.PopupComponent = memRepairPrintSMSText) or
     (mnuMsgText.PopupComponent = edtRepairPrintEmailSubject) then begin
    { Repairs }
    for ctr:= Low(EmailconfigOptions) to High(EmailconfigOptions) do begin
      if EmailconfigOptions[ctr,3] = 'Repair' then begin
        NewItem := TMenuItem.Create(mnuMsgText);
        NewItem.Caption := EmailconfigOptions[ctr,1];
        NewItem.OnClick := EmailconfigOptionsclick;
        mnuMsgText.Items.Add(NewItem);
      end;
    end;
  end
  else if (mnuMsgText.PopupComponent = memPOPrintEmailText) or
     (mnuMsgText.PopupComponent = memPOCreateEmailText) or
     (mnuMsgText.PopupComponent = edtPOCreateEmailSubject) or
     (mnuMsgText.PopupComponent = memPOPrintSMSText) or
     (mnuMsgText.PopupComponent = edtPOPrintEmailSubject) then begin
    { PO }
    for ctr:= Low(EmailconfigOptions) to High(EmailconfigOptions) do begin
      if EmailconfigOptions[ctr,3] = 'PO' then begin
        NewItem := TMenuItem.Create(mnuMsgText);
        NewItem.Caption := EmailconfigOptions[ctr,1];
        NewItem.OnClick := EmailconfigOptionsclick;
        mnuMsgText.Items.Add(NewItem);
      end;
    end;
  end
  else if (mnuMsgText.PopupComponent = memRAPrintEmailText) or
     (mnuMsgText.PopupComponent = memRAPrintSMSText) or
     (mnuMsgText.PopupComponent = edtRAPrintEmailSubject) then begin
    { RA }
    for ctr:= Low(EmailconfigOptions) to High(EmailconfigOptions) do begin
      if EmailconfigOptions[ctr,3] = 'RA' then begin
        NewItem := TMenuItem.Create(mnuMsgText);
        NewItem.Caption := EmailconfigOptions[ctr,1];
        NewItem.OnClick := EmailconfigOptionsclick;
        mnuMsgText.Items.Add(NewItem);
      end;
    end;
  end
  else if (mnuMsgText.PopupComponent = memBillPrintEmailText) or
     (mnuMsgText.PopupComponent = memBillPrintSMSText) or
     (mnuMsgText.PopupComponent = edtBillPrintEmailSubject) then begin
    { Bill }
    for ctr:= Low(EmailconfigOptions) to High(EmailconfigOptions) do begin
      if EmailconfigOptions[ctr,3] = 'Bill' then begin
        NewItem := TMenuItem.Create(mnuMsgText);
        NewItem.Caption := EmailconfigOptions[ctr,1];
        NewItem.OnClick := EmailconfigOptionsclick;
        mnuMsgText.Items.Add(NewItem);
      end;
    end;
  end
  else if (mnuMsgText.PopupComponent = memCreditPrintEmailText) or
     (mnuMsgText.PopupComponent = memCreditPrintSMSText) or
     (mnuMsgText.PopupComponent = edtCreditPrintEmailSubject) then begin
    { Bill }
    for ctr:= Low(EmailconfigOptions) to High(EmailconfigOptions) do begin
      if EmailconfigOptions[ctr,3] = 'Bill' then begin
        NewItem := TMenuItem.Create(mnuMsgText);
        NewItem.Caption := EmailconfigOptions[ctr,1];
        NewItem.OnClick := EmailconfigOptionsclick;
        mnuMsgText.Items.Add(NewItem);
      end;
    end;
  end
  else if (mnuMsgText.PopupComponent = memPrintStatementsSMSText) then begin
    { Print Statements }
    for ctr:= Low(EmailconfigOptions) to High(EmailconfigOptions) do begin
      if EmailconfigOptions[ctr,3] = 'CustStatement' then begin
        NewItem := TMenuItem.Create(mnuMsgText);
        NewItem.Caption := EmailconfigOptions[ctr,1];
        NewItem.OnClick := EmailconfigOptionsclick;
        mnuMsgText.Items.Add(NewItem);
      end;
    end;
  end
  else if (mnuMsgText.PopupComponent = memARSMSText) then begin
    { AR }
    for ctr:= Low(EmailconfigOptions) to High(EmailconfigOptions) do begin
      if EmailconfigOptions[ctr,3] = 'AR' then begin
        NewItem := TMenuItem.Create(mnuMsgText);
        NewItem.Caption := EmailconfigOptions[ctr,1];
        NewItem.OnClick := EmailconfigOptionsclick;
        mnuMsgText.Items.Add(NewItem);
      end;
    end;
  end
  else begin
    { Sales }
    for ctr:= Low(EmailconfigOptions) to High(EmailconfigOptions) do begin
      if EmailconfigOptions[ctr,3] = 'Sales' then begin
        NewItem := TMenuItem.Create(mnuMsgText);
        NewItem.Caption := EmailconfigOptions[ctr,1];
        NewItem.OnClick := EmailconfigOptionsclick;
        mnuMsgText.Items.Add(NewItem);
      end;
    end;
  end;
end;


procedure TMessagePrefsGUI.PerformStartup(var Msg: TMessage);
begin
  DoPerformStartup(Msg);
end;

procedure TMessagePrefsGUI.StartupProcess(var Msg: TMessage);
begin
  inherited;
  SMSConfig.Load(dsPrefs.Connection);
  chkSMSEnabled.Checked := SMSConfig.SMSEnabled;
  edtSMSUserName.Text := SMSConfig.SMSUser;
  edtSMSPassword.Text := SMSConfig.SMSPass;
  edtPhoneNumber.Text := SMSConfig.PhoneNumber;

//  edtSMSUserName.Enabled := false;
//  edtSMSPassword.Enabled := false;
//  edtPhoneNumber.Enabled := false;

  if chkSMSEnabled.Checked then
      lblSMSEnabled.Caption := 'Enabled'
  else
      lblSMSEnabled.Caption := 'Disabled';


  pnlSMSConfig.Hint :=
    'Rates will vary for this service depending on where the SMS is coming from,' + #13#10 +
    'which telco provider you are using and where the SMS is going to.' + #13#10 + #13#10 +
    'Billing will be from ERP, monthly.' + #13#10 + #13#10 +
    'Please contact ERP in your country, if you wish to know more.' + #13#10;
  pnlSMSConfig.ShowHint := true;
end;
procedure TMessagePrefsGUI.PerformFinish(var Msg: TMessage);
begin
  DoPrefformFinish(Msg);
end;
procedure TMessagePrefsGUI.FinishProcess(var Msg: TMessage);
begin
  PostDB(dsPrefs.DataSet);
  SMSConfig.Save(dsPrefs.Connection);
end;

initialization
  RegisterClass(TMessagePrefsGUI);

end.
