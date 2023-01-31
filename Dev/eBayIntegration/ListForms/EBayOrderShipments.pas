unit EBayOrderShipments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TEBayOrderShipmentsGUI = class(TBaseListingGUI)
    qryMainClientId: TIntegerField;
    qryMainSaleno: TWideStringField;
    qryMainSaleId: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainPrintName: TWideStringField;
    qryMainTotalAmountinc: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainTotalAmount: TFloatField;
    qryMainPayment: TFloatField;
    qryMainBalance: TFloatField;
    qryMainSaleDate: TDateField;
    qryMainConverted: TWideStringField;
    qryMainfutureSo: TWideStringField;
    qryMainType: TWideStringField;
    qryMainSaleStatus: TWideStringField;
    qryMainheld: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainterms: TWideStringField;
    qryMainComments: TWideMemoField;
    qryMainClassName: TWideStringField;
    qryMaindueDate: TDateField;
    qryMainShipTo: TWideStringField;
    qryMainHasSignature: TWideStringField;
    qryMainTIMESTAMPtofilter: TDateTimeField;
    qryMainShipmentId: TIntegerField;
    qryMainShipAddressId: TIntegerField;
    qryMainMasterTrackingNumber: TWideStringField;
    qryMainPackageIDCode: TWideStringField;
    qryMainPayorAccountNumber: TWideStringField;
    qryMainPayorCountryCode: TWideStringField;
    qryMainPayorType: TIntegerField;
    qryMainPayorZipCode: TWideStringField;
    qryMainProvider: TIntegerField;
    qryMainPostageProvider: TIntegerField;
    qryMainRecipientFirstName: TWideStringField;
    qryMainRecipientMiddleInitial: TWideStringField;
    qryMainRecipientLastName: TWideStringField;
    qryMainRecipientCompany: TWideStringField;
    qryMainRecipientAddress1: TWideStringField;
    qryMainRecipientAddress2: TWideStringField;
    qryMainRecipientCity: TWideStringField;
    qryMainRecipientState: TWideStringField;
    qryMainRecipientZipCode: TWideStringField;
    qryMainRecipientCountryCode: TWideStringField;
    qryMainRecipientEmail: TWideStringField;
    qryMainRecipientPhone: TWideStringField;
    qryMainRecipientFax: TWideStringField;
    qryMainRecipientAddressValid: TWideStringField;
    qryMainSenderFirstName: TWideStringField;
    qryMainSenderMiddleInitial: TWideStringField;
    qryMainSenderLastName: TWideStringField;
    qryMainSenderCompany: TWideStringField;
    qryMainSenderAddress1: TWideStringField;
    qryMainSenderAddress2: TWideStringField;
    qryMainSenderCity: TWideStringField;
    qryMainSenderState: TWideStringField;
    qryMainSenderZipCode: TWideStringField;
    qryMainSenderCountryCode: TWideStringField;
    qryMainSenderEmail: TWideStringField;
    qryMainSenderPhone: TWideStringField;
    qryMainSenderFax: TWideStringField;
    qryMainServiceType: TIntegerField;
    qryMainDeliveryData: TDateTimeField;
    qryMainShipmentSpecialServices: TLargeintField;
    qryMainTotalNetCharge: TFloatField;
    qryMainTotalBaseCharge: TFloatField;
    qryMainTotalSurcharges: TFloatField;
    qryMainTotalNetChargeNegotiated: TFloatField;
    qryMainMICostCenter: TWideStringField;
    qryMainMIPackageID: TWideStringField;
    qryMainBookingNumber: TWideStringField;
    qryMainEndorsement: TIntegerField;
    qryMainDropoffType: TIntegerField;
    qryMainProcessed: TWideStringField;
    qryMainProcessedComment: TWideMemoField;
    qryMainDocumentsOnly: TWideStringField;
    qryMainShipmentActive: TWideStringField;
    qryMainSaleType: TWideStringField;
    qryMainSaleRefNo: TWideStringField;
    qryMainDateCreated: TDateTimeField;
    qryMainEmployeeName: TWideStringField;
    qryMainShiplistActive: TWideStringField;
    qryMainSTATUS: TWideStringField;
    qryMainShipQty: TFloatField;
    qryMainSynched: TWideStringField;
    qryMainSaleshipdate: TDateField;
    qryMainShipDate: TDateTimeField;
    procedure FormCreate(Sender: TObject);
  private
  Protected
    Procedure SetGridColumns;Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses AppEnvironment, CommonLib;

{$R *.dfm}

{ TEBayOrderShipmentsGUI }

procedure TEBayOrderShipmentsGUI.FormCreate(Sender: TObject);
begin
   inherited;
   GrdMain.Selected.Clear;
   GrdMain.Selected.Add(SelectedText(QrymainSaleno.fieldname                    ,'No  '                 ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainSaleId.fieldname                    ,'ID  '                 ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainCustomerName.fieldname              ,'Customer'             ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainPrintName.fieldname                 ,'Print Name'           ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainClassName.fieldname                 ,'Class'                ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainType.fieldname                      ,'Type'                 ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainSaleStatus.fieldname                ,'Status'               ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainTotalAmount.fieldname               ,'Total (Ex)'           ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainTotalTax.fieldname                  ,'Tax '                 ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainTotalAmountinc.fieldname            ,'Total (Inc)'          ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainPayment.fieldname                   ,'Payment'              ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainBalance.fieldname                   ,'Balance'              ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainPONumber.fieldname                  ,'PO  '                 ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(Qrymainterms.fieldname                     ,'Terms'                ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainComments.fieldname                  ,'Comments'             ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainSaleDate.fieldname                  ,'Date'                 ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainSaleshipdate.fieldname              ,'Ship Date'            ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymaindueDate.fieldname                   ,'Due Date'             ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainShipTo.fieldname                    ,'Ship To'              ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainConverted.fieldname                 ,'Converted ?'          ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainfutureSo.fieldname                  ,'Future So ?'          ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(Qrymainheld.fieldname                      ,'Held ?'               ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainHasSignature.fieldname              ,'Has Signature?'       ,10,'Sales Information'));
   GrdMain.Selected.Add(SelectedText(QrymainMasterTrackingNumber.fieldname      ,'Tracking No'          ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainPackageIDCode.fieldname             ,'Package Code'         ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainProvider.fieldname                  ,'Provider'             ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainPostageProvider.fieldname           ,'Postage Provider'     ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainPayorAccountNumber.fieldname        ,'A/c no'               ,10,'Shipment Payor'));
   GrdMain.Selected.Add(SelectedText(QrymainPayorCountryCode.fieldname          ,'Country'              ,10,'Shipment Payor'));
   GrdMain.Selected.Add(SelectedText(QrymainPayorType.fieldname                 ,'Type'                 ,10,'Shipment Payor'));
   GrdMain.Selected.Add(SelectedText(QrymainPayorZipCode.fieldname              ,'Zip Code'             ,10,'Shipment Payor'));
   GrdMain.Selected.Add(SelectedText(QrymainRecipientFirstName.fieldname        ,'First Name'           ,10,'Shipment Recipient'));
   GrdMain.Selected.Add(SelectedText(QrymainRecipientMiddleInitial.fieldname    ,'Middle Name'          ,10,'Shipment Recipient'));
   GrdMain.Selected.Add(SelectedText(QrymainRecipientLastName.fieldname         ,'Last Name'            ,10,'Shipment Recipient'));
   GrdMain.Selected.Add(SelectedText(QrymainRecipientCompany.fieldname          ,'Company'              ,10,'Shipment Recipient'));
   GrdMain.Selected.Add(SelectedText(QrymainRecipientAddress1.fieldname         ,'Address1'             ,10,'Shipment Recipient'));
   GrdMain.Selected.Add(SelectedText(QrymainRecipientAddress2.fieldname         ,'Address2'             ,10,'Shipment Recipient'));
   GrdMain.Selected.Add(SelectedText(QrymainRecipientCity.fieldname             ,'City'                 ,10,'Shipment Recipient'));
   GrdMain.Selected.Add(SelectedText(QrymainRecipientState.fieldname            ,'State'                ,10,'Shipment Recipient'));
   GrdMain.Selected.Add(SelectedText(QrymainRecipientZipCode.fieldname          ,'Zip Code'             ,10,'Shipment Recipient'));
   GrdMain.Selected.Add(SelectedText(QrymainRecipientCountryCode.fieldname      ,'Country Code'         ,10,'Shipment Recipient'));
   GrdMain.Selected.Add(SelectedText(QrymainRecipientEmail.fieldname            ,'Email'                ,10,'Shipment Recipient'));
   GrdMain.Selected.Add(SelectedText(QrymainRecipientPhone.fieldname            ,'Phone'                ,10,'Shipment Recipient'));
   GrdMain.Selected.Add(SelectedText(QrymainRecipientFax.fieldname              ,'Fax '                 ,10,'Shipment Recipient'));
   GrdMain.Selected.Add(SelectedText(QrymainSenderFirstName.fieldname           ,'First Name'           ,10,'Shipment Sender'));
   GrdMain.Selected.Add(SelectedText(QrymainSenderMiddleInitial.fieldname       ,'Middle Name'          ,10,'Shipment Sender'));
   GrdMain.Selected.Add(SelectedText(QrymainSenderLastName.fieldname            ,'Last Name'            ,10,'Shipment Sender'));
   GrdMain.Selected.Add(SelectedText(QrymainSenderCompany.fieldname             ,'Company'              ,10,'Shipment Sender'));
   GrdMain.Selected.Add(SelectedText(QrymainSenderAddress1.fieldname            ,'Address1'             ,10,'Shipment Sender'));
   GrdMain.Selected.Add(SelectedText(QrymainSenderAddress2.fieldname            ,'Address2'             ,10,'Shipment Sender'));
   GrdMain.Selected.Add(SelectedText(QrymainSenderCity.fieldname                ,'City'                 ,10,'Shipment Sender'));
   GrdMain.Selected.Add(SelectedText(QrymainSenderState.fieldname               ,'State'                ,10,'Shipment Sender'));
   GrdMain.Selected.Add(SelectedText(QrymainSenderZipCode.fieldname             ,'Zip Code'             ,10,'Shipment Sender'));
   GrdMain.Selected.Add(SelectedText(QrymainSenderCountryCode.fieldname         ,'Country Code'         ,10,'Shipment Sender'));
   GrdMain.Selected.Add(SelectedText(QrymainSenderEmail.fieldname               ,'Email'                ,10,'Shipment Sender'));
   GrdMain.Selected.Add(SelectedText(QrymainSenderPhone.fieldname               ,'Phone'                ,10,'Shipment Sender'));
   GrdMain.Selected.Add(SelectedText(QrymainSenderFax.fieldname                 ,'Fax '                 ,10,'Shipment Sender'));
   GrdMain.Selected.Add(SelectedText(QrymainServiceType.fieldname               ,'Service Type'         ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainDeliveryData.fieldname              ,'Delivery Data'        ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainShipmentSpecialServices.fieldname   ,'Special Services'     ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainTotalNetCharge.fieldname            ,'Net Charge'           ,10,'Totals'));
   GrdMain.Selected.Add(SelectedText(QrymainTotalBaseCharge.fieldname           ,'Base Charge'          ,10,'Totals'));
   GrdMain.Selected.Add(SelectedText(QrymainTotalSurcharges.fieldname           ,'Surcharges'           ,10,'Totals'));
   GrdMain.Selected.Add(SelectedText(QrymainTotalNetChargeNegotiated.fieldname  ,'Net Charge Negotiated',10,'Totals'));
   GrdMain.Selected.Add(SelectedText(QrymainMICostCenter.fieldname              ,'MI Cost Center'       ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainMIPackageID.fieldname               ,'MI Package ID'        ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainBookingNumber.fieldname             ,'Booking Number'       ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainEndorsement.fieldname               ,'Endorsement'          ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainDropoffType.fieldname               ,'Drop off Type'        ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainProcessed.fieldname                 ,'Processed ?'          ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainProcessedComment.fieldname          ,'Processed Comment'    ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainDocumentsOnly.fieldname             ,'Documents Only'       ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainSaleType.fieldname                  ,'Sales Type'           ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainShipmentActive.fieldname            ,'Shipment Active'      ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainSaleRefNo.fieldname                 ,'Sales Ref No'         ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainDateCreated.fieldname               ,'Date Created'         ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainEmployeeName.fieldname              ,'Employee Name'        ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainShiplistActive.fieldname            ,'Active ?'             ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainSTATUS.fieldname                    ,'Status'               ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainShipQty.fieldname                   ,'Qty '                 ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainSynched.fieldname                   ,'Synched ?'            ,10,'Shipment'));
   GrdMain.Selected.Add(SelectedText(QrymainShipDate.fieldname                  ,'Date'                 ,10,'Shipment'));
   HaveDateRangeSelection := false;
end;

procedure TEBayOrderShipmentsGUI.RefreshQuery;
begin
  Qrymain.parambyname('Datefrom').asDateTime := Appenv.companyprefs.StatusUpdatedUntil;
  inherited;
end;

procedure TEBayOrderShipmentsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainClientId.fieldname);
  RemoveFieldfromGrid(QrymainTIMESTAMPtofilter.fieldname);
  RemoveFieldfromGrid(QrymainShipmentId.fieldname);
  RemoveFieldfromGrid(QrymainShipAddressId.fieldname);
end;

initialization
  RegisterClassOnce(TEBayOrderShipmentsGUI);
end.
