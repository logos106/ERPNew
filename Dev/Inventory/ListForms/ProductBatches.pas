unit ProductBatches;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, BaseInputForm;

type
  TProductBatchesGUI = class(TBaseListingGUI)
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainPartsID: TIntegerField;
    qryMainPARTNAME: TWideStringField;
    qryMainPartsClassUOMID: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    qryMainClassId: TIntegerField;
    qryMainclassname: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainBatchno: TWideStringField;
    qryMainTruckLoadNo: TWideStringField;
    qryMainExpiryDate: TDateTimeField;
    qryMainSMEglobalref: TWideStringField;
    qryMainSMEType: TWideStringField;
    qryMainTransTypeDesc: TWideStringField;
    qryMainFormName: TWideStringField;
    qryMainAlloctype: TWideStringField;
    qryMainQtyDescription: TWideStringField;

    qryMainInStockQty: TFloatField;
    qryMainAvailableQty: TFloatField;
    qryMainAllocatedSOQty: TFloatField;
    qryMainAllocatedBOQty: TFloatField;
    qryMainOnOrderQty: TFloatField;
    qryMainSOBOQty: TFloatField;
    qryMainOnBuildQty: TFloatField;
    qryMainBuildingQty: TFloatField;
    qryMaininsQty: TFloatField;
    qryMainOutsQty: TFloatField;
    qryMainQty: TFloatField;

    qryMainUOMInStockQty: TFloatField;
    qryMainUOMAvailableQty: TFloatField;
    qryMainUOMAllocatedSOQty: TFloatField;
    qryMainUOMAllocatedBOQty: TFloatField;
    qryMainUOMOnOrderQty: TFloatField;
    qryMainUOMSOBOQty: TFloatField;
    qryMainUOMOnBuildQty: TFloatField;
    qryMainUOMBuildingQty: TFloatField;
    qryMainUOMinsQty: TFloatField;
    qryMainUOMOutsQty: TFloatField;
    qryMainUOMQty: TFloatField;
    qryMainQuantity: TFloatField;
    qryMainCUSTFLD6: TFloatField;


    grpQtys: TRadioGroup;
    Label1: TLabel;
    qryMaintransid: TIntegerField;
    qryMainGLevel: TIntegerField;
    qryMainID: TIntegerField;
    qryMainUOMID: TIntegerField;
    qryMainTranstype: TWideStringField;
    grpOptions: TwwRadioGroup;

    procedure FormCreate(Sender: TObject);
    procedure grpQtysClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);
    procedure grpOptionsClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
  private
    fiProductID: Integer;
    fiClassid: Integer;
    fsWhere:String;
    fbHighlightBatcheswithQty: Boolean;
    fsTablename :String;
    Procedure makeQrymain;
    function QrymainSQL(const aWhere :String):string;
    procedure PrepareGridSelected;
    procedure Populatedata;
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex: Integer);Override;
    Procedure SetGridColumns;override;
    Procedure AssignKeyId(Popupform :TBaseInputGUI); override;
    procedure ReadnApplyGuiPrefExtra; override;
    Procedure WriteGuiPrefExtra; override;
    Procedure inPanelcomponents(const ficmpProcess :TcmpProcessNo);override;
  public
    Procedure RefreshQuery;Override;
    Property ProductID :Integer read fiProductID write fiProductID;
    Property Classid :Integer read fiClassid write fiClassid;
    Property HighlightBatcheswithQty : Boolean read fbHighlightBatcheswithQty write fbHighlightBatcheswithQty;
  end;


implementation

uses ProductQtyLib, tcConst, PQALib, BusobjProduct, BusObjClass, MySQLConst,
  busobjStockMovement, LogLib, JSONObject, CommonLib, tcDataUtils, saleslib,
  TemplateReportsLib, Barcodeconst, AppEnvironment, busobjstockTransferentry,
  BusobjStockAdjustEntry, CommonDbLib;

{$R *.dfm}

{ TBaseListingGUI1 }

procedure TProductBatchesGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  Popupform.KeyId := 0;
  if (Sysutils.SameText(qryMainSMEType.asString , TStockTransferEntry.Transtype)) or
            (Sysutils.SameText(qryMainSMEType.asString , TStockAdjustEntry.Transtype))  then begin
     Popupform.KeyId := TStockMovement.TransactionID(QrymainTransid.asInteger);
  end;
  if Popupform.KeyId = 0 then inherited;

end;

procedure TProductBatchesGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    pnlAdvPrinting.visible := False;
    try
      inherited;
    finally
      pnlAdvPrinting.visible := True;
    end;
  finally
    EnableForm;
  end;
end;

procedure TProductBatchesGUI.DNMSpeedButton1Click(Sender: TObject);
var
  sSQL:String;
  fTemplateName, fTemplateType: string;
  Json: TJsonObject;
begin
  inherited;
  if grdMain.SelectedList.Count =0 then begin
    MessageDlgXP_vista('Please select the batches to be printed', mtWarning, [mbOK], 0);
    Exit;
  end;

  IterateProcno :=1;
  fsWhere:= '';
  IterateselectedRecords(True);
  if fsWhere = '' then begin
    MessageDlgXP_vista('Please select the batches to be printed', mtWarning, [mbOK], 0);
    Exit;
  end;
  fTemplateName := Trim(TemplateToPrINT('Batch Barcode', chkChooseRpt.checked , 'Batch Barcode'));
  fTemplateType := GetTypeNameoftemplate(fTemplateName);
  if SameText(fTemplateType,'Sales Dispatch Barcode') then begin
    ssql:= SalesDispatchBarcodeSQL(inttostr(qryMainTransid.asInteger) , '' , ''  );
    ReportSQLSupplied :=  True;
    Json:= JO;
    try
        Json.O['0'].S['master']:= 'Details';
        Json.O['0'].S['detail']:= 'RelatedParts';
        Json.O['0'].S['masterfields']:='PQADetailID';
        Json.O['0'].S['detailfields']:= 'slpqad.PQADetailID';
        PrintTemplateReport( fTemplateName , ssql , not(chkPreview.Checked) , 1 ,Json);
    finally
      Json.Free;
    end;
  end else begin
      ssql := companyInfoSQL +
            ' ~|||~{Details}'+qrymainsql(fsWhere);
      ReportSQLSupplied :=  True;
      PrintTemplateReport( fTemplateName , ssql , not(chkPreview.Checked) , 1 );
  end;
end;

procedure TProductBatchesGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer);
begin
  if iterateprocno = 1 then begin
    if fsWhere <> '' then fsWhere := fsWhere + ' or ';
    fsWhere := fsWhere + '( T.PartsId =' + inttostr(QrymainpartsID.asInteger)+' and T.ClassId =' + inttostr(QrymainClassID.asInteger) +' and ifnull(Batchno,"") =' +quotedstr(Qrymainbatchno.AsString)+')';
  end;
end;

procedure TProductBatchesGUI.PrepareGridSelected;
var
  fs: String;
begin
    RemoveFieldsfromGrid (qryMainQty.fieldname              +','+
                          qryMainInStockQty.fieldname       +','+
                          qryMainAvailableQty.fieldname     +','+
                          qryMainAllocatedSOQty.fieldname   +','+
                          qryMainAllocatedBOQty.fieldname   +','+
                          qryMainOnOrderQty.fieldname       +','+
                          qryMainSOBOQty.fieldname          +','+
                          qryMainOnBuildQty.fieldname       +','+
                          qryMainBuildingQty.fieldname      +','+
                          qryMaininsQty.fieldname           +','+
                          qryMainOutsQty.fieldname          +','+
                          qryMainUOMQty.fieldname           +','+
                          qryMainUOMInStockQty.fieldname    +','+
                          qryMainUOMAvailableQty.fieldname  +','+
                          qryMainUOMAllocatedSOQty.fieldname+','+
                          qryMainUOMAllocatedBOQty.fieldname+','+
                          qryMainUOMOnOrderQty.fieldname    +','+
                          qryMainUOMSOBOQty.fieldname       +','+
                          qryMainUOMOnBuildQty.fieldname    +','+
                          qryMainUOMBuildingQty.fieldname   +','+
                          qryMainUOMinsQty.fieldname        +','+
                          qryMainUOMOutsQty.fieldname);


    if grpQtys.itemindex in [0,2]  then begin
      if grpFilters.itemindex = 6  then fs:= 'Quantity read as ' + Quotedstr(AppEnv.DefaultClass.DefaultUOM) else fs:= '('+AppEnv.DefaultClass.DefaultUOM+')';
      With qryMainQty               do begin
                 if grpFilters.ItemIndex = 0 then  {Available}    grdmain.Selected.Add(SelectedText(fieldname, 'Available', displaywidth ,fs))
            else if grpFilters.ItemIndex = 1 then  {Stock In}     grdmain.Selected.Add(SelectedText(fieldname, 'Stock-In', displaywidth ,fs))
            else if grpFilters.ItemIndex = 2 then  {Stock Out}    grdmain.Selected.Add(SelectedText(fieldname, 'Stock-Out', displaywidth ,fs))
            else if grpFilters.ItemIndex = 3 then  {On SO}        grdmain.Selected.Add(SelectedText(fieldname, 'SO', displaywidth ,fs))
            else if grpFilters.ItemIndex = 4 then  {On Build Raw} grdmain.Selected.Add(SelectedText(fieldname, 'Build Raw', displaywidth ,fs))
            else if grpFilters.ItemIndex = 5 then  {Building}     grdmain.Selected.Add(SelectedText(fieldname, 'Building', displaywidth ,fs));
      end;
      if grpFilters.itemindex = 6 then begin
        With qryMainInStockQty        do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
        With qryMainAvailableQty      do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
        With qryMainAllocatedSOQty    do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
        With qryMainAllocatedBOQty    do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
        With qryMainOnOrderQty        do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
        With qryMainSOBOQty           do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
        With qryMainOnBuildQty        do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
        With qryMainBuildingQty       do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
        With qryMaininsQty            do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
        With qryMainOutsQty           do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
      end;
    end;

    if grpQtys.itemindex in [1,2] then begin
      if grpFilters.itemindex = 6  then fs:= 'UOM Quantities as Bought and Sold' else fs:= 'UOM';
      With qryMainUOMQty  do begin
                 if grpFilters.ItemIndex = 0 then  {Available}    grdmain.Selected.Add(SelectedText(fieldname, 'Available', displaywidth ,fs))
            else if grpFilters.ItemIndex = 1 then  {Stock In}     grdmain.Selected.Add(SelectedText(fieldname, 'Stock-In', displaywidth ,fs))
            else if grpFilters.ItemIndex = 2 then  {Stock Out}    grdmain.Selected.Add(SelectedText(fieldname, 'Stock-Out', displaywidth ,fs))
            else if grpFilters.ItemIndex = 3 then  {On SO}        grdmain.Selected.Add(SelectedText(fieldname, 'SO', displaywidth ,fs))
            else if grpFilters.ItemIndex = 4 then  {On Build Raw} grdmain.Selected.Add(SelectedText(fieldname, 'Build Raw', displaywidth ,fs))
            else if grpFilters.ItemIndex = 5 then  {Building}     grdmain.Selected.Add(SelectedText(fieldname, 'Building', displaywidth ,fs));
      end;
      if grpFilters.itemindex = 6 then begin
        With qryMainUOMInStockQty       do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
        With qryMainUOMAvailableQty     do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
        With qryMainUOMAllocatedSOQty   do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
        With qryMainUOMAllocatedBOQty   do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
        With qryMainUOMOnOrderQty       do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
        With qryMainUOMSOBOQty          do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
        With qryMainUOMOnBuildQty       do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
        With qryMainUOMBuildingQty      do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
        With qryMainUOMinsQty           do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
        With qryMainUOMOutsQty          do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
      end;
    end;
    grdmain.ApplySelected;
end;

procedure TProductBatchesGUI.FormCreate(Sender: TObject);
begin
  fsTablename := commondbLib.GetUserTemporaryTableName('Batches' );
  HaveOnlyToDate['Batch Qty As On '] := true;
  MakeQrymain;
  fbHighlightBatcheswithQty := False;
  inherited;
  SelectionOption := soClassnProduct;
  ProductID := 0;
  Classid := 0;
  InitWwRadioGroup(grpFilters);
end;

procedure TProductBatchesGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  inherited;
end;

procedure TProductBatchesGUI.FormShow(Sender: TObject);
begin
  inherited;
  EnableMultiSelect('Select Batches to Print Barcode');
  if ProductID <> 0 then begin
    SelectedProductID := ProductID;
    if assigned(ProductLookupform) then ProductLookupform.EnableLookup:= False;
  end;
end;

procedure TProductBatchesGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (qrymainglevel.asInteger = 0) then begin doBold(AFont, ABrush);DoGreenhighlight(AFont, ABrush); end;
  if (qrymainglevel.asInteger = 1) and (grpOptions.itemindex >0) then doBold(AFont, ABrush);
  HideZeroValueInNumberfield(State,Field,AFont,ABrush,true,true,true);

  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }

  if grpOptions.itemIndex = grpOptions.Items.count-1 then
    if qryMainGLevel.asInteger = 0 then    Afont.style := AFont.Style +[fsbold];
  if (qryMainGLevel.asInteger = 0) or (grpOptions.ItemIndex = 0) then
    if Sysutils.SameText(field.fieldname , qrymaintransid.fieldname) then AFont.Color := aBrush.Color;

  if fbHighlightBatcheswithQty then
    if Qrymainquantity.asFloat >0 then
      aBrush.Color := GridColhighLightGreen;
end;

procedure TProductBatchesGUI.grdMainDblClick(Sender: TObject);
begin
  if DoOnGridDataSelect(grdmain) then exit;
  if (qryMainformName.asString = '') or (qryMainTransID.asInteger = 0) then begin
    if grpOptions.ItemIndex = 0 then MessageDlgXP_Vista('This is the summary, Please select the ''Details'' option to get the transaction list to drill down to the details.' , mtinformation , [mbok] , 0)
    else if qryMainGLevel.asInteger = 0 then MessageDlgXP_Vista('This is the in-stock quantity which is the summary of all transactions. Double click on a transaction record to get the details' , mtinformation , [mbok] , 0);
    Exit;
  end;
  inherited;
end;

procedure TProductBatchesGUI.grpFiltersClick(Sender: TObject);
var
  fiID:Integer;
begin
  inherited;
    if not isformshown then Exit;
    with sctmain do begin
        SQL.clear;
               if grpFilters.ItemIndex = 0 then  {Available}    SQL.add( 'Update '+ fstablename +' set Qty = AvailableQty   ,UOMQty = UOMAvailableQty')
          else if grpFilters.ItemIndex = 1 then  {Stock In}     SQL.add( 'Update '+ fstablename +' set Qty = InsQty         ,UOMQty = UOMInsQty')
          else if grpFilters.ItemIndex = 2 then  {Stock Out}    SQL.add( 'Update '+ fstablename +' set Qty = OutsQty        ,UOMQty = UOMOutsQty')
          else if grpFilters.ItemIndex = 3 then  {On SO}        SQL.add( 'Update '+ fstablename +' set Qty = AllocatedSOQty ,UOMQty = UOMAllocatedSOQty')
          else if grpFilters.ItemIndex = 4 then  {On Build Raw} SQL.add( 'Update '+ fstablename +' set Qty = OnBuildQty     ,UOMQty = UOMOnBuildQty')
          else if grpFilters.ItemIndex = 5 then  {Building}     SQL.add( 'Update '+ fstablename +' set Qty = BuildingQty    ,UOMQty = UOMBuildingQty')
          else SQL.add( 'Update '+ fstablename +' set Qty = 0.00,UOMQty = 0.00');
        clog(SQL.text);
        fiId := qrymainid.asinteger;
        try
          ExecutewithProgress(False);
          closedb(qrymain);
          inherited RefreshQuery;
          grpQtysClick(nil);
        finally
          Qrymain.locate('ID', fiID, []);
        end;
    end;
end;

procedure TProductBatchesGUI.grpOptionsClick(Sender: TObject);
begin
  GroupFilterString := '';
  if grpOptions.itemindex =0  then
       GroupFilterString := 'GLevel = 0 or GLevel = 1 ';
  inherited grpFiltersClick(Sender);
end;

procedure TProductBatchesGUI.grpQtysClick(Sender: TObject);
begin
  PrepareGridSelected;
end;

procedure TProductBatchesGUI.inPanelcomponents( const ficmpProcess: TcmpProcessNo);
begin
  inherited;

end;

procedure TProductBatchesGUI.makeQrymain;
var
  strCaption:String;
  fs:String;
  fi:Integer;
begin
    strCaption := '';
    if ProductID <> 0 then begin
      strCaption := TProductsimple.IDToggle(ProductID);
    end;
    if Classid <> 0 then begin
      if strcaption <> '' then strCaption := strCaption +' in ' ;
      strCaption := strCaption + TDeptClass.idtoggle(Classid);
    end;
    if strCaption <> '' then begin
      StrCaption := ' Batches of ' + strCaption ;
      Self.Caption        := strCaption ;
    end;
    QrymainSQL('');

    grdmain.Selected.Clear;
    With qryMainPARTNAME          do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth , ''));
    With qryMainProductPrintName  do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth , ''));
    With qryMainclassname         do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth , ''));
    With qryMainUOM               do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth , ''));
    With qryMainBatchno           do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth , ''));
    With qryMainTruckLoadNo       do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth , ''));
    With qryMainExpiryDate        do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth , ''));
    With qryMainCUSTFLD6          do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth , ''));
    With qryMainQtyDescription    do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth , ''));
    With qryMainQuantity          do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth , ''));
    fs:= 'Quantity read as '+ Quotedstr(AppEnv.DefaultClass.DefaultUOM);
    With qryMainQty               do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth , ''));
    With qryMainInStockQty        do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainAvailableQty      do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainAllocatedSOQty    do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainAllocatedBOQty    do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainOnOrderQty        do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainSOBOQty           do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainOnBuildQty        do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainBuildingQty       do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMaininsQty            do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainOutsQty           do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    fs:= 'UOM Quantities as Bought and Sold' ;
    With qryMainUOMQty            do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainUOMInStockQty     do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainUOMAvailableQty   do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainUOMAllocatedSOQty do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainUOMAllocatedBOQty do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainUOMOnOrderQty     do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainUOMSOBOQty        do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainUOMOnBuildQty     do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainUOMBuildingQty    do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainUOMinsQty         do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainUOMOutsQty        do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth ,fs));
    With qryMainTransTypeDesc     do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth , ''));
    With qryMaintransid           do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth , ''));
    if devmode then With qryMainFormName do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth , ''));
    With qryMainAlloctype         do grdmain.Selected.Add(SelectedText(fieldname, displaylabel, displaywidth , ''));

    for fi:= 0 to qrymain.fieldcount-1 do begin
      if Qrymain.fields[fi] is TFloatField then
        with TFloatField(Qrymain.fields[fi]) do
          if sametext(copy(fieldname, length(fieldname)-2,3), 'Qty') or sametext(fieldname, 'Quantity') then
            Displayformat := QTY_FIELD_MASK;
    end;
end;

procedure TProductBatchesGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  grpQtysClick(nil);
end;

procedure TProductBatchesGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  Exit;
  if qryMainGLevel.asInteger = 0 then qryMainQtyDescription.asString := 'In-stock'
  else qryMainQtyDescription.asString := qryMainTransTypeDesc.asString;
end;

function TProductBatchesGUI.QrymainSQL(const aWhere: String): String;
begin
  Qrymain.SQL.Clear;
  Qrymain.SQL.Add('SELECT ');
  Qrymain.SQL.Add('*');
  Qrymain.SQL.Add('FROM ' + fstablename + ' T ');
  if aWhere <> '' then Qrymain.SQL.Add(' WHERE ' + aWhere );
  Qrymain.SQL.Add('ORDER BY Classname, PARTNAME, ProductPrintName, UOM,Batchno, TruckLoadNo, ExpiryDate, GLevel, transtype, transid;');
  Result := Qrymain.SQL.Text;
end;

Procedure TProductBatchesGUI.Populatedata;
  function QtyField: String;
  begin
    Result := '';
               if grpFilters.ItemIndex = 0 then begin {Available}     Result := Result + 'Round(' + SQL4Qty(tAvailable , 'PQA', DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS Qty,';
                                                                      Result := Result + 'Round(' + SQL4Qty(tAvailable , 'PQA', DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS UOMQty,';
      end else if grpFilters.ItemIndex = 1 then begin  {Stock In}     Result := Result + 'Round(' + SQL4Qty(tins       , 'PQA', DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS Qty,';
                                                                      Result := Result + 'Round(' + SQL4Qty(tins       , 'PQA', DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS UOMQty,';
      end else if grpFilters.ItemIndex = 2 then begin  {Stock Out}    Result := Result + 'Round(' + SQL4Qty(touts      , 'PQA', DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS Qty,';
                                                                      Result := Result + 'Round(' + SQL4Qty(touts      , 'PQA', DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS UOMQty';
      end else if grpFilters.ItemIndex = 3 then begin  {On SO}        Result := Result + 'Round(' + SQL4Qty(tSO        , 'PQA', DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS Qty,';
                                                                      Result := Result + 'Round(' + SQL4Qty(tSO        , 'PQA', DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS UOMQty,';
      end else if grpFilters.ItemIndex = 4 then begin  {On Build Raw} Result := Result + 'Round(' + SQL4Qty(tOnBuild   , 'PQA', DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS Qty,';
                                                                      Result := Result + 'Round(' + SQL4Qty(tOnBuild   , 'PQA', DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS UOMQty,';
      end else if grpFilters.ItemIndex = 5 then begin  {Building}     Result := Result + 'Round(' + SQL4Qty(tBuilding  , 'PQA', DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS Qty,';
                                                                      Result := Result + 'Round(' + SQL4Qty(tBuilding  , 'PQA', DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS UOMQty,';
      end else begin                                                  Result := Result + '0.00 AS Qty,';
                                                                      Result := Result + '0.00 AS UOMQty,';
      end;
  end;
begin
  With sctmain do begin
    SQL.Clear;
    SQL.Add('DROP TABLE IF EXISTS ' + fsTablename + ' ;');
    SQL.Add('CREATE TABLE ' + fsTablename + '  ( '+
	          ' ID                INT(11) NOT NULL AUTO_INCREMENT, '+
            ' PartsClassUOMID   VARCHAR(255) NULL DEFAULT NULL, '+
	          ' GLevel            INT(11)      NULL DEFAULT 0, '+
	          ' PartsID           INT(11)      NULL DEFAULT 0, '+
	          ' transid           INT(11)      NULL DEFAULT 0, '+
	          ' ClassId           INT(11)      NULL DEFAULT 0, '+
	          ' UOMID             INT(11)      NULL DEFAULT 0, '+
	          ' Transtype         VARCHAR(30)  NULL DEFAULT NULL, '+
	          ' PARTNAME          VARCHAR(100) NULL DEFAULT NULL, '+
	          ' ProductPrintName  VARCHAR(100) NULL DEFAULT NULL, '+
	          ' ClassName         VARCHAR(50)  NULL DEFAULT "", '+
	          ' UOM               VARCHAR(50)  NULL DEFAULT NULL, '+
	          ' Batchno           VARCHAR(50)  NULL DEFAULT NULL, '+
	          ' TruckLoadNo       VARCHAR(10)  NULL DEFAULT NULL, '+
	          ' ExpiryDate        DATETIME     NULL DEFAULT NULL, '+
	          ' SMEglobalref      VARCHAR(255) NULL DEFAULT NULL, '+
	          ' SMEType           VARCHAR(50)  NULL DEFAULT NULL, '+
	          ' TransTypeDesc     VARCHAR(100) NULL DEFAULT NULL, '+
	          ' FormName          VARCHAR(100) NULL DEFAULT NULL, '+
	          ' Alloctype         VARCHAR(10)  NULL DEFAULT NULL, '+
	          ' Qty               DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMQty            DOUBLE       NULL DEFAULT NULL, '+
	          ' InStockQty        DOUBLE       NULL DEFAULT NULL, '+
	          ' AvailableQty      DOUBLE       NULL DEFAULT NULL, '+
	          ' AllocatedSOQty    DOUBLE       NULL DEFAULT NULL, '+
	          ' AllocatedBOQty    DOUBLE       NULL DEFAULT NULL, '+
	          ' OnOrderQty        DOUBLE       NULL DEFAULT NULL, '+
	          ' SOBOQty           DOUBLE       NULL DEFAULT NULL, '+
	          ' OnBuildQty        DOUBLE       NULL DEFAULT NULL, '+
	          ' BuildingQty       DOUBLE       NULL DEFAULT NULL, '+
	          ' insQty            DOUBLE       NULL DEFAULT NULL, '+
	          ' OutsQty           DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMInStockQty     DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMAvailableQty   DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMAllocatedSOQty DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMAllocatedBOQty DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMOnOrderQty     DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMSOBOQty        DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMOnBuildQty     DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMBuildingQty    DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMinsQty         DOUBLE       NULL DEFAULT NULL, '+
	          ' UOMOutsQty        DOUBLE       NULL DEFAULT NULL, '+
	          ' Quantity          DOUBLE       NULL DEFAULT NULL, '+
	          ' QtyDescription    VARCHAR(255) NULL DEFAULT NULL, '+
            ' CUSTFLD6          DOUBLE       NULL DEFAULT NULL, '+
	          ' PRIMARY KEY (ID), '+
	          ' INDEX GLevel (GLevel), '+
	          ' INDEX Transtype_transid (Transtype, transid)  '+
	          ' ) COLLATE="utf8_general_ci" ENGINE=MyISAM ; ');

    if not IsLimit0selection then begin
          SQL.Add('INSERT IGNORE INTO ' + fsTablename +
                ' (GLevel, QtyDescription, PartsID, PARTNAME,ProductPrintName, ClassId, ClassName, uomid, UOM, Batchno, TruckLoadNo, ExpiryDate, CUSTFLD6, Quantity,' +
                ' TransTypeDesc, TransType, transid, FormName, Alloctype,' +
                ' Qty, UOMQty, InStockQty, AvailableQty, AllocatedSOQty, AllocatedBOQty, OnOrderQty, SOBOQty, OnBuildQty, BuildingQty, insQty, OutsQty,' +
                ' UOMInStockQty, UOMAvailableQty, UOMAllocatedSOQty, UOMAllocatedBOQty, UOMOnOrderQty, UOMSOBOQty, UOMOnBuildQty, UOMBuildingQty, UOMinsQty, UOMOutsQty) ' +
                ' SELECT ' +
                '2                     AS GLevel, ' +
                'TT.Description        AS QtyDescription,' +
                'P.PartsID             AS PartsID,  ' +
                'P.PARTNAME            AS PARTNAME,' +
                'P.ProductPrintName    AS ProductPrintName,' +
                'PC.ClassId            AS ClassId, ' +
                'PC.ClassName          AS ClassName, ' +
                'PQA.uomid             as uomid, ' +
                'PQA.UOM               AS UOM, ' +
                'PQABatch.Value        AS Batchno, ' +
                'PQABatch.TruckLoadNo  AS TruckLoadNo, ' +
                'PQABatch.ExpiryDate   AS ExpiryDate, ' +
                'PQABatch.CUSTFLD6     AS CUSTFLD6, ' +
                'if(PQA.Alloctype="OUT", 0 - PQABatch.UOMQty, PQABatch.UOMQty) AS Quantity, ' +
                'TT.Description        AS TransTypeDesc, ' +
                'PQA.transtype         AS transtype, ' +
                'PQA.transId           AS transid, ' +
                'TT.formName           AS FormName, ' +
                'PQA.Alloctype         AS Alloctype, ' +

                Qtyfield +

                 'Round(' + SQL4Qty(tInstock   ,'PQA' , DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "InStockQty",'+
                 'Round(' + SQL4Qty(tAvailable ,'PQA' , DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "AvailableQty",'+
                 'Round(' + SQL4Qty(tSO        ,'PQA' , DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "AllocatedSOQty",'+
                 'Round(' + SQL4Qty(tInvBO     ,'PQA' , DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "AllocatedBOQty",'+
                 'Round(' + SQL4Qty(tPOBO      ,'PQA' , DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "OnOrderQty",'+
                 'Round(' + SQL4Qty(tSOBO      ,'PQA' , DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "SOBOQty",'+
                 'Round(' + SQL4Qty(tOnBuild   ,'PQA' , DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "OnBuildQty",'+
                 'Round(' + SQL4Qty(tBuilding  ,'PQA' , DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "BuildingQty",'+
                 'Round(' + SQL4Qty(tins       ,'PQA' , DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "insQty",'+
                 'Round(' + SQL4Qty(touts      ,'PQA' , DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "OutsQty",'+

                 'Round(' + SQL4Qty(tInstock   ,'PQA' , DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "UOMInStockQty",'+
                 'Round(' + SQL4Qty(tAvailable ,'PQA' , DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "UOMAvailableQty",'+
                 'Round(' + SQL4Qty(tSO        ,'PQA' , DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "UOMAllocatedSOQty",'+
                 'Round(' + SQL4Qty(tInvBO     ,'PQA' , DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "UOMAllocatedBOQty",'+
                 'Round(' + SQL4Qty(tPOBO      ,'PQA' , DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "UOMOnOrderQty",'+
                 'Round(' + SQL4Qty(tSOBO      ,'PQA' , DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "UOMSOBOQty",'+
                 'Round(' + SQL4Qty(tOnBuild   ,'PQA' , DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "UOMOnBuildQty",'+
                 'Round(' + SQL4Qty(tBuilding  ,'PQA' , DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "UOMBuildingQty",'+
                 'Round(' + SQL4Qty(tins       ,'PQA' , DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "UOMinsQty",'+
                 'Round(' + SQL4Qty(touts      ,'PQA' , DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "UOMOutsQty"' +

                ' FROM ' + ProductTables(tDetails, True, True) +
                ' WHERE P.active <> "F" AND PC.ACtive <> "F" AND P.Batch <> "F"'+
                iif(ProductID<>0, ' AND PQA.productId =' + inttostr(ProductID), iif(SelectedProductID<>0, ' AND PQA.productId =' + inttostr(SelectedProductID),'' ))+
                iif(selectedClasSID<> 0 ,' AND PQA.DepartmentID = ' + IntToStr(selectedClasSID),'') +

                ' AND PQA.TransDate <' + Quotedstr(FormatDateTime(MysqlDateFormat , FilterdateTo))+
                ' GROUP BY PQA.DepartmentID, ' +
                                'P.PartsID, ' +
                                'PQA.UOMID, ' +
                                'PQA.transid, ' +
                                'IFNULL(PQABatch.Value, ""), ' +
                                'IFNULL(TruckLoadNo, ""), ' +
                                'IFNULL(PQABatch.ExpiryDate, 0), ' +
                                'PQA.TransType' +
                ' ORDER BY Classname, PARTNAME, ProductPrintName, UOM, Batchno, TruckLoadNo, ExpiryDate, GLevel, transtype, transid;');

          SQL.Add('UPDATE ' + fstablename + ' T INNER JOIN tblStockMovement SM on SM.StockmovementId = T.TransId and T.TransType = ' + QuotedStr(TStockMovementLines.classname)+
                        ' Set T.SMEglobalref = SM.StockmovementEntryglobalref , T.SMEType = SM.StockmovementEntryType  ;');

          SQL.Add('INSERT IGNORE INTO ' + fsTablename +
                 ' (GLevel,QtyDescription, PartsID,PARTNAME,ProductPrintName,ClassId,classname,uomid, UOM,Batchno,TruckLoadNo,ExpiryDate,CUSTFLD6,Quantity,'+
                 ' Qty,UOMQty,InStockQty,AvailableQty,AllocatedSOQty,AllocatedBOQty,OnOrderQty,SOBOQty,OnBuildQty,BuildingQty,insQty,OutsQty,'+
                 ' UOMInStockQty,UOMAvailableQty,UOMAllocatedSOQty,UOMAllocatedBOQty,UOMOnOrderQty,UOMSOBOQty,UOMOnBuildQty,UOMBuildingQty,UOMinsQty,UOMOutsQty) '+
                 ' Select 1 as GLevel,"In-stock" as QtyDescription, PartsID,PARTNAME,ProductPrintName,ClassId,classname,uomid, UOM,Batchno,TruckLoadNo,ExpiryDate, '+
                 ' sum(CUSTFLD6) as CUSTFLD6,Sum(Quantity) as Quantity,'+
                 ' sum(Qty),'+
                 ' sum(UOMQty),'+
                 ' sum(InStockQty),'+
                 ' sum(AvailableQty),'+
                 ' sum(AllocatedSOQty),'+
                 ' sum(AllocatedBOQty),'+
                 ' sum(OnOrderQty),'+
                 ' sum(SOBOQty),'+
                 ' sum(OnBuildQty),'+
                 ' sum(BuildingQty),'+
                 ' sum(insQty),'+
                 ' sum(OutsQty),'+
                 ' sum(UOMInStockQty),'+
                 ' sum(UOMAvailableQty),'+
                 ' sum(UOMAllocatedSOQty),'+
                 ' sum(UOMAllocatedBOQty),'+
                 ' sum(UOMOnOrderQty),'+
                 ' sum(UOMSOBOQty),'+
                 ' sum(UOMOnBuildQty),'+
                 ' sum(UOMBuildingQty),'+
                 ' sum(UOMinsQty),sum(UOMOutsQty) '+
                 ' from '+ fstablename +
                 ' Where Glevel = 2' +
                 ' group by Classid,PartsID,UOMID,Batchno,TruckLoadNo,ExpiryDate;');

          SQL.Add('INSERT IGNORE INTO  ' + fsTablename +
                 ' (GLevel,QtyDescription, PartsID,PARTNAME,ProductPrintName,ClassId,classname,uomid, UOM,CUSTFLD6,Quantity,'+
                 ' Qty,UOMQty,InStockQty,AvailableQty,AllocatedSOQty,AllocatedBOQty,OnOrderQty,SOBOQty,OnBuildQty,BuildingQty,insQty,OutsQty,'+
                 ' UOMInStockQty,UOMAvailableQty,UOMAllocatedSOQty,UOMAllocatedBOQty,UOMOnOrderQty,UOMSOBOQty,UOMOnBuildQty,UOMBuildingQty,UOMinsQty,UOMOutsQty) '+
                 ' Select 0 as GLevel,"In-stock" as QtyDescription, PartsID,PARTNAME,ProductPrintName,ClassId,classname,uomid, UOM, '+
                 ' sum(CUSTFLD6) as CUSTFLD6,Sum(Quantity) as Quantity,'+
                 ' sum(Qty),'+
                 ' sum(UOMQty),'+
                 ' sum(InStockQty),'+
                 ' sum(AvailableQty),'+
                 ' sum(AllocatedSOQty),'+
                 ' sum(AllocatedBOQty),'+
                 ' sum(OnOrderQty),'+
                 ' sum(SOBOQty),'+
                 ' sum(OnBuildQty),'+
                 ' sum(BuildingQty),'+
                 ' sum(insQty),'+
                 ' sum(OutsQty),'+
                 ' sum(UOMInStockQty),'+
                 ' sum(UOMAvailableQty),'+
                 ' sum(UOMAllocatedSOQty),'+
                 ' sum(UOMAllocatedBOQty),'+
                 ' sum(UOMOnOrderQty),'+
                 ' sum(UOMSOBOQty),'+
                 ' sum(UOMOnBuildQty),'+
                 ' sum(UOMBuildingQty),'+
                 ' sum(UOMinsQty),sum(UOMOutsQty) '+
                 ' FROM '+ fstablename +
                 ' WHERE Glevel = 2' +
                 ' GROUP BY Classid,PartsID,UOMID;');
          SQL.Add('UPDATE '+fstablename +' T Set T.PartsClassUOMID  = concat(PartsID,"-",ClassId,"-",UOMID);');

    end;
    clog(SQL.text);
    ExecutewithProgress(False);
  end;

end;

procedure TProductBatchesGUI.RefreshQuery;
begin
  showProgressbar(WaitMsg, 5);
  try
    stepProgressbar;
    Populatedata;
    stepProgressbar;
    inherited;
    stepProgressbar;
    grpQtysClick(nil);
    stepProgressbar;
  finally
    HideProgressbar;
  end;
end;

procedure TProductBatchesGUI.SetGridColumns;
begin
  inherited;

  RemoveFieldfromGrid(QrymainAlloctype.fieldname);
  RemoveFieldfromGrid(QrymainPartsId.fieldname);
  RemoveFieldfromGrid(QrymainclassID.fieldname);
  RemoveFieldfromGrid(QrymainGLevel.fieldname);
  RemoveFieldfromGrid(QrymainFormname.fieldname);
  RemoveFieldfromGrid(qryMainSMEglobalref.fieldname);
  RemoveFieldfromGrid(qryMainSMEType.fieldname);
  RemoveFieldfromGrid(qryMainID.fieldname);
  RemoveFieldfromGrid(qryMainUOMID.fieldname);
  RemoveFieldfromGrid(qryMainTranstype.fieldname);
  RemoveFieldfromGrid(qryMainPartsClassUOMID.fieldname);
end;

procedure TProductBatchesGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
    if GuiPrefs.Node.Exists('Options.Qtysindex')        then grpQtys.ItemIndex    :=  GuiPrefs.Node['Options.Qtysindex'].asInteger        else grpQtys.ItemIndex    :=  3;
    if GuiPrefs.Node.Exists('Options.FiltersIndex')     then grpFilters.ItemIndex :=  GuiPrefs.Node['Options.FiltersIndex'].asInteger     else grpFilters.ItemIndex :=  0;
    if GuiPrefs.Node.Exists('Options.OptionsIndex')     then grpOptions.ItemIndex :=  GuiPrefs.Node['Options.OptionsIndex'].asInteger     else grpOptions.ItemIndex :=  0;
    if selectedProductId = 0 then SelectedProductId := ProductLookupform.FirstRecID;
end;

procedure TProductBatchesGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.Qtysindex'].asInteger      := grpQtys.ItemIndex;
  GuiPrefs.Node['Options.FiltersIndex'].asInteger   := grpFilters.ItemIndex;
  GuiPrefs.Node['Options.OptionsIndex'].asInteger   := grpOptions.ItemIndex;
end;

initialization
  RegisterClassOnce(TProductBatchesGUI);

end.

