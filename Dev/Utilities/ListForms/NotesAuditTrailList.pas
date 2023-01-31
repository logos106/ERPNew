unit NotesAuditTrailList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, ERPDbLookupCombo, DAScript,
  MyScript, wwcheckbox;

type



  TNotesAuditTrailListGUI = class(TBaseListingGUI)
    cboClientLookup: TERPQuery;
    cboProductQry: TERPQuery;
    cboProductQryPARTSID: TIntegerField;
    cboProductQryPARTTYPE: TWideStringField;
    cboProductQryPARTNAME: TWideStringField;
    cboProductQryPARTSDESCRIPTION: TWideStringField;
    cboProductQryPurchaseDesc: TWideStringField;
    cboProductQryFirstcolumn: TWideStringField;
    cboProductQrySecondcolumn: TWideMemoField;
    cboProductQryThirdcolumn: TWideMemoField;
    cboClientLookupClientID: TIntegerField;
    cboClientLookupCompany: TWideStringField;
    pnlCustomer: TDNMPanel;
    pnlProduct: TDNMPanel;
    cboClientR: TERPDbLookupCombo;
    Label4: TLabel;
    lblClassTitle: TLabel;
    cboProduct: TERPDbLookupCombo;
    qryMainGlobalRef: TWideStringField;
    qryMainAuditID: TIntegerField;
    qryMainTransType: TWideStringField;
    qryMainTransGlobalRef: TWideStringField;
    qryMainDataDescription: TWideMemoField;
    qryMainAuditDate: TDateTimeField;
    qryMainEmployeeName: TWideStringField;
    qryMainChangesDetails: TWideMemoField;
    qryMainFieldName: TWideStringField;
    qryMainDataname: TWideStringField;
    cboProductQryActive: TWideStringField;
    qryMainNotesOldValue: TStringField;
    qryMainNoteschangedValue: TStringField;
    chkallcustomers: TCheckBox;
    chkAllProducts: TCheckBox;
    qryMainCategory: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure cboClientRCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboProductCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboProductQryAfterOpen(DataSet: TDataSet);
    procedure chkallcustomersClick(Sender: TObject);
    procedure chkAllProductsClick(Sender: TObject);
  private
    tablename :String;
    fiCustomerId: Integer;
    fiProductId: Integer;
    procedure PopulateTempTable;
    procedure SetCustomerId(const Value: Integer);
    procedure SetProductID(const Value: Integer);
    procedure OnBeforeExecuteSQL(Sender: TObject; var SQL: string;var Omit: Boolean);

  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;

  public
    Procedure RefreshQuery;Override;
    Property CustomerId :Integer read fiCustomerId write SetCustomerId;
    Property ProductId :Integer read fiProductId write SetProductID;
  end;

implementation

uses CommonLib, ProductQtyLib, StrUtils, types, CommonDbLib,
  frmnotesAuditMsgPopup, MySQLConst, AppEnvironment, tcDataUtils, FastFuncs,
  StoredProcedures,DateUtils, tcConst, SystemLib;

{$R *.dfm}

procedure TNotesAuditTrailListGUI.cboClientRCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not (modified) then exit;
  ficustomerId := cboClientLookupClientId.asInteger;
  chkallcustomers.checked :=ficustomerId=0;
  RefreshQuery;
end;


procedure TNotesAuditTrailListGUI.cboProductCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not (modified) then exit;
  fiProductId := cboProductQryPartsId.asInteger;
  chkallProducts.checked :=fiProductId=0;
  RefreshQuery;
end;

procedure TNotesAuditTrailListGUI.cboProductQryAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cboProductQryThirdColumn.DisplayLabel  := AppEnv.DefaultClass.ThirdColumn;
  cboProductQrySecondColumn.DisplayLabel := AppEnv.DefaultClass.SecondColumn;
  cboProductQryFirstColumn.DisplayLabel  := AppEnv.DefaultClass.FirstColumn;
end;

procedure TNotesAuditTrailListGUI.chkallcustomersClick(Sender: TObject);
begin
  inherited;
  fiCustomerId :=0;
  cboClientR.text := '';
  RefreshQuery;
end;

procedure TNotesAuditTrailListGUI.chkAllProductsClick(Sender: TObject);
begin
  inherited;
  fiProductId:= 0;
  cboProduct.text := '';
  RefreshQuery;
end;

procedure TNotesAuditTrailListGUI.FormCreate(Sender: TObject);
begin
  createSP('VersionToNo');
  createSP('SecondsBetween');
  TableName := CreateUserTemporaryTable('tmp_notesaudittraillist');
  Qrymain.SQL.clear;
  Qrymain.SQL.Add('Select * ');
  Qrymain.SQL.Add('from ' +tablename );

  fiCustomerId:=0;
  fiProductId :=0;
  inherited;
  cboClientR.SpcialLookupItemList.Text := '';
  cboProduct.SpcialLookupItemList.Text := '';
end;

procedure TNotesAuditTrailListGUI.PopulateTempTable;
var
  s:String;
  function ChangeField(const FieldName:String):String;
  begin
    REsult := ' substring(A.ChangedFields , LOCATE("' + FieldName +' - ",A.ChangedFields)  , Locate( ";" , substring(A.ChangedFields , LOCATE("'+FieldName+' - ",A.ChangedFields)) ))   ' ;
  end;
  Function SQLForauditTrial(Transtype,Datadescription, FieldName, DataName, DataSQL, ClientIDfieldname :String;ProductIDfieldName:String):String;
  begin
  Result := ' SELECT ' +
            ' 1, A.GlobalRef, ' +
            ' A.AuditID, ' +
            ' A.TransType, ' +
            ' A.TransGlobalref as TransGlobalRef, ' +
            ' A.DataDescription, ' +
            ' A.AuditDate, ' +
            ' E.EmployeeName, ' +
            changefield(FieldName) + ' as ChangesDetails,  ' +
            Quotedstr(FieldName) + '  as FieldName, ' +
            'DT.' +DataName + ' as Dataname'+
            ' FROM tblaudittrail A  INNER JOIN tblemployees E on E.EmployeeID = A.EmployeeID ' +
            ' INNER JOIN ' + DataSQL + ' as DT on DT.Globalref =   A.TransGlobalref'+
            ' /*LEFT join tblaudittriallines AL on A.AuditId = AL.auditID */' +
            ' WHERE  /*ifnull(AL.AuditID,0) =0 and */ VersionToNo(ifnull(applicationVersion,"")) <= "9007" and  A.TransType = '+ quotedstr(Transtype) ;
  if (ClientIDfieldname <> '') and (fiCustomerID<>0)  then REsult := Result + ' and DT.' +  ClientIDfieldname + ' = ' +inttostr( fiCustomerId);
  if (ProductIDfieldName<> '') and (fiProductId<>0) then REsult := Result + ' and DT.' +  ProductIDfieldName+ ' = ' +inttostr( fiProductId);
  REsult := Result + ' and A.DataDescription = '+ quotedstr(Datadescription) +
            ' and A.ChangedFields like "%'+FieldName+' - %" '+
            ' and AuditDate Between ' + Quotedstr(formatDateTime(MySQLDateTimeformat , filterdateFrom))+' AND ' + Quotedstr(formatDateTime(MySQLDateTimeformat , filterdateTo))+' ';
  Result :=  REsult + ' union all SELECT ' +
            ' 2, A.GlobalRef, ' +
            ' A.AuditID, ' +
            ' A.TransType, ' +
            ' A.TransGlobalref as TransGlobalRef, ' +
            ' A.DataDescription, ' +
            ' A.AuditDate, ' +
            ' E.EmployeeName, ' +
            'concat(ifnull(AL.OldValue, "") , '+ Quotedstr(chr(255)) +',ifnull(Al.NewValue, "")) as ChangesDetails,  ' +
            Quotedstr(FieldName) + '  as FieldName, ' +
            'DT.' +DataName + ' as Dataname'+
            ' FROM tblaudittrail A  INNER JOIN tblemployees E on E.EmployeeID = A.EmployeeID ' +
            ' INNER join tblaudittriallines AL on A.AuditId = AL.auditID ' +
            ' INNER JOIN ' + DataSQL + ' as DT on DT.Globalref =   A.TransGlobalref'+
            ' WHERE  A.TransType = '+ quotedstr(Transtype) ;
  if (ClientIDfieldname <> '') and (fiCustomerID<>0)  then REsult := Result + ' and DT.' +  ClientIDfieldname + ' = ' +inttostr( fiCustomerId);
  if (ProductIDfieldName<> '') and (fiProductId<>0) then REsult := Result + ' and DT.' +  ProductIDfieldName+ ' = ' +inttostr( fiProductId);
  REsult := Result + ' and A.DataDescription = '+ quotedstr(Datadescription) +
            ' and AL.fieldname like "%'+FieldName+'%" '+
            ' and AuditDate Between ' + Quotedstr(formatDateTime(MySQLDateTimeformat , filterdateFrom))+' AND ' + Quotedstr(formatDateTime(MySQLDateTimeformat , filterdateTo))+' ';
  end;
begin
  s:= 'truncate ' +tablename +';';
  if (ficustomerID<> 0) or (chkallcustomers.checked) then
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('Customer'       ,  'Main' ,  'Notes'          , 'Company'      , 'tblclients'           ,'ClientId',''   ) +';' ;
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('Supplier'       ,  'Main' ,  'Notes'          , 'Company'      , 'tblclients'           ,'ClientId',''   ) +';' ;
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('Other Contact'  ,  'Main' ,  'Notes'          , 'COMPANY'      , 'tblclients'           ,'ClientId',''   ) +';' ;
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('Quote'          ,  'Main' ,  'Comments'       , 'CustomerName' , 'tblsales'             ,'ClientId',''   ) +';' ;
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('SalesOrder'     ,  'Main' ,  'Comments'       , 'CustomerName' , 'tblsales'             ,'ClientId',''   ) +';' ;
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('Invoice'        ,  'Main' ,  'Comments'       , 'CustomerName' , 'tblsales'             ,'ClientId',''   ) +';' ;
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('CashSale'       ,  'Main' ,  'Comments'       , 'CustomerName' , 'tblsales'             ,'ClientId',''   ) +';' ;
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('RefundSale'     ,  'Main' ,  'Comments'       , 'CustomerName' , 'tblsales'             ,'ClientId',''   ) +';' ;
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('PurchaseOrder'  ,  'Main' ,  'Comments'       , 'SupplierName' , 'tblpurchaseorders'    ,'ClientId',''  ) +';' ;
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('ReturnAuthority',  'Main' ,  'Comments'       , 'SupplierName' , 'tblpurchaseorders'    ,'ClientId',''   ) +';' ;
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('Bill'           ,  'Main' ,  'Comments'       , 'SupplierName' , 'tblpurchaseorders'    ,'ClientId',''   ) +';' ;
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('Credit'         ,  'Main' ,  'Comments'       , 'SupplierName' , 'tblpurchaseorders'    ,'ClientId',''   ) +';' ;
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('Cheque'         ,  'Main' ,  'Comments'       , 'SupplierName' , 'tblpurchaseorders'    ,'ClientId',''   ) +';' ;
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('MarketingContact', 'Main' ,  'Notes'          , 'COMPANY'      , 'tblmarketingcontacts' ,'ClientId',''   ) +';' ;
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('Messages'       ,  'Main' ,  'Details'        , 'Name'         , 'tblmessages'          ,'FromId'  ,''   ) +';' ;
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('PhoneSupportLog',  'Main' ,  'Issue'          , 'Company'      , 'tblphonesupportlog'   ,'ClientId',''   ) +';' ;
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('PhoneSupportLog',  'Main' ,  'Solution'       , 'Company'      , 'tblphonesupportlog'   ,'ClientId',''   ) +';' ;
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('Repairs'        ,  'Main' ,  'Notes'          , 'CustomerName' , 'tblrepairs'           ,'cusId'   ,''   ) +';' ;
    s:= s+ 'insert into  ' +tablename +'(Category,GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
        SQLForauditTrial('Repairs'        ,  'Main' ,  'FeedbackNotes'  , 'CustomerName' , 'tblrepairs'           ,'cusid'   ,''   ) +';';

  if (fiProductId <> 0) or (chkAllProducts.checked) then begin
    s:= s+ 'insert into  ' +tablename +'(category, GlobalRef,AuditID,TransType,TransGlobalRef,DataDescription,AuditDate,EmployeeName,ChangesDetails,FieldName,Dataname)  ' +
          SQLForauditTrial('Product'        ,  'Main' ,  'PRODUCTCOMMENT' , 'Partname'     , 'tblPArts','' , 'PartsID' ) ;
  end;
  showprogressbar(WaitMsg , 40);
  try
    ExecuteSQL(s, nil, OnBeforeExecuteSQL);
  finally
    HideProgressbar;
  end;
end;
procedure TNotesAuditTrailListGUI.OnBeforeExecuteSQL(Sender: TObject;  var SQL: string; var Omit: Boolean);
begin
  inherited;
  StepProgressbar;
end;

procedure TNotesAuditTrailListGUI.FormShow(Sender: TObject);
begin
  (* if  fiCustomerId <> 0 then  *)grdmain.RowHeightPercent := 200;
(*   cboClientLookup.Parambyname('SearchValue').asString := '';
  cboClientLookup.ParambyName('SearchMode').asInteger := 3; *)
  opendb(cboClientLookup);
(*   cboProductQry.Parambyname('SearchValue').asString := '';
  cboProductQry.ParambyName('SearchMode').asInteger := 3; *)
  opendb(cboProductQry);
  inherited;
end;

procedure TNotesAuditTrailListGUI.grdMainDblClick(Sender: TObject);
begin
  TfmnotesAuditMsgPopup.Memopopup(qrymain);
end;



procedure TNotesAuditTrailListGUI.qryMainCalcFields(DataSet: TDataSet);
const
  sds: array[1..2] of String = (AuditTrialOldValue , AuditTrialNewValue);
var
  s:String;
  strArray: Array[1..3] of String;
  i1,i2:Integer;
begin
  inherited;
  if QrymainChangesDetails.asString = '' then exit;
  s:= QrymainChangesDetails.asString;
  if QrymainCategory.asInteger = 1 then begin
    i1:= Pos(sds[1] , s);
    i2:= Pos(sds[2] , s);

    strArray[1] := copy(s, 1 , i1 -1    ) ;
    strArray[2] := copy(s, i1, i2-i1    ) ;
    strArray[3] := copy(s, i2, Length(s)) ;

    strArray[2] := Replacestr(strArray[2],sds[1]  , '') ;
    strArray[3] := Replacestr(strArray[3],sds[2]  , '') ;
    if copy(strArray[3] , length(strArray[3]) , 1) = ';' then strArray[3] := copy(strArray[3] , 1, Length(strArray[3])-1);
    qryMainNotesOldValue.asString :=strArray[2];
    qryMainNoteschangedValue.asString :=strArray[3];
  end else begin
    qryMainNotesOldValue.asString :=copy(s, 1,pos(chr(255),s)-1);
    qryMainNoteschangedValue.asString :=replacestr(replacestr(s,qryMainNotesOldValue.asString,''),chr(255) , '');
  end;
end;

procedure TNotesAuditTrailListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('General') then begin
    if fiCustomerId =0 then if GuiPrefs.Node['General.Allcustomer'].AsString <> '' then chkallcustomers.checked :=  Strtoboolean(GuiPrefs.Node['General.Allcustomer'].AsString);
    if fiproductId =0 then if GuiPrefs.Node['General.AllProducts'].AsString <> '' then chkallProducts.checked :=  Strtoboolean(GuiPrefs.Node['General.AllProducts'].AsString);
  end;
end;

procedure TNotesAuditTrailListGUI.RefreshQuery;
begin
  Processingcursor(True);
  try
    PopulateTempTable;
    inherited;
  finally
    ProcessingCursor(False);
  end;
end;

procedure TNotesAuditTrailListGUI.SetCustomerId(const Value: Integer);
begin
  fiCustomerId := Value;
  CloseDB(cboClientLookup);
  cboClientLookup.Parambyname('SearchValue').asString := tcdatautils.getClientName(Value);
  cboClientLookup.ParambyName('SearchMode').asInteger := 1;
  chkallCustomers.checked :=fiCustomerId=0;
  opendb(cboClientLookup);
  cboClientR.text := cboClientLookupcompany.asString;
end;

procedure TNotesAuditTrailListGUI.SetProductID(const Value: Integer);
begin
  fiProductId := Value;
  CloseDB(cboProductQry);
  cboProductQry.Parambyname('SearchValue').asString := tcdatautils.GetProduct(Value);
  cboProductQry.ParambyName('SearchMode').asInteger := 1;
  chkallProducts.checked :=fiProductId=0;
  opendb(cboProductQry);
  cboProduct.text := cboProductQryPartname.asString;
end;

procedure TNotesAuditTrailListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['General.Allcustomer'].AsString:= booleanToStr(chkallcustomers.checked);
  GuiPrefs.Node['General.AllProducts'].AsString:= booleanToStr(chkallProducts.checked);
end;

initialization
  RegisterClassOnce(TNotesAuditTrailListGUI);
end.

