unit SalesListOutstanding;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesListReportForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, busobjsales, UserLockObj,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TSalesListOutstandingGUI = class(TSalesListReportGUI)
    DNMSpeedButton1: TDNMSpeedButton;
    btnInvoice: TDNMSpeedButton;
    qryMainClassId: TIntegerField;
    qryMainIsSalesOrder: TWideStringField;
    qryMainIsInvoice: TWideStringField;
    qryMainSaleLineId: TIntegerField;
    lblSelectedRecords: TLabel;
    lblSelectedRecordscount: TLabel;
    qryMainInvoiceTo: TWideStringField;
    qryMainShipTo: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnInvoiceClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    clientID:Integer;
    ClassId:Integer;
    SelectingAll:Boolean;
    InvoiceObj:TInvoice;
    UserLock: TUserLock;
    LockMsg:String;
    procedure CreateInvoiceLine;
    Function LockSelectedsales(const SaleID:Integer):Boolean;
  Protected
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex:Integer);Override;
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, tcDataUtils, AppEnvironment, CommonDbLib,
  busobjMergedSalesLines, CommonFormLib,ProductQtyLib;

{$R *.dfm}
Function TSalesListOutstandingGUI.LockSelectedsales(const SaleID:Integer):Boolean;
var
  s:String;
  xsaleId:Integer;
begin
  REsult := True;
  s := 'Select 1 as ctr , '+inttostr(saleID) + ' as SaleId '+
          ' union all Select distinct ' +
            ' 2 as ctr , S.SaleId    '  +
            ' from tblSales S  ' +
            ' inner join tblsales Original on s.Originalno = Original.originalno  ' +
            ' where  S.SaleID <> ' +inttostr(SaleID) +' and Original.saleId =' +inttostr(saleID)+' order by ctr';
  With TempMyQuery do try
    SQL.add(s);
    Open;
    if recordcount > 0 then begin
      first;
      while Eof = False do begin
        if not(UserLock.Lock('tblsales', Fieldbyname('SAleID').asInteger, TitleLabel.Caption))  then begin
          result := False;
          s:= UserLock.Username + '" is accessing ' + qryMainTransactionType.asString+' # ' +inttostr(fieldbyname('SaleId').asInteger);
          if pos(s , lockMsg) = 0 then begin
            xSaleID:=fieldbyname('SaleId').asInteger;
            if SaleID<> xSaleID then s:= s + '(in the group of ' + qryMainTransactionType.asString+' # ' +inttostr(SaleID)+')';
            s:= s+        ' with: ' + UserLock.LockInfo.LockingForm + ' since: ' + FormatDateTime('dd/mm hh:nn:ss', UserLock.LockInfo.TimeLocked);
            if LockMsg <> '' then LockMsg := LockMsg + chr(13);
            LockMsg := LockMsg + s;
          end;
          Exit;
        end;
        Next;
      end;
    end;
  finally
    closenFree;
  end;
end;
procedure TSalesListOutstandingGUI.RefreshQuery;
begin
  inherited;
end;

procedure TSalesListOutstandingGUI.btnInvoiceClick(Sender: TObject);
var
  s:String;
  invID:Integer;
begin
  invID:=0;
  try
    inherited;
    if grdmain.Selectedlist.count =0 then exit;

    UserLock := TUserLock.Create(Self);
    try
      IterateProcNo:= 2;
      LockMsg := '';
      IterateselectedRecordsReverse(true);

      if grdmain.Selectedlist.count =0 then begin
        MessageDlgXP_Vista('Sales Records Selected are all locked by other users.' +chr(13)+chr(13) +LockMsg, mtWarning, [mbOK], 0 , nil, '' , '' , False, nil, '' , '' , 500);
        exit;
      end;
      if LockMsg <> '' then s := 'The following Sales Records Selected are locked by other utsers and are removed from the selection.' +chr(13) +LockMsg+chr(13)+chr(13);
      if MessageDlgXP_Vista(s+ 'This will Create a new Invoice for '+ getclientName(clientID) +
                          ' with all the selected products and will delete it from the Original Sales record.'+chr(13)+chr(13)+
                          'Do you wish to continue?', mtConfirmation, [mbYes, mbNo], 0 , nil, '' , '' , False, nil, '' , '' , 500) = mrno then exit;

      InvoiceObj:=TInvoice.CreateWithNewConn(self);
      try
        InvoiceObj.Load(0);
        InvoiceObj.SilentMode := true;
        InvoiceObj.Connection.beginTransaction;
        Try
          InvoiceObj.New;
          InvoiceObj.CustomerName := getClientName(clientID);
          InvoiceObj.SaleClassName    := getClassname(classID);
          InvoiceObj.Comments := 'Merging Outstanding Products';
          InvoiceObj.PostDB;
          IterateProcNo:= 3;
          IterateSelectedRecords(true);
          if InvoiceObj.Save then begin
            InvoiceObj.Connection.CommitTransaction;
            invID:=InvoiceObj.Id;
            Grdmain.UnselectAll;
          end else begin
            InvoiceObj.Connection.RollbackTransaction;
          end;
        Except
          on E:Exception do begin
            MessageDlgXP_Vista('Invoice Creation Failed.'+ chr(13)+ chr(13)+E.Message, mtWarning, [mbOK], 0);
          end;
        End;
      finally
        Freeandnil(InvoiceObj);
      end;
    finally
      Userlock.Unlock(TitleLabel.Caption);
      FreeandNil(UserLock);
    end;
  finally
    if invID<>0 then begin
      OpenErpform('TInvoiceGUI' ,invID);
      Self.Close;
    end;
  end;

end;
procedure TSalesListOutstandingGUI.CreateInvoiceLine;
var
  SalesObj:TSales;
  Seqno :Integer;
  Qty:Double;
  MergedSalesLines :TMergedSalesLines ;
  s:String;
begin
  if QrymainIsSalesOrder.asBoolean then SalesObj := TSalesorder.create(Self)
  else SalesObj:= TInvoice.Create(self);
  try
    SalesObj.DeletingTomergeOutstandingsale :=  True;
    SalesObj.connection := InvoiceObj.connection;
    SalesObj.Load(QrymainSaleID.asInteger);
    if SalesObj is TSales then TSales(SalesObj).InstantiateAllTrees; // load the trees to copy
    SalesObj.silentMode:= True;

      SalesObj.connection.BeginNestedTransaction;
      try
        if SalesObj.Lines.Locate('SaleLineId' , QrymainSalelineId.asInteger , []) then begin
          if SalesObj.Lines.UOMQtyShipped <> 0 then Qty := SalesObj.Lines.UOMQtyShipped  else Qty := SalesObj.Lines.UOMQtyBackOrder;

          InvoiceObj.Lines.New;
          Seqno :=InvoiceObj.Lines.Seqno;
          InvoiceObj.Lines.XML :=replacestr(SalesObj.Lines.XML , SalesObj.Lines.XMLNodename , InvoiceObj.Lines.XMLNodename);
          InvoiceObj.Lines.UOMQtySold    := Qty;
          InvoiceObj.Lines.UOMQtyShipped := Qty;
          InvoiceObj.Lines.Seqno := Seqno;
          InvoiceObj.Lines.PostDB;
          InvoiceObj.Comments := InvoiceObj.Comments  + chr(13) + InvoiceObj.Lines.Productname +'  from ' +SalesObj.XMLNodename+'#'+  SalesObj.globalref;

            {this is a temporary table keeping the original of the salesline being merged for history - as the record is being deleted just in case}
            MergedSalesLines := TMergedSalesLines.Create(nil);
            try
              MergedSalesLines.connection :=SalesObj.Connection;
              MergedSalesLines.Load(0);
              MergedSalesLines.New;
              MergedSalesLines.XML                    := Replacestr(SalesObj.Lines.XML , SalesObj.Lines.XMLNodename , MergedSalesLines.XMLNodename);
              MergedSalesLines.SalelineRef            := SalesObj.Lines.globalref;
              MergedSalesLines.SaleRef                := SalesObj.globalref;
              MergedSalesLines.InvoiceRef             := InvoiceObj.globalref;
              MergedSalesLines.InvoiceLineRef         := InvoiceObj.Lines.globalref;
              MergedSalesLines.BOID                   := salesObj.Backorderglobalref;
              MergedSalesLines.baseno                 := SalesObj.baseno;
              MergedSalesLines.baselineno             := 0;
              MergedSalesLines.RelatedParentLineREf   := '';
              MergedSalesLines.RelatedProductQty      := 0;
              MergedSalesLines.ParentProductID := 0;
              MergedSalesLines.isRelatedProduct       := False;
              MergedSalesLines.PostDB;
            finally
              Freeandnil(MergedSalesLines);
            end;

            s:='Deleted and Merged Lines :';
            if pos(s , SalesObj.Comments) = 0 then SalesObj.Comments := s + chr(13) +SalesObj.Lines.ProductName +' into invoice #' + InvoiceObj.globalref + chr(13)
            else SalesObj.Comments := replacestr(SalesObj.Comments , s ,s + chr(13) +SalesObj.Lines.ProductName +' into invoice #' + InvoiceObj.globalref );

            SalesObj.Lines.deleted:= True;
            SalesObj.Lines.PostDb;
            SalesObj.Lines.Next;

            {this is for audit trail of the original Sales}

            if (SalesObj.Lines.count =0) or ((SalesObj.Lines.count =1) and (SalesObj.Lines.deleted = True)) then begin
              if (SalesObj.BaseNo <> '') or (SalesObj.BackOrderGlobalRef <> '') then
                SalesObj.ExecuteSQL('update tblsales set BOID = ' +quotedstr(SalesObj.BackOrderGlobalRef) +' where globalref = ' + Quotedstr(SalesObj.BaseNo)+';'+
                    'update tblsales Set Baseno = ' +quotedstr(SalesObj.baseno) +' where globalref = ' +quotedstr(SalesObj.BackOrderGlobalRef)  +';' , true);
              SalesObj.Deleted :=  True;
              SalesObj.postDB;
            end;

          if SalesObj.Save then begin
            SalesObj.connection.CommitNestedTransaction;
          end else begin
            SalesObj.connection.RollbackNestedTransaction;
          end;
        end;
      Except
        on E:Exception do begin
          SalesObj.connection.RollbackNestedTransaction;
        end;
      end;
  finally
    FreeandNil(salesObj);
  end;
end;
procedure TSalesListOutstandingGUI.IterateselectedRecordsCallback(var Abort: boolean;SelIndex:Integer);
begin
  if IterateProcNo = 1 then begin
    Grdmain.SelectRecord;
  end else if IterateProcno = 2 then begin
    if not LockSelectedsales(QrymainSaleid.asInteger) then
      Grdmain.unSelectRecord;
  end else if IterateProcNo = 3 then begin
    CreateInvoiceLine;
  end;
end;
procedure TSalesListOutstandingGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  IterateProcNo:= 1;
  SelectingAll:= True;
  Try
    IterateRecords;
    SetControlFocus(grdmain);
  Finally
    SelectingAll:= False;
  End;
end;

procedure TSalesListOutstandingGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ClientId := 0;
  ClassId:= 0;
  SelectingAll:= False;
end;

procedure TSalesListOutstandingGUI.FormShow(Sender: TObject);
begin
  inherited;
  lblSelectedRecordscount.caption := '0';
  ShowControlhint(grdmain, 'This is the list of  Invoice Backorders and Unconverted Sales Orders and Sales Order Bakorders');
end;

procedure TSalesListOutstandingGUI.grdMainMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if GrdMain.Selectedlist.count =0 then begin
    lblSelectedRecordscount.caption := '0';
  end else begin
    lblSelectedRecordscount.Caption :=inttostr(GrdMain.Selectedlist.count);
  end;
end;

procedure TSalesListOutstandingGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid;Selecting: Boolean; var Accept: Boolean);
var
  s:String;
begin
  inherited;
    if GrdMain.Selectedlist.count =0 then begin
      clientId :=0;
      classId := 0;
    end;
  if Selecting then begin
    if clientID = 0 then clientId := QrymainClientID.asInteger;
    if ClassId =0 then ClassId := QrymainClassId.asInteger;
    if  (QrymainClientID.asInteger <> ClientID) OR (QrymainclassId.asInteger <> classId)  then begin
      s:= '';
      if SelectingAll then
      else begin
        s:='Sale(s) of ' +Quotedstr(getClientName(ClientID)) +' in ' + Quotedstr(GetClassName(ClassId)) +'  is already selected.'+ chr(13)+
                          '  It is not possible to  merge ' +QrymainTransactiontype.asString +'#' +inttostr(QrymainSaleId.asInteger) +
                          ' of ' +quotedstr(qrymainCustomerName.asString) + ' in ' + quotedstr(Qrymainclassname.asString)+'.' +chr(13) +chr(13)+
                          'Only Sales of the Same Customer and ' + Appenv.DefaultClass.Classheading+' Can be Merged. ';
        MessageDlgXP_Vista(s,mtInformation, [mbOK], 0);
      end ;
      Accept := False;
    end;
  end;
  if GrdMain.Selectedlist.count =0 then begin
    lblSelectedRecordscount.caption := '0';
  end else begin
    lblSelectedRecordscount.Caption :=inttostr(GrdMain.Selectedlist.count);
  end;
end;

procedure TSalesListOutstandingGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainShipped.fieldname);
  RemoveFieldfromGrid(QrymainBackorder.fieldname);
  RemoveFieldfromGrid(QrymainQtySold.fieldname);
  RemoveFieldfromGrid(QrymainClientID.fieldname);
  RemoveFieldfromGrid(QrymainIsSalesOrder.fieldname);
  RemoveFieldfromGrid(QrymainIsInvoice.fieldname);
  RemoveFieldfromGrid(QrymainsaleLineId.fieldname);
  RemoveFieldfromGrid(QrymainBinlocation.fieldname);
  RemoveFieldfromGrid(QrymainBinnumber.fieldname);
end;

initialization
  RegisterClassOnce(TSalesListOutstandingGUI);
end.



