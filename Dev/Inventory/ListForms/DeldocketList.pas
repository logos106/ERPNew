{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
}
unit DeldocketList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, wwdblook,  kbmMemTable,
  Shader, DAScript, MyScript, wwcheckbox;

type
  TDeldocketListGUI = class(TBaseListingGUI)
    cboClassQry: TERPQuery;
    qrySales: TERPQuery;
    qryMainProductName: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSalesDescription: TWideStringField;
    qryMainSaleID: TIntegerField;
    qryMainSaleDate: TDateField;
    qryMainType: TWideStringField;
    qryMainShipping: TWideStringField;
    qryMainComments: TWideMemoField;
    qryMainArea: TWideStringField;
    qryMaincustomername: TWideStringField;
    qryMainShipdate: TDateTimeField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainInvoiceDocNumber: TWideStringField;
    qryMainclientID: TIntegerField;
    qryMainBackOrderGlobalref: TWideStringField;
    qryMainPrintFlag: TWideStringField;
    Panel4: TPanel;
    Label4: TLabel;
    cboClass: TwwDBLookupCombo;
    qryMainPrintedBy: TWideStringField;
    btnShipExport: TDNMSpeedButton;
    qryMainSaleLineId: TIntegerField;
    qryMainshipped: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureQtySold: TFloatField;
    QryData: TERPQuery;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure grdMainDblClick(Sender: TObject);Override;
    (*procedure PrintReport(const ReportName: string; const SaleID: integer);*)
    procedure cmdPrintClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnShipExportClickold(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
    procedure btnShipExportClick(Sender: TObject);
  private
    //fSelectedBOIds:TStringlist;
    fsSelectedBOIds :STring;
    procedure PrintDelDocket(const SaleID: Integer);
    procedure SelectedBOIds(const Value: Integer);
    Procedure initdataQry;

    { Private declarations }
  public
    { Public declarations }
  protected
    procedure RefreshQuery; override;
    procedure ReadnApplyGuiPrefExtra;override;
    Procedure WriteGuiPrefExtra; Override;
    procedure SetGridColumns; Override;
    function GetReportTypeID: integer;Override;
    procedure Warnifnotshipped(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);Override;
    Procedure DoAfterallSelected;Override;
  end;

implementation

uses
  UnbalancedBinQty,
  frmPrintPickingSlips, Commonlib,systemlib, Forms, AppEnvironment, CommonFormLib,
  IntegerListObj, DatasetExporter, saleslib, BusObjPrintDoc, tcTypes, FastFuncs,
  CommonDbLib, BusObjClient, EmailUtils , ProductQtyLib,  AppEnvVirtualObj, TextFileObj, tcConst, frmMessageBase, frmMessageWithList, AusPosteParcelObj;

{$R *.dfm}
procedure TDeldocketListGUI.RefreshQuery;
begin
  if QryMain.Active then QryMain.Close;
  qryMain.Params.ParamByName('dtfrom').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('dtto').AsDate := dtTo.DateTime;
  qrymain.Params.ParamByName('ClassID').AsString := cboClassQry.FieldByName('ClassID').AsString;
  inherited;

end;

procedure TDeldocketListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ClientID');
  RemoveFieldfromGrid('Backorderglobalref');
  RemoveFieldfromGrid(qryMainSaleLineId.fieldName);
  RemoveFieldfromGrid(qryMainShipped.fieldName);
end;


procedure TDeldocketListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['PrintOptions.ShowPreview'].AsString        := BooleanToStr(chkPreview.checked);
end;

procedure TDeldocketListGUI.ReadnApplyGuiPrefExtra;
var
  x:Integer;
  oldIndex:Integer;
begin
  if GuiPrefs.Node.Exists('PrintOptions') then begin
    chkPreview.checked  := StrToboolean(GuiPrefs.Node['PrintOptions.ShowPreview'].AsString);
  end;
  oldIndex:=grpFilters.itemindex ;
  if GuiPrefs.Node.Exists('Grpfilters') then begin
    x:= GuiPrefs.Node['Grpfilters.ItemIndex'].asInteger;
    if (x > 0) and (X<3) and (grpFilters.Items.count >= x) then
      grpFilters.itemindex := x-1
    else begin
      grpFilters.itemindex  := 0;
      if grpFilters.itemindex  <> oldIndex then grpFilters.itemindex  := oldIndex;
    end;
  end;
end;

procedure TDeldocketListGUI.grpFiltersClick(Sender: TObject);
begin
GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:  GroupFilterString := 'PrintFlag = ''F'' ';
    1:  GroupFilterString := 'PrintFlag = ''T'' ';
  end;
  inherited;
end;

procedure TDeldocketListGUI.initdataQry;
var
  SaleLineIDs:String;
begin
  SaleLineIDs := selectedIds('SaleLineId');
  if SaleLineIDs = '' then SaleLineIDs := '0';

  closeDb(QryData);
  QryData.SQL.Clear;
  QryData.SQL.Add('Select S.SAleId, SL.saleLineId, C.firstName, C.company, C.street, C.Street2, C.street3, C.Suburb, C.State, c.PostCode, C.country, C.Phone, C.Faxnumber, C.Email, ');
  QryData.SQL.Add('S.Comments , ');
  QryData.SQL.Add('SL.TotalLineAmount, SL.TotalLineAmountInc,SL.UnitofMeasureShipped as UnitofMeasureShipped,SL.ProductName as ProductName , SL.LinePriceInc, SL.Product_Description,SL.TotalLineAmountinc,');
  QryData.SQL.Add('CeP.consigneePhoneonLabel ,CeP.SignatureReqd , CeP.LeaveAtAddress, CeP.ExtraDeliveryInstructions, ');
  QryData.SQL.Add('CeP.eParcelreference1, CeP.PrintEParcelreference1 , CeP.eParcelreference2, CeP.PrintEParcelreference2  , CeP.ChargeBackAcnt,');
  QryData.SQL.Add('CeP.Return_Name, CeP.Return_company, CeP.Return_street1, CeP.Return_Street2, CeP.Return_street3, CeP.Return_Suburb, CeP.Return_State, CeP.Return_PostCode ,CeP.Return_country,');
  QryData.SQL.Add('CeP.Redir_Name, CeP.Redir_company, CeP.Redir_street1, CeP.Redir_Street2, CeP.Redir_street3, CeP.Redir_Suburb, CeP.Redir_State, CeP.Redir_PostCode ,CeP.Redir_Country,CeP.EmailNotification , ');
  QryData.SQL.Add('UOM.Weight as ProductUOMWeight, UOM.Length as ProductUOMLength, UOM.Width as ProductUOMWidth, UOM.Height as ProductUOMHeight, ');
  QryData.SQL.Add('P.DangerousProduct as Dangerous, P.Reqdinsurance as Reqdinsurance, P.InsuranceAmount, ');
  QryData.SQL.Add('if(P.UndeliveredAction ="RS", "T","F") as ReturnBySea,');
  QryData.SQL.Add('if(P.UndeliveredAction ="RA", "T","F") as ReturnByAir,');
  QryData.SQL.Add('if(P.UndeliveredAction ="A", "T","F") as abandonGoods,');
  QryData.SQL.Add('if(P.UndeliveredAction ="DS", "T","F") as ReDirBySea,');
  QryData.SQL.Add('if(P.UndeliveredAction ="DS", "T","F") as ReDirbyAir,');
  QryData.SQL.Add('P.Tariffcode, P.consignmentProducttype, P.Productclassification');
  QryData.SQL.Add('From');
  QryData.SQL.Add('tblSales S');
  QryData.SQL.Add('inner join tblsaleslines SL on S.SaleId = SL.saleID');
  QryData.SQL.Add('inner join tblclients C on C.clientId = S.clientID');
  QryData.SQL.Add('LEft join tblclients_eparcel CeP on C.clientID = CeP.ClientID');
  QryData.SQL.Add('inner join tblPArts P on P.partsId = SL.productId');
  QryData.SQL.Add('inner join tblunitsofmeasure UOM on UOM.UnitID = SL.UnitOfMeasureID');
  QryData.SQL.Add('Where Sl.saleLineId in (' + SaleLineIDs +' )');
  QryData.SQL.Add('Order by SaleID');
  openDB(QryData);
end;

procedure TDeldocketListGUI.FormShow(Sender: TObject);
begin
  cboClassQry.Open;
  cboClassQry.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive]);
  cboClass.LookupValue := AppEnv.DefaultClass.DefaultClassName;
  qryMain.Close;
  inherited;
end;

procedure TDeldocketListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  cboClassQry.Connection := qryMain.Connection;
  btnShipExport.enabled := (AppEnv.RegionalOptions.RegionType = rAust) and (Appenv.CompanyPrefs.EnableAusEparcel);
end;

procedure TDeldocketListGUI.btnShipExportClick(Sender: TObject);
var
  fAusPostEParcelObj : TAusPostEParcelObj;
  filename:String;
  SaleLineIDs:String;
begin
  inherited;
  SaleLineIDs := selectedIds('SaleLineId');
  if SaleLineIDs = '' then begin
    MessageDlgXP_Vista('Please Select the records to be exported', mtWarning, [mbOK], 0);
    exit;
  end;

  if not dlgSave.Execute then exit;
  filename :=dlgSave.FileName;


  initdataQry;
  fAusPostEParcelObj:= TAusPostEParcelObj.Create;
  try
    fAusPostEParcelObj.DataQry := QryData;
    if fAusPostEParcelObj.DoExport(fileName) then
          MessageDlgXP_Vista('Data Exported into ' + Quotedstr(Filename), mtInformation, [MbOK], 0)
    else  MessageDlgXP_Vista('Data Exported Failed ', MtWarning, [MbOK], 0);
  finally
    FreeandNil(fAusPostEParcelObj);
  end;
end;

procedure TDeldocketListGUI.btnShipExportClickold(Sender: TObject);
var
  SaleLineIDs:String;
  Qryheader, Qrylines :TERPQuery;
  fileName: string;
  TF:TTextfile;
  s:String;
  ctr:Integer;
  function shipStatus(const Shipped, BO:Double):String;
  begin
    if (BO=0) and (Shipped <> 0) then result := 'Shipped'
    else if (BO<>0) and (shipped <> 0) then result := 'Partially shipped'
    else result := 'Unshipped';
  end;

begin
  inherited;
  if not dlgSave.Execute then exit;
  filename :=dlgSave.FileName;

  SaleLineIDs := selectedIds('SaleLineId');
  if SaleLineIDs = '' then exit;
  Qryheader:= TempMyQuery;
  Qrylines := TempMyQuery;
  try
    Qryheader.SQL.Text := 'SELECT DISTINCT  '+
                          ' S.SAleId   ,  '+
                          'if(' +ifnull('if('+ Ifnull('CN.contactFirstName')+'="",C.FirstName, CN.contactFirstName)')+'="" ,' + SplitField('S', 'CustomerName', 1)+' , if('+ Ifnull('CN.contactFirstName')+'="",C.FirstName, CN.contactFirstName)) as FirstName, ' +
                          'if(' +ifnull('if('+ Ifnull('CN.contactSurname')+'="",C.LastName, CN.contactSurname)')+'="" ,' + SplitField('S', 'CustomerName', 2)+' , if('+ Ifnull('CN.contactSurname')+'="",C.LastName, CN.contactSurname)) as LastName, ' +
                          ' S.customername  ,  '+
                          SplitField('S', 'InvoiceTo' , 1 , #13#10) +' as Address1 ,  '+
                          SplitField('S', 'InvoiceTo' , 2, #13#10) +' as Address2 ,  '+
                          SplitField('S', 'InvoiceTo' , 3, #13#10) +' as Address3 ,  '+
                          ' C.State,  '+
                          ' C.Postcode,  '+
                          ' if('+ifnull('C.Country')+'="" , ' + Quotedstr(Appenv.RegionalOptions.Region ) +' ,C.Country ) Country,  '+
                          ' ifnull(CN.ContactPH , C.Phone  ) phone ,  '+
                          ' ifnull(CN.ContactEmail , C.Email) as email ,  '+
                          'sum(SL.shipped) as Shipped,'+
                          'Sum(SL.BackOrder) as BackOrder,'+
                          ' S.PayMethod, '+
                          ' sum(SL.totalLineamountinc) as totalLineamountinc ,  '+
                          ' count(SL.salelineID) as linescount ,'+
                          ' S.SAleDatetime,CT.countrycode ' +
                          ' FROM tblSales S '+
                          ' INNER JOIN tblSaleslines SL on SL.SaleID = S.SaleID /*AND Invoiced = "T"*/ '+
                          ' inner join tblclients C on c.ClientId = S.clientID '+
                          ' Left join tblcontacts CN on CN.ContactID = S.contactID '+
                          ' Left join tblcountries CT on CT.Country = C.Country'+
                          ' where SL.SaleLineID in (' + SaleLineIDs +')' +
                          ' group by S.SaleID '+
                          ' Order by SAleID';
    Qrylines.SQL.text := 'SELECT DISTINCT' +
                          ' SL.SaleID , SL.productName, SL.Product_Description, totalLineAmountinc , Shipped' +
                          ' FROM  tblSaleslines SL' +
                          ' where SL.SaleLineID in (' + SaleLineIDs +') '+
                          ' Order by SAleID, ProductName';

    Qryheader.Open;    Qrylines.Open;
    Qryheader.first;   Qrylines.First;
    ctr:= 0;
    TF:= TTextfile.Create(Filename , tfmCreate);
    try
      While Qryheader.Eof = False do begin
        s:= 'C,' +
            inttostr(Qryheader.fieldbyname('SaleId').AsInteger )+','+
            Qryheader.fieldByname('firstName').AsString +',' +
            Qryheader.fieldbyname('LastName').AsString +',' +
            Qryheader.fieldbyname('customername').AsString +',' +
            Qryheader.fieldbyname('Address1').AsString +',' +
            Qryheader.fieldbyname('Address2').AsString +',' +
            Qryheader.fieldbyname('Address3').AsString +',' +
            Qryheader.fieldbyname('State').AsString +',' +
            Qryheader.fieldbyname('PostCode').AsString +',' +
            Qryheader.fieldbyname('Country').AsString +',' +
            Qryheader.fieldbyname('Countrycode').AsString +',' +
            Qryheader.fieldbyname('Phone').AsString +',' +
            Qryheader.fieldbyname('email').AsString +',' +
            Qryheader.fieldbyname('paymethod').AsString +',' +
            floatToStr(Qryheader.fieldbyname('totalLineAmountinc').AsFloat) +',' +
            '0,' +
            '0,' +
            inttostr(Qryheader.fieldbyname('linescount').asInteger) +',' +
            ',' + Shipstatus(Qryheader.fieldbyname('shipped').AsFloat, Qryheader.fieldByname('backorder').AsFloat) +',' +
            formatDatetime('yyyy-mm-dd hh:nn:ss' , Qryheader.fieldbyname('SaleDatetime').asDateTime);
          s:= replacestr(s ,  #13#10 , '' );
          s:= replacestr(s ,  chr(13) , '' );
          s:= replacestr(s ,  chr(10) , '' );
          TF.WriteLine(s);
          ctr:= ctr+1;
        while (Qrylines.Eof = False ) and (Qrylines.FieldByname('SaleID').asInteger  = Qryheader.FieldByname('SaleID').asInteger) do begin
          s:= 'A,' +
              inttostr(Qrylines.fieldbyname('SaleID').AsInteger) +',' +
              Qrylines.fieldbyname('ProductName').AsString +',' +
              Qrylines.fieldbyname('Product_Description').AsString +',' +
              floatToStr(Qrylines.fieldbyname('TotalLineAmountinc').asFloat) +',' +
              floatTostr(Qrylines.fieldbyname('Shipped').asFloat) +',,,,,,,,' ;
          s:= replacestr(s ,  #13#10 , '' );
          s:= replacestr(s ,  chr(13) , '' );
          s:= replacestr(s ,  chr(10) , '' );
          TF.WriteLine(s);
          Qrylines.Next;
        end;
        Qryheader.Next;
      end;
    finally
      grdmain.UnselectAll;
      if ctr>0 then
        MessageDlgXP_Vista('Please Refer to ' + filename +' for ' + inttostr(ctr) +' Sales record exported', mtInformation, [mbOK], 0);
      Freeandnil(TF);
    end;
  finally
    Qryheader.ClosenFree;
    Qrylines.ClosenFree;
  end;
end;

procedure TDeldocketListGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TDeldocketListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if QrymainShipped.AsFloat =0 then
    Afont.Color := clInactiveCaption;
  if sametext(field.fieldname, QrymainUnitofMeasureBackorder.FieldName) or
     sametext(field.fieldname, QrymainUnitofMeasureShipped.FieldName) or
     sametext(field.fieldname, QrymainUnitofMeasureQtySold.FieldName) then
      if Field.AsFloat = 0 then
        Afont.Color := Abrush.Color;

end;

procedure TDeldocketListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.FieldByName('Type').AsString;
  inherited;
end;

procedure TDeldocketListGUI.SelectedBOIds(const Value:Integer);
begin
  //fSelectedBOIds.Add(inttostr(Value));
  if fsSelectedBOIds <> '' then fsSelectedBOIds := fsSelectedBOIds + NL;
  fsSelectedBOIds := fsSelectedBOIds + Qrymaintype.AsString +','+ inttostr(QrymainsaleId.AsInteger) +',' +Qrymainproductname.asString +',' + QrymainUOM.AsString +',' + floatTostr(qryMainUnitofMeasureQtySold.AsFloat);

end;
procedure TDeldocketListGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer);
begin
  if (IterateProcNo=1) or (IterateProcNo=ItearteProcno4ValidateSelection) then begin
    if Qrymainshipped.AsFloat =0 then begin
        SelectedBOIds(QrymainSaleId.AsInteger);
    end;
  end;
end;
procedure TDeldocketListGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  Warnifnotshipped(grid,selecting,Accept);
end;

procedure TDeldocketListGUI.cmdPrintClick(Sender: TObject);
Var
  SaleIds:TIntegerList;
  ctr:Integer;
begin
  PrintTemplate.UseEmployeeShowPrintDialogPref:= true;
  SaleIds:=TIntegerList.create;
  try
    SelectedIds('SaleId' , SaleIds, True);
    if SaleIds.count =0 then exit;
    for ctr := 0 to SaleIds.count -1 do begin
      PrintDelDocket(SaleIds[ctr]);
    end;
  finally
    Freeandnil(SaleIds);
  end;
end;
function TDeldocketListGUI.GetReportTypeID: integer;
begin
  Result := 29;
end;

procedure TDeldocketListGUI.PrintDelDocket(const SaleID:Integer);
var
  fPrintDoc : TBusObjPrintDoc;
  s:String;
  ReportToPrint:  String;
Begin
  ReportToPrint:= '';
  if chkChooseRpt.checked then begin
    (*with TempMyQuery do try
        Sql.Add(Format('SELECT TemplName FROM tblTemplates WHERE ifnull(Active, "F")  = "T" and TypeID = %d', [29]));
        Open;
        dlgReportSelect.Items.Clear;
        if not IsEmpty then begin
          First;
          while not Eof do begin
            dlgReportSelect.Items.Add(FieldByName('TemplName').AsString);
            Next;
          end;
        end;
    finally
        ClosenFree;
    end;*)
    LoadReportTypes;
    if dlgReportSelect.Execute then ReportToPrint := dlgReportSelect.SelectedItems.Text;
  end;
  ReportToPrint := PrintDeliverydocket(SaleID, QrymainclientID.asInteger, QrymainBackOrderGlobalRef.asString, Self, chkPreview.checked, ReportToPrint);
  fPrintDoc := TBusObjPrintDoc.create(self);
  try
    if SameText(Qrymaintype.asString , 'Invoice') then s := 'TInvoice' else s:= 'TSalesOrder';
    fPrintdoc.Printdoc(s, SaleID, dtDelDock, Self.Classname ,PreviewToDocumentOutputType(chkPreview.checked) , ReportToPrint);
  finally
    Freeandnil(fPrintDoc);
  end;
  PrintTemplate.UseEmployeeShowPrintDialogPref:= False;
end;

procedure TDeldocketListGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  GrdMain.SelectAll;
  DoAfterallSelected;
end;
procedure TDeldocketListGUI.Warnifnotshipped(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  if Selecting then begin
    if Qrymainshipped.AsFloat =0 then
      timerMsg(lblDateComments, Qrymainproductname.asString +' of ' + Qrymaintype.AsString +' #' + inttostr(QrymainSaleId.AsInteger)+' is not shipped.'+
                         '''Ship Export'' will export this record with 0 Shipped Quantity.');
  end;
end;
procedure TDeldocketListGUI.DoAfterallSelected;
begin
  fsSelectedBOIds:= '';
  //fSelectedBOIds:= TStringlist.Create;
  try
    inherited;
    if fsSelectedBOIds<>'' then begin
      InitMsgParams;
      PopupMsgParams.Msgcaption := 'Warning';
      PopupMsgParams.MsgTExtForGridDelim := NL;
      PopupMsgParams.MsgTExtForGrid :=  fsSelectedBOIds;
      PopupMsgParams.displayLabels:= 'Type,ID#,Product,UOM,Quantity';
      PopupMsgParams.displayWidths:= '80,80,140,80,90';
      PopupMsgParams.Custombuttons :='"OK"' ;
      PopupMsgParams.Msg1:='The following Product(s) are backordered - not shipped.';
      PopupMsgParams.Msg2 := '''Ship Export'' will export these record(s) with 0 Shipped Quantity.' ;
      PopupMsgParams.MsgColor := Self.Color;
      TfmMessageWithList.MsgDlg;
    end;
  finally
    //FreeandNil(fSelectedBOIds);
  end;

end;

initialization
  RegisterClassOnce(TDeldocketListGUI);
end.

