unit frmBinUsageReportGUI;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 06/12/05  1.00.01  AL  Initial Version
 07/12/05  1.00.02  AL  Added progressDialog, dates ranges checking, cbAll checkbox
 08/12/05  1.00.03  AL  Open an Invoice form with calculated ammount for selected department
 04/05/06  1.00.05  BJ  Defualt department is displayed in the department combo
                        as a defualt selection
                        BinLocation and Binnumber identifies the Bin, the report was showing only
                        the BinNumber, so added the binLocation to the Grid
 }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DateUtils,  wwdblook, DBCtrls, forms,
  MyScript, DAScript,  Shader, kbmMemTable, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TfrmBinUsageReport = class(TBaseListingGUI)
    qryMainDetails: TIntegerField;
    qryMainDt: TDateTimefield;
    qryMainDepartmentName: TWideStringField;
    qryMainBinLocation: TWideStringField;
    qryMainBinNumber: TWideStringField;
    qryMainDaysUsed: TLargeintField;
    qryMainProductID: TLargeintField;
    qryMaininstock: TFloatField;
    qryMainAvailable: TFloatField;
    qryMaintranstype: TWideStringField;
    qryMainUsage: TFloatField;
    qryMainUsagedesc: TWideStringField;
    qryMainProductName: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
  private
    fsTablename :STring;
    fiBinID: Integer;
    procedure RebuildTempTable;
    Function GetBinQty(ClassID:Integer=0):String;
    procedure MakeQrymain;


    { Private declarations }
  protected
    procedure RefreshQuery; override;
    function DoDtFromChange(Sender:Tobject): boolean; override;
    function DoDtToChange(Sender: TObject): boolean; override;
    procedure SetGridColumns; override;
  public
    Property BinID:Integer read fiBinID write fiBinID;
  end;

implementation

uses pqalib,CommonDBLib, frmInvoice,   CommonLib,
   Preferences, AppEnvironment, FastFuncs, MySQLConst, ProductQtyLib,
  StockQtysLocationsReport, PreferenceLib, LogLib;

{$R *.dfm}

procedure TfrmBinUsageReport.RebuildTempTable;
var
    i :Integer;
    fStringList :TStringList;
    BinUsageTmpTablename2 , BinUsageTmpTablename3:String;
begin
  if dtTo.Date > Today then dtTo.Date := Today;
  if DaysBetween(dtFrom.Date, dtto.Date) < 0 then Exit;

  Processingcursor(True);
  try
    qryMain.Close;

    BinUsageTmpTablename2 := GetUserTemporaryTableName('BinUsageReport_2');
    BinUsageTmpTablename3 := GetUserTemporaryTableName('BinUsageReport_3');
    fStringList :=TStringList.Create;
    try
      fStringList.add('drop table if exists  ' + fsTablename+';');
      fStringList.add('drop table if exists ' + BinUsageTmpTablename2+';');
      fStringList.add('CREATE TABLE ' + BinUsageTmpTablename2);
      fStringList.add(GetBinQty(SelectedClassId)+';');
      fStringList.add('update '+ BinUsageTmpTablename2 +' Set Volume = 1 where ifnull(Volume,0)=0;');


      fStringList.add('drop table if exists ' + BinUsageTmpTablename3+';');
      fStringList.add('Create table ' + BinUsageTmpTablename3+' Select BinId, DT, sum(instock ) as instock, sum(Available ) as Available  from ' + BinUsageTmpTablename2+' group by binId, DT;');
      fStringList.add('Alter table   ' + BinUsageTmpTablename3 + ' ADD COLUMN `recid` int(11) NULL AUTO_INCREMENT , ADD PRIMARY KEY(`recid`);');

      fStringList.add('Create table ' + fsTablename +
              ' SELECT distinct 1 as DEtails, PB.binID, PB.BinLocation, PB.BinNumber,PB.ClassID, ' + quotedstr(FormatDatetime(mySQLDateformat , filterDateTo))+' as DT,  ' +
              ' convert(NULL, CHAR(255)) as TransType,  CONVERT( null ,UNSIGNED) ProductID,  ' +
              ' C.ClassName, ' +
              '(Select count(Distinct date(T.DT)) from   ' +BinUsageTmpTablename3 + ' T '+
                                      ' where tmp.binID = T.binID and  '+
                                      ' T.DT between ' + Quotedstr(FormatDateTime(mysqldateTimeformat , filterDatefrom)) +' and ' +  Quotedstr(FormatDateTime(mysqldateTimeformat , filterDateTo)) +') as DaysUsed, ' +
              ' sum(tmp.instock) as instock,' +
              ' sum(tmp.Available) as Available' +
              ' FROM  tblProductBin PB  '+
              ' INNER JOIN tblClass C ON C.ClassID = PB.ClassID ' +
              ' inner join ' +BinUsageTmpTablename3 + ' tmp   ' +
              ' on tmp.binId = PB.BinID and (ifnull(tmp.instock,0) <> 0  or ifnull(tmp.Available,0) <> 0 ) ' +
              ' group by PB.binID, PB.BinLocation, PB.BinNumber,PB.ClassID, C.ClassName '+';') ;

      if grpfilters.itemindex = 1 then
        fStringList.add('insert ignore into  ' + fsTablename +
                ' SELECT 2 as DEtails, PB.binID, PB.BinLocation, PB.BinNumber,PB.ClassID, DT, TransType,   CONVERT( tmp.ProductID,UNSIGNED) ProductID,  ' +
                ' C.ClassName, null as  DaysUsed, tmp.instock as instock, tmp.Available as Available' +
                ' FROM  tblProductBin PB  '+
                ' INNER JOIN tblClass C ON C.ClassID = PB.ClassID ' +
                ' inner join ' +BinUsageTmpTablename2 + ' tmp   ' +
                ' on tmp.binId = PB.BinID and (ifnull(tmp.instock,0) <> 0 or ifnull(tmp.Available,0) <> 0 ) ;') ;

      fStringList.add('drop table if exists ' + BinUsageTmpTablename3+';');
      fStringList.add('drop table if exists ' + BinUsageTmpTablename2+';');
    finally
      With Scriptmain do begin
        SQL.clear;
        SQL.add(fStringList.text);
        clog(SQL.text);
        Execute;
      end;
    end;
  finally
     Processingcursor(False);
  end;
end;

procedure TfrmBinUsageReport.RefreshQuery;
begin
  RebuildTempTable;
  inherited;
end;

procedure TfrmBinUsageReport.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymaindetails.fieldname);
  RemoveFieldfromGrid(qrymainProductID.fieldname);
end;

function TfrmBinUsageReport.DoDtToChange(Sender:TObject): boolean;
begin
  result:= true;
  if dtTo.Date > Today then begin
    CommonLib.MessageDlgXP_Vista('date "To" cant''t be bigger than Today!', mtWarning, [mbOK], 0);
    dtTo.Date := Today;
  end;
  inherited;
end;

function TfrmBinUsageReport.DoDtFromChange(Sender:TObject): boolean;
begin
  inherited;
end;



Procedure TfrmBinUsageReport.MakeQrymain;
begin
  fsTablename := GetUserTemporaryTableName('BinUsageReport_1');
  qryMain.SQL.clear;
  qryMain.SQL.add(' SELECT ');
  qryMain.SQL.add(' T.Details as Details, ');
  qryMain.SQL.add(' convert(T.Dt, datetime) as Dt, ');
  qryMain.SQL.add(' T.ProductId as ProductID, ');
  qryMain.SQL.add(' T.ClassName "DepartmentName",');
  qryMain.SQL.add(' T.BinLocation "BinLocation" ,  ');
  qryMain.SQL.add(' T.BinNumber "BinNumber" , ');
  qryMain.SQL.add(' CONVERT( T.DaysUsed ,UNSIGNED)"DaysUsed",');
  qryMain.SQL.add(' T.instock as instock ,');
  qryMain.SQL.add(' T.Available as Available ,');
  qryMain.SQL.add(' T.Transtype as transtype,');
  qryMain.SQL.add(' P.partname as ProductName,');
  qryMain.SQL.add(' concat(T.DaysUsed,"/", DATEDIFF(:DateTo,:DateFrom) , "Days" ) as Usagedesc,');
  qryMain.SQL.add(' round((T.DaysUsed/ DATEDIFF(:DateTo,:DateFrom) )*  100,2) "Usage"');
  qryMain.SQL.add(' FROM  ' + fsTablename +' T  left join tblparts P on T.productId = P.partsID');
end;
procedure TfrmBinUsageReport.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if selectedClassId <> 0 then
      AddFieldtoGrid(qrymainDepartmentName.fieldname, qrymainDepartmentName.index)
  else RemoveFieldfromGrid(qrymainDepartmentName.fieldname);
  if (grpfilters.visible = false) or (grpfilters.itemindex =0) then begin
    RemoveFieldfromGrid(qrymaindt.fieldname);
    RemoveFieldfromGrid(qrymaintranstype.fieldname);
  end else begin
    AddFieldtoGrid(qrymaindt.fieldname, qrymaindt.index);
    AddFieldtoGrid(qrymaintranstype.fieldname, qrymaintranstype.index);
  end;
end;

procedure TfrmBinUsageReport.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  InitDateFromnDateto;
end;

procedure TfrmBinUsageReport.FormCreate(Sender: TObject);
begin
  MakeQrymain;
  inherited;
  SelectionOption := soClass;
  grpfilters.itemindex := 0;
  grpfilters.visible := False;
  BinID := 0;
end;

procedure TfrmBinUsageReport.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  inherited;
end;

function TfrmBinUsageReport.GetBinQty(ClassID:Integer=0): String;
var
  SQLList:TStringList;
begin
    SQLList := TStringList.Create;
    try
        SQLList.add('SELECT pqa.productId, pqa.pqaid ,ifnull(Pt.description , Pqa.transtype) TransType,  PQABins.Value AS BinID,uom.Volume,');
        SQLList.add('PQA.transDate AS DT,');
        SQLList.add(ProductQtyLib.SQL4Qty(tInstock,'PQA' , 'if(ifnull(PQABins.PQAdetailID,0) <> 0 , PQABins.Qty , 0)') +' as instock,');
        SQLList.add(ProductQtyLib.SQL4Qty(tAvailable,'PQA' , 'if(ifnull(PQABins.PQAdetailID,0) <> 0 , PQABins.Qty , 0)') +' as Available');
        SQLList.add(' FROM ' +ProductTables(tExtraDetails));
        SQLList.add(' INNER JOIN tblunitsofmeasure uom ON uom.UnitID = PQA.uomid ');
        SQLList.add('  INNER JOIN tblpqatranstypes Pt ON PQA.transtype = Pt.Transtype');
        SQLList.Add(' Where P.active <>"F" and PC.ACtive <> "F"');
        SQLList.add('and (PQA.TransDate < '  +quotedStr(FormatDateTime(MysqlDatetimeFormat , filterDateto)) +' )');
        if ClassID <> 0 then SQLList.add('AND PQA.DepartmentID = ' + IntToStr(ClassID));
        if BinID <> 0 then SQLList.add('AND PQABins.Value = ' + IntToStr(BinID));
        SQLList.add('group by PQABins.Value , PQA.transDate , pqa.pqaid');
        SQLList.add('HAVING IFNULL(binId,0)<>0');
        Result := SQLList.Text;
    finally
        Freeandnil(SQLList);
    end;
end;

procedure TfrmBinUsageReport.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if grpfilters.itemindex =1 then
    if qrymaindetails.asInteger = 1 then
      DoGreenhighlight(AFont, ABrush);
end;

procedure TfrmBinUsageReport.grdMainDblClick(Sender: TObject);
var
  form: TStockQtysLocationsReportGUI;
begin
  Form := TStockQtysLocationsReportGUI.DrillDownfor(0,0, '', 0,qryMain.Fieldbyname('bin location').asString ,qrymain.fieldbyname('bin number').asString, '');
  if Assigned(Form) then begin
    Form.showmodal;
    Exit;
  end;
end;

procedure TfrmBinUsageReport.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Details' , ['1'], true);
  inherited;
end;

initialization
  RegisterClassOnce(TfrmBinUsageReport);
end.

