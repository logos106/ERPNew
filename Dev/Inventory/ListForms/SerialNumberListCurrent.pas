unit SerialNumberListCurrent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel,SerialNumbers, dmMainGUI,
  SerialNumberListCurrentSQL;

type
  TSerialNumberListCurrentGUI = class(TSerialNumbersGUI)
    tmrSP: TTimer;
    Qry_SN_Ctr: TERPQuery;
    procedure FormCreate(Sender: TObject);
    procedure mnuPopulateSerialNumberListClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SctMainError(Sender: TObject; E: Exception; SQL: string;
      var Action: TErrorAction);
    procedure FormDestroy(Sender: TObject);
  private
    ReportSQL: TSerialNumberListCurrentReport;
    procedure onUpdateSerialnoListProgress(Sender: TObject);
    function DeptCount: Integer;
  Protected
    procedure CreateTemptable;Override;
    Procedure MakeQrymain;Override;
    Function ExpressDetailListName:String;Override;
    function ReportTableUpdatedtime(lineBreak:Boolean =False): String; Override;
    procedure OnProductSelection(Sender:TObject);Override;
    procedure OnClassSelection(Sender:TObject);Override;
  public

  end;

implementation

uses Barcodeconst, CommonDbLib, LogLib, PQALib, ProductQtyLib, CommonLib,
  AppEnvironment, tcConst, SyncReportTableObj, MySQLConst, UserLockBaseObj,
  DbSharedObjectsObj, ThreadGUIScript;

{$R *.dfm}

procedure TSerialNumberListCurrentGUI.CreateTemptable;
begin
  if fsTablename = '' then exit;
  clog(fsTablename);
  if Userlock.Lock(iif(fsTablename='', 'tblSerial_number_List' , ''),0) then begin
     try
          With Scriptmain do begin
              SQL.clear;
              if IsLimit0selection  then else begin
                SQL.add('call Update_Serial_Number_List();');
              end;
              doshowProgressbar(DeptCount, iif(not(DEvmode), 'This May Take Several Minutes.','Started at ' +formatdatetime(shortdateformat +' :hh:nn:ss am/pm', now)));
              try
                    try
                      clog(formatDateTime('dd-mm-yy hh:nn:ss' , now));
                      ExecScriptThread(sctmain.SQL.text,onUpdateSerialnoListProgress, False, 1000);
                      logtext(formatDateTime('dd-mm-yy hh:nn:ss' , now));
                    Except
                      on E:Exception do begin
                        if Pos('Lock wait timeout',E.message) > 0 then begin
                          MessageDlgXP_Vista('Somebody is processing a Serial number Right Now.  So this report is locked.  Opening the Available Serial Number List ', mtWarning, [mbOK], 0);
                        end else MessageDlgXP_Vista('Error Occured, Please Contact ERP'+NL+E.message, mtWarning, [mbOK], 0);
                      end;
                    end;
              finally
                  dohideprogressbar;
              end;
              grpFiltersClick(grpFilters);
          end;
     finally
       AppEnv.UtilsClient.DeleteServerFiles('tmp_SNL_pqa*.tmp');
     end;
     Userlock.UnLock(iif(fsTablename='', 'tblSerial_number_List' , ''));
  end else begin
    MessageDlgXP_Vista(CustomiseLockMessage(Userlock.LockMessage , ['Unable to update data.' ,'accessing this record','Record has been in use'],
                                                                   ['Unable to Run the Serial Number List.', 'Running the List''Record has been running']),
                                                mtWarning, [mbOK], 0);
  end;
end;

function TSerialNumberListCurrentGUI.ExpressDetailListName: String;
begin
  REsult := 'TSerialNumberListBatchGUI' ;

end;

procedure TSerialNumberListCurrentGUI.FormCreate(Sender: TObject);
begin
  ShowcontrolHint(Self,'Serial Number List is Re-Populated by Scanning Entire Stock in the '+NL+
                      '"Midnight Update"   OR   "Refreshing the Closing Dates" from Preferences.'+NL+NL+
                      'Refreshing this List will only Check for Serialnumbers Allocated Since Last Update of the List.');
  ReportSQL := TSerialNumberListCurrentReport.Create;
  inherited;
  HaveDateRangeSelection := False;
  tmrSP.enabled := False;
end;

procedure TSerialNumberListCurrentGUI.FormDestroy(Sender: TObject);
begin
  //DestroyUserTemporaryTable(fsTablename);
  //ExecuteSQL('Delete from tblUpdateSerialnumberHistory where tablename =' + quotedstr(fsTablename)+';');
  ReportSQL.Free;
  inherited;
end;

procedure TSerialNumberListCurrentGUI.FormShow(Sender: TObject);
begin
  inherited;
  Showcontrolhint(btnExpressDetail ,btnExpressDetail.caption +NL+'This Report Will be Faster');

end;

procedure TSerialNumberListCurrentGUI.MakeQrymain;
var
  msg: string;
begin
 //nherited;
(*  ExecuteSQL('Drop table if exists '+fstablename +';' +
            ' CREATE TABLE '+ fstablename +'  like tblSerial_number_List;');*)
  fsTableName := ReportSQL.TempTableName; //   'tblSerial_number_List';
  CloseDB(Qrymain);
  ReportSQL.PopulateReportSQL(qryMain.SQL,msg);
//  Qrymain.sql.clear;
//  Qrymain.sql.add('select');
//  Qrymain.sql.add('P.partsID          as PArtsId,');
//  Qrymain.sql.add('T.DepartmentID     as DepartmentID,');
//  Qrymain.sql.add('T.UOMID            as UOMID,');
//  Qrymain.sql.add('UOM.UnitName       as UOM,');
//  Qrymain.sql.add('UOM.Multiplier     as UOMMultiplier ,');
//  Qrymain.sql.add('P.PARTNAME         as ProductName ,');
//  Qrymain.sql.add('0                  as gLevel,');
//  Qrymain.sql.add(Firstcolumn + '     as ProductColumn1,');
//  Qrymain.sql.add(Secondcolumn + '    as ProductColumn2,');
//  Qrymain.sql.add(Thirdcolumn + '     as ProductColumn3,');
//  Qrymain.sql.add('P.PARTSDESCRIPTION as PartsDescription,');
//  Qrymain.sql.add('C.classname        as classname,');
//  Qrymain.sql.add('T.Batchnumber      as Batchnumber ,');
//  Qrymain.sql.add('T.TruckLoadNo      as TruckLoadNo ,');
//  Qrymain.sql.add('DATE_FORMAT(T.Expirydate , ' + QuotedStr('%d/%m/%Y') +') as cBatchExpiryDate ,');
//  Qrymain.sql.add('T.Expirydate       as BatchExpiryDate ,');
//  Qrymain.sql.add('T.binLocation      as binLocation,');
//  Qrymain.sql.add('T.Binnumber        as Binnumber,');
//  Qrymain.sql.add('T.serialnumber     as serialnumber,');
//  Qrymain.sql.add('TT.DEscription     as DEscription,');
//  Qrymain.sql.add('PQA.Transdate      as Transdate,');
//  Qrymain.SQL.add('concat(' +Quotedstr(Barcode_Prefix_PQASN)+',''-'' ,P.PartsId,''-'' ,T.Serialnumber) as BOMSerialnumber , ');
//  Qrymain.sql.add('T.status           as allocType');
//  Qrymain.sql.add(' from '+fsTablename+' T');
//  //Qrymain.sql.add(' from tblSerial_number_List T');
//  Qrymain.sql.add(' inner join tblunitsofmeasure UOM on T.uomid = UOM.UnitID');
//  Qrymain.sql.add(' inner join tblparts P on P.partsId = T.productID');
//  Qrymain.sql.add('inner join tblclass C on C.classid = T.DepartmentID');
//  Qrymain.sql.add('inner join tblpqa pqa on pqa.PQAID = t.pqaid');
//  Qrymain.sql.add('Left  join `tblpqatranstypes` as TT on TT.TransType = T.TransType');
//  Qrymain.SQL.add('Order by Serialnumber');
end;

procedure TSerialNumberListCurrentGUI.mnuPopulateSerialNumberListClick(Sender: TObject);
begin
  inherited;
  ProcessingCursor(True);
  try
      showProgressbar(WAITMSG, 3);
      try
        stepProgressbar;
            try
              if Userlock.Lock('tblSerial_number_List' ,0) then begin
                SyncReportObj.DosyncSerialnumberlist;
                Userlock.UnLock('tblSerial_number_List');
              end else begin
                MessageDlgXP_Vista(CustomiseLockMessage(Userlock.LockMessage , ['Unable to update data.' ,'accessing this record','Record has been in use'],
                                                                               ['Unable to Run the Serial Number List.', 'Running the List''Record has been running']),
                                                            mtWarning, [mbOK], 0);
              end;
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

  end;


procedure TSerialNumberListCurrentGUI.OnClassSelection(Sender: TObject);
begin
  inherited;
  // delete the updateserialnumber history as the product selection is changed
  //ExecuteSQL('Delete from tblUpdateSerialnumberHistory where tablename =' + quotedstr(fsTablename)+';');
end;

procedure TSerialNumberListCurrentGUI.OnProductSelection(Sender: TObject);
begin
  inherited;
  // delete the updateserialnumber history as the product selection is changed
  //ExecuteSQL('Delete from tblUpdateSerialnumberHistory where tablename =' + quotedstr(fsTablename)+';');
end;

function TSerialNumberListCurrentGUI.ReportTableUpdatedtime(lineBreak: Boolean): String;
begin
  Result :=iif(lineBreak , 'Data on This Report is'+NL ,  '     -    ') +
          'Based on Serial Number List Table Last Updated On ' +iif(lineBreak , NL , '') +
          quotedstr(FormatDateTime('dddd, mmmm d, yyyy, " at " hh:mm AM/PM',AppEnv.CompanyPrefs.SerialNumberListUpdatedOn));
end;


procedure TSerialNumberListCurrentGUI.SctMainError(Sender: TObject;  E: Exception; SQL: string; var Action: TErrorAction);
begin
    if Pos('Lock wait timeout',E.message) > 0 then MessageDlgXP_Vista('Tables Are Locked, You Cannot Run This Report at the Moment', mtWarning, [mbOK], 0)
    else inherited;
end;
Function TSerialNumberListCurrentGUI.DeptCount:Integer;
begin
  try
    Closedb(Qry_SN_Ctr);
    opendb(Qry_SN_Ctr);
    REsult := Qry_SN_Ctr.fieldbyname('Total').asInteger;
  Except
    on E:Exception do begin
      REsult := 10;
    end;
  end;
end;
procedure TSerialNumberListCurrentGUI.onUpdateSerialnoListProgress(Sender: TObject);
begin
try
  Closedb(Qry_SN_Ctr);
  opendb(Qry_SN_Ctr);
  stepProgressbar( 'Checking ' +
                    Quotedstr(Qry_SN_Ctr.fieldbyname('classname').asString) +'.....' +  inttostr(Qry_SN_Ctr.fieldbyname('Done').asInteger)+' of ' +inttostr(Qry_SN_Ctr.fieldbyname('Total').asInteger)+
                    iif(devmode, '(' + Qry_SN_Ctr.fieldbyname('updateserialnumberlistlog').asString +')' , ''));
Except
  on E:Exception do begin
    stepProgressbar;
  end;
end;
end;

initialization
  RegisterClassOnce(TSerialNumberListCurrentGUI);

end.
