unit VS1ClientARList;

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
  TVS1ClientARListGUI = class(TBaseListingGUI)
    qryMaindetails: TLargeintField;
    qryMainClientID: TIntegerField;
    qryMainClientName: TWideStringField;
    qryMainRegistrationDate: TDateField;
    qryMainSoftwareReleaseType: TWideStringField;
    qryMainRegionName: TWideStringField;
    qryMainLicenseRenewDuration: TWideStringField;
    qryMainLicenseFrom: TDateField;
    qryMainLicenseUntil: TDateField;
    qryMainModuleName: TWideStringField;
    qryMainModuleDescription: TWideStringField;
    qryMainIsExtra: TWideStringField;
    qryMainrenewPrice: TFloatField;
    qryMainnextRenewDate: TDateField;
    qryMainnextLicenseFrom: TDateField;
    qryMainnextLicenseTo: TDateField;
    qryMainLicenseLeveldesc: TWideStringField;
    qryMainLicenseLevel: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    //fsTablename:String;
    //Procedure CalRenewalPrice;
  Protected
    procedure SetGridColumns; Override;
    procedure ReadGrpfiltersPrefs;Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, AppEnvironment, CommonDbLib, DbSharedObjectsObj;

{$R *.dfm}

{ TVS1ClientARListGUI }

(*procedure TVS1ClientARListGUI.CalRenewalPrice;
var
  ctr:Integer;
  cmd :TERPCommand;
begin
  inherited;
  cmd := DbSharedObj.Getcommand(commondblib.GetSharedMyDacConnection);
  try
    CMD.SQL.Clear;
    for ctr:= 1 to 2 do begin
        if CMD.SQL.count >0 then CMD.SQL.add('UNION ALL');
        CMD.SQL.add('SELECT DISTINCT');
        CMD.SQL.add('C.id as ClientId, ');
        CMD.SQL.add('C.ClientName,');
        CMD.SQL.add('C.RegistrationDate,');
        CMD.SQL.add('MP.LicenseLevel,');
        CMD.SQL.add('MP.ModuleID,');
        CMD.SQL.add('MP.DateFrom,');
        CMD.SQL.add('MP.DateTo,');
        CMD.SQL.add('MP.Price,');
        CMD.SQL.add('Md.Id as moduleDiscountId,');
        CMD.SQL.add('Md.Description,');
        CMD.SQL.add('Md.Discount,');
        CMD.SQL.add('CONCAT(Md.Discount, if(Md.DiscountType="DP","%",' + quotedstr(AppEnv.RegionalOptions.CurrencySymbol)+')) AS Discounts,');
        CMD.SQL.add('if(Md.DiscountType="DP" , (MP.Price*Md.Discount/100), Md.Discount) AS DiscountAmt,');
        CMD.SQL.add('MP.Price-if(Md.DiscountType="DP" , (MP.Price*Md.Discount/100), Md.Discount) AS DiscountedPrice,');
        CMD.SQL.add('Md.DiscountType,');
        CMD.SQL.add('Md.Duration,');
        CMD.SQL.add('Md.Clienttype,');
        CMD.SQL.add('if(Md.Clienttype="New", C.RegistrationDate,Md.DiscountFrom) AS DiscountFrom,');
        CMD.SQL.add('date_add(date_add(if(Md.Clienttype="New", C.RegistrationDate,Md.DiscountFrom), INTERVAL Md.Duration MONTH), INTERVAL -1 DAY)  AS DiscountTo,');
        CMD.SQL.add('(SELECT COUNT(CMU.ID) from tblVS1_clientmodulesusage CMU where CM.ID = CMU.ClientModuleID)+1 monthno');
        CMD.SQL.add('FROM');
        CMD.SQL.add('tblVS1_clients C');
        CMD.SQL.add('inner JOIN tblVS1_clientmodules CM ON C.id = CM.ClientId');
        if ctr = 1 then begin
          CMD.SQL.add('inner JOIN tblVS1_moduleprice   MP ON MP.RegionID = (SELECT regionid FROM tblregionaloptions WHERE Region =C.regionname ) and MP.LicenseLevel = CM.LicenseLevel AND IFNULL(MP.ModuleID,0)=0');
          CMD.SQL.add('Left join tblVS1_modulediscount Md ON (ifnull(Md.RegionID,0)=0 or Md.RegionID = (SELECT regionid FROM tblregionaloptions WHERE Region =C.regionname )) AND  ((IFNULL(Md.LicenseLevel,0)=0 ) OR (Md.LicenseLevel = CM.LicenseLevel )) AND Md.Active ="T"');
        end else begin
          CMD.SQL.add('inner JOIN tblVS1_moduleprice   MP ON  MP.RegionID = (SELECT regionid FROM tblregionaloptions WHERE Region =C.regionname ) and IFNULL(MP.ModuleID,0) = IFNULL(CM.ModuleID,0)');
          CMD.SQL.add('Left join tblVS1_modulediscount Md ON  (ifnull(Md.RegionID,0)=0 or Md.RegionID = (SELECT regionid FROM tblregionaloptions WHERE Region =C.regionname )) AND ((IFNULL(Md.ModuleId,0)=0) OR (Md.ModuleID = CM.ModuleID )) AND Md.Active ="T"');
        end;
        CMD.SQL.add('HAVING (Md.Clienttype IN ("New") AND monthno <=Md.Duration) OR (Md.Clienttype IN ("Old") AND monthno >1) OR (Md.Clienttype IN ("All"))');
    end;
    CMD.SQL.add('Order by DiscountAmt Limit 1'); // get the lawest dicsounted price

    cmd.Execute;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;*)

procedure TVS1ClientARListGUI.FormCreate(Sender: TObject);
begin
  inherited;
//  fstablename := commondblib.GetUserTemporaryTableName('VS1RenewalPrice');
end;

procedure TVS1ClientARListGUI.FormDestroy(Sender: TObject);
begin
  //DestroyUserTemporaryTable(fsTablename);
  inherited;
end;

procedure TVS1ClientARListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if grpfilters.itemindex =0 then
  else if qrymaindetails.asInteger = 1 then begin
     DoGreenhighlight(Afont, ABrush);
  end;
end;

procedure TVS1ClientARListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString(qrymaindetails.fieldname, ['1'], true);
  inherited;
end;

procedure TVS1ClientARListGUI.ReadGrpfiltersPrefs;
begin
  inherited;
  if not GuiPrefs.Node.Exists('Grpfilters') or (grpFilters.ItemIndex<0) or (grpFilters.ItemIndex>1)  then
        grpFilters.ItemIndex := 1;
end;

procedure TVS1ClientARListGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
  showcontrolhint(grdmain, 'This is the List of Expected Renewals between '+ formatdatetime(shortdateformat, filterdatefrom)+' and '+ formatdatetime(shortdateformat, filterdateTo));
end;

procedure TVS1ClientARListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymaindetails.fieldname);
  RemoveFieldfromGrid(qrymainclientId.fieldname);
  RemoveFieldfromGrid(qryMainLicenseLevel.fieldname);
  RemoveFieldfromGrid(qryMainSoftwareReleaseType.fieldname);
end;
{ Selected.Strings = (
        'ClientName'#9'20'#9'Client~Name'
        'RegistrationDate'#9'12'#9'Registration~Date'
        'RegionName'#9'10'#9'Region'
        'LicenseRenewDuration'#9'10'#9'Renew Duration'
        'LicenseLevel'#9'10'#9'Level'#9#9'License'
        'LicenseFrom'#9'10'#9'From'#9#9'License'
        'LicenseUntil'#9'10'#9'Until'#9#9'License'
        'ModuleName'#9'20'#9'Name'#9#9'Module'
        'ModuleDescription'#9'20'#9'Description'#9#9'Module'
        'IsExtra'#9'10'#9'Is Extra ?'#9#9'Module'
        'PricePermonth'#9'10'#9'Original'#9#9'Price Per Month'
        'DiscountedPricePrmonth'#9'10'#9'Discounted'#9#9'Price Per Month'
        'renewPrice'#9'10'#9'Original'#9#9'Renew Price'
        'renewDiscountedPrice'#9'10'#9'Discounted'#9#9'Renew Price'
        'nextRenewDate'#9'10'#9'Date'#9#9'Renew '
        'nextLicenseFrom'#9'10'#9'From'#9#9'Renew '
        'nextLicenseTo'#9'10'#9'To'#9#9'Renew ')}

{SELECT
1 AS details,
C.id AS ClientID,
C.ClientName AS ClientName,
C.RegistrationDate AS RegistrationDate,
C.SoftwareReleaseType AS SoftwareReleaseType,
C.RegionName AS RegionName,
CONCAT (CM.LicenseRenewDuration , ' ',   if(CM.LicenseRenewDurationType ='M' , 'Month', 'Year')) AS LicenseRenewDuration,
CM.LicenseLevel AS LicenseLevel,
CM.LicenseFrom AS LicenseFrom,
CM.LicenseUntil AS LicenseUntil,
null AS ModuleName,
null AS ModuleDescription,
null AS IsExtra,
sum(CM.DiscountedPrice) AS DiscountedPricePrmonth,
Sum(CM.Price ) AS PricePermonth ,
sum(CM.DiscountedPrice *CM.LicenseRenewDuration* if(CM.LicenseRenewDurationType='M', 1, 12)  ) AS renewDiscountedPrice,
Sum(CM.Price *CM.LicenseRenewDuration* if(CM.LicenseRenewDurationType='M', 1, 12)  ) AS renewPrice ,
DATE_ADD(CM.LicenseUntil, INTERVAL -1 MONTH) AS nextRenewDate,
DATE_ADD(CM.LicenseUntil, INTERVAL 1 day) AS nextLicenseFrom,
DATE_ADD(CM.LicenseUntil ,INTERVAL CM.LicenseRenewDuration* if(CM.LicenseRenewDurationType='M', 1, 12)  MONTH) nextLicenseTo
from tblvs1_clients C
INNER JOIN tblvs1_clientmodules CM ON C.id = CM.ClientId
INNER JOIN tblvs1_modules M ON CM.ModuleId = M.ID
HAVING LicenseUntil BETWEEN :Datefrom and :Dateto
UNION
SELECT
2 AS details,
C.id AS ClientID,
C.ClientName AS ClientName,
C.RegistrationDate AS RegistrationDate,
C.SoftwareReleaseType AS SoftwareReleaseType,
C.RegionName AS RegionName,
CONCAT (CM.LicenseRenewDuration , ' ',   if(CM.LicenseRenewDurationType ='M' , 'Month', 'Year')) AS LicenseRenewDuration,
CM.LicenseLevel AS LicenseLevel,
CM.LicenseFrom AS LicenseFrom,
CM.LicenseUntil AS LicenseUntil,
M.ModuleName AS ModuleName,
M.Description AS ModuleDescription,
M.IsExtra AS IsExtra,
CM.DiscountedPrice AS DiscountedPricepermonth,
CM.Price  AS Pricepermonth,
CM.DiscountedPrice*CM.LicenseRenewDuration* if(CM.LicenseRenewDurationType='M', 1, 12)   AS RenewDiscountedPrice,
CM.Price *CM.LicenseRenewDuration* if(CM.LicenseRenewDurationType='M', 1, 12)   AS RenewPrice ,
DATE_ADD(CM.LicenseUntil, INTERVAL -1 MONTH) AS nextRenewDate,
DATE_ADD(CM.LicenseUntil, INTERVAL 1 day) AS nextLicenseFrom,
DATE_ADD(CM.LicenseUntil ,INTERVAL CM.LicenseRenewDuration* if(CM.LicenseRenewDurationType='M', 1, 12)  MONTH) nextLicenseTo
from tblvs1_clients C
INNER JOIN tblvs1_clientmodules CM ON C.id = CM.ClientId
INNER JOIN tblvs1_modules M ON CM.ModuleId = M.ID
HAVING LicenseUntil BETWEEN :Datefrom and :Dateto
order by ClientName,details;
}
initialization
  RegisterClass(TVS1ClientARListGUI);

end.
