{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 26/09/05  1.00.01 ISB  Added IgnoreDates And Enable Web Search.
 20/01/06  1.00.02  AL  added registerclass
}
unit BackOrderListForm;

interface

uses
  Windows, Messages, Graphics, Controls,
  BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ImgList, Menus, AdvMenus, ComCtrls,AdvOfficeStatusBar, PrintDAT,
  ActnList, SelectionDialog, DNMPanel, wwDialog, Wwlocate, MemDS, DBAccess,
  MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog, Classes, Dialogs,
   wwdblook, Shader, kbmMemTable, BaseInputForm,IntegerListObj,BackorderListBase, BusObjSales,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TBackOrdersListGUI = class(TBackorderListBaseGUI)
    btnInvoiceList: TDNMSpeedButton;
    qryMainSaleID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainEmployeeID: TIntegerField;
    qryMainProductID: TIntegerField;
    qryMainSaleDate: TDateField;
    qryMainCustomerName: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainOriginalNo: TWideStringField;
    qryMainInvoiceDocNumber: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainBackOrder: TFloatField;
    qryMainProductName: TWideStringField;
    qryMainProduct_Description: TWideStringField;
    qryMainLinePrice: TFloatField;
    qryMainLinePriceInc: TFloatField;
    qryMainLineWholesalePrice: TFloatField;
    qryMainLineCost: TFloatField;
    qryMainLineCostInc: TFloatField;
    qryMainDeleted: TWideStringField;
    qryMainCustomerType: TWideStringField;
    lblHide: TLabel;
    qryMainSaleLineID: TIntegerField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainConvertFromQuote: TWideStringField;
    qryMainConvertFromSO: TWideStringField;
    qryMainCreationDate: TDateTimeField;
    qryMainSalesLinesCustField1: TWideStringField;
    qryMainSalesLinesCustField2: TWideStringField;
    qryMainSalesLinesCustField3: TWideStringField;
    qryMainSalesLinesCustField4: TWideStringField;
    qryMainSalesLinesCustField5: TWideStringField;
    qryMainSalesLinesCustField6: TWideStringField;
    qryMainSalesLinesCustField7: TWideStringField;
    qryMainSalesLinesCustField8: TWideStringField;
    qryMainSalesLinesCustField9: TWideStringField;
    qryMainSalesLinesCustField10: TWideStringField;
    mnuShowStatus: TMenuItem;
    N1: TMenuItem;
    btnShowStatus: TDNMSpeedButton;
    qryMainRep: TWideStringField;
    qryMainEnteredBy: TWideStringField;
    qryMainclass: TWideStringField;
    qryMainTotalLineCost: TFloatField;
    qryMainTotalLineCostinc: TFloatField;
    qryMainTotalLinePrice: TFloatField;
    qryMainTotalLinePriceInc: TFloatField;
    qryMainDueDate: TDateField;
    qryMainFirstcolumn: TWideStringField;
    qryMainSecondcolumn: TWideStringField;
    qryMainThirdcolumn: TWideStringField;
    ProgressBar: TProgressBar;
    qryMainShipDate: TDateField;
    qryMainWarrantyEndsOn: TDateField;
    qryMainWarrantyPeriod: TWideStringField;
    qryMainCUSTdate1: TDateField;
    qryMainCUSTdate2: TDateField;
    qryMainCUSTdate3: TDateField;
    qryMainLineShipDate: TDateTimeField;
    qryMainPreferedSupplier: TWideStringField;
    qryMainPickUpFrom: TWideStringField;
    qryMainPickMemo: TWideMemoField;
    qryMainPrintName: TWideStringField;
    qryMainPushedToSmartOrder: TWideStringField;
    procedure btnInvoiceListClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure IgnoreDatesClick(Sender: TObject);
    procedure mnuShowStatusClick(Sender: TObject);
    procedure btnSmartOrderClick(Sender: TObject);
  private
    { Private declarations }
    fbConsolidateMode: boolean;
    fiNewSaleID: integer;
    fiCustomerId: Integer;

    Procedure CopyInvLineFromOutstandingBOLine(const Changefield :String; const ChangeValue :Variant; src,Targ:TInvoiceline);

  protected
    procedure RefreshQuery; override;
    Procedure AssignKeyId(Popupform :TBaseInputGUI); override;
    procedure RefreshTotals; override;
    Procedure SetGridColumns;override;
    Function ExpressDetailListName:String;Override;
  public
    { Public declarations }
    property ConsolidateMode: boolean read fbConsolidateMode write fbConsolidateMode;
    property NewSaleID: integer read fiNewSaleID write  fiNewSaleID;
    Property CustomerId :Integer read fiCustomerId write fiCustomerId;
  end;

implementation

uses
  SysUtils, frmInvoice, DateUtils, CommonLib, Forms, FastFuncs, MySQLConst,
  FormFactory, BusObjSaleBase, AppEnvironment, TypInfo,
  BusObjTrans, frmStockStatus, Sales, ProductQtyLib,
  CommonFormLib, BusObjBase, CommonDbLib, ThreadObjForOtherDB, tcConst;

{$R *.dfm}

procedure TBackOrdersListGUI.grpFiltersClick(Sender: TObject);
begin
  inherited;
  lblTotal.Caption := IntToStr(qryMain.RecordCount);
end;

procedure TBackOrdersListGUI.btnInvoiceListClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TInvoiceListGUI');
  Self.Close;
end;

procedure TBackOrdersListGUI.btnSmartOrderClick(Sender: TObject);
begin
  inherited;
  MakeSmartOrder('I');
end;

procedure TBackOrdersListGUI.cmdNewClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TInvoiceGUI');
  If not Assigned(tmpComponent) then Exit;
  with TInvoiceGUI(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TBackOrdersListGUI.RefreshQuery;
begin
  try qryMain.Params.ParamByName('txtfrom').AsString := FormatDateTime(MysqlDateFormat, FilterDateFrom); Except end;
  try qryMain.Params.ParamByName('txtto').AsString := FormatDateTime(MysqlDateFormat, filterDateTo);Except end;
  try qryMain.Params.ParamByName('CustomerId').asInteger := CustomerId;Except end;
  inherited;
  btnShowStatus.Visible := qrymain.recordcount >0;
  mnuShowStatus.Visible := qrymain.recordcount >0;
end;

procedure TBackOrdersListGUI.grdMainDblClick(Sender: TObject);
begin
  if Self.Owner is TInvoiceGUI then Exit;
  inherited;
end;

procedure TBackOrdersListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if Self.ErrorOccurred then Exit;
  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'ClientId,SaleId,EmployeeId,ProductId,SaleLineId');

   if  AppEnv.CompanyPrefs.ShowSalesWarrantyEndsOn then begin
    grdmain.AddField('WarrantyEndsOn');
   end else begin
    RemoveFieldfromGrid('WarrantyEndsOn');
   end;

   if  AppEnv.CompanyPrefs.ShowSalesWarrantyPeriod then begin
    grdmain.AddField('WarrantyPeriod');
   end else begin
    RemoveFieldfromGrid('WarrantyPeriod');
   end;

   if Trim(AppEnv.CompanyPrefs.SalesWarrantyEndsOnCaption) <> '' then
    grdmain.ColumnByName('WarrantyEndsOn').DisplayLabel :=
      Trim(AppEnv.CompanyPrefs.SalesWarrantyEndsOnCaption);

   if Trim(AppEnv.CompanyPrefs.SalesWarrantyPeriodCaption) <> '' then
    grdmain.ColumnByName('WarrantyPeriod').DisplayLabel :=
      Trim(AppEnv.CompanyPrefs.SalesWarrantyPeriodCaption);


   if fbConsolidateMode then begin
      grdMain.Options        := grdMain.Options + [dgMultiSelect];
      grdMain.MultiSelectOptions := grdMain.MultiSelectOptions + [msoShiftSelect];
      lblHide.Visible        := true;
      btnCustomize.Enabled   := false;
      cmdExport.Enabled      := false;
      btnInvoiceList.Enabled := false;
      cmdNew.Enabled         := false;
   end;
end;
(*procedure TBackOrdersListGUI.cmdCloseClick(Sender: TObject);
var
  qryTemp: TERPQuery;
  i,j, idx: integer;
  lst: TStringList;
  NewInvoice,ExistingBOInvoice: TInvoice;
  SavedSilentMode:Boolean;
begin
  SavedSilentMode := False;
  if FormStillOpen('TInvoiceGUI') and (Self.Owner.ClassName = 'TInvoiceGUI') then begin
    qryTemp := TERPQuery.Create(nil);
    qryTemp.Connection := TInvoiceGUI(Self.Owner).MyConnection;
    lst:= TStringList.Create;
    NewInvoice:= TInvoiceGui(self.Owner).Invoice;
    try
      if (grdMain.SelectedList.Count > 0) and (CommonLib.MessageDlgXP_Vista('Do You Wish To Add The ' +
        IntToStr(grdMain.SelectedList.Count) + ' Selected BO''s To Your Invoice ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      begin
        if fbConsolidateMode then begin
          ExistingBOInvoice := TInvoice.Create(nil);
          try
            ExistingBOInvoice.Connection := TMyDacDataConnection.Create(ExistingBOInvoice);
            ExistingBOInvoice.Connection.connection := NewInvoice.Connection.connection;
            ExistingBOInvoice.SilentMode := True;
            SavedSilentMode := NewInvoice.SilentMode;
            NewInvoice.SilentMode := True;
            for i := 0 to grdMain.SelectedList.Count - 1 do begin
              qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
  //            qryTemp.Sql.Clear;
  //            qryTemp.Sql.Add('UPDATE tblsaleslines SET SaleID=' + IntToStr(fiNewSaleID) +
  //              ' WHERE SaleLineID=' + qryMainSaleLineID.AsString + ';');
  //            if (fiNewSaleID > 0) and (StrValue(qryMainSaleLineID.AsString) > 0) then begin
  //              qryTemp.Execute;
  //            end;
              idx:= lst.IndexOf(qryMain.FieldByName('SaleId').AsString);
              if idx < 0 then begin
                { we dont have this invoice number in list yet }
                lst.AddObject(qryMain.FieldByName('SaleId').AsString, TIntegerList.Create);
                TIntegerList(lst.Objects[lst.Count-1]).AddIfNotInList(qryMain.FieldByName('SaleLineId').AsInteger);
              end
              else begin
                { invoice already in list }
                TIntegerList(lst.Objects[idx]).AddIfNotInList(qryMain.FieldByName('SaleLineId').AsInteger);
              end;
            end;
            { now do the consolidation!!! }
            for i:= 0 to lst.Count-1 do begin
              { 1. load invoice }
              ExistingBOInvoice.Load(StrToInt(lst.Strings[i]));
              { 2. lock invoice }
              ExistingBOInvoice.Lock;
              try
                { 3. clone selected lines to NewInvoice }
                for j := 0 to TIntegerList(lst.Objects[i]).Count - 1 do begin
                  if ExistingBOInvoice.Lines.Dataset.Locate('SaleLineID',TIntegerList(lst.Objects[i]).Item[j],[]) then begin
                    CopyInvLineFromOutstandingBOLine('SaleID' , newSaleId ,ExistingBOInvoice.Lines ,  NewInvoice.Lines);
                    { 4. set line qty to zero }
                    ExistingBOInvoice.Lines.QtySold := 0;
                    ExistingBOInvoice.Lines.PostDb;
                  end;
                end;
                { 5. validate/Save invoices }
                ExistingBOInvoice.ResultStatus.Clear;
                if not ExistingBOInvoice.Save then begin
                  CommonLib.MessageDlgXP_Vista('Could not add existing back order invoices : ' + ExistingBOInvoice.ResultStatus.Messages, mtWarning, [mbOK], 0);

                  ExistingBOInvoice.Connection.RollbackTransaction;
                  ExistingBOInvoice.Connection.BeginTransaction;
                  Exit;
                end;

                NewInvoice.ResultStatus.Clear;
                if not NewInvoice.Save then begin
                  CommonLib.MessageDlgXP_Vista('Could not add existing back order invoices : ' + NewInvoice.ResultStatus.Messages, mtWarning, [mbOK], 0);

                  NewInvoice.Connection.RollbackTransaction;
                  NewInvoice.Connection.BeginTransaction;
                  Exit;

                end;
              finally   { 6. unlock invoice }
                ExistingBOInvoice.UnLock;
              end;
            end;
          finally
            FreeAndNil(ExistingBOInvoice);
            NewInvoice.SilentMode := SavedSilentMode;
          end;
        end;
      end;
    finally
      FreeAndNil(qryTemp);
      for i:= 0 to lst.Count -1 do
        lst.Objects[i].Free;
      lst.Free;
    end;
  end;
  inherited;
end;    *)
procedure TBackOrdersListGUI.cmdCloseClick(Sender: TObject);
begin
  Inherited;
(*var
  i,j, idx: integer;
  lst: TStringList;
  NewInvoice,ExistingBOInvoice: TInvoice;
  SavedSilentMode:Boolean;
//  ID:Integer;
begin
  SavedSilentMode := False;
  try
      if not(FormStillOpen('TInvoiceGUI') and (Self.Owner.ClassName = 'TInvoiceGUI')) then exit;

      if (grdMain.SelectedList.Count > 0) and (CommonLib.MessageDlgXP_Vista('Do You Wish To Add The ' +
            IntToStr(grdMain.SelectedList.Count) + ' Selected BO''s To Your Invoice ?', mtConfirmation, [mbYes, mbNo], 0) = mrno ) then exit;

      if not fbConsolidateMode then Exit;


      lst:= TStringList.Create;
      NewInvoice:= TInvoiceGui(self.Owner).Invoice;
      try
          ExistingBOInvoice := TInvoice.Create(nil);
          try
              ExistingBOInvoice.Connection := TMyDacDataConnection.Create(ExistingBOInvoice);
              ExistingBOInvoice.Connection.connection := NewInvoice.Connection.connection;
              ExistingBOInvoice.SilentMode := True;
              SavedSilentMode := NewInvoice.SilentMode;
              NewInvoice.SilentMode := True;

              {get the selected sale and sale line IDs: note that its possible to select few lines from a back order not the whole back order}
              for i := 0 to grdMain.SelectedList.Count - 1 do begin
                qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
                idx:= lst.IndexOf(qryMain.FieldByName('SaleId').AsString);
                if idx < 0 then begin
                  { we dont have this invoice number in list yet }
                  lst.AddObject(qryMain.FieldByName('SaleId').AsString, TIntegerList.Create);
                  TIntegerList(lst.Objects[lst.Count-1]).AddIfNotInList(qryMain.FieldByName('SaleLineId').AsInteger);
                end else begin
                  { invoice already in list }
                  TIntegerList(lst.Objects[idx]).AddIfNotInList(qryMain.FieldByName('SaleLineId').AsInteger);
                end;
              end;

              { now do the consolidation!!! }
              NewInvoice.Connection.BeginNestedTransaction;
              try
                  for i:= 0 to lst.Count-1 do begin
                    { 1. load invoice }
                      NewInvoice.Connection.BeginNestedTransaction;
                      Try
                          ExistingBOInvoice.Load(StrToInt(lst.Strings[i]));
                          NewInvoice.UserLock.Lock(NewInvoice.LockGroupName , ExistingBOInvoice.ID);{ 2. lock invoice }
                          for j := 0 to TIntegerList(lst.Objects[i]).Count - 1 do begin { 3. clone selected lines to NewInvoice }
                              if ExistingBOInvoice.Lines.Dataset.Locate('SaleLineID',TIntegerList(lst.Objects[i]).Item[j],[]) then begin
                                CopyInvLineFromOutstandingBOLine('SaleID' , newSaleId ,ExistingBOInvoice.Lines ,  NewInvoice.Lines);
                                ExistingBOInvoice.Lines.QtySold := 0;{ 4. set line qty to zero }
                                ExistingBOInvoice.Lines.PostDb;
                              end;
                          end;

                          ExistingBOInvoice.ResultStatus.Clear;{ 5. validate/Save invoices }
                          if not ExistingBOInvoice.Save then begin
                              CommonLib.MessageDlgXP_Vista('Could not add existing back order invoices : ' +
                                ExistingBOInvoice.ResultStatus.Messages, mtWarning, [mbOK], 0);
                              NewInvoice.Lines.Canceldb;
                              NewInvoice.Lines.Closedb;
                              NewInvoice.Closedb;
                              NewInvoice.Connection.RollbackNestedTransaction;
                              NewInvoice.opendb;
                              NewInvoice.Lines;
                              continue;
                          end;
                          NewInvoice.connection.CommitNestedTransaction;
                          ExistingBOInvoice.Closedb;
                      Except
                        on E:Exception do begin
                          NewInvoice.Connection.RollbackNestedTransaction;
                        end;
                      end;
                  end;

                  NewInvoice.ResultStatus.Clear;
                  NewInvoice.PostDB;
                  {if not NewInvoice.Save then begin
                    CommonLib.MessageDlgXP_Vista('Could not add existing back order invoices : ' + NewInvoice.ResultStatus.Messages, mtWarning, [mbOK], 0);
                    NewInvoice.Connection.RollbackNestedTransaction;
                    Exit;
                  end;}
                  NewInvoice.Connection.CommitNestedTransaction;
              except
                on E:Exception do begin
                  NewInvoice.Connection.RollbackNestedTransaction;
                end;
              end;
          finally
            FreeAndNil(ExistingBOInvoice);
            NewInvoice.SilentMode := SavedSilentMode;
          end;
      finally
          {ID := NewInvoice.ID;
          NewInvoice.CloseDB;
          NewInvoice.Load(ID);}
          for i:= 0 to lst.Count -1 do
            lst.Objects[i].Free;
          lst.Free;
      end;
  finally
      inherited;
  end;*)
end;

Procedure TBackOrdersListGUI.CopyInvLineFromOutstandingBOLine(const Changefield :String; const ChangeValue :Variant; src,Targ:TInvoiceline);
var
  Propcount:integer;
  PropList: PPropList ;
  iIndex:integer;
  fsFieldsnotToclone:string;
begin
  targ.New;
  targ.DoFieldChange := False;
  fsFieldsnotToclone := '';
  Try
      Propcount:= GetPropList(PTypeInfo(targ.ClassInfo) , PropList);
      if (not(Assigned(PropList))) or (Propcount = 0 ) then Exit;
      for iIndex := 0 to Propcount-1 do begin
          try
            if FastFuncs.SameText(string(Proplist[iIndex].name), 'SaleDatetime') then begin // fields not to be copied
            end else if FastFuncs.SameText(string(Proplist[iIndex].name), changefield) then begin
              SetPropValue(targ , string(Proplist[iIndex].name) , ChangeValue);
            end else if (not (PropType( targ ,string(Proplist[iIndex].name)) in [tkClass, tkMethod, tkArray, tkRecord, tkInterface])) and
                  (assigned(Proplist[iIndex].setproc))  and
                  (FastFuncs.PosEx(uppercase(string(Proplist[iIndex].name)), uppercase(fsFieldsnotToclone)) = 0 ) then
                  if not(proplist^[iIndex].Proptype^.Kind = tkClass) then
                    SetPropValue(targ , string(Proplist[iIndex].name) , GetPropValue(src , string(Proplist[iIndex].name))) ;
            //  else Log('Non-writable:' + Proplist[iIndex].name , LogType_Error);
          Except
              on E:Exception do begin
                //  Log(Proplist[iIndex].name + '-' + E.Message , LogType_Error);
              end;
          end;
      end;
  Finally
      targ.DoFieldChange := True;
  end;
  targ.Postdb;
end;
function TBackOrdersListGUI.ExpressDetailListName: String;
begin
  result := 'TbackorderInvoiceExpressGUI';
end;

procedure TBackOrdersListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('SaleDate') + ' DESC CIS ; ' + QuotedStr('SaleID') + ' DESC CIS';
  BaseIndexFieldNames := QuotedStr('SaleID') + ' DESC CIS';
  qryMain.First;
end;

procedure TBackOrdersListGUI.FormCreate(Sender: TObject);
begin
  //NoDateRange := true;
  fbEnableWebSearch := true;
  if Qrymain.active then Qrymain.Close;
  Qrymain.SQL.text:=     StringReplace(StringReplace(StringReplace(Qrymain.SQL.text,
                      '" " as Firstcolumn'  ,Firstcolumn('P') +' as Firstcolumn'  , [rfIgnoreCase]),
                      '" " as Secondcolumn' ,Secondcolumn('P')+' as Secondcolumn' , [rfIgnoreCase]),
                      '" " as Thirdcolumn'  ,Thirdcolumn('P') +' as Thirdcolumn'  , [rfIgnoreCase]);

  qryMainFirstcolumn.DisplayLabel := AppEnv.DefaultClass.FirstColumn;
  qryMainSecondcolumn.DisplayLabel:= AppEnv.DefaultClass.Secondcolumn;
  qryMainThirdcolumn.DisplayLabel := AppEnv.DefaultClass.Thirdcolumn;
  inherited;
  AddCalccolumn('BackOrder',False);
  AddCalccolumn('TotalLineCost', true);
  AddCalccolumn('TotalLineCostinc', true);
  AddCalccolumn('TotalLinePrice', true);
  AddCalccolumn('TotalLinePriceInc', true);

  ShowChartViewOnPopup := True;
  fiCustomerId := 0;
end;

procedure TBackOrdersListGUI.IgnoreDatesClick(Sender: TObject);
begin
  inherited;
(*  if IgnoreDates.Checked then begin
    dtFrom.Enabled := false;
    dtTo.Enabled   := false;
  end else begin
    dtFrom.Enabled := true;
    dtTo.Enabled   := true;
  end;
  RefreshQuery;*)
end;

procedure TBackOrdersListGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  if  (FormFact.Identifier = 'OriginalNo') then
    Popupform.KeyID := TSalesBase.IDToggle(qryMain.Fields.FieldByName(FormFact.Identifier).AsString)
  else inherited;
end;

procedure TBackOrdersListGUI.RefreshTotals;
begin
  CalcnShowFooter;
end;

procedure TBackOrdersListGUI.mnuShowStatusClick(Sender: TObject);
var
  InvoiceObj:TInvoice;
begin
  if qryMainSaleID.asInteger =0 then exit;

  InvoiceObj:=TInvoice.create(Self);
  Try
    InvoiceObj.connection := TMyDacDataConnection.Create(InvoiceObj);
    InvoiceObj.connection.Connection := CommonDBLib.GetNewMyDacConnection(Self);
    InvoiceObj.Load(qrymainsaleID.ASInteger);
    if not InvoiceObj.Lock then Exit;
    InvoiceObj.connection.BeginTransaction;
    if TBaseSaleGUI.showStock(InvoiceObj, self.Color, ProgressBar , self) then begin
      InvoiceObj.connection.CommitTransaction;
    end else begin
      InvoiceObj.connection.RollbackTransaction;
    end;
  Finally
      FreeAndNil(InvoiceObj);
  end;
end;


procedure TBackOrdersListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ProductID');
  RemoveFieldfromGrid('clientID');
  RemoveFieldfromGrid('EmployeeId');
  SetUpcustomFields('Cust');
end;


initialization
  RegisterClassOnce(TBackOrdersListGUI);
end.
