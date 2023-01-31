unit StockAnalysisReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  MessageConst,wwradiogroup, Shader, DNMPanel, GIFImg;

type
  TDurationFields = record
      fieldname  :String;
      Fielddisplaylabel  :String;
      groupname :String;
      DateFrom  :TdateTime;
      DateTo :Tdatetime;

  end;
  TStockAnalysisReportGUI = class(TBaseListingGUI)
    DNMSpeedButton1: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DateChange(var Message: TMessage); message SX_DatechangeMsg;
    procedure btnCustomizeClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grpFiltersClick(Sender: TObject); Override;
    procedure FormShow(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
    totalfields :Integer;
    strwhere:String;


    Procedure PopulateData;
    procedure Populatefields;


    function ClassesSelected  :String;
    function ProductsSelected :String;
    function StatenCountriesSelected  :String;
    function ProposedSmartOrderQtySQL: String;
    Procedure ExplainField(fieldname: String);
    Function GrpfiltersItemClassname :String;
    Procedure CopyGuiPrefs(Sender:TObject);
    procedure MakeSmartOrder;
  Protected
    fDurationFields : Array of TDurationFields;
    fsTablename :String;

    function Weekly           :Boolean;
    Function Monthly          :Boolean;
    function CountQuote       :Boolean;
    function CountSO          :Boolean;
    function CountSOBO        :Boolean;
    function CountFSO         :Boolean;
    function CountFSOBO       :Boolean;
    function CountINV         :Boolean;
    function CountINVBO       :Boolean;
    function CountNERPS       :Boolean;
    function CountONBUILD     :Boolean;
    function CountBUILDING    :Boolean;
    function CountTRANS       :Boolean;
    function CountADJ         :Boolean;
    function CountPO          :Boolean;
    function CountPOBO        :Boolean;
    Function CountBuilt       :Boolean;
    Procedure AddGuiPrefElements;Override;
    Procedure MakeQrymain;Virtual;abstract;
    Procedure PopulateGridFields;Virtual;abstract;
    function GrpfiltersItemidex :Integer ; virtual; abstract;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    Procedure CopyParamsto(Sender:TObject);Override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonDbLib, MySQLConst, ProductQtyLib, PQALib, dateutils, CommonLib,
  LogLib, AppEnvironment, tcConst, BusObjSales, salesAnalysisLib,
  busobjstockTransferentry, BusobjStockAdjustEntry, StockAnalysisDetailsReport,
  StockAnalysisSummaryReport, CommonFormLib, BusObjSmartOrder,
  DbSharedObjectsObj, DNMLib, ProductMovementList;


{$R *.dfm}

{ TSalesAnalysisReportGUI }

procedure TStockAnalysisReportGUI.AddGuiPrefElements;
begin
  inherited;
  GuiPrefs.Elements.Add('TStockAnalysisGuiElement', grdMain);
end;

procedure TStockAnalysisReportGUI.DateChange(var Message: TMessage);
begin
  if Weekly and (weeksbetween(Filterdatefrom , filterDateTo) > 200) then begin
    if dtFromLastDateTime <> dtFrom.DateTime then dtFrom.DateTime := incweek(filterdateto , 0-200)
    else dtTo.DateTime := incweek(filterdatefrom , 200);
  end else if Monthly and (Monthsbetween(Filterdatefrom , filterDateTo) > 200) then begin
    if dtFromLastDateTime <> dtFrom.DateTime then dtFrom.DateTime := incMonth(filterdateto , 0-200)
    else dtTo.DateTime := incMonth(filterdatefrom , 200);
  end;
  dtFromLastDateTime :=  dtFrom.DateTime;
  RefreshQuery;
end;

procedure TStockAnalysisReportGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  if Qrymain.recordcount =0 then exit;
  if selectedrecords =0 then
    if MessageDlgXP_Vista('Do You Want to Make Smart Order for All products in the List? ', mtConfirmation, [mbYes, mbNo], 0) = mryes then
      Grdmain.selectAll;
  if selectedrecords >  0 then MakeSmartOrder;
end;
procedure TStockAnalysisReportGUI.MakeSmartOrder;
var
  qry: TERPQuery;
  SmartOrder :TSmartOrder;
  success:Boolean;
begin
  Success := False;
  try
      strwhere := '';
      IterateProcno := 1;
      IterateselectedRecords;
      if strwhere ='' then exit;

      qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
      try
        Qry.sql.text := 'Select distinct P.partname , T.classid , P.PREFEREDSUPP , T.SmartOrderQty , C.classname'+
                        ' from ' + fsTablename +' T '+
                        ' inner join tblparts P on T.partsId = P.partsId '+
                        ' inner join tblclass C on T.ClassId = C.clasSId '+
                        ' where ( '+ strWhere+') and ifnull(T.SmartOrderQty , 0) >0';
        Qry.open;
        if Qry.recordcount =0 then begin
          MessageDlgXP_Vista('Based on the Selections, there is nothing to Order', mtInformation, [mbOK], 0);
          Exit;
        end;
        SmartOrder := TSmartOrder.CreateWithNewConn(Self);
        Try
          SmartOrder.load(0);
          SmartOrder.connection.BeginTransaction;
          try
            SmartOrder.New;
            SmartOrder.SmartOrderDesc := 'Smart Order Created from Stock Analysis Report';
            SmartOrder.PostDB;
            Qry.first;
            While Qry.EOF = False do begin
              SmartOrder.Lines.New;
              SmartOrder.Lines.Productname := Qry.fieldbyname('partname').asString;
              if Qry.fieldbyname('PREFEREDSUPP').asString <> '' then SmartOrder.Lines.SupplierName := Qry.fieldbyname('PREFEREDSUPP').asString;
              SmartOrder.Lines.ToPurchaseQty := Qry.fieldbyname('SmartOrderQty').asFloat;
              SmartOrder.Lines.DeptName := Qry.fieldbyname('classname').AsString;
              SmartOrder.Lines.PostDB;
              Qry.next;
            end;
            if not SmartOrder.Save then begin
              MessageDlgXP_Vista('Creation of Smart Order Failed.', mtWarning, [mbOK], 0);
              SmartOrder.connection.RollbackTransaction;
            end;
            SmartOrder.connection.CommitTransaction;
            OpenERPForm('TSmartOrderGUI' ,SmartOrder.ID);
            MessageDlgXP_Vista('Smart Order # ' + inttoStr(SmartOrder.Id) +' Created.', mtWarning, [mbOK], 0);
            Success:= true;
          Except
            on E:Exception do begin
              MessageDlgXP_Vista('Creation of Smart Order Failed.'+NL+E.message, mtWarning, [mbOK], 0);
              SmartOrder.connection.RollbackTransaction;
            end;
          end;
        Finally
          FreeandNil(SmartOrder);
        End;

      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
      end;
  finally
    if success then Closewait;
  end;
end;
procedure TStockAnalysisReportGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
begin
  inherited;
  if iterateprocno =1 then begin
     if strwhere <> '' then strwhere := strwhere +' or ';
     strwhere := strwhere +' ( T.PartsId = ' + inttoStr(qrymain.fieldbyname('PartsId').asInteger) +' and ' +
                 ' T.ClassID = ' + inttoStr(qrymain.fieldbyname('ClassID').asInteger) +')';
  end;
end;

procedure TStockAnalysisReportGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  AppEnv.Employee.StockanalysisReport := Self.classname;
end;

procedure TStockAnalysisReportGUI.FormCreate(Sender: TObject);
begin
  fstablename := commondblib.GetUserTemporaryTableName('SAR');
  IsGridcustomisable      := false;
  inherited;
  DisableSortoncolumtitleclick:= TRue;
end;

procedure TStockAnalysisReportGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(fsTablename);
  inherited;
end;

procedure TStockAnalysisReportGUI.FormShow(Sender: TObject);
begin
  inherited;
       if Self is TStockAnalysisSummaryReportGUI      then Grpfilters.ItemIndex  :=0
  else Grpfilters.ItemIndex  :=1;
  EnableMultiSelect('');
end;

Procedure TStockAnalysisReportGUI.ExplainField(fieldname:String);
var
  s:String;
  fbincrease      : Boolean;
  fbPercentage    : Boolean;
  fdQty           : Double;
  fdAvailable     : double;
  fdinstock       : double;
  fiApplytoOption : Integer;
begin
    s := replacestr(fieldname, 'field' , '');

    (*if  isinteger(s) then begin
      s := Qrymain.fieldbyname('Description').asString +' of ' +
                  Quotedstr(Qrymain.fieldbyname('Partname').asString)+' for the ' +
                  iif(Weekly , 'Week' , 'Month')+'  ' +
                  fDurationFields[strtoint(s)-1].Fielddisplaylabel+' ' +
                  fDurationFields[strtoint(s)-1].Groupname;
    end else if sametext(s , 'FinalQty') then begin
      s := 'Total of ' + Qrymain.fieldbyname('Description').asString +' of ' +
                  Quotedstr(Qrymain.fieldbyname('Partname').asString)+' from  ' +
                  Quotedstr(formatdateTime(Shortdateformat, FilterDateFrom))+' to ' +
                  Quotedstr(formatdateTime(Shortdateformat, FilterDateTo));

    end else if sametext(s , 'SmartorderQty') then begin*)
    if sametext(fieldname , 'SmartorderQty') then begin
      s := 'Proposed Smart Order Qty for  ' + Quotedstr(Qrymain.fieldbyname('Partname').asString)+' Based on Options Selected in Customise.';
      fbincrease      := not(GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_IncreaseDecrease))  or          (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_IncreaseDecrease].asInteger =0);
      fbPercentage    := not(GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_PercentageQty))     or          (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_PercentageQty].asInteger =0);
      fdQty           :=0; if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_SOQtyPeercent)     then fdQty          :=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_SOQtyPeercent].asFloat;
      fdAvailable     :=0; if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_Available)         then fdAvailable    :=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_Available].asFloat;
      fdinstock       :=0; if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_instock  )         then fdinstock      :=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_instock].asFloat;
      fiApplytoOption :=0; if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_ApplyTo)           then fiApplytoOption:=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_ApplyTo].asInteger;

      s := s +NL+' i.e. ' +
            iif(fbincrease , 'Add '  , 'Reduce ') +
            floattostr(fdQty)+' ' +
            iif(fbPercentage , '% ' , '')+
            iif(fbincrease , ' to '  , ' of  ') +
            iif(fiApplytoOption =0 , ' the Qty required to Make Product''s Available Qty ' + Quotedstr(FloattoStr(fdAvailable) ),
            iif(fiApplytoOption =1 , ' the Qty required to Make Product''s instock Qty ' + Quotedstr(FloattoStr(fdinstock) ),
            iif(fiApplytoOption =2 , ' Product''s Sales Order Qty ' ,
            iif(fiApplytoOption =3 , ' Product''s Sales Order and Sales Order Back Order Qty ' ,
            iif(fiApplytoOption =4 , ' Product''s Sales Order and Future Sales Order Qty ' ,
            iif(fiApplytoOption =5 , ' Product''s Sales Order , Future Sales Orders and SO Back Orders ' , '' )))))) +
            ' as on ' + Quotedstr(formatdatetime(FormatSettings.Shortdateformat , filterDateto));
      if (s<> '') and (s <> fieldname) then ListTimerMsg(s, nil, 30);
    end else begin
      TProductMovementForm.showList(Self, qryMain.fieldbyname('PartsId').asInteger, 0, FilterdateTo);
    end;

(*  finally
      if not(dgMultiselect in grdMain.Options) then grdMain.Options := grdMain.Options + [dgMultiselect];
      if not(dgRowSelect in grdMain.Options) then grdMain.Options := grdMain.Options + [dgRowSelect];
  end;*)
end;

procedure TStockAnalysisReportGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
    if sametext(Field.fieldname , 'Partname') or
       sametext(Field.fieldname , 'Classname') or
       sametext(Field.fieldname , 'Description') then
         ABrush.Color := clwhite;
    if Field is TFloatfield then
      if TFloatfield(Field).asfloat =0 then
         DoHide(Field,State,Afont , ABrush );//hide 0 values

end;

procedure TStockAnalysisReportGUI.grdMainDblClick(Sender: TObject);
begin

  ExplainField(Activefieldname);
  //inherited;


end;

procedure TStockAnalysisReportGUI.grpFiltersClick(Sender: TObject);
begin
  //inherited;
  if not isformshown then exit;
  if GrpfiltersItemidex = Grpfilters.ItemIndex then exit;
  if GrpfiltersItemClassname = '' then exit;

  OpenERpListForm(GrpfiltersItemClassname, CopyParamsto );
  CloseWait;
end;

function TStockAnalysisReportGUI.GrpfiltersItemClassname: String;
begin
         if Grpfilters.ItemIndex  =0 then result := TStockAnalysisSummaryReportGUI.classname
  else  result := TStockAnalysisDetailsReportGUI.classname;
end;


Procedure TStockAnalysisReportGUI.RefreshQuery;
begin
  DisableForm;
  try
       Closedb(Qrymain);
  {1--}Populatefields;
  {2--}PopulateData;
  {3--}MakeQrymain;
       inherited;
  {4--}PopulateGridfields;
  finally
    Enableform;
  end;
end;
{1------}procedure TStockAnalysisReportGUI.Populatefields;
          var
            fdDate:Tdatetime;
          begin
            SetLength(fDurationFields,0);
              fdDate:= filterdateFrom;
              if Weekly then fdDate := StartoftheWeek(fdDate)
              else fdDate := Startofthemonth(fdDate);
              Totalfields :=0;
              While fdDate <filterdateTo do begin
                Totalfields := Totalfields +1;

                SetLength(fDurationFields,Totalfields);

                fDurationFields[high(fDurationFields)].FieldName := 'field' + trim(inttostr(Totalfields));
                fDurationFields[high(fDurationFields)].Fielddisplaylabel:= iif(Weekly , inttostr(WeekOfTheYear(fddate)),MonthNumberToName(MonthOf(fdDate)));
                fDurationFields[high(fDurationFields)].groupname := iif(Weekly , MonthNumberToName(MonthOf(fdDate)) + ' ' + inttostr(YearOf(fddate)),inttostr(YearOf(fddate)));
                fDurationFields[high(fDurationFields)].Datefrom := IncSecond(fddate, 1);
                if Weekly then  fdDate := incweek (fdDate , 1)
                else            fdDate := IncMonth (fdDate , 1);
                if fddate >filterdateTo then fddate := filterdateTo;
                fDurationFields[high(fDurationFields)].DateTo := fddate;
              end;
          end;
{2------}procedure TStockAnalysisReportGUI.PopulateData;
          var
            ctr:Integer;
            Function fields(IncludeDataBeforeFrom:Boolean = True) :String;
            var  i:Integer;
            begin
              Result := '';
              if IncludeDataBeforeFrom then REsult := 'Field0';
              for i := low(fDurationFields) to high(fDurationFields) do begin
                if result <> '' then result := result +',';
                Result := Result + fDurationFields[i].Fieldname;
              end;
(*              if result <> '' then result := result +',';
                result := Result + 'FinalQty';*)

            end;
            Function Qtyfields(Qtyfield:String = 'SL.shipped'; DateField :string = 'SL.ShipDate'; extrawhere :String = '';AsOnTodate:Boolean =False) :String;
            var  i:Integer;
            begin
              Result := '';
              Result := Result + 'Round(sum(if ('+ DateField +
                                              '<= '+ quotedstr(formatDateTime(MysqlDateTimeFormat , fDurationFields[low(fDurationFields)].Dateto)) +
                                              extrawhere +'  , ' +
                                              Qtyfield+' , 0)),' +
                                             IntToStr(GeneralRoundPlaces) + ') as Field0 ,'+NL;

              for i := low(fDurationFields) to high(fDurationFields) do
                  Result := Result + 'Round(sum(if ('+ DateField +
                                              iif(AsOnTodate , '<= '+ quotedstr(formatDateTime(MysqlDateTimeFormat , fDurationFields[i].Dateto)) ,
                                                               ' between ' + quotedstr(formatDateTime(MysqlDateTimeFormat , fDurationFields[i].Datefrom))+' and ' +quotedstr(formatDateTime(MysqlDateTimeFormat , fDurationFields[i].Dateto)))+extrawhere +'  , ' +
                                              Qtyfield+' , 0)),' +
                                             IntToStr(GeneralRoundPlaces) + ') as '+fDurationFields[i].fieldname+','+NL;

                  (*Result := Result + 'Round(sum('+ Qtyfield+' ),' +
                                             IntToStr(GeneralRoundPlaces) + ') as FinalQty,'+NL;*)

            end;
            Function SQLwhere(SQLjoin, productIdfieldname, classIdfieldname:String):String;
            begin
              Result := '';
              if ProductsSelected <> '' then Result := productIdfieldname+ '  in (' +ProductsSelected +')';
              if ClassesSelected <> '' then begin
                if Result <> '' then Result := Result +' and ';
                Result := classIdfieldname+ '  in (' +ClassesSelected +')';
              end;
              if Result <> '' then Result := SQLjoin + ' ' + Result;
            end;
            Function statencountryfieldNames:String;
            begin
                result := '';
                if StatenCountriesSelected <> '' then result := 'State , country, ';
            end;
            Function statencountryfields:String;
            begin
                result := '';
                if StatenCountriesSelected <> '' then result := 'CL.State , CL.country, ';
            end;
            Function StatenCountriesFilter(ClientAlias:String ='CL'):string;
            var
              st2:TStringlist;
            begin
              REsult := '';
                if StatenCountriesSelected = '' then exit;
                st2:= TStringlist.create;
                try
                    st2.commatext := '';
                    SplitString(StatenCountriesSelected, '-' , st2);
                    if st2.Count >0 then begin
                      if st2[0]<> '' then result := ClientAlias +'.Country      ='+Quotedstr(st2[0]);
                      if result <> '' then result := result +' and ' ;
                      if st2[1]<> '' then result := result + ClientAlias +'.State ='+Quotedstr(st2[1]);
                    end;

                  if result <> '' then begin
                    result :=' and ('+result +')';
                  end;
                finally
                  Freeandnil(st2);
                end;
            end;
          begin
            With ScriptMain do begin
              SQL.clear;
              SQL.add('/*1*/drop table if exists ' + fsTablename +';');
              SQL.add('/*2*/CREATE TABLE ' + fsTablename+' ( ' +
                          ' ID          INT NOT NULL AUTO_INCREMENT,'+
                          ' FieldSeqno  INT NULL DEFAULT 0,'+
                          ' PartsId     INT NULL DEFAULT 0,'+
                          ' classId     INT NULL DEFAULT 0,'+
                          ' Partname    VARCHAR(255) NULL DEFAULT "",'+
                          ' State       VARCHAR(255) NULL DEFAULT "",'+
                          ' Country     VARCHAR(255) NULL DEFAULT "",'+
                          ' Description VARCHAR(255) NULL DEFAULT "",' +
                          ' Field0  DOUBLE NULL DEFAULT 0,');
              for ctr := low(fDurationFields) to high(fDurationFields) do
                SQL.add(fDurationFields[ctr].fieldname+' DOUBLE NULL DEFAULT 0,');

              SQL.add(' FinalQty DOUBLE NULL DEFAULT 0,'+
                      ' SmartOrderQty  DOUBLE NULL DEFAULT 0,'+
                      '  PRIMARY KEY (ID));');

{--}ctr:= I_Quote;  if CountQuote then
                SQL.add('/*' + inttostr(ctr)+' */ insert ignore into ' + fstablename +'( PartsId,ClassId,FieldSeqno ,  Partname,  ' + fields+',Description)'+NL+
                          ' select P.partsId as PartsId,S.ClassID, ' + inttostr(ctr)+' as FieldSeqno, P.partname as Partname ,  '+Qtyfields +
                          Quotedstr(salesAnalysisLib.Transtypes[ctr]) + ' as Description '+
                          ' from  tblParts P   left join (tblsaleslines SL  ' +
                                      ' inner join tblsales S on S.saleId = SL.saleId and S.isquote ="T" and S.converted ="F" and ifnull(S.Deleted,"F")="F" and ifnull(S.Cancelled,"F")="F" and ifnull(SL.Deleted,"F")="F"  '+
                                      iif(ClassesSelected <> '' , ' and S.classId in (' + ClassesSelected+')' , '') +
                                      iif(StatenCountriesSelected <> '', ' inner join tblclients CL on CL.ClientID = S.clientID ' + StatenCountriesFilter , '') +
                                      ' )  on P.partsId = SL.productId '+
                                      SQLwhere('where' , 'P.partsID', 'S.classid') +' group by P.partsID;');

{--}ctr:= I_SO; if CountSO then
                SQL.add('/*' + inttostr(ctr)+' */ insert ignore into ' + fstablename +'( PartsId,ClassId,FieldSeqno ,  Partname,  ' +statencountryfieldNames+ fields+',Description)'+NL+
                          ' select P.partsId as PartsId,pqa.DepartmentID,' + inttostr(ctr)+' as FieldSeqno, P.partname as Partname ,  '+
                          statencountryfields+
                          Qtyfields(SQL4QtyField(tSO),'PQA.transdate' , ' and FutureSO ="F"'+ iif(StatenCountriesSelected <> '', '  and ifnull(CL.clientId,0)<>0' , '' ))+
                          Quotedstr(salesAnalysisLib.Transtypes[ctr]) + ' as Description '+
                          ' from '+
                          ProductTables (tProductList) +
                          ' Left join (tblsales S ' + iif(StatenCountriesSelected <> '', ' inner join tblclients CL on CL.ClientID = S.clientID ' + StatenCountriesFilter , '') +' ) on S.saleId = PQa.transId and pqa.transtype =' +Quotedstr(TSalesorderline.className)+ ' and FutureSO ="F"' +
                          SQLwhere('where' , 'P.partsID', 'PQA.DepartmentID') +
                          ' group by P.partsID;');

{--}ctr:= I_SOBO;
              if CountSOBO then
                SQL.add('/*' + inttostr(ctr)+' */ insert ignore into ' + fstablename +'( PartsId,ClassId,FieldSeqno ,  Partname,  ' + statencountryfieldNames+fields+',Description)'+NL+
                          ' select P.partsId as PartsId,pqa.DepartmentID,' + inttostr(ctr)+' as FieldSeqno, P.partname as Partname ,  '+
                          statencountryfields+
                          Qtyfields(SQL4QtyField(tSOBO),'PQA.transdate' ,'and FutureSO ="F"' + iif(StatenCountriesSelected <> '', '  and ifnull(CL.ClientID,0)<>0' , '' ))+
                          Quotedstr(salesAnalysisLib.Transtypes[ctr]) + ' as Description '+
                          ' from '+
                          ProductTables (tProductList) +
                          ' Left join (tblsales S ' + iif(StatenCountriesSelected <> '', ' inner join tblclients CL on CL.ClientID = S.clientID ' + StatenCountriesFilter , '') +' ) on S.saleId = PQa.transId and pqa.transtype =' +Quotedstr(TSalesorderline.className)+ ' and FutureSO ="F"' +
                          SQLwhere('where' , 'P.partsID', 'PQA.DepartmentID') +
                          ' group by P.partsID;');

{--}ctr:= I_FSO;
              if CountFSO then
                SQL.add('/*' + inttostr(ctr)+' */ insert ignore into ' + fstablename +'( PartsId,ClassId,FieldSeqno ,  Partname,  ' + statencountryfieldNames+fields+',Description)'+NL+
                          ' select P.partsId as PartsId,pqa.DepartmentID,' + inttostr(ctr)+' as FieldSeqno, P.partname as Partname ,  '+
                          statencountryfields+
                          Qtyfields(SQL4QtyField(tSO),'PQA.transdate'  , 'and FutureSO ="T"'+ iif(StatenCountriesSelected <> '', '  and ifnull(CL.ClientID,0)<>0' , '' ))+
                          Quotedstr(salesAnalysisLib.Transtypes[ctr]) + ' as Description '+
                          ' from '+
                          ProductTables (tProductList) +
                          ' Left join (tblsales S ' + iif(StatenCountriesSelected <> '', ' inner join tblclients CL on CL.ClientID = S.clientID ' + StatenCountriesFilter , '') +' ) on S.saleId = PQa.transId and pqa.transtype =' +Quotedstr(TSalesorderline.className)+ ' and FutureSO ="T"' +
                          SQLwhere('where' , 'P.partsID', 'PQA.DepartmentID') +
                          ' group by P.partsID;');

{--}ctr:= I_FSOBO;
              if CountFSOBO then
                SQL.add('/*' + inttostr(ctr)+' */ insert ignore into ' + fstablename +'( PartsId,ClassId,FieldSeqno ,  Partname,  ' + statencountryfieldNames+fields+',Description)'+NL+
                          ' select P.partsId as PartsId,pqa.DepartmentID,' + inttostr(ctr)+' as FieldSeqno, P.partname as Partname ,  '+
                          statencountryfields+
                          Qtyfields(SQL4QtyField(tSOBO),'PQA.transdate'  , 'and FutureSO ="T"'+ iif(StatenCountriesSelected <> '', '  and ifnull(CL.ClientID,0)<>0' , '' ))+
                          Quotedstr(salesAnalysisLib.Transtypes[ctr]) + ' as Description '+
                          ' from '+
                          ProductTables (tProductList) +
                          ' Left join (tblsales S ' + iif(StatenCountriesSelected <> '', ' inner join tblclients CL on CL.ClientID = S.clientID ' + StatenCountriesFilter , '') +' ) on S.saleId = PQa.transId and pqa.transtype =' +Quotedstr(TSalesorderline.className)+ ' and FutureSO ="T"' +
                          SQLwhere('where' , 'P.partsID', 'PQA.DepartmentID') +
                          ' group by P.partsID;');


{--}ctr:= I_INV;
              if CountINV then
                SQL.add('/*' + inttostr(ctr)+' */ insert ignore into ' + fstablename +'( PartsId,ClassId,FieldSeqno ,  Partname,  ' + fields+',Description)'+NL+
                          ' select P.partsId as PartsId,pqa.DepartmentID,' + inttostr(ctr)+' as FieldSeqno, P.partname as Partname ,  '+
                          Qtyfields(SQL4QtyField(tTotSales),'PQA.transdate' )+
                          Quotedstr(salesAnalysisLib.Transtypes[ctr]) + ' as Description '+
                          ' from '+
                          ProductTables (tProductList) +
                          SQLwhere('where' , 'P.partsID', 'PQA.DepartmentID') +
                          ' group by P.partsID;');
{--}ctr:= I_INVBO;
              if CountINVBO then
                SQL.add('/*' + inttostr(ctr)+' */ insert ignore into ' + fstablename +'( PartsId,ClassId,FieldSeqno ,  Partname,  ' + fields+',Description)'+NL+
                          ' select P.partsId as PartsId,pqa.DepartmentID,' + inttostr(ctr)+' as FieldSeqno, P.partname as Partname ,  '+
                          Qtyfields(SQL4QtyField(tInvBO),'PQA.transdate' )+
                          Quotedstr(salesAnalysisLib.Transtypes[ctr]) + ' as Description '+
                          ' from '+
                          ProductTables (tProductList) +
                          SQLwhere('where' , 'P.partsID', 'PQA.DepartmentID') +
                          ' group by P.partsID;');


{--}ctr:= I_NERPS;
              if CountNERPS then
                SQL.add('/*' + inttostr(ctr)+' */ insert ignore into ' + fstablename +'( PartsId,ClassId,FieldSeqno ,  Partname,  ' + fields+',Description)'+NL+
                          ' select P.partsId as PartsId,S.ClassID,' + inttostr(ctr)+' as FieldSeqno, P.partname as Partname ,  '+
                          Qtyfields('SL.shipped' ,'s.saleDate' )+
                          Quotedstr(salesAnalysisLib.Transtypes[ctr]) + ' as Description '+
                          ' from '+
                          ' tblParts P  '+
                          ' left join (tblnonerpsaleslines SL inner join tblnonerpsales S on S.saleId = SL.saleId '    +
                                      iif(ClassesSelected <> '' , ' and S.classId in (' + ClassesSelected+')' , '') + ' )  '+
                              ' on P.partsId = SL.productId '+
                          iif(ProductsSelected <> '' , ' Where P.partsId in (' +ProductsSelected+')', '')+' group by P.partsID;');
{--}ctr:= I_USEDTOBuilD;
              if CountONBUILD then
                SQL.add('/*' + inttostr(ctr)+' */ insert ignore into ' + fstablename +'( PartsId,ClassId,FieldSeqno ,  Partname,  ' + fields+',Description)'+NL+
                          ' select P.partsId as PartsId,pqa.DepartmentID,' + inttostr(ctr)+' as FieldSeqno, P.partname as Partname ,  '+
                          Qtyfields(SQL4QtyField(tUSedForBuild),'PQA.transdate' )+
                          Quotedstr(salesAnalysisLib.Transtypes[ctr]) + ' as Description '+
                          ' from '+
                          ProductTables (tProductList) +
                          SQLwhere('where' , 'P.partsID', 'PQA.DepartmentID') +
                          ' group by P.partsID;');
{--}ctr:= I_ONBUILD;
              if CountONBUILD then
                SQL.add('/*' + inttostr(ctr)+' */ insert ignore into ' + fstablename +'( PartsId,ClassId,FieldSeqno ,  Partname,  ' + fields+',Description)'+NL+
                          ' select P.partsId as PartsId,pqa.DepartmentID,' + inttostr(ctr)+' as FieldSeqno, P.partname as Partname ,  '+
                          Qtyfields(SQL4QtyField(tOnBuild),'PQA.transdate' )+
                          Quotedstr(salesAnalysisLib.Transtypes[ctr]) + ' as Description '+
                          ' from '+
                          ProductTables (tProductList) +
                          SQLwhere('where' , 'P.partsID', 'PQA.DepartmentID') +
                          ' group by P.partsID;');

{--}ctr:= I_BUILDING;
              if CountBUILDING then
                SQL.add('/*' + inttostr(ctr)+' */ insert ignore into ' + fstablename +'( PartsId,ClassId,FieldSeqno ,  Partname,  ' + fields+',Description)'+NL+
                          ' select P.partsId as PartsId,pqa.departmentID,' + inttostr(ctr)+' as FieldSeqno, P.partname as Partname ,  '+
                          Qtyfields(SQL4QtyField(tBuilding),'PQA.transdate' )+
                          Quotedstr(salesAnalysisLib.Transtypes[ctr]) + ' as Description '+
                          ' from '+
                          ProductTables (tProductList) +
                          SQLwhere('where' , 'P.partsID', 'PQA.DepartmentID') +
                          ' group by P.partsID;');
{--}ctr:= I_TRANS;
              if CountTRANS    then
                SQL.add('/*' + inttostr(ctr)+' */ insert ignore into ' + fstablename +'( PartsId,ClassId,FieldSeqno ,  Partname,  ' + fields+',Description)'+NL+
                          ' select P.partsId as PartsId,pqa.departmentID,' + inttostr(ctr)+' as FieldSeqno, P.partname as Partname ,  '+
                          Qtyfields(SQL4QtyField(tStockTransnAdj),'PQA.transdate' )+
                          Quotedstr(salesAnalysisLib.Transtypes[ctr]) + ' as Description '+
                          ' from '+
                          ProductTables (tProductList) +
                          ' inner join tblstockmovement SM on SM.StockmovementID = PQA.transId and PQA.transtype in (' + StockMovementtypes +') and StockmovementEntryType = ' + quotedstr(TStockTransferEntry.XMLNodeName) +
                          SQLwhere('where' , 'P.partsID', 'PQA.DepartmentID') +
                          ' group by P.partsID;');
{--}ctr:= I_ADJ;
              if CountADJ      then
                SQL.add('/*' + inttostr(ctr)+' */ insert ignore into ' + fstablename +'( PartsId,ClassId,FieldSeqno ,  Partname,  ' + fields+',Description)'+NL+
                          ' select P.partsId as PartsId,pqa.departmentID,' + inttostr(ctr)+' as FieldSeqno, P.partname as Partname ,  '+
                          Qtyfields(SQL4QtyField(tStockTransnAdj),'PQA.transdate' )+
                          Quotedstr(salesAnalysisLib.Transtypes[ctr]) + ' as Description '+
                          ' from '+
                          ProductTables (tProductList) +
                          ' inner join tblstockmovement SM on SM.StockmovementID = PQA.transId and PQA.transtype in (' + StockMovementtypes +') and StockmovementEntryType = ' + quotedstr(TStockAdjustEntry.XMLNodeName) +
                          SQLwhere('where' , 'P.partsID', 'PQA.DepartmentID') +
                          ' group by P.partsID;');
{--}ctr:= I_PO;
              if CountPO       then
                SQL.add('/*' + inttostr(ctr)+' */ insert ignore into ' + fstablename +'( PartsId,ClassId,FieldSeqno ,  Partname,  ' + fields+',Description)'+NL+
                          ' select P.partsId as PartsId,pqa.departmentID,' + inttostr(ctr)+' as FieldSeqno, P.partname as Partname ,  '+
                          Qtyfields(SQL4QtyField(tPO),'PQA.transdate' )+
                          Quotedstr(salesAnalysisLib.Transtypes[ctr]) + ' as Description '+
                          ' from '+
                          ProductTables (tProductList) +
                          SQLwhere('where' , 'P.partsID', 'PQA.DepartmentID') +
                          ' group by P.partsID;');
{--}ctr:= I_POBO;
              if CountPOBO     then
                SQL.add('/*' + inttostr(ctr)+' */ insert ignore into ' + fstablename +'( PartsId,ClassId,FieldSeqno ,  Partname,  ' + fields+',Description)'+NL+
                          ' select P.partsId as PartsId,pqa.departmentID,' + inttostr(ctr)+' as FieldSeqno, P.partname as Partname ,  '+
                          Qtyfields(SQL4QtyField(tPOBO),'PQA.transdate' )+
                          Quotedstr(salesAnalysisLib.Transtypes[ctr]) + ' as Description '+
                          ' from '+
                          ProductTables (tProductList) +
                          SQLwhere('where' , 'P.partsID', 'PQA.DepartmentID') +
                          ' group by P.partsID;');

{--}ctr:= I_Built;
              if CountBuilt     then
                SQL.add('/*' + inttostr(ctr)+' */ insert ignore into ' + fstablename +'( PartsId,ClassId,FieldSeqno ,  Partname,  ' + fields+',Description)'+NL+
                          ' select P.partsId as PartsId,pqa.departmentID,' + inttostr(ctr)+' as FieldSeqno, P.partname as Partname ,  '+
                          Qtyfields(SQL4QtyField(tBuilt),'PQA.transdate' )+
                          Quotedstr(salesAnalysisLib.Transtypes[ctr]) + ' as Description '+
                          ' from '+
                          ProductTables (tProductList) +
                          SQLwhere('where' , 'P.partsID', 'PQA.DepartmentID') +
                          ' group by P.partsID;');

{--}ctr:= I_AVAILABLE;
                SQL.add('/*' + inttostr(ctr)+' */ insert ignore into ' + fstablename +'( PartsId,ClassId,FieldSeqno ,  Partname,  ' + fields+',Description)'+NL+
                          ' select P.partsId as PartsId,pqa.DepartmentID,' + inttostr(ctr)+' as FieldSeqno, P.partname as Partname ,  '+
                          Qtyfields(SQL4QtyField(tAvailable)+ iif(AppEnv.CompanyPrefs.CountSOBOInAvailable , '- ' + SQL4QtyField(tsobo) , ''),'PQA.transdate'  , '' , true)+
(*                          '(' +Qtyfields(SQL4QtyField(tAvailable),'PQA.transdate' )+')'+
                          iif(AppEnv.CompanyPrefs.CountSOBOInAvailable , '- (' + Qtyfields(SQL4QtyField(tsobo),'PQA.transdate' )+')' , '')+*)
                          ' '+ quotedstr(Description_Available) +' as Description '+
                          ' from '+
                          ProductTables (tProductList) +
                          iif(ProductsSelected <> '' , ' where P.partsId in (' +ProductsSelected+')', '')+' group by P.partsID;');

{--}ctr:= I_instock;
                SQL.add('/*' + inttostr(ctr)+' */ insert ignore into ' + fstablename +'( PartsId,ClassId,FieldSeqno ,  Partname,  ' + fields+',Description)'+NL+
                          ' select P.partsId as PartsId,pqa.DepartmentID,' + inttostr(ctr)+' as FieldSeqno, P.partname as Partname ,  '+
                          Qtyfields(SQL4QtyField(tinstock),'PQA.transdate'   , '' , true)+
                          ' '+ quotedstr(Description_Instock) +' as Description '+
                          ' from '+
                          ProductTables (tProductList) +
                          iif(ProductsSelected <> '' , ' where P.partsId in (' +ProductsSelected+')', '')+' group by P.partsID;');

ctr:= ctr+1;    SQL.add('/*' + inttostr(ctr)+' */update ' + fstablename +' Set ClassId = ' + IntToStr(AppEnv.DefaultClass.ClassID) +' where ifnull(ClassId,0)=0;');
ctr:= ctr+1;    SQL.add('/*' + inttostr(ctr)+' */update ' + fstablename +' Set finalQty = ' + replacestr(fields(False) ,',' , '+')+' where description <> '+ quotedstr(Description_Available) +' and description <> '+ quotedstr(Description_Instock) +' ;');
ctr:= ctr+1;    SQL.add('/*' + inttostr(ctr)+' */update ' + fstablename +' Set finalQty = ' + fDurationFields[high(fDurationFields)].fieldname + ' where description = '+ quotedstr(Description_Available) +' OR description = '+ quotedstr(Description_Instock) +' ;');
ctr:= ctr+1;    SQL.add('/*' + inttostr(ctr)+' */Drop table if exists ' + fstablename +'1;');
ctr:= ctr+1;    SQL.add('/*' + inttostr(ctr)+' */Create table ' + fstablename +'1 ' + ProposedSmartOrderQtySQL+';');
ctr:= ctr+1;    SQL.add('/*' + inttostr(ctr)+' */ALTER TABLE ' + fstablename +'1  ADD INDEX `PartsId`       ( PartsId);' );
ctr:= ctr+1;    SQL.add('/*' + inttostr(ctr)+' */ALTER TABLE ' + fstablename +'  ADD INDEX `PartsId`       ( PartsId);' );
ctr:= ctr+1;    SQL.add('/*' + inttostr(ctr)+' */ALTER TABLE ' + fstablename +'  ADD INDEX `classId`       ( classId);' );
ctr:= ctr+1;    SQL.add('/*' + inttostr(ctr)+' */update  ' + fstablename +' T inner join  ' + fstablename +'1 T1 on T.partsId = T1.PartsId Set T.SmartOrderQty = T1.SmartOrderQty;');
ctr:= ctr+1;    SQL.add('/*' + inttostr(ctr)+' */Drop table if exists ' + fstablename +'1;');
                clog(SQl.Text);
                ShowProgressbar(WAITMSG, SQL.count); try Execute; Finally HideProgressbar; End;
            end;
          end;

Function TStockAnalysisReportGUI.ProposedSmartOrderQtySQL:String;
var
  fbincrease :boolean;
  fbPercentage:Boolean;
  fdQty :double;
  fdAvailable:double;
  fdinstock:double;
  fiApplytoOption :Integer;
  Function Sumfield:String;
  begin
    REsult := 'sum(finalQty)';
    if fiApplytoOption =0 then result := ' sum(' +floattostr(fdAvailable)+'- FinalQty) '
    else if fiApplytoOption =1 then result := ' sum(' +floattostr(fdinstock)+'- FinalQty) ';;
  end;
begin
  fbincrease      := not(GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_IncreaseDecrease))  or          (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_IncreaseDecrease].asInteger =0);
  fbPercentage    := not(GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_PercentageQty))     or          (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_PercentageQty].asInteger =0);
  fdQty           :=0; if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_SOQtyPeercent)     then fdQty          :=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_SOQtyPeercent].asFloat;
  fdAvailable     :=0; if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_Available)         then fdAvailable    :=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_Available].asFloat;
  fdinstock       :=0; if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_instock  )         then fdinstock      :=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_instock].asFloat;
  fiApplytoOption :=0; if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_ApplyTo)           then fiApplytoOption:=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_ApplyTo].asInteger;

  REsult :=' Select PartsId, ';
  REsult := result +' ' +SumField;
  if fdQty <> 0 then  begin
         if  fbincrease       and  fbPercentage       then REsult := result +' + ' + SumField+' * ' +floattostr(fdQty)+' /100 '
    else if  not(fbincrease)  and  fbPercentage       then REsult := result +' - ' + SumField+' * ' +floattostr(fdQty)+' /100 '
    else if  (fbincrease)     and  not(fbPercentage)  then REsult := result +' + ' +floattostr(fdQty)
    else if  not(fbincrease)  and  not(fbPercentage)  then REsult := result +' - ' +floattostr(fdQty);
  end;
  Result := REsult +' as SmartOrderQty ';
  Result := REsult +' from '+ fsTablename;
  case fiApplytoOption of
    0:REsult := result +' where FieldSeqno = '+ inttostr(I_AVAILABLE)+' and FinalQty <'+floattoStr(fdAvailable);
    1:REsult := result +' where FieldSeqno = '+ inttostr(I_instock)+' and FinalQty <'+floattoStr(fdinstock);
    2:REsult :=REsult +' where FieldSeqno = '+ inttostr(I_SO);
    3:REsult :=REsult +' where ( FieldSeqno = '+ inttostr(I_SO)+' or FieldSeqno = '+ inttostr(I_SOBO)+')';
    4:REsult :=REsult +' where ( FieldSeqno = '+ inttostr(I_SO)+' or FieldSeqno = '+ inttostr(I_FSO)+')';
    5:REsult :=REsult +' where ( FieldSeqno = '+ inttostr(I_SO)+' or FieldSeqno = '+ inttostr(I_FSO)+' or FieldSeqno = '+ inttostr(I_SOBO)+' or FieldSeqno = '+ inttostr(I_FSOBO)+')';
  end;
  REsult :=REsult +' Group by PartsId';



end;
procedure TStockAnalysisReportGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  HideProgressbar;
end;

procedure TStockAnalysisReportGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  ShowProgressbar(WAITMSG, 10);
  StepProgressbar;
end;

procedure TStockAnalysisReportGUI.btnCustomizeClick(Sender: TObject);
begin
  Disableform;
  try
    inherited;
    RefreshQuery;
  finally
    Enableform;
  end;
end;
function TStockAnalysisReportGUI.StatenCountriesSelected:String;begin result := '';if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_AllStatenCountries) and GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_AllStatenCountries].asBoolean  then exit; if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_StatenCountry) then Result := GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_StatenCountry].asString;end;
function TStockAnalysisReportGUI.ClassesSelected        :String;begin result := '';if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_AllClasses        ) and GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_AllClasses].asBoolean          then exit; if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_SelectedClasses) then Result := GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_SelectedClasses].asString;end;
function TStockAnalysisReportGUI.ProductsSelected       :String;begin result := '';if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_AllProducts       ) and GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_AllProducts].asBoolean         then exit; if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_SelectedParts)   then Result := GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_SelectedParts].asString  ;end;
Function TStockAnalysisReportGUI.Weekly :Boolean; begin Result :=     GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_ReportDuration) and (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_ReportDuration].asInteger = 0); end;
Function TStockAnalysisReportGUI.Monthly:Boolean; begin Result := not(GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_ReportDuration)) or (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_ReportDuration].asInteger = 1); end;

Function TStockAnalysisReportGUI.CountQuote   :Boolean; begin Result :=     GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[1]))  and (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[1])].asBoolean) ; end;
Function TStockAnalysisReportGUI.CountSO      :Boolean; begin Result :=     GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[2]))  and (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[2])].asBoolean) ; end;
Function TStockAnalysisReportGUI.CountSOBO    :Boolean; begin Result :=     GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[3]))  and (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[3])].asBoolean) ; end;
Function TStockAnalysisReportGUI.CountFSO     :Boolean; begin Result :=     GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[4]))  and (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[4])].asBoolean) ; end;
Function TStockAnalysisReportGUI.CountFSOBO   :Boolean; begin Result :=     GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[5]))  and (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[5])].asBoolean) ; end;
Function TStockAnalysisReportGUI.CountNERPS   :Boolean; begin Result :=     GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[6]))  and (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[6])].asBoolean) ; end;
Function TStockAnalysisReportGUI.CountINV     :Boolean; begin Result :=     GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[7]))  and (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[7])].asBoolean) ; end;
Function TStockAnalysisReportGUI.CountINVBO   :Boolean; begin Result :=     GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[8]))  and (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[8])].asBoolean) ; end;
Function TStockAnalysisReportGUI.CountONBUILD :Boolean; begin Result :=     GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[10]))  and (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[10])].asBoolean) ; end;
Function TStockAnalysisReportGUI.CountBUILDING:Boolean; begin Result :=     GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[11])) and (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[11])].asBoolean); end;
Function TStockAnalysisReportGUI.CountTRANS   :Boolean; begin Result :=     GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[12])) and (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[12])].asBoolean); end;
Function TStockAnalysisReportGUI.CountADJ     :Boolean; begin Result :=     GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[13])) and (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[13])].asBoolean); end;
Function TStockAnalysisReportGUI.CountPO      :Boolean; begin Result :=     GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[14])) and (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[14])].asBoolean); end;
Function TStockAnalysisReportGUI.CountPOBO    :Boolean; begin Result :=     GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[15])) and (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[15])].asBoolean); end;
Function TStockAnalysisReportGUI.CountBuilt   :Boolean; begin Result :=     GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[16])) and (GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[16])].asBoolean); end;
procedure TStockAnalysisReportGUI.CopyGuiPrefs(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  if sender is TStockAnalysisReportGUI then
    if GuiPrefs.Node.Exists(NodeName_grdmainOptions) then begin
        if not TStockAnalysisReportGUI(Sender).GuiPrefs.Active then TStockAnalysisReportGUI(Sender).GuiPrefs.Active := true;
        if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_AllClasses      ) then   TStockAnalysisReportGUI(Sender).GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_AllClasses      ].asBoolean  :=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_AllClasses      ].asBoolean ;
        if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_AllProducts     ) then   TStockAnalysisReportGUI(Sender).GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_AllProducts     ].asBoolean  :=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_AllProducts     ].asBoolean ;
        if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_IncreaseDecrease) then   TStockAnalysisReportGUI(Sender).GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_IncreaseDecrease].asInteger  :=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_IncreaseDecrease].asInteger ;
        if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_SOQtyPeercent   ) then   TStockAnalysisReportGUI(Sender).GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_SOQtyPeercent   ].asInteger  :=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_SOQtyPeercent   ].asInteger ;
        if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_PercentageQty   ) then   TStockAnalysisReportGUI(Sender).GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_PercentageQty   ].asfloat    :=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_PercentageQty   ].asfloat   ;
        if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_ApplyTo         ) then   TStockAnalysisReportGUI(Sender).GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_ApplyTo         ].asInteger  :=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_ApplyTo         ].asInteger ;
        if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_Available       ) then   TStockAnalysisReportGUI(Sender).GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_Available       ].asfloat    :=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_Available       ].asfloat   ;
        if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_instock         ) then   TStockAnalysisReportGUI(Sender).GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_instock         ].asfloat    :=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_instock         ].asfloat   ;
        if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_SelectedParts   ) then   TStockAnalysisReportGUI(Sender).GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_SelectedParts   ].asString   :=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_SelectedParts   ].asString  ;
        if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_SelectedClasses ) then   TStockAnalysisReportGUI(Sender).GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_SelectedClasses ].asString   :=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_SelectedClasses ].asString  ;
        if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_StatenCountry ) then   TStockAnalysisReportGUI(Sender).GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_StatenCountry ].asString   :=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_StatenCountry ].asString  ;
        for ctr := low(Transtypes) to high(Transtypes) do
          if GuiPrefs.Node.Exists(NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[ctr])) then
            TStockAnalysisReportGUI(Sender).GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[ctr])].asBoolean :=GuiPrefs.Node[NodeName_grdmainOptions+'.'+NodeName_TransType+'.'+nodename(Transtypes[ctr])].asBoolean;
    end;
end;

procedure TStockAnalysisReportGUI.CopyParamsto(Sender: TObject);
begin
  inherited;
  CopyGuiPrefs(Sender);
end;

end.
