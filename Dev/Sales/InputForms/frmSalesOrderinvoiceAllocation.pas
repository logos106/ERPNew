unit frmSalesOrderinvoiceAllocation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Grids, Wwdbigrd, Wwdbgrid, Shader, ExtCtrls, DNMPanel, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, StdCtrls, DNMSpeedButton, busobjSalesorderInvoice;

type
  TfmSalesOrderinvoiceAllocation = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    grdallocation: TwwDBGrid;
    Qryallocation: TERPQuery;
    dsallocation: TDataSource;
    Qryallocationbatchno: TWideStringField;
    Qryallocationexpirydate: TDateTimeField;
    Qryallocationbatchqty: TFloatField;
    Qryallocationbinlocation: TWideStringField;
    Qryallocationbinnumber: TWideStringField;
    Qryallocationbinqty: TFloatField;
    Qryallocationserialnumber: TWideStringField;
    QryallocationCategory: TWideStringField;
    QryallocationDetailID: TIntegerField;
    QryallocationpqaSNID: TIntegerField;
    Qryallocationpqabinid: TIntegerField;
    QryallocationpqabatchID: TIntegerField;
    QryallocationAllocqty: TFloatField;
    btncancel: TDNMSpeedButton;
    btnclose: TDNMSpeedButton;
    Qryallocationbatchbin: TWideStringField;
    QryallocationKeydata: TWideStringField;
    Qryallocationbinid: TIntegerField;
    QryallocationGlobalref: TWideStringField;
    QryallocationParentRef: TWideStringField;
    QryallocationID: TIntegerField;
    QryallocationHidebatch: TWideStringField;
    QryallocationHideBin: TWideStringField;
    btnshipAll: TDNMSpeedButton;
    btnAutoAllocate: TDNMSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtShipment: TEdit;
    edttotalQty: TEdit;
    edtProductName: TEdit;
    edtDEsc: TEdit;
    lblMsg: TLabel;
    procedure FormShow(Sender: TObject);
    procedure QryallocationAfterOpen(DataSet: TDataSet);
    procedure grdallocationCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdallocationCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure grdallocationMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
    procedure grdallocationMultiSelectAllRecords(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
    procedure btncancelClick(Sender: TObject);
    procedure btncloseClick(Sender: TObject);
    procedure QryallocationAfterPost(DataSet: TDataSet);
    procedure btnshipAllClick(Sender: TObject);
    procedure btnAutoAllocateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Tablename :string;
    fSalesOrderInvoiceLines :TSalesOrderInvoiceLines;
    fbPosting:boolean;
    formShown :boolean;
    procedure MakeTable;
    procedure OnMultiSelectAllRecords(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
    function SaveAllocation:Boolean;
    procedure setSalesOrderInvoiceLines(const Value: TSalesOrderInvoiceLines);
    procedure updateAllocQtyofSelectedSerials;
    Procedure DoAutoAllocate;
  public
    Property SalesOrderInvoiceLines : TSalesOrderInvoiceLines read fSalesOrderInvoiceLines write setSalesOrderInvoiceLines;
    Class Procedure AutoAllocateAll(const fSalesOrderInvoiceLine :TSalesOrderInvoiceLines);
  end;


implementation

uses CommonLib, CommonDbLib,  busobjPQA, math, tcConst, types, AppEnvironment, systemlib, BusObjSales, SalesOrderInvoiceLib, frmAllocation,
  TempTableUtils;

{$R *.dfm}

class procedure TfmSalesOrderinvoiceAllocation.AutoAllocateAll(const fSalesOrderInvoiceLine :TSalesOrderInvoiceLines);
var
  FOrm :Tcomponent;
begin
  form := GetComponentByClassName('TfmSalesOrderinvoiceAllocation');
  if form =  nil then exit;
  try
    TfmSalesOrderinvoiceAllocation(Form).SalesOrderInvoiceLines := fSalesOrderInvoiceLine;
    TfmSalesOrderinvoiceAllocation(Form).formshow(TfmSalesOrderinvoiceAllocation(Form)); // this is to open the connection and the tables
    TfmSalesOrderinvoiceAllocation(Form).DoAutoAllocate;
    TfmSalesOrderinvoiceAllocation(Form).SaveAllocation;
  finally
    FreeandNil(form);
  end;

end;

procedure TfmSalesOrderinvoiceAllocation.DoAutoAllocate;
var
  fdQty :double;
  fd:double;
  flag:Boolean;
begin
  if Qryallocation.RecordCount =0 then exit;
    fdQty :=SalesOrderInvoiceLines.UOMQty;
    Qryallocation.First;
    While (Qryallocation.Eof = False) and (fdQty >0) do begin
      flag:=False;
      editDB(Qryallocation);
      if SalesOrderInvoiceLines.Product.SNTracking then begin
          grdallocation.SelectRecord;
          fdQty := fdQty - 1;
          flag:= true;
      end else begin
        if SalesOrderInvoiceLines.Product.MultipleBins then fd:= Qryallocationbinqty.AsFloat else fd:=Qryallocationbatchqty.AsFloat;
        if fd <> 0 then
          if fdQty > fd then begin
              QryallocationAllocqty.AsFloat := fd;
              fdQty := fdQty - fd;
              flag := True;
          end else begin
              QryallocationAllocqty.AsFloat := fdQty;
              fdQty :=0;
              flag:= true;
          end;
      end;
      if flag then PostDB(Qryallocation) else CancelDB(Qryallocation);
      Qryallocation.Next;
    end;
end;

procedure TfmSalesOrderinvoiceAllocation.btnAutoAllocateClick(Sender: TObject);
begin
  inherited;
  try
        if not SaveAllocation then exit;
        SalesOrderInvoiceLines.PQAllocation := '-';
        try
          SalesOrderInvoiceLines.PostDB;
          TfmAllocation.DoBinBatchform(SalesOrderInvoiceLines.PQA, self, AccessLevel>=5, true);
        finally
            SalesOrderInvoiceLines.PQAllocation := '+';
        End;
        btncancel.click;
Except
  on E:EXception do begin
    MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
  end;
end;

end;

procedure TfmSalesOrderinvoiceAllocation.btncancelClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmSalesOrderinvoiceAllocation.btncloseClick(Sender: TObject);
begin
  inherited;
  if SaveAllocation then self.Close;
end;

procedure TfmSalesOrderinvoiceAllocation.btnshipAllClick(Sender: TObject);
begin
  inherited;
  DoAutoAllocate;
end;

procedure TfmSalesOrderinvoiceAllocation.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := false;
  inherited;
end;

procedure TfmSalesOrderinvoiceAllocation.FormShow(Sender: TObject);
begin
  inherited;
  opendb(Qryallocation);
  fbPosting:= False;
  formShown:= True;
end;

procedure TfmSalesOrderinvoiceAllocation.grdallocationCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if SalesOrderInvoiceLines.Product.SNTracking = False then begin
    if sameText(Field.fieldname , QryallocationAllocqty.FieldName) then
         AFont.Style :=AFont.Style  +[fsbold]
    else begin
      ABrush.Color := clInactiveCaptionText;
      AFont.Color := $00737373;
    end;
    edtDEsc.Color := clInactiveCaptionText;
  end;

  if QryallocationHidebatch.asboolean then
    if sameText(Field.FieldName , Qryallocationbatchno.FieldName) or SameText(Field.FieldName , Qryallocationexpirydate.FieldName) then AFont.Color := ABrush.Color;
  if QryallocationHidebin.asboolean then
    if sameText(Field.FieldName , Qryallocationbinlocation.FieldName) or SameText(Field.FieldName , Qryallocationbinnumber.FieldName) then AFont.Color := ABrush.Color;
end;

procedure TfmSalesOrderinvoiceAllocation.grdallocationCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
begin
  inherited;
  if SalesOrderInvoiceLines.Product.SNTracking then exit;
  if sameText(AFieldName , QryallocationAllocqty.FieldName) then
       AFont.Style :=AFont.Style  +[fsbold]
  else begin
    ABrush.Color := clInactiveCaptionText;
    AFont.Color := $00737373;
  end;
end;
procedure TfmSalesOrderinvoiceAllocation.OnMultiSelectAllRecords(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  //if not(Selecting) then exit;
  if not(formshown) then exit;
  if not(SalesOrderInvoiceLines.Product.SNTracking)  and Selecting then begin
    Accept := False;
    Exit;
  end;
  if Selecting then
    if grdallocation.SelectedList.Count >= SalesOrderInvoiceLines.UOMQty then Accept := False;

  updateAllocQtyofSelectedSerials;

end;
procedure TfmSalesOrderinvoiceAllocation.grdallocationMultiSelectAllRecords(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  OnMultiSelectAllRecords(Grid,selecting,Accept);
end;

procedure TfmSalesOrderinvoiceAllocation.grdallocationMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  OnMultiSelectAllRecords(Grid,selecting,Accept);
end;

procedure TfmSalesOrderinvoiceAllocation.MakeTable;
var
  strSQL:String;
begin
  inherited;
  CloseDB(Qryallocation);
  Tablename := GetSalesOrderAllocationTobeInvoiced(SalesOrderInvoiceLines.SalesOrderLineID);
  With TempMyQuery(terpConnection(SalesOrderInvoiceLines.connection.connection)) do try
    SQL.Add('SELECT');
    SQL.Add('concat(ifnull(pqabatch.value,""),"-", ifnull(pqabatch.expirydate,0),"-",ifnull(pqabins.binID,""), "-", ifnull(PQASN.Value,"") ,');
    SQL.Add('if(not(isnull(PQASN.PQADetailID)) , ' + quotedstr(TPQASN.PQADetailtype) +' , if(not(isnull(pqabins.PQADetailID)) ,  ');
    SQL.Add( quotedstr(TPQABins.PQADetailtype) +' , ' + quotedstr(TPQABatch.PQADetailtype) +'))) as Keydata,');
    SQL.Add('pqabatch.value as batchno , pqabatch.expirydate,  pqabins.Value as binID,  pqasn.value serialnumber,  if(not(isnull(PQASN.PQADetailID)) , ');
    SQL.Add('' + quotedstr(TPQASN.PQADetailtype) +' , if(not(isnull(pqabins.PQADetailID)) ,  ' + quotedstr(TPQABins.PQADetailtype) +' , ' + quotedstr(TPQABatch.PQADetailtype) +')) as Category,  ');
    SQL.Add('sum(ifnull(Pqasn.qty ,  ifnull(PQABins.qty, PQABatch.qty))) as qty,sum(ifnull(Pqasn.uomqty ,  ifnull(PQABins.uomqty, PQABatch.uomqty))) as uomqty,  ');
    SQL.Add('PQASN.PQADetailID    pqaSNID,  pqabins.PQADetailID  pqabinid,  PQAbatch.PQADetailID pqabatchID  ');
    SQL.Add('from tblpqa PQA  ');
    SQL.Add('inner join tblparts P on P.partsId = PQa.productId  ');
    SQL.Add('inner join tblSalesOrderInvoiceLines SOIL on SOIL.SOInvoiceLineID = PQA.transLineID and SOIL.SOInvoiceID = PQa.transId and PQA.TransType = ' + Quotedstr(TSalesOrderInvoiceLines.classname)+'  ');
    SQL.Add('inner join tblSaleslines SOL on  SOL.SaleLineID = SOIL.SalesOrderLineID and SOL.SaleLineID= ' + inttostr(SalesOrderInvoiceLines.SalesOrderLineID) );
    SQL.Add('LEft  JOIN `tblPqaDetails` PQABatch  ON PQABatch.PQAId 	= PQA.PQAID AND PQABatch.PQAType = ' + quotedstr(TPQABatch.PQADetailtype) +'  AND PQABatch.Active= "T" and ifnull(PQABatch.qty,0)<>0  ');
    SQL.Add('LEFT JOIN `tblPqaDetails` PQABins  ON PQABins.PQAId 	= PQA.PQAID  AND PQABins.PQAType = ' + quotedstr(TPQABins.PQADetailtype) +' AND PQABins.Active = "T"  and ifnull(PQABins.qty,0)<>0');
    SQL.Add('AND   ( (PQABatch.globalref = IFNULL(PQABins.ParentRef,"") AND P.Batch="T"  AND P.multiplebins = "T") ');
    SQL.Add('or (ifnull(PQABins.Parentref ,"") = ""             AND P.Batch="F" AND P.multiplebins = "T"))  ');
    SQL.Add('LEFT JOIN `tblPqaDetails` PQASN    ON (PQASN.PQAId 	= PQA.PQAID AND PQASN.PQAType = ' + quotedstr(TPQASN.PQADetailtype) +'   ');
    SQL.Add('AND PQASN.Active = "T" and ifnull(PQASN.qty,0)<>0  AND ((PQABatch.globalref = IFNULL(PQASN.ParentRef,"") AND P.Batch="T" AND P.multiplebins = "F" AND P.SNTracking = "T")  ');
    SQL.Add('OR (PQAbins.Globalref = IFNULL(PQASn.ParentRef,"") AND P.Multiplebins = "T" AND P.SNTracking = "T") or  ifnull(PQASN.Parentref ,"") = "" AND P.Batch="F" ');
    SQL.Add('AND P.Multiplebins = "F" AND P.SNTracking = "T" ))  ');
    SQL.add(' where SOIL.SOInvoiceLineID =' + inttostr(SalesOrderInvoiceLines.ID));
    SQL.Add('group by concat(ifnull(pqabatch.value,""),"-", ifnull(pqabatch.expirydate,0),"-",ifnull(pqabins.Value,""), "-", ifnull(PQASN.Value,"") ,  ');
    SQL.Add('if(not(isnull(PQASN.PQADetailID)) , ' + quotedstr(TPQASN.PQADetailtype) +' , if(not(isnull(pqabins.PQADetailID)) ,  ' + quotedstr(TPQABins.PQADetailtype) +' , ' + quotedstr(TPQABatch.PQADetailtype) +'))) ');
    open;
    if recordcount =0 then exit;
    strSQL:= '';
    First;
    While Eof = False do begin
      strSQL := strSQL+'update ' + tablename +' Set Allocqty = ' +floatTostr(FieldByname('uomQty').asfloat) +' where  KeyData = ' + quotedstr(FieldByname('KeyData').asString)+';';
      Next;
    end;
    if strSQL <> '' then ExecuteSQL(strSQL);
  finally
    if active then close;
    Free;
  end;
  Qryallocation.SQL.Text := 'Select * from ' + tablename(* +
      ' where (Category = ' + quotedstr(TPQABatch.PQADetailtype) +' and ifnull(BatchQty,0) >0 )  OR ' +
            ' (Category = ' + quotedstr(TPQAbins.PQADetailtype) +' and ifnull(BinQty,0) >0 )  OR ' +
            ' (Category = ' + quotedstr(TPQASN.PQADetailtype) +' )'*);
end;

procedure TfmSalesOrderinvoiceAllocation.QryallocationAfterOpen(DataSet: TDataSet);
var
    batchbin :String;
    binID:Integer;
begin
  inherited;
  if SalesOrderInvoiceLines.Product.SNTracking then begin
    edtDEsc.align := altop;
    lblMsg.caption :='List of serial numbers already allcoated in the Sale Sales Order for ' + quotedstr(SalesOrderInvoiceLines.Product.ProductName) +
                      ' is provided.' + NL +'Please Select the Serial numbers of this shipment out of it.' +NL+
                      'OR Select ''Allocation Form'' to allocate different Serial Number(s)';
  end else begin
    lblMsg.caption :='List of allocation done for the Sale Sales Order for  ' + quotedstr(SalesOrderInvoiceLines.Product.ProductName) +
                      ' is provided.' + NL +'Please Select the quantity of this shipment out of it.' + NL+
                      'OR Select ''Allocation Form'' to allocate different Bin / Batch';
  end;
    (*Qryallocationbatchno.Visible := SalesOrderInvoiceLines.Product.batch;
    Qryallocationexpirydate.Visible := SalesOrderInvoiceLines.Product.batch;
    Qryallocationbatchqty.Visible := SalesOrderInvoiceLines.Product.batch;
    Qryallocationbinlocation.Visible := SalesOrderInvoiceLines.Product.MultipleBins;
    Qryallocationbinnumber.Visible := SalesOrderInvoiceLines.Product.MultipleBins;
    Qryallocationbinqty.Visible := SalesOrderInvoiceLines.Product.MultipleBins;
    Qryallocationserialnumber.Visible := SalesOrderInvoiceLines.Product.SNTracking;*)
    //QryallocationAllocqty.Visible := not(SalesOrderInvoiceLines.Product.SNTracking)(* or devmode*);

    if SalesOrderInvoiceLines.Product.SNTracking(* or not(devmode)*) then begin
      grdallocation.RemoveField(QryallocationAllocqty.FieldName, true);
      grdallocation.Selected.Delete(0);
    end else begin
      grdallocation.RemoveField(QryallocationSerialnumber.FieldName, true);
      grdallocation.Selected.Delete(grdallocation.Selected.count-1);
    end;
    grdallocation.applySelected;

    if SalesOrderInvoiceLines.Product.SNTracking then begin
      grdallocation.options := grdallocation.options  +[dgMultiSelect];
      grdallocation.options := grdallocation.options  +[dgrowSelect];
    end else begin
      grdallocation.options := grdallocation.options  -[dgMultiSelect];
      grdallocation.options := grdallocation.options  -[dgrowSelect];
    end;
    if Qryallocation.RecordCount >1 then begin
      Qryallocation.First;
      batchbin :='';
      binID:=0;
      while Qryallocation.Eof = False do begin
        if  (batchbin <> Qryallocationbatchbin.AsString)  then
          batchbin := Qryallocationbatchbin.AsString
        else begin
          editDB(Qryallocation);
          QryallocationHideBatch.asBoolean := True;
          POSTDB(Qryallocation);
        end;
        if (Qryallocationbinid.AsInteger <> binId) or (batchbin <> Qryallocationbatchbin.AsString) then begin
            binId    := Qryallocationbinid.AsInteger;
            batchbin := Qryallocationbatchbin.AsString;
        end else begin
          editDB(Qryallocation);
          QryallocationhideBin.AsBoolean := True;
          POSTDB(Qryallocation);
        end;
        if QryallocationSerialnumber.visible and (QryallocationSerialnumber.asString <> '') and (QryallocationallocQty.asfloat <> 0) then
          grdallocation.SelectRecord;

        Qryallocation.Next;
      end;
    end;
    Qryallocation.first;
    grdallocation.RedrawGrid;
end;
procedure TfmSalesOrderinvoiceAllocation.QryallocationAfterPost(DataSet: TDataSet);
var
  fdQty:Double;
begin
  inherited;
  if fbPosting then exit;
  if not formShown then exit;
  fdQty := QryallocationAllocqty.Value - QryallocationAllocqty.OldValue;
  if fdQty=0 then exit;
  while True do begin
    if  QryallocationParentRef.AsString = '' then break;
    if sametext(QryallocationGlobalref.FieldName , QryallocationParentRef.AsString ) then break;
    if not Qryallocation.Locate(QryallocationGlobalref.FieldName , QryallocationParentRef.AsString  , []) then break;
    editdb(Qryallocation);
    QryallocationAllocQty.AsFloat  := QryallocationAllocQty.AsFloat   + fdQty;
    postdb(Qryallocation);
  end;
end;


Procedure TfmSalesOrderinvoiceAllocation.updateAllocQtyofSelectedSerials;
var
  bm:Tbookmark;
  ctr:Integer;
begin
  if Qryallocation.RecordCount =0 then exit;
  Qryallocation.DisableControls;
  try
    bm := Qryallocation.GetBookmark;
    try
      Qryallocation.First;
      while Qryallocation.Eof = False do begin
        if trim(Qryallocationserialnumber.AsString) <> '' then begin
          if QryallocationAllocqty.asfloat <> 0 then begin
            EditDB(Qryallocation);
            QryallocationAllocqty.asfloat := 0;
            POSTDB(Qryallocation);
          end;
        end;
        Qryallocation.Next;
      end;
      for ctr:= 0 to grdallocation.SelectedList.Count -1 do begin
        Qryallocation.GotoBookmark(grdallocation.SelectedList.Items[ctr]);
        if trim(Qryallocationserialnumber.AsString) <> '' then begin
          if QryallocationAllocqty.asfloat <> 1 then begin
            EditDB(Qryallocation);
            QryallocationAllocqty.asfloat := 1;
            POSTDB(Qryallocation);
          end;
        end;
      end;
    finally
      Qryallocation.GotoBookmark(bm);
      Qryallocation.FreeBookmark(bm);
    end;
  finally
    Qryallocation.EnableControls;
  end;

end;
function TfmSalesOrderinvoiceAllocation.SaveAllocation: Boolean;
var
  strSQL: string;
  TablenamePQAdetails: string;
  clonePQADetails: TPQADetails;
  qryPQADetails: TERPQuery;
  IDs: string;
  SQLs: TStringList;
begin
  REsult := True;
  try
    PostDB(qryallocation);
    With TempMyquery do try
      if SalesOrderInvoiceLines.Product.SnTracking then  begin
        updateAllocQtyofSelectedSerials;
        SQL.Add('Select sum(Allocqty) as Allocqty from ' +tablename +' where Category = ' +quotedstr(TPQASN.PQADetailtype));
        open;
        if (CompareValue(SalesOrderInvoiceLines.UOMQty,fieldByname('Allocqty').asFloat,0.000001) = LessThanValue) or
          ((not Samevalue(SalesOrderInvoiceLines.UOMQty,fieldByname('Allocqty').asFloat,0.000001) ) and AppEnv.CompanyPrefs.EnforceAllocationValidationinPI) then begin
          Result:= False;
          if visible then MessageDlgXP_Vista(SalesOrderInvoiceLines.ProductName + ': The Quantity of Serialnumber Allocated [' + FloattoStr(fieldbyname('Allocqty').AsFloat) + '] does not match the Quantity to be Allocated[' +
            FloattoStr(SalesOrderInvoiceLines.UOMQty) + ']', mtWarning, [mbOK], 0);
          Exit;
        end else if not Samevalue(SalesOrderInvoiceLines.UOMQty,fieldByname('Allocqty').asFloat,0.000001) then begin
          {only warning when the allocation is < trans Qty and }
          if visible then if MessageDlgXP_Vista(SalesOrderInvoiceLines.ProductName + ': The Quantity of Serialnumber Allocated [' + FloattoStr(fieldbyname('Allocqty').AsFloat) + '] does not match the Quantity to be Allocated[' +
            FloattoStr(SalesOrderInvoiceLines.UOMQty) + '].' +Nl+'Do you wish to apply this allocation to the Invoice?', mtConfirmation, [mbyes, mbno], 0) = mrno then begin
              Result := false;
              Exit;
            end;
        end;
      end else if SalesOrderInvoiceLines.Product.MultipleBins then  begin
        close;
        SQL.Clear;
        SQL.Add('Select sum(Allocqty) as Allocqty from ' +tablename +' where Category = ' +quotedstr(TPQAbins.PQADetailtype));
        open;
        if (CompareValue(SalesOrderInvoiceLines.UOMQty,fieldByname('Allocqty').asFloat,0.000001) = LessThanValue) or
          ((not Samevalue(SalesOrderInvoiceLines.UOMQty,fieldByname('Allocqty').asFloat,0.000001) ) and AppEnv.CompanyPrefs.EnforceAllocationValidationinPI) then begin
          Result:= False;
          if visible then MessageDlgXP_Vista(SalesOrderInvoiceLines.ProductName + ': The Bin Quantity Allocated [' + FloattoStr(fieldbyname('Allocqty').AsFloat) + '] does not match the Quantity to be Allocated[' +
            FloattoStr(SalesOrderInvoiceLines.UOMQty) + ']', mtWarning, [mbOK], 0);
          Exit;
        end else if not Samevalue(SalesOrderInvoiceLines.UOMQty,fieldByname('Allocqty').asFloat,0.000001) then begin
          {only warning when the allocation is < trans Qty and }
          if visible then if MessageDlgXP_Vista(SalesOrderInvoiceLines.ProductName + ': The Bin Quantity Allocated [' + FloattoStr(fieldbyname('Allocqty').AsFloat) + '] does not match the Quantity to be Allocated[' +
            FloattoStr(SalesOrderInvoiceLines.UOMQty) + '].' +Nl+'Do you wish to apply this allocation to the Invoice?', mtConfirmation, [mbyes, mbno], 0) = mrno then begin
              Result := false;
              Exit;
            end;
        end;
      end else if SalesOrderInvoiceLines.Product.Batch then  begin
        close;
        SQL.Clear;
        SQL.Add('Select sum(Allocqty) as Allocqty from ' +tablename +' where Category = ' +quotedstr(TPQAbatch.PQADetailtype));
        open;
        if (CompareValue(SalesOrderInvoiceLines.UOMQty,fieldByname('Allocqty').asFloat,0.000001) = LessThanValue) or
          ((not Samevalue(SalesOrderInvoiceLines.UOMQty,fieldByname('Allocqty').asFloat,0.000001) ) and AppEnv.CompanyPrefs.EnforceAllocationValidationinPI) then begin
          Result:= False;
          if visible then MessageDlgXP_Vista(SalesOrderInvoiceLines.ProductName + ': The Batch Quantity Allocated [' + FloattoStr(fieldbyname('Allocqty').AsFloat) + '] does not match the Quantity to be Allocated[' +
            FloattoStr(SalesOrderInvoiceLines.UOMQty) + ']', mtWarning, [mbOK], 0);
          Exit;
        end else if not Samevalue(SalesOrderInvoiceLines.UOMQty,fieldByname('Allocqty').asFloat,0.000001) then begin
          {only warning when the allocation is < trans Qty and }            if visible then if MessageDlgXP_Vista(SalesOrderInvoiceLines.ProductName + ': The Batch Quantity Allocated [' + FloattoStr(fieldbyname('Allocqty').AsFloat) + '] does not match the Quantity to be Allocated[' +
            FloattoStr(SalesOrderInvoiceLines.UOMQty) + '].' +Nl+'Do you wish to apply this allocation to the Invoice?', mtConfirmation, [mbyes, mbno], 0) = mrno then begin
              Result := false;
              Exit;
            end;
        end;
      end;

    finally
      closenFree;
    end;


    TablenamePQAdetails := CreateUserTemporaryTable('tmp_allocation','SOIA');
    try

      strSQL := ' select * from ' + TablenamePQAdetails + ' order by Globalref';
      qryPQADetails := TERPQuery(SalesOrderInvoiceLines.getnewDataset(strSQL, True));
      try
        Qryallocation.First;
        While Qryallocation.Eof = False do begin
          if QryallocationAllocqty.AsFloat <> 0 then begin
            if (QryallocationPQASNID.AsInteger<> 0) then
              if qryPQADetails.Locate('PQAdetailID' , QryallocationPQASNID.AsInteger, []) = False then begin
                qryPQADetails.Append;
                qryPQADetails.fieldbyname('PQAdetailID').AsInteger  := QryallocationPQASNID.AsInteger;
                qryPQADetails.fieldbyname('UOMQty').AsFloat         := QryallocationAllocqty.AsFloat;
                qryPQADetails.fieldbyname('Qty').AsFloat            := QryallocationAllocqty.AsFloat *SalesOrderInvoiceLines.UOMMultiplier;
                qryPQADetails.fieldbyname('PQAType').AsString       := TPQASN.PQADetailtype;
                qryPQADetails.fieldbyname('Value').AsString         := Qryallocationserialnumber.AsString;
                qryPQADetails.Post;
              end else begin
                EditDB(qryPQADetails);
                qryPQADetails.fieldbyname('UOMQty').AsFloat := qryPQADetails.fieldbyname('UOMQty').AsFloat + QryallocationAllocqty.AsFloat;
                qryPQADetails.fieldbyname('Qty').AsFloat    := qryPQADetails.fieldbyname('Qty').AsFloat    + QryallocationAllocqty.AsFloat *SalesOrderInvoiceLines.UOMMultiplier;
                PostDB(qryPQADetails);
              end;


            if (QryallocationPQAbinID.AsInteger<> 0) then
              if qryPQADetails.Locate('PQAdetailID' , QryallocationPQAbinID.AsInteger, []) = False then begin
                qryPQADetails.Append;
                qryPQADetails.fieldbyname('PQAdetailID').AsInteger  := QryallocationPQAbinID.AsInteger;
                qryPQADetails.fieldbyname('UOMQty').AsFloat         := QryallocationAllocqty.AsFloat;
                qryPQADetails.fieldbyname('Qty').AsFloat            := QryallocationAllocqty.AsFloat *SalesOrderInvoiceLines.UOMMultiplier;
                qryPQADetails.fieldbyname('PQAType').AsString       := TPQABins.PQADetailtype;
                qryPQADetails.fieldbyname('Value').AsString         := Qryallocationbinid.AsString;
                qryPQADetails.fieldbyname('binId').AsInteger        := Qryallocationbinid.AsInteger;
                qryPQADetails.Post;
              end else begin
                EditDB(qryPQADetails);
                qryPQADetails.fieldbyname('UOMQty').AsFloat := qryPQADetails.fieldbyname('UOMQty').AsFloat + QryallocationAllocqty.AsFloat;
                qryPQADetails.fieldbyname('Qty').AsFloat    := qryPQADetails.fieldbyname('Qty').AsFloat    + QryallocationAllocqty.AsFloat *SalesOrderInvoiceLines.UOMMultiplier;
                PostDB(qryPQADetails);
              end;


            if (QryallocationPQABatchID.AsInteger<> 0) then
              if qryPQADetails.Locate('PQAdetailID' , QryallocationPQABatchID.AsInteger, []) = False then begin
                qryPQADetails.Append;
                qryPQADetails.fieldbyname('PQAdetailID').AsInteger  := QryallocationPQABatchID.AsInteger;
                qryPQADetails.fieldbyname('UOMQty').AsFloat         := QryallocationAllocqty.AsFloat;
                qryPQADetails.fieldbyname('Qty').AsFloat            := QryallocationAllocqty.AsFloat *SalesOrderInvoiceLines.UOMMultiplier;
                qryPQADetails.fieldbyname('PQAType').AsString       := TPQABatch.PQADetailtype;
                qryPQADetails.fieldbyname('Value').AsString         := QryallocationBatchNo.AsString;
                qryPQADetails.fieldbyname('ExpiryDate').AsDateTime  := Qryallocationexpirydate.AsDateTime;
                qryPQADetails.Post;
              end else begin
                EditDB(qryPQADetails);
                qryPQADetails.fieldbyname('UOMQty').AsFloat := qryPQADetails.fieldbyname('UOMQty').AsFloat + QryallocationAllocqty.AsFloat;
                qryPQADetails.fieldbyname('Qty').AsFloat    := qryPQADetails.fieldbyname('Qty').AsFloat    + QryallocationAllocqty.AsFloat *SalesOrderInvoiceLines.UOMMultiplier;
                PostDB(qryPQADetails);
              end;
          end;
          Qryallocation.Next;
        end;

        SalesOrderInvoiceLines.ExecuteSQL( 'update ' + TablenamePQAdetails +' t inner join tblPQADetails  PQAD on T.PQAdetailID = PQAD.PQAdetailID Set T.globalref = PQAD.globalref, T.ParentREf = PQAD.ParentREf' , true);
        closeDB(qryPQADetails);
        openDB(qryPQADetails);
        clonePQADetails := TPQADetails.Create(SalesOrderInvoiceLines);
        clonePQADetails.Connection := SalesOrderInvoiceLines.Connection;
        clonePQADetails.LoadSelect(' PQAID = ' + inttostr(SalesOrderInvoiceLines.PQA.ID));
        clonePQADetails.DEleteall;
        IDs := '';
        if qryPQADetails.recordcount = 0 then Exit;
        qryPQADetails.first;
        while qryPQADetails.Eof = False do begin
          clonePQADetails.New;
          clonePQADetails.PQAID     := SalesOrderInvoiceLines.PQA.ID;
          clonePQADetails.Qty       := qryPQADetails.fieldByname('Qty').asFloat;
          clonePQADetails.UOMQty    := qryPQADetails.fieldByname('UOMQty').asFloat;
          clonePQADetails.PQAType   := qryPQADetails.fieldByname('PQAType').asString;
          clonePQADetails.ParentRef := qryPQADetails.fieldByname('ParentRef').asString;
          clonePQADetails.PQAValue  := qryPQADetails.fieldByname('Value').asString;
          clonePQADetails.BinID     := qryPQADetails.fieldByname('BinID').AsInteger;
          if qryPQADetails.fieldByname('ExpiryDate').asDatetime <> 0 then clonePQADetails.ExpiryDate := qryPQADetails.fieldByname('ExpiryDate').asDatetime;
          clonePQADetails.PostDb;
          if IDs <> '' then IDs := IDs + ',';
          IDs := IDs + inttostr(clonePQADetails.ID);
          qryPQADetails.edit;
          qryPQADetails.fieldByname('Newglobalref').asString := clonePQADetails.Globalref;
          qryPQADetails.Post;
          qryPQADetails.next;
        end;
        if qryPQADetails.recordcount = 0 then Exit;
        qryPQADetails.first;
        SQLs := TStringList.Create;
        try
          while qryPQADetails.Eof = False do begin
            SQLs.Add('update tblPQADetails set ParentREf = ' + Quotedstr(qryPQADetails.fieldByname('Newglobalref').asString) + ' where ParentRef = ' +
              Quotedstr(qryPQADetails.fieldByname('Globalref').asString) + ' and PQADetailID in (' + IDs + ');');
            qryPQADetails.next;
          end;
          SalesOrderInvoiceLines.ExecuteSQL(SQLs, True);
          SalesOrderInvoiceLines.Closedb;
          SalesOrderInvoiceLines.OpenDB;
        finally
          FreeandNil(SQLs);
        end;
      finally
        if qryPQADetails.Active then qryPQADetails.close;
        FreeandNil(qryPQADetails);
      end;
    finally
      //strSQL := ' drop table if exists ' + TablenamePQAdetails;
      //SalesOrderInvoiceLines.ExecuteSQL(strSQL, False);
      TAfterTransList.Inst.AddAfterTransSQL(TERPConnection (MyConnection), 'drop table if exists ' + TablenamePQAdetails + ';');
    end;
    Result:= True;
  except
    on E:Exception do begin
      MessageDlgXP_vista(E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TfmSalesOrderinvoiceAllocation.setSalesOrderInvoiceLines(const Value: TSalesOrderInvoiceLines);
begin
  fSalesOrderInvoiceLines := Value;
  MakeTable;
  edtDEsc.Text:= 'Allocations Already Made in Sales Order for ' + quotedStr(fSalesOrderInvoiceLines.SalesOrderLine.ProductName);
  edttotalQty.Text    := FloatTostrF(fSalesOrderInvoiceLines.SalesOrderLine.UOMQtyShipped, ffGeneral, 15,0);
  edtShipment.Text    := FloatTostrF(fSalesOrderInvoiceLines.uomQty, ffGeneral, 15,0);
  edtProductName.Text := fSalesOrderInvoiceLines.SalesOrderLine.ProductName;
end;

initialization
  RegisterClassOnce(TfmSalesOrderinvoiceAllocation);

end.




