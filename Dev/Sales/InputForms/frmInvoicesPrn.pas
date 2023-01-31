unit frmInvoicesPrn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmSalesPrnBase, DB, ActnList, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, Shader, StdCtrls, ExtCtrls, DNMPanel, DNMSpeedButton, Grids,
  Wwdbigrd, Wwdbgrid, ComCtrls,BusObjSales, kbmMemTable, 
  ProgressDialog, wwDialog, Wwlocate, PrintDAT, Buttons, wwdbdatetimepicker,
  wwdblook, AdvOfficeStatusBar, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TInvoicesPrnGUI = class(TSalesPrnBaseGUI)
    Label10: TLabel;
    qryMainTotalAmountInc: TFloatField;
    qryMainFundingBody: TWideStringField;
    qryMainFundingBodyID: TIntegerField;
    qryMainTotalAmount: TFloatField;
    qryMainStatus: TWideStringField;
    grpExtraOptions: TRadioGroup;
    qryMainTranstype: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
  private
//    procedure DoImportListJson;
    Procedure Printdeldocket(Sender:TObject);
    Procedure PrintPickingslip(Sender:TObject);
    { Private declarations }
  Protected
    function getReportType: String;Override;
    function getDocumentName: string;Override;

    function getSalesObj: TSales;Override;
    function GetReportTypeID: integer;Override;
    Procedure PrintExtraReports(Sender:TObject);Override;
    procedure RefreshReportstoPrint;Override;
    procedure SetGridColumns; Override;
    Procedure ExtrgrpFilters;Override;
    procedure PrintSelectedTrans(Sender: TObject; selclientID: Integer; IsFirst: boolean = true); Override;
    procedure DoExtraPrintOptions;override;
    function EMailMessageText(asaleID:Integer;sl:TStringlist): String;Override;
//    procedure DoEmailListJson;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, AppEnvironment, saleslib, BusObjPrintDoc, tcTypes, EmailUtils,
  BusObjClient, tcDataUtils, frmReportingOptions, IntegerListObj, SystemLib,
  DbSharedObjectsObj, CommonDbLib, BusObjCash, BusObjSaleBase, ObjectSerialiser,
  JsonObject, JsonObjectUtils, CorrespondenceObj, MemoDialog, tcConst;

{$R *.dfm}

procedure TInvoicesPrnGUI.btnImportClick(Sender: TObject);
begin
  inherited;
//  DoImportListJson;
end;

Procedure TInvoicesPrnGUI.PrintSelectedTrans(Sender:TObject; selclientID: Integer; IsFirst: boolean);
var
  st:TStringlist;
  ctr:Integer;
  s:String;
  ids:String;
begin
  s:= Qrymain.Filter;
  try
    st:= tStringlist.Create;
    try
      SelectedDatas(Qrymaintranstype.fieldname , st , true);
      Ids:= SelectedDatas('saleId' , true );
      if Ids = '' then exit;
      Ids := 'saleId = ' + replacestr(ids, ',' , ' or saleId = ');
      ShowProgressbar('Printing Invoices', GrdMain.SelectedList.Count* st.count*2);
      try
        for ctr:= 0 to st.Count-1 do begin
          PrintCount:=0;
          if sametext(st[ctr] , 'Invoice') then continuousreportname := 'Invoice Continuous' else continuousreportname := 'Cash Sale Continuous';
          grdmain.unselectAll;
          Qrymain.Filtered := false;
          if s<> '' then Qrymain.Filter := '(' + s + ') and '+qrymaintranstype.FieldName+' = ' + Quotedstr(st[ctr]) +' and ( '+Ids+')'
          else Qrymain.Filter := qrymaintranstype.FieldName+' = ' + Quotedstr(st[ctr])+' and ( '+Ids+')';
          Qrymain.Filtered := True;
          grdmain.selectAll;
          inherited PrintSelectedTrans(Sender, selclientID, ctr = 0);
          StepProgressbar(inttostr(ctr+1) +' of ' + inttostr(st.Count));
        end;
      finally
        HideProgressbar;
      end;
    finally
      FreeandNil(st);
    end;
  finally
    grdmain.unselectAll;
    Qrymain.Filtered := False;
    Qrymain.Filter := s;
    Qrymain.Filtered := Qrymain.Filter <> '';
  end;

end;
(*
procedure TInvoicesPrnGUI.DoEmailListJson;
var
  i: integer;
  IdList: TIntegerList;
//  sd: TSaveDialog;
  tmpFileName: string;
  qry: TERPQuery;
  CashSale: TCashSale;
  Invoice: TInvoice;
  Sale: TSalesBase;
  JSONSerialiser: TJSONSerialiser;
  list: TJsonObject;
  Corres: TCorrespondenceGui;
  prog: TProgressDialog;
begin
  DisableForm;
  try
    if Qrymain.RecordCount = 0 then begin
      CommonLib.MessageDlgXP_Vista('Nothing has been selected',mtInformation,[mbOk],0);
      Exit;
    end;

    Invoice := nil;
    CashSale := nil;
    IdList := TIntegerList.Create;
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    list := JO;
    Corres := TCorrespondenceGui.Create;
    prog := TProgressDialog.Create(nil);
    try
      SelectedIDs('SaleId',IdList,false);
      qry.SQL.Text := 'select * from tblSales where SaleId = :SaleId';
      prog.Caption := 'Exporting Sales as JSON';
      prog.MaxValue := IdList.Count;
      prog.Step := 1;
      prog.Value := 1;
      prog.Message := 'Exporting JSON ..';
      prog.Execute;

      tmpFileName := SystemLib.GetAppTempDir + '\Sales_' + FormatDateTime('yyyy-mm-dd_hh-nn-ss',now) +'.json';

      for I := 0 to IdList.Count - 1 do begin
        Sale := nil;
        qry.ParamByName('SaleId').AsInteger := IdLIst[i];
        qry.Open;
        try
          if qry.FieldByName('IsInvoice').AsBoolean then begin
            if not Assigned(Invoice) then begin
              Invoice := TInvoice.CreateWithSharedConn(nil);
            end;
            Invoice.Load(IdList[i]);
            Sale := Invoice;
          end
          else if qry.FieldByName('IsCashSale').AsBoolean then begin
            if not Assigned(CashSale) then begin
              CashSale := TCashSale.CreateWithSharedConn(nil);
            end;
            CashSale.Load(IdList[i]);
            Sale := CashSale;
          end;

          if Assigned(Sale) then begin
            JSONSerialiser:= TJSONSerialiser.Create;
            try
              list.A['List'].Add(JSONSerialiser.SerialiseObject(Sale));
            finally
              JSONSerialiser.Free;
            end;
          end;
        finally
          qry.Close;
        end;
        prog.StepIt;
      end;

//      list.SaveToFile(tmpFileName);
      RemoveFields(list,'ID,GlobalRef');
      JsonToFileFormated(list,tmpFileName);
      prog.CloseDialog;
      Corres.Subject := 'Sales List';
      Corres.MessageText := 'Sales List';
      Corres.AttachmentList.Add(tmpFileName);
      Corres.Execute();

    finally
      IdList.Free;
      qryMain.EnableControls;
      DbSharedObj.ReleaseObj(qry);
      Invoice.Free;
      CashSale.Free;
      list.Free;
      Corres.Free;
      prog.Free;
    end;
  finally
    EnableForm;
  end;
end;
*)
procedure TInvoicesPrnGUI.DoExtraPrintOptions;
begin
  inherited;
//  OptsForm.ActionList.InsertAfter('Email XML', 'Email JSON', 'Email Selected Items as JSON', DoEmailListJSON, false, true);
end;

{
procedure TInvoicesPrnGUI.DoImportListJson;
var
  od: TOpenDialog;
  jsonFileName: string;
  list, errList, json: TJsonObject;
  x: integer;
  JSONDesrialiser: TJSONDeserialiser;
  obj: TObject;
  errMsg: TStringList;
  prog: TProgressDialog;

  procedure AddErr(msg: string; j: TJsonObject);
  begin
    if not Assigned(errMsg) then errMsg := TStringList.Create;
    if not Assigned(errList) then errList := JO;
    if errMsg.Count > 0 then errMsg.Add('');
    errMsg.Add(msg);
    if Assigned(j) then
      errList.A['List'].Add(j);
  end;

begin
  od := TOpenDialog.Create(nil);
  try
    od.Filter := 'JSON files (*.json)|*.JSON|All files (*.*)|*.*';
    if od.Execute then
      jsonFileName := od.FileName
    else
      exit;
  finally
    od.Free;
  end;

  list := JO;
  JSONDesrialiser:= TJSONDeserialiser.Create;
  prog := TProgressDialog.Create(nil);
  try
    JSONDesrialiser.DatabaseConnection := CommonDbLib.GetNewMyDacConnection(nil);
    JSONDesrialiser.RawMode := true;
    try
      list.LoadFromFile(jsonFileName);
      prog.Caption := 'Importing Sales as JSON';
      prog.MaxValue := List.A['List'].Count + 1;
      prog.Step := 1;
      prog.Value := 1;
      prog.Message := 'Importing JSON ..';
      prog.Execute;
      json := nil;
      for x := 0 to list.A['List'].Count -1 do begin
        if not JSONDesrialiser.DatabaseConnection.InTransaction then
          JSONDesrialiser.DatabaseConnection.StartTransaction;
        try
          json := list.A['List'].Items[x].AsObject;

          Obj:= JSONDesrialiser.DeserialiseObject(json);
          if not JSONDesrialiser.IsConsistent then begin
            JSONDesrialiser.DatabaseConnection.Rollback;
            AddErr('Error populating object: ' + JSONDesrialiser.Messages.CommaText, json);
            continue;
          end;

          if Assigned(Obj) then begin
            if Obj is TSalesBase then begin
              if not TSalesBase(Obj).Save then begin
                JSONDesrialiser.DatabaseConnection.Rollback;
                AddErr('Error Saving Sale: ' + TSalesBase(Obj).ResultStatus.Messages, json);
                continue;
              end;
            end
            else begin
              JSONDesrialiser.DatabaseConnection.Rollback;
              AddErr('Error - Unknown data type: ' + obj.ClassName, json);
              continue;
            end;
          end;


          if JSONDesrialiser.DatabaseConnection.InTransaction then
            JSONDesrialiser.DatabaseConnection.Commit;
        except
          on e: exception do begin
            if JSONDesrialiser.DatabaseConnection.InTransaction then
              JSONDesrialiser.DatabaseConnection.Rollback;
            AddErr('Exception processing sale: ' + e.Message, json);
          end;

        end;

        prog.StepIt;
      end;
      prog.CloseDialog;
    finally
      if JSONDesrialiser.DatabaseConnection.InTransaction then
        JSONDesrialiser.DatabaseConnection.Rollback;
    end;

    if Assigned(errMsg) then begin
      JsonFileName := ChangeFileExt(JsonFileName,'_error.json');
      JsonToFileFormated(errList,JsonFileName);

      errMsg.Insert(0, '');
      errMsg.Insert(0, 'The following errors occured while importing the list of sales. ' +
        'The unprocessed sales have been saved into the following file:' + #13#10 + JsonFileName);
      TfrmMemoDialog.Memopopup(errMsg.Text,'Import Errors');
    end;

  finally
    list.Free;
    errList.Free;
    errMsg.Free;
    JSONDesrialiser.DatabaseConnection.Free;
    JSONDesrialiser.Free;
    prog.Free;
  end;

end;
}
function TInvoicesPrnGUI.EMailMessageText(asaleID:Integer;sl:TStringlist): String;
begin
    TSalesBase.PopulateMessageSubstituteList(aSaleID,SL);
    Result := TMailUtils.SubstituteText(AppEnv.CompanyPrefs.InvoiceMailAttachmentBodyText,sl);
end;

procedure TInvoicesPrnGUI.ExtrgrpFilters;
begin
  inherited;
    case grpExtraOptions.ItemIndex of
    0:begin
        if GroupFilterString <> '' then GroupFilterString := GroupFilterString + ' and ';
        GroupFilterString := GroupFilterString +' TransType = ' +Quotedstr('Invoice');
      end;
    1:begin
        if GroupFilterString <> '' then GroupFilterString := GroupFilterString + ' and ';
        GroupFilterString := GroupFilterString +' TransType = ' +Quotedstr('Cash Sale');
      end;
    2:begin
      end;
    end;
end;

procedure TInvoicesPrnGUI.FormCreate(Sender: TObject);
begin
  inherited;
  showcontrolhint(chkEmail , 'Preference "Utilities->Preview Email" will Let You to Preview the Email Before Sending.'+NL+
                             'Turn this Preference Off if You Don''t Need to Preview it and to Send the Email Silently.'+NL) ;
end;

procedure TInvoicesPrnGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('FundingBodyID');
end;

function TInvoicesPrnGUI.getDocumentName: string;
begin
  Result := TInvoice.Classname;
end;

function TInvoicesPrnGUI.getReportType: String;
begin
  REsult :='Invoice';
end;

function TInvoicesPrnGUI.GetReportTypeID: integer;
begin
  Result := TemplateTypeID(Qrymaintranstype.AsString);
end;

function TInvoicesPrnGUI.getSalesObj: TSales;
begin
  Result := TInvoice.create(Self);
end;

procedure TInvoicesPrnGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainTranstype.AsString;
  inherited;

end;

procedure TInvoicesPrnGUI.Printdeldocket(Sender: TObject);
var
  fPrintDoc : TBusObjPrintDoc;
  reportName:String;
begin
  inherited;
  if AppEnv.CompanyPrefs.PrintDelDocketWithInvoice then begin
    reportName:= PrintDeliverydocket( QrymainSaleID.asinTeger,QrymainclientId.asinTeger,QrymainBOID.AsString, Self , chkpreview.checked , '' );
    fPrintDoc := TBusObjPrintDoc.Create(self);
    Try
      fPrintDoc.Printdoc(DocumentName,   Qrymain.FieldByName('SaleID').AsInteger, BusObjPrintDoc.dtDelDock, Self.Classname ,PreviewToDocumentOutputType(chkpreview.checked) , reportName);
    finally
      Freeandnil(fPrintDoc);
    end;
  end;
end;

procedure TInvoicesPrnGUI.PrintExtraReports(Sender:TObject);
begin
  inherited;
  if (Sender = cmdPrint) then begin
    PrintDeldocket(Sender);
    PrintPickingslip(Sender);
  end;
end;

procedure TInvoicesPrnGUI.PrintPickingslip(Sender: TObject);
var
  reportname:String;
  fPrintDoc : TBusObjPrintDoc;
begin
  reportname := tcdatautils.GetDefaultReport(30);
  if AppEnv.CompanyPrefs.PrintPickSlipWithInvoice then
    if Saleslib.printsalesPickingslip(reportname,QrymainSaleID.asinTeger,DocumentName, self, (chkpreview.checked)) then begin
      fPrintDoc := TBusObjPrintDoc.Create(self);
      Try
        fPrintDoc.Printdoc(DocumentName ,   QrymainSaleID.asinTeger, dtPickSlip, Self.Classname , PreviewToDocumentOutputType(chkpreview.checked) , reportname);
      finally
        Freeandnil(fPrintDoc);
      end;
    end;
end;
procedure TInvoicesPrnGUI.RefreshReportstoPrint;
begin
  if not chkPrintAsOnedocument.checked then begin
    if AppEnv.CompanyPrefs.PrintDelDocketWithInvoice or
       AppEnv.CompanyPrefs.PrintPickSlipWithInvoice then begin
      Label10.Caption:= Label10.Caption + ' Invoice';
      if AppEnv.CompanyPrefs.PrintDelDocketWithInvoice then
        Label10.Caption:= Label10.Caption  + ', Delivery Docket';
      if AppEnv.CompanyPrefs.PrintPickSlipWithInvoice then
        Label10.Caption:= Label10.Caption + ', Picking Slip';
    end
    else
      Label10.Caption:= '';
  end
  else
    Label10.Caption:= '';
end;

procedure TInvoicesPrnGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymainconverted.FieldName);
end;
initialization
  RegisterClassOnce(TInvoicesPrnGUI);
end.
