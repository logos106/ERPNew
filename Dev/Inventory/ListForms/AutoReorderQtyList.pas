unit AutoReorderQtyList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TAutoReorderQtyListGUI = class(TBaseListingGUI)
    qryMainProductID: TIntegerField;
    qryMainPREFEREDSUPP: TWideStringField;
    qryMainPURCHTAXCODE: TWideStringField;
    qryMainClassID: TIntegerField;
    qryMainReorderAmount: TFloatField;
    qryMainReOrderPoint: TFloatField;
    qryMainPreferredLevel: TFloatField;
    qryMainUseproductforecastformula: TWideStringField;
    qryMainQty1: TFloatField;
    qryMainQty2: TFloatField;
    qryMainQty3: TFloatField;
    qryMainQty4: TFloatField;
    qryMainProductname: TWideStringField;
    qryMainClassname: TWideStringField;
    DNMPanel1: TDNMPanel;
    chkshowProductsToBeOrdered: TCheckBox;
    DNMPanel2: TDNMPanel;
    lblExplainfilter: TLabel;
    qryMainQty5: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure chkshowProductsToBeOrderedClick(Sender: TObject);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
  private
    fsPreferredSupp: String;
    fsTempTablename: String;
    ficlassId: Integer;
    fiBasesonitemIndex: Integer;
    function Productcount: Integer;
  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery;Override;
    Property TempTablename      : String  read fsTempTablename    write fsTempTablename;
    Property classId            : Integer read ficlassId          write ficlassId;
    Property PreferredSupp      : String  read fsPreferredSupp    write fsPreferredSupp;
    Property BasesonitemIndex   : Integer read fiBasesonitemIndex write fiBasesonitemIndex;
  end;


implementation

uses CommonLib, ReorderLib, tcConst, AppEnvironment, DbSharedObjectsObj,
  tcDataUtils, CommonDbLib;

{$R *.dfm}
{ TAutoReorderQtyListGUI }

procedure TAutoReorderQtyListGUI.chkshowProductsToBeOrderedClick(
  Sender: TObject);
begin
  inherited;
  Qrymain.filtered := chkshowProductsToBeOrdered.checked;
end;

procedure TAutoReorderQtyListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TAutoReorderQtyListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if sametext(field.fieldname , qryMainQty1.fieldname) or
     sametext(field.fieldname , qryMainQty2.fieldname) or
     sametext(field.fieldname , qryMainQty3.fieldname) or
     sametext(field.fieldname , qryMainQty4.fieldname) or
     sametext(field.fieldname , qryMainQty5.fieldname) then ABrush.color := GridColhighLightYellow1;
  if not Qrymain.filtered then begin
    if (fiBasesonitemIndex =0)and (qryMainQty1.asFloat < iif(qrymainreorderpoint.asFloat>qrymainPreferredLevel.asFloat , Qrymainreorderpoint.asfloat , qrymainPreferredLevel.asFloat)) then ABrush.color := GridColhighLightGreen ;
    if (fiBasesonitemIndex =1)and (qryMainQty2.asFloat < iif(qrymainreorderpoint.asFloat>qrymainPreferredLevel.asFloat , Qrymainreorderpoint.asfloat , qrymainPreferredLevel.asFloat)) then ABrush.color := GridColhighLightGreen ;
    if (fiBasesonitemIndex =2)and (qryMainQty3.asFloat < iif(qrymainreorderpoint.asFloat>qrymainPreferredLevel.asFloat , Qrymainreorderpoint.asfloat , qrymainPreferredLevel.asFloat)) then ABrush.color := GridColhighLightGreen ;
    if (fiBasesonitemIndex =3)and (qryMainQty4.asFloat < iif(qrymainreorderpoint.asFloat>qrymainPreferredLevel.asFloat , Qrymainreorderpoint.asfloat , qrymainPreferredLevel.asFloat)) then ABrush.color := GridColhighLightGreen ;
    if (fiBasesonitemIndex =4)and (qryMainQty5.asFloat < iif(qrymainreorderpoint.asFloat>qrymainPreferredLevel.asFloat , Qrymainreorderpoint.asfloat , qrymainPreferredLevel.asFloat)) then ABrush.color := GridColhighLightGreen ;
  end;
end;

procedure TAutoReorderQtyListGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
    if (fiBasesonitemIndex =0) then Qrymain.filter := '(' +qryMainQty1.fieldname +' < ' + qrymainreorderpoint.fieldname +' and ' + qrymainreorderpoint.fieldname +'>0 ) or (' + qryMainQty1.fieldname +' < ' + qrymainPreferredLevel.fieldname+'  and ' + qrymainreorderpoint.fieldname +'>0 )';
    if (fiBasesonitemIndex =1) then Qrymain.filter := '(' +qryMainQty2.fieldname +' < ' + qrymainreorderpoint.fieldname +' and ' + qrymainreorderpoint.fieldname +'>0 ) or (' + qryMainQty2.fieldname +' < ' + qrymainPreferredLevel.fieldname+'  and ' + qrymainreorderpoint.fieldname +'>0 )';
    if (fiBasesonitemIndex =2) then Qrymain.filter := '(' +qryMainQty3.fieldname +' < ' + qrymainreorderpoint.fieldname +' and ' + qrymainreorderpoint.fieldname +'>0 ) or (' + qryMainQty3.fieldname +' < ' + qrymainPreferredLevel.fieldname+'  and ' + qrymainreorderpoint.fieldname +'>0 )';
    if (fiBasesonitemIndex =3) then Qrymain.filter := '(' +qryMainQty4.fieldname +' < ' + qrymainreorderpoint.fieldname +' and ' + qrymainreorderpoint.fieldname +'>0 ) or (' + qryMainQty4.fieldname +' < ' + qrymainPreferredLevel.fieldname+'  and ' + qrymainreorderpoint.fieldname +'>0 )';
    if (fiBasesonitemIndex =4) then Qrymain.filter := '(' +qryMainQty5.fieldname +' < ' + qrymainreorderpoint.fieldname +' and ' + qrymainreorderpoint.fieldname +'>0 ) or (' + qryMainQty5.fieldname +' < ' + qrymainPreferredLevel.fieldname+'  and ' + qrymainreorderpoint.fieldname +'>0 )';
    Qrymain.filtered := chkshowProductsToBeOrdered.checked;
    lblExplainfilter.caption := '';
         if fiBasesonitemIndex =0 then lblExplainfilter.caption  := lblExplainfilter.caption  + NL + 'Based On = Instock'
    else if fiBasesonitemIndex =1 then lblExplainfilter.caption  := lblExplainfilter.caption  + NL + 'Based On = Available'
    else if fiBasesonitemIndex =2 then lblExplainfilter.caption  := lblExplainfilter.caption  + NL + 'Based On = Available - SOBO'
    else if fiBasesonitemIndex =3 then lblExplainfilter.caption  := lblExplainfilter.caption  + NL + 'Based On = Instock _ Internal SOBO'
    else if fiBasesonitemIndex =4 then lblExplainfilter.caption  := lblExplainfilter.caption  + NL + 'Based On = Available _ Internal SO';
    if classId <> 0 then               lblExplainfilter.caption  := lblExplainfilter.caption  + NL + Appenv.defaultClass.classheading +' =' +quotedstr(getclassname(classID));
    if fsPreferredSupp <> '' then lblExplainfilter.caption  := lblExplainfilter.caption  + NL + 'Prefered Supplier = ' +quotedstr(fsPreferredSupp);
    if TempTablename <> ''   then lblExplainfilter.caption  := lblExplainfilter.caption  + NL + 'Products Selected = ' + inttostr(Productcount);
    lblExplainfilter.caption := Trim(lblExplainfilter.caption);
end;
Function TAutoReorderQtyListGUI.Productcount :Integer;
var
  qry: TERPQuery;
begin
  result := 0;
  if TempTablename='' then exit;

  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.sql.text := 'Select count(*) ctr from ' + TempTablename;
    qry.open;
    result := qry.fieldbyname('ctr').asInteger;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
procedure TAutoReorderQtyListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
    if GuiPrefs.Node.Exists('Options.showProductsToBeOrdered') then
      chkshowProductsToBeOrdered.checked:=  GuiPrefs.Node['Options.showProductsToBeOrdered'].asBoolean;
end;

procedure TAutoReorderQtyListGUI.RefreshQuery;
begin
  ReorderLib.MakeQryParts( Qrymain ,TempTablename , -1,ClassId, PreferredSupp);
  inherited;
end;

procedure TAutoReorderQtyListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.showProductsToBeOrdered'].asBoolean := chkshowProductsToBeOrdered.checked;
end;

initialization
  RegisterClassOnce(TAutoReorderQtyListGUI);

end.
