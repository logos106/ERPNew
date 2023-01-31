unit SerialNumberListBatch;

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
  TSerialNumberListBatchGUI = class(TSerialNumbersGUI)
    mnuPopulateSerialNumberList: TMenuItem;
    N1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure mnuPopulateSerialNumberListClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
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
  AppEnvironment, tcConst, SyncReportTableObj, UserLockBaseObj;

{$R *.dfm}

procedure TSerialNumberListBatchGUI.CreateTemptable;
begin
  //inherited;
end;

function TSerialNumberListBatchGUI.ExpressDetailListName: String;
begin
  REsult := 'TSerialNumberListCurrentGUI'
end;

procedure TSerialNumberListBatchGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
  usingReportTables:=true;
end;

procedure TSerialNumberListBatchGUI.FormShow(Sender: TObject);
begin
  inherited;
  actdetails :=dtmMainGUI.actSerialNumbers;
  Showcontrolhint(btnExpressDetail ,btnExpressDetail.caption +NL+'This Report Will be Slower');

end;

procedure TSerialNumberListBatchGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qrymainglevel.asInteger = 4 then
    GreennFont(Afont);
end;

procedure TSerialNumberListBatchGUI.grpFiltersClick(Sender: TObject);
begin
  grpFilters.itemindex := 0;
  inherited;

end;

procedure TSerialNumberListBatchGUI.MakeQrymain;
begin
 //nherited;
  fsTableName := 'tblSerial_number_List_Available';
  CloseDB(Qrymain);
  Qrymain.sql.clear;
  Qrymain.sql.add('select');
  Qrymain.sql.add('P.partsID          as PArtsId,');
  Qrymain.sql.add('T.DepartmentID     as DepartmentID,');
  Qrymain.sql.add('T.UOMID            as UOMID,');
  Qrymain.sql.add('T.UOM              as UOM,');
  Qrymain.sql.add('T.UOMMultiplier    as UOMMultiplier ,');
  Qrymain.sql.add('0                  as gLevel,');
  Qrymain.sql.add('P.PARTNAME         as ProductName ,');
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
  Qrymain.sql.add('from tblSerial_number_List_Available T');
  Qrymain.sql.add('inner join tblparts P on P.partsId = T.productID');
  Qrymain.sql.add('inner join tblclass C on C.classid = T.DepartmentID');
  Qrymain.sql.add('inner join tblpqa pqa on pqa.PQAID = t.pqaid');
  Qrymain.sql.add('Left  join `tblpqatranstypes` as TT on TT.TransType = T.TransType');
  Qrymain.sql.add('Where (T.DepartmentId = :DepartmentId or :DepartmentId=0) and (T.ProductId = :ProductId or :ProductId=0) ');
  {Generated Serial numbers - for steel mains
  not allocated to any transaction yet }
  Qrymain.sql.add('Union all ');
(*  Qrymain.sql.add('SELECT distinct ');
  Qrymain.sql.add('P.PartsId              as PArtsId, ');
  Qrymain.sql.add('S.ClassId              as DepartmentID,');
  Qrymain.sql.add('0                      as UOMID, ');
  Qrymain.sql.add(Quotedstr(AppEnv.DefaultClass.DefaultUOM) +' as UOM,');
  Qrymain.sql.add('1                      as UOMMultiplier,');
  Qrymain.sql.add('P.PartName             as ProductName ,');
  Qrymain.sql.add('4                      as gLevel, ');
  Qrymain.sql.add(FirstColumn  +        ' as ProductColumn1,');
  Qrymain.sql.add(Secondcolumn +        ' as ProductColumn2,');
  Qrymain.sql.add(Thirdcolumn  +        ' as ProductColumn3,');
  Qrymain.sql.add('PartsDescription       as PartsDescription,');
  Qrymain.sql.add('S.ClassName            as ClassName ,');
  Qrymain.sql.add('null                   as Batchnumber,');
  Qrymain.sql.add('null                   as TruckLoadNo,');
  Qrymain.sql.add('null                   as cBatchExpiryDate , ');
  Qrymain.sql.add('NULL                   as BatchExpiryDate,');
  Qrymain.sql.add('null                   as binLocation,');
  Qrymain.sql.add('null                   as Binnumber,');
  Qrymain.sql.add('SerialNo               as serialnumber,');
  Qrymain.sql.add('null                   as DEscription,');
  Qrymain.sql.add('null                   as Transdate,');
  Qrymain.sql.add('null                   as BOMSerialnumber,');
  Qrymain.sql.add('"New"                  as allocType');
  Qrymain.sql.add('FROM tblSerialnumbers S');
  Qrymain.sql.add('Left join tblParts P on P.PartsId = S.ProductID');
  Qrymain.sql.add('left join tblpqa pqa on pqa.productId = S.ProductID and pqa.DepartmentID = S.classId');
  Qrymain.sql.add('Left join tblPQADetails pqad on pqa.pqaid = pqad.pqaid and  pqad.PQAType = ' +quotedStr(TPQASN.PQADetailType)+' and pqad.value = S.Serialno ');
  Qrymain.sql.add('Where  pqad.pqadetailid is null');
  //Qrymain.sql.add('and Serialno not in (Select Value from tblPQADetails where PQAType = ' +quotedStr(TPQASN.PQADetailType)+' and productId = P.PartsID)');
  Qrymain.sql.add('and (S.ClassId = :DepartmentId or :DepartmentId=0) ');
  Qrymain.sql.add('and (S.ProductID = :ProductId or :ProductId=0) ');*)
  Qrymain.SQL.Add(SerialJonNumeberListSQL(True,true, true, 0 ));
  Qrymain.sql.add('Order by ProductName, ClassName , serialnumber');


end;

procedure TSerialNumberListBatchGUI.mnuPopulateSerialNumberListClick(Sender: TObject);
begin
  inherited;
    if Userlock.Lock('tblSerial_number_List' ,0) then begin
      ProcessingCursor(True);
      try
          showProgressbar(WAITMSG, 3);
          try
            stepProgressbar;
                try
                    SyncReportObj.DosyncSerialnumberlist;
                    Userlock.UnLock('tblSerial_number_List');
                Except
                  on E:Exception do begin
                    if Pos('Lock wait timeout',E.message) > 0 then MessageDlgXP_Vista('Tables Are Locked, You Cannot Populate the Serial Number List.', mtWarning, [mbOK], 0)
                    else MessageDlgXP_Vista('Error Occured, Please Contact ERP'+NL+E.message, mtWarning, [mbOK], 0);
                  end;
                end;
          finally
            HideProgressbar;
          end;
      finally
        ProcessingCursor(False);
      end;
    end else begin
      MessageDlgXP_Vista(CustomiseLockMessage(Userlock.LockMessage , ['Unable to update data.' ,'accessing this record','Record has been in use'],
                                                                     ['Unable to Run the Serial Number List.', 'Running the List','Record has been running']),
                                                  mtWarning, [mbOK], 0);
    end;
end;

procedure TSerialNumberListBatchGUI.RefreshQuery;
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

function TSerialNumberListBatchGUI.ReportTableUpdatedtime(lineBreak: Boolean): String;
begin
  Result :=iif(lineBreak , 'Data on This Report is'+NL ,  '     -    ') +
          'Based on Serial Number List Table Last Updated On ' +iif(lineBreak , NL , '') +
          quotedstr(FormatDateTime('dddd, mmmm d, yyyy, " at " hh:mm AM/PM',AppEnv.CompanyPrefs.SerialNumberListUpdatedOn));
end;

initialization
  RegisterClassOnce(TSerialNumberListBatchGUI);

end.
