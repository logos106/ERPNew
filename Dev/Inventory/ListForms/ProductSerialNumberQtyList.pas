unit ProductSerialNumberQtyList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel ,BusobjStockAdjustEntry, GIFImg ;

type
  TProductSerialNumberQtyListGUI = class(TBaseListingGUI)
    qryMainUOMNAme: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    qryMainMultipleBins: TWideStringField;
    qryMainbatch: TWideStringField;
    qryMainSNTracking: TWideStringField;
    qryMainProductTypeCode: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainSalesDescription: TWideStringField;
    qryMainCostIncA: TFloatField;
    qryMainPriceIncA: TFloatField;
    qryMainInStock: TFloatField;
    qryMainAvailable: TFloatField;
    qryMainSNInStock: TFloatField;
    qryMainSNAvailable: TFloatField;
    qryMainProductType: TWideStringField;
    qryMainCostExA: TFloatField;
    qryMainPriceExA: TFloatField;
    qryMainPurchaseDescription: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainUOMID: TIntegerField;
    qryMainPARTSID: TIntegerField;
    qryMainProductName: TWideStringField;
    btnAdjust: TDNMSpeedButton;
    qryMainID: TIntegerField;
    qryMainClassid: TIntegerField;
    qryMainClassName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SctMainError(Sender: TObject; E: Exception; SQL: string;var Action: TErrorAction);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure btnAdjustClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    fstablename : String;
    fbHasSQLError :Boolean;
    AdjustmentOnInstock:Boolean;
  StockAdjust: TStockAdjustEntry;
  Originalno:String;
  AdjsutemntMade:Boolean;

    procedure MakeQRYmain;
    Procedure MakeStockAdjust;
    procedure NewLine(aAdjQty: Double);
    procedure NewStock;
    procedure AfterStockAdjustEntryListShow(Sender: TObject);
  Protected
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonDbLib, CommonLib, AppEnvironment, ProductQtyLib, PQALib, tcConst,
  MySQLConst, LogLib, BusObjBase, CommonFormLib, StockAdjustEntryList , Math;

{$R *.dfm}

procedure TProductSerialNumberQtyListGUI.btnAdjustClick(Sender: TObject);
var
  fiIndex:Integer;
  fiID:Integer;
begin
  inherited;
  if chkIgnoreDates.Checked then begin
    MessageDlgXP_Vista('Please Choose the ''As on date'' for the Report.  The Adjustment will be done for this date', mtInformation, [mbOK], 0);
    Exit;
  end;

  fiIndex:= grpfilters.ItemIndex;
  fiID:=qrymainid.asInteger;
  try
    if grpfilters.ItemIndex <> 1 then grpfilters.ItemIndex := 1;
    if Qrymain.recordcount =0 then exit;
    if SelectedRecords =0 then
      if MessageDlgXP_Vista('You Have not Selected the Products to Adjust. Do you Want to Adjust All Products in the List? ', mtConfirmation, [mbYes, mbNo], 0)= mrno then exit
      else grdmain.SelectAll;

      AdjustmentOnInstock := MessageDlgXP_Vista('Please Choose the Quantity to Match for Adjustment', mtConfirmation, [], 0 , nil, '' , '' , False, nil , 'In-Stock Qty,Available Qty') =100;

      if MessageDlgXP_Vista('Stock Adjustment will be Created to Adjust the Product '+ iif(AdjustmentOnInstock , 'In-Stock' , 'Available') +' Quantity '+
                            ' to Match the Serial Number '+ iif(AdjustmentOnInstock , 'In-Stock' , 'Available') +' Quantity as on ' + Quotedstr(formatdateTime(FormatSettings.shortdateformat +' HH:NN:SS AM/PM' , Filterdateto))+'.'+NL+
                                'Continue?' , mtConfirmation, [mbYes, mbNo], 0)= mrno then exit;
      MakeStockAdjust;
  finally
    grpfilters.ItemIndex :=fiIndex;
    qrymain.Locate('ID' , fiId, []);
  end;
end;

procedure TProductSerialNumberQtyListGUI.FormCreate(Sender: TObject);
begin
  fstablename := commondblib.GetUserTemporaryTableName('PSQ');
  qrymain.SQL.Clear;
  qrymain.SQL.add('select');
  qrymain.SQL.add('*');
  qrymain.SQL.add('from ' + fstablename);
  qrymain.SQL.add('order by Productname,Classname');
  HaveOnlyToDate['As On '] := true;
  inherited;
  SelectionOption := soClass;
  //HasAsondateRange:= True;
end;

procedure TProductSerialNumberQtyListGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(fstablename);
  inherited;

end;

procedure TProductSerialNumberQtyListGUI.FormShow(Sender: TObject);
begin
  inherited;
  EnableMultiSelect('Select Records to Adjust the Product Qty to Match Serial Number Quantity');
end;

procedure TProductSerialNumberQtyListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if sametext(field.fieldname , qrymainavailable.fieldname) or
     sametext(field.fieldname , qrymainsnavailable.fieldname) then
      if not(Samevalue(qrymainavailable.asfloat , qrymainsnavailable.asfloat,0)) then
        DoGreenhighlight(AFont,ABrush);

  if sametext(field.fieldname , qrymainInstock.fieldname) or
     sametext(field.fieldname , qrymainsnInstock.fieldname) then
      if not(Samevalue(qrymainInstock.asfloat , qrymainsnInstock.asfloat,0)) then
        DoGreenhighlight(AFont,ABrush);
end;

procedure TProductSerialNumberQtyListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupfilterString := '';
  if grpFilters.itemindex =1 then
    GroupfilterString := 'SNAvailable <> Available or SNInstock <> Instock';
  inherited;
end;

procedure TProductSerialNumberQtyListGUI.RefreshQuery;
begin
  MakeQRYmain;
  inherited;
end;

procedure TProductSerialNumberQtyListGUI.SctMainError(Sender: TObject;E: Exception; SQL: string; var Action: TErrorAction);
begin
  inherited;
  fbHasSQLError := TRue;
end;

procedure TProductSerialNumberQtyListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainId.fieldname);
  RemoveFieldfromGrid(qrymainUOMId.fieldname);
  RemoveFieldfromGrid(qrymainpartsId.fieldname);
  RemoveFieldfromGrid(qryMainClassId.fieldname);
  RemoveFieldfromGrid(qrymainProductTypeCode.fieldname);
end;

procedure TProductSerialNumberQtyListGUI.MakeQRYmain;
begin
  with ScriptMain do begin
    with SQL do begin
      Clear;
      Add('/*1*/Drop table if exists ' + fsTablename + '; ');
      Add('/*2*/CREATE TABLE ' + fsTablename + '(  ' +
          ' ID                    INT(11) NOT NULL AUTO_INCREMENT,  ' +
          ' ProductName           VARCHAR(60) DEFAULT NULL,  ' +
          ' Classname             VARCHAR(60) DEFAULT NULL,  ' +
          ' ProductPrintName      VARCHAR(255) DEFAULT NULL,  ' +
          ' MultipleBins          ENUM("T","F") DEFAULT "F",  ' +
          ' batch                 enum("F","T") DEFAULT "F",  ' +
          ' SNTracking            ENUM("T","F") DEFAULT "F",  ' +
          ' ProductTypeCode       VARCHAR(13) DEFAULT NULL,  ' +
          ' FirstColumn           VARCHAR(255) DEFAULT NULL,  ' +
          ' SecondColumn          VARCHAR(255) DEFAULT NULL,  ' +
          ' ThirdColumn           VARCHAR(255) DEFAULT NULL,  ' +
          ' SalesDescription      VARCHAR(255) DEFAULT NULL,  ' +
          ' CostIncA              DOUBLE NOT NULL DEFAULT 0,  ' +
          ' PriceIncA             DOUBLE NOT NULL DEFAULT 0,  ' +
          ' InStock               DOUBLE  DEFAULT NULL,  ' +
          ' Available             DOUBLE  DEFAULT NULL,  ' +
          ' SNInStock             DOUBLE  DEFAULT NULL,  ' +
          ' SNAvailable           DOUBLE  DEFAULT NULL,  ' +
          ' ProductType           VARCHAR(30) DEFAULT NULL,  ' +
          ' CostExA               DOUBLE NOT NULL DEFAULT 0,  ' +
          ' PriceExA              DOUBLE NOT NULL DEFAULT 0,  ' +
          ' PurchaseDescription   VARCHAR(255) DEFAULT NULL,  ' +
          ' Active                ENUM("T","F") DEFAULT "T",  ' +
          ' PARTSID               INT(11) NOT NULL DEFAULT 0,  ' +
          ' ClassId               INT(11) NOT NULL DEFAULT 0,  ' +
          ' UOMID                 INT(11) NOT NULL DEFAULT 0,  ' +
          ' UOMname               VARCHAR(255) DEFAULT NULL,  ' +
          ' PRIMARY KEY (ID), INDEX classId(PARTSID,ClassID)  ) ENGINE=Myisam DEFAULT CHARSET=utf8; ');

      Add('/*3*/insert ignore into  ' + fsTablename + ' (ProductName,Classname,ProductPrintName,MultipleBins,batch,SNTracking,ProductTypeCode,FirstColumn,SecondColumn,ThirdColumn,' +
          ' SalesDescription,CostIncA,PriceIncA,CostExA,PriceExA, PurchaseDescription,Active,PARTSID,classId, uomid, uomname)  ' +
          ' SELECT  Distinct  P.PARTNAME  as ProductName, PC.Classname,  P.ProductPrintName  as ProductPrintName,  P.MultipleBins MultipleBins,  ' +
          ' P.batch batch,  P.SNTracking SNTracking,  P.PARTTYPE  as ProductTypeCode, ' +
          Firstcolumn   + '  as FirstColumn, ' +
          Secondcolumn  + '  as SecondColumn, ' +
          Thirdcolumn   + '  as ThirdColumn,  P.PARTSDESCRIPTION  as SalesDescription,  ' +
          ' P.COSTINC1   as "CostIncA",  P.PRICEINC1  as "PriceIncA",  P.COST1  as "CostExA",  P.PRICE1  as "PriceExA",  ' +
          ' P.PURCHASEDESC  as "PurchaseDescription",  P.Active  as Active,  P.PARTSID  as PARTSID, PC.classId , ' +
          ' PQA.UOMID , concat(PQA.UOM , "(" , pqa.UOMMultiplier , ")") as uomname ' +
          ' FROM tblParts  as P  ' +
          ' inner  join tblproductclasses PC on P.partsId = PC.productid' + iif(SelectedClassID <> 0, ' and PC.ClassID = ' + inttostr(SelectedClassID), '') +
          ' inner join tblpqa PQA on PC.ProductID = PQA.ProductID and PC.ClassID = pqa.DepartmentID ' +
          ' WHERE char_length(P.PARTNAME)>0 AND not IsNull(P.PARTNAME) and P.parttype ="INV" and P.snTracking ="T" ' + iif(IsLimit0selection, 'LIMIT 0', '') + ';');

      Add('/*4*/update ' + fsTablename + ' P inner join tblparttypes PT on PT.TypeCode = P.ProductTypeCode  Set P.ProductType = PT.TypeDesc;');

      Add('/*5*/Drop table if exists ' + fsTablename + '1; ');
      Add('/*6*/CREATE TABLE ' + fsTablename + '1 (   ' +
                ' ID               INT(11) NOT NULL AUTO_INCREMENT,  ' +
                ' partsId          INT(11) DEFAULT NULL, ' +
                ' ClassId          INT(11) DEFAULT NULL, ' +
                ' InStock          DOUBLE  DEFAULT NULL, ' +
                ' uomid            int(11) , '+
                ' Available        DOUBLE  DEFAULT NULL, ' +
                ' PRIMARY KEY (ID) , Index PartsId (PartsID,classId)   ) ENGINE=Myisam DEFAULT CHARSET=utf8; ');

      Add('/*7*/insert into ' + fsTablename + '1  ' +
          ' (PartsID , classId, uomid, InStock,Available)   ' +
          ' select  P.partsId ,PQA.DepartmentID, pqa.UOMID ,  ' + ' Round(IF(P.ProductTypeCode = "INV",' +ProductQtylib.SQL4Qty(tInstock) + ',0.0),' + inttostr(tcConst.GeneralRoundPlaces) + ')  as "InStock",' +
            iif(AppEnv.CompanyPrefs.CountSOBOInAvailable, 'Round(IF(P.ProductTypeCode = "INV",' + ProductQtylib.SQL4Qty(tAvailable) + ' - ' +
                                                                                                ProductQtylib.SQL4Qty(tsobo) + ',0.0), ' + inttostr(tcConst.GeneralRoundPlaces) +')  as "Available"',
                                                        'Round(IF(P.ProductTypeCode = "INV",' + ProductQtylib.SQL4Qty(tAvailable) + ',0.0),' + inttostr(tcConst.GeneralRoundPlaces) + ')  as "Available"')+
          ' from ' + fsTablename + ' P ' +
          ' inner join tblPQA  as PQA on P.partsId = PQA.ProductID and pqa.DepartmentID = P.classid and pqa.UOMID = P.UOMID and PQA.transdate <=' +Quotedstr(formatdatetime(MysqlDateTimeFormat, FilterdateTo)) +
                                                                    iif(SelectedClassID <> 0, ' and PQA.DepartmentID = ' + inttostr(SelectedClassID), '') +
          ' group by p.partsId, P.classId,p.UOMID; ');

      Add('/*8*/update ' + fsTablename + ' t1 inner join ' + fsTablename + '1 t2 on t1.partsId = t2.partsId and t1.classid = t2.classId and t1.uomid = t2.uomid ' + ' Set  ' + ' T1.InStock = t2.InStock,  ' +
          ' T1.Available = t2.Available ; ');

      Add('/*9*/Truncate ' + fsTablename + '1; ');
      Add('/*7*/insert into ' + fsTablename + '1  ' + ' (PartsID , classId,uomid,  InStock,Available)   ' + ' select  P.partsId ,PQA.DepartmentID, PQA.uomid,  ' + ' Round(IF(P.ProductTypeCode = "INV",' +
          ProductQtylib.SQL4Qty(tInstock, 'PQA', 'PQASN.Qty') + ',0.0),' + inttostr(tcConst.GeneralRoundPlaces) + ')  as "InStock",' + iif(AppEnv.CompanyPrefs.CountSOBOInAvailable,
          'Round(IF(P.ProductTypeCode = "INV",' + ProductQtylib.SQL4Qty(tAvailable, 'PQA', 'PQASN.Qty') + ' - ' + ProductQtylib.SQL4Qty(tsobo, 'PQA', 'PQASN.Qty') + ',0.0), ' +
            inttostr(tcConst.GeneralRoundPlaces) + ')  as "Available"', 'Round(IF(P.ProductTypeCode = "INV",' + ProductQtylib.SQL4Qty(tAvailable, 'PQA', 'PQASN.Qty') + ',0.0),' +
            inttostr(tcConst.GeneralRoundPlaces) + ')  as "Available"') + ' from ' + fsTablename + ' P ' +
          ' inner join tblPQA  as PQA on P.partsId = PQA.ProductID and P.classId = PQA.DepartmentID and p.UOMID = pqa.UOMID and PQA.transdate <=' + Quotedstr(formatdatetime(MysqlDateTimeFormat, FilterdateTo)) +
                                                  iif(SelectedClassID <> 0,' and PQA.DepartmentID = ' + inttostr(SelectedClassID), '') +
            ' inner join tblpqadetails PQASN on pqa.pqaid = PQASN.pqaid and pqaSN.PQAType="SN" ' +
          ' group by p.partsId, p.classid, p.uomid; ');

      Add('/*8*/update ' + fsTablename + ' t1 inner join ' + fsTablename + '1 t2 on t1.partsId = t2.partsId  and t1.classId = t2.classid and t1.uomid = t2.uomid ' + ' Set  ' + ' T1.SNInStock = t2.InStock,  ' +
          ' T1.SNAvailable = t2.Available ; ');

      Add('/*9*/Drop table if exists ' + fsTablename + '1; ');

    end;
    clog(SQLText);
    fbHasSQLError := False;

    if devmode then begin
        ShowProgressbar(WAITMSG, SQL.Count);
        try
          Execute;
        finally
          HideProgressbar;
        end;
    end;

    if not(Devmode) or (fbHasSQLError) then begin
        SQL.text := ChangeQuery(SQL.text);
        clog(SQLText);

        ShowProgressbar(WAITMSG, SQL.Count);
        try
          Execute;
          if fbHasSQLError then MessageDlgXP_Vista('Please Run Update Batch To Update the Report Tables', mtWarning, [mbOK], 0);
        finally
          HideProgressbar;
          fbHasSQLError := False;
        end;
    end;

  end;
end;
procedure TProductSerialNumberQtyListGUI.AfterStockAdjustEntryListShow(Sender:TObject);
begin
  if sender is TStockAdjustEntryListGUI then begin
    if (TStockAdjustEntryListGUI(Sender).grpfilters.itemindex <> 0) and (TStockAdjustEntryListGUI(Sender).grpfilters.itemindex <>3) then
      TStockAdjustEntryListGUI(Sender).grpfilters.itemindex  := 0;
    TStockAdjustEntryListGUI(Sender).FilterString :=  'Originalno = ' +QuotedStr(Originalno);
  end;
end;
procedure TProductSerialNumberQtyListGUI.MakeStockAdjust;
begin
      AdjsutemntMade:=False;
      Originalno:= '';
      StockAdjust:= TStockAdjustEntry.CreateWithNewConn(self);
      try
          StockAdjust.Connection.BeginTransaction;
          StockAdjust.Load(0);
          IterateProcno :=1;
          NewStock;
          Iterateselectedrecords;
          if AdjsutemntMade then begin
            StockAdjust.Connection.CommitTransaction;
          end else begin
            StockAdjust.Connection.RollbackTransaction;
          end;

            if (Originalno <> '') and (AdjsutemntMade) then begin
                  CommonLib.MessageDlgXP_Vista( 'Stock Adjustment will be Created to Adjust the Product '+ iif(AdjustmentOnInstock , 'In-Stock' , 'Available') +' Quantity '+
                                ' to Match the Serial Number '+ iif(AdjustmentOnInstock , 'In-Stock' , 'Available') +' Quantity as on ' + Quotedstr(formatdateTime(FormatSettings.shortdateformat +' HH:NN:SS AM/PM' , Filterdateto))+'.'+NL+NL+
                                          'Please make sure the stock adjustment is processed.', mtInformation, [mbok], 0);
                  OpenERPListForm('TStockAdjustEntryListGUI', nil, AfterStockAdjustEntryListShow);

            end else if AdjsutemntMade = False then begin
                CommonLib.MessageDlgXP_Vista( 'There is nothing to Adjust in the Selected Products', mtInformation, [mbok], 0);
            end;
      finally
        Freeandnil(StockAdjust);
      end;
end;
  Procedure TProductSerialNumberQtyListGUI.NewStock;
  begin
    StockAdjust.PostDB;
    StockAdjust.New;
    StockAdjust.EnforceUOM := True;
    StockAdjust.AdjustmentOnInstock := AdjustmentOnInstock;
    StockAdjust.AdjustmentDate := FilterdateTo;
    StockAdjust.Notes := 'Adjust ProductQty to Match Serial number Qty';
    StockAdjust.PostDB;
    if Originalno = '' then Originalno := StockAdjust.globalref;
    StockAdjust.ImportgroupOriginalno := Originalno;
    StockAdjust.PostDB;
    StockAdjust.Lines.DoFieldChangewhenDisabled := true;
  end;

  Procedure TProductSerialNumberQtyListGUI.NewLine(aAdjQty :Double);
  begin
    if aAdjQty <> 0 then begin
        AdjsutemntMade:=True;
        if StockAdjust.Lines.Count >= 400 then begin
          StockAdjust.Lines.PostDB;
          StockAdjust.PostDB;
          NewStock;
        end;
        StockAdjust.Lines.New;
        StockAdjust.Lines.ProductID  := QrymainPartsId.asInteger;
        StockAdjust.Lines.DeptID     := QrymainClassId.asInteger;
        StockAdjust.Lines.UOMID      := QrymainUOMId.asInteger;
        StockAdjust.Lines.AdjustQty  := aAdjQty;
        StockAdjust.Lines.PostDB;
    end;
  end;
procedure TProductSerialNumberQtyListGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
begin
  inherited;
  if iterateprocno = 1 then begin
        if AdjustmentOnInstock and (qrymaininstock.asfloat <> qrymainsninstock.asfloat) then begin
          NewLine(0-(Qrymaininstock.asfloat - Qrymainsninstock.asfloat));
        end else if not(AdjustmentOnInstock) and (qrymainAvailable.asfloat <> qrymainsnAvailable.asfloat) then begin
          NewLine(0-(QrymainAvailable.asfloat - QrymainsnAvailable.asfloat));
        end;
  end;
end;

initialization
  RegisterClassOnce(TProductSerialNumberQtyListGUI);

end.
