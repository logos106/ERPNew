unit ProductSerialNumbersForHire;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , BusObjEquipment,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProductSerialNumbersForHireGUI = class(TBaseListingGUI)
    qryMaindetails: TLargeintField;
    qryMainPurchaseLineID: TIntegerField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainPQAID: TIntegerField;
    qryMainPQADetailID: TIntegerField;
    qryMainSerialnumber: TWideStringField;
    qryMainOnHire: TWideStringField;
    qryMainEquipmentID: TIntegerField;
    qryMainEquipmentName: TWideStringField;
    lblSubtitle: TLabel;
    qryMainProductID: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    fiPurchaseOrderId: Integer;
    fiProductId: integer;
    fiEquipments:Integer;
    fsEquipmentIDs :String;
    Equipment : TEquipment;

    procedure setProductId(const Value: integer);
    procedure SetPurchaseOrderId(const Value: Integer);
    Procedure MakeQrymain;
    procedure initEquipmentList(Sender: TObject);
  Protected
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    Property PurchaseOrderId :Integer read fiPurchaseOrderId write SetPurchaseOrderId;
    Property ProductId :integer read fiProductId write setProductId;
    Procedure RefreshQuery;Override;
    Procedure CreateEquipsForSelectedSerials;
  end;


implementation

uses CommonLib, tcDataUtils, CommonDbLib, ProductQtyLib, BusObjBase, tcConst,
  CommonFormLib, EquipmentListForm;


{$R *.dfm}
procedure TProductSerialNumbersForHireGUI.initEquipmentList(Sender:TObject);
begin
  if not(sender is   TEquipmentListGUI) then exit;
  TEquipmentListGUI(Sender).FilterString := 'EquipmentID =' + replaceStr(fsEquipmentIDs , ',' , ' or EquipmentID =');
end;
procedure TProductSerialNumbersForHireGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  CreateEquipsForSelectedSerials;
end;

procedure TProductSerialNumbersForHireGUI.CreateEquipsForSelectedSerials;
begin
  if SelectedRecords = 0 then begin
    MessageDlgXP_Vista('No Serial Number Selected to Create Equipment', mtInformation, [mbOK], 0);
    Exit;
  end;
  IterateProcno := 1;
  Equipment := TEquipment.CreateWithNewConn(Self);
  try
    Equipment.Connection.BeginTransaction;
    try
      fiEquipments := 0;
      fsEquipmentIDs:= '';
      IterateselectedRecords(True);
      Equipment.Connection.CommitTransaction;
      if fiEquipments >0 then begin
        if fsEquipmentIDs <> '' then OpenERPListForm('TEquipmentListGUI' , initEquipmentList);
        MessageDlgXP_Vista(inttostr(fiEquipments) +' Equipment Created for the Selection.', mtInformation, [mbOK], 0);
      end;
    Except
      on E:Exception do begin
        Equipment.Connection.RollbackTransaction;
        MessageDlgXP_vista('Creating Equipment Failed.'+NL+Nl+E.Message, mtWarning, [mbOK], 0);
      end;
    end;
  finally
    Freeandnil(Equipment);
  end;
end;
procedure TProductSerialNumbersForHireGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer);
  function EquipName(Value:String):String;
  var
    ctr:Integer;
  begin
    ctr:= 0;
    While not Equipment.IsUnique(Equipment.ID , 'EquipmentName = ' + quotedstr(Value) , Equipment.connection.connection ) do begin
      ctr:= ctr +1;
      Value := Value +'_'+ inttostr(ctr);
    end;
    REsult := Value;
  end;
begin
  if QrymainEquipmentId.AsInteger <> 0 then exit;
  if QrymainSerialnumber.AsString = '' then exit;
  Equipment.LoadSelect('ProductId =' + inttostr(qryMainProductID.asInteger)+' and SerialNumber =' +Quotedstr(qrymainSerialNumber.asString));
  Equipment.Connection.BeginNestedTransaction;
  try
      if Equipment.count =0 then begin
        Equipment.New;
        Equipment.EquipmentName := EquipName(getProduct(qryMainProductID.asInteger)+'(' + qrymainSerialNumber.asString+')');
        Equipment.ProductId :=qryMainProductID.asInteger;
        Equipment.SerialNumber := qrymainSerialNumber.asString;
        Equipment.OnHire := True;
        Equipment.Active := TRue;
        Equipment.PostDB;
        if not Equipment.Save then begin
          Equipment.Connection.RollbackNestedTransaction;
          Exit;
        end;
        Equipment.Connection.CommitNestedTransaction;
        fiEquipments := fiEquipments +1;
        if fsEquipmentIDs <> '' then fsEquipmentIDs := fsEquipmentIDs +',';
        fsEquipmentIDs := fsEquipmentIDs + inttostr(Equipment.ID);
      end;
    Except
      on E:Exception do begin
        Equipment.Connection.RollbackNestedTransaction;
        MessageDlgXP_vista('Creating Equipment for Product ' + Quotedstr(GetProduct(QrymainproductId.AsInteger)) +' and Serialnumber '+ Quotedstr(Qrymainserialnumber.AsString)+' Failed.'+NL+NL+E.Message, mtWarning, [mbOK], 0);
      end;
    end;
end;
procedure TProductSerialNumbersForHireGUI.MakeQrymain;
begin
  closeDB(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select');
  Qrymain.SQL.add('1 as details,');
  Qrymain.SQL.add('PL.PurchaseLineID as PurchaseLineID,');
  Qrymain.SQL.add('PL.UnitofMeasureQtySold as UnitofMeasureQtySold,');
  Qrymain.SQL.add('PL.UnitofMeasureShipped as UnitofMeasureShipped,');
  Qrymain.SQL.add('PL.UnitofMeasureBackorder as UnitofMeasureBackorder ,');
  Qrymain.SQL.add('concat(PL.UnitofMeasurePOLines, "(" , PL.UnitofMeasureMultiplier , ")") as UOM,');
  Qrymain.SQL.add('PL.ProductName as ProductName,');
  Qrymain.SQL.add('PL.ProductID as ProductID,');
  Qrymain.SQL.add('null PQAID,');
  Qrymain.SQL.add('null as PQADetailID,');
  Qrymain.SQL.add('null as Serialnumber ,');
  Qrymain.SQL.add('null as OnHire ,');
  Qrymain.SQL.add('null EquipmentID,');
  Qrymain.SQL.add('null as EquipmentName');
  Qrymain.SQL.add('from tblpurchaselines PL');
  Qrymain.SQL.add('inner join tblparts P on PL.ProductID = P.partsId and P.SNTracking ="T" and P.isEquipment ="T"');
  Qrymain.SQL.add('Where PL.PurchaseOrderID =:PurchaseOrderID');
  Qrymain.SQL.add('union all');
  Qrymain.SQL.add('Select');
  Qrymain.SQL.add('2 as Details,');
  Qrymain.SQL.add('PL.PurchaseLineID as PurchaseLineID,');
  Qrymain.SQL.add('PL.UnitofMeasureQtySold as UnitofMeasureQtySold,');
  Qrymain.SQL.add('PL.UnitofMeasureShipped as UnitofMeasureShipped,');
  Qrymain.SQL.add('PL.UnitofMeasureBackorder as UnitofMeasureBackorder ,');
  Qrymain.SQL.add('concat(PL.UnitofMeasurePOLines, "(" , PL.UnitofMeasureMultiplier , ")") as UOM,');
  Qrymain.SQL.add('PL.ProductName as ProductName,');
  Qrymain.SQL.add('PL.ProductID as ProductID,');
  Qrymain.SQL.add('PQA.PQAID as PQAID,');
  Qrymain.SQL.add('PQASN.PQADetailID as PQADetailID,');
  Qrymain.SQL.add('PQASN.Value as Serialnumber ,');
  Qrymain.SQL.add('if(ifnull(E.EquipmentID , 0) =0 , "F" , "T") as OnHire ,');
  Qrymain.SQL.add('E.EquipmentID as EquipmentID,');
  Qrymain.SQL.add('E.EquipmentName as EquipmentName');
  Qrymain.SQL.add('from tblpurchaselines PL');
  Qrymain.SQL.add('inner join tblparts P on PL.ProductID = P.partsId and P.SNTracking ="T" and P.isEquipment ="T"');
  Qrymain.SQL.add('inner join tblPQA PQA on PL.PurchaseLineID = PQA.transLineID and PL.PurchaseOrderID = PQA.TransId and PQA.transType in ("TPurchaseOrderLine")');
  Qrymain.SQL.add('inner join tblpqadetails PQASN on PQA.PQAID = PQASN.PQAID and PQASN.PQAType ="SN"');
  Qrymain.SQL.add('LEft join tblequipment E on E.ProductId = PQA.ProductID and E.SerialNumber = PQASN.Value');
  Qrymain.SQL.add('Where PQA.TransId =:PurchaseOrderID ');
  Qrymain.SQL.add('union all');
  Qrymain.SQL.add('SELECT distinct ');
  Qrymain.SQL.add('3 as details,');
  Qrymain.SQL.add('NULL  as PurchaseLineID,');
  Qrymain.SQL.add('NULL  as UnitofMeasureQtySold,');
  Qrymain.SQL.add('NULL  as UnitofMeasureShipped,');
  Qrymain.SQL.add('NULL  as UnitofMeasureBackorder ,');
  Qrymain.SQL.add('concat(PQA.UOM, "(" , PQA.UOMMultiplier , ")") as UOM,');
  Qrymain.SQL.add('P.partname as ProductName,');
  Qrymain.SQL.add('P.PartsID as ProductID,');
  Qrymain.SQL.add('PQA.PQAID as PQAID,');
  Qrymain.SQL.add('PQASN.PQADetailID as PQADetailID,');
  Qrymain.SQL.add('PQASN.Value as Serialnumber ,');
  Qrymain.SQL.add('if (PQAAllocType(PQA.allocType,PQA.Transtype,PQASN.Qty,SM.StockmovementID,SM.StockmovementEntryType,FA.Serial, S.Converted, S.IsInternalOrder)= '+ quotedStr('In-Stock') + ' or '+
                      'PQAAllocType(PQA.allocType,PQA.Transtype,PQASN.Qty,SM.StockmovementID,SM.StockmovementEntryType,FA.Serial, S.Converted, S.IsInternalOrder)= '+ quotedStr('New') + ',"F" , "T")  as OnHire,');
  Qrymain.SQL.add('E.EquipmentID as EquipmentID,');
  Qrymain.SQL.add('E.EquipmentName as EquipmentName');
  Qrymain.SQL.add(' FROM ' + ProductTables(tSerialnoList, True, True, 0 , True , 0));
  //Qrymain.SQL.add('LEft join tblequipment E on E.ProductId = PQA.ProductID and E.SerialNumber = PQASN.Value');
  Qrymain.SQL.add('left join tblstockmovementlines SML on PQA.transId = SML.StockmovementID and PQA.transLineId = SML.StockmovementLinesID and PQA.transType = "TStockMovementLines"');
  Qrymain.SQL.add('Left join tblstockmovement SM on SM.StockmovementID = SML.StockmovementID');
  Qrymain.SQL.add('left join tblSales  S on PQA.transId = S.saleID and PQA.transType  in ( '+ SalesTransTypes+','+ ManufactureTypes+')');
  Qrymain.SQL.add('Where PQA.ProductID =:ProductId');
  Qrymain.SQL.add('Order by Productname, PurchaseLineID , Details, PQAID');
end;

procedure TProductSerialNumbersForHireGUI.FormCreate(Sender: TObject);
begin
  MakeQrymain;
  inherited;
  fiPurchaseOrderId := 0;
  DisableSortoncolumtitleclick:= TRue;
  HaveDateRangeSelection := False;
end;

procedure TProductSerialNumbersForHireGUI.FormShow(Sender: TObject);
begin
  inherited;
  if not Assigned(fOnGridDataSelect) then begin
          cmdNew.Caption := 'Make Equip';
          cmdNew.showhint := True;
          cmdNew.Hint := 'Select Serial Numbers to Make Equipments';
          cmdNew.Enabled := TRue;
          ListTimerMsg('Select Serial Numbers and Choose '+ Quotedstr(cmdNew.Caption) +' to Make Equipments' , nil, 30);
          Showcontrolhint( cmdNew, 'Select Serial Numbers and Choose to Make Equipments');
  end else begin
    if ProductID <> 0 then begin
      TitleLabel.caption := 'Product Serial Number';
    end else begin
      TitleLabel.caption := 'Serial Number Allocated in PO';
    end;
    Self.caption := TitleLabel.caption;
    cmdNew.Enabled := FAlse;
    ListTimerMsg('Select Serial Numbers and Choose '+ Quotedstr(cmdPrint.Caption) +' to Make Equipments' , nil, 30);
    Showcontrolhint( cmdPrint, 'Select Serial Numbers and Choose to Make Equipments');
  end;

end;

procedure TProductSerialNumbersForHireGUI.grdMainCalcCellColors(Sender: TObject;Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;ABrush: TBrush);
begin
  inherited;
  if QrymainDetails.asInteger =1 then begin
  end else begin
    if Sametext(Field.fieldname , QrymainPurchaseLineID.fieldname) or
       Sametext(Field.fieldname , QrymainUnitofMeasureQtySold.fieldname) or
       Sametext(Field.fieldname , QrymainUnitofMeasureShipped.fieldname) or
       Sametext(Field.fieldname , QrymainUnitofMeasureBackorder .fieldname) or
       Sametext(Field.fieldname , QrymainUOM.fieldname) or
       Sametext(Field.fieldname , QrymainProductName.fieldname) then
        Afont.color := ABrush.color;
  end;
end;

procedure TProductSerialNumbersForHireGUI.RefreshQuery;
begin
  Qrymain.parambyname('PurchaseOrderID').asInteger := PurchaseOrderID;
  Qrymain.parambyname('ProductID').asInteger := ProductID;
  inherited;

end;

procedure TProductSerialNumbersForHireGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMaindetails.fieldname);
  RemoveFieldfromGrid(qryMainPurchaseLineID.fieldname);
  RemoveFieldfromGrid(qryMainPQAID.fieldname);
  RemoveFieldfromGrid(qryMainPQADetailID.fieldname);
  RemoveFieldfromGrid(qryMainEquipmentID.fieldname);
  RemoveFieldfromGrid(qryMainProductID.fieldname);
  if ProductId <> 0 then begin
    RemoveFieldfromGrid(QrymainUnitofMeasureQtySold.fieldname) ;
    RemoveFieldfromGrid(QrymainUnitofMeasureShipped.fieldname) ;
    RemoveFieldfromGrid(QrymainUnitofMeasureBackorder .fieldname) ;
  end;
end;

procedure TProductSerialNumbersForHireGUI.setProductId(const Value: integer);
begin
  fiProductId := Value;
  lblSubtitle.Caption := 'Serial Number Allocated for Products in Product ' + Quotedstr(getproduct(Value));
end;

procedure TProductSerialNumbersForHireGUI.SetPurchaseOrderId(const Value: Integer);
begin
  fiPurchaseOrderId := Value;
  lblSubtitle.Caption := 'Serial Number Allocated for Products in Purchase Order # ' + inttostr(Value);
end;

Initialization
RegisterClassOnce(TProductSerialNumbersForHireGUI);

end.
