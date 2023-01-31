unit VS1LicenseLevelsnModulesSQL;

interface
uses
  ERPDbComponents, DAScript, SysUtils, classes, Types, DB, ReportBaseObj;


type

  TVS1LicenseLevelsnModules = class(TReportBase)
  Private
    fsRegionname: String;
  Protected
  Public
    constructor Create; Override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  published
    Property Regionname:String read fsRegionname write fsRegionname;
  end;

implementation

uses CommonLib, BusObjRegionalOptions;

{ TVS1LicenseLevelsnModules }

constructor TVS1LicenseLevelsnModules.Create;
begin
  inherited;
  fsRegionname := '';
end;

function TVS1LicenseLevelsnModules.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
var
  fiRegionID:Integer;
begin
  fiRegionID:= TREgionalOptions.IDToggle(fsRegionname);
  result := inherited;
  SQL.Clear;

  {License Levels}
  SQL.Add('SELECT DISTINCT ');
  SQL.Add('1                  AS Type, ');
  SQL.add('if(ifnull(MP.RegionId,0)=0 , "All", ifnull(R.Region,"All"))  AS Region,');
  SQL.Add('LL.Id              AS LicenseLevel,  ');
  SQL.Add('LL.LicenseOrder    AS LicenseOrder,  ');
  SQL.Add('LL.Description     AS LicenseLevelDescprion, ');
  SQL.Add('null               AS ModuleId,  ');
  SQL.Add('null               AS ModuleName ,  ');
  SQL.Add('NULL               AS moduledescription,   ');
  SQL.Add('null               AS IsExtra,  ');
  SQL.Add('null               AS RequiredLevel, ');
  SQL.Add('MP.DateFrom        AS DiscountFrom,  ');
  SQL.Add('MP.DateTo          AS DiscountTo,  ');
  SQL.Add('MP.Price           AS Price, ');
  SQL.add('Md.Discount AS Discount ');
  SQL.Add('FROM tblVS1_LicenseLevels LL ');
  SQL.Add('INNER JOIN (tblVS1_Modules M LEFT JOIN tblVS1_LicenseLevels MRL ON MRL.ID = M.RequiredLevel) ON LL.ID = M.LicenseLevel  AND M.Active ="T"  AND M.IsExtra ="F" ');
  SQL.Add('inner JOIN tblVS1_ModulePrice MP ON MP.LicenseLevel = LL.ID and  IFNULL(MP.ModuleID,0)=0  '+
                                               ' and (MP.RegionId ='+ inttostr(fiRegionID)+' Or '+ inttostr(fiRegionID)+'=0)');
  SQL.Add('Left join tblRegionaloptions R on MP.RegionId = R.RegionID');
  SQL.Add('left join tblVS1_ModuleDiscount MD ON (LL.ID = MD.LicenseLevel or MD.LicenseLevel  =0) AND MD.active ="T" '+
                                               ' and (ifnull(MD.RegionId ,0)=0 or MD.RegionId ='+ inttostr(fiRegionID)+' Or '+ inttostr(fiRegionID)+'=0)');
  SQL.Add('WHERE LL.Active ="T" ');

  {IsExtra Modules}
  SQL.Add('UNION ALL ');
  SQL.Add('SELECT 3           AS Type,   ');
  SQL.add('if(ifnull(MP.RegionId,0)=0 , "All", ifnull(R.Region,"All"))  AS Region,');
  SQL.Add('LL.Id              AS LicenseLevel,  ');
  SQL.Add('LL.LicenseOrder    AS LicenseOrder,  ');
  SQL.Add('LL.Description     AS LicenseLevelDescprion, ');
  SQL.Add('M.ID               AS ModuleId,  ');
  SQL.Add('M.ModuleName       AS Modulename,  ');
  SQL.Add('M.Description      AS moduledescription,  ');
  SQL.Add('M.IsExtra          AS IsExtra,  ');
  SQL.Add('MRL.Description    AS RequiredLevel, ');
  SQL.Add('MP.DateFrom        AS DiscountFrom,  ');
  SQL.Add('MP.DateTo          AS DiscountTo,  ');
  SQL.Add('MP.Price           AS Price, ');
  //SQL.Add('if (MD.dateType="RG" AND MD.ClientType IN ("All","New")  , if(DiscountType="DP", MP.Price*MD.Discount/100 ,MD.Discount ) ,0) AS Discount ');
  SQL.add('Md.Discount AS Discount ');
  SQL.Add('FROM tblVS1_LicenseLevels LL ');
  SQL.Add('INNER JOIN (tblVS1_Modules M LEFT JOIN tblVS1_LicenseLevels MRL ON MRL.ID = M.RequiredLevel) ON LL.ID >= M.LicenseLevel  AND M.Active ="T" AND M.IsExtra ="T" ');
  SQL.Add('inner JOIN tblVS1_ModulePrice MP ON M.id = MP.ModuleID and  IFNULL(MP.ModuleID,0)<>0  '+
                                               ' and (MP.RegionId ='+ inttostr(fiRegionID)+' Or '+ inttostr(fiRegionID)+'=0)');
  SQL.Add('Left join tblRegionaloptions R on MP.RegionId = R.RegionID');
  SQL.Add('left join tblVS1_ModuleDiscount MD ON (MD.ModuleId = M.ID or MD.ModuleId =0) AND MD.active ="T"  '+
                                               ' and (ifnull(MD.RegionId ,0)=0 or MD.RegionId ='+ inttostr(fiRegionID)+' Or '+ inttostr(fiRegionID)+'=0)');
  SQL.Add('WHERE LL.Active ="T" ');

  {Included modules Modules}
  SQL.Add('UNION ALL ');
  SQL.Add('SELECT DISTINCT  ');
  SQL.Add('2                  AS Type,   ');
  SQL.add('if(ifnull(MP.RegionId,0)=0 , "All", ifnull(R.Region,"All"))  AS Region,');
  SQL.Add('LL.Id              AS LicenseLevel,  ');
  SQL.Add('LL.LicenseOrder    AS LicenseOrder,  ');
  SQL.Add('LL.Description     AS LicenseLevelDescprion, ');
  SQL.Add('M.ID               AS ModuleId,  ');
  SQL.Add('M.ModuleName       AS ModuleName, ');
  SQL.Add('M.Description      AS moduledescription,   ');
  SQL.Add('M.IsExtra          AS IsExtra,  ');
  SQL.Add('MRL.Description    AS RequiredLevel, ');
  SQL.Add('null               AS DiscountFrom,  ');
  SQL.Add('null               AS DiscountTo,  ');
  SQL.Add('null               AS Price, ');
  SQL.Add('null               AS Discount ');
  SQL.Add('FROM tblVS1_LicenseLevels LL ');
  SQL.Add('INNER JOIN (tblVS1_Modules M LEFT JOIN tblVS1_LicenseLevels MRL ON MRL.ID = M.RequiredLevel) ON LL.ID = M.LicenseLevel  AND M.Active ="T"  AND M.IsExtra ="F" ');
  SQL.Add('inner JOIN tblVS1_ModulePrice MP ON MP.LicenseLevel = LL.ID and  IFNULL(MP.ModuleID,0)=0  '+
                                               ' and (MP.RegionId ='+ inttostr(fiRegionID)+' Or '+ inttostr(fiRegionID)+'=0)');
  SQL.Add('Left join tblRegionaloptions R on MP.RegionId = R.RegionID');
(*  SQL.Add('left join tblVS1_ModuleDiscount MD ON (LL.ID = MD.LicenseLevel ) AND MD.active ="T"  '+
                                               ' and (ifnull(MD.RegionId ,0)=0 or MD.RegionId ='+ inttostr(fiRegionID)+' Or '+ inttostr(fiRegionID)+'=0)');*)
  SQL.Add('WHERE LL.Active ="T" ');
  SQL.Add('ORDER BY Region, LicenseOrder, Type, ModuleId');
end;
initialization
  RegisterClass(TVS1LicenseLevelsnModules);

end.
