unit frmpurchaseorderPrn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, wwcheckbox, emailutils,
  XMLDoc, XMLIntf, DAScript, MyScript, CustomInputBox, BusObjBase,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
 TPOIds = record
    POIds: String;
    supplierID:Integer;
    SupplierName: string;
    EmailAddress :String;
    XMLFileName :String;
    FTPAddress: string;
    FTPUserName: string;
    FTPPassword: string;
  end;

  TPurchaseOrderPrnGUI = class(TBaseListingGUI)
    qryMainPurchaseOrderID: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainPONum: TWideStringField;
    qryMainOrderDate: TDateField;
    qryMainComments: TWideStringField;
    qryMainConNote: TWideStringField;
    qryMainContact: TWideStringField;
    qryMainETADate: TDateField;
    qryMainPhone: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainWarehouseNotes: TWideStringField;
    qryMainTotalAmount: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainInvoiceDate: TDateField;
    qryMainApproved: TWideStringField;
    qryMainPaid: TWideStringField;
    qryMainPrinted: TWideStringField;
    qryMainEmailed: TWideStringField;
    chkShowNonApproved: TwwCheckBox;
    Label4: TLabel;
    Bevel1: TBevel;
    chkEmail: TCheckBox;
    Label5: TLabel;
    chkFax: TCheckBox;
    Bevel2: TBevel;
    qryMainclientID: TIntegerField;
    qryMainGlobalref: TWideStringField;
    qryMainPurchaseOrderNumber: TWideStringField;
    qryMainEmailPOXML: TWideStringField;
    qryMainSendXMLPOs: TWideStringField;
    qryMainFTPAddress: TWideStringField;
    qryMainFTPUserName: TWideStringField;
    qryMainFTPPassword: TWideStringField;
    btnImport: TDNMSpeedButton;
    qryMainIsBO: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);override;
    procedure cmdPrintClick(Sender: TObject);
    procedure btnFTPClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    ReportToPrint :String;
    ExcludeBOFromPrintinPO:Boolean;
    POIDs :Array of TPOIds;
    Doc             : IXMLDocument;
    HeaderNode: IXMLNode;
    CurNode         : IXMLNode;
    function Emailreport(sSQL:String;fsReportName:STring): boolean;
    function FaxReport(sSQL: String;fsReportName:String): boolean;
    procedure AuditTrialPrint(const Value: STring;ReportName:STring);
    procedure EMailXML;
    procedure SaveXML(const Sender: TBusObj; var Abort: Boolean);
    procedure FTPXML;
    procedure CreateHeader;
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex:Integer); Override;
    procedure SetGridColumns; Override;
    procedure DoExport;
    procedure DoFTPXML;
    procedure DoAutoSend;
    procedure DoEmailXml;
    procedure DoEmailJson;
    procedure DoImportListJson;
  public
    Procedure RefreshQuery;override;
    Function GetReportTypeID: Integer; Override;
  end;


implementation

uses AppEnvironment, tcDataUtils, CommonLib, MySQLConst, CommonDbLib, DNMLib,
  FaxObj, busobjOrders, BusObjPrintDoc, tcTypes, SystemLib, BusObjConst,
  IdFTP, URLObj, CorrespondenceObj, frmReportingOptions,
  ObjectSerialiser, JsonObject, JsonObjectUtils, BusObjCash, IntegerListObj,
  BusObjSaleBase, DbSharedObjectsObj, MemoDialog, EmailExtraUtils,
  CommonFormLib;

{$R *.dfm}

function TPurchaseOrderPrnGUI.GetReportTypeID: Integer;
begin
  result := 19;
end;

procedure TPurchaseOrderPrnGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
        if grpfilters.Itemindex = 0 then GroupFilterString := 'Printed = '+quotedstr('T')
  else  if grpfilters.Itemindex = 1 then GroupFilterString := 'Printed = '+quotedstr('F')
  else  if grpfilters.Itemindex = 2 then GroupFilterString := 'Emailed = '+quotedstr('T')
  else  if grpfilters.Itemindex = 3 then GroupFilterString := 'Emailed = '+quotedstr('F');
  inherited;
end;

procedure TPurchaseOrderPrnGUI.btnFTPClick(Sender: TObject);
var
  i: integer;
  ctr,fCtr:Integer;
  FFlag :Boolean;
  CustomersWithoutFTPDetails: string;
begin
  inherited;
  DisableForm;
  try
    CustomersWithoutFTPDetails := '';
    if Qrymain.RecordCount = 0 then Exit;
    Setlength(POIDs , 0);
    try
      Qrymain.DisableControls;
      if GrdMain.SelectedList.Count = 0 then Exit;
        for i := 0 to GrdMain.SelectedList.Count - 1 do begin
          if not Qrymain.BookmarkValid(GrdMain.SelectedList.Items[i]) then Continue;
          Qrymain.GotoBookmark(GrdMain.SelectedList.Items[i]);
          {store the SaleIDs and client email addresses to send email the xml invoices }
          if (QrymainFTPAddress.asString <> '') and (QrymainFTPUserName.asString <> '') and (QrymainFTPPassword.asString <> '') then begin
            fFlag := False;
            fctr:=0;
            for ctr := 0 to High(POIDs) do
                if POIDs[ctr].supplierId = QrymainClientID.asInteger then begin
                    fFlag := True;
                    fctr := ctr;
                End;
            if fFlag then begin
                if POIDs[fctr].POIds <> '' then POIDs[fctr].POIds := POIDs[fctr].POIds + ',';
                POIDs[fctr].POIds :=POIDs[fctr].POIds + qryMainPurchaseOrderID.asString;
            end else begin
                Setlength(POIDs , High(POIDs)+2);
                POIDs[High(POIDs)].POIds      := qryMainPurchaseOrderID.asString;
                POIDs[High(POIDs)].SupplierId   := QrymainClientID.asInteger;
                POIDs[High(POIDs)].SupplierName := qryMainCompany.AsString;
                POIDs[High(POIDs)].FTPAddress := QrymainFTPAddress.AsString;
                POIDs[High(POIDs)].FTPUserName := QrymainFTPUserName.AsString;
                POIDs[High(POIDs)].FTPPassword := QrymainFTPPassword.AsString;
            end;
          end
          else begin
            if CustomersWithoutFTPDetails <> '' then
              CustomersWithoutFTPDetails := CustomersWithoutFTPDetails + ', ';
            CustomersWithoutFTPDetails := CustomersWithoutFTPDetails + qryMainCompany.AsString;
          end;

        end;

        if CustomersWithoutFTPDetails <> '' then begin
          CommonLib.MessageDlgXP_Vista('The following suppliers do not have FTP details fully configured:' + #13#10 +
            CustomersWithoutFTPDetails,mtInformation,[mbOk],0);
          exit;
        end;


        FTPXML;

    finally
      qryMain.EnableControls;
    end;
  finally
    EnableForm;
  end;
end;

procedure TPurchaseOrderPrnGUI.btnImportClick(Sender: TObject);
begin
  inherited;
  DoImportListJson;
end;

procedure TPurchaseOrderPrnGUI.cmdExportClick(Sender: TObject);
var
  OptsForm : TfmReportingOptions;
begin
  OptsForm := TfmReportingOptions.Create(nil);
  try
    OptsForm.ActionList.AddDivider('Export');
    OptsForm.ActionList.Add('Export', 'Export List to File', DoExport, false, true); //DoExport, false, true);
    OptsForm.ActionList.Add('Auto Send', 'Auto Send Based on Options Selected', DoAutoSend, false, true);


    OptsForm.ActionList.AddDivider('Email');
    OptsForm.ActionList.Add('Email XML', 'Email Selected Items as XML', DoEmailXML, false, true);//DoEmailXML, false, true);
    OptsForm.ActionList.Add('Email JSON', 'Email Selected Items as JSON', DoEmailJSON, false, true);


    OptsForm.ActionList.AddDivider('FTP');
    OptsForm.ActionList.Add('FTP XML', 'FTP Selected Items as XML', DoFTPXML, false, true); //DoFTPXML, false, true);

    OptsForm.ShowModal;
  finally
    FreeAndNil(OptsForm);
  end;
end;

procedure TPurchaseOrderPrnGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TPurchaseGUI',0);
end;

procedure TPurchaseOrderPrnGUI.cmdPrintClick(Sender: TObject);
var
  SavedPrintDialogPref:boolean;
begin
  ExcludeBOFromPrintinPO := False;
  if (AppEnv.CompanyPrefs.ExcludeBOFromPrintinPO) then
    if MessageDlgXP_Vista('Do You Wish to Exclude the Back Ordered Items From Print?' , mtConfirmation , [mbyes, mbno] , 0 ) = mryes then
      ExcludeBOFromPrintinPO := TRue;

  if chkChooseRpt.Checked  then begin
    LoadReportTypes;
    if dlgReportSelect.Execute then begin
      ReportToPrint := dlgReportSelect.SelectedItems.Text;
      if not Empty(ReportToPrint) then begin
        ReportToPrint := TemplateNameToTemplateClassName(Trim(ReportToPrint));
      end else begin
        ReportToPrint := tcdatautils.GetDefaultReport(GetReportTypeID);
      end;
    end;
  end else begin
    ReportToPrint := tcdatautils.GetDefaultReport(GetReportTypeID);
  end;
  if ReportToPrint = '' then exit;

  IterateProcNo := 1;
  Setlength(POIDs , 0);
  try
    SavedPrintDialogPref := AppEnv.Employee.ShowPrintDialog;
    try
      PrintTemplate.UseEmployeeShowPrintDialogPref := AppEnv.Employee.ShowPrintDialog;
      IterateselectedRecords;
    finally
      AppEnv.Employee.ShowPrintDialog:= SavedPrintDialogPref;
    end;
  finally
    if (Sender = cmdprint )  then EmailXML;
  end;
end;

procedure TPurchaseOrderPrnGUI.CreateHeader;
begin
  doc.Active := true;
  doc.Version := XMLDocVersion;
  doc.Encoding := XMLDocEncoding;
  HeaderNode:= doc.AddChild(XMLDocRoot);
  HeaderNode.Attributes['DataVersion'] := getUserVersion;
end;

procedure TPurchaseOrderPrnGUI.DoAutoSend;
begin
  if grdMain.SelectedList.Count = 0 then begin
    CommonLib.MessageDlgXP_Vista('Nothing is selected in the list', mtInformation, [mbOk],0);
    exit;
  end;

  inherited cmdPrintClick(cmdPrint);
end;

procedure TPurchaseOrderPrnGUI.DoEmailJson;
var
  i: integer;
  IdList: TIntegerList;
  tmpFileName: string;
  qry: TERPQuery;
  PurchaseOrder : TPurchaseOrder;
  JSONSerialiser: TJSONSerialiser;
  list, obj: TJsonObject;
  Corres: TCorrespondenceGui;
  prog: TProgressDialog;
  lSilent, lSecret : boolean;
begin
  DisableForm;
  try
    if Qrymain.RecordCount = 0 then begin
      CommonLib.MessageDlgXP_Vista('Nothing has been selected',mtInformation,[mbOk],0);
      Exit;
    end;

    PurchaseOrder := nil;
    IdList := TIntegerList.Create;
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    list := JO;
    Corres := TCorrespondenceGui.Create;
    prog := TProgressDialog.Create(nil);
    try
      SelectedIDs('PurchaseOrderId',IdList,false);
      qry.SQL.Text := 'select * from tblpurchaseorders where PurchaseOrderId = :PurchaseOrderId';
      prog.Caption := 'Exporting Purchases as JSON';
      prog.MaxValue := IdList.Count;
      prog.Step := 1;
      prog.Value := 1;
      prog.Message := 'Exporting JSON ..';
      prog.Execute;

      tmpFileName := SystemLib.GetAppTempDir + '\Purchases_' + FormatDateTime('yyyy-mm-dd_hh-nn-ss',now) +'.json';

      for I := 0 to IdList.Count - 1 do begin
        qry.ParamByName('PurchaseOrderId').AsInteger := IdLIst[i];
        qry.Open;
        try
          PurchaseOrder := TPurchaseOrder.CreateWithSharedConn(nil);
          PurchaseOrder.Load(IdList[i]);
          JSONSerialiser:= TJSONSerialiser.Create;
          try
            obj := JSONSerialiser.SerialiseObject(PurchaseOrder);
            RemoveFields(obj,'ProductID,DepartmentID,UnitOfMeasureID,EquipmentId,CustomerEquipmentID,LastLineID,PartSpecID,ProcTreeId,RepairId,SaleLineID,SmartOrderID,SmartOrderLineID,ShipToId');
            list.A['List'].Add(obj);
          finally
            JSONSerialiser.Free;
          end;
        finally
          qry.Close;
        end;
        prog.StepIt;
      end;

      RemoveFields(list,'ID,GlobalRef');
      JsonToFileFormated(list,tmpFileName);
      prog.CloseDialog;
      Corres.Subject := 'Purchases List';
      Corres.MessageText := 'Purchases List';
      Corres.AttachmentList.Add(tmpFileName);
      if not EmailShortSendMode(lSilent, lSecret) then
        exit;
      Corres.Execute(lSilent, lSecret);

    finally
      IdList.Free;
      qryMain.EnableControls;
      DbSharedObj.ReleaseObj(qry);
      PurchaseOrder.Free;
      list.Free;
      Corres.Free;
      prog.Free;
    end;
  finally
    EnableForm;
  end;
end;

procedure TPurchaseOrderPrnGUI.DoEmailXml;
var
  i: integer;
  bm:TBookmark;
  FFlag :Boolean;
  fctr, ctr:Integer;
begin
  ExcludeBOFromPrintinPO := False;

  IterateProcNo := 1;
  Setlength(POIDs , 0);

    bm := Qrymain.GetBookmark;
    try
        if SelectedRecords > 0 then begin
          for i := 0 to SelectedRecords - 1 do
          begin
            qryMain.GoToBookmark(grdMain.SelectedList.Items[i]);
            fFlag := False;
            fctr:=0;
            for ctr := 0 to High(POIDs) do
              if POIDs[ctr].supplierID = QrymainClientID.asInteger then
              begin
                fFlag := True;
                fctr := ctr;
              End;
              if fFlag then
              begin
                if POIDs[fctr].POIds <> '' then
                  POIDs[fctr].POIds := POIDs[fctr].POIds + ',';
                  POIDs[fctr].POIds :=POIDs[fctr].POIds + QrymainPurchaseOrderID.asString;
              end
              else
              begin
                Setlength(POIDs , High(POIDs)+2);
                POIDs[High(POIDs)].POIds      := QrymainPurchaseOrderID.asString;
                POIDs[High(POIDs)].supplierID   := QrymainClientID.asInteger;
                POIDs[High(POIDs)].EmailAddress := QrymainEmailPOXML.asString;
              end;
          end;
        end;
    finally
      Qrymain.GotoBookmark(bm);
      Qrymain.FreeBookmark(bm);
    end;

    EmailXML;
end;

procedure TPurchaseOrderPrnGUI.DoExport;
begin
  inherited cmdExportClick(Self);
end;

procedure TPurchaseOrderPrnGUI.DoFTPXML;
begin
  btnFTPClick(Self);
end;

procedure TPurchaseOrderPrnGUI.DoImportListJson;
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
      prog.Caption := 'Importing Purchases as JSON';
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
            if Obj is TPurchaseOrder then begin
              if not TPurchaseOrder(Obj).Save then begin
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
            AddErr('Exception processing purchase: ' + e.Message, json);
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
      errMsg.Insert(0, 'The following errors occured while importing the list of Purchases. ' +
        'The unprocessed purchases have been saved into the following file:' + #13#10 + JsonFileName);
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

procedure TPurchaseOrderPrnGUI.SaveXML(Const Sender: TBusObj;  var Abort: Boolean);
var
    ClassNode: IXMLNode;
begin
    ClassNode := CurNode.Addchild(Sender.XMLNodeName);
    Sender.SavingXMLTofile := true;
    Sender.SaveToXMLNode(ClassNode);
end;

Procedure TPurchaseOrderPrnGUI.EMailXML;
var
    Ctr:Integer;
    Filename :String;
    fPOs:TPurchaseOrder;
    Corres: TCorrespondenceGui;
begin
    if high(POIDs) = -1  then Exit;
    fPOs :=   TPurchaseOrder.create(Self);
    try
      With fPOs do begin
          For ctr := 0 to high(POIDs) do begin
              LoadSelect('PurchaseOrderID in (' +POIDs[ctr].POIds +')');
              if count > 0 then begin
                  doc:= TXMLDocument.Create(nil);
                  Try
                      doc.Active := true;
                      doc.Version := XMLDocVersion;
                      doc.Encoding := XMLDocEncoding;
                      HeaderNode:= doc.AddChild(XMLDocRoot);
                      HeaderNode.Attributes['DataVersion'] := getUserVersion;
                      Curnode := HeaderNode.Addchild(XMLDocRequest);
                      Curnode.Attributes['OnError'] := XMLDocRequestStopError;
                      Curnode.Attributes['DataObject'] := fPOs.Classname;
                      IterateRecords(SaveXML);
                  Finally
                      Filename := SystemLib.ExeDir +'ERPPOsData_' +FormatDatetime('yyyymmddhhnnss' , now) +Trim(IntToStr(ctr)) + '.XML';
                      Doc.XML.SaveToFile(FileName);
                      POIDs[ctr].XMLFileName := FileName;
                  end;
              end;
          end;
      end;
    Finally
        FreeandNil(fPOs);
    end;
    For ctr := 0 to high(POIDs) do begin
        if POIDs[ctr].XMLFileName <> '' then begin
          Corres := TCorrespondenceGui.Create;
          try
            Corres.Subject := 'XML PO #' + POIDs[ctr].POIds ;
            Corres.RecipientList := POIDs[ctr].EmailAddress;
            Corres.MessageText := 'This XML PO(s) email has been sent to you from ' + GetCompanyName;
            if fileExists(POIDs[ctr].XMLFileName) then Corres.AttachmentList.Add(POIDs[ctr].XMLFileName);
            Corres.Execute();
            DeleteFiles(ExtractFilePath(POIDs[ctr].XMLFileName), replaceStr(POIDs[ctr].XMLFileName,SystemLib.ExeDir,''));
          finally
            Corres.Free;
          end;
      end;
    end;
End;
procedure TPurchaseOrderPrnGUI.IterateselectedRecordsCallback(  var Abort: boolean;SelIndex:Integer);
var
  ssql:String;
  fsReportname:String;
  FFlag :Boolean;
  fctr, ctr:Integer;
begin
  inherited;
  fsReportName := reporttoprint;
  if (qrymainTotalAmountInc.AsFloat < 0) then fsReportName:= 'Credit Return';
  if IterateProcNo = 1 then begin

            if (qryMainSendXMLPOs.asBoolean) and (QrymainEmailPOXML.asString <> '' ) then begin
              fFlag := False;
              fctr:=0;
              for ctr := 0 to High(POIDs) do
                  if POIDs[ctr].supplierID = QrymainClientID.asInteger then begin
                      fFlag := True;
                      fctr := ctr;
                  End;
              if fFlag then begin
                  if POIDs[fctr].POIds <> '' then POIDs[fctr].POIds := POIDs[fctr].POIds + ',';
                  POIDs[fctr].POIds :=POIDs[fctr].POIds + QrymainPurchaseOrderID.asString;
              end else begin
                  Setlength(POIDs , High(POIDs)+2);
                  POIDs[High(POIDs)].POIds      := QrymainPurchaseOrderID.asString;
                  POIDs[High(POIDs)].supplierID   := QrymainClientID.asInteger;
                  POIDs[High(POIDs)].EmailAddress := QrymainEmailPOXML.asString;
              end;
            end;


    if Sysutils.SameText(fsReportName , 'Purchase Order (Store Away)') then begin
      sSQL := ' ~|||~ WHERE PO.PurchaseOrderID = '+IntToStr(QrymainPurchaseOrderId.asInteger);
      if ExcludeBOFromPrintinPO then if QrymaintotalAmountinc.asfloat <> 0 then sSQL := sSQL +' AND ifnull(POL.shipped,0) <> 0 ';
      sSQL:= sSQL+  ' Group by  PurchaseLineId, '+
                        ' ifnull(PQABatch.Value,"") , ifnull(PQABatch.ExpiryDate,0),'+
                        ' ifnull(PBin.binnumber,""), ifnull(PBin.Binlocation,"") '+
                        ' Order by PurchaseLineId, '+
                        ' ifnull(PQABatch.Value,"") , ifnull(PQABatch.ExpiryDate,0),'+
                        ' ifnull(PBin.binnumber,""), ifnull(PBin.Binlocation,"") ';

    end else if  Assigned(StrPos(PChar(fsReportName), PChar('Purchase Order ShipTo'))) then begin
      sSQL := ' ~|||~ WHERE P.PurchaseOrderID = '+IntToStr(QrymainPurchaseOrderId.asInteger) ;
      if ExcludeBOFromPrintinPO then if QrymaintotalAmountinc.asfloat <> 0 then sSQL := sSQL +' AND ifnull(PL.shipped,0) <> 0 ';
      sSQL:= sSQL+   ' Group by PurchaseLineID ';
    end else begin
      sSQL := ' AND d2.PurchaseOrderId = '+ IntToStr(QrymainPurchaseOrderId.asInteger)  ;
      if ExcludeBOFromPrintinPO then if QrymaintotalAmountinc.asfloat <> 0 then sSQL := sSQL +' AND ifnull(d3.shipped,0) <> 0 ';
      sSQL:= sSQL+   ' Group by PurchaseLineID ';
    end;
    if chkEmail.checked then begin
      Emailreport(sSQL,fsReportName);
      AuditTrialPrint('Email',fsReportName);
    end else if  chkFax.checked then begin
      FaxReport(sSQL,fsReportName);
      AuditTrialPrint('fax',fsReportName);
    end else begin
      PrintTemplateReport(fsReportName, sSQL ,not(chkpreview.checked)  , 1);
      if chkpreview.checked then AuditTrialPrint('Preview',fsReportName) else AuditTrialPrint('print',fsReportName);
    end;
    PrintTemplate.UseEmployeeShowPrintDialogPref :=False;
  end;
end;
procedure TPurchaseOrderPrnGUI.AuditTrialPrint(const Value:STring;ReportName:STring);
var
  fPrintDoc : TBusObjPrintDoc;
  function DocumentOutputtype:TdocumentOutputtype;
  begin
    result := dotPreview;
         if SameText(Value , 'Email')   then result := dotEmail
    else if SameText(Value , 'Preview')        then result := dotPreview
    else if SameText(Value , 'Print') then result := dotPrint
    else if SameText(Value , 'Fax') then result := dotFax;
  end;
begin
  fPrintDoc := TBusObjPrintDoc.Create(self);
  Try
    fPrintDoc.Printdoc(TPurchaseOrder.classname,   QrymainPurchaseOrderID.asInteger, dtMain, Self.Classname ,DocumentOutputtype , ReportName);
  finally
    Freeandnil(fPrintDoc);
  end;
end;
procedure TPurchaseOrderPrnGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').asDatetime:= FilterDateFrom;
  qryMain.Params.ParamByName('txtto').asDateTime := FilterDateTo;

  if AppEnv.CompanyPrefs.UseApprovalLevels then begin
    if chkShowNonApproved.Checked then qryMain.Params.ParamByName('Approved').AsString := 'F'
     else qryMain.Params.ParamByName('Approved').AsString := 'T';
    (*qryMain.Params.ParamByName('EmployeeApprovalValueH').AsString :=
       FormatFloat('########0.00',tcDataUtils.GetEmployeeApprovalValueH(AppEnv.Employee.EmployeeID,'Purchase Order'));

    qryMain.Params.ParamByName('EmployeeApprovalValueL').AsString :=
     FormatFloat('########0.00',tcDataUtils.GetEmployeeApprovalValueL(AppEnv.Employee.EmployeeID,'Purchase Order'));*)
  end else begin
    (*qryMain.Params.ParamByName('EmployeeApprovalValueH').AsFloat := 0;
    qryMain.Params.ParamByName('EmployeeApprovalValueL').AsFloat := 0;*)
    qryMain.Params.ParamByName('Approved').AsString := 'F';
  end;
  //qryMain.Params.ParamByName('EnteredBy').AsString := AppEnv.Employee.EmployeeName;
  inherited;
end;
procedure TPurchaseOrderPrnGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(QrymainSendXMLPOs.FieldName);
    RemoveFieldfromGrid(QrymainEmailPOXML.FieldName);
end;

function TPurchaseOrderPrnGUI.FaxReport(sSQL:String;fsReportName:String) :boolean;
var
  Fax: TFaxObj;
  FaxNo: string;
begin
  Result := False;
  inherited;
  FaxNo := GetClientFaxNumber(QrymainClientId.asInteger);
  if Empty(FaxNo) then begin
    CommonLib.MessageDlgXP_Vista(QrymainCompany.AsString +
      ' does not have an Fax Number to Send to.' + #13 + #10 + #13 + #10 +
      'Please Review Supplier information to Add an Fax Number.', mtWarning,
      [mbOK], 0);
      Exit;
  end else begin
    label4.Visible := true;
//    label4.Caption := 'Adding to Fax Spool...';
    SaveTemplateReport(fsReportName, sSQL, TRue, 'GraphicFile','Purchase Order_' +QrymainGlobalref.asString);
    Fax := TFaxObj.Create;
    try
      Fax.NoCoverSheet := true;
      Fax.AddToFaxSpool(AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName,
        QrymainCompany.asString, FaxNo, 'Purchase Order',
        Qrymainglobalref.AsString, '',
        ExtractFilePath(ParamStr(0)) + 'IMG0001.BMP', Now());
    finally
      FreeandNil(Fax);
    end;
    label4.Visible := false;
    DeleteFiles(ExtractFilePath(ParamStr(0)), '*.BMP');
    Result := True;
  end;


end;
procedure TPurchaseOrderPrnGUI.FTPXML;
var
  Ctr:Integer;
  Filename :String;
  fPOs: TPurchaseOrder;
  ftp: TIdFTP;
  url: TURLObj;
  prog: TProgressDialog;
  fileStream: TFileStream;
begin
  if high(POIDs) = -1  then Exit;
  prog := TProgressDialog.Create(nil);
  try
    prog.Caption := 'Uploading XML to FTP Sites';
    prog.MaxValue := high(POIDs);
    prog.Step := 1;
    prog.Value := 1;
    prog.Message := 'Exporting XML ..';
    prog.Execute;
    fPOs := TPurchaseOrder.Create(self);
    try
      With fPOs do begin
          For ctr := 0 to high(POIDs) do begin
              LoadSelect('PurchaseOrderId in (' +POIDs[ctr].POIds +')');
              if count > 0 then begin
                  doc:= TXMLDocument.Create(nil);
                  Try
                      CreateHeader;
                      Curnode := HeaderNode.Addchild(XMLDocRequest);
                      Curnode.Attributes['OnError'] := XMLDocRequestStopError;
                      Curnode.Attributes['DataObject'] := fPOs.Classname;
                      IterateRecords(SaveXML);
                  Finally
                      Filename := GetAppTempDir + '\' +'TrueERP_PO_List_' +FormatDatetime('yyyymmddhhnnss' , now) +Trim(IntToStr(ctr)) + '.xml';
                      { NOTE: we use a file stream here to force xml encoding info to be written out to disk.
                              doc.SaveToFile will ommit encoding="UTF-8" as this is the default. }
                      fileStream := TFileStream.Create(FileName, fmCreate or fmOpenWrite);
                      try
                        //Doc.XML.SaveToFile(FileName);
                        Doc.SaveToStream(fileStream);
                      finally
                        fileStream.Free;
                      end;
                      POIDs[ctr].XMLFileName := FileName;
                  end;
              end;
              prog.StepIt;
          end;
      end;
    Finally
      FreeandNil(fPOs);
    end;
    prog.Message := 'Uploading ...';
    prog.Value := 1;
    ftp := TIdFTP.Create(nil);
    url := TURLObj.Create();
    try

      For ctr := 0 to high(POIDs) do begin
        if POIDs[ctr].XMLFileName <> '' then begin

          url.URL := POIDs[ctr].FTPAddress;
          ftp.Host := url.Host;
          ftp.Username := POIDs[ctr].FTPUserName;
          ftp.Password := POIDs[ctr].FTPPassword;
          try
            fileName := url.Path;
            if (fileName <> '') and (copy(fileName,Length(fileName),1) <> '/') then
              fileName := fileName + '/';
            fileName := fileName + ExtractFileName(POIDs[ctr].XMLFileName);
            ftp.Connect;
            ftp.Put(POIDs[ctr].XMLFileName,fileName);
            ftp.Disconnect;
            DeleteFiles(ExtractFilePath(POIDs[ctr].XMLFileName), replaceStr(POIDs[ctr].XMLFileName,SystemLib.ExeDir,''));
          except
            on e: exception do begin
              CommonLib.MessageDlgXP_Vista('Error sending XML Purchase Order to ' + POIDs[ctr].SupplierName +
              #13#10 + 'Error message: ' + e.Message,mtWarning,[mbOK],0);
            end;
          end;

        end;
        prog.StepIt;
      end;

    finally
      ftp.Free;
      url.Free;
    end;
  finally
    prog.Free;
  end;

end;

function TPurchaseOrderPrnGUI.Emailreport(sSQL:String;fsReportName:String) :boolean;
var
  RecipientAddress, OutGoingFileName: string;
  qryEmailedList: TERPQuery;
  TransactionID, UserID, TransactionDescription: string;
  EmailDate: TDateTime;
  Corres: TCorrespondenceGui;
  ReportAttachmentfiles:String;
  lSilent, lSecret : boolean;
begin
  Result := False;
//  label4.Caption := 'Emailing, ' + WAITMSG;
  RecipientAddress := '';
  OutGoingFileName := '';

  Corres:= TCorrespondenceGui.Create;
  try

    RecipientAddress := GetContactEmails(QrymainClientID.AsInteger,'MainContactForPO');

    lSilent := true;
    lSecret := false;
    if RecipientAddress = '' then
    begin
      if CommonLib.MessageDlgXP_Vista(Qrymain.FieldByName('Company').AsString +
        ' does not have an email address to send to.' +#13#10 + #13#10
        + 'Do you wish to load the email program anyway?',  mtConfirmation, [mbYes, mbNo], 0)  = mrNo then Exit;
      lSilent := false;
    end;

    try
      // String defined here because it is easy to change when this code is applied to
      // other forms. (ie, Quote instead of Invoice etc)
      label4.Visible := true;
      SaveTemplateReport(fsReportName, sSQL, true, 'PDF');
//        label4.Caption := 'Emailing, ' + WAITMSG;

      Corres.Subject := 'Purchase Order #' + inttostr(qryMainPurchaseOrderID.AsInteger) + ' for ' + QrymainCompany.asString;

      Corres.RecipientList := RecipientAddress;
      Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;

      OutGoingFileName := getOutGoingFileName('',' Purchase Order #' + inttoStr(QrymainPurchaseORderID.asInteger) , '.PDF');
      if not FileExists( Commonlib.TempDir  + OutGoingFileName) then begin
        copyfile(PChar( Commonlib.TempDir  + 'EmailReport.PDF'),
          PChar( Commonlib.TempDir  + OutGoingFileName), false);
      end;

      // Wait For OS Copy
      Sleep(1000);
      Application.ProcessMessages;


      if FileExists( Commonlib.TempDir  + OutGoingFileName) then
        Corres.AttachmentList.Add( Commonlib.TempDir  + OutGoingFileName);
      ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres , GetTemplate(fsReportName));
      if lSilent and not EmailShortSendMode(lSilent, lSecret) then
        exit;
      if Corres.Execute then begin

        TransactionID := Qrymain.FieldByName('PurchaseOrderNumber').AsString;
        UserID := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
        EmailDate := Now;

        // ReportType already defined at start of procedure
        TransactionDescription := GetCompanyName + ' Purchase Order #' +
          inttostr(QrymainPurchaseOrderId.asInteger) + ' for ' + QrymainCompany.AsString;
        qryEmailedList := TERPQuery.Create(nil);
        qryEmailedList.Connection := CommonDbLib.GetSharedMyDacConnection;
        try
          qryEmailedList.Sql.Clear;
          qryEmailedList.Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType, TransactionDescription) Values ("' +
            TransactionID + '","' + UserID + '", "' + FormatDateTime(MysqlDateFormat,EmailDate) + '", "Purchase Order", "' + TransactionDescription +
            '")');
          qryEmailedList.Execute;
        finally
          DeleteFiles( Commonlib.TempDir , '*.PDF');
          FreeandNil(qryEmailedList);
        end;
        Result := True;

      end;
      DeleteFiles( Commonlib.TempDir , '*.PDF');
      DeleteMultipleFiles(Commonlib.TempDir , ReportAttachmentfiles);
      label4.Visible := false;
    except
      label4.Visible := false;
    end;
  finally
    Corres.Free;
  end;
end;

initialization
  RegisterClassOnce(TPurchaseOrderPrnGUI);
end.

