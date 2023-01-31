unit SerialNumberList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel,SerialNumbers, dmMainGUI;

type
  TSerialNumberListGUI = class(TSerialNumbersGUI)
    mnuPopulateSerialNumberList: TMenuItem;
    N1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure mnuPopulateSerialNumberListClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);
  private
  Protected
    procedure CreateTemptable;Override;
    Procedure MakeQrymain;Override;
    Function ExpressDetailListName:String;Override;
    function ReportTableUpdatedtime(lineBreak:Boolean =False): String; Override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses Barcodeconst, CommonDbLib, LogLib, PQALib, ProductQtyLib, CommonLib,
  AppEnvironment, tcConst, SyncReportTableObj;

{$R *.dfm}

procedure TSerialNumberListGUI.CreateTemptable;
begin
  //inherited;
end;

function TSerialNumberListGUI.ExpressDetailListName: String;
begin
  REsult := 'TSerialNumbersGUI'
end;

procedure TSerialNumberListGUI.FormCreate(Sender: TObject);
begin
  HaveDateRangeSelection := False;
  inherited;
  usingReportTables:=true;
end;

procedure TSerialNumberListGUI.FormShow(Sender: TObject);
begin
  inherited;
  Showcontrolhint(btnExpressDetail ,btnExpressDetail.caption +NL+'This Report Will be Slower');

end;

procedure TSerialNumberListGUI.grpFiltersClick(Sender: TObject);
begin
  grpFilters.itemindex := 0;
  inherited;

end;

procedure TSerialNumberListGUI.MakeQrymain;
begin
 //nherited;
  CloseDB(Qrymain);
  Qrymain.sql.clear;
  Qrymain.sql.add('select');
  Qrymain.sql.add('P.partsID          as PArtsId,');
  Qrymain.sql.add('T.DepartmentID     as DepartmentID,');
  Qrymain.sql.add('T.UOMID            as UOMID,');
  Qrymain.sql.add('UOM.UnitName       as UOM,');
  Qrymain.sql.add('UOM.Multiplier     as UOMMultiplier ,');
  Qrymain.sql.add('P.PARTNAME         as ProductName ,');
  Qrymain.sql.add('0                  as gLevel,');
  Qrymain.sql.add(Firstcolumn + '     as ProductColumn1,');
  Qrymain.sql.add(Secondcolumn + '    as ProductColumn2,');
  Qrymain.sql.add(Thirdcolumn + '     as ProductColumn3,');
  Qrymain.sql.add('P.PARTSDESCRIPTION as PartsDescription,');
  Qrymain.sql.add('C.classname        as classname,');
  Qrymain.sql.add('T.Batchnumber      as Batchnumber ,');
  Qrymain.sql.add('T.TruckLoadNo      as TruckLoadNo ,');
  Qrymain.sql.add('DATE_FORMAT(T.Expirydate , ' + QuotedStr('%d/%m/%Y') +') as cBatchExpiryDate ,');
  Qrymain.sql.add('T.Expirydate       as BatchExpiryDate ,');
  Qrymain.sql.add('T.binLocation      as binLocation,');
  Qrymain.sql.add('T.Binnumber        as Binnumber,');
  Qrymain.sql.add('T.serialnumber     as serialnumber,');
  Qrymain.sql.add('TT.DEscription     as DEscription,');
  Qrymain.sql.add('PQA.Transdate      as Transdate,');
  Qrymain.SQL.add('concat(' +Quotedstr(Barcode_Prefix_PQASN)+',''-'' ,P.PartsId,''-'' ,T.Serialnumber) as BOMSerialnumber , ');
  Qrymain.sql.add('T.status           as allocType');
  Qrymain.sql.add(' from tblSerialnumberList_Available T');
  Qrymain.sql.add(' inner join tblunitsofmeasure UOM on T.uomid = UOM.UnitID');
  Qrymain.sql.add(' inner join tblparts P on P.partsId = T.productID');
  Qrymain.sql.add('inner join tblclass C on C.classid = T.DepartmentID');
  Qrymain.sql.add('inner join tblpqa pqa on pqa.PQAID = t.pqaid');
  Qrymain.sql.add('Left  join `tblpqatranstypes` as TT on TT.TransType = T.TransType');
  Qrymain.sql.add('Where (T.DepartmentId = :DepartmentId or :DepartmentId=0) ');
  Qrymain.sql.add('and (T.ProductId = :ProductId or :ProductId=0) ');
end;

procedure TSerialNumberListGUI.mnuPopulateSerialNumberListClick(Sender: TObject);
begin
  inherited;
  showProgressbar(WAITMSG, 3);
  try
    stepProgressbar;
    SyncReportObj.DosyncSerialnumberlist;
  finally
    HideProgressbar;
  end;
end;

procedure TSerialNumberListGUI.RefreshQuery;
begin
  showProgressbar(WAITMSG, 3);
  try
    stepProgressbar;
    grpFilters.itemindex := 0;
    Qrymain.parambyname('DepartmentId').asInteger := SelectedClasSId;
    Qrymain.parambyname('ProductId').asInteger := SelectedProductId;
    inherited;
  finally
    HideProgressbar;
  end;
end;

function TSerialNumberListGUI.ReportTableUpdatedtime(lineBreak: Boolean): String;
begin
  Result :=iif(lineBreak , 'Data on This Report is'+NL ,  '     -    ') +
          'Based on Serial Number List Table Last Updated On ' +iif(lineBreak , NL , '') +
          quotedstr(FormatDateTime('dddd, mmmm d, yyyy, " at " hh:mm AM/PM',AppEnv.CompanyPrefs.SerialNumberListUpdatedOn));
end;

initialization
  RegisterClassOnce(TSerialNumberListGUI);

end.
