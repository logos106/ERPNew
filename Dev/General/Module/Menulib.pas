unit Menulib;

interface

uses  Classes, menus;

(*
type
TMenuPage = record
  Category:String;
  Actionnames :String;
end;*)

procedure DefaultCategories(OrigCategories :TStringList; OrigAction :TStringList; SortedCategories :TStringList ; SortedAction:TStringList );
Function MainMenuHelpcontextID(Const Pagename:String):Integer;
function menuItem(PopupMenu : TPopupMenu;menuCaption: String):TMenuitem;


implementation

uses tcConst, CommonLib, AppEnvironment, tcTypes, sysutils, ERPLib, StSConst;

function menuItem(PopupMenu : TPopupMenu;menuCaption: String):TMenuitem;
var
  ctr:Integer;
begin
  result := nil;
  if PopupMenu.Items.Count=0 then exit;
  for ctr := 0 to PopupMenu.Items.Count-1 do begin
    if sametext(PopupMenu.Items[ctr].caption ,  menuCaption) or
       sametext(PopupMenu.Items[ctr].caption ,  replacestr(menuCaption , '&', '')) then begin
         result :=PopupMenu.Items[ctr];
         exit;
       end;
  end;
end;

Function MainMenuHelpcontextID(Const Pagename:String):Integer;
begin
                       if sametext(Pagename , 'Accounts') then result :=            990
                  else if sametext(Pagename , 'Appointments') then result :=        980
//                else if sametext(Pagename , 'Assessment') then result :=          970
                  else if sametext(Pagename , 'Banking') then result :=             960
                  else if sametext(Pagename , 'Budget') then result :=              950
                  else if sametext(Pagename , 'CRM') then result :=                 940
                  else if sametext(Pagename , 'Marketing') then result :=           930
                  else if sametext(Pagename , 'Delivery') then result :=            920
                  else if sametext(Pagename , 'EBay') then result :=          910
                  else if sametext(Pagename , 'Walmart') then result :=       920
                  else if sametext(Pagename , 'WooCommerce') then result :=   930
                  else if sametext(Pagename , 'EDI and Integration') then result := 900
                  else if sametext(Pagename , 'Employee') then result :=            890
                  else if sametext(Pagename , 'Fixed Assets') then result :=        880
                  else if sametext(Pagename , 'General') then result :=             870
                  else if sametext(Pagename , 'Google') then result :=              860
                  else if sametext(Pagename , 'Hire') then result :=                850
                  else if sametext(Pagename , 'Inventory') then result :=           840
                  else if sametext(Pagename , 'Inventory Adjust') then result :=    830
                  else if sametext(Pagename , 'Manufacturing Setup') then result := 820
                  else if sametext(Pagename , 'Manufacturing') then result :=       810
                  else if sametext(Pagename , 'Payments') then result :=            800
                  else if sametext(Pagename , 'Payroll') then result :=             790
                  else if sametext(Pagename , 'Purchases') then result :=           780
                  else if sametext(Pagename , 'Price Schemes') then result :=       770
                  else if sametext(Pagename , 'Sales') then result :=               760
                  else if sametext(Pagename , 'Utilities') then result :=           750
                  else if sametext(Pagename , 'Workshop') then result :=            740
                  else if sametext(Pagename , 'Training') then result :=            730
                  else if sametext(Pagename , 'Workflow') then result :=            720
                  else if sametext(Pagename , 'Repairs') then result :=             710
                  else result := 0;
end;

procedure DefaultCategories(OrigCategories :TStringList; OrigAction :TStringList; SortedCategories :TStringList; SortedAction:TStringList );

  Procedure AddPage(Category, actionnames:String);
  begin
    if OrigCategories<> nil then OrigCategories.add(Category);
    if OrigAction<> nil then OrigAction.add(actionnames);
  end;
var
  i, j: Integer;
begin
  //add the default categories
  if AppEnv.CompanyPrefs.AmazonConfig.Active then
    AddPage('Amazon',DEFAULT_ACTIONS_AMAZON);
  if AppEnv.RegionalOptions.RegionType = rUK then
    AddPage('Accounts',           DEFAULT_ACTIONS_ACCOUNTS_UK)
  else if AppEnv.RegionalOptions.RegionType = rAust then
    AddPage('Accounts',           DEFAULT_ACTIONS_ACCOUNTS_AUS_NZ)
  else if AppEnv.RegionalOptions.RegionType = rNZ then
    AddPage('Accounts',           DEFAULT_ACTIONS_ACCOUNTS_AUS_NZ)
  else
    AddPage('Accounts',           DEFAULT_ACTIONS_ACCOUNTS_OTHERS);
  AddPage('Appointments',       DEFAULT_ACTIONS_APPOINTMENTS);
//                AddPage('Assessment',         DEFAULT_ACTIONS_ASSESSMENT);
  AddPage('Banking',            DEFAULT_ACTIONS_BANKING);
  AddPage('Budget',             DEFAULT_ACTIONS_BUDGET);
  AddPage('CRM',                DEFAULT_ACTIONS_CRM);
  AddPage('Delivery',           DEFAULT_ACTIONS_DELIVERY);
  if (*AppEnv.CompanyPrefs.EnableEbay and*) AppEnv.CompanyPrefs.ShowEbayonMainMenubyDefault then
    AddPage('Ebay',DEFAULT_ACTIONS_EBAY);
  AddPage('EDI and Integration',DEFAULT_ACTIONS_INTEGRATION);
  if AppEnv.CompanyPrefs.EDIConfig.EnableEDI and AppEnv.CompanyPrefs.EDIConfig.ShowEDIonMainmenubyDefault then
    AddPage('EDI Synch',DEFAULT_ACTIONS_EDISynch);
  AddPage('Employee',           DEFAULT_ACTIONS_EMPLOYEE);
  if IsERPCustomEnabled       then AddPage('ERP',       DEFAULT_ACTIONS_ERPCustomOptions);
  if IsVS1_ProductionAdminDatabase then AddPage('VS1 Cloud (Production)', DEFAULT_ACTIONS_Vs1CustomOptions);
  if IsVS1_SandBoxAdminDatabase    then AddPage('VS1 Cloud (SandBox)', DEFAULT_ACTIONS_Vs1CustomOptions);
  AddPage('Fixed Assets',       DEFAULT_ACTIONS_FIXEDASSETS);
  AddPage('General',            DEFAULT_ACTIONS_GENERAL);
  AddPage('Google',             DEFAULT_ACTIONS_GOOGLE);
  AddPage('Hire',               DEFAULT_ACTIONS_HIRE);
  AddPage('Inventory',          DEFAULT_ACTIONS_INVENTORY);
  AddPage('Inventory Adjust',   DEFAULT_ACTIONS_INVENTORY_ADJUST);
  if AppEnv.CompanyPrefs.MagentoEnabled    and AppEnv.CompanyPrefs.ShowMagentoOnMainMenu then AddPage('Magento',DEFAULT_ACTIONS_Magento);
  if AppEnv.CompanyPrefs.AvaTaxconfig.EnableAvaTax      and AppEnv.CompanyPrefs.AvaTaxconfig.ShowAvaTaxOnMainMenu then AddPage('Avalara Tax',DEFAULT_ACTIONS_AvaTax);
  AddPage('Manufacturing Setup',DEFAULT_ACTIONS_MANUFACTURING_SETUP);
  AddPage('Manufacturing',      DEFAULT_ACTIONS_MANUFACTURING);
  AddPage('Marketing',          DEFAULT_ACTIONS_MARKETING);
  AddPage('Payments',           DEFAULT_ACTIONS_PAYMENTS);
  AddPage('Payroll',
    iif(AppEnv.RegionalOptions.RegionType = rUSA ,DEFAULT_ACTIONS_PAYROLL_USA,
    iif(AppEnv.RegionalOptions.RegionType = rUK ,DEFAULT_ACTIONS_PAYROLL_UK, DEFAULT_ACTIONS_PAYROLL)));
  AddPage('Purchases',          DEFAULT_ACTIONS_PURCHASES);
  AddPage('Price Schemes',      DEFAULT_ACTIONS_PRICESCHEME);

  if AppEnv.CompanyPrefs.IntuitConfig.EnableQuickbooks and AppEnv.CompanyPrefs.IntuitConfig.ShowQuickbooksonMainmenubyDefault then
    AddPage('Quickbooks',DEFAULT_ACTIONS_QuickBooks);

  AddPage('Sales',              DEFAULT_ACTIONS_SALES);

  if AppEnv.CompanyPrefs.UseSeedtoSale then AddPage(STS_CAPTION,DEFAULT_ACTIONS_StS);
  if AppEnv.CompanyPrefs.UseSeedtoSale and (trim(AppEnv.CompanyPrefs.StSSupplier)<>'') then AddPage(trim(AppEnv.CompanyPrefs.StSSupplier),DEFAULT_ACTIONS_StSSupplier);

  AddPage('Utilities',          DEFAULT_ACTIONS_UTILITIES);
  if AppEnv.CompanyPrefs.EnableWalmart  and AppEnv.CompanyPrefs.ShowWalmartonMainmenubyDefault then AddPage('Walmart',DEFAULT_ACTIONS_WALMART);
  if AppEnv.CompanyPrefs.EnableWooCommerce  and AppEnv.CompanyPrefs.ShowWooCommerceonMainmenubyDefault then AddPage('WooCommerce',DEFAULT_ACTIONS_WooCommerce);
  AddPage('Workshop',           DEFAULT_ACTIONS_WORKSHOP);
  AddPage('Training',           DEFAULT_ACTIONS_TRAINING);
  AddPage('Workflow',           DEFAULT_ACTIONS_WORKFlow);

  AddPage('Coles', DEFAULT_ACTIONS_COLES);

  //                AddPage('Repairs',            DEFAULT_ACTIONS_REPAIRS);

  //now sort any packages
  if (SortedCategories<> nil) and (OrigCategories <> nil) then begin
        SortedCategories.CaseSensitive := true;
        SortedCategories.Assign(OrigCategories);
        SortedCategories.Sorted := true;
        if (SortedAction<> nil) then begin
          for i := 0 to SortedCategories.Count - 1 do begin
              for j := 0 to OrigCategories.Count - 1 do begin
                  if OrigCategories.strings[j] = SortedCategories.strings[i] then begin
                      SortedAction.add(IntToStr(j));
                      Break;
                  end;
              end
          end;
        end;
    end;
end;

end.

