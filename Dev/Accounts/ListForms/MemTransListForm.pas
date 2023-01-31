{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 14/02/06  1.00.01 BJ   Creating the transaction record uses FastFuncs,the business
                        object in the background for PO, SO, Invice and quote.
 20/04/07  1.00.02 IJB  Added pop-up message after creation of new Invoice etc
}
unit MemTransListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  ProgressDialog, wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS,
  DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, BusObjTrans,busobjPQA,
   wwdblook, Shader, dmGUIStylers, kbmMemTable, BusObjBase,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

const
  SX_AutoPostDueMsg = WM_USER + 110;

type
  TMemTransListGUI = class(TBaseListingGUI)
    popDelete: TAdvPopupMenu;
    popDeleteBtn1: TMenuItem;
    popDeleteBtn2: TMenuItem;
    dlgProgress: TProgressDialog;
    qryMainMemTransID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainDateDue: TDateField;
    qryMainType: TWideStringField;
    qryMainCompany: TWideStringField;
    qryMainAutoPost: TWideStringField;
    qryMainCreatedDate: TDateField;
    qryMainformClass: TWideStringField;
    qryMainTransID: TIntegerField;
    qryMainTotalAmountInc: TFloatField;
    qryMainTransactionType: TWideStringField;
    AutoPostTimer: TTimer;
    qryMainMemo: TWideStringField;
    btnCreateAll: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure AutoPostDue(var Message: TMessage); message SX_AutoPostDueMsg;
    procedure popDeletePopup(Sender: TObject);
    procedure popDeleteBtn1Click(Sender: TObject);
    procedure popDeleteBtn2Click(Sender: TObject);
    procedure btnGridClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure AutoPostTimerTimer(Sender: TObject);
    procedure btnCreateAllClick(Sender: TObject);
  private
    BusObj, NewBusObj: TMSBusObj;

    IsAutoPosting       : Boolean;
    ClientName: string;
    function CloneTrans(var msg: string): integer;
    Function DoProductallocation(const LineObj :(*TTransLineBase*)TProdQty):Boolean ;
    function PostMemTrans(var TransType: string; var msg: string; GUIMode: boolean = true): boolean;
    procedure DeleteMemTrans(IdList: string);
    Procedure OpenTransaction;
    procedure DoAutoPostDue;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure RefreshQuery; override;
    Procedure SetGridColumns;override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); override;
  public
  end;


implementation

{$R *.dfm}

uses
  CommonDbLib,CommonLib,BusObjSales,
  BusObjOrders , DateUtils, FastFuncs, BusobjCash, busobjExpenses,
  frmAllocation, IntegerListObj, BaseInputForm, FormFactory, DNMLib, MemoDialog,
  tcConst, BusObjJournal, BusObjConst,FormS, BusObjRepairs;

procedure TMemTransListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('dtfrom').AsDate := FilterDateFrom;
  qryMain.Params.ParamByName('dtto').AsDate   := FilterDateTo;
  inherited;
end;

function TMemTransListGUI.CloneTrans(var msg: string): integer;
Var
  NewConnection: TERPConnection;
begin
  Result := 0;
  msg := '';
  NewConnection := GetNewMyDacConnection(Self);
  TfmAllocation.ShowProductDetails(True);
  Try
    BusObj.SilentMode := False;
    if NewConnection.Intransaction = False then NewConnection.StartTransaction;
    BusObj.Connection := TMyDacDataConnection.Create(BusObj);
    if BusObj is TTransBase then
      TTransBase(BusObj).DoProductallocation := Self.DoProductallocation;

    BusObj.Connection.Connection := NewConnection;
    BusObj.Load(Qrymain.fieldByname('TransID').AsInteger);
    if BusObj is TSales then TSales(BusObj).InstantiateAllTrees; // load the trees to copy
    if BusObj.Count = 0 then begin
      msg:= 'Original transaction not found.';
      Exit;
    end;

    if BusObj is TTransBase then
      DoShowProgressbar(TTransBase(BusObj).Lines.Count, 'Creating ' + ReplaceStr(TTransBase(BusObj).BusObjectTypeDescription, ' Object', ''));
    try
      if (BusObj is TPurchaseOrder) or (BusObj is TReturnAuthority) or (BusObj is TExpenseBase) then
        NewBusObj := TTransBase(BusObj.CopyTrans('OrderDate', Qrymain.FieldByname('DateDue').AsVariant, False, 'PurchaseOrderID'))
      else if (BusObj is TSales) or (BusObj is TCashBase) then
        NewBusObj := TTransBase(BusObj.CopyTrans('SaleDate', Qrymain.FieldByname('DateDue').AsVariant, False, 'SaleID'))
      else if BusObj is TJournalEntry then
        NewBusObj := TTransBase(BusObj.CopyTrans('TransactionDate', Qrymain.FieldByname('DateDue').AsVariant, False, 'GJID'))
      else if BusObj is TRepairs then
        NewBusObj := TMSBusObj(BusObj.CopyTrans('JobDueDate', Qrymain.FieldByname('DateDue').AsVariant, False, 'RepairID'));
    finally
      DoHideProgressbar;
    end;

    if NewBusObj = nil then begin
//    Raise Exception.Create(TransObj.ResultStatus.Messages);
      msg := BusObj.ResultStatus.Messages;
      Exit;
    end;

    if BusObj is TTransBase then begin
      TTransBase(NewBusObj).totalbalance   := TTransBase(NewBusObj).totalamountinc;
      TTransBase(NewBusObj).totalpaid      := 0;
      TTransBase(NewBusObj).isPaid         := False;
    end;

    if BusObj is TPurchaseOrder then begin
      TPurchaseOrder(NewBusObj).SupplierInvoiceNumber := '';
      TPurchaseOrder(NewBusObj).NullWhenDateIs0    := true;
      TPurchaseOrder(NewBusObj).SupplierInvoiceDate:= 0;
      TPurchaseOrder(NewBusObj).DueDate            := 0;
    end else if BusObj is TSales then begin
      TSales(NewBusObj).SaleDate       := TSales(NewBusObj).SaleDate;
      TSales(NewBusObj).Lines.Dataset.First;
      while not TSales(NewBusObj).Lines.Dataset.Eof do begin
        TSales(NewBusObj).Lines.ShipDate := TSales(NewBusObj).SaleDate;
        TSales(NewBusObj).Lines.Dataset.Next;
      end;
      TSales(NewBusObj).Lines.PostDb;

      if NewBusObj is TSalesorder then TSalesorder(NewBusObj).Converted := False;
      if NewBusObj is TQuote      then TQuote(NewBusObj).Converted := False;
      {early payment discount should not be copied across as its only added when the payment is made}
      if TSales(NewBusObj).Lines.Locate('Productname' , EARLY_PAYMENT_DISCOUNT_PRODUCT , []) then begin
        TSales(NewBusObj).Lines.Deleted:= true;
        TSales(NewBusObj).Lines.PostDB;
      end;
    end else if BusObj is TJournalEntry then begin
      TJournalEntry(NewBusObj).TransactionNo := IntToStr(TJournalEntry(NewBusObj).ID);
    end else if BusObj is TRepairs then begin
      TRepairs(NewBusObj).RepairDocno := IntToStr(TRepairs(NewBusObj).ID);
    end;

    if NewBusObj is TTransBase then
      ClientName := TTransBase(NewBusObj).ClientName
    else
      ClientName := '';
    NewBusObj.PostDB;
    NewBusObj.Save;
    Result := NewBusObj.ID;
    if NewConnection.Intransaction = True then NewConnection.Commit;
  Finally
    TfmAllocation.ShowProductDetails(False);
    FreeAndNil(NewBusObj);
    FreeAndNil(BusObj);
    FreeAndNil(NewConnection);
  end;
end;

procedure TMemTransListGUI.AutoPostDue(var Message: TMessage);
begin
  DoAutoPostDue;
end;

procedure TMemTransListGUI.DoAutoPostDue;
var
  DelIdList: TIntegerList;
  s, transTyp: string;
  msg: string;

  function RecordsNeedProcessing: boolean;
  var  qry: TMyQuery;
  begin
    qry:= TMyQuery.Create(nil);
    try
      qry.Connection:= qryMain.Connection;
      qry.SQL.Add('select count(memtransid) from tblmemtrans');
      qry.SQL.Add('where datedue <= ' + QuotedStr(FormatDateTime('yyyy-mm-dd',now)));
      qry.SQL.Add('and autopost = "T"');
      qry.SQL.Add('and datedue between :dtfrom and :dtto');
      qry.ParamByName('dtfrom').AsDate := dtFrom.DateTime;
      qry.ParamByName('dtto').AsDate := dtTo.DateTime;
      qry.Open;
      result:= qry.Fields[0].AsInteger > 0;
    finally
      qry.Free;
    end;
  end;

begin
  IsAutoPosting := True;
  DelIdList:= TIntegerList.Create;
  Try
    if not RecordsNeedProcessing then
      exit;
    s:= '';
    if qryMain.RecordCount > 0 then begin
      qryMain.First;
      dlgProgress.Caption:= 'Please Wait ...';
      dlgProgress.MinValue:= 0;
      dlgProgress.MaxValue:= qryMain.RecordCount;
      dlgProgress.Step:= 1;
      dlgProgress.Value:= 0;
      dlgProgress.Execute;
      while not qryMain.Eof do begin
        if (qryMain.FieldByName('DateDue').AsDateTime <= Date) and
            qryMainAutoPost.AsBoolean then begin
          DelIdList.Add(qryMainMemTransID.AsInteger);
          if PostMemTrans(transTyp,msg,false) then begin
            if s <> '' then s:= s + #13#10;
            if qryMainCompany.AsString <> '' then
              s:= s + transTyp + ' Created for ' + qryMainCompany.AsString
            else
              s:= s + transTyp + ' Created';
          end
          else begin
            if s <> '' then s:= s + #13#10;
            if qryMainCompany.AsString <> '' then
              s:= s + transTyp + ' Failed for ' + qryMainCompany.AsString + ' ' +
                msg +  ' ' + qryMainType.AsString
            else
              s:= s + transTyp + ' Failed ' +
                msg +  ' ' + qryMainType.AsString;

          end;
        end;
        qryMain.Next;
        dlgProgress.StepIt;
      end;
      dlgProgress.CloseDialog;
      if DelIdList.Count > 0 then begin
        DeleteMemTrans(DelIdList.CommaText);
        RefreshQuery;
        DoMemoDialog('Results',s,ssBoth);
      end;
    end;
  finally
    DelIdList.Free;
    IsAutoPosting := False;
  end;
end;

procedure TMemTransListGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'MemTransID,GlobalRef,CreatedDate,formClass,TransID,PurchaseOrderID');
  if (AccessLevel = 1) then begin
//    PostMessage(self.Handle, SX_AutoPostDueMsg, 0, 0);
    AutoPostTimer.Enabled:= true;
  end;
  btnCreateAll.visible :=devmode;
  if devmode then
    EnableMultiSelect('');
end;

procedure TMemTransListGUI.popDeletePopup(Sender: TObject);
begin
  popDeleteBtn1.Caption := 'Delete This Transaction ''' + qryMain.FieldByName('Type').AsString + '''';
  popDeleteBtn2.Caption := 'Delete All Transactions ''' + qryMain.FieldByName('Type').AsString + '''';
end;

procedure TMemTransListGUI.popDeleteBtn1Click(Sender: TObject);
var
  qry: TERPQuery;
  key: integer;
begin
  key := qryMain.FieldByName('MemTransID').AsInteger;
  qry := TERPQuery.Create(self);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := qryMain.Connection;
    qry.SQL.Text   := Format('DELETE FROM tblMemTrans WHERE MemTransID = %d', [key]);
    qry.Execute;
    RefreshQuery;
  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TMemTransListGUI.popDeleteBtn2Click(Sender: TObject);
var 
  qry: TERPQuery;
  key: string;
begin
  key := qryMain.FieldByName('Type').AsString;
  qry := TERPQuery.Create(self);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := qryMain.Connection;
    qry.SQL.Text   := Format('DELETE FROM tblMemTrans WHERE Concat(Type, ''#'', TransID) = ''%s''', [key]);
    qry.Execute;
    RefreshQuery;
  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TMemTransListGUI.btnCreateAllClick(Sender: TObject);
begin
  inherited;
  IterateProcno := 1;
  iterateSelectedRecordsReverse;
  RefreshQuery;
end;

procedure TMemTransListGUI.btnGridClick(Sender: TObject);
begin
  popDelete.Popup(Mouse.CursorPos.x, Mouse.CursorPos.Y);
  invalidate;
end;

procedure TMemTransListGUI.grdMainDblClick(Sender: TObject);
var
  transTyp: string;
  msg: string;
begin
  if not PostMemTrans(transTyp,msg) then begin
    if msg <> '' then
      MessageDlgXP_Vista('Could not creat transaction: ' + msg, mtInformation,[mbOk],0);
  end;
end;

procedure TMemTransListGUI.IterateselectedRecordsCallback(var Abort: boolean;  SelIndex: Integer);
var
  transTyp: string;
  msg: string;
begin
  inherited;
  if iterateprocno =1 then
    PostMemTrans(transTyp,msg,False );
end;

procedure TMemTransListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('DateDue') + ' ASC CIS ; ' + QuotedStr('Type') + ' ASC CIS';
  BaseIndexFieldNames := QuotedStr('DateDue') + ' ASC CIS ; ' + QuotedStr('Type') + ' ASC CIS';
  qryMain.First;
end;

Function TMemTransListGUI.DoProductallocation(const LineObj :(*TTransLineBase*)TProdQty):Boolean ;
begin
    LineObj.PostDb;
    Result := TfmAllocation.DoBinBatchform(LineObj.PQA, Self);
end;

procedure TMemTransListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  IsAutoPosting := False;
  Searchmode := smFullList;
end;

function TMemTransListGUI.PostMemTrans(var TransType: string; var msg: string; GUIMode: boolean): boolean;
var
  id: integer;
  form: TBaseInputGUI;
  Choice:Word;
begin
  Result := true;
  BusObj := nil;
  TransType := '';
  if Pos('Purchase Order',qryMainType.AsString) > 0 then begin
    BusObj:= TMSBusObj(TPurchaseOrder.Create(Self));
    TransType:= 'Purchase Order';
  end else if Pos('Invoice', qryMainType.AsString) > 0 then begin
    BusObj := TMSBusObj(TInvoice.Create(Self));
    TransType:= 'Invoice';
  end else if Pos('Sales Order',qryMainType.AsString) > 0 then begin
    BusObj := TMSBusObj(TSalesOrder.Create(Self));
    TransType:= 'Sales Order';
  end else if Pos('Quote',qryMainType.AsString) > 0  then begin
    BusObj := TMSBusObj(TQuote.Create(Self));
    TransType:= 'Quote';
  end else if Pos('Cheque', qryMainType.AsString) > 0 then begin
    BusObj := TMSBusObj(TCheque.Create(Self));
    TransType:= 'Cheque';
  end else if Pos('Bill', qryMainType.AsString) > 0 then begin
    BusObj := TMSBusObj(TBill.Create(Self));
    TransType:= 'Bill';
  end else if Pos('Credit', qryMainType.AsString) > 0 then begin
    BusObj := TMSBusObj(TCredit.Create(Self));
    TransType:= 'Credit';
  end else if Pos('Cash Sale', qryMainType.AsString) > 0 then begin
    BusObj := TMSBusObj(TCashSale.Create(Self));
    TransType:= 'Cash Sale';
  end else if Pos('Refund', qryMainType.AsString) > 0 then begin
    BusObj := TMSBusObj(TRefundSale.Create(Self));
    TransType:= 'Refund';
  end else if Pos('Journal Entry', qryMainType.AsString) > 0 then begin
    BusObj := TMSBusObj(TJournalEntry.Create(Self));
    TransType:= 'Journal Entry';
  end else if Pos('Repairs', qryMainType.AsString) > 0 then begin
    BusObj := TMSBusObj(TRepairs.Create(Self));
    TransType:= 'Repairs';
  end;
  Busobj.BusobjEVent :=DoBusinessObjectEvent;
try
  msg:= '';
  if GuiMode then begin
    if TransType  = '' then begin
      CommonLib.MessageDlgXP_Vista('Memorised transactions not supported for this transaction type',
        mtInformation,[mbOk],0);
      exit;
    end;
    Choice := CommonLib.MessageDlgXP_Vista( qryMainType.AsString+ ' is Memorised.' ,
                mtConfirmation , [] , 0 , nil , 'Choose the Option' , '' , False , nil ,
                  'Open ' +qryMainType.AsString +',Post '+TransType+' as New,Cancel');

    if choice  = 102 then exit;

    if choice = 100 then begin
      OpenTransaction;
      if CommonLib.MessageDlgXP_Vista('Post Memorised ' + TransType +
        ' as new ' + TransType +'?',mtconfirmation , [mbYes,mbNo] , 0) = mrNo then begin
        (*FreeAndNil(TransObj);*)
        Exit;
      end;
    end;
  end;

  if BusObj is TTransBase then begin
    BusObj.FieldsnotToclone:=
      QuotedStr('IsPaid') + ',' +
      QuotedStr('TotalBalance') + ',' +
      QuotedStr('TotalPaid') + ',' +
      QuotedStr('ForeignPaidAmount') + ',' +
      QuotedStr('ForeignBalanceAmount') + ',' +
      QuotedStr('DueDate');
  end;

  id:= CloneTrans(msg);
  result:= id > 0;
  if (id > 0) and GUIMode then begin
    { display form }
    form:= TBaseInputGUI(CommonLib.GetComponentByClassName(qryMainformClass.AsString,false));
    form.KeyID:= id;
    form.FormStyle:= fsMDIChild;
    form.BringToFront;
    DeleteMemTrans(qryMainMemTransID.AsString);
    RefreshQuery;
  end else begin
    DeleteMemTrans(qryMainMemTransID.AsString);
  end;
  finally
       FreeAndNil(BusObj);
  end;

end;

procedure TMemTransListGUI.DeleteMemTrans(IdList: string);
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(self);
  try
    qry.Connection := qryMain.Connection;
    qry.SQL.Text := 'DELETE FROM tblMemTrans WHERE MemTransID in (' + IdList + ')';
    qry.Execute;
  finally
    qry.Free;
  end;
end;

procedure TMemTransListGUI.OpenTransaction;
var
  frmPopup:TRegForm;
begin
     frmPopup := FormFact.CreateForm[ClassName + Chr(95) + (*grdmain.GetActiveField.FieldName + Chr(95) +*) '*'+ chr(95)+qrymaintransactionType.asString ];

      if not Assigned(frmPopup) then begin
        MessageDlgXP_Vista(qrymaintransactionType.asString +' Form Can Not Be Created.' , mtwarning , [mbok] , 0);
        exit;
      end;
      if frmPopup.Visible and (frmPopup.KeyID <> QrymainTransID.asInteger) then begin
        MessageDlgXP_Vista( TypeToDescription(ClassNameToTranType(frmPopup.classname)) +' is Already Opened for a Different Record. Please Close the Form First.' , mtWarning, [mbok] ,0);
        Exit;
      end;

      frmPopup.KeyID := QrymainTransID.asInteger;
      frmPopup.CallingClassName := self.ClassName;
      frmPopup.AttachObserver(Self);
      if frmPopup.AccessLevel = 6 then begin //No Access
        frmPopup.Close;
        Exit;
      end;
      frmPopup.showmodal;
end;

procedure TMemTransListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Transactiontype');
  RemoveFieldfromGrid('TRansId');
end;

procedure TMemTransListGUI.AutoPostTimerTimer(Sender: TObject);
begin
  inherited;
  AutoPostTimer.Enabled:= false;
  DisableForm;
  try
    self.DoAutoPostDue;
  finally
    EnableForm;
  end;  
end;

procedure TMemTransListGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
    (*if (Eventtype = BusobjEvent_ToDo ) and (Value = BusobjEvent_ProgressbarShowsub ) then begin
      DoShowSubProgressbar(Sender.count );
    end  else if (Eventtype = BusobjEvent_ToDo ) and (Value =  BusobjEvent_ProgressbarStepsub) then begin
      DoStepSubProgressbar;
    end  else *)if (Eventtype = BusobjEvent_ToDo ) and (Value =  BusobjEvent_ProgressbarProgress) then begin
      DoStepProgressbar;
    end;
end;

initialization
  RegisterClassOnce(TMemTransListGUI);
end.



