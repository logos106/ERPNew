unit SerialNumbers;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwcheckbox, kbmMemTable, DB,
  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript,
  MyScript, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg , BaseListExpress, dmMainGUI , frmBaselistingSelectionLookup,DNMAction;

type
  TSerialNumbersGUI = class(TBaseListExpressGUI)
    qryMainPartsId: TIntegerField;
    qryMainDepartmentID: TIntegerField;
    qryMainUOM: TWideStringField;
    qryMainUOMMultiplier: TFloatField;
    qryMaingLevel: TLargeintField;
    qryMainProductName: TWideStringField;
    qryMainProductColumn1: TWideStringField;
    qryMainProductColumn2: TWideStringField;
    qryMainProductColumn3: TWideStringField;
    qryMainPartsDescription: TWideStringField;
    qryMainClassname: TWideStringField;
    qryMainBatchnumber: TWideStringField;
    qryMainTruckLoadNo: TWideStringField;
    qryMainBatchExpiryDate: TDateTimeField;
    qryMainbinLocation: TWideStringField;
    qryMainBinnumber: TWideStringField;
    qryMainSerialnumber: TWideStringField;
    qryMainBOMSerialnumber: TWideStringField;
    qryMainDEscription: TWideStringField;
    qryMainallocType: TWideStringField;
    qryMainTransDate: TDateTimeField;
    btnPrintBarcode: TDNMSpeedButton;
    btnInspect: TDNMSpeedButton;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPrintBarcodeClick(Sender: TObject);
    procedure btnInspectClick(Sender: TObject);
    procedure btnExpressDetailClick(Sender: TObject);
  private
    SerialNumberHistoryform :TBaseListingGUI;
    function SelectedRecordsfilter: String;
    procedure SerialNumberHistoryBeforeShow(Sender: TObject);
  Protected
    fstablename :STring;
    actDetails :TDnMAction;
    Procedure SetGridColumns;override;
    function GetReportTypeID: integer; override;
    procedure CreateTemptable;Virtual;
    Procedure MakeQrymain;Virtual;
    Function ExpressDetailListName:String;Override;
    Procedure SelectionOptionQry(Lookupform:TfmBaselistingSelectionLookup; cboQry:TERPQuery);Override;
    Function CreatetableSQL:String;Virtual;
    function SerialJonNumeberListSQL(hasBOMSerialnumber:Boolean; hasclassParam:Boolean; hasProductParam:Boolean; aClassID:Integer ):String;
  public
    Procedure RefreshQuery; override;
  end;


implementation

uses ProductQtyLib, CommonLib, AppEnvironment, DateUtils,
  SerialnumberHistory, frmStockAdjustEntryFlat, tcConst, busobjPQA,
  FastFuncs, CommonDbLib, Barcodeconst, LogLib, CommonFormLib,
  TemplateReportsLib, BusobjCustomFilter , ShellAPI, DbSharedObjectsObj,
   SerialNumberListBatch, SerialNumberListCurrent, BaseGUIDatamodule;

{$R *.dfm}

function  TSerialNumbersGUI.SelectedRecordsfilter:String;
var
  i: integer;
begin
    result:= '';
    if grdmain.SelectedList.Count=0 then exit;
    if grdmain.SelectedList.Count > 0 then begin
      for i := 0 to grdmain.SelectedList.Count - 1 do begin
        grdmain.Datasource.Dataset.GoToBookmark(grdmain.SelectedList.Items[i]);
        if result <> '' then result := result + ' Or ' ;
        result := result + ' (T.ProductId = ' + inttostr( qryMainPartsId.AsInteger) + ' and T.Serialnumber = ' + quotedstr(qryMainSerialnumber.AsString ) +')';
      end;
    end;

end;
procedure TSerialNumbersGUI.SelectionOptionQry(Lookupform: TfmBaselistingSelectionLookup; cboQry: TERPQuery);
begin
  inherited;
end;

procedure TSerialNumbersGUI.btnPrintBarcodeClick(Sender: TObject);
var
  s:String;
begin
  inherited;
  chkAdvancedPrinting.Checked := True;
  chkPreview.Checked := True;
  try
    TemplateSQL := companyInfoSQL +
            ' ~|||~{Details}SELECT    P.GlobalRef,P.PARTSID,P.PARTTYPE,P.PRODUCTGROUP,P.PARTNAME, '+
            ' P.PURCHASEDESC,P.INCOMEACCNT,P.ASSETACCNT,P.COGSACCNT,P.BARCODE,P.PRODUCTCODE,   '+
            ' P.TAXCODE,P.PURCHTAXCODE,P.PREFEREDSUPP,P.SpecialDiscount,P.SNTracking,  P.MultipleBins,P.batch, '+
            ' P.AutoBatch,P.AutoReorder,P.BuyQTY1,P.BuyQTY2,  P.BuyQTY3,P.COST1,P.COST2,P.COST3,P.AvgCost, '+
            ' P.SellQTY1,P.SellQTY2,  P.SellQTY3,P.PRICE1,P.PRICE2,P.PRICE3,P.WHOLESALEPRICE,P.Active,  P.productcomment, '+
            ' PRICE1 + TC.Rate* P.PRICE1 as priceinc1,    '+
            ' PRICE2 + TC.Rate* P.PRICE2 as priceinc2,     '+
            ' PRICE3 + TC.Rate* P.PRICE3 as priceinc3,   '+
            ' ((P.PRICE1 + TC.Rate* P.PRICE1 )*1.5) as retail1,   '+
            ' ((P.PRICE2 + TC.Rate* P.PRICE2 )*1.5) as retail2,   '+
            ' ((P.PRICE3 + TC.Rate* P.PRICE3 )*1.5) as retail3    , '+
            ' concat(T.UOM, " (" , T.UOMMultiplier, " )" ) as UOM,  '+
            ' P.partname as Productname,  '+
            Firstcolumn +' as Productcolumn1, '+
            Secondcolumn +' as Productcolumn2, '+
            Thirdcolumn +' as Productcolumn3,  '+
            ' P.PARTSDESCRIPTION as PartsDescription,  '+
            ' C.Classname as Classname , T.batchnumber,T.TruckLoadNo,T.ExpiryDate as BatchExpiryDate, T.binlocation,  '+
            ' T.binnumber, T.serialnumber, P.description, T.Alloctype , ' +
            'concat(' +Quotedstr(Barcode_Prefix_PQASN)+',''-'' ,T.ProductID,''-'' ,Serialnumber) as BOMSerialnumber  '+
            'FROM tblparts   P  '+
            'Inner Join tbltaxcodes TC ON P.TAXCODE = TC.Name    and TC.regionID =  '+ inttostr(AppEnv.RegionalOptions.ID) + ' ' +
            'inner join '+fstablename +' T on T.ProductId = P.PartsID '+
            'inner join tblclass C on C.classId = T.departmentID ';
    s:= SelectedRecordsfilter;
    if s<> '' then s:= ' where (' + s +')';
    if GroupFilterString <> '' then begin
        if s<> '' then s := s +' and ' else s:= ' where ';
        s:= s+ ' (T.'+ trim(GroupFilterString)+')';
    end;
    TemplateSQL := TemplateSQL +s;
    TemplateSQL := TemplateSQL +' Order by Partname, Alloctype';
    ReportToPrint:= 'Product Serial Numbers';
    ReportSQLSupplied:= True;
    try
      cmdPrint.Click;
    finally
      ReportSQLSupplied:= False;
    end;
  finally
    chkAdvancedPrinting.Checked := False;
  end;
end;

procedure TSerialNumbersGUI.RefreshQuery;
begin
  closeDB(Qrymain);
  CreateTemptable;
  inherited;
  qrymain.fieldByname('Classname').DisplayLabel       := AppEnv.DefaultClass.ClassHeading;
  qrymain.fieldByname('ProductName').DisplayLabel     := 'Product Name';
  qrymain.fieldByname('Batchnumber').DisplayLabel     := 'Batch Number' ;
  qrymain.fieldByname('TruckLoadNo').DisplayLabel     := 'Truck Load Number' ;
  qrymain.fieldByname('BatchExpiryDate').DisplayLabel := 'Expiry Date';
  qrymain.fieldByname('binLocation').DisplayLabel     := 'Bin Location';
  qrymain.fieldByname('Binnumber').DisplayLabel       := 'Bin Number';
  qrymain.fieldByname('Serialnumber').DisplayLabel    := 'Serial Number';
  qrymain.fieldByname('allocType').DisplayLabel       := 'Status';
  qrymain.fieldByname('TRansDate').DisplayLabel       := 'Last Transaction Date';
  TDateTimeField(qrymain.fieldByname('TRansDate')).DisplayFormat := FormatSettings.ShortDateformat;
end;

function TSerialNumbersGUI.CreatetableSQL: String;
begin
  REsult := '';
end;

procedure TSerialNumbersGUI.CreateTemptable;
begin
    With Scriptmain do begin
        SQL.clear;
        SQL.add(CreatetableSQL);
        SQL.add('truncate ' + fstablename +';');
        if IsLimit0selection  then else begin
            SQL.add('insert ignore into ' + fstablename +
                    ' (PartsId,DepartmentID,UOMID	,UOM	,UOMMultiplier	,gLevel	,ProductName	,ProductColumn1	,'+
                      'ProductColumn2	,ProductColumn3	,PartsDescription	,Classname	,Batchnumber	,TruckLoadNo	,'+
                      'cBatchExpiryDate	,BatchExpiryDate	,binLocation	,Binnumber	,Serialnumber	,DEscription	,'+
                      'Transdate	,allocType	)' );
              SQL.add(ProductQtylib.Serialnumberlist(0, SelectedClasSId , 0,  0, FilterDateTo, false));
              SQL.add('Union all');
              SQL.Add(SerialJonNumeberListSQL(False,False, false, SelectedClasSId ));
              SQL.add(';');
        end;
        doshowProgressbar(SQL.count , waitmsg);
        try
            SQL.text := changeQuery(SQL.text);
            clog(SQL.text);
            Execute;
        finally
            dohideprogressbar
        end;
        grpFiltersClick(grpFilters);
    end;
end;
function TSerialNumbersGUI.SerialJonNumeberListSQL(hasBOMSerialnumber:Boolean; hasclassParam:Boolean; hasProductParam:Boolean; aClassID:Integer ):String;
var
  st:TStringList;
begin
  st:= TStringList.Create;
  try
            ST.Add('SELECT distinct ');
            ST.Add('P.PartsId           as PartsID, ');
            ST.Add('S.ClassId           as DepartmentID,');
            ST.Add('0                   as UOMID, ');
            ST.Add(Quotedstr(AppEnv.DefaultClass.DefaultUOM) +' as UOM,');
            ST.Add('1                   as UOMMultiplier,');
            ST.Add('4                   as gLevel, ');
            ST.Add('P.PartName          as ProductName ,');
            ST.Add(FirstColumn       +' as ProductColumn1,');
            ST.Add(Secondcolumn      +' as ProductColumn2,');
            ST.Add(Thirdcolumn       +' as ProductColumn3,');
            ST.Add('PartsDescription    as PartsDescription,');
            ST.Add('S.ClassName         as ClassName,');
            ST.Add('""                  as Batchnumber,');
            ST.Add('""                  as TruckLoadNo,');
            ST.Add('""                  as cBatchExpiryDate, ');
            ST.Add('NULL                as BatchExpiryDate,');
            ST.Add('""                  as binLocation,');
            ST.Add('""                  as Binnumber,');
            ST.Add('SerialNo            as serialnumber  ,');
            ST.Add('""                  as DEscription,');
            ST.Add('NULL                as Transdate,');
            if hasBOMSerialnumber then ST.add('null as BOMSerialnumber,');
            ST.Add('"New"               as allocType');
            ST.Add('FROM tblSerialnumbers S');
            ST.Add('inner join tblParts P on P.PartsId = S.ProductID');
            ST.Add('left join tblpqa pqa on pqa.productId = S.ProductID and pqa.DepartmentID = S.classId');
            ST.Add('Left join  tblPQADetails pqad on pqa.pqaid = pqad.pqaid and  pqad.PQAType = ' +quotedStr(TPQASN.PQADetailType)+' and pqad.value = S.Serialno ');
            ST.Add('Where  pqad.pqadetailid is null ');
            if hasclassParam    then St.Add('and (S.ClassId = :DepartmentId or :DepartmentId=0)');
            if hasProductParam  then St.Add('and (S.ProductID = :ProductId or :ProductId=0) ');
            if aClassID<> 0     then St.add('and S.ClassId =' + IntToStr(aClassId));
  finally
    REsult := St.Text;
  end;

end;

function TSerialNumbersGUI.ExpressDetailListName: String;
begin
  Result := 'TSerialNumberListBatchGUI'
end;

procedure TSerialNumbersGUI.grpFiltersClick(Sender: TObject);
begin
  if grpFilters.visible then
         if grpFilters.ItemIndex =0 then GroupFilterString  := 'alloctype = ' + quotedStr('In-Stock') + ' or alloctype = ' + quotedStr('New')
    else if grpFilters.ItemIndex =1 then GroupFilterString  := 'alloctype = ' + quotedStr('Sold')
    else if grpFilters.ItemIndex =2 then GroupFilterString  := 'alloctype = ' + quotedStr('SO')
    else if grpFilters.ItemIndex =3 then GroupFilterString  := 'alloctype = ' + quotedStr('Fixed Asset')
    else GroupFilterString := '';
  inherited;

end;
procedure TSerialNumbersGUI.MakeQrymain;
begin

  ExecuteSQL('Drop table if exists '+fstablename +';' +
            ' CREATE TABLE '+ fstablename +' ('+
            ' `ID` int(11) NOT NULL auto_increment,'+
            '   `PartsId` int(11) NOT NULL default 0,'+
            '   `DepartmentID` int(11) default NULL,'+
            '   `UOMID` bigint(20) default NULL,'+
            '   `UOM` varchar(50) NOT NULL default "",'+
            '   `UOMMultiplier` double NOT NULL default 0,'+
            '   `gLevel` bigint(20) NOT NULL default 0,'+
            '   `ProductName` varchar(60) default NULL,'+
            '   `ProductColumn1` varchar(255) default NULL,'+
            '   `ProductColumn2` varchar(255) default NULL,'+
            '   `ProductColumn3` varchar(255) default NULL,'+
            '   `PartsDescription` varchar(255) default NULL,'+
            '   `Classname` varchar(255) default NULL,'+
            '   `Batchnumber` varchar(100) default NULL,'+
            '   `TruckLoadNo` varchar(100) default NULL,'+
            '   `cBatchExpiryDate` datetime default NULL,'+
            '   `BatchExpiryDate` datetime default NULL,'+
            '   `binLocation` varchar(30) default NULL,'+
            '   `Binnumber` varchar(30) default NULL,'+
            '   `Serialnumber` varchar(100) default NULL,'+
            '   `DEscription` varchar(100) default NULL,'+
            '   `Transdate` datetime default NULL,'+
            '   `allocType` varchar(11) default "",'+
            '   PRIMARY KEY  (`ID`),'+
            '   KEY `partsididx` (`PartsId`)'+
            ' ) ENGINE=MyIsam ');
  Qrymain.SQL.Clear;
  Qrymain.SQL.add('Select ');
  Qrymain.SQL.add('ID  as ID , ');
  Qrymain.SQL.add('PartsId as PartsId , ');
  Qrymain.SQL.add('DepartmentID as DepartmentID , ');
  Qrymain.SQL.add('UOMID as UOMID , ');
  Qrymain.SQL.add('UOM as UOM , ');
  Qrymain.SQL.add('UOMMultiplier as UOMMultiplier , ');
  Qrymain.SQL.add('gLevel as gLevel , ');
  Qrymain.SQL.add('ProductName as ProductName , ');
  Qrymain.SQL.add('ProductColumn1 as ProductColumn1 , ');
  Qrymain.SQL.add('ProductColumn2 as ProductColumn2 , ');
  Qrymain.SQL.add('ProductColumn3 as ProductColumn3 , ');
  Qrymain.SQL.add('PartsDescription as PartsDescription , ');
  Qrymain.SQL.add('Classname as Classname , ');
  Qrymain.SQL.add('Batchnumber as Batchnumber , ');
  Qrymain.SQL.add('TruckLoadNo as TruckLoadNo , ');
  Qrymain.SQL.add('cBatchExpiryDate as cBatchExpiryDate , ');
  Qrymain.SQL.add('BatchExpiryDate as BatchExpiryDate , ');
  Qrymain.SQL.add('binLocation as binLocation , ');
  Qrymain.SQL.add('Binnumber as Binnumber , ');
  Qrymain.SQL.add('Serialnumber as Serialnumber , ');
  Qrymain.SQL.add('Description as Description , ');
  Qrymain.SQL.add('Transdate as Transdate , ');
  Qrymain.SQL.add('allocType as allocType, ');
  Qrymain.SQL.add('concat(' +Quotedstr(Barcode_Prefix_PQASN)+',''-'' ,PartsId,''-'' ,Serialnumber) as BOMSerialnumber  ');
  Qrymain.SQL.add('FROM ' +fstablename);
  Qrymain.SQL.add('Order by Serialnumber');
end;

procedure TSerialNumbersGUI.FormShow(Sender: TObject);
begin
  inherited;
  actdetails :=dtmMainGUI.actSerialNumberList;

(*  if Assigned(btnExpressDetail.action) then begin
    actdetails :=TDnmAction(btnExpressDetail.action );
    btnExpressDetail.action  := nil;
    btnExpressDetail.onClick := btnExpressDetailClick;
  end;*)
  Showcontrolhint(btnExpressDetail ,btnExpressDetail.caption +NL+'This Report Will be Faster');
  btnInspect.visible := Devmode;
end;


function TSerialNumbersGUI.GetReportTypeID: integer;
begin
  REsult :=160;
end;

procedure TSerialNumbersGUI.grdMainDblClick(Sender: TObject);
//var
//  Form : TSerialNumberHistoryGUI;
begin
  if devmode and sametext(activefieldname, qrymainbomserialnumber.FieldName) then begin
      Logtext(qrymainbomserialnumber.asString);
      exit;
  end;

  if QrymainAlloctype.asString = 'New' then begin
      MessageDlgXP_Vista('This is a new Serial/Job Number' , mtWarning , [mbok], 0);
      Exit;
  end;

  {if form already opened - then refresh for the current serial number}
  if SerialNumberHistoryform <> nil then begin
    try
     SerialNumberHistoryBeforeShow(SerialNumberHistoryform);
     TSerialNumberHistoryGUI(SerialNumberHistoryform).RefreshQuery;
     Exit;
    except
      on E:Exception do begin
        SerialNumberHistoryform := nil;
      end;
    end;
  end;

  CommonFormLib.OpenErpListform('TSerialNumberHistoryGUI' ,SerialNumberHistoryBeforeShow);
end;
procedure TSerialNumbersGUI.SerialNumberHistoryBeforeShow(Sender: TObject);
begin
  if not(Sender is TSerialNumberHistoryGUI) then exit;
  TSerialNumberHistoryGUI(Sender).Serialnumber := qryMainSerialnumber.asString;
  TSerialNumberHistoryGUI(Sender).PartsID      := qryMainPartsId.asInteger;
  TSerialNumberHistoryGUI(Sender).dtFrom.date  := 0;
  TSerialNumberHistoryGUI(Sender).DtTo.Date    := dtTo.Date;
  TSerialNumberHistoryGUI(Sender).fbDateRangeSupplied:= true;
  SerialNumberHistoryform :=TSerialNumberHistoryGUI(Sender);
end;
procedure TSerialNumbersGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  if MessageDlgXP_Vista('You need to do a stock adjustment to create new Serial numbers. Do you wish to open the Stock Adjustment form?' , mtconfirmation , [mbyes, mbNo] , 0) = mrno then exit;
  Form := GetComponentByClassName('TfmStockAdjustEntryflat');
  if Assigned(Form) then begin
    with TfmStockAdjustEntryflat(Form) do begin
      AttachObserver(Self);
      FormStyle   := fsMDIChild;
      BringToFront;
      TfmStockAdjustEntryflat(Form).stockAdjust.New;
      if TfmStockAdjustEntryflat(Form).StockAdjust.accountID> 0 then begin
        TfmStockAdjustEntryflat(Form).StockAdjust.PostDB;
        TfmStockAdjustEntryflat(Form).StockAdjust.Lines.New;
        if qryMain.fieldbyname('PartsID').asInteger <> 0 then
          TfmStockAdjustEntryflat(Form).StockAdjust.Lines.ProductID := qryMain.fieldbyname('PartsID').asInteger;
        if qryMain.fieldbyname('DepartmentID').asInteger <> 0 then
          TfmStockAdjustEntryflat(Form).StockAdjust.Lines.DeptID    := qryMain.fieldbyname('DepartmentID').asInteger;
        TfmStockAdjustEntryflat(Form).StockAdjust.Lines.PostDB;
        SetControlFocus(TfmStockAdjustEntryflat(Form).grdTransactions);
      end;
    end;
  end;
end;

procedure TSerialNumbersGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('PartsId');
  RemoveFieldfromGrid('DepartmentId');
  RemoveFieldfromGrid('UOMMultiplier');
  RemoveFieldfromGrid('gLevel');
  RemoveFieldfromGrid('ExpiryDate');
  RemoveFieldfromGrid('Description');

end;

procedure TSerialNumbersGUI.FormCreate(Sender: TObject);
begin
  //HasAsondateRange := True;
  HaveOnlyToDate['As On '] := true;
  SerialNumberHistoryform := nil;
  CloseDB(Qrymain);
  fstablename := GetUserTemporarytablename('Serialnumbers');
  MakeQrymain;
 inherited;
 fbSelectioninPopup := True;
(* if (self is TSerialNumberListCurrentGUI) or (Self is TSerialNumberListBatchGUI) then
   SelectionOption :=soClassnProduct
 else  SelectionOption := soClass;*)
end;

procedure TSerialNumbersGUI.FormDestroy(Sender: TObject);
begin
  if Pos('tmp_',Lowercase(fstablename)) = 1 then
    CommonDbLib.DestroyUserTemporaryTable(fstablename );
  inherited;
end;
procedure TSerialNumbersGUI.btnExpressDetailClick(Sender: TObject);
begin
  if assigned(ActDetails) then begin
    ActDetails.OnExecute(ActDetails);
    CloseWait;
    Exit;
  end else begin
    inherited;
  end;

end;

procedure TSerialNumbersGUI.btnInspectClick(Sender: TObject);
  Procedure CreateLogTable;
  begin
    With Scriptmain do begin
      SQL.Clear;
      SQL.add(' CREATE TABLE if not exists tmp_1 ( '+
	            ' ID INT(11) NOT NULL AUTO_INCREMENT, '+
	            ' 	Productname VARCHAR(16) NOT NULL DEFAULT "" , '+
	            ' 	Batch_Serialnumbers INT(11) NOT NULL DEFAULT 0, '+
	            ' 	Curent_Serialnumbers INT(11) NOT NULL DEFAULT 0, '+
	            ' 	PRIMARY KEY (ID), '+
	            ' 	UNIQUE INDEX Productname (Productname) ) COLLATE="utf8_general_ci" ENGINE=InnoDB ;');
       if self is TSerialNumberListBatchGUI then
            SQL.add(' update tmp_1  set Batch_Serialnumbers =0;')
       else SQL.add(' update tmp_1  set Curent_Serialnumbers =0;');
    end;
  end;

  Procedure AddLog( Productname:String; sncount:Integer);
  begin
      With Scriptmain do begin
        if self is TSerialNumberListBatchGUI then
             SQL.add('insert ignore into tmp_1 	(Productname, Batch_Serialnumbers) values ('+quotedstr(Productname)+',' +inttostr(sncount)+')   ON DUPLICATE KEY UPDATE Batch_Serialnumbers=	' +inttostr(sncount)+';')
        else SQL.add('insert ignore into tmp_1 	(Productname, Curent_Serialnumbers) values ('+quotedstr(Productname)+',' +inttostr(sncount)+')   ON DUPLICATE KEY UPDATE Curent_Serialnumbers=	' +inttostr(sncount)+';');
      end;
  end;
var
  qry: TERPQuery;
begin
  Qrymain.disablecontrols;
  try
      qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
      try
            inherited;
            qry.sql.text := 'Select distinct productname from (' + qrymain.sql.text+') as main order by productname ';
            qry.open;
            qry.first;

            CreateLogTable;
            DoshowProgressbar(100 , WAITMSG  );
            try
              While qry.Eof = False do begin
                mnuClearFilter.Click;
                if Qrymain.Locate('Productname' , qry.fieldbyname('Productname').asString , []) then begin
                  Customfilter.Addfilter(QrymainProductname, AndFilter);
                  RefreshfilterLabel;
                  PreviewFilteredReport;
                  AddLog( QrymainProductname.AsString ,Qrymain.recordcount);
                  DoStepProgressbar(QrymainProductname.AsString +':' + inttostr( Qrymain.recordcount)+'     ' + inttostr(qry.recno)+' of '+ inttostr(qry.recordcount));
                end;
                qry.Next;
              end;
            finally
              DOHideProgressbar;
            end;
      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
      end;
  finally
    Scriptmain.execute;
    Qrymain.enablecontrols;
  end;
end;

initialization
// this form is not used any more -
// TSerialNumberListBatchGUI and TSerialNumberListCurrentGUI are used
//  RegisterClassOnce(TSerialNumbersGUI);
end.
