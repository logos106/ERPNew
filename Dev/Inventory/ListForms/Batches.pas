unit Batches;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, wwcheckbox, BaseInputForm,
  DAScript, MyScript, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TBatchesGUI = class(TBaseListingGUI)
    cboClassQry: TERPQuery;
    cboClassQryClassID: TIntegerField;
    cboClassQryClassName: TWideStringField;
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label4: TLabel;
    chkAllClass: TwwCheckBox;
    cboClass: TwwDBLookupCombo;
    qryMainQtyDescription: TWideStringField;
    grpOptions: TRadioGroup;
    qryMainQuantity: TFloatField;
    qryMainID: TIntegerField;
    qryMainGLevel: TIntegerField;
    qryMainPartsID: TIntegerField;
    qryMainClassId: TIntegerField;
    qryMainPARTNAME: TWideStringField;
    qryMainclassname: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainBatchno: TWideStringField;
    qryMainTruckLoadNo: TWideStringField;
    qryMainExpiryDate: TDateTimeField;
    qryMainTransType: TWideStringField;
    qryMainTransactionNo: TIntegerField;
    qryMainformName: TWideStringField;
    qryMainAlloctype: TWideStringField;
    qryMainQty: TFloatField;
    qryMainUOMQty: TFloatField;
    qryMainInStockQty: TFloatField;
    qryMainAvailableQty: TFloatField;
    qryMainAllocatedSOQty: TFloatField;
    qryMainAllocatedBOQty: TFloatField;
    qryMainOnOrderQty: TFloatField;
    qryMainSOBackOrdersQty: TFloatField;
    qryMainOnBuildQty: TFloatField;
    qryMainBuildingQty: TFloatField;
    QrymainUOMInStockQty: TFloatField;
    QrymainUOMAvailableQty: TFloatField;
    QrymainUOMAllocatedSOQty: TFloatField;
    QrymainUOMAllocatedBOQty: TFloatField;
    QrymainUOMOnOrderQty: TFloatField;
    QrymainUOMSOBackOrdersQty: TFloatField;
    QrymainUOMOnBuildQty: TFloatField;
    QrymainUOMBuildingQty: TFloatField;

    DNMSpeedButton1: TDNMSpeedButton;
    Label2: TLabel;
    grpQtys: TRadioGroup;
    qryMainBOMBatchno: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure chkAllClassClick(Sender: TObject);
    procedure cboClassChange(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grpOptionsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure grpQtysClick(Sender: TObject);
  private
    fiClassid: Integer;
    fiProductID: Integer;
    fsTablename :STring;
    fsWhere:String;
    fbHighlightBatcheswithQty: Boolean;
  Protected
    Procedure AssignKeyId(Popupform :TBaseInputGUI); override;
    Procedure SetGridColumns;override;
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex: Integer);override;
    procedure ReadnApplyGuiPrefExtra; override;
    Procedure WriteGuiPrefExtra; override;
  public
    Procedure RefreshQuery; override;
    Property ProductID:Integer read fiProductID write fiproductID;
    Property Classid :Integer read fiClassid Write fiClassID;
    Property HighlightBatcheswithQty : Boolean read fbHighlightBatcheswithQty write fbHighlightBatcheswithQty;
  end;


implementation

uses CommonLib, ProductQtyLib, FastFuncs, MySQLConst, dateutils,
    AppEnvironment, busobjStockMovement, BusobjStockAdjustEntry,
  busobjstockTransferentry, BusObjStock, BusObjClass, DNMLib,
  CommonDbLib, PQALib, TemplateReportsLib, tcDataUtils, tcConst,
  BarcodeConst,SalesLib, JSONObject, LogLib;

{$R *.dfm}
{ TBatchesGUI }

procedure TBatchesGUI.grpQtysClick(Sender: TObject);
begin
  inherited;
  RemoveFieldsfromGrid(QrymainInStockQty.fieldname+','+
                       QrymainAvailableQty.fieldname+','+
                       QrymainAllocatedSOQty.fieldname+','+
                       QrymainAllocatedBOQty.fieldname+','+
                       QrymainOnOrderQty.fieldname+','+
                       QrymainSOBackOrdersQty.fieldname+','+
                       QrymainOnBuildQty.fieldname+','+
                       QrymainBuildingQty.fieldname+','+
                       QrymainUOMInStockQty.fieldname+','+
                       QrymainUOMAvailableQty.fieldname+','+
                       QrymainUOMAllocatedSOQty.fieldname+','+
                       QrymainUOMAllocatedBOQty.fieldname+','+
                       QrymainUOMOnOrderQty.fieldname+','+
                       QrymainUOMSOBackOrdersQty.fieldname+','+
                       QrymainUOMOnBuildQty.fieldname+','+
                       QrymainUOMBuildingQty.fieldname);

  if grpQtys.itemindex in [0,2]  then begin
       AddFieldstoGrid(QrymainInStockQty.fieldname+','+
                       QrymainAvailableQty.fieldname+','+
                       QrymainAllocatedSOQty.fieldname+','+
                       QrymainAllocatedBOQty.fieldname+','+
                       QrymainOnOrderQty.fieldname+','+
                       QrymainSOBackOrdersQty.fieldname+','+
                       QrymainOnBuildQty.fieldname+','+
                       QrymainBuildingQty.fieldname);
  end;
  if grpQtys.itemindex in [1,2] then begin
       AddFieldstoGrid(QrymainUOMInStockQty.fieldname+','+
                       QrymainUOMAvailableQty.fieldname+','+
                       QrymainUOMAllocatedSOQty.fieldname+','+
                       QrymainUOMAllocatedBOQty.fieldname+','+
                       QrymainUOMOnOrderQty.fieldname+','+
                       QrymainUOMSOBackOrdersQty.fieldname+','+
                       QrymainUOMOnBuildQty.fieldname+','+
                       QrymainUOMBuildingQty.fieldname);
  end;
end;

procedure TBatchesGUI.RefreshQuery;
var
    SQLList:TStringList;
    ctr :Integer;
    strCaption :String;
begin
    SQLList := TStringList.Create;
    try
      SQLList.Add('truncate ' +fsTablename +';');
        For ctr := 0 to 5 do begin
          SQLList.Add('insert into ' +fsTablename+'(GLevel,PartsID,PARTNAME,ProductPrintName,ClassId,classname,UOM,Batchno,TruckLoadNo,ExpiryDate,StockmovementEntryglobalref, TransType,TransactionNo,formName,Alloctype,'+
                'InStockQty,AvailableQty,AllocatedSOQty,AllocatedBOQty,OnOrderQty,SOBackOrdersQty,OnBuildQty,BuildingQty,'+
                'UOMInStockQty,UOMAvailableQty,UOMAllocatedSOQty,UOMAllocatedBOQty,UOMOnOrderQty,UOMSOBackOrdersQty,UOMOnBuildQty,UOMBuildingQty,'+
                'Qty,UOMQty)');

          SQLList.add('SELECT ');
          SQLList.add(IntToStr(ctr) +' as GLevel, ');
          SQLList.add('P.PartsID,  ');
          SQLList.add('P.PARTNAME ,');
          SQLList.add('P.ProductPrintName ,');
          SQLList.add('PC.ClassId, ');
          SQLList.add('PC.classname ,  ');
          SQLList.add('PQA.UOM,');
          SQLList.add('PQABatch.Value as Batchno,');
          SQLList.add('PQABatch.TruckLoadNo as TruckLoadNo,');
          SQLList.add('PQABatch.ExpiryDate , ');
          SQLList.Add('SM.StockmovementEntryglobalref,');
          {instock doesn't have the transaction type}
          if ctr <> 0  then SQLList.add(' if(ifnull(SMTT.Description,"")<> "" ,SMTT.Description, if(ifnull(TT.Description,"") = "" , PQA.TransType , TT.Description)) as TransType, ')
          else SQLList.add('" " as TransType, ');
          {summary or instock doesn't have the form name/transaction no to stop drill down}
          if (grpOptions.ItemIndex = 1) and (ctr<> 0) then begin
            SQLList.Add('PQA.transId as TransactionNo,')       ;
            SQLList.add('ifnull(TT.formName, SMTT.formname) as FormName , ')                ;
          end else begin
            SQLList.Add('0   as TransactionNo,');
            SQLList.add('" " as formName, ');
          end;
          if  (ctr<>0) then begin
            SQLList.Add('PQA.Alloctype as Alloctype,')       ;
          end else begin
            SQLList.Add('" " as Alloctype,')       ;
          end;
          //if ctr =0 then begin
            SQLList.Add( 'Round(' +SQL4Qty(tInstock   ,'PQA' , DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "InStockQty",');
            SQLList.Add( 'Round(' +SQL4Qty(tAvailable ,'PQA' , DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "AvailableQty",');
            SQLList.Add( 'Round(' +SQL4Qty(tSO        ,'PQA' , DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "AllocatedSOQty",');
            SQLList.Add( 'Round(' +SQL4Qty(tInvBO     ,'PQA' , DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "AllocatedBOQty",');
            SQLList.Add( 'Round(' +SQL4Qty(tPOBO      ,'PQA' , DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "OnOrderQty",');
            SQLList.Add( 'Round(' +SQL4Qty(tSOBO      ,'PQA' , DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "SOBackOrdersQty",');
            SQLList.Add( 'Round(' +SQL4Qty(tOnBuild   ,'PQA' , DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "OnBuildQty",');
            SQLList.Add( 'Round(' +SQL4Qty(tBuilding  ,'PQA' , DetailQtyfield(tDetails)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "BuildingQty",');

            SQLList.Add( 'Round(' +SQL4Qty(tInstock   ,'PQA' , DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "UOMInStockQty",');
            SQLList.Add( 'Round(' +SQL4Qty(tAvailable ,'PQA' , DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "UOMAvailableQty",');
            SQLList.Add( 'Round(' +SQL4Qty(tSO        ,'PQA' , DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "UOMAllocatedSOQty",');
            SQLList.Add( 'Round(' +SQL4Qty(tInvBO     ,'PQA' , DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "UOMAllocatedBOQty",');
            SQLList.Add( 'Round(' +SQL4Qty(tPOBO      ,'PQA' , DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "UOMOnOrderQty",');
            SQLList.Add( 'Round(' +SQL4Qty(tSOBO      ,'PQA' , DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "UOMSOBackOrdersQty",');
            SQLList.Add( 'Round(' +SQL4Qty(tOnBuild   ,'PQA' , DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "UOMOnBuildQty",');
            SQLList.Add( 'Round(' +SQL4Qty(tBuilding  ,'PQA' , DetailQtyfield(tDetails,true)) +',' + IntToStr(tcConst.GeneralRoundPlaces)+') AS "UOMBuildingQty",');
          (*end else begin
            SQLList.Add( '0 AS "InStockQty",');
            SQLList.Add( '0 AS "AvailableQty",');
            SQLList.Add( '0 AS "AllocatedSOQty",');
            SQLList.Add( '0 AS "AllocatedBOQty",');
            SQLList.Add( '0 AS "OnOrderQty",');
            SQLList.Add( '0 AS "SOBackOrdersQty",');
            SQLList.Add( '0 AS "OnBuildQty",');
            SQLList.Add( '0 AS "BuildingQty",');

            SQLList.Add( '0 AS "UOMInStockQty",');
            SQLList.Add( '0 AS "UOMAvailableQty",');
            SQLList.Add( '0 AS "UOMAllocatedSOQty",');
            SQLList.Add( '0 AS "UOMAllocatedBOQty",');
            SQLList.Add( '0 AS "UOMOnOrderQty",');
            SQLList.Add( '0 AS "UOMSOBackOrdersQty",');
            SQLList.Add( '0 AS "UOMOnBuildQty",');
            SQLList.Add( '0 AS "UOMBuildingQty",');

          end;*)


          if ctr = 0 then begin {Available}
            SQLList.add(SQL4Qty(tAvailable,'PQA' , DetailQtyfield(tDetails)) +' as Qty,');
            SQLList.add(SQL4Qty(tAvailable,'PQA' , DetailQtyfield(tDetails, true)) +' as UOMQty');
          end else if ctr = 1 then begin {IN}
            SQLList.add(SQL4Qty(tINs,'PQA' , DetailQtyfield(tDetails)) +' as Qty,');
            SQLList.add(SQL4Qty(tINs,'PQA' , DetailQtyfield(tDetails, true)) +' as UOMQty');
          end else if ctr = 2 then begin{OUT}
            SQLList.add(SQL4Qty(tOUTs,'PQA' , DetailQtyfield(tDetails)) +' as Qty,');
            SQLList.add(SQL4Qty(tOUTs,'PQA' , DetailQtyfield(tDetails, true)) +' as UOMQty');
          end else if ctr = 3 then begin{SO}
            SQLList.add(SQL4Qty(tSO,'PQA' , DetailQtyfield(tDetails)) +' as Qty,');
            SQLList.add(SQL4Qty(tSO,'PQA' , DetailQtyfield(tDetails, true)) +' as UOMQty');
          end else if ctr = 4 then begin{On Build Raw}
            SQLList.add(SQL4Qty(tOnBuild,'PQA' , DetailQtyfield(tDetails)) +' as Qty,');
            SQLList.add(SQL4Qty(tOnBuild,'PQA' , DetailQtyfield(tDetails, true)) +' as UOMQty');
          end else if ctr = 5 then begin{building}
            SQLList.add(SQL4Qty(tBuilding,'PQA' , DetailQtyfield(tDetails)) +' as Qty,');
            SQLList.add(SQL4Qty(tBuilding,'PQA' , DetailQtyfield(tDetails, true)) +' as UOMQty');
          end;
          SQLList.add(' FROM ' +ProductTables(tDetails , true, True));
          SQLList.Add('LEFt JOIN tblStockMovement SM on SM.StockmovementId = PQA.TransId and PQA.TransType = ' + QuotedStr(TStockMovementLines.classname));
          SQLList.Add('LEFt JOIN tblpqatranstypes as SMTT on SM.StockmovementEntryType = SMTT.TransType');
          SQLList.Add(' Where P.active <>"F" and PC.ACtive <> "F" and P.Batch <> "F"');
          strCaption:= '';
          if ProductID <> 0 then begin
            SQLList.Add(' and P.PartsId = ' +IntToStr(ProductID));
            strCaption        := TProduct.IDToggle(ProductID);
          end;
          if Classid <> 0 then begin
            SQLList.Add(' and PC.ClassId = ' +IntToStr(classid));
            if strcaption <> '' then strCaption := strCaption +' in ' ;
            strCaption := strCaption + TDeptClass.idtoggle(Classid);
          end;
          if strCaption <> '' then begin
            StrCaption := ' Batches of ' + strCaption ;
            Self.Caption        := strCaption ;
          end;

          if chkAllClass.checked = False  then SQLList.add('and PQA.DepartmentID = ' + IntToStr(cboClassQryClassID.asInteger));
          SQLList.add('and PQA.TransDate <' + Quotedstr(FormatDateTime(MysqlDateFormat , FilterdateTo)));
          SQLList.add('group by TransactionNo, P.PartsID, P.PARTNAME,UOM,');
          SQLList.add('IFNULL( PQABatch.Value,""),IFNULL( PQABatch.ExpiryDate,0), PC.Classname  ');
          if ctr <> 0 then SQLList.add(',TransType');
          if (grpFilters.ItemIndex <> 0) and (ctr<>0) then SQLList.add(',PQA.Alloctype');
          if ctr <> 0 then SQLList.add('having Qty <> 0');
          SQLList.add('Order by Classname, PARTNAME,ProductPrintName,UOM,IFNULL( Batchno,""),IFNULL( TruckLoadNo,""),IFNULL( ExpiryDate,0) , GLevel, transtype , TransactionNo;');
        end;

        with scriptmain do begin
            Sql.Clear;
            clog(SQLList.text);
            Sql.add(SQLList.text);
            Processingcursor(True);
            try
              Execute;
            finally
              Processingcursor(False);
            end;
        end;
    finally
        Freeandnil(SQLList);
    end;
    inherited;
       (* if Qrymain.Active then Qrymain.close;
        Qrymain.SQL.clear;
        Qrymain.SQl.add(SQLList.Text);
        inherited;
  finally
      Qrymain.enablecontrols;
  end;*)
end;

procedure TBatchesGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpFiltersClick(grpFilters);
  grdMain.UseTFields := True;
  if cboClassQry.active = False then cboClassQry.open;
  Qrymain.first;
end;

procedure TBatchesGUI.chkAllClassClick(Sender: TObject);
begin
  if chkAllClass.Checked then begin
    cboClass.Enabled := false;
  end else begin
    cboClass.Enabled := true;
  end;
  if screen.activecontrol = sender then RefreshQuery;
end;

procedure TBatchesGUI.cboClassChange(Sender: TObject);
begin
  inherited;
  if screen.activecontrol = sender then RefreshQuery;
end;

procedure TBatchesGUI.grdMainDblClick(Sender: TObject);
begin
  if DoOnGridDataSelect(grdmain) then exit;
  if (qryMainformName.asString = '') or (qryMainTransactionNo.asInteger = 0) then begin
    if grpOptions.ItemIndex = 0 then MessageDlgXP_Vista('This is the summary, Please select the ''Details'' option to get the transaction list to drill down to the details.' , mtinformation , [mbok] , 0)
    else if qryMainGLevel.asInteger = 1 then MessageDlgXP_Vista('This is the in-stock quantity which is the summary of all transactions. Double click on a transaction record to get the details' , mtinformation , [mbok] , 0);
    Exit;
  end;
  inherited;
end;

procedure TBatchesGUI.grpFiltersClick(Sender: TObject);
begin
  if grpFilters.itemindex <grpFilters.items.count-1 then GroupFilterString := 'GLevel = ' + IntToStr(grpFilters.itemindex)
  else GroupFilterString := '';
  inherited;
end;

procedure TBatchesGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if grpFilters.itemIndex = grpFilters.Items.count-1 then
    if qryMainGLevel.asInteger = 1 then    Afont.style := AFont.Style +[fsbold];
  if (qryMainGLevel.asInteger = 1) or (grpOptions.ItemIndex = 0) then
    if Sysutils.SameText(field.fieldname , 'TransactionNo') then AFont.Color := aBrush.Color;


  (*if Sysutils.SameText(field.fieldname , 'InStockQty') OR
     Sysutils.SameText(field.fieldname , 'AvailableQty') OR
     Sysutils.SameText(field.fieldname , 'AllocatedSOQty') OR
     Sysutils.SameText(field.fieldname , 'AllocatedBOQty') OR
     Sysutils.SameText(field.fieldname , 'OnOrderQty') OR
     Sysutils.SameText(field.fieldname , 'SOBackOrdersQty') OR
     Sysutils.SameText(field.fieldname , 'OnBuildQty') OR
     Sysutils.SameText(field.fieldname , 'BuildingQty') OR
     Sysutils.SameText(field.fieldname , 'UOMInStockQty') OR
     Sysutils.SameText(field.fieldname , 'UOMAvailableQty') OR
     Sysutils.SameText(field.fieldname , 'UOMAllocatedSOQty') OR
     Sysutils.SameText(field.fieldname , 'UOMAllocatedBOQty') OR
     Sysutils.SameText(field.fieldname , 'UOMOnOrderQty') OR
     Sysutils.SameText(field.fieldname , 'UOMSOBackOrdersQty') OR
     Sysutils.SameText(field.fieldname , 'UOMOnBuildQty') OR
     Sysutils.SameText(field.fieldname , 'UOMBuildingQty') then
     if (qryMainGLevel.asInteger > 0) then AFont.Color := aBrush.Color;*)
  if field is Tfloatfield then
    if TFloatfield(Field).asFloat =0 then AFont.Color := aBrush.Color;


  if fbHighlightBatcheswithQty then
    if Qrymainquantity.asFloat >0 then
      aBrush.Color := GridColhighLightGreen;

end;

procedure TBatchesGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
       (*if qryMainGLevel.asInteger = 0 then qryMainQtyDescription.asString := 'In-stock'
  else if qryMainGLevel.asInteger = 1 then qryMainQtyDescription.asString := 'Purchase'
  else if qryMainGLevel.asInteger = 2 then qryMainQtyDescription.asString := 'Sales'
  else if qryMainGLevel.asInteger = 3 then qryMainQtyDescription.asString := 'Sales Order';*)
  if qryMainGLevel.asInteger = 1 then qryMainQtyDescription.asString := 'In-stock'
  else qryMainQtyDescription.asString := qryMainTranstype.asString;
  if Trim(qrymainalloctype.asString) = '' then QrymainQuantity.asfloat := QrymainUOMQty.asFloat
  else if Trim(qrymainalloctype.asString) = 'IN' then QrymainQuantity.asfloat := QrymainUOMQty.asFloat
  else if Trim(qrymainalloctype.asString) = 'OUT' then QrymainQuantity.asfloat := 0-QrymainUOMQty.asFloat;
end;

procedure TBatchesGUI.grpOptionsClick(Sender: TObject);
begin
  if IsFormshown then RefreshQuery;
  //inherited ;
end;

procedure TBatchesGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  Popupform.KeyId := 0;
  if (Sysutils.SameText(qryMain.FieldByname('TransType').asString , TStockTransferEntry.Transtype)) or
            (Sysutils.SameText(qryMain.FieldByname('TransType').asString , TStockAdjustEntry.Transtype))  then begin
     Popupform.KeyId := TStockMovement.TransactionID(Qrymain.fieldbyname('TransactionNo').asInteger);
  end;
  if Popupform.KeyId = 0 then inherited;

end;

procedure TBatchesGUI.FormCreate(Sender: TObject);
begin
  fsTablename := CommonDbLib.CreateUserTemporaryTable('tmp_batches');
  grpFilters.ItemIndex := 6; // All by default
  fbHighlightBatcheswithQty := False;
  grdmain.selected.Text := replacestr( grdmain.selected.Text , 'Quantity read as Units' , 'Quantity read as '+ Quotedstr(AppEnv.DefaultClass.DefaultUOM));
  grpQtys.items[0] := 'As ' + AppEnv.DefaultClass.DefaultUOM;
  qrymain.SQl.text := StringReplace(Qrymain.SQL.text , 'tmp_batches' , fsTablename, [rfIgnoreCase]);
  inherited;
  fiProductID := 0;
  fiClassid:= 0;
end;

procedure TBatchesGUI.cmdPrintClick(Sender: TObject);
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

procedure TBatchesGUI.DNMSpeedButton1Click(Sender: TObject);
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

//  fTemplateName := Trim(TemplateToPrint('Batch Barcode,Sales Dispatch Barcode', chkChooseRpt.checked , 'Batch Barcode'));
  fTemplateName := Trim(TemplateToPrint('Batch Barcode', chkChooseRpt.checked , 'Batch Barcode'));

  fTemplateType := GetTypeNameoftemplate(fTemplateName);

  if SameText(fTemplateType,'Sales Dispatch Barcode') then begin


    ssql:= SalesDispatchBarcodeSQL(qryMainTransactionNo.AsString , '' , ''  );
//    ssql:= SalesDispatchBarcodeSQL('10' , '' , ''  );
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



  end
  else begin

      ssql := companyInfoSQL +
            ' ~|||~{Details}select distinct PartsID as PartsID , '+
                                ' PARTNAME as PARTNAME , '+
                                ' ProductPrintName as ProductPrintName , '+
                                ' classname as classname , '+
                                ' UOM as UOM , '+
                                ' Batchno as Batchno , '+
                                ' ExpiryDate as ExpiryDate , '+
                                ' TruckLoadNo as TruckLoadNo, '+
                                ' concat("'+ Barcode_Prefix_PQABATCH +'-",PartsID, "-" , BatchNo) as ProductIDnBatchnumber,'+
                               // ' Sum(if(alloctype="IN" , Qty, 0-Qty)) as Qty ,  Sum(if(alloctype="IN" , UOMQty, 0-UOMQty)) as UOMQty   '+
                                ' Sum(if(GLevel=0 , Qty, 0)) as Qty ,  Sum(if(GLevel=0 , UOMQty, 0)) as UOMQty   '+
                                ' from ' + fstablename +
                                ' where ' +  fsWhere +
                                ' Group by PartsID ,PARTNAME ,ProductPrintName ,ClassId ,classname ,UOM ,Batchno ,ExpiryDate, TruckLoadNo';
      ReportSQLSupplied :=  True;
      PrintTemplateReport( fTemplateName , ssql , not(chkPreview.Checked) , 1 );
      //PrintTemplateReport(TemplateToPrint('Batch Barcode(PO)', chkChooseRpt.checked) , ssql, False, 1 );
  end;
end;
procedure TBatchesGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer);
begin
  if iterateprocno = 1 then begin
      if fsWhere <> '' then fsWhere := fsWhere + ' or ';
      fsWhere := fsWhere + '( PartsID =' + inttostr(QrymainpartsID.asInteger)+' and ClassId =' + inttostr(QrymainClassID.asInteger) +' and Batchno =' +quotedstr(Qrymainbatchno.AsString)+')';
  end;
end;
procedure TBatchesGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  inherited;
end;

procedure TBatchesGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainAlloctype.fieldname);
  RemoveFieldfromGrid(QrymainUOMQty.fieldname);
  RemoveFieldfromGrid(QrymainID.fieldname);
  RemoveFieldfromGrid(QrymainGLevel.fieldname);
  RemoveFieldfromGrid(QrymainPartsID.fieldname);
  RemoveFieldfromGrid(QrymainClassId.fieldname);
end;
procedure TBatchesGUI.ReadnApplyGuiPrefExtra;
begin
    if GuiPrefs.Node.Exists('Options.ShowQtysIndex') then
      grpQtys.ItemIndex :=  GuiPrefs.Node['Options.ShowQtysIndex'].asInteger
    else grpQtys.ItemIndex :=  3;

end;
Procedure TBatchesGUI.WriteGuiPrefExtra;
begin
  GuiPrefs.Node['Options.ShowQtysIndex'].asInteger := grpQtys.ItemIndex;
end;

initialization
//  RegisterClassOnce(TBatchesGUI);
end.
