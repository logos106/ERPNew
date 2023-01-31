unit ProductPriceList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProductPriceListGUI = class(TBaseListingGUI)
    qryMainRecType: TLargeintField;
    qryMainpartsId: TIntegerField;
    qryMainpartname: TWideStringField;
    qryMainSalesDescription: TWideStringField;
    qryMainPurchaseDescription: TWideStringField;
    qryMainWHOLESALEPRICE: TFloatField;
    qryMainPRICE1: TFloatField;
    qryMainCOST1: TFloatField;
    qryMainCOST2: TFloatField;
    qryMainCOST3: TFloatField;
    qryMainCOSTINC1: TFloatField;
    qryMainCOSTINC2: TFloatField;
    qryMainCOSTINC3: TFloatField;
    qryMainPRICE2: TFloatField;
    qryMainPRICE3: TFloatField;
    qryMainPRICEINC1: TFloatField;
    qryMainPRICEINC2: TFloatField;
    qryMainPRICEINC3: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainunitId: TIntegerField;
    qryMainWSP1: TFloatField;
    qryMainWSP2: TFloatField;
    qryMainWSP3: TFloatField;
    qryMainWSP4: TFloatField;
    btnchooseWholeSalers: TDNMSpeedButton;
    qryMainRetailPRICE: TFloatField;
    qryMainCustFld1: TWideStringField;
    qryMainCustFld2: TWideStringField;
    qryMainCustFld3: TWideStringField;
    qryMainCustFld4: TWideStringField;
    qryMainCustFld5: TWideStringField;
    qryMainCustFld6: TWideStringField;
    qryMainCustFld7: TWideStringField;
    qryMainCustFld8: TWideStringField;
    qryMainCustFld9: TWideStringField;
    qryMainCustFld10: TWideStringField;
    qryMainCustFld11: TWideStringField;
    qryMainCustFld12: TWideStringField;
    qryMainCustFld13: TWideStringField;
    qryMainCustFld14: TWideStringField;
    qryMainCustFld115: TWideStringField;
    qryMainCustDate1: TDateTimeField;
    qryMainCustDate2: TDateTimeField;
    qryMainCustDate3: TDateTimeField;
    qryMainActive: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string;
      AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure btnchooseWholeSalersClick(Sender: TObject);
  private
    function MainQrySQL(const HasgroupLineforProduct:boolean =True;aSQL :TSTrings = nil):String;
  Protected
    procedure SetGridColumns; Override;
    function GetReportTypeID: integer; Override;
    procedure MakeTemplateSQL;Override;
    procedure ApplyQueryFilter; override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, tcDataUtils, AppEnvironment, tcConst, Preferences,
  TemplateReportsLib, LogLib;

{$R *.dfm}
{ TProductPriceListGUI }

procedure TProductPriceListGUI.ApplyQueryFilter;
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Active}
        GroupFilterString := '(Active = "T")';
      end;
    1:
      begin {Inactive}
        GroupFilterString := '(Active = "F")';
      end;
    2:
      begin {All}
        GroupFilterString := '';
      end;
  end;
  inherited;
end;

procedure TProductPriceListGUI.btnchooseWholeSalersClick(Sender: TObject);
begin
  inherited;
  OpenPrefform('Sales' ,  'cboWholeSaleCustomerType1' , 0 , true );
  SetGridColumns;
end;

procedure TProductPriceListGUI.FormCreate(Sender: TObject);
begin
  (*Qrymain.SQL.Text:= *)MainQrysQL( True , Qrymain.SQL);
  inherited;
  BaseIndexfields:= 'Partname, Rectype';
  HaveDateRangeSelection := False;
end;

function TProductPriceListGUI.GetReportTypeID: integer;
begin
  Result := TemplateTypeID('Product Price List');
end;

procedure TProductPriceListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;

  if QrymainRecType.asInteger = 1 then begin
    Afont.Style := Afont.Style +[fsBold];
    //if not sametext(Field.Fieldname, qryMainPartname.fieldname ) then Abrush.color := GridColBrushInactive;
  end else begin
   if sametext(Field.Fieldname, qryMainSalesDescription.fieldname ) or
          sametext(Field.Fieldname, qryMainPurchaseDescription.fieldname ) or
          sametext(Field.Fieldname, qryMainWHOLESALEPRICE.fieldname ) or
          sametext(Field.Fieldname, qryMainPRICE1.fieldname ) or
          sametext(Field.Fieldname, qryMainCOST1.fieldname ) or
          sametext(Field.Fieldname, qryMainCOST2.fieldname ) or
          sametext(Field.Fieldname, qryMainCOST3.fieldname ) or
          sametext(Field.Fieldname, qryMainCOSTINC1.fieldname ) or
          sametext(Field.Fieldname, qryMainCOSTINC2.fieldname ) or
          sametext(Field.Fieldname, qryMainCOSTINC3.fieldname ) or
          sametext(Field.Fieldname, qryMainPRICE2.fieldname ) or
          sametext(Field.Fieldname, qryMainPRICE3.fieldname ) or
          sametext(Field.Fieldname, qryMainPRICEINC1.fieldname ) or
          sametext(Field.Fieldname, qryMainPRICEINC2.fieldname ) or
          sametext(Field.Fieldname, qryMainPRICEINC3.fieldname ) then Afont.color := ABrush.color;

  if sametext(qryMainretailPRICE.fieldname , Field.fieldname) then ABrush.color := GridColhighLightGreen
  else if sametext(qryMainWSP1.fieldname , Field.fieldname) or
          sametext(qryMainWSP2.fieldname , Field.fieldname) or
          sametext(qryMainWSP3.fieldname , Field.fieldname) or
          sametext(qryMainWSP4.fieldname , Field.fieldname) then ABrush.color := GridColhighLightYellow1 ;
  if (Appenv.companyprefs.WholeSaleCustomerType1 = '') and (sametext(qryMainWSP1.fieldname , Field.fieldname)) then Afont.color := Inactivefontcolor;
  if (Appenv.companyprefs.WholeSaleCustomerType2 = '') and (sametext(qryMainWSP2.fieldname , Field.fieldname)) then Afont.color := Inactivefontcolor;
  if (Appenv.companyprefs.WholeSaleCustomerType3 = '') and (sametext(qryMainWSP3.fieldname , Field.fieldname)) then Afont.color := Inactivefontcolor;
  if (Appenv.companyprefs.WholeSaleCustomerType4 = '') and (sametext(qryMainWSP4.fieldname , Field.fieldname)) then Afont.color := Inactivefontcolor;
  end;
end;

procedure TProductPriceListGUI.grdMainCalcTitleAttributes(Sender: TObject;
  AFieldName: string; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
  if (Appenv.companyprefs.WholeSaleCustomerType1 = '') and (sametext(qryMainWSP1.fieldname , AFieldName)) then Afont.color := Inactivefontcolor;
  if (Appenv.companyprefs.WholeSaleCustomerType2 = '') and (sametext(qryMainWSP2.fieldname , AFieldName)) then Afont.color := Inactivefontcolor;
  if (Appenv.companyprefs.WholeSaleCustomerType3 = '') and (sametext(qryMainWSP3.fieldname , AFieldName)) then Afont.color := Inactivefontcolor;
  if (Appenv.companyprefs.WholeSaleCustomerType4 = '') and (sametext(qryMainWSP4.fieldname , AFieldName)) then Afont.color := Inactivefontcolor;

end;

procedure TProductPriceListGUI.MakeTemplateSQL;
begin
  inherited;
  ReportSQLSupplied := True;
  (*TemplateSQL:= companyInfoSQL +'~|||~{Details}' + Qrymain.SQL.Text;
  TemplateSQL := Replacestr(TemplateSQL , ':RCT' , inttostr(getClientTypeID(Appenv.companyprefs.RetailcustomerType1)));
  TemplateSQL := Replacestr(TemplateSQL , ':WCT1', inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType1)));
  TemplateSQL := Replacestr(TemplateSQL , ':WCT2', inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType2)));
  TemplateSQL := Replacestr(TemplateSQL , ':WCT3', inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType3)));
  TemplateSQL := Replacestr(TemplateSQL , ':WCT4', inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType4)));*)
  TemplateSQL:= companyInfoSQL +'~|||~{Details} ' + MainQrysQL( False);
end;
Function TProductPriceListGUI.MainQrySQL(const HasgroupLineforProduct:boolean =True;aSQL :TSTrings = nil):String;
var
  st:TStrings;
  Function SQL:TStrings;
  begin
    if  aSQL<> nil then result := aSQL else result := st;
  end;
begin
  st:= TStrings.create;
  try
    Result := '';
    try
      with SQL do begin
            clear;
            if HasgroupLineforProduct then begin
              Add('Select ' );
              Add('1                   as Rectype, ' );
              Add('P.partsId           as partsId , ' );
              Add('P.partname          as partname, ' );
              Add('P.Description       as SalesDescription, ' );
              Add('P.PURCHASEDESC      as PurchaseDescription, ' );
              Add('NULL                as UOM , ' );
              Add('NULL                as unitId, ' );
              Add('NULL                as RetailPRICE, ' );
              Add('P.WHOLESALEPRICE    as WHOLESALEPRICE, ' );
              Add('P.COST1             as COST1, ' );
              Add('P.COST2             as COST2, ' );
              Add('P.COST3             as COST3, ' );
              Add('P.COSTINC1          as COSTINC1, ' );
              Add('P.COSTINC2          as COSTINC2, ' );
              Add('P.COSTINC3          as COSTINC3,' );
              Add('P.PRICE1            as PRICE1  , ' );
              Add('P.PRICE2            as PRICE2,' );
              Add('P.PRICE3            as PRICE3, ' );
              Add('P.PRICEINC1         as PRICEINC1, ' );
              Add('P.PRICEINC2         as PRICEINC2, ' );
              Add('P.PRICEINC3         as PRICEINC3, ');
              Add('NULL                as WSP1, ' );
              Add('NULL                as WSP2, ' );
              Add('NULL                as WSP3, ' );
              Add('NULL                as WSP4, ' );
              Add('P.CUSTFLD1          as CustFld1, ' );
              Add('P.CUSTFLD2          as CustFld2, ' );
              Add('P.CUSTFLD3          as CustFld3, ' );
              Add('P.CUSTFLD4          as CustFld4, ' );
              Add('P.CUSTFLD5          as CustFld5, ' );
              Add('P.CUSTFLD6          as CustFld6, ' );
              Add('P.CUSTFLD7          as CustFld7, ' );
              Add('P.CUSTFLD8          as CustFld8, ' );
              Add('P.CUSTFLD9          as CustFld9, ' );
              Add('P.CUSTFLD10         as CustFld10, ' );
              Add('P.CUSTFLD11         as CustFld11, ' );
              Add('P.CUSTFLD12         as CustFld12, ' );
              Add('P.CUSTFLD13         as CustFld13, ' );
              Add('P.CUSTFLD14         as CustFld14, ' );
              Add('P.CUSTFLD15         as CustFld115, ' );
              Add('P.CUSTDATE1         as CustDate1, ' );
              Add('P.CUSTDATE2         as CustDate2, ' );
              Add('P.CUSTDATE3         as CustDate3, ' );
              Add('P.Active            as Active ' );
              Add('from tblparts  P ' );
              Add('where P.IsSystemProduct ="F" ' );
            end;
              Add('union all  ' );
              Add('Select Distinct ' );
              Add('3                   as Rectype, ' );
              Add('P.partsId           as partsId , ' );
              Add('P.partname          as partname, ' );
              Add('P.Description       as SalesDescription, ' );
              Add('P.PURCHASEDESC      as PurchaseDescription, ' );
              Add('concat(UOM.UnitName , "(" , UOM.Multiplier , ")") as UOM , ' );
              Add('UOM.UnitID          as UnitID, ' );
              Add('Retailer.Price1*UOM.Multiplier     as RetailPRICE, ' );
              Add('P.WHOLESALEPRICE    as WHOLESALEPRICE, ' );
              Add('P.COST1             as COST1, ' );
              Add('P.COST2             as COST2, ' );
              Add('P.COST3             as COST3, ' );
              Add('P.COSTINC1          as COSTINC1, ' );
              Add('P.COSTINC2          as COSTINC2, ' );
              Add('P.COSTINC3          as COSTINC3,' );
              Add('P.PRICE1            as PRICE1  , ' );
              Add('P.PRICE2            as PRICE2,' );
              Add('P.PRICE3            as PRICE3, ' );
              Add('P.PRICEINC1         as PRICEINC1, ' );
              Add('P.PRICEINC2         as PRICEINC2, ' );
              Add('P.PRICEINC3         as PRICEINC3, ');
              Add('WholeSaler1.Price1*UOM.Multiplier  as WSP1, ' );
              Add('WholeSaler2.Price1*UOM.Multiplier  as WSP2, ' );
              Add('WholeSaler3.Price1*UOM.Multiplier  as WSP3, ' );
              Add('WholeSaler4.Price1*UOM.Multiplier  as WSP4, ' );
              Add('P.CUSTFLD1          as CustFld1, ' );
              Add('P.CUSTFLD2          as CustFld2, ' );
              Add('P.CUSTFLD3          as CustFld3, ' );
              Add('P.CUSTFLD4          as CustFld4, ' );
              Add('P.CUSTFLD5          as CustFld5, ' );
              Add('P.CUSTFLD6          as CustFld6, ' );
              Add('P.CUSTFLD7          as CustFld7, ' );
              Add('P.CUSTFLD8          as CustFld8, ' );
              Add('P.CUSTFLD9          as CustFld9, ' );
              Add('P.CUSTFLD10         as CustFld10, ' );
              Add('P.CUSTFLD11         as CustFld11, ' );
              Add('P.CUSTFLD12         as CustFld12, ' );
              Add('P.CUSTFLD13         as CustFld13, ' );
              Add('P.CUSTFLD14         as CustFld14, ' );
              Add('P.CUSTFLD15         as CustFld115, ' );
              Add('P.CUSTDATE1         as CustDate1, ' );
              Add('P.CUSTDATE2         as CustDate2, ' );
              Add('P.CUSTDATE3         as CustDate3, ' );
              Add('P.Active            as Active ' );
              Add('From tblParts P ' );
              Add('inner join tblunitsofmeasure UOM on P.PartsId = UOM.PartID ' );
              Add('left join tblextrapricesell Retailer on Retailer.UOMID = UOM.UnitID and Retailer.PartsID = UOM.PartID and Retailer.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.RetailcustomerType1)));
              Add('left join tblextrapricesell WholeSaler1 on WholeSaler1.UOMID = UOM.UnitID and WholeSaler1.PartsID = UOM.PartID and WholeSaler1.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType1)));
              Add('left join tblextrapricesell WholeSaler2 on WholeSaler2.UOMID = UOM.UnitID and WholeSaler2.PartsID = UOM.PartID and WholeSaler2.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType2)));
              Add('left join tblextrapricesell WholeSaler3 on WholeSaler3.UOMID = UOM.UnitID and WholeSaler3.PartsID = UOM.PartID and WholeSaler3.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType3)));
              Add('left join tblextrapricesell WholeSaler4 on WholeSaler4.UOMID = UOM.UnitID and WholeSaler4.PartsID = UOM.PartID and WholeSaler4.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType4)));
              Add(' where P.IsSystemProduct ="F" ' );
              Add('having ifnull(RetailPRICE,0)<> 0 or ifnull(WSP1,0)<> 0  or ifnull(WSP2,0)<> 0  or ifnull(WSP3,0)<> 0  or ifnull(WSP4,0)<> 0  ' );
              Add('union all  ' );
              Add('Select Distinct ' );
              Add('4                   as Rectype, ' );
              Add('P.partsId           as partsId , ' );
              Add('P.partname          as partname, ' );
              Add('P.Description       as SalesDescription, ' );
              Add('P.PURCHASEDESC      as PurchaseDescription, ' );
              Add('NULL                as UOM , ' );
              Add('NULL                as UnitID, ' );
              Add('Retailer.Price1     as RetailPRICE, ' );
              Add('P.WHOLESALEPRICE    as WHOLESALEPRICE, ' );
              Add('P.COST1             as COST1, ' );
              Add('P.COST2             as COST2, ' );
              Add('P.COST3             as COST3, ' );
              Add('P.COSTINC1          as COSTINC1, ' );
              Add('P.COSTINC2          as COSTINC2, ' );
              Add('P.COSTINC3          as COSTINC3,' );
              Add('P.PRICE1            as PRICE1  , ' );
              Add('P.PRICE2            as PRICE2,' );
              Add('P.PRICE3            as PRICE3, ' );
              Add('P.PRICEINC1         as PRICEINC1, ' );
              Add('P.PRICEINC2         as PRICEINC2, ' );
              Add('P.PRICEINC3         as PRICEINC3, ');
              Add('WholeSaler1.Price1  as WSP1, ' );
              Add('WholeSaler2.Price1  as WSP2, ' );
              Add('WholeSaler3.Price1  as WSP3, ' );
              Add('WholeSaler4.Price1  as WSP4, ' );
              Add('P.CUSTFLD1          as CustFld1, ' );
              Add('P.CUSTFLD2          as CustFld2, ' );
              Add('P.CUSTFLD3          as CustFld3, ' );
              Add('P.CUSTFLD4          as CustFld4, ' );
              Add('P.CUSTFLD5          as CustFld5, ' );
              Add('P.CUSTFLD6          as CustFld6, ' );
              Add('P.CUSTFLD7          as CustFld7, ' );
              Add('P.CUSTFLD8          as CustFld8, ' );
              Add('P.CUSTFLD9          as CustFld9, ' );
              Add('P.CUSTFLD10         as CustFld10, ' );
              Add('P.CUSTFLD11         as CustFld11, ' );
              Add('P.CUSTFLD12         as CustFld12, ' );
              Add('P.CUSTFLD13         as CustFld13, ' );
              Add('P.CUSTFLD14         as CustFld14, ' );
              Add('P.CUSTFLD15         as CustFld115, ' );
              Add('P.CUSTDATE1         as CustDate1, ' );
              Add('P.CUSTDATE2         as CustDate2, ' );
              Add('P.CUSTDATE3         as CustDate3, ' );
              Add('P.Active            as Active ' );
              Add('From tblParts P ' );
              Add('LEFT JOIN tblextrapricesell Retailer ON (IFNULL(Retailer.UOMID,0)=0 AND Retailer.PartsId = P.partsID) AND Retailer.ClientTypeID = '  + inttostr(getClientTypeID(Appenv.companyprefs.RetailcustomerType1)));
              Add('LEFT JOIN tblextrapricesell WholeSaler1 ON (IFNULL(WholeSaler1.UOMID,0)=0 AND WholeSaler1.PartsId = P.partsID) AND WholeSaler1.ClientTypeID = '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType1)));
              Add('LEFT JOIN tblextrapricesell WholeSaler2 ON (IFNULL(WholeSaler2.UOMID,0)=0 AND WholeSaler2.PartsId = P.partsID) AND WholeSaler2.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType2)));
              Add('LEFT JOIN tblextrapricesell WholeSaler3 ON (IFNULL(WholeSaler3.UOMID,0)=0 AND WholeSaler3.PartsId = P.partsID) AND WholeSaler3.ClientTypeID =   '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType3)));
              Add('LEFT JOIN tblextrapricesell WholeSaler4 ON (IFNULL(WholeSaler4.UOMID,0)=0 AND WholeSaler4.PartsId = P.partsID) AND WholeSaler4.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType4)));
              Add('where P.IsSystemProduct ="F" ' );
              Add('having  ifnull(RetailPRICE,0)<> 0 or ifnull(WSP1,0)<> 0  or ifnull(WSP2,0)<> 0  or ifnull(WSP3,0)<> 0  or ifnull(WSP4,0)<> 0  ' );
              Add('Order by Partname , UOM , rectype');
      end;
    finally
      Result := SQL.text;
      cLog(result);
    end;
  finally
    FreeandNil(st);
  end;
end;
procedure TProductPriceListGUI.RefreshQuery;
begin
  (*Qrymain.parambyname('RCT').asInteger  := getClientTypeID(Appenv.companyprefs.RetailcustomerType1);
  Qrymain.parambyname('WCT1').asInteger := getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType1);
  Qrymain.parambyname('WCT2').asInteger := getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType2);
  Qrymain.parambyname('WCT3').asInteger := getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType3);
  Qrymain.parambyname('WCT4').asInteger := getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType4);*)
  //Qrymain.parambyname('DefaultUOM').asString := appenv.defaultclass.DefaultUOM;
  inherited;
end;

procedure TProductPriceListGUI.SetGridColumns;
begin
  inherited;
    Showcontrolhint(btnchooseWholeSalers , 'Choose to set Wholesalers in the Company Preferences'+NL);
    RemoveFieldfromGrid(qryMainRecType.fieldname);
    RemoveFieldfromGrid(qryMainpartsId.fieldname);
    RemoveFieldfromGrid(qryMainunitId.fieldname);
    if Appenv.companyprefs.WholeSaleCustomerType1 = '' then (*RemoveFieldfromGrid(qryMainWSP1.fieldname) *)qryMainWSP1.DisplayLabel := '<Not Selected>' else qryMainWSP1.DisplayLabel := Appenv.companyprefs.WholeSaleCustomerType1;
    if Appenv.companyprefs.WholeSaleCustomerType2 = '' then (*RemoveFieldfromGrid(qryMainWSP2.fieldname) *)qryMainWSP2.DisplayLabel := '<Not Selected>' else qryMainWSP2.DisplayLabel := Appenv.companyprefs.WholeSaleCustomerType2;
    if Appenv.companyprefs.WholeSaleCustomerType3 = '' then (*RemoveFieldfromGrid(qryMainWSP3.fieldname) *)qryMainWSP3.DisplayLabel := '<Not Selected>' else qryMainWSP3.DisplayLabel := Appenv.companyprefs.WholeSaleCustomerType3;
    if Appenv.companyprefs.WholeSaleCustomerType4 = '' then (*RemoveFieldfromGrid(qryMainWSP4.fieldname) *)qryMainWSP4.DisplayLabel := '<Not Selected>' else qryMainWSP4.DisplayLabel := Appenv.companyprefs.WholeSaleCustomerType4;
    if (Appenv.companyprefs.WholeSaleCustomerType1 = '') or
       (Appenv.companyprefs.WholeSaleCustomerType2 = '') or
       (Appenv.companyprefs.WholeSaleCustomerType3 = '') or
       (Appenv.companyprefs.WholeSaleCustomerType4 = '') then begin
        Showcontrolhint(btnchooseWholeSalers , 'Wholesalers are Not Selected in the Company Preference.'+NL+'Please Choose to set them'+NL);
        ListtimerMsg('Wholesaler(s) are Not Selected in the Company Preference.  This is Causing ' + quotedstr('<Not Selected>')+' columns in the List Above.' + NL +
                    'Please Choose ' + quotedstr(btnchooseWholeSalers.caption ) +' at the Top for Preferences->Sales to Choose the Wholesalers.', btnchooseWholeSalers , 30);
    end;
  SetupCustomFields('Product');
end;

initialization
  RegisterClassOnce(TProductPriceListGUI);

end.
