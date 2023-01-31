unit StockQtysLocationsBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel,
  BaseListExpressDetails;

type
  TFormDisplayMode = (tNormal=1, tSelectRec=2, tDrilldown=3, tSummaryOnly=4);

  TStockQtysLocationsBaseGUI = class(TBaseListExpressDetailsGUI)
    qryLookup: TERPQuery;
    qryMainPartsId: TIntegerField;
    qryMainDepartmentID: TIntegerField;
    qryMainUOM: TWideStringField;
    qryMainUOMMultiplier: TFloatField;
    qryMainUOMVolume: TFloatField;
    qryMainUOMTotalAvailableVolume: TFloatField;
    qryMainUOMTotalinstockVolume: TFloatField;
    qryMainProductName: TWideStringField;
    qryMainPartType: TWideStringField;
    qryMainProductColumn1: TWideStringField;
    qryMainProductColumn2: TWideStringField;
    qryMainProductColumn3: TWideStringField;
    qryMainPartsDescription: TWideStringField;
    qryMainClassname: TWideStringField;
    qryMainBatchnumber: TWideStringField;
    qryMainTruckLoadNo: TWideStringField;
    qryMainExpiryDate: TWideStringField;
    qryMainBatchExpiryDate: TDateTimeField;
    qryMainBinlocation: TWideStringField;
    qryMainBinnumber: TWideStringField;
    qryMainSerialnumber: TWideStringField;
    qryMainSOUOMQty: TFloatField;
    qryMainSOQty: TFloatField;
    qryMainCost: TFloatField;
    qryMainValue: TFloatField;
    qryMainAutoID: TIntegerField;
    qryMaingLevel: TIntegerField;
    qryMainUOMQty: TFloatField;
    qryMainQty: TFloatField;
    qryMainInstockUOMQty: TFloatField;
    qryMainInstockQty: TFloatField;
    qryMainUnAllocatedSOUOMQty: TFloatField;
    qryMainUnAllocatedInstockUOMQty: TFloatField;
    qryMainUnAllocatedUOMQty: TFloatField;
    qryMainAllocatedUOMQty: TFloatField;
    qryMainAllocatedSOUOMQty: TFloatField;
    qryMainAllocatedInStockUOMQty: TFloatField;
    qryMainBin: TWideStringField;
    qryMainBatch: TWideStringField;
    qryMainSN: TWideStringField;
    qryMainAvailableQty: TFloatField;
    qryMainAvailableUOMQty: TFloatField;
    qryMainUOMMultiplierDesc1: TWideStringField;
    qryMainUOMMultiplierDesc2: TWideStringField;
    qryMainPreferredSupplier: TWideStringField;
    qryMainProductPrintName: TWideStringField;
        procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SctMainBeforeExecute(Sender: TObject; var SQL: string;var Omit: Boolean);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
  Protected
    Tablename       : String;
    FClassId        : Integer;
    FProductID      : Integer;
    fBatchno        : String;
    fBinnumber      : String;
    fbinLocation    : String;
    fExpiryDate     : TDatetime;
    fUOM            : String;
    fFormDisplayMode: TFormDisplayMode;
    Formshown :Boolean;
    fIncludeNonInventoryParts: boolean;
    fCustomFilterString: string;
    fDefaultGroupFilterItemIndex: integer;
    fUseBoldInGrid: boolean;
    procedure PopulateData;Virtual;
    procedure SetBatchNo(const Value: String);
    procedure SetBinLocation(const Value: String);
    procedure SetBinnumber(const Value: String);
    procedure SetExpiryDate(const Value: TDatetime);
    procedure SetUOM(const Value: String);
    Procedure SetSelectionOptionsFor(Value:TSelectionOptions);Override;
    procedure MakeQryMain;Virtual;
    procedure SetGridColumns; Override;
    procedure RefreshTotals; override;
    Procedure AfterFormShow; Override;
  public
    Property ProductID    :Integer    read FProductID     write FProductID;
    Property ClassId      :Integer    read FClassId       write FClassId;
    Property Batchno      :String     read fBatchno       write SetBatchNo;
    Property ExpiryDate   :TDatetime  read fExpiryDate    write SetExpiryDate;
    Property BinLocation  :String     read fbinLocation   write SetBinLocation;
    Property Binnumber    :String     read fBinnumber     Write SetBinnumber;
    Property UOM          :String     Read fUOM           Write SetUOM;
    Property FormDisplayMode : TFormDisplayMode REad fFormDisplayMode Write fFormDisplayMode;
    property IncludeNonInventoryParts: boolean read fIncludeNonInventoryParts write fIncludeNonInventoryParts;
    property CustomFilterString: string read fCustomFilterString write fCustomFilterString;
    property UseBoldInGrid: boolean read fUseBoldInGrid write fUseBoldInGrid;
    property DefaultGroupFilterItemIndex: integer read fDefaultGroupFilterItemIndex write fDefaultGroupFilterItemIndex;
    Procedure RefreshQuery;Override;


  end;

implementation

uses CommonDbLib, ProductQtyLib, SystemLib, PQALib, tcConst, CommonLib, LogLib;

{$R *.dfm}

{ TStockQtysLocationsBaseGUI }

procedure TStockQtysLocationsBaseGUI.AfterFormShow;
begin
  inherited;
  Formshown := True;
end;

procedure TStockQtysLocationsBaseGUI.FormCreate(Sender: TObject);
begin
  Tablename         := commondblib.GetUserTemporaryTableName(ListShortName);
  fIncludeNonInventoryParts := false;
  fUseBoldInGrid := true;
  MakeQryMain;
  HaveOnlyToDate['As On '] := true;
  inherited;
  //HasAsondateRange:= True;
    FClassId      :=0;
    FProductID    :=0;
    fBatchno      :='';
    fBinnumber    :='';
    fbinLocation  :='';
    fExpiryDate   :=0;
    fUOM          := '';
    fFormDisplayMode := tNormal;
    SelectionOption :=soClassnProduct;
end;

procedure TStockQtysLocationsBaseGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;
end;

procedure TStockQtysLocationsBaseGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }

  {-------batch expiry date -> blank when 0}
      if (Sysutils.SameText(field.fieldName , 'ExpiryDate')) then
        if (Qrymain.fieldbyname('ExpiryDate').asString = '')
            or (Qrymain.fieldbyname('ExpiryDate').asString = '1899-12-30')
            or (qryMaingLevel.asInteger = 1) then
            Afont.color := ABrush.color;

{-------UOM descriptions are shown only when Qty <> 0}
      if    (Sysutils.SameText(field.fieldName , 'UOMMultiplierDesc1')) then
        if QrymainQty.asFloat = 0 then
          Afont.color := ABrush.color;
      if (Sysutils.SameText(field.fieldName , 'UOMMultiplierDesc2')) then
          if QrymainAvailableQty.asFloat = 0 then
              Afont.color := ABrush.color;

end;

procedure TStockQtysLocationsBaseGUI.MakeQryMain;
begin
  if qryMain.Active then qryMain.Close;
  qryMain.SQL.clear;
  qryMain.SQL.Add('select');
  qryMain.SQL.Add('*');
  qryMain.SQL.Add('from ' +tablename);
  qryMain.SQL.Add('Where   Active ="T" ');
  qryMain.SQL.Add('and (:UOM ="" or UOM = :UOM)');
  qryMain.SQL.Add('and (:AllDept ="T" or   DepartmentId = :DepartmentId )');
  qryMain.SQL.Add('and (:FilterIndex <1 or ((:Batchnumber ="" or   Batchnumber = :Batchnumber ) and (:ExpiryDate <="1900/12/30" or ExpiryDate = :ExpiryDate) ))');
  qryMain.SQL.Add('and (:FilterIndex <2 or ((:Binlocation ="" or   Binlocation = :Binlocation ) and (:Binnumber ="" or Binnumber  = :Binnumber) ))');
end;

procedure TStockQtysLocationsBaseGUI.PopulateData;
var
  iProd   : Integer;
  iClass  : Integer;
  SQLList : TStringList;
begin
  clog('');
    iProd  := ProductID; if iProd =0 then iProd := SelectedProductId;
    iClass := classID; if iClass =0 then iClass := SelectedClassID;
    SQLList := TStringList.Create;
    Try
      SQLList.add('Drop table if Exists ' +tableName +';' );
      SQLList.add('CREATE TABLE ' +Tablename +' (');
      SQLList.add('AutoID             int(11)      NOT NULL  auto_increment,');
      SQLList.add('PartsId            int(11)      NOT NULL  default "0",');
      SQLList.add('DepartmentID       int(11)               default NULL,');
      SQLList.add('UOMID       int(11)               default NULL,');
      SQLList.add('UOM                varchar(50)  NOT NULL  default "",');
      SQLList.add('UOMMultiplier      double       NOT NULL  default "0",');
      SQLList.add('UOMVolume      double       NOT NULL  default "0",');
      SQLList.add('UOMTotalAvailableVolume      double       NOT NULL  default "0",');
      SQLList.add('UOMTotalinstockVolume      double       NOT NULL  default "0",');
      SQLList.add('gLevel             int(20)               default "0",');
      SQLList.add('PartType           varchar(13)           default "INV",');
      SQLList.add('ProductName        varchar(60)           default NULL,');
      SQLList.add('ProductPrintName   varchar(255)          default NULL,');
      SQLList.add('ProductColumn1     varchar(255)          default NULL,');
      SQLList.add('ProductColumn2     varchar(255)          default NULL,');
      SQLList.add('ProductColumn3     varchar(255)          default NULL,');
      SQLList.add('PartsDescription   varchar(255)          default NULL,');
      SQLList.add('Classname          varchar(255)          default NULL,');
      SQLList.add('Batchnumber        varchar(100)          default NULL,');
      SQLList.add('TruckLoadNo        varchar(100)          default NULL,');
      SQLList.add('ExpiryDate         varchar(10)           default NULL,');
      SQLList.add('BatchExpiryDate    datetime              default NULL,');
      SQLList.add('Binlocation        varchar(100) NULL     default "",');
      SQLList.add('Binnumber          varchar(100) NULL     default "",');
      SQLList.add('Serialnumber       varchar(100) NULL     default "",');
      SQLList.add('UOMQty             double                default NULL,');
      SQLList.add('Qty                double                default NULL,');
      SQLList.add('CUSTFLD1           double                default NULL,');
      SQLList.add('InstockUOMQty      double                default NULL,');
      SQLList.add('InstockQty         double                default NULL,');
      SQLList.add('SOUOMQty           double                default NULL,');
      SQLList.add('SOQty              double                default NULL,');
      SQLList.add('Cost               double       NOT NULL  default "0",');
      SQLList.add('Value              double                default NULL,');
      SQLList.add('Bin                enum("T","F")         default "F",');
      SQLList.add('Batch              enum("T","F")         default "F",');
      SQLList.add('SN                 enum("T","F")         default "F",');
      SQLList.add('Active             enum("T","F")         default "T",');
      SQLList.add('UOMMultiplierDesc1 varchar(100)          default NULL,');
      SQLList.add('UOMMultiplierDesc2 varchar(100)          default NULL,');
      SQLList.add('AvailableUOMQty    Double                 default NULL,');
      SQLList.add('AvailableQty       Double                 default NULL,');
      SQLList.Add('PreferredSupplier  varchar(55)            default NULL,'); //##
      SQLList.add('PRIMARY KEY  (AutoID)');
      SQLList.add(') ENGINE=MyISAM;');
      if (Formshown = true) or  (SearchMode = smFullList) then begin
            SQLList.add('insert into ' +Tablename +  ' (');
            SQLList.add('PartsId,DepartmentID ,UOMID, UOM ,UOMMultiplier ,gLevel ,ProductName  ,');
            SQLList.add('ProductColumn1 ,ProductColumn2 ,ProductColumn3 ,PartsDescription,');
            SQLList.add('Classname ,Batchnumber,TruckLoadNo,ExpiryDate ,BatchExpiryDate ,Binlocation ,');
            SQLList.add('Binnumber ,Serialnumber ,UOMQty ,Qty ,CUSTFLD1, InstockUOMQty ,InstockQty ,');
            SQLList.add('SOUOMQty ,SOQty ,Cost ,Value )');
            if self.IncludeNonInventoryParts then begin
              { note: we set the glevel initially to 0 here to prevent the line being deleted below ..}
              SQLList.add(ProductQtyLib.NonStockQtySummary(false,0,0,0,false,0));
              SQLList.add('union all');
            end;

            if classnameis('TStockBinQtysReportGUI') then SQLList.add(ProductQtyLib.StockQty(True , iProd, iClass , tExtraDetails   , filterdateto))
            else if grpFilters.Itemindex = 0      then SQLList.add(ProductQtyLib.StockQty(True , iProd, iClass , tSummary        , filterdateto))
            else if grpFilters.Itemindex = 1 then SQLList.add(ProductQtyLib.StockQty(True , iProd, iClass , tDetails        , filterdateto))
            else if grpFilters.Itemindex = 2 then SQLList.add(ProductQtyLib.StockQty(True , iProd, iClass , tExtraDetails   , filterdateto))
            else if grpFilters.Itemindex = 3 then SQLList.add(ProductQtyLib.StockQty(True , iProd, iClass , tDetailswithSno , filterdateto));
            SQLList.add(';');
            SQLList.add('update ' + tablename +' T Set  AvailableUOMQty = UOMQty;');
            SQLList.add('update ' + tablename +' T Set  AvailableQty = Qty;');
            SQLList.add('update ' + tablename +' T inner join  tblParts P on T.PartsID = P.PartsID set T.ProductPrintName = P.ProductPrintName ;');

            if self.IncludeNonInventoryParts then
              SQLList.add('update ' + tablename +' T inner join  tblParts P on T.PartsID = P.PartsID set T.PartType = P.PartType ;');

            SQLList.add(' delete from '+ tablename +' where gLevel >=2 '+
                                                            ' and ifnull(Batchnumber,"")=""  '+
                                                            ' and ifnull(Expirydate,0)=0  '+
                                                            ' and ifnull(TruckLoadNo , "") = ""  '+
                                                            ' and ifnull(binlocation,"")=""  '+
                                                            ' and ifnull(Binnumber,"")=""  '+
                                                            ' and  ifnull(Serialnumber,"") = ""  '+
                                                            ' and ifnull(Qty,0) =0;');
            SQLList.add(' delete from '+ tablename +' where gLevel >=3 '+
                                                            ' and ifnull(binlocation,"")=""  '+
                                                            ' and ifnull(Binnumber,"")=""  '+
                                                            ' and  ifnull(Serialnumber,"") = ""  '+
                                                            ' and ifnull(Qty,0) =0;');
            SQLList.add(' delete from '+ tablename +' where gLevel >=4 '+
                                                            ' and  ifnull(Serialnumber,"") = "";');
            if grpFilters.Itemindex = 3 then
              SQLList.add(' delete from '+ tablename +' where gLevel = 4 and  ifnull(Serialnumber,"") <> "" and ifnull(Qty,0) <=0;'); // delete serial numbers -ive Qtys as its only history

            SQLList.add('update ' +Tablename +  ' as tmp '+
                        ' inner join tblParts as P on P.PartsId = tmp.PartsID  '+
                        ' set tmp.bin = P.Multiplebins, tmp.batch = P.batch, tmp.SN = P.SNTracking, tmp.Active = P.Active;');
            SQLList.add('update ' +Tablename +  ' as tmp ' +
                        ' Set AvailableQty = (select ' + SQL4Qty(tAvailable,'PQA' , 'PQA.Qty') +
                        ' from tblPQa as PQA where  PQA.ProductID = tmp.PartsID  '+
                        ' and PQA.DEpartmentId = tmp.DepartmentID) where tmp.GLevel = 1; ' );
            SQLList.add('update ' +Tablename +  ' as tmp ' +
                        ' Set AvailableUOMQty = AvailableQty/UOMMultiplier , ' +
                        ' UOMMultiplierDesc1 = concat(" X " ,UOMMultiplier), '+
                        ' UOMMultiplierDesc2 = concat(" / " ,UOMMultiplier) '+
                        ' where tmp.GLevel = 1; ');
            if iProd <> 0 then
              SQLList.add('Delete from ' + tablename +' where PartsId <> ' + inttoStr(iprod) +' OR departmentid <> ' + intTostr(iClass) +';' );
            { now set the gLevel back }
            SQLList.add('update ' +Tablename +  ' set gLevel = 4 where gLevel = 0;');

            SQLList.add('update ' + tablename);
            SQLList.Add('inner join tblParts on tblParts.PartsId=' + TableName + '.PartsId');
            SQLList.add('set ' + tablename +'.PreferredSupplier = tblParts.PreferedSupp;');
            SQLList.add('update ' + tablename+' T ');
            SQLList.Add('inner join tblunitsofmeasure uom on uom.unitID=T.UOMID Set T.UOMVolume = UOM.Volume;');
            SQLList.add('update ' + tablename+' T Set UOMTotalAvailableVolume = UOMVolume * AvailableUOMQty;');
            SQLList.add('update ' + tablename+' T Set UOMTotalinstockVolume = UOMVolume * InstockUOMQty;');

      end;


      showProgressbar(WAITMSG, Stringcount(SQLList.text , ';')+1);
      try
        StepProgressbar;
        with Scriptmain do begin
          logtext(SQLList.Text);
          SQL.text := ChangeQuery(SQLList.Text);//, nil, MyScriptBeforeExecute);
          Execute;
        end;
      finally
        HideProgressbar;
      end;
    finally
        freeandnil(SQLList);
    end;
    if qryLookup.active then qryLookup.close;
    qryLookup.SQL.clear;
    qryLookup.SQL.add('SELECT PartsId,DepartmentID,UOM,');
    qryLookup.SQL.add('sum(UOMQty) as UOMQty,sum(InstockUOMQty) as InstockUOMQty,sum(SOUOMQty) as SOUOMQty');
    qryLookup.SQL.add('from ' + tablename);
(*    if fsfilter <> '' then fsfilter := fsfilter + ' and ';
    fsFilter := fsfilter + '  GLevel <> 1';
    if fsFilter <> '' then
      qryLookup.SQL.Add('Where ' +fsfilter);*)
    qryLookup.SQL.add('group by PartsId, DepartmentID,UOM');
    qryLookup.open;
end;
procedure TStockQtysLocationsBaseGUI.RefreshQuery;
begin
  qrymain.DisableControls;
  try
    closeDb(qrymain);
    PopulateData;
    qryMain.PArambyname('UOM').asString := uom;
    qryMain.PArambyname('AllDept').asString       := BooleantoStr(AllClasses);
    qryMain.PArambyname('DepartmentId').asInteger := SelectedClassID;
    qryMain.PArambyname('FilterIndex').asInteger  := grpfilters.itemindex;
    qryMain.PArambyname('Batchnumber').asString   := Batchno;
    qryMain.PArambyname('ExpiryDate').asDatetime  := ExpiryDate;
    qryMain.PArambyname('Binlocation').asString   := Binlocation;
    qryMain.PArambyname('Binnumber').asString     := Binnumber;
    inherited;
    if (CustomFilterString <> '') and (qryMain.Filter <> CustomFilterString) then begin
      qryMain.Filter := CustomFilterString;
      qryMain.Filtered := true;
    end;
  finally
    Qrymain.EnableControls;
  end;

end;

procedure TStockQtysLocationsBaseGUI.RefreshTotals;
var
  bm: TBookmark;
  dValue: double;
  dQty: double;
  PartName: string;
  HasHeader: boolean;
  tmpIndexFieldNames: string;
begin
  dValue := 0.0;
  dQty := 0.0;

  with qryMain do begin
    bm := GetBookmark;
    DisableControls;

    if not Empty(IndexFieldNames) then begin
      tmpIndexFieldNames := IndexFieldNames;
      IndexFieldNames := '';
    end
    else
      tmpIndexFieldNames := '';

    try
      First;
      HasHeader := False;
      PartName := FieldByName('ProductName').AsString;

      while not Eof do begin
        if not Sysutils.SameText(PartName, FieldByName('ProductName').AsString) then
          HasHeader := False;

        if Empty(qryMainBinLocation.AsString) and Empty(qryMainBinNumber.AsString) and
          Empty(qryMainbatchnumber.AsString) then begin
          dValue := dValue + qryMainValue.AsFloat;
          dQty := dQty + qryMainInstockQty.AsFloat;
          HasHeader := True;
        end
        else begin
          if HasHeader = False then begin
            dValue := dValue + qryMainValue.AsFloat;
            dQty := dQty + qryMainInstockQty.AsFloat;
          end;
        end;

        PartName := FieldByName('ProductName').AsString;
        Next;
      end;
    finally
      if not Empty(tmpIndexFieldNames) then
        IndexFieldNames := tmpIndexFieldNames;

      EnableControls;
      GotoBookmark(bm);
      FreeBookmark(bm);
    end;
  end;

  grdMain.ColumnByName('Value').FooterValue := FloatToStrF(dValue, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Qty').FooterValue := FloatToStrF(dQty, ffFixed, 15, 2);
end;

procedure TStockQtysLocationsBaseGUI.SetSelectionOptionsFor(Value: TSelectionOptions);
begin
  inherited;
(*  try ProductLookupform.pnlwidth := 220; Except end;
  try ClassLookupform.pnlwidth := 220;Except end;*)
end;
procedure TStockQtysLocationsBaseGUI.SctMainBeforeExecute(Sender: TObject;
var
  SQL: string; var Omit: Boolean);
begin
  inherited;
  Application.ProcessMessages;
end;

procedure TStockQtysLocationsBaseGUI.SetBatchNo(const Value: String);
begin
  fBatchno := Value;
  //UpdateQryMainSql;
end;

procedure TStockQtysLocationsBaseGUI.SetBinLocation(const Value: String);
begin
  fbinLocation := Value;
  //UpdateQryMainSql;
end;

procedure TStockQtysLocationsBaseGUI.SetBinnumber(const Value: String);
begin
  fBinnumber := Value;
  //UpdateQryMainSql;
end;

procedure TStockQtysLocationsBaseGUI.SetExpiryDate(
  const Value: TDatetime);
begin
  fExpiryDate := Value;
  //UpdateQryMainSql;
end;
procedure TStockQtysLocationsBaseGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMaingLevel.fieldname);
  RemoveFieldfromGrid(qryMainDepartmentID.fieldname);
  RemoveFieldfromGrid(qryMainPartsId.fieldname);
  RemoveFieldfromGrid(qryMainAutoID.fieldname);
end;

procedure TStockQtysLocationsBaseGUI.SetUOM(const Value: String);
begin
  fUOM := Value;
  //UpdateQryMainSql;
end;
end.
