unit SmartorderListDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwcheckbox, CustomInputBox, wwradiogroup, wwclearbuttongroup, GIFImg;

type
  TSmartorderListDetailsGUI = class(TBaseListingGUI)
    qryMainSmartOrderDesc: TWideStringField;
    qryMainSmartOrderId: TIntegerField;
    qryMainPODesc: TWideStringField;
    qryMainpartsname: TWideStringField;
    qryMaincostEx: TFloatField;
    qryMainCostInc: TFloatField;
    qryMainClassname: TWideStringField;
    qryMainsuppliername: TWideStringField;
    qryMainUOM: TWideStringField;
    chkExcludeifnoSupplier: TCheckBox;
    DNMSpeedButton1: TDNMSpeedButton;
    grpExtraFilters: TwwRadioGroup;
    qryMainconverted: TWideStringField;
    qryMainShippedamtex: TFloatField;
    qryMainShippedamtinc: TFloatField;
    qryMainSmartOrderLinesID: TIntegerField;
    qryMainapproved: TWideStringField;
    qryMainapprovedby: TWideStringField;
    qryMainQtyTotal: TFloatField;
    btnMergeNew: TDNMSpeedButton;
    qryMainDetails: TIntegerField;
    qryMainCreationDate: TDateTimeField;
    procedure grpFiltersClick(Sender: TObject);override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure chkAdvancedPrintingClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
    procedure btnMergeNewClick(Sender: TObject);
    procedure SmartOrderAfterShow(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fstablename:String;
    procedure beforeshowSmartOrderList(Sender: TObject);
    procedure initSupplierOrderShipments(Sender: TObject);
    procedure Populatedata;
  Protected
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib, CommonFormLib, SmartOrderListForm, SupplierOrderShipments, SystemLib,
     CommonDBLib, frmSmartOrderfrm, busObjSmartOrder, tcConst, MySQLConst;

{$R *.dfm}

{ TSmartorderListDetailsGUI }

procedure TSmartorderListDetailsGUI.btnMergeNewClick(Sender: TObject);
begin

  if grdMain.SelectedList.Count = 0 then
  begin
    ShowWarning('Please Select Records To Be Merged Into a Smart Order');
    exit;
  end;

  OpenERPForm('TSmartOrderGUI', 0, SmartOrderAfterShow, nil);

end;

procedure TSmartorderListDetailsGUI.chkAdvancedPrintingClick(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = chkAdvancedPrinting then
    RefreshQuery;
end;

procedure TSmartorderListDetailsGUI.cmdNewClick(Sender: TObject);
var
  tmpComponent: TComponent;
begin
  DisableForm;
  try
    inherited;
    tmpComponent := GetComponentByClassName('TSmartOrderGUI');
    if not Assigned(tmpComponent) then Exit;
    with TSmartOrderGUI(tmpComponent) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  finally
    EnableForm;
  end;
end;

procedure TSmartorderListDetailsGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TSmartOrderListGUI' , beforeshowSmartOrderList);
  Self.close;
end;
procedure TSmartorderListDetailsGUI.FormCreate(Sender: TObject);
begin
  fsTablename := CommonDbLib.GetUserTemporaryTableName('tmp_SOList' );
  Qrymain.sql.clear;
  Qrymain.sql.add('Select');
  Qrymain.sql.add(' * ');
  Qrymain.sql.add('from '+ fstablename+'');
  Qrymain.sql.add(' order by suppliername, Details, CreationDate,partsname');
  inherited;

end;

procedure TSmartorderListDetailsGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  inherited;
end;

procedure TSmartorderListDetailsGUI.beforeshowSmartOrderList(Sender: TObject);
begin
  TSmartOrderListGUI(Sender).dtFrom.Date   := dtFrom.Date;
  TSmartOrderListGUI(Sender).dtto.Date     := dtto.Date;
  TSmartOrderListGUI(Sender).fbDateRangeSupplied := true;
end;
procedure TSmartorderListDetailsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if GrpFilters.ItemIndex = 1 then begin
    if qryMainDetails.asinteger =1 then AFont.Style := AFont.Style +[fsbold];
  end;
end;
procedure TSmartorderListDetailsGUI.initSupplierOrderShipments(Sender: TObject);
begin
  if not(Sender is TSupplierOrderShipmentsGUI) then exit;
  TSupplierOrderShipmentsGUI(Sender).SmartOrderLinesID := qryMainSmartOrderLinesID.asInteger;
end;

procedure TSmartorderListDetailsGUI.grdMainDblClick(Sender: TObject);
begin
  if (sameText(ActiveFieldname , qryMainShippedamtex.fieldname) or
      sameText(ActiveFieldname , qryMainShippedamtinc.fieldname)) then begin
      if (qryMainSmartOrderLinesID.asInteger <> 0) then
        OpenERPListForm('TSupplierOrderShipmentsGUI' , initSupplierOrderShipments)
      else CommonLib.MessageDlgXP_Vista('No further information available on this column. ', mtInformation, [mbOK], 0);
  end else if QrymainSmartOrderId.AsInteger <> 0 then  inherited
  else CommonLib.MessageDlgXP_Vista('No further information available on this column. ', mtInformation, [mbOK], 0);
end;

procedure TSmartorderListDetailsGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  if grpFilters.ItemIndex =0 then GroupFilterString := 'Details = 1';
  (*case grpFilters.ItemIndex of
    0:begin
      GroupFilterString := 'Details = 1';
      case grpExtraFilters.ItemIndex of
        0:  GroupFilterString := GroupFilterString +' and converted =' + Quotedstr('F');
        1:  GroupFilterString := GroupFilterString +' and converted =' + Quotedstr('T');
      end;
    end;
    1:begin
      case grpExtraFilters.ItemIndex of
        0:  GroupFilterString := ' Details = 1 or converted =' + Quotedstr('F');
        1:  GroupFilterString := ' Details = 1 or converted =' + Quotedstr('T');
      end;
    end;
  end;*)
  RefreshQuery;
  inherited;
end;

procedure TSmartorderListDetailsGUI.RefreshQuery;
begin
(*  Qrymain.ParamByName('DateFrom').AsDateTime := FilterDateFrom;
  Qrymain.ParamByName('DateTo').AsDateTime := FilterDateTo;
  Qrymain.ParamByName('ExcludeifnoSupplier').AsString := BooleantoStr(chkExcludeifnoSupplier.checked);

       if grpExtraFilters.itemindex =0 then Qrymain.ParamByName('Converted').AsString := 'F'
  else if grpExtraFilters.itemindex =1 then Qrymain.ParamByName('Converted').AsString := 'T'
  else Qrymain.ParamByName('Converted').AsString := '';*)
  closedb(Qrymain);
  Populatedata;
  inherited;
end;
procedure TSmartorderListDetailsGUI.Populatedata;
function convertFilter:String;
begin
        if grpExtraFilters.itemindex =0 then Result   := 'F'
  else  if grpExtraFilters.itemindex =1 then Result   := 'T'
  else Result   := '';
end;
begin
  With scriptmain do begin
    SQL.clear;
    SQL.add('drop table if exists ' + fstablename +';');
    SQL.add('Create table  ' + fstablename + ' (  ' +
            ' Details           INT(11)       DEFAULT 0, ' +
            ' CreationDate      DATETIME      DEFAULT NULL, ' +
            ' SmartOrderDesc    VARCHAR(255)  DEFAULT NULL, ' +
            ' SmartOrderId      INT(11)       DEFAULT NULL, ' +
            ' SmartOrderLinesID INT(11)       DEFAULT NULL, ' +
            ' PODesc            VARCHAR(255)  DEFAULT NULL, ' +
            ' partsname         VARCHAR(255)  DEFAULT NULL, ' +
            ' QtyTotal          DOUBLE        DEFAULT NULL, ' +
            ' costEx            DOUBLE        DEFAULT NULL, ' +
            ' CostInc           DOUBLE        DEFAULT NULL, ' +
            ' Classname         VARCHAR(255)  DEFAULT NULL, ' +
            ' suppliername      VARCHAR(255)  DEFAULT NULL, ' +
            ' converted         ENUM("T","F") Default "F", ' +
            ' UOM               VARCHAR(280)  DEFAULT NULL,           ' +
            ' approved          ENUM("T","F") Default "F", ' +
            ' approvedby        VARCHAR(255)  DEFAULT NULL, ' +
            ' Shippedamtex      DOUBLE        DEFAULT NULL, ' +
            ' Shippedamtinc     DOUBLE        DEFAULT NULL ' +
            ' ) ENGINE=Myisam DEFAULT CHARSET=utf8;');

    SQL.add('insert into  ' + fstablename +
            ' select ' +
            ' 1 as Details, ' +
            ' NULL as CreationDate, ' +
            ' NULL as SmartOrderDesc, ' +
            ' NULL as SmartOrderId, ' +
            ' NULL as  SmartOrderLinesID , ' +
            ' NULL as PODesc, ' +
            ' NULL as partsname,  ' +
            ' Sum(SOL.Qty) as QtyTotal, ' +
            ' Sum(SOL.costEx*SOL.Qty) as costEx , ' +
            ' Sum(SOL.CostInc*SOL.Qty) as CostInc, ' +
            ' NULL as Classname , ' +
            ' SOL.suppliername as suppliername , ' +
            ' if(ifnull(( ' +
                        ' Select count(SmartOrderID)  ' +
                        ' from tblsmartOrderlines  ' +
                        ' where tblsmartOrderlines.smartOrderID = SO.SmartOrderId and ifnull(converted,"F") <>"T"),0)  =0, "T","F") as converted, ' +
            ' NULL  as UOM  , ' +
            ' Null as  approved, ' +
            ' NULL as approvedby, ' +
            ' Sum(ifnull(POL.TotalLineAmount,0)) as Shippedamtex, ' +
            ' Sum(ifnull(POL.TotalLineAmountInc,0)) as Shippedamtinc ' +
            ' from tblsmartorderlines SOL inner join tblSmartOrder SO on SOL.SmartOrderID = SO.SmartOrderID ' +
            ' Left join ( ' +
                        ' Select SmartOrderLineID ,SmartOrderID ,  Sum(TotalLineAmount) TotalLineAmount  , sum(TotalLineAmountInc) as TotalLineAmountInc  ' +
                        ' from tblpurchaselines group by SmartOrderLineID ,SmartOrderID    ' +
                        ' ) as POL  on  POL.SmartOrderID = SOL.SmartOrderID  and POL.SmartOrderLineID  = SOL.SmartOrderLinesID ' +
            ' Where SO.CreationDate between ' + Quotedstr(Formatdatetime(MysqlDatetimeFormat , FilterDateFrom)) +' and ' +  Quotedstr(Formatdatetime(MysqlDatetimeFormat , FilterDateTo)) +'  ' +
            ' and (ifnull(SupplierName,"")<>"" or ' + Quotedstr(BooleantoStr(chkExcludeifnoSupplier.checked))+' ="F") ' +
            ' and (SOL.converted ="T" and ' + Quotedstr(convertFilter)+' ="T") or (SOL.converted ="F" and ' + Quotedstr(convertFilter)+' ="F") or (' + Quotedstr(convertFilter)+' ="") ' +
            ' group by  SOL.suppliername ;' );

    SQL.add('insert into  ' + fstablename +
            ' select ' +
            ' 2 as Details, ' +
            ' SO.CreationDate as CreationDate, ' +
            ' SO.SmartOrderDesc as SmartOrderDesc, ' +
            ' SOL.SmartOrderId as SmartOrderId, ' +
            ' SOL.SmartOrderLinesID  as SmartOrderLinesID , ' +
            ' SOL.PODesc as PODesc, ' +
            ' SOL.partsname as partsname, ' +
            ' SOL.Qty as QtyTotal, ' +
            ' SOL.costEx*SOL.Qty as costEx , ' +
            ' SOL.CostInc*SOL.Qty as CostInc , ' +
            ' SOL.Classname as Classname , ' +
            ' SOL.suppliername as suppliername, ' +
            ' converted as converted, ' +
            ' concat(unitofMeasure , " (" , SOL.unitofMeasureMultiplier, ")") as UOM  , ' +
            ' SO.approved as approved, ' +
            ' E.EmployeeName as approvedby, ' +
            ' Sum(ifnull(POL.TotalLineAmount,0)) as Shippedamtex, ' +
            ' Sum(ifnull(POL.TotalLineAmountInc,0)) as Shippedamtinc ' +
            ' from tblsmartorderlines SOL inner join tblSmartOrder SO on SOL.SmartOrderID = SO.SmartOrderID ' +
            ' Left join tblpurchaselines POL on POL.SmartOrderID = SOL.SmartOrderID  and POL.SmartOrderLineID  = SOL.SmartOrderLinesID ' +
            ' Left join tblemployees E on SO.ApproverId = E.employeeId ' +
            ' Where SO.CreationDate between ' + Quotedstr(Formatdatetime(MysqlDatetimeFormat , FilterDateFrom)) +' and ' +  Quotedstr(Formatdatetime(MysqlDatetimeFormat , FilterDateTo)) +'  ' +
            ' and (ifnull(SupplierName,"")<>"" or ' + Quotedstr(BooleantoStr(chkExcludeifnoSupplier.checked))+' ="F") ' +
            ' and (SOL.converted ="T" and ' + Quotedstr(convertFilter)+' ="T") or (SOL.converted ="F" and ' + Quotedstr(convertFilter)+' ="F") or (' + Quotedstr(convertFilter)+' ="") ' +
            ' group by SOL.SmartOrderLinesID; ' );

     SQL.text:= ChangeQuery(SQL.text);

     DoShowProgressbar(SQL.count, WAITMSG);
     try
      Execute;
     finally
       doHideProgressbar;
     end;
  end;
end;
procedure TSmartorderListDetailsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymaindetails.fieldname);
  RemoveFieldfromGrid(qryMainconverted.fieldname);
  RemoveFieldfromGrid(qryMainSmartOrderLinesID.fieldname);
end;

procedure TSmartorderListDetailsGUI.SmartOrderAfterShow(Sender: TObject);
var
  lForm : TSmartOrderGui;
  idx : integer;
  soLine : TSmartOrderLine;
  soObj : TSmartOrder;
  s : string;
  qry : TERPQuery;

begin

  if not (Sender is TSmartOrderGui) then
    exit;

  lForm := TSmartOrderGUI(Sender);

  s := '';
  // need lines selected
  for idx := 0 to grdMain.SelectedList.Count - 1 do
  begin
    qryMain.GotoBookmark(grdMain.SelectedList[idx]);
    if qryMain.FieldByName('Details').AsInteger = 1 then
      continue;
    if qryMain.FieldByName('SmartOrderLinesID').IsNull then
      Continue;
    if s = '' then
      s := qryMain.FieldByName('SmartOrderLinesID').asString
    else
      s := s + ',' + qryMain.FieldByName('SmartOrderLinesID').asString;
  end;

  if s = '' then
  begin
    ShowWarning('No Products Were Selected, Have Nothing to Merge');
    exit;
  end;

  lForm.txtSmartOrderDesc.Text  := 'Smart Order From Supplier Order Totals';
  lForm.tblMaster.Edit;
  lform.tblMaster.FieldByName('SmartOrderDesc').AsString :=  'Smart Order From Supplier Order Totals';
  lForm.tblMaster.Post;
  soObj := lForm.SmartOrder;

  qry := TERPQuery.Create(self);
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.SQL.Text := 'select * from tblSmartOrderLines where SmartOrderLinesId in (' + s + ')';
    qry.Open;
    qry.First;
    soLine := soObj.Lines;
    while not qry.Eof  do
    begin
      soLine.New;
      soLine.ProductID        := qry.FieldByName('PartsId').AsInteger;
      soLine.UnitOfMeasureID  := qry.FieldByName('UnitOfMeasureId').AsInteger;
      soLine.UnitOfMeasure    := qry.FieldByName('UnitOfMeasure').asString;
      soLine.UnitofMeasureMultiplier := qry.FieldByName('UnitOfMeasureMultiplier').AsFloat;
      if qry.FieldByName('SupplierId').AsInteger > 0 then soLine.SupplierID     := qry.FieldByName('SupplierId').AsInteger;
      soLine.SupplierName     := qry.FieldByName('SupplierName').asString;
      soLine.ToPurchaseUOMQty := qry.FieldByName('Qty').AsFloat;
      soLine.ClassID          := qry.FieldByName('ClassId').AsInteger;
      soLine.DeptName         := qry.FieldByName('ClassName').asString;
      soLine.PODesc           := qry.FieldByName('PODesc').AsString;
      soLine.LinePrice        := qry.FieldByName('LinePrice').AsFloat;
      soLine.LineTaxRate      := qry.FieldByName('LineTaxRate').AsFloat;
      soLine.GeneralNotes     := qry.FieldByName('GeneralNotes').AsString;
      soLine.RepairId         := qry.FieldByName('RepairId').AsInteger;
      soLine.CustomerEquipmentID := qry.FieldByName('CustomerEquipmentId').AsInteger;
      soLine.EquipmentName    := qry.FieldByName('EquipmentName').AsString;
      soLine.CustPONumber     := qry.FieldByName('CustPONumber').AsString;
      soLine.CusJobID         := qry.FieldByName('CusJobId').AsInteger;
      soLine.CusJobName       := qry.FieldByName('CusJobName').AsString;
      soLine.GroupID          := qry.FieldByName('GroupId').AsInteger;
      soLine.GroupLineID      := qry.FieldByName('GroupLineId').AsInteger;
      qry.Next;
    end;
  finally
    qry.Free;
  end;

end;

procedure TSmartorderListDetailsGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Grpfilters.ExcludeifnoSupplier'].asBoolean:= chkExcludeifnoSupplier.Checked;
  GuiPrefs.Node['GrpExtraFilters.ItemIndex'].AsInteger:= grpExtraFilters.ItemIndex;
  GuiPrefs.Node['GrpView.ItemIndex'].AsInteger:= grpView.ItemIndex;
end;

procedure TSmartorderListDetailsGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  chkExcludeifnoSupplier.Checked := GuiPrefs.Node['Grpfilters.ExcludeifnoSupplier'].asBoolean;
  grpExtraFilters.ItemIndex := GuiPrefs.Node['GrpExtraFilters.ItemIndex'].AsInteger;
  grpView.ItemIndex := GuiPrefs.Node['GrpView.ItemIndex'].AsInteger;
end;

initialization
  RegisterClassOnce(TSmartorderListDetailsGUI);

end.

