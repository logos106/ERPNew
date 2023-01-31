unit VS1PreferencesSQL;

interface

uses
  classes, ReportBaseObj, Types;

{
TVS1Preferences  : Base class
------TVS1MessagingPreferences  : Messaging preferencess
Inherit from TVS1Preferences for any specific type and Override
MakePreferencesList for more fields from preferences
in the relevant class , eg:TVS1MessagingPreferences }

type
  TVS1Preferences = class(TReportBase)
  private
  protected
    MsgPreferences : Array of String;
    procedure AddPreferenceItem(const value: STring);
    Procedure MakePreferencesList;Virtual;abstract;
  public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  published
  end;

  TVS1MessagingPreferences = class(TVS1Preferences)
  private
  protected
    Procedure MakePreferencesList;Override;
  published
  end;

implementation

uses sysutils;
Procedure TVS1Preferences.AddPreferenceItem(const value:STring);
begin
  if Trim(Value)='' then exit;
  SetLength(MsgPreferences , length(MsgPreferences)+1);
  MsgPreferences[high(MsgPreferences)] := Value;
end;
{ TVS1MessagingPreferences }
procedure TVS1MessagingPreferences.MakePreferencesList;
begin
          SetLength(MsgPreferences,0);
          AddPreferenceItem('VoucherSalePrintEmailSubject');
          AddPreferenceItem('VoucherSalePrintEmailText');
          AddPreferenceItem('EnableVoucherSalePrintEmail');
          AddPreferenceItem('EnablVoucherSalePrintSMS');
          AddPreferenceItem('VoucherSalePrintSMSText');
          AddPreferenceItem('ShipContainerChangeEmailSubject');
          AddPreferenceItem('ShipContainerChangeEmailText');
          AddPreferenceItem('EnableShipContainerChangeEmail');
          AddPreferenceItem('EnablShipContainerChangeSMS');
          AddPreferenceItem('ShipContainerChangeSMSText');
          AddPreferenceItem('SOShipChangeEmailSubject');
          AddPreferenceItem('SOShipChangeEmailText');
          AddPreferenceItem('EnableSOShipChangeEmail');
          AddPreferenceItem('EnableSOShipChangeSMS');
          AddPreferenceItem('SOShipChangeSMSText');
          AddPreferenceItem('SOSaveEmailSubject');
          AddPreferenceItem('SOSaveEmailText');
          AddPreferenceItem('EnableSOSaveEmail');
          AddPreferenceItem('EnableSOSaveSMS');
          AddPreferenceItem('SOSaveSMSText');
          AddPreferenceItem('SOPrintEmailSubject');
          AddPreferenceItem('SOPrintEmailText');
          AddPreferenceItem('EnableSOPrintEmail');
          AddPreferenceItem('EnableSOPrintSMS');
          AddPreferenceItem('SOPrintSMSText');
          AddPreferenceItem('RAPrintEmailSubject');
          AddPreferenceItem('RAPrintEmailText');
          AddPreferenceItem('EnableRAPrintEmail');
          AddPreferenceItem('EnableRAPrintSMS');
          AddPreferenceItem('RAPrintSMSText');
          AddPreferenceItem('RepairPrintEmailSubject');
          AddPreferenceItem('RepairPrintEmailText');
          AddPreferenceItem('EnableRepairPrintEmail');
          AddPreferenceItem('EnableRepairPrintSMS');
          AddPreferenceItem('RepairPrintSMSText');
          AddPreferenceItem('RepairInvoicedEmailSubject');
          AddPreferenceItem('RepairInvoicedEmailText');
          AddPreferenceItem('EnableRepairInvoicedEmail');
          AddPreferenceItem('EnableRepairInvoicedSMS');
          AddPreferenceItem('RepairInvoicedSMSText');
          AddPreferenceItem('RefundPrintEmailSubject');
          AddPreferenceItem('RefundPrintEmailText');
          AddPreferenceItem('EnableRefundPrintEmail');
          AddPreferenceItem('EnableRefundPrintSMS');
          AddPreferenceItem('RefundPrintSMSText');
          AddPreferenceItem('QuoteSaveEmailSubject');
          AddPreferenceItem('QuoteSaveEmailText');
          AddPreferenceItem('EnableQuoteSaveEmail');
          AddPreferenceItem('EnableQuoteSaveSMS');
          AddPreferenceItem('QuoteSaveSMSText');
          AddPreferenceItem('QuotePrintEmailSubject');
          AddPreferenceItem('QuotePrintEmailText');
          AddPreferenceItem('EnableQuotePrintEmail');
          AddPreferenceItem('EnableQuotePrintSMS');
          AddPreferenceItem('QuotePrintSMSText');
          AddPreferenceItem('POPrintEmailSubject');
          AddPreferenceItem('POPrintEmailText');
          AddPreferenceItem('EnablePOPrintEmail');
          AddPreferenceItem('EnablePOPrintSMS');
          AddPreferenceItem('POPrintSMSText');
          AddPreferenceItem('POReceiveSOEmailSubject');
          AddPreferenceItem('POReceiveSOEmailText');
          AddPreferenceItem('EnablePOReceiveSOEmail');
          AddPreferenceItem('EnablePOReceiveSOSMS');
          AddPreferenceItem('POReceiveSOSMSText');
          AddPreferenceItem('POReceiveInvEmailSubject');
          AddPreferenceItem('POReceiveInvEmailText');
          AddPreferenceItem('EnablePOReceiveInvEmail');
          AddPreferenceItem('EnablePOReceiveInvSMS');
          AddPreferenceItem('POReceiveInvSMSText');
          AddPreferenceItem('POCreateEmailSubject');
          AddPreferenceItem('POCreateEmailText');
          AddPreferenceItem('EnablePOCreateEmail');
          AddPreferenceItem('PrintStatementsSMSText');
          AddPreferenceItem('POSCashSalePrintEmailSubject');
          AddPreferenceItem('POSCashSalePrintEmailText');
          AddPreferenceItem('EnablePOSCashSalePrintEmail');
          AddPreferenceItem('EnablePOSCashSalePrintSMS');
          AddPreferenceItem('POSCashSalePrintSMSText');
          AddPreferenceItem('ExcludeInactiveContactFromMessages');
          AddPreferenceItem('InvShipChangeEmailSubject');
          AddPreferenceItem('InvShipChangeEmailText');
          AddPreferenceItem('EnableInvShipChangeEmail');
          AddPreferenceItem('EnableInvShipChangeSMS');
          AddPreferenceItem('InvShipChangeSMSText');
          AddPreferenceItem('InvoiceSaveEmailSubject');
          AddPreferenceItem('InvoiceSaveEmailText');
          AddPreferenceItem('EnableInvoiceSaveMail');
          AddPreferenceItem('EnableInvoiceSaveSMS');
          AddPreferenceItem('InvoiceSaveSMSText');
          AddPreferenceItem('InvoiceMailSubject');
          AddPreferenceItem('InvoiceMailText');
          AddPreferenceItem('EnableInvoiceMail');
          AddPreferenceItem('EnableInvoicePrintSMS');
          AddPreferenceItem('InvoicePrintSMSText');
          AddPreferenceItem('InvoicePickMailSubject');
          AddPreferenceItem('InvoicePickMailText');
          AddPreferenceItem('EnableInvoicePickMail');
          AddPreferenceItem('EnableInvoicePickSMS');
          AddPreferenceItem('InvoicePickSMSText');
          AddPreferenceItem('InvoiceMailAttachmentSubject');
          AddPreferenceItem('InvoiceMailAttachmentBodyText');
          AddPreferenceItem('InvoiceDelMailSubject');
          AddPreferenceItem('InvoiceDelMailText');
          AddPreferenceItem('EnableInvoiceDelMail');
          AddPreferenceItem('EnableInvoiceDelSMS');
          AddPreferenceItem('InvoiceDelSMSText');
          AddPreferenceItem('CreditPrintEmailSubject');
          AddPreferenceItem('CreditPrintEmailText');
          AddPreferenceItem('EnableCreditPrintEmail');
          AddPreferenceItem('EnableCreditPrintSMS');
          AddPreferenceItem('CreditPrintSMSText');
          AddPreferenceItem('CashSalePrintEmailSubject');
          AddPreferenceItem('CashSalePrintEmailText');
          AddPreferenceItem('EnableCashSalePrintEmail');
          AddPreferenceItem('EnableCashSalePrintSMS');
          AddPreferenceItem('CashSalePrintSMSText');
          AddPreferenceItem('BillPrintEmailSubject');
          AddPreferenceItem('BillPrintEmailText');
          AddPreferenceItem('EnableBillPrintEmail');
          AddPreferenceItem('EnableBillPrintSMS');
          AddPreferenceItem('BillPrintSMSText');
          AddPreferenceItem('AppointmentPrintEmailSubject');
          AddPreferenceItem('AppointmentPrintEmailText');
          AddPreferenceItem('EnableAppointmentPrintEmail');
          AddPreferenceItem('EnableAppointmentPrintSMS');
          AddPreferenceItem('AppointmentPrintSMSText');
          AddPreferenceItem('EnableAppointmentRepPrintSMS');
          AddPreferenceItem('AppointmentPrintRepSMSText');
          AddPreferenceItem('ARSMSText');
end;



{ TVS1Preferences }

constructor TVS1Preferences.Create;
begin
  inherited;
  MakePreferencesList;
end;

destructor TVS1Preferences.Destroy;
begin

  inherited;
end;

function TVS1Preferences.PopulateReportSQL(SQL: TStrings;var msg: string): boolean;
var
  ctr:Integer;
begin
  SQL.clear;
  SQL.add('Select 1 as ID,');
  for ctr := low(MsgPreferences) to high(MsgPreferences) do
    SQL.add('(Select Fieldvalue from tbldbpreferences where name = ' +Quotedstr(MsgPreferences[ctr])+	') as 	'+ MsgPreferences[ctr]+',');
  SQL.add('"Preferences" as Description');
end;

initialization
  RegisterClass(TVS1MessagingPreferences);

end.
