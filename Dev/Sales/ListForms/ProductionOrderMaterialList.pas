unit ProductionOrderMaterialList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel, Mask, wwdbedit, BusobjTemplateOptions , JsonObject , CorrespondenceObj,
  GIFImg;

type
  TProductionOrderMaterialListGUI = class(TBaseListingGUI)
    qryMainSAleId: TIntegerField;
    qryMainSaleProduct: TWideStringField;
    qryMainSaleProductDescription: TWideStringField;
    qryMainSaleProductUOM: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainLineno: TIntegerField;
    qryMainItem: TWideStringField;
    qryMainItemuom: TWideStringField;
    qryMainItemDEscription: TWideStringField;
    qryMainItemInfo: TWideMemoField;
    qryMainFromStockUOMQty: TFloatField;
    qryMainManufactureUOMQty: TFloatField;
    qryMainManufacturedUOMQty: TFloatField;
    qryMainManufacturingUOMQty: TFloatField;
    qryMainOnOrderUOMQty: TFloatField;
    qryMainCompleted: TWideStringField;
    qryMainrownum: TLargeintField;
    qryMaintobeBuitQty: TFloatField;
    qryMainTreeItem: TWideStringField;
    qryMainSaleLineId: TLargeintField;
    qryMainTreePartUOMTotalQty: TFloatField;
    edtcompleteQty: TwwDBEdit;
    qryMaincompleteQty: TFloatField;
    qryMainProctreeID: TLargeintField;
    qryMainHasChildren: TWideStringField;
    qryMainOrderedQty: TFloatField;
    qryMainProducedQty: TFloatField;
    qryMainCustomerId: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainShipDate: TDateTimeField;
    pnlHideRawMaterials: TDNMPanel;
    chkHideRawMaterials: TCheckBox;
    qryMainChildCaption: TWideStringField;
    qryMainChildTotalQty: TFloatField;
    qryMainChildQtyPer: TFloatField;
    qryMainProducedChildQty: TFloatField;
    qryMaincompleteChildQty: TFloatField;
    qryMaintobeBuitChildQty: TFloatField;
    qryMainSalesChildQtyPer: TFloatField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qryMainAfterPost(DataSet: TDataSet);
    procedure qryMainBeforePost(DataSet: TDataSet);
    procedure grdMainKeyPress(Sender: TObject; var Key: Char);
    procedure grdMainColExit(Sender: TObject);
    procedure grdMainExit(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure edtcompleteQtyDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure chkHideRawMaterialsClick(Sender: TObject);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
  private
    fsTablename :String;
    fbUpdatingQty :Boolean;
    fsReportSQL:String;
    procedure MakeTable;
    procedure OncompleteQtyChange;
    Procedure initReporttoPrint;
    procedure PopulatereportSQL(const CompletingQty:Double);
  Protected
    procedure SetGridColumns; Override;
    procedure AfterPopup(Popupform:TComponent);Override;
    procedure initPrintTemplateOptionsReport(Sender: TTemplateOptions;var ssql: String; var MasterDetailLink: TJsonObject;var ShowCancelPreviewBtninReportPreview: Boolean);Override;
    procedure initCorresforPrintTemplateOptionsReport(Sender: TTemplateOptions;var  OutGoingFileName:String;var Corres: TCorrespondenceGui);Override;
    function GetReportTypeID: integer; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;


  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, frmSalesOrder, CommonDbLib, MySQLConst, tcConst, LogLib,
  TemplateReportsLib, AppEnvironment , tcDataUtils , dateutils, ManufactureLib,
  SystemLib;

{$R *.dfm}

{ TProductionOrderMaterialListGUI }

procedure TProductionOrderMaterialListGUI.AfterPopup(Popupform: TComponent);
begin
  inherited;
  if popupform is TSalesOrderGUI then begin
    with TSalesOrderGUI(popupform) do begin
      if SAlesOrder.Lines.locate(SAlesOrder.Lines.idfieldname, qryMainSaleLineId.asInteger , []) then ;
    end;
  end;
end;

procedure TProductionOrderMaterialListGUI.chkHideRawMaterialsClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol = chkHideRawMaterials then else exit;
  Closedb(Qrymain);
  opendb(Qrymain);
end;

procedure TProductionOrderMaterialListGUI.cmdCloseClick(Sender: TObject);
begin
  if fbUpdatingQty then exit;
  inherited;

end;

procedure TProductionOrderMaterialListGUI.cmdPrintClick(Sender: TObject);
begin
  (*inherited;
  initReporttoPrint;*)
  fsReportSQL:= '';
  try
    PopulatereportSQL(0);
    TTemplateOptions.DoPrintreports(self, 'ProductionProgressBuild'      ,'', PrintTemplateOptionsReport);
  finally
    fsReportSQL:= '';
  end;
end;

procedure TProductionOrderMaterialListGUI.edtcompleteQtyDblClick(Sender: TObject);
begin
  inherited;
    if MessageDlgXP_vista('Do You Wish to Complete the Remaining Qty ' + Floattostrf(qrymaintobeBuitQty.asfloat, ffGeneral, 15,2) +'?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
      EditDB(Qrymain);
      qryMaincompleteQty.asfloat := qrymaintobeBuitQty.asfloat;
      qryMaincompletechildQty.asfloat := qryMaincompleteQty.asfloat *qryMainchildqtyper.asfloat;
      PostDB(Qrymain);
    end;
end;

procedure TProductionOrderMaterialListGUI.FormCreate(Sender: TObject);
var
  fiBomLevels , level :Integer;
  s:String;
begin
  fiBomLevels := BOMTreeLevels;

  fbUpdatingQty :=False;
  fsTablename := GetUserTemporaryTableName('POL');
  Qrymain.SQL.Clear;
  Qrymain.SQL.add('select');
  Qrymain.SQL.add('T.*  ');
  Qrymain.SQL.add('from '+ fstablename +' T');
  Qrymain.SQL.add('Where ((:HideRawMaterial ="T" and ifnull(PTID'+LvlNo(fiBomLevels-1)+',0) <>0 and ifnull(PTID'+LvlNo(fiBomLevels)+',0) =0) or (:HideRawMaterial ="F" and ifnull(PTID'+LvlNo(fiBomLevels-1)+',0) <>0))');
  //Qrymain.SQL.add('Order by saleId desc , SaleProduct ,saleLineId,  sequencedown');


  for level := 1 to fiBomLevels do begin
      s:= 'caption'+LvlNo(Level);
      if Qrymain.findfield(s) = nil then
          with TWideStringfield.Create(Self) do begin
            fieldKind := fkData;
            fieldname := s;
            name := ComponentName(self, 'Qrymain'+fieldname);
            DataSet := qryMain;
            visible := True;
            Displaywidth := 20;
            DisplayLabel := 'Item-'+LvlNo(Level);
          end;
      s:= 'PTID'+LvlNo(Level);
      if Qrymain.findfield(s) = nil then
          with TIntegerfield.Create(Self) do begin
            fieldKind := fkData;
            fieldname := s;
            name := ComponentName(self, 'Qrymain'+fieldname);
            DataSet := qryMain;
            visible := False;
          end;
      s:= 'totalQty'+LvlNo(Level);
      if Qrymain.findfield(s) = nil then
          with TFloatfield.Create(Self) do begin
            fieldKind := fkData;
            fieldname := s;
            name := ComponentName(self, 'Qrymain'+fieldname);
            DataSet := qryMain;
            visible := False;
          end;
      s:= 'QtyPer'+LvlNo(Level);
      if Qrymain.findfield(s) = nil then
          with TFloatfield.Create(Self) do begin
            fieldKind := fkData;
            fieldname := s;
            name := ComponentName(self, 'Qrymain'+fieldname);
            DataSet := qryMain;
            visible := True;
            Displaylabel :='Qty Per-'+LvlNo(Level);
            DisplayWidth :=10;
          end;
      s:= 'SequenceUp'+LvlNo(Level);
      if Qrymain.findfield(s) = nil then
          with TIntegerfield.Create(Self) do begin
            fieldKind := fkData;
            fieldname := s;
            name := ComponentName(self, 'Qrymain'+fieldname);
            DataSet := qryMain;
            visible := False;
          end;
      s:= s;
      if Qrymain.findfield(s) = nil then
          with TIntegerfield.Create(Self) do begin
            fieldKind := fkData;
            fieldname := s;
            name := ComponentName(self, 'Qrymain'+fieldname);
            DataSet := qryMain;
            visible := False;
          end;
  end;
  inherited;
  DateRangetype := drShort;
end;

procedure TProductionOrderMaterialListGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(fstablename);
  inherited;

end;

procedure TProductionOrderMaterialListGUI.FormShow(Sender: TObject);
begin
  inherited;
    lblNote.caption := '"Double Click on ' + quotedstr(replacestr(qryMaincompletechildQty.DisplayLabel , '~' , ''))+' Field to Complete the Remaining Qty."';
    lblNote.REfresh;
    lblNote.visible := True;

end;

function TProductionOrderMaterialListGUI.GetReportTypeID: integer;
begin
  REsult := GetTemplateTypeId('Sales Order');
end;

procedure TProductionOrderMaterialListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  try
(*    if sametext(Field.Fieldname, qryMainSAleId.fieldname) or
       sametext(Field.Fieldname, qryMainSaleProduct.fieldname) or
       sametext(Field.Fieldname, qryMainSaleProductDescription.fieldname) or
       sametext(Field.Fieldname, qryMainSaleProductUOM.fieldname) or
       sametext(Field.Fieldname, qryMainUnitofMeasureQtySold.fieldname) or
       sametext(Field.Fieldname, qryMainUnitofMeasureShipped.fieldname) or
       sametext(Field.Fieldname, qryMainUnitofMeasureBackorder.fieldname) then
       if qrymainrownum.asInteger >1 then DoHide(Field,State,AFont,ABrush)
       else doBold(AFont,ABrush);*)

    if sametext(Field.Fieldname, qryMainLineno.fieldname) and (qryMainLineno.asInteger =0) then
        DoHide(Field,State,AFont,ABrush);

    if qryMaintobeBuitQty.asFloat >0 then
      if sametext(Field.Fieldname, qryMainCompleteChildQty.fieldname)  then
        DoGreenhighlight(AFont,ABrush);
  except

  end;
end;

procedure TProductionOrderMaterialListGUI.grdMainColExit(Sender: TObject);
begin
  inherited;
  if sametext(activefieldname, qrymaincompletechildqty.fieldname) and (qrymaincompletechildqty.asFloat <> 0) then
    OncompleteQtyChange;
end;

procedure TProductionOrderMaterialListGUI.grdMainDblClick(Sender: TObject);
begin
  if sametext(activefieldname ,qryMaincompletechildQty.fieldname) then begin
    edtcompleteQtyDblClick( edtcompleteQty);
    Exit;
  end;
  inherited;

end;

procedure TProductionOrderMaterialListGUI.grdMainExit(Sender: TObject);
begin
  inherited;
  if sametext(activefieldname, qrymaincompletechildqty.fieldname) and (qrymaincompletechildqty.asFloat <> 0) then
    OncompleteQtyChange;
end;

procedure TProductionOrderMaterialListGUI.grdMainKeyPress(Sender: TObject;
  var Key: Char);
begin
  // binny : completeQty is editable in this form
  try
  if sametext(activefieldname, qryMaincompletechildQty.fieldname) then else
  inherited;
  except

  end;
end;

procedure TProductionOrderMaterialListGUI.grpFiltersClick(Sender: TObject);
begin
       if grpFilters.itemindex = 0 then groupfilterString := qryMaintobeBuitQty.fieldname +' <= 0'
  else if grpFilters.itemindex = 1 then groupfilterString := qryMaintobeBuitQty.fieldname +' > 0'
  else groupfilterString := '';
  inherited;
end;

procedure TProductionOrderMaterialListGUI.RefreshQuery;
begin
  (*InitDateFromnDateto;
  qrymain.parambyname('TreeOnly').asString := iif(grpFilters.itemindex = 0 , 'F' , 'T');*)
  MakeTable;
  inherited;
end;
procedure TProductionOrderMaterialListGUI.qryMainAfterPost(DataSet: TDataSet);
begin
  inherited;
  OncompleteQtyChange;
end;
Procedure TProductionOrderMaterialListGUI.PopulatereportSQL(const CompletingQty:Double);
begin
  //if CompletingQty =0 then CompletingQty := qryMainProducedQty.AsFloat;
fsReportSQL :=  companyInfoSQL('CompanyInfo')+NL+'~|||~' +
               ColumnHeadingsSQL('ColumnHeadings')+NL+'~|||~' +
               '{itemDetails}Select '+  inttostr(qryMainSAleId.asInteger)                 +' as SAleID '                                    +', '+
                                        Quotedstr(qryMainSaleProduct.asString)            +' as  ' + qryMainSaleProduct.fieldname           +',' +
                                        Quotedstr(qryMainSaleProductDescription.asString) +' as  ' + qryMainSaleProductDescription.fieldname+',' +
                                        Quotedstr(qryMainSaleProductUOM.asString)         +' as  ' + qryMainSaleProductUOM.fieldname        +',' +
                                        FloattoStr(qryMainUnitofMeasureQtySold.AsFloat)   +' as  ' + qryMainUnitofMeasureQtySold.fieldname  +',' +
                                        FloattoStr(qryMainUnitofMeasureShipped.AsFloat)   +' as  ' + qryMainUnitofMeasureShipped.fieldname  +',' +
                                        FloattoStr(qryMainUnitofMeasureBackorder.AsFloat) +' as  ' + qryMainUnitofMeasureBackorder.fieldname+',' +
                                        inttostr(qryMainLineno.asInteger)                 +' as  ' + qryMainLineno.fieldname                +',' +
                                        Quotedstr(qryMainItem.asString)                   +' as  ' + qryMainItem.fieldname                  +',' +
                                        Quotedstr(qryMainItemuom.asString)                +' as  ' + qryMainItemuom.fieldname               +',' +
                                        Quotedstr(qryMainItemDEscription.asString)        +' as  ' + qryMainItemDEscription.fieldname       +',' +
                                        Quotedstr(qryMainItemInfo.asString)               +' as  ' + qryMainItemInfo.fieldname              +',' +
                                        FloattoStr(qryMainFromStockUOMQty.AsFloat)        +' as  ' + qryMainFromStockUOMQty.fieldname       +',' +
                                        FloattoStr(qryMainManufactureUOMQty.AsFloat)      +' as  ' + qryMainManufactureUOMQty.fieldname     +',' +
                                        FloattoStr(qryMainManufacturedUOMQty.AsFloat)     +' as  ' + qryMainManufacturedUOMQty.fieldname    +',' +
                                        FloattoStr(qryMainManufacturingUOMQty.AsFloat)    +' as  ' + qryMainManufacturingUOMQty.fieldname   +',' +
                                        FloattoStr(qryMainOnOrderUOMQty.AsFloat)          +' as  ' + qryMainOnOrderUOMQty.fieldname         +',' +
                                        Quotedstr(qryMainCompleted.asString)              +' as  ' + qryMainCompleted.fieldname             +',' +
                                        inttostr(qryMainrownum.asInteger)                 +' as  ' + qryMainrownum.fieldname                +',' +
                                        FloattoStr(qryMaintobeBuitQty.AsFloat)            +' as  ' + qryMaintobeBuitQty.fieldname           +',' +
                                        Quotedstr(qryMainTreeItem.asString)               +' as  ' + qryMainTreeItem.fieldname              +',' +
                                        inttostr(qryMainSaleLineId.asInteger)             +' as  ' + qryMainSaleLineId.fieldname            +',' +
                                        FloattoStr(qryMainTreePartUOMTotalQty.AsFloat)    +' as  ' + qryMainTreePartUOMTotalQty.fieldname   +',' +
                                        FloattoStr(qryMaincompleteQty.AsFloat)            +' as  ' + qryMaincompleteQty.fieldname           +',' +
                                        inttostr(qryMainProctreeID.asInteger)             +' as  ' + qryMainProctreeID.fieldname            +',' +
                                        Quotedstr(qryMainHasChildren.asString)            +' as  ' + qryMainHasChildren.fieldname           +',' +
                                        FloattoStr(qryMainOrderedQty.AsFloat)             +' as  ' + qryMainOrderedQty.fieldname            +',' +
                                        FloattoStr(qryMainProducedQty.AsFloat)            +' as  ' + qryMainProducedQty.fieldname           +',' +
                                        iif(CompletingQty=0 ,FloattoStr(qryMainProducedQty.AsFloat),FloattoStr(CompletingQty))+' as  CompletingQty'+',' +
                                        iif(Qrymainhaschildren.AsBoolean , FloattoStr(QrymainManufacturedUOMQty.asFloat) ,FloattoStr(qrymainManufacturingUOMQty.asFloat))+' +' +FloattoStr(CompletingQty) +' as  ProducedQtyAfter,' +
                                        Quotedstr(formatDateTime(FormatSettings.shortdateformat +' HH:NN:SS AM/PM', now))+' as BuiltTime,'+
                                        FloattoStr(qrymaintobeBuitQty.asfloat) +' -' +FloattoStr(CompletingQty) +' as  tobeBuitQtyAfter ' +
                                        ' From DUAL  '+NL+'~|||~' +
               '{SalesDetails}Select * from tblsales where saleId = ' + inttostr(QrymainsaleId.asInteger)+NL+'~|||~' +
               '{TreeDetails}Select PT.* from tblsaleslines SL '+
                      ' inner join tblproctree PT on SL.salelineid = PT.MasterId and PT.MasterType <> "mtProduct"   '+
                      ' where Sl.saleLineId = ' + inttostr(QrymainsalelineId.asInteger);
               logtext(fsReportSQL);
end;
procedure TProductionOrderMaterialListGUI.OncompleteQtyChange;
var
  fd:Double;
  fiUpdatedProctreeId:Integer;
  fiProctreeId:Integer;
begin
  inherited;
  if fbUpdatingQty then exit;
  fiProctreeId := 0;
  try
    Qrymain.Disablecontrols;
    try
      fiProctreeId:= qrymainProctreeId.asInteger;
      DisableForm;
      Try
          fsReportSQL := '';
          fbUpdatingQty := True;
          try
          if qryMaincompletechildQty.asfloat >0 then begin
            if not Userlock.Lock('tblsales' , qrymainsaleId.asInteger , 'ProductionOrderList') then begin
              MessageDlgXP_Vista(ReplaceStr(Userlock.LockMessage, 'this record', 'Sales Order #' + inttostr(QrymainsaleId.asInteger)), mtWarning, [mbOK], 0);
              editDb(qrymain);
              qryMaincompletechildQty.asfloat := 0;
              PostDb(qrymain);
              Exit;
            end;
            try
              fd:= qrymaincompletechildqty.asfloat;
              if fd>0 then fd:= round(fd / qryMainChildQtyPer.asFloat,5);
              if fd> qrymaintobeBuitQty.asfloat then fd:= qrymaintobeBuitQty.asfloat;
              if fd <=0 then begin
                editDb(qrymain);
                qryMaincompletechildQty.asfloat := 0;
                PostDb(qrymain);
                exit;
              end;
              populatereportsql(fd);

              fiUpdatedProctreeId:=qrymainproctreeid.asInteger;
              try
                with scriptmain do begin
                  SQL.clear;
                  if Qrymainhaschildren.AsBoolean then
                        SQL.add('update tblproctree Set ManufacturedUOMQty = ManufacturedUOMQty + ' +floattostr(fd) +' where ProctreeId  = ' + inttostr(fiUpdatedProctreeId))
                  else  SQL.add('update tblproctree Set ManufacturingUOMQty = ManufacturingUOMQty + ' +floattostr(fd) +' where ProctreeId  = ' + inttostr(fiUpdatedProctreeId));
                  Execute;
                end;
                ReportSQLSupplied := True;
                //PrintTemplateReport('Production Progress Build' , fsReportSQL, Not(Appenv.Employee.ShowPreview) , 1 );

                Application.ProcessMessages;
                closedb(qrymain);
                RefreshQuery;
              finally
                if qrymain.locate('proctreeId' , fiUpdatedProctreeId , []) then begin
                         if (Appenv.companyprefs.PrintOnItemcompletion and (qryMaintobeBuitQty.asfloat =0)) OR
                            (Appenv.companyprefs.PrintOnItemProgress) then begin
                              ListtimerMsg('Please Wait ...  Printing Production Progress Build Report');
                              try
                                TTemplateOptions.DoPrintreports(self, 'ProductionProgressBuild'      ,'', PrintTemplateOptionsReport);
                              finally
                                hideTimerMsg;
                              end;
                            end;
                end;

                grdmain.SetActiveField(qryMaincompletechildQty.fieldname);
              end;
            finally
              Userlock.UnLock('tblsales' , qrymainsaleId.asInteger , 'ProductionOrderList');
            end;
          end;
          finally
            fbUpdatingQty := false;
            fsReportSQL := '';
          end;
      Finally
        Enableform;
      End;
    finally
      qrymain.Locate('ProctreeId' ,fiProctreeId , []);
      grdmain.SetActiveField(qrymaincompleteChildQty.fieldname);
      Qrymain.Enablecontrols;
    end;
  Except
    // kill the exception
  end;
end;
procedure TProductionOrderMaterialListGUI.initCorresforPrintTemplateOptionsReport(Sender: TTemplateOptions; var OutGoingFileName: String;var Corres: TCorrespondenceGui);
begin
  inherited;
  OutGoingFileName := getOutGoingFileName('',' ' + inttostr(Sender.typeID) + ' #' + inttostr(QrymainSaleId.asInteger), '.PDF');
                              Corres.CustomerId := QrymainCustomerID.asInteger;
                              Corres.Subject := 'Production Progress Build';
                              Corres.RecipientList := SalesOrderEmployeeEmail(QrymainSaleId.asInteger);
                              Corres.MessageText := 'Production Progress Build';

end;

procedure TProductionOrderMaterialListGUI.initPrintTemplateOptionsReport(Sender: TTemplateOptions;
                                                   var  ssql:String;
                                                   var  MasterDetailLink: TJsonObject;
                                                   var  ShowCancelPreviewBtninReportPreview :Boolean);
begin
  ReportSQLSupplied := True;
  ssql:=fsReportSQL;
end;

procedure TProductionOrderMaterialListGUI.initReporttoPrint;
var
  s:String;
begin
  s:= '';
  if ReporttoPrint <> '' then s:='Selected Template :'+ Quotedstr(ReporttoPrint);
  Showcontrolhint(LblChooseTemplate ,s);
  Showcontrolhint(ChkChooseRpt ,s);
  Showcontrolhint(pnlAdvPrinting ,s);
end;

procedure TProductionOrderMaterialListGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Qrymain.parambyname('HideRawMaterial').asString := Booleantostr(chkHideRawMaterials.checked);
end;

procedure TProductionOrderMaterialListGUI.qryMainBeforePost(DataSet: TDataSet);
begin
  inherited;
  if qryMaincompletechildQty.asfloat <0 then qryMaincompletechildQty.asfloat := 0;
end;

procedure TProductionOrderMaterialListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainrownum.fieldname);
  RemoveFieldfromGrid(qryMainSaleLineId.fieldname);
  RemoveFieldfromGrid(qryMainCustomerId.fieldname);

  {these are qtys based on sales, they only want to see the Qty per }
  RemoveFieldfromGrid(qryMainProducedQty.fieldname);
  RemoveFieldfromGrid(qryMaincompleteQty.fieldname);
  RemoveFieldfromGrid(qryMaintobeBuitQty.fieldname);

end;

procedure TProductionOrderMaterialListGUI.MakeTable;
var
  fiBomLevels, level:Integer;
  function BOOMLEvelfields:String;
  var
    filevel :Integer;
  begin
    result := '';
    for filevel := 1 to fiBomLevels do
      result := result +',PTID'+ LvlNo(fiLevel) +',parentId'+ LvlNo(fiLevel);

  end;
begin
  fiBomLevels := BOMTreeLevels;

  with scriptmain do begin
    SQL.Clear;
    SQL.add(BOMTreeFlat(FilterdateFrom, filterDateto , fstablename+'1', 'SaleDate' , 'S.IsSalesOrder ="T" and S.Converted ="F"  order by SL.saleId Desc, SL.saleLineId , PT.sequencedown'));
    //ID ,Level,SalesLevels,saleID,saleLineID,productID,PTID,Sequencedown
    SQL.add('alter Table ' + fstablename+'1  	CHANGE COLUMN PTID ProctreeID INT(11) NULL DEFAULT 0;');
    SQL.add('alter Table ' + fstablename+'1  ADD COLUMN  CustomerId              INT(11)  NOT NULL DEFAULT 0 , ' +
                                          '  ADD COLUMN  CustomerName varchar(255) Null DEfault "", '+
                                          '  ADD COLUMN  shipdate datetime Null Default 0,'+
                                          '  ADD COLUMN  SaleProduct             VARCHAR(255) DEFAULT NULL, ' +
                                          '  ADD COLUMN  SaleProductDescription  VARCHAR(255) DEFAULT NULL, ' +
                                          '  ADD COLUMN  SaleProductUOM          VARCHAR(255) DEFAULT NULL, ' +
                                          '  ADD COLUMN  UnitofMeasureQtySold    DOUBLE NOT NULL DEFAULT 0 , ' +
                                          '  ADD COLUMN  UnitofMeasureShipped    DOUBLE NOT NULL DEFAULT 0 , ' +
                                          '  ADD COLUMN  UnitofMeasureBackorder  DOUBLE NOT NULL DEFAULT 0 , ' +
                                          '  ADD COLUMN  Lineno                  INT(11)  DEFAULT NULL, ' +
                                          '  ADD COLUMN  Item                    VARCHAR(255) DEFAULT NULL, ' +
                                          '  ADD COLUMN  TreeItem                VARCHAR(255) DEFAULT NULL, ' +
                                          '  ADD COLUMN  Itemuom                 VARCHAR(255) DEFAULT NULL, ' +
                                          '  ADD COLUMN  ItemDEscription         VARCHAR(255) DEFAULT NULL, ' +
                                          '  ADD COLUMN  ItemInfo                TEXT, ' +
                                          '  ADD COLUMN  TreePartUOMTotalQty     DOUBLE DEFAULT 0 , ' +
                                          '  ADD COLUMN  FromStockUOMQty         DOUBLE DEFAULT NULL, ' +
                                          '  ADD COLUMN  ManufactureUOMQty       DOUBLE DEFAULT NULL , ' +
                                          '  ADD COLUMN  ManufacturedUOMQty      DOUBLE DEFAULT NULL , ' +
                                          '  ADD COLUMN  tobeBuitQty             DOUBLE DEFAULT NULL, ' +
                                          '  ADD COLUMN  ManufacturingUOMQty     DOUBLE DEFAULT NULL , ' +
                                          '  ADD COLUMN  OnOrderUOMQty           DOUBLE DEFAULT NULL, ' +
                                          '  ADD COLUMN  OrderedQty              DOUBLE DEFAULT NULL, ' +
                                          '  ADD COLUMN  ProducedQty             DOUBLE DEFAULT NULL, ' +
                                          '  ADD COLUMN  Completed               ENUM("T","F") default "F", ' +
                                          '  ADD COLUMN  Haschildren             ENUM("T","F") DEFAULT "F", '+
                                          '  ADD COLUMN  completeQty             DOUBLE NOT NULL DEFAULT 0;' );

    SQL.add('update ' + fstablename+'1  T inner join tblSales S on S.saleId = T.saleId  '+
                                    ' Set T.CustomerId   = S.ClientID , '+
                                        ' T.CustomerName = S.CustomerName ,  '+
                                        ' T.shipdate     = S.ShipDate;');

    SQL.add('update ' + fstablename+'1  T inner join tblsaleslines SL on T.Salelineid = SL.SaleLineID  '+
                                    ' Set T.SaleProduct           = SL.ProductName , '+
                                        ' T.SaleProductDescription= SL.Product_Description, '+
                                        ' T.SaleProductUOM        = concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")"), '+
                                        ' T.UnitofMeasureQtySold    = SL.UnitofMeasureQtySold   , '+
                                        ' T.UnitofMeasureShipped    = SL.UnitofMeasureShipped   , '+
                                        ' T.UnitofMeasureBackorder  = SL.UnitofMeasureBackorder  ;');

    SQL.add('update ' + fstablename+'1  T inner join tblproctree PT on PT.ProctreeId = T.proctreeId Left join tblproctree PTC on PT.proctreeId = PTC.parentId  '+
                                    ' Set T.Lineno              = PT.BuildLineNo,'+
                                        ' T.Item                = PT.Caption ,'+
                                        ' T.TreeItem            = Convert(TreeNodeCaption(PT.level, PT.caption) ,char(255)),'+
                                        ' T.Itemuom             = concat(PT.TreePartUOM , "(" , PT.TreePartUOMMultiplier , ")") ,'+
                                        ' T.ItemDEscription     = PT.Description ,'+
                                        ' T.ItemInfo            = PT.Info ,'+
                                        ' T.TreePartUOMTotalQty = Round(PT.TreePartUOMTotalQty  ,5) ,'+
                                        ' T.FromStockUOMQty     = Round(PT.FromStockUOMQty      ,5) ,'+
                                        ' T.ManufactureUOMQty   = Round(PT.ManufactureUOMQty    ,5) ,'+
                                        ' T.ManufacturedUOMQty  = Round(PT.ManufacturedUOMQty   ,5) ,'+
                                        ' T.tobeBuitQty         = Round(if(ifnull(PTC.ProctreeId,0)<> 0 , PT.ManufactureUOMQty , PT.TreePartUOMTotalQty) - if(ifnull(PTC.ProctreeId,0)<> 0 , PT.ManufacturedUOMQty , PT.ManufacturingUOMQty),5),'+
                                        ' T.ManufacturingUOMQty = Round(PT.ManufacturingUOMQty  ,5),'+
                                        ' T.OnOrderUOMQty       = Round(PT.OnOrderUOMQty        ,5) ,'+
                                        ' T.OrderedQty          = Round(if(ifnull(PTC.ProctreeId,0)<> 0 , PT.ManufactureUOMQty , PT.TreePartUOMTotalQty),5),'+
                                        ' T.ProducedQty         = Round(if(ifnull(PTC.ProctreeId,0)<> 0 , PT.ManufacturedUOMQty , PT.ManufacturingUOMQty),5),'+
                                        ' T.Completed           = if(if(ifnull(PTC.ProctreeId,0)<> 0 , PT.ManufacturedUOMQty , PT.ManufacturingUOMQty) = PT.TreePartUOMTotalQty , "T" , "F"),'+
                                        ' T.Haschildren         = if(ifnull(PTC.ProctreeId,0)<> 0 , "T", "F"),'+
                                        ' T.completeQty         = 0.0 ;');


    (*SQL.Add('drop table if exists ' + fstablename+'1;');
    SQL.Add('CREATE TABLE ' + fstablename+'1 ( ' +
              ' ID                      INT(11)  NOT NULL AUTO_INCREMENT, ' +
              ' SaleLineId              INT(11)  unsigned NULL DEFAULT 0 , ' +
              ' SAleId                  INT(11)  NOT NULL DEFAULT 0 , ' +
              ' CustomerId              INT(11)  NOT NULL DEFAULT 0 , ' +
              ' CustomerName varchar(255) Null DEfault "", '+
              ' shipdate datetime Null Default 0,'+
              ' SaleProduct             VARCHAR(255) DEFAULT NULL, ' +
              ' SaleProductDescription  VARCHAR(255) DEFAULT NULL, ' +
              ' SaleProductUOM          VARCHAR(255) DEFAULT NULL, ' +
              ' UnitofMeasureQtySold    DOUBLE NOT NULL DEFAULT 0 , ' +
              ' UnitofMeasureShipped    DOUBLE NOT NULL DEFAULT 0 , ' +
              ' UnitofMeasureBackorder  DOUBLE NOT NULL DEFAULT 0 , ' +
              ' Lineno                  INT(11)  DEFAULT NULL, ' +
              ' ProctreeID              INT(11)  unsigned NULL DEFAULT 0 , ' +
              ' Item                    VARCHAR(255) DEFAULT NULL, ' +
              ' TreeItem                VARCHAR(255) DEFAULT NULL, ' +
              ' Itemuom                 VARCHAR(255) DEFAULT NULL, ' +
              ' ItemDEscription         VARCHAR(255) DEFAULT NULL, ' +
              ' ItemInfo                TEXT, ' +
              ' TreePartUOMTotalQty     DOUBLE DEFAULT 0 , ' +
              ' FromStockUOMQty         DOUBLE DEFAULT NULL, ' +
              ' ManufactureUOMQty       DOUBLE DEFAULT NULL , ' +
              ' ManufacturedUOMQty      DOUBLE DEFAULT NULL , ' +
              ' tobeBuitQty             DOUBLE DEFAULT NULL, ' +
              ' ManufacturingUOMQty     DOUBLE DEFAULT NULL , ' +
              ' OnOrderUOMQty           DOUBLE DEFAULT NULL, ' +
              ' OrderedQty              DOUBLE DEFAULT NULL, ' +
              ' ProducedQty             DOUBLE DEFAULT NULL, ' +
              ' Completed               ENUM("T","F") default "F", ' +
              ' Haschildren             ENUM("T","F") DEFAULT "F", '+
              ' completeQty             DOUBLE NOT NULL DEFAULT 0, ' +
              ' PRIMARY KEY (ID) ' +
              ' ) ENGINE=InnoDB DEFAULT CHARSET=utf8;');
    SQL.Add('insert ignore into ' + fstablename+'1 ( ' +
              'SaleLineId,SAleId,CustomerId,customername, shipdate, SaleProduct,SaleProductDescription,SaleProductUOM,UnitofMeasureQtySold,UnitofMeasureShipped,'+
              'UnitofMeasureBackorder,Lineno,ProctreeID,Item,TreeItem,Itemuom,ItemDEscription,ItemInfo,TreePartUOMTotalQty,FromStockUOMQty,ManufactureUOMQty,'+
              'ManufacturedUOMQty,tobeBuitQty,ManufacturingUOMQty,OnOrderUOMQty,OrderedQty,ProducedQty,Completed,Haschildren,completeQty) ' +
              ' Select distinct ' +
              ' sl.SaleLineId as SaleLineId, ' +
              ' S.saleId as SAleId, ' +
              ' S.ClientID as CustomerId, ' +
              'S.customername, S.shipdate,'+
              ' SL.Productname as SaleProduct, ' +
              ' SL.Product_Description  as SaleProductDescription, ' +
              ' concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")") as SaleProductUOM, ' +
              ' SL.UnitofMeasureQtySold as UnitofMeasureQtySold, ' +
              ' SL.UnitofMeasureShipped as UnitofMeasureShipped, ' +
              ' SL.UnitofMeasureBackorder as UnitofMeasureBackorder, ' +
              ' PT.BuildLineNo as Lineno, ' +
              'PT.ProctreeID as ProctreeID,'+
              ' PT.Caption as Item, ' +
              ' Convert(TreeNodeCaption(PT.level, PT.caption) ,char(255)) as TreeItem, ' +
              ' concat(PT.TreePartUOM , "(" , PT.TreePartUOMMultiplier , ")") as Itemuom, ' +
              ' PT.Description as ItemDEscription, ' +
              ' PT.Info as ItemInfo, ' +
              ' Round(PT.TreePartUOMTotalQty  ,5) as TreePartUOMTotalQty, ' +
              ' Round(PT.FromStockUOMQty      ,5) as FromStockUOMQty, ' +
              ' Round(PT.ManufactureUOMQty    ,5) as ManufactureUOMQty, ' +
              ' Round(PT.ManufacturedUOMQty   ,5) as ManufacturedUOMQty , ' +
              ' Round(if(ifnull(PTC.ProctreeId,0)<> 0 , PT.ManufactureUOMQty , PT.TreePartUOMTotalQty) - if(ifnull(PTC.ProctreeId,0)<> 0 , PT.ManufacturedUOMQty , PT.ManufacturingUOMQty),5)  as tobeBuitQty, ' +
              ' Round(PT.ManufacturingUOMQty  ,5) as ManufacturingUOMQty , ' +
              ' Round(PT.OnOrderUOMQty        ,5) as OnOrderUOMQty , ' +
              ' Round(if(ifnull(PTC.ProctreeId,0)<> 0 , PT.ManufactureUOMQty , PT.TreePartUOMTotalQty),5) as OrderedQty, ' +
              ' Round(if(ifnull(PTC.ProctreeId,0)<> 0 , PT.ManufacturedUOMQty , PT.ManufacturingUOMQty),5) as ProducedQty, ' +
              ' if(if(ifnull(PTC.ProctreeId,0)<> 0 , PT.ManufacturedUOMQty , PT.ManufacturingUOMQty) = PT.TreePartUOMTotalQty , "T" , "F") as Completed, ' +
              ' if(ifnull(PTC.ProctreeId,0)<> 0 , "T", "F") as Haschildren, ' +
              ' 0.0 as completeQty ' +
              ' from tblsales S ' +
              ' inner join tblSaleslines SL on S.saleId = SL.saleId ' +
              ' inner join tblproctree PT on SL.salelineid = PT.MasterId and PT.MasterType <> "mtProduct" ' +
              ' Left join tblproctree PTC on PT.proctreeId = PTC.parentId ' +
              ' where S.Converted ="F" ' +
              ' and S.saleDate between   ' + Quotedstr(Formatdatetime(MysqlDateFormat , FilterDateFrom)) + '  AND ' + Quotedstr(formatDatetime(MysqlDateFormat , FilterDateTo)) +
              ' order by SL.saleId Desc, SL.saleLineId , PT.sequencedown;');*)

    SQL.Add('drop table if exists ' + fstablename+';');
    SQL.Add('CREATE TABLE ' + fstablename+' ( ' +
              ' ID                      INT(11)  NOT NULL AUTO_INCREMENT, ' +
              ' rownum                  INT(11)  unsigned DEFAULT NULL, ' +
              ' SaleLineId              INT(11)  unsigned NULL DEFAULT 0 , ' +
              ' SAleId                  INT(11)  NOT NULL DEFAULT 0 , ' +
              ' CustomerId              INT(11)  NOT NULL DEFAULT 0 , ' +
              ' CustomerName varchar(255) Null DEfault "", '+
              ' shipdate datetime Null Default 0,'+
              ' SaleProduct             VARCHAR(255) DEFAULT NULL, ' +
              ' SaleProductDescription  VARCHAR(255) DEFAULT NULL, ' +
              ' SaleProductUOM          VARCHAR(255) DEFAULT NULL, ' +
              ' UnitofMeasureQtySold    DOUBLE NOT NULL DEFAULT 0 , ' +
              ' UnitofMeasureShipped    DOUBLE NOT NULL DEFAULT 0 , ' +
              ' UnitofMeasureBackorder  DOUBLE NOT NULL DEFAULT 0 , ' +
              ' Lineno                  INT(11)  DEFAULT NULL, ' +
              ' ProctreeID              INT(11)  unsigned NULL DEFAULT 0 , ' +
              ' Item                    VARCHAR(255) DEFAULT NULL, ' +
              ' TreeItem                VARCHAR(255) DEFAULT NULL, ' +
              ' Itemuom                 VARCHAR(255) DEFAULT NULL, ' +
              ' ItemDEscription         VARCHAR(255) DEFAULT NULL, ' +
              ' ItemInfo                TEXT, ' +
              ' ChildCaption            varchar(255) DEFAULT NULL, '+
              ' ChildTotalQty           Double       DEFAULT NULL,  '+
              ' ChildQtyPer             Double        DEFAULT NULL ,'  +
              ' SalesChildQtyPer        Double        DEFAULT NULL ,'  +
              ' TreePartUOMTotalQty     DOUBLE DEFAULT 0 , ' +
              ' FromStockUOMQty         DOUBLE DEFAULT NULL, ' +
              ' ManufactureUOMQty       DOUBLE DEFAULT NULL , ' +
              ' ManufacturedUOMQty      DOUBLE DEFAULT NULL , ' +
              ' tobeBuitQty             DOUBLE DEFAULT NULL, ' +
              ' ManufacturingUOMQty     DOUBLE DEFAULT NULL , ' +
              ' OnOrderUOMQty           DOUBLE DEFAULT NULL, ' +
              ' OrderedQty              DOUBLE DEFAULT NULL, ' +
              ' ProducedQty             DOUBLE DEFAULT NULL, ' +
              ' Completed               ENUM("T","F") default "F", ' +
              ' Haschildren             ENUM("T","F") DEFAULT "F", '+
              ' completeQty             DOUBLE NOT NULL DEFAULT 0, ' +
              ' SequenceDown            INT(11) default 0,'+
              ' ProducedChildQty        DOUBLE DEFAULT NULL, ' +
              ' completeChildQty        DOUBLE DEFAULT NULL, ' +
              ' tobeBuitChildQty        DOUBLE DEFAULT NULL, ' +
              ' PRIMARY KEY (ID) ' +
              ' ) ENGINE=InnoDB DEFAULT CHARSET=utf8;');



      for level := 1 to fiBomLevels do
        SQL.add('alter table '+fstablename +' add column PTID'    + LvlNo(Level) +' int(11) DEFAULT 0 , '+
                                            ' add column parentId' + LvlNo(Level) +' int(11) DEFAULT 0 ;' );

    SQL.Add('insert ignore into ' + fstablename+' ( ' +
              'Rownum, SaleLineId,SAleId,CustomerId,customername, shipdate,SaleProduct,SaleProductDescription,SaleProductUOM,UnitofMeasureQtySold,UnitofMeasureShipped,'+
              'UnitofMeasureBackorder,Lineno,ProctreeID,Item,TreeItem,Itemuom,ItemDEscription,ItemInfo,TreePartUOMTotalQty,FromStockUOMQty,'+
              'ManufactureUOMQty,ManufacturedUOMQty,tobeBuitQty,ManufacturingUOMQty,OnOrderUOMQty,OrderedQty,ProducedQty,'+
              'Completed,Haschildren,completeQty,SequenceDown' + BOOMLEvelfields+') ' +
              ' Select distinct ' +
              ' convert( @rownum:=if(@SaleLineId <> SaleLineId,  @rownum:= 1 ,  @rownum+1) , unsigned) as rownum , ' +
              ' convert( @SaleLineId := SaleLineId , unsigned)  as SaleLineId, ' +
              ' T.SAleId,T.CustomerId,T.customername, T.shipdate, T.SaleProduct,T.SaleProductDescription,T.SaleProductUOM,T.UnitofMeasureQtySold,T.UnitofMeasureShipped,T.UnitofMeasureBackorder,T.Lineno, ' +
              'T.ProctreeID,T.Item,T.TreeItem,T.Itemuom,T.ItemDEscription,T.ItemInfo,' +
              'Round(T.TreePartUOMTotalQty  ,5),'+
              'Round(T.FromStockUOMQty      ,5),'+
              'Round(T.ManufactureUOMQty    ,5),'+
              'Round(T.ManufacturedUOMQty   ,5),'+
              'Round(T.tobeBuitQty          ,5),'+
              'Round(T.ManufacturingUOMQty  ,5),'+
              'Round(T.OnOrderUOMQty        ,5),'+
              'Round(T.OrderedQty           ,5),'+
              'Round(T.ProducedQty          ,5),'+
              'T.Completed,T.Haschildren,T.completeQty,T.SequenceDown' + BOOMLEvelfields+'' +
              ' from  (SELECT @rownum:=0) r ,  (SELECT @SaleLineId:=0) s, (select * from ' + fstablename+'1 order by saleId desc , saleLineId, sequencedown)  as T;');


      for level := 1 to fiBomLevels do begin
        SQL.add('alter table '+fstablename +' add column Caption'    + LvlNo(Level) +' varchar(255) DEFAULT NULL, '+
                                            ' add column TotalQty'   + LvlNo(Level) +' Double DEFAULT NULL,  '+
                                            ' add column QtyPer'     + LvlNo(Level) +' Double DEFAULT NULL,  '+
                                            ' add column Sequenceup' + LvlNo(Level) +' int(11) DEFAULT 0 ;' );

        SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fstablename +' T inner join tblproctree PT on T.PTID'+LvlNo(Level)+'= PT.proctreeId  '+
                                    ' Set T.Caption'+LvlNo(Level)+' = PT.Caption, '+
                                        ' T.TotalQty'+LvlNo(Level)+' = PT.TotalQty; ');

             if Sametext(Appenv.companyPrefs.Fe1Name ,Appenv.companyPrefs.FeQtyField) then SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.QtyPer' +LvlNo(Level)+' = ifnull(PT.FormulaQtyValue1,0) where ifnull(PT.Formulaid,0)<> 0 and (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0) ;')
        else if Sametext(Appenv.companyPrefs.Fe2Name ,Appenv.companyPrefs.FeQtyField) then SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.QtyPer' +LvlNo(Level)+' = ifnull(PT.FormulaQtyValue2,0) where ifnull(PT.Formulaid,0)<> 0  and (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0);')
        else if Sametext(Appenv.companyPrefs.Fe3Name ,Appenv.companyPrefs.FeQtyField) then SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.QtyPer' +LvlNo(Level)+' = ifnull(PT.FormulaQtyValue3,0) where ifnull(PT.Formulaid,0)<> 0  and (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0);')
        else if Sametext(Appenv.companyPrefs.Fe4Name ,Appenv.companyPrefs.FeQtyField) then SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.QtyPer' +LvlNo(Level)+' = ifnull(PT.FormulaQtyValue4,0) where ifnull(PT.Formulaid,0)<> 0  and (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0);')
        else if Sametext(Appenv.companyPrefs.Fe5Name ,Appenv.companyPrefs.FeQtyField) then SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblproctree PT on PT.ProctreeId = T.PTID'+LvlNo(Level)+' Set T.QtyPer' +LvlNo(Level)+' = ifnull(PT.FormulaQtyValue5,0) where ifnull(PT.Formulaid,0)<> 0  and (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0);');
    end;

    SQL.add('Update '+fstablename +' T inner join tblproctree PT on T.ProctreeId = PT.parentId Set T.ChildCaption  = PT.caption ,T.ChildTotalQty  = PT.TotalQty;' );

         if Sametext(Appenv.companyPrefs.Fe1Name ,Appenv.companyPrefs.FeQtyField) then SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblproctree PT on T.ProctreeId = PT.parentId  Set T.ChildQtyPer= ifnull(PT.FormulaQtyValue1,0) where ifnull(PT.Formulaid,0)<> 0 and (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0) ;')
    else if Sametext(Appenv.companyPrefs.Fe2Name ,Appenv.companyPrefs.FeQtyField) then SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblproctree PT on T.ProctreeId = PT.parentId  Set T.ChildQtyPer= ifnull(PT.FormulaQtyValue2,0) where ifnull(PT.Formulaid,0)<> 0  and (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0);')
    else if Sametext(Appenv.companyPrefs.Fe3Name ,Appenv.companyPrefs.FeQtyField) then SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblproctree PT on T.ProctreeId = PT.parentId  Set T.ChildQtyPer= ifnull(PT.FormulaQtyValue3,0) where ifnull(PT.Formulaid,0)<> 0  and (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0);')
    else if Sametext(Appenv.companyPrefs.Fe4Name ,Appenv.companyPrefs.FeQtyField) then SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblproctree PT on T.ProctreeId = PT.parentId  Set T.ChildQtyPer= ifnull(PT.FormulaQtyValue4,0) where ifnull(PT.Formulaid,0)<> 0  and (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0);')
    else if Sametext(Appenv.companyPrefs.Fe5Name ,Appenv.companyPrefs.FeQtyField) then SQL.add('/*'+inttostr(SQL.count+1)+'*/'+'update ' + fsTablename +' T  inner join tblproctree PT on T.ProctreeId = PT.parentId  Set T.ChildQtyPer= ifnull(PT.FormulaQtyValue5,0) where ifnull(PT.Formulaid,0)<> 0  and (ifnull(PT.FromStockQty,0)>0 Or ifnull(PT.OnOrderQty,0)>0);');


    SQL.add('Update '+fstablename +' T  Set T.SalesChildQtyPer  = UnitofMeasureQtySold * ChildQtyPer;' );
    SQL.add('Update '+fstablename +' T  Set T.ProducedChildQty  = ProducedQty * ChildQtyPer;' );
    SQL.add('Update '+fstablename +' T  Set T.completeChildQty  = completeQty * ChildQtyPer;' );
    SQL.add('Update '+fstablename +' T  Set T.tobeBuitChildQty  = tobeBuitQty * ChildQtyPer;' );



    clog(sql.text);
    showProgressbar(WAITMSG , SQL.count);
    try
      execute;
    finally
      HideProgressbar;
    end;
  end;
end;
procedure TProductionOrderMaterialListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
    if GuiPrefs.Node.Exists('Options.ReporttoPrint') then
      ReporttoPrint :=  GuiPrefs.Node['Options.ReporttoPrint'].asString
    else ReporttoPrint := GetDefaultTemplate('Sales Order');
    initReportToPrint;

    if GuiPrefs.Node.Exists('Options.HideRawMaterials') then
      chkHideRawMaterials.checked :=  GuiPrefs.Node['Options.HideRawMaterials'].AsBoolean
    else chkHideRawMaterials.checked :=  True;

end;
Procedure TProductionOrderMaterialListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.HideRawMaterials'].AsBoolean := chkHideRawMaterials.checked;
end;



initialization
  RegisterClassOnce(TProductionOrderMaterialListGUI);

end.
