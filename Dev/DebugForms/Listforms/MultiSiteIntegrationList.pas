unit MultiSiteIntegrationList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TMultiSiteIntegrationListGUI = class(TBaseListingGUI)
    qryMainTablename: TWideStringField;
    qryMainMad: TLargeintField;
    qryMaincanada: TLargeintField;
    qryMainhawai: TLargeintField;
    qryMainny: TLargeintField;
    qryMainsa: TLargeintField;
    qryMainusa: TLargeintField;
    qryMainMergedMad: TLargeintField;
    qryMainMergedcanada: TLargeintField;
    qryMainMergedhawai: TLargeintField;
    qryMainMergedny: TLargeintField;
    qryMainMergedsa: TLargeintField;
    qryMainMergedusa: TLargeintField;

    procedure FormCreate(Sender: TObject);
  private
  public

  end;

var
  MultiSiteIntegrationListGUI: TMultiSiteIntegrationListGUI;

implementation

uses BusObjBase, BusObjPreference, Busobjcustomfields, BusObjRegionalOptions,
  BusObjClass, BusObjAbility, BusObjSimpleTypes, BusObjCommon,
  BusObjPayRate, BusObjProductPicture, BusobjProductProperties, BusObjGLAccount,
  BusObjTaxCodes, BusObjClient, BusObjModel, BusObjManufacture, BusobjCountries,
  BusObjCurrency, busobjPaymethods, BusobjProductFormula, BusObjStock,
  busobjSerialnumbers, BusObjEquipment, BusObjEmployee, BusObjRoster,
  busobjProductcommission, BusObjToDo, busobjtasks, BusObjRep,
  busobjPhoneSupportLog, BusObjRepServices, BusobjMarketingcontacts,
  BusObjMarketingLeads, BusObjSales, BusObjPosKeypad, BusObjPosTill,
  BusObjPosEop, BusObjAppointments, BusobjCash, busobjvoucher,
  BusobjStockAdjustEntry, busobjStockMovement, busobjstockTransferentry,
  BusObjPOSSale, BusObjRepairs, LogLib, CommonLib, CommonDbLib, tcConst;

{$R *.dfm}

procedure TMultiSiteIntegrationListGUI.FormCreate(Sender: TObject);
var
  conn : TMyDacDataConnection;

  function SQL(ComponentClassType: TComponentClass; hasunion:Boolean = True):String;
  var
    obj : TDatasetBusObj;
  begin
      result := '';

      if hasunion then result := result +' Union all ';
      obj := TDatasetBusObj (TComponentClass(ComponentClassType).Create(nil));
      try
      obj.Connection := conn;
      obj.Load(0);
      result := result +' select ' + quotedstr(obj.BusObjectTableName)+' as Tablename,'+
                                    '(Select count(*) from madeurne_pty_ltd.'         + obj.BusObjectTableName+') as Mad , '+
                                    '(Select count(*) from trueerp_canada_2015_june.' + obj.BusObjectTableName+') as canada, '+
                                    '(Select count(*) from trueerp_hawaii.'           + obj.BusObjectTableName+') as hawai, '+
                                    '(Select count(*) from trueerp_new_york.'         + obj.BusObjectTableName+') as ny, '+
                                    '(Select count(*) from trueerp_sa.'               + obj.BusObjectTableName+') as sa, '+
                                    '(Select count(*) from trueerp_usa.'              + obj.BusObjectTableName+') as usa ,'+

                                    '(Select count(*) from madeurne_pty_ltd.'         + obj.BusObjectTableName+'  where not (Globalref like concat((SELECT SiteCode FROM madeurne_pty_ltd.tblmsbackendid        ) , ''%''))) as mergedMad , '+
                                    '(Select count(*) from trueerp_canada_2015_june.' + obj.BusObjectTableName+'  where not (Globalref like concat((SELECT SiteCode FROM trueerp_canada_2015_june.tblmsbackendid) , ''%''))) as mergedcanada, '+
                                    '(Select count(*) from trueerp_hawaii.'           + obj.BusObjectTableName+'  where not (Globalref like concat((SELECT SiteCode FROM trueerp_hawaii.tblmsbackendid          ) , ''%''))) as mergedhawai, '+
                                    '(Select count(*) from trueerp_new_york.'         + obj.BusObjectTableName+'  where not (Globalref like concat((SELECT SiteCode FROM trueerp_new_york.tblmsbackendid        ) , ''%''))) as mergedny, '+
                                    '(Select count(*) from trueerp_sa.'               + obj.BusObjectTableName+'  where not (Globalref like concat((SELECT SiteCode FROM trueerp_sa.tblmsbackendid              ) , ''%''))) as mergedsa, '+
                                    '(Select count(*) from trueerp_usa.'              + obj.BusObjectTableName+'  where not (Globalref like concat((SELECT SiteCode FROM trueerp_usa.tblmsbackendid             ) , ''%''))) as mergedusa ';

      finally
        Freeandnil(obj);
      end;
  end;

begin
conn := TMyDAcDataconnection.Create(Self);
try
  doshowprogressbar(85, WAITMSG);
  try
  conn.Connection := GetNewMyDacConnection(self);
  Qrymain.sql.clear;
  //Qrymain.sql.add(SQL(TERPPreference                ,False); DoStepProgressbar;
  Qrymain.sql.add(SQL(TCustomFieldList              ,False)); DoStepProgressbar;
  Qrymain.sql.add(SQL(TCustomFieldList              )); DoStepProgressbar;
  //Qrymain.sql.add(SQL(TCustomFieldConfig            )); DoStepProgressbar;
  //Qrymain.sql.add(SQL(TBusObjCustFieldValueConfig   )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TRegionalOptions              )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TDeptClass                    )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TAbility                      )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TServices                     )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TPayRate                      )); DoStepProgressbar;
  //Qrymain.sql.add(SQL(TPartsClassPreferences        )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TAccountType                  )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TTaxCode                      )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TAccount                      )); DoStepProgressbar;
  //Qrymain.sql.add(SQL(TERPAccountPref               )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TSource                       )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TModel                        )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TManufacture                  )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TCountries                    )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TCurrency                     )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TCurrencyRateHistory          )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TShippingMethod               )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TPaymentMethod                )); DoStepProgressbar;
  //Qrymain.sql.add(SQL(TERPPaymentMethodPref         )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TTerms                        )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TClientType                   )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TCompanyType                  )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TFormulaEntry                 )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TFormula                      )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TProductWeb                   )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TSerialJobNumbers             )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TProductJPGPicture            )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TEquipment                    )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TEquipmentJPGPicture          )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TEquipmentJPGImages           )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TEmployee                     )); DoStepProgressbar;
  //Qrymain.sql.add(SQL(TERPEmployeePref              )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TRoster                       )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TPreference                   )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TEmpNoCommsProducts           )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TToDo                         )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TToDoLines                    )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TTasks                        )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TTasksPages                   )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TCustomer                     )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TRepServices                  )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TPhoneSupportType             )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TPhoneSupportVersion          )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TPhoneSupportLog              )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TPhoneSupportLoglines         )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TLeadActionType               )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TAppointmentStatusType        )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TOtherContact                 )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TMarketingContact             )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TLeads                        )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TCustomerEquipment            )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TQuote                        )); DoStepProgressbar;
  //Qrymain.sql.add(SQL(TSalesOrderGroup              )); DoStepProgressbar;
  //Qrymain.sql.add(SQL(TInvoiceGroup                 )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TPosKeypad                    )); DoStepProgressbar;
  //Qrymain.sql.add(SQL(TFuncRoom                     )); DoStepProgressbar;
  //Qrymain.sql.add(SQL(TPosKeypadCustomise           )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TPosTill                      )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TPosEop                       )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TAppointment                  )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TCashSale                     )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TRefundSale                   )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TVoucher                      )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TStockAdjustEntry             )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TStockTransferEntry           )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TStockMovement                )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TPOSCashSale                  )); DoStepProgressbar;
//  Qrymain.sql.add(SQL(TDelectedProductPicture       )); DoStepProgressbar;
//  Qrymain.sql.add(SQL(TDeletedPartsClassPreferences )); DoStepProgressbar;
//  Qrymain.sql.add(SQL(TDeletedPreference            )); DoStepProgressbar;
//  Qrymain.sql.add(SQL(TDeletedCFListDropDown        )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TRepairFaults                 )); DoStepProgressbar;
  Qrymain.sql.add(SQL(TRepairs                      )); DoStepProgressbar;
  Qrymain.sql.add('Order by Tablename');
finally
  freeandnil(conn); DoStepProgressbar;
end;
clog(Qrymain.sql.Text); DoStepProgressbar;
  inherited;
  HaveDateRangeSelection := fAlse;
finally
  dohideprogressbar;
end;

end;
initialization
  RegisterClassOnce(TMultiSiteIntegrationListGUI);

end.

