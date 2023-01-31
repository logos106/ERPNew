unit BOMOrderStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  BusObjProcess,AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DNMAction,DAScript, MyScript , BomreportBase, BusObjBase, BusObjSales,
  wwcheckbox, CustomInputBox, wwclearbuttongroup, wwradiogroup ;

type
  TBOMOrderStatusGUI = class(TBomreportBaseGUI)
    qryMainSaleId: TIntegerField;
    qryMainSaledate: TDateField;
    qryMainShipDate: TDateTimeField;
    qryMainETADate: TDateTimeField;
    qryMainProductname: TWideStringField;
    qryMainTreeProduct: TWideStringField;
    qryMainConverted: TWideStringField;
    qryMainclientID: TIntegerField;
    qryMainSaleCustomerName: TWideStringField;
    qryMainTreeRootID: TIntegerField;
    qryMainSaleLineID: TIntegerField;
    qryMainProcTreeId: TIntegerField;
    qryMainFromStockUOMQty: TFloatField;
    qryMainManufactureUOMQty: TFloatField;
    qryMainInStockQty: TFloatField;
    qryMainOnOrderQty: TFloatField;
    QrymainAvailableQty:TFloatfield;
    qryMainOnOrderUOMQty: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainOrdered: TFloatField;
    qryMainreceived: TFloatField;
    qryMainBakorder: TFloatField;
    qryMainDescription: TWideStringField;
    btnGroup: TDNMSpeedButton;
    grpExtrafilter: TRadioGroup;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainBOMProductionLine: TWideStringField;
    qryMainDetails: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);override;
    procedure grdMainDblClick(Sender: TObject);  override;
    procedure btnGroupClick(Sender: TObject);
    procedure actUnGroupUpdate(Sender: TObject);
    procedure actUnGroupExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actSmartOrderUpdate(Sender: TObject);
  private

    fireplacingProductID:Integer;
    fsreplacingProductName :String;
    Tablename :String;
    fiSaleId: Integer;
    fiSaleLineID:Integer;
    Grouping,ungrouping:Boolean;


    procedure SetSaleId(const Value: Integer);


    
    function SOIFdorSale(const lineID: Integer): Integer;

    procedure GetreplacingProductID(Sender: TwwDbGrid);
    procedure ValidateForGrouping(const SaleLineId: Integer);
    function ConfirmtoGroup(QtyGrouping:Double): Boolean;
    procedure beforeshowManufactureProductList(Sender: TObject);
    procedure DetaillistWithSelection;
    function Treenode(busobj: TBusobj): TProctreenode;
    procedure SetSaleLineId(const Value: Integer);
    procedure Applyfilter;

    { Private declarations }
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure SetGridColumns; Override;
  public
    Property SaleId :Integer read fiSaleId write SetSaleId;
    Property SaleLineId :Integer read fiSaleLineId write SetSaleLineId;
    Procedure RefreshQuery;override;

  end;


implementation

uses pqalib, CommonLib, CommonDbLib, tcConst,
  CommonFormLib, MySQLConst, frmProcTreeEdit, TreeFrame, AppEnvironment,
  ProcessUtils, frmMessageWithList, BusObjConst, ManufactureLib, ProductQtyLib,dateutils,
   AppContextObj, ProductMovementList, tcDataUtils  ,IntegerListObj,
  frmMessageBase;


{$R *.dfm}


procedure TBOMOrderStatusGUI.GetreplacingProductID(Sender: TwwDbGrid);
begin
  try
    fireplacingProductID := TwwDbGrid(Sender).DataSource.DataSet.FieldByName('PartsID').AsInteger;
    fsreplacingProductName := TwwDbGrid(Sender).DataSource.DataSet.FieldByName('PartName').asString;
  Except
    // ignore the error incase if the grid's dataset doesn't have the partsId field
  end;
end;
Procedure TBOMOrderStatusGUI.ValidateForGrouping(const SaleLineId:Integer);
var
  bm: TBookmark;
  Flag:boolean;
begin
  Qrymain.DisableControls;
  try
    bm := qrymain.GetBookmark;
    try
      Flag:= False;
      Qrymain.First;
      While Qrymain.Eof = False do begin
        if QrymainSaleLineID.AsInteger = saleLineId then begin
          if QrymainProcTreeId.asInteger =QrymainTreeRootID.AsInteger then begin
              if (qryMainFromStockUOMQty.asfloat <>0) or
                (qryMainOnOrderUOMQty.asfloat<>0) then begin
                  MessageDlgXP_Vista('It is not possible to Group ' + Quotedstr(trim(QrymainProductName.asString)) +' as it has Quantity from "Stock" or "On Order".' , mtWarning, [mbOK], 0);
                  Flag := True;
                  break;
                end;
          end;
          if (qryMainOrdered.AsFloat <> 0) or (QrymainReceived.AsFloat <>0) or (qryMainBakorder.AsFloat<>0) then begin
            MessageDlgXP_Vista('It is not possible to Group a job with Smart Orders or Purchase Orders already created.' + NL + NL+ Quotedstr(trim(QrymainProductName.asString)) +' of ' + Quotedstr(QrymainTreeProduct.asString)+ ' has orders ', mtWarning, [mbOK], 0);
            Flag := True;
            break;
          end else if qryMainBOMProductionLine.asBoolean then begin
            MessageDlgXP_Vista('It is not possible to Group a Grouped Product.' + NL + NL+ Quotedstr(QrymainTreeProduct.asString)+ ' is a Grouped Product.', mtWarning, [mbOK], 0);
            Flag := True;
            break;
          end;
        end;
        Qrymain.Next;
      end;
      if not(Flag) then
        With tempMyQuery do try
          SQL.Add('select productname,  ProcessStatus('+inttostr(SaleLineID) +') ProcessStatus from tblsaleslines where saleLineID = ' +inttostr(salelineid));
          open;
          if recordcount>0 then
            if not(sameTExt(fieldbyname('ProcessStatus').asString , PS_STR_NOTSCHEDULED)) then begin
              Flag := true;
              MessageDlgXP_Vista('It is not possible to Group a started job.' + NL + Quotedstr(fieldbyname('productname').asString ) +' is already started and the production status is ' +quotedstr( fieldbyname('Processstatus').asString), mtWarning, [mbOK], 0);
            end;
        finally
          closenFree;
        end;

      if flag then exit;

      Qrymain.First;
      While Qrymain.Eof = False do begin
        if QrymainSaleLineID.AsInteger = saleLineId then begin
          grdmain.SelectRecord;
        end;
        Qrymain.Next;
      end;

    finally
      Qrymain.GotoBookmark(bm);
      Qrymain.FreeBookmark(bm);
    end;
  finally
    Qrymain.EnableControls;
  end;
end;
procedure TBOMOrderStatusGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (EventType = BusObjEvent_Change) and (Value = BusObjEvent_ReadTreePartSourceforSales) and (Sender is Tsalesorder) then begin
    TsalesOrder(Sender).UserConfirmedPartsourceStock := False;
  end;
end;
procedure TBOMOrderStatusGUI.actSmartOrderUpdate(Sender: TObject);
begin
  inherited;
  actSmartOrder.enabled := grpExtrafilter.itemindex = 1;
end;

procedure TBOMOrderStatusGUI.actUnGroupExecute(Sender: TObject);
var
  SO:TsalesOrder;
  MSG:String;
begin
  inherited;
  if ungrouping then exit;
  ungrouping := true;
  try
    actUnGroup.Enabled := not(unGrouping);
    With tempMyQuery do try
        SQL.Add('select productname,  ProcessStatus('+inttostr(QrymainSalelineId.AsInteger) +') ProcessStatus from tblsaleslines where saleLineID = ' +inttostr(QrymainSalelineId.AsInteger));
        open;
        if recordcount>0 then
          if not(sameTExt(fieldbyname('ProcessStatus').asString , PS_STR_NOTSCHEDULED)) then begin
            MessageDlgXP_Vista('It is not possible to Un-Group a started job.' + NL + Quotedstr(fieldbyname('productname').asString ) +' is already started and the production status is ' +quotedstr( fieldbyname('Processstatus').asString), mtWarning, [mbOK], 0);
            Exit;
          end;
    finally
        closenFree;
    end;
    SO:= Tsalesorder.CreateWithNewConn(self);
    try
      SO.Load(QrymainSaleID.AsInteger);
      if SO.Count=1 then begin
        SO.SilentMode:= true;
        SO.Connection.BeginTransaction;
        So.BusObjEvent:= DoBusinessObjectEvent;
        if SO.UnGroupProductionEntry(QrymainSaleLineID.AsInteger , MSG) then begin
          So.Connection.CommitTransaction;
          RefreshQuery;
        end else begin
          So.Connection.RollbackTransaction;
        end;
      end;
    finally
      FreeandNil(SO);
    end;
  finally
    unGrouping:= False;
    actUnGroup.Enabled := not(unGrouping);
  end;
end;

procedure TBOMOrderStatusGUI.actUnGroupUpdate(Sender: TObject);
begin
  inherited;
  actUnGroup.Enabled := (grdmain.SelectedList.Count =1) and (qryMainBOMProductionLine.AsBoolean) and (qryMainProcTreeId.AsInteger = qryMainTreeRootID.AsInteger);
end;

procedure TBOMOrderStatusGUI.beforeshowManufactureProductList(Sender: TObject);
begin
  if not(Sender is TbaselistingGUI) then exit;
  TbaselistingGUI(Sender).TimerMsg(TbaselistingGUI(Sender).lblnote,'This is the list of ''BOM Template'' Products. A product can be set as a ''BOM Template'' product in the product card.  Please Select the Product to replace with from this list' , 60);
  TbaselistingGUI(Sender).FilterString := 'IsBOmtemplate ="T"';
end;
Procedure TBOMOrderStatusGUI.DetaillistWithSelection;
var
  st:TIntegerList;
  ctr:Integer;
begin
  if grdmain.SelectedList.Count =0 then begin
    grpExtrafilter.itemindex:= 1;
    Exit;
  end;
  st:= TIntegerList.Create;
  try
    st.CommaText := selectedIds('saleLineID');
    grpExtrafilter.itemindex:= 1;
    for ctr:= 0 to st.Count-1 do begin
     ValidateForGrouping(st[ctr]);
    end;
  finally
    Freeandnil(st);
  end;

end;
procedure TBOMOrderStatusGUI.btnGroupClick(Sender: TObject);
var
  st:TIntegerList;
  ctr:Integer;
  isaleID:Integer;
  SO:TSalesOrder;
  totQtyShipped :double;
  BOMProductionLineID:Integer;
  ExtrafilterIndex:Integer;
  MergedNode,Targetnode:TProctreenode;

begin
  inherited;
  if grouping then exit;
  grouping := true;
  try
    btnGroup.Enabled := not(Grouping);
    ExtrafilterIndex := grpExtrafilter.itemindex;
    Qrymain.DisableControls;
    try
      if grpExtrafilter.itemindex =0 then DetaillistWithSelection;
      if grdmain.SelectedList.Count <= 0 then begin
        MessageDlgXP_Vista('Please Select the products to be merged', mtInformation, [mbOK], 0);
        exit;
      end;

      St:= TIntegerList.Create;
      try
        st.CommaText:=  SelectedIDs(QrymainSAlelineId.FieldName ,True);
        grdmain.UnselectAll;
        for ctr := 0 to st.Count-1 do begin
            ValidateForGrouping(st[ctr]);
        end;

        if grdmain.SelectedList.Count <= 0 then begin
          MessageDlgXP_Vista('Please Select the products to be merged', mtInformation, [mbOK], 0);
          exit;
        end;

        st.CommaText:=  SelectedIDs(QrymainSAleId.FieldName ,True);
        if St.Count >1 then begin
          MessageDlgXP_Vista('Selected entries belongs to different sales Orders - not possible to group ', mtInformation, [mbOK], 0);
          exit;
        end;
        isaleID :=st[0];

        st.CommaText:=  SelectedIDs(QrymainSAlelineId.FieldName ,True);
        if St.Count =1 then begin
          MessageDlgXP_Vista('Selected entries belongs to the same product.', mtInformation, [mbOK], 0);
          exit;
        end;

        //MessageDlgXP_Vista('Please Select the Product to replace with from this list', mtInformation, [mbOK], 0);
        OpenERPListFormSingleselectModal('TManufactureProductListGUI' , GetreplacingProductID, beforeshowManufactureProductList);
        if fireplacingProductID =0 then exit;

        if (not(Userlock.Lock('tblsales' ,isaleID , Self.Caption))) then begin
          MessageDlgXP_Vista(replaceStr(Userlock.lockMessage , 'Unable to update data.' , 'Unable to Group lines in SO #' + inttostr(isaleID ) +'.'), mtWarning, [mbOK], 0);
          Exit;
        end;

        try
           SO:= TSalesOrder.CreateWithNewConn(Self);
           try
              So.Load(iSaleID);
              SO.SilentMode:= true;
              if SO.Count = 0 then exit;
              SO.Connection.BeginTransaction;
              So.BusObjEvent:= DoBusinessObjectEvent;
              try
                totQtyShipped := 0;
                for ctr := 0 to st.Count-1 do begin
                  if SO.Lines.Locate('SaleLineID' , st[ctr] , []) then begin
                    SO.Lines.BOMGroupedLine := True;
                    SO.Lines.BOMProductionLine:= False;
                    SO.Lines.PostDb;
                    SO.Lines.Save;
                    totQtyShipped := totQtyShipped +SO.Lines.QtyShipped;
                  end;
                end;
                if totQtyShipped =0 then exit;
                if not(confirmTogroup(totQtyShipped)) then begin
                  SO.Connection.RollbackTransaction;
                  exit;
                end;

                SO.Lines.New;
                SO.Lines.ProductId := fireplacingProductID;
                SO.Lines.Product_Description_Memo:= 'manufacture Lines Grouped';
                SO.Lines.QtySold := totQtyShipped;
                SO.Lines.QtyShipped := totQtyShipped;
                SO.Lines.BOMProductionLine := True;
                SO.Lines.BOMGroupedLine := False;
                SO.Lines.LinePriceInc:=0;
                SO.Lines.Save; // will save the tree with the changed qty
                TSalesline(SO.Lines).InstantiateTree;
                Targetnode := Treenode(SO.Lines);
                Targetnode.InitWithZeroQty;
                BOMProductionLineID := SO.Lines.ID;
                for ctr := 0 to st.Count-1 do begin
                  if not SO.SalesGroupedLines.Locate('SaleID;BOMProductionLineID;BOMGroupedLineID' , vararrayof([SO.ID,BOMProductionLineID,st[ctr]]),[]) then begin
                    SO.SalesGroupedLines.New;
                    SO.SalesGroupedLines.BOMProductionLineID :=BOMProductionLineID;
                    SO.SalesGroupedLines.BOMGroupedLineID:= st[ctr];
                    SO.SalesGroupedLines.GroupedAt := now;
                    SO.SalesGroupedLines.PostDB;
                  end;
                end;
                for ctr:= 0 to st.Count -1 do begin
                  if SO.Lines.Locate('SaleLineId' , St[ctr] , []) then begin
                    TSalesline(SO.Lines).InstantiateTree;
                    MergedNode := Treenode(SO.Lines);
                    MergedNode.MergeTree(Targetnode);
                    Targetnode.Savenocheck;
                  end;
                end;
                Targetnode.CalcPrice;
                Targetnode.SaveNoCheck;
                if SO.Lines.Locate('SaleLineId' , BOMProductionLineID , []) then begin
                  SO.Lines.LinePriceInc:=0;
                end;
                SO.Connection.CommitTransaction;
                RefreshQuery;
              Except
                on E:Exception do begin
                  SO.Connection.RollbackTransaction;
                end;
              end;
           finally
             Freeandnil(SO);
           end;
        finally
            Userlock.unLock('tblsales' ,isaleID , Self.Caption);
        end;

      finally
        Freeandnil(st);
      end;
    finally
      if grpExtrafilter.itemindex <> ExtrafilterIndex then grpExtrafilter.itemindex := ExtrafilterIndex;
      Qrymain.enableControls;
    end;
  finally
    Grouping:= False;
    btnGroup.Enabled := not(Grouping);
  end;
end;
function TBOMOrderStatusGUI.Treenode(busobj: TBusobj):TProctreenode;
var
  x: integer;
begin
  result:= nil;
  if busobj is TSalesline then TSalesline(busobj).InstantiateTree;
  for x:= 0 to busobj.container.Count -1 do
    try
      if (busobj.container.Item[x] is TProctreenode) then begin
        Result :=TProctreenode(busobj.container.Item[x]);
        exit;
      end;
    except
    end;
end;


function  TBOMOrderStatusGUI.ConfirmtoGroup(QtyGrouping:Double):Boolean;
var
  Qry:TERPquery;
begin
  result:= false;
  Qry := tempMyquery;
  try
    Qry.SQL.Add('Select ' +
                ' SL.ProductName , SL.UnitofMeasureSaleLines , SL.UnitofMeasureShipped ' +
                ' From tblsaleslines SL  ' +
                ' Where SaleLineID in (' + SelectedIDs('SaleLineID', true) +')');
    Qry.open;
    if Qry.RecordCount = 0 then exit;
    InitMsgParams;
    PopupMsgParams.Msgcaption := 'Products to Group';
    PopupMsgParams.Msgds := Qry;
    PopupMsgParams.fieldnames := 'ProductName,UnitofMeasureSaleLines,UnitofMeasureShipped';
    PopupMsgParams.displayLabels:= 'Product,UOM,Qty' ;
    PopupMsgParams.Custombuttons := 'Yes,No';
    PopupMsgParams.Msg1:='This is the list of products you will be ' +NL +'replacing for production';
    PopupMsgParams.Msg2 := 'Are you sure you want to replace these with ' +NL+Quotedstr(fsreplacingProductName)+'?';
    PopupMsgParams.MsgColor := Self.Color;
    result := TfmMessageWithList.MsgDlg= 100;

  finally
    Qry.ClosenFree;
  end;
end;

procedure TBOMOrderStatusGUI.FormCreate(Sender: TObject);
begin
  Grouping:= False;
  ungrouping:=False;
  Tablename := CommonDbLib.GetUserTemporaryTableName('BOMOrderStatus');
  closeDB(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.Add('Select ');
  Qrymain.SQL.Add('* ');
  Qrymain.SQL.Add('from ' +tablename );
  Qrymain.SQL.Add('where nodeselected ="T" ');
  Qrymain.SQL.Add('order by saleID desc, TreerootID, Sequencedown ');
  inherited;
  DisableSortoncolumtitleclick:= TRue;
  BaseIndexfields:= 'SaleID';
  fiSaleId :=0;
  fiSaleLineId:=0;
  if Appenv.companyprefs.OpenTreeOnSmartOrdercreation then begin
    btnSO.Hint := 'This will open the ''Production Tree'' of the sale to make changes.'+NL+NL+
                  'Saving the Tree will create/update ''Smart Order'' for all products with a ''Quantity to Order'' in the Tree.' +NL+NL+
                  'Not Saving the Tree will create/update ''Smart Order'' for the selected Lines only';
  end else begin
    btnSO.Hint := 'This will create/update ''Smart Order'' for the selected Lines only';
  end;
  btnSO.ShowHint := True;
  btnGroup.hint := 'This will let you select an alternate BOM product for all the selected Products.'+NL+'The selection should match the criteria:' +NL+
                    '      -> The total Quantity should be manufacturing  '+NL+
                    '      -> Should not have any Smart Order / Purchase Order already created for it  ' +NL+
                    '      -> Should not be one thats already Grouped  '+NL+
                    '      -> Should not have any process started  '+NL;
  btnGroup.showhint := True;
end;

procedure TBOMOrderStatusGUI.FormDestroy(Sender: TObject);
begin
  commondblib.DestroyUserTemporaryTable(tablename);
  commondblib.DestroyUserTemporaryTable(tablename+'1');
  inherited;
end;

procedure TBOMOrderStatusGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;

  if  (sameText(Field.fieldname, qryMainSaleId.fieldname) or
       sameText(Field.fieldname, qryMainSaledate.fieldname) or
       sameText(Field.fieldname, qryMainShipDate.fieldname) or
       sameText(Field.fieldname, qryMainETADate.fieldname) or
       sameText(Field.fieldname, qryMainConverted.fieldname) or
       sameText(Field.fieldname, qryMainclientID.fieldname) or
       sameText(Field.fieldname, qryMainSaleCustomerName.fieldname) or
       sameText(Field.fieldname, qryMainTreeRootID.fieldname) or
       sameText(Field.fieldname, qryMainSaleLineID.fieldname)) and (*(grpExtrafilter.ItemIndex<>0) and *)
       (QrymainProcTreeId.AsInteger <> QrymainTreeRootID.AsInteger ) then begin
      AFont.Color :=ABrush.Color;
  end else if  sameText(Field.fieldname, qryMainOrdered.fieldname) or
      sameText(Field.fieldname, qryMainreceived.fieldname) or
      sameText(Field.fieldname, qryMainBakorder.fieldname) then
      ABrush.Color := Appenv.companyPrefs.ProductStatusOrderQtyColour
  else if  sameText(Field.fieldname, qryMainInStockQty.fieldname) or
      sameText(Field.fieldname, qryMainOnOrderQty.fieldname) or
      sameText(Field.fieldname, QrymainAvailableQty.fieldname) then
      ABrush.Color := Appenv.companyPrefs.ProductStatusPartQtyColour
  else if sameText(Field.fieldname, qryMainFromStockUOMQty.fieldname) or
    sameText(Field.fieldname, qryMainManufactureUOMQty.fieldname) or
    sameText(Field.fieldname, qryMainOnOrderUOMQty.fieldname) then
      ABrush.Color := Appenv.companyPrefs.ProductStatusTransQtyColour
  else if sameText(Field.fieldname, qryMainFromStockUOMQty.fieldname) or
    sameText(Field.fieldname, qryMainManufactureUOMQty.fieldname) or
    sameText(Field.fieldname, qryMainOrdered.fieldname) or
    sameText(Field.fieldname, qryMainreceived.fieldname) or
    sameText(Field.fieldname, qryMainBakorder.fieldname) or
    sameText(Field.fieldname, qryMainInStockQty.fieldname) or
    sameText(Field.fieldname, qryMainOnOrderQty.fieldname) or
    sameText(Field.fieldname, QrymainAvailableQty.fieldname) or
    sameText(Field.fieldname, qryMainOnOrderUOMQty.fieldname) then begin
      if Field.asFloat =0 then
        AFont.color := Abrush.color;
  (*end else if Qrymaindetails.AsInteger = 1 then begin
          if (Sametext(field.FieldName , qryMainInStockQty.FieldName) or
              Sametext(field.FieldName , QrymainUOM.FieldName) or
              Sametext(field.FieldName , QrymainAvailableQty.FieldName)) then begin
              AFont.Color := clGray;
          end else
                Afont.Color := ABrush.Color;
  end else if (grpExtrafilter.ItemIndex =2) and (Qrymaindetails.AsInteger =0) and SameText(Field.FieldName , Qrymainuom.FieldName) then begin
            Afont.Color := ABrush.Color;*)
  end else if (qrymainetadate.AsDateTime<>0) and (qryMainBakorder.AsFloat <> 0) then begin
    if ( appenv.Employee.GoodToReceiveReminderDays<>0) and ( incday(qrymainetadate.AsDateTime ,0-appenv.Employee.GoodToReceiveReminderDays)<= date) then
      ABrush.color := Appenv.companyPrefs.ProductStatusETAExceededColour
    else
      ABrush.color := Appenv.companyPrefs.ProductStatusETAWithinPeriodColour;
  end;

  if Qrymaindetails.AsInteger = 1 then begin
          if (Sametext(field.FieldName , qryMainInStockQty.FieldName) or
              Sametext(field.FieldName , QrymainUOM.FieldName) or
              Sametext(field.FieldName , QrymainAvailableQty.FieldName)) then begin
              AFont.Color := clGray;
          end else
                Afont.Color := ABrush.Color;
  end else if (grpExtrafilter.ItemIndex =2) and (Qrymaindetails.AsInteger =0) and SameText(Field.FieldName , Qrymainuom.FieldName) then begin
            Afont.Color := ABrush.Color;
  end;

end;
Function TBOMOrderStatusGUI.SOIFdorSale(Const lineID:Integer):Integer;
begin
  With TempMyQuery do try
    SQL.Add('select SmartOrderID from tblsmartorderlines where saleLineId=' +inttostr(lineID));
    open;
    Result := fieldByname('SmartOrderID').AsInteger;
  finally
    ClosenFree;
  end;
end;
procedure TBOMOrderStatusGUI.grdMainDblClick(Sender: TObject);
var
  SmartOrderID:Integer;
begin
  if TField(grdMain.GetActiveField).FieldName = Qrymainonorderqty.fieldname then begin
    SubsequentID := Chr(95) + 'OnOrderRequest';
    AppContext['PartDrillInfo'].IntVar['Department'] := 0;
    inherited;
  end else if TField(grdMain.GetActiveField).FieldName = QrymainAvailableQty.fieldname then begin
    ProcessingCursor(True);
    try
         TProductMovementForm.showList(Self, getproduct(qryMainProductname.AsString), 0);
        Exit;
    finally
      ProcessingCursor(False);
    end;
  end else if Sametext(Activefieldname, 'TreeProduct') then begin
    OpenProductTree(QrymainSaleId.AsInteger , qryMainTreeRootID.AsInteger , False);
  end else if SameText(ActiveFieldName , 'ProductName')  and (trim(qryMainProductname.AsString) <> '')then begin
     openERPForm('TfrmParts'  , GetProduct(qryMainProductname.AsString) );
  end else if (SameText(ActiveFieldName , 'Ordered'))  then begin
    SmartOrderID:= SOIFdorSale(QrymainSaleLineID.asInteger);
    if SmartOrderID <> 0 then
      openERPForm('TSmartOrderGUI'  ,SmartOrderID)
    else
      MessageDlgXP_Vista('There is no smart order created for ' + QrymainTreeProduct.asString+ ' of Sales Order # ' + inttostr(QrymainSaleID.asInteger) +'.', mtWarning, [mbOK], 0);
  end else if (SameText(ActiveFieldName , 'Bakorder')) or (SameText(ActiveFieldName , 'received'))  then begin
    SmartOrderID:= SOIFdorSale(QrymainSaleLineID.asInteger);
    if SmartOrderID <> 0 then
      openERPForm('TSmartOrderGUI'  ,SmartOrderID)
    else
      MessageDlgXP_Vista('There is no smart order created for ' + QrymainTreeProduct.asString+ ' of Sales Order # ' + inttostr(QrymainSaleID.asInteger) +'.', mtWarning, [mbOK], 0);
  end else begin
    inherited;
  end;

end;

procedure TBOMOrderStatusGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:  GroupFilterString := 'Converted = ' + QuotedStr('F') ;
    1:  GroupFilterString := 'Converted = ' + QuotedStr('T') ;
  end;
  if grpExtrafilter.itemindex = 0 then begin
    if GroupFilterString <> '' then GroupFilterString := GroupFilterString + ' and ';
    GroupFilterString := GroupFilterString + ' ProcTreeId =TreeRootID and details =0 ';
  end else if grpExtrafilter.itemindex = 1 then begin
    if GroupFilterString <> '' then GroupFilterString := GroupFilterString + ' and ';
    GroupFilterString := GroupFilterString + ' details =0 ';
  end else if grpExtrafilter.itemindex = 2 then begin
    // force displaying the uom just before the qty
    guiprefs.DbGridElement[grdmain].AddField(Qrymainuom.fieldname);
    if (QrymainAvailableQty.Index < qryMainInStockQty.Index) and (QrymainAvailableQty.Index <qryMainOnOrderQty.Index) then
      Qrymainuom.Index := QrymainAvailableQty.Index-1
    else if (qryMainInStockQty.Index < QrymainAvailableQty.Index) and (qryMainInStockQty.Index <qryMainOnOrderQty.Index) then
      Qrymainuom.Index := qryMainInStockQty.Index-1
    else Qrymainuom.Index := qryMainOnOrderQty.Index-1;
  end;
  inherited;
end;


procedure TBOMOrderStatusGUI.RefreshQuery;
var
  st :TStringlist;
  dt:TDatetime;
begin
  dt:= now;
  try
    closeDB(qrymain);
    st:= tStringlist.Create;
    try
      St.add('Drop table if exists ' +Tablename +';');
      St.add('Create table ' +tablename + ' Select'+
              ' PT.TreeRootID,'+
              ' PT.ParentID,'+
              ' PT.PartsId,'+
              ' S.clientID,'+
              ' space(20) as Parttype,  '+
              ' S.CustomerName as SaleCustomerName,'+
              ' SL.ProductName as TreeProduct,'+
              ' SL.BOMProductionLine,'+
              ' SL.SaleLineID,'+
              ' s.SaleId,'+
              ' S.Saledate,'+
              ' SL.ShipDate,  '+
              ' PT.ProcTreeId,'+
              ' PT.inputType ,'+
              ' PT.selected ,'+
              ' PT.Sequencedown ,' +
              ' Convert(TreeNodeCaption(PT.Level, PT.caption ) ,char(255)) Productname,'+
              ' PT.FromStockUOMQty ,'+
              ' PT.ManufactureUOMQty ,'+
              ' PT.OnOrderUOMQty ,'+
              ' concat(PT.TreePartUOM ,if(PT.TreePartUOMMultiplier = 1 , "" , concat( " (" , PT.TreePartUOMMultiplier , ")"))) as UOM,'+
              ' S.Converted,'+
              ' PT.Description'+
              ' from '+
              ' tblsales S'+
              ' inner join tblSaleslines SL on SL.SaleId = S.SaleID'+
              ' inner join tblProctree PT on SL.SaleLineID = PT.MasterId and PT.MasterType <> "mtProduct"'+
              ' /*Left join tblproctree PTP on PT.parentID = PTP.ProcTreeId*/ '+
              ' where /*(PT.parentId =0 or PTP.InputType <> "itOption" or PT.selected ="T")'+
              ' and */ PT.MasterType = "mtSalesOrder"'+
              ' and ifnull(SL.shipped,0)<>0'+
              ' and SL.Shipdate between ' + Quotedstr(Formatdatetime(MySQLdatetimeformat , FilterDateFrom)) +' and ' + Quotedstr(Formatdatetime(MySQLdatetimeformat , FilterDateto)) +' and (SL.BOMProductionLine ="T" or SL.BOMGroupedLine ="F" )');
      if fiSaleId <> 0 then st.add(' and S.SaleId =' +inttostr(fiSaleId) +' ');
      if fiSaleLineId<>0 then st.add(' and SL.SaleLineId =' +inttostr(fiSaleLineId) +' ');
      St.add(' group by PT.ProctreeID');
      St.add(' Order by SaleId desc;');
      St.add('ALTER TABLE ' +tablename + ' ADD COLUMN ID int NOT NULL AUTO_INCREMENT , ADD PRIMARY KEY(`ID`), ADD INDEX `SaleID`(`saleId`),  add index  ProctreeID (ProctreeID), add index PartsID (PartsID), Add index Parttype (Parttype);');
      St.add('ALTER TABLE ' +tablename + ' ADD COLUMN AvailableQty double default 0;');
      St.add('ALTER TABLE ' +tablename + ' ADD COLUMN InStockQty   double default 0;');
      St.add('ALTER TABLE ' +tablename + ' ADD COLUMN OnOrderQty   double default 0;');
      St.add('ALTER TABLE ' +tablename + ' ADD COLUMN Ordered   double default 0;');
      St.add('ALTER TABLE ' +tablename + ' ADD COLUMN received   double default 0;');
      St.add('ALTER TABLE ' +tablename + ' ADD COLUMN Bakorder   double default 0;');
      st.Add('update '+tablename +' t inner join tblParts P on P.partsId = T.partsID set T.parttype = P.parttype;');
      St.add('Drop table if exists '+Tablename +'1;');
      St.add('Create table '+tablename +'1 Select distinct ProctreeId from ' +tablename +';');
      St.add('ALTER TABLE ' +tablename + '1 ADD COLUMN ID int NOT NULL AUTO_INCREMENT , ADD PRIMARY KEY(`ID`), add index  ProctreeID (ProctreeID);');
      St.add('Delete T.* from ' +tablename +' T Left join ' +tablename +'1 as T1 on T.parentID = T1.ProctreeId where ifnull(T1.proctreeID,0)=0 and T.parentID<>0;');
      St.add('Drop table if exists '+Tablename +'1;');
      St.add('Create table '+Tablename +'1 Select PQa.productId partsID, ' +
              SQL4Qty(tAvailable,'PQA' , 'Qty' ) +' as AvailableQty,'+
              SQL4Qty(tInStock,'PQA' , 'Qty' ) +' as InStockQty,'+
              SQL4Qty(tPOBO,'PQA' , 'Qty' ) +' as OnOrderQty'+
              ' from tblPQa PQA where  PQA.productID  in (Select PartsId from ' +tablename +' T  where T.parttype ="INV")  group by ProductId;');

      St.add('ALTER TABLE ' +tablename + '1 ADD COLUMN ID int NOT NULL AUTO_INCREMENT , ADD PRIMARY KEY(`ID`), add index  PartsID (PartsID);');
      St.add('update ' +tablename + '1 T1 inner join ' +tablename +' T on T.PartsId = T1.PartsId '+
                ' Set T.AvailableQty =  T1.AvailableQty,' +
                ' T.InStockQty = T1.InStockQty,'+
                ' T.OnOrderQty = T1.OnOrderQty;');
      St.add('Drop table if exists '+Tablename +'1;');
      st.Add(SQLToupdateOrderQtys(tablename, 'Ordered' , 'received' , 'Bakorder' , true));
      st.Add('Alter table ' +tablename +' add column nodeselected Enum("T","F") default "F";');
      ExecuteSQLwithProgress(st.Text);
      Sleep(100);
      ChecknUpdateInTreeNodesSelected(Tablename  , 'nodeselected');
      St.Clear;
      St.add('Create table '+Tablename +'1 Select T.SaleId, T.SaleLineId, T.ProctreeId, T.TreeRootID, T.nodeselected ,T.Sequencedown ,  T.converted,  PQa.productId partsID, ' +
              'concat(PQA.UOM ," (" ,  PQA.UOMMultiplier , ")") as UOMDetails, PQA.UOM , PQA.UOMMultiplier, ' +
              SQL4Qty(tAvailable,'PQA' , 'UOMQty' ) +' as AvailableQty,'+
              SQL4Qty(tInStock,'PQA' , 'UOMQty' ) +' as InStockQty'+
              ' from tblPQA as PQA '+
              ' inner join tblParts as P on PartsId = PQA.ProductID'+
              ' inner join tblunitsofmeasure on tblunitsofmeasure.UnitID = PQA.UOMID'+
              ' inner join ' + tablename + ' T on T.PartsId = PQa.ProductID' +
              ' and tblunitsofmeasure.Active ="T"'+
              ' group by SaleId, saleLineID, treerootId, proctreeid, productId, PQA.UOM , PQA.UOMMultiplier ;')  ;
      st.Add('Alter table ' +tablename +' add column Details int(11) default 0;');
      st.Add('update ' +tablename +' set Details =0 ;');
      st.Add('insert into ' +tablename + ' (saleId, saleLineId, proctreeId, treeRootID, nodeSelected, partsId, AvailableQty, instockQty, Sequencedown, UOM, details , converted) ' +
                                   ' Select saleId, saleLineId, proctreeId, treeRootID, nodeSelected, partsId, AvailableQty, instockQty, Sequencedown , UOMDetails , 1 , converted from '+Tablename +'1  where ifnull(AvailableQty,0)<>0 or ifnull(instockQty,0)<> 0;');
      St.add('Drop table if exists '+Tablename +'1;');
      ExecuteSQLwithProgress(st.Text);
    finally
      freeandnil(st);
    end;
    inherited;
  finally
  if devmode then
    TimerMsg(lblNote , 'RefreshQuery time :' + SecondsToTime(SecondsBetween(now, dt)));
  end;
end;

procedure TBOMOrderStatusGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainproctreeId.fieldname);
  RemoveFieldfromGrid(QrymainClientID.fieldname);
  RemoveFieldfromGrid(QrymainTreeRootID.fieldname);
  RemoveFieldfromGrid(qryMainBOMProductionLine.fieldname);
  RemoveFieldfromGrid(qryMainDetails.fieldname);
end;

procedure TBOMOrderStatusGUI.SetSaleId(const Value: Integer);
begin
  fiSaleId := Value;
  Applyfilter;
end;

procedure TBOMOrderStatusGUI.SetSaleLineId(const Value: Integer);
begin
  fiSaleLineId := Value;
  Applyfilter;
end;
Procedure TBOMOrderStatusGUI.Applyfilter;
begin
  if (fiSaleId <> 0) or (fiSaleLineId <> 0) then begin
    chkIgnoreDates.visible :=False;
    cboDateRange.visible :=False;
    lblFrom.visible :=False;
    dtFrom.visible :=False;
    lblTo.visible :=False;
    dtTo.visible :=False;
  end;

end;

initialization
  RegisterClassOnce(TBOMOrderStatusGUI);

end.

