unit frmPickingSlipsPrnGUI;
{$I ERP.inc}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, DNMSpeedButton, Grids, Wwdbigrd,
  Wwdbgrid, ExtCtrls, DNMPanel, Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, DB,  MemDS, ComCtrls,AdvOfficeStatusBar, BusObjPrintDoc, Shader,
  ImgList, ProgressDialog, wwradiogroup, wwclearbuttongroup;

type
  TfrmPickingSlipsPrn = class(TBaseInputGUI)
    Bevel1: TBevel;
    grd: TwwDBGrid;
    btnSelect: TDNMSpeedButton;
    btnUnselect: TDNMSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    DNMPanel1: TDNMPanel;
    Label5: TLabel;
    Label6: TLabel;
    cboFilter: TComboBox;
    edtSearch: TEdit;
    btnAddFilter: TDNMSpeedButton;
    btnExecute: TDNMSpeedButton;
    btnClear: TDNMSpeedButton;
    dtFrom: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    dtTo: TDateTimePicker;
    chkPrintFlag: TCheckBox;
    Label42: TLabel;
    qryPickSlip: TERPQuery;
    DSPickSlips: TDataSource;
    btnClose: TDNMSpeedButton;
    btnSend: TDNMSpeedButton;
    btnPreview: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    btnFax: TDNMSpeedButton;
    btnEmail: TDNMSpeedButton;
    qryPickSlipProductName: TWideStringField;
    qryPickSlipThirdColumn: TWideStringField;
    qryPickSlipSecondColumn: TWideStringField;
    qryPickSlipFirstColumn: TWideStringField;
    qryPickSlipSalesDescription: TWideStringField;
    qryPickSlipSaleID: TIntegerField;
    qryPickSlipSaleDate: TDateField;
    qryPickSlipType: TWideStringField;
    qryPickSlipShipping: TWideStringField;
    qryPickSlipComments: TWideMemoField;
    qryPickSlipPickPrintFlag: TWideStringField;
    qryPickSlipClientID: TIntegerField;
    qryPickSlipCustomerName: TWideStringField;
    qryPickSlipGlobalRef: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryPickSlipCategory: TLargeintField;
    grpFilters: TwwRadioGroup;
    qryPickSlipisCashSale: TWideStringField;
    qryPickSlipisInvoice: TWideStringField;
    qryPickSlipISSalesOrder: TWideStringField;
    qryPickSlipIsPos: TWideStringField;
    qryPickSlipISQuote: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RefreshQuery;
    procedure dtFromChange(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnUnselectClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
    procedure chkPrintFlagClick(Sender: TObject);
    procedure btnAddFilterClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure grdCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure grpFiltersClick(Sender: TObject);
  private
    { Private declarations }
    fsFilterString: string;
    flstFilter: TStringList;
    fPrintDoc :TBusObjPrintDoc;
    fsFax: boolean;
    procedure PopulateFilterCombo;
    procedure EmailPickSlip(const sFileName:string);
    procedure FaxPickSlip(const SaleID:integer);
    function GetFilterString: string;
  public
    { Public declarations }
  end;

implementation
uses
  DNMExceptions,DnMLib,
  EmailUtils,CommonDbLib, FaxObj, AppEnvironment, CommonLib, FastFuncs,
  tcDataUtils, MySQLConst, frmPrintPickingSlips, ProductQtyLib, tcTypes,
  BusObjSales, BusobjCash, busobjPOS, tcConst, CorrespondenceObj, EmailExtraUtils,
  JSONObject, PrintPickingSlipsLib;
{$R *.dfm}

procedure TfrmPickingSlipsPrn.RefreshQuery;
begin
  with qryPickSlip do begin
    if active then Close;
    SQL.clear;
    SQL.add('SELECT distinct 1 as Category,');
    SQL.add('"" as "Product Name",');
    SQL.add('"" AS "FirstColumn" ,');
    SQL.add('"" AS "SecondColumn",');
    SQL.add('"" AS "ThirdColumn" ,');
    SQL.add('"" as "Sales Description",');
    SQL.add('S.SaleID, ');
    SQL.add('S.SaleDate AS "Sale Date",');
    SQL.add('S.isCashSale,');
    SQL.add('S.isInvoice,');
    SQL.add('S.ISSalesOrder,');
    SQL.add('S.IsPos,');
    SQL.add('S.ISQuote,');
    SQL.add('CASE WHEN S.isCashSale   = "T" THEN "CashSale"');
    SQL.add('     WHEN S.isInvoice    = "T" THEN "Invoice"');
    SQL.add('     WHEN S.ISSalesOrder = "T" THEN "Sales Order"');
    SQL.add('     WHEN S.IsPos        = "T" THEN "POS Sale"');
    SQL.add('     WHEN S.ISQuote      = "T" THEN "Quote"  END AS Type,');
    SQL.add('S.Shipping,');
    SQL.add('S.ClientID, ');
    SQL.add('S.Comments , ');
    SQL.add('if(ifnull(tblPrintDocs.docId,0)=0, "F","T") PickPrintFlag,');
    SQL.add('S.CustomerName,S.GlobalRef');
    SQL.add('FROM tblparts AS P');
    SQL.add('INNER JOIN tblSalesLines AS SL ON P.PartsID = SL.ProductID and ifnull(SL.Shipped,0) <> 0');
    SQL.add('INNER JOIN tblSales AS S ON S.SaleID = SL.SaleID');
    SQL.add('left join tblPrintDocs on tblPrintDocs.docId = SL.SaleId and tblPrintDocs.DocName = "PickingSlip"');
    SQL.add('WHERE S.SaleDate Between '+ quotedStr(FormatDateTime(MysqlDateFormat , dtFrom.DateTime))+ ' and  ' + quotedStr(FormatDateTime(MysqlDateFormat , dtTo.DateTime)));
    if chkPrintFlag.Checked then SQL.add('AND ifnull(tblPrintDocs.DocId ,0) <>0')
    else SQL.add('AND ifnull(tblPrintDocs.DocId ,0) =0');
    if grpFilters.Itemindex = 1 then begin
      SQL.add('union all');
      SQL.add('SELECT distinct 2    as Category, ');
      SQL.add('PARTNAME             as "Product Name",');
      SQL.add(Firstcolumn  + '      AS "FirstColumn" ,');
      SQL.add(Secondcolumn + '      AS "SecondColumn",');
      SQL.add(Thirdcolumn  + '      AS "ThirdColumn" ,');
      SQL.add('P.PARTSDESCRIPTION   as "Sales Description",');
      SQL.add('S.SaleID, S.SaleDate AS "Sale Date",');
    SQL.add('S.isCashSale,');
    SQL.add('S.isInvoice,');
    SQL.add('S.ISSalesOrder,');
    SQL.add('S.IsPos,');
    SQL.add('S.ISQuote,');
      SQL.add('CASE WHEN S.isCashSale   = "T" THEN "CashSale"');
      SQL.add('     WHEN S.isInvoice    = "T" THEN "Invoice"');
      SQL.add('     WHEN S.ISSalesOrder = "T" THEN "Sales Order"');
      SQL.add('     WHEN S.IsPos        = "T" THEN "POS Sale"');
      SQL.add('     WHEN S.ISQuote      = "T" THEN "Quote"  END AS Type,');
      SQL.add('S.Shipping,');
      SQL.add('S.ClientID,');
      SQL.add('S.Comments,');
      SQL.add('if(ifnull(tblPrintDocs.docId,0)=0, "F","T") PickPrintFlag,');
      SQL.add('S.CustomerName,');
      SQL.add('S.GlobalRef');
      SQL.add('FROM tblparts AS P');
      SQL.add('INNER JOIN tblSalesLines AS SL ON P.PartsID = SL.ProductID and ifnull(SL.Shipped,0) <> 0');
      SQL.add('INNER JOIN tblSales AS S ON S.SaleID = SL.SaleID');
      SQL.add('left join tblPrintDocs on tblPrintDocs.docId = SL.SaleId and tblPrintDocs.DocName = "PickingSlip"');
      SQL.add('WHERE S.SaleDate Between '+ quotedStr(FormatDateTime(MysqlDateFormat , dtFrom.DateTime))+ ' and  ' + quotedStr(FormatDateTime(MysqlDateFormat , dtTo.DateTime)));
      if chkPrintFlag.Checked then SQL.add('AND ifnull(tblPrintDocs.DocId ,0) <>0')
      else SQL.add('AND ifnull(tblPrintDocs.DocId ,0) =0');
    end;
    SQL.add('ORDER BY SaleID,Category ,  Type, "Product name"');
    Open;
  end;
end;

procedure TfrmPickingSlipsPrn.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmPickingSlipsPrn.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmPickingSlipsPrn.FormCreate(Sender: TObject);
begin
  inherited;
  dtFrom.Date := Date - 7;
  dtTo.Date := Date;
  flstFilter := TStringList.Create;
  flstFilter.Sorted := true;
  flstFilter.Duplicates := dupError;
end;

procedure TfrmPickingSlipsPrn.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
      if AccessLevel <> 1 then begin
      AccessLevel := 6
    end;

    try
      inherited;
      RefreshQuery;
      PopulateFilterCombo;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmPickingSlipsPrn.PopulateFilterCombo;
var
  iIndex: integer;
  sLabel: string;
begin
  cboFilter.Sorted := false;
  cboFilter.Items.Clear;
  for iIndex := 0 to qryPickSlip.fields.Count - 1 do begin
    if (qryPickSlip.fields[iIndex].Visible) and
      ((qryPickSlip.Fields[iIndex].DataType = ftString) or
      (qryPickSlip.Fields[iIndex].DataType = ftWideString)) then begin
      sLabel :=
        grd.ColumnByName(qryPickSlip.Fields[iIndex].FieldName).DisplayLabel;
      // If this field has a Display Label then add to list.
      if sLabel <> '' then begin
        cboFilter.Items.AddObject(sLabel, qryPickSlip.Fields[iIndex]);
      end;
    end;
  end;

  cboFilter.Sorted := true;
  cboFilter.ItemIndex := 0;
end;


procedure TfrmPickingSlipsPrn.dtFromChange(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;


procedure TfrmPickingSlipsPrn.btnSelectClick(Sender: TObject);
begin
  grd.SelectedList.Clear;
  if qryPickSlip.RecordCount = 0 then Exit;
  qryPickSlip.First;
  while not qryPickSlip.Eof do begin
    if qryPickSlipCategory.asInteger = 1 then
      {$ifdef COMPILER_22_UP}
      grd.SelectedList.CurrentRowSelected:= true;
      {$else}
      grd.SelectedList.Add(qryPickSlip.GetBookmark);
      {$endif}
    qryPickSlip.Next;
  end;
  grd.Refresh;
end;

procedure TfrmPickingSlipsPrn.btnUnselectClick(Sender: TObject);
begin
  inherited;
  grd.SelectedList.Clear;
  grd.Refresh;
end;

procedure TfrmPickingSlipsPrn.btnPreviewClick(Sender: TObject);
var
  i: integer;
  sSQL: string;
  sReportToPrint: string;
  Json: TJsonObject;

  function DocumentOutputtype:TdocumentOutputtype;
  begin
    result := dotPreview;
         if Sender = btnSend then result := dotEmail
    else if Sender = btnPreview then result := dotPreview
    else if Sender = btnPrint  then result := dotPrint
    else if Sender = btnEmail  then result := dotEmail
    else if Sender = btnFax  then  result := dotFax;
  end;

begin
  DisableForm;
  try
    if qryPickSlip.RecordCount = 0 then Exit;

    try
      if not DirectoryExists(GetCurrentDir + '\PickSlipFiles') then
              if not CreateDir(GetCurrentDir + '\PickSlipFiles') then
                raise Exception.Create('Cannot create ' + GetCurrentDir + '\PickSlipFiles');

      with qryPickSlip do begin
        DisableControls;
        First;
        for i := 0 to grd.SelectedList.Count - 1 do begin
          if not qryPickSlip.BookmarkValid(grd.SelectedList.Items[i]) then Continue;

          qryPickSlip.GotoBookmark(grd.SelectedList.Items[i]);
          sReportToPrint := tcdatautils.GetDefaultReport(30); // there is only 1 picking slip report - which is taking care of all grouping with the groupfield in it
          sSQL := PrintPickingSlipsLib.SQL4PickingSlipreport(sReportToPrint,json, IntToStr(FieldByName('SaleID').AsInteger));


          fPrintDoc := TBusObjPrintDoc.Create(self);     //records printing
          Try
                 if qryPickSlipisCashSale.asBoolean     then fPrintDoc.Printdoc(TCashSale.classname   , FieldByName('SaleID').AsInteger, dtPickSlip, self.classname,DocumentOutputtype , sReportToPrint)
            else if qryPickSlipisInvoice.asBoolean      then fPrintDoc.Printdoc(TInvoice.classname    , FieldByName('SaleID').AsInteger, dtPickSlip, self.classname,DocumentOutputtype , sReportToPrint)
            else if qryPickSlipISSalesOrder.asBoolean   then fPrintDoc.Printdoc(TSalesOrder.classname , FieldByName('SaleID').AsInteger, dtPickSlip, self.classname,DocumentOutputtype , sReportToPrint)
            else if qryPickSlipISQuote.asBoolean        then fPrintDoc.Printdoc(TQuote.classname      , FieldByName('SaleID').AsInteger, dtPickSlip, self.classname,DocumentOutputtype , sReportToPrint)
            else if qryPickSlipIsPos.asBoolean          then fPrintDoc.Printdoc(TPos.classname        , FieldByName('SaleID').AsInteger, dtPickSlip, self.classname,DocumentOutputtype , sReportToPrint)
                                                        else fPrintDoc.Printdoc(TSales.classname      , FieldByName('SaleID').AsInteger, dtPickSlip, self.classname,DocumentOutputtype , sReportToPrint);
          finally
            Freeandnil(fPrintDoc);
          end;
          fsFax := false;

   //       sSQL := Format('AND d2.SaleID = %d', [SaleID]) + ' GROUP BY d2.SaleID';

          if Sender = btnSend then begin
            //"Email" Else "Fax" Else "Print"
            if not
              Empty(GetContactEmails(qryPickSlip.FieldByName('ClientID').AsInteger,'MainContactForInvoice')) then begin
              SaveTemplateReport(sReportToPrint, sSQL, True, 'PDF', 'PickSlipFiles\' + IntToStr(FieldByName('SaleID').AsInteger) + '.pdf' , json);
              EmailPickSlip('\PickSlipFiles\' + IntToStr(FieldByName('SaleID').AsInteger) + '.pdf');
            end else if not
              Empty(GetClientFaxNumber(qryPickSlip.FieldByName('ClientID').AsInteger)) then begin
              SaveTemplateReport(sReportToPrint, sSQL, True, 'GraphicFile', 'PickSlipFiles\' + IntToStr(FieldByName('SaleID').AsInteger) + '.bnp' , json);
              FaxPickSlip(FieldByName('SaleID').AsInteger);
            end else begin
              //PrintPickSlips(not AppEnv.Employee.ShowPreview,SaleID);
              fbReportSQLSupplied := true;
              PrintTemplateReport(sReportToPrint, sSQL, not(AppEnv.Employee.ShowPreview), 1, json);
            end;
          end else if Sender = btnPreview then begin
            //PrintPickSlips(False,SaleID);
            fbReportSQLSupplied:= true;
            PrintTemplateReport(sReportToPrint, sSQL, not(AppEnv.Employee.ShowPreview), 1, json);
          end else if Sender = btnPrint then begin
            //PrintPickSlips(not AppEnv.Employee.ShowPreview,SaleID);
            fbReportSQLSupplied:= true;
            PrintTemplateReport(sReportToPrint, sSQL, AppEnv.Employee.ShowPreview, 1, json);
          end else if Sender = btnEmail then begin
            SaveTemplateReport(sReportToPrint, sSQL, True, 'PDF', 'PickSlipFiles\' + IntToStr(FieldByName('SaleID').AsInteger) + '.pdf' , json);
            EmailPickSlip('\PickSlipFiles\' + IntToStr(FieldByName('SaleID').AsInteger) + '.pdf');
          end else if Sender = btnFax then begin
            SaveTemplateReport(sReportToPrint, sSQL, True, 'GraphicFile', 'PickSlipFiles\' + IntToStr(FieldByName('SaleID').AsInteger) + '.bnp' , json);
            FaxPickSlip(FieldByName('SaleID').AsInteger);
          end;

          Next;
        end;
      end;
    finally
      qryPickSlip.EnableControls;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmPickingSlipsPrn.FaxPickSlip(Const SaleID:integer);
var
  Fax: TFaxObj;
  FaxNo: string;
begin
  inherited;
  FaxNo := GetClientFaxNumber(qryPickSlip.FieldByName('ClientID').AsInteger);
  if Empty(FaxNo) then begin
    CommonLib.MessageDlgXP_Vista(qryPickSlip.FieldByName('CustomerName').AsString +
      ' does not have an Fax Number to Send to.' + #13 + #10 + #13 + #10 +
      'Please Review Customer information to Add an Fax Number.', mtWarning,
      [mbOK], 0);
  end else begin
    label4.Visible := true;
    label4.Caption := 'Adding to Fax Spool...';
    fsFax          := true;
    Fax := TFaxObj.Create;
    try
      Fax.NoCoverSheet := true;
      Fax.AddToFaxSpool(AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName,
        qryPickSlip.FieldByName('CustomerName').AsString, FaxNo, 'Picking Slip',
        qryPickSlip.FieldByName('GlobalRef').AsString, '',
        ExtractFilePath(ParamStr(0)) + 'IMG0001.BMP', Now());
    finally
      FreeandNil(Fax);
    end;
    label4.Visible := false;
    DeleteFiles(ExtractFilePath(ParamStr(0)), '*.BMP');
  end;
end;

procedure TfrmPickingSlipsPrn.EmailPickSlip(Const sFileName:string);
var
  Corres: TCorrespondenceGUI;
  f: file;
  RecipientAddress, ReportType, OutGoingFileName: string;
  qryEmailedList: TERPQuery;
  TransactionID, UserID, TransactionDescription: string;
  EmailDate: TDateTime;
  lSilent, lSecret : boolean;

begin
  Corres := TCorrespondenceGUI.Create;
  try
        // Clear all previous params/data
    label4.Caption := 'Emailing, ' + WAITMSG;
    RecipientAddress := '';
    ReportType := '';
    OutGoingFileName := '';

    RecipientAddress := GetContactEmails(qryPickSlip.FieldByName('ClientID').AsInteger,'MainContactForInvoice');

    if RecipientAddress = '' then
    begin
      if CommonLib.MessageDlgXP_Vista(qryPickSlip.FieldByName('CustomerName').AsString +
        ' does not have an email address to send to.' +#13#10+ 'Do you wish to load the email program anyway?',
        mtConfirmation, [mbYes, mbNo], 0)  = mrNo then
          Exit;
      lSilent := false;
    end
    else
      lSilent := true;

    try
      ReportType := 'Picking Slip';

      label4.Visible := true;

      label4.Caption := 'Emailing, ' + WAITMSG;

      Corres.Subject := ReportType + ' #' +
        qryPickSlip.FieldByName('SaleID').AsString + ' for ' + qryPickSlip.FieldByName('CustomerName').AsString;

      Corres.RecipientList := RecipientAddress;
      Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;

      OutGoingFileName := getOutGoingFileName('', ' ' + ReportType + ' #' + qryPickSlip.FieldByName('SaleID').AsString , '.PDF');
      AssignFile(f,  Commonlib.TempDir  + sFileName);

      if not FileExists( Commonlib.TempDir  + OutGoingFileName) then begin
        copyfile(PChar( Commonlib.TempDir  + sFileName),
          PChar( Commonlib.TempDir  + OutGoingFileName), false);
      end;

      Corres.AttachmentList.Add(Commonlib.TempDir  + OutGoingFileName);
      lSecret := false;
      if lSilent and not EmailShortSendMode(lSilent, lSecret) then
        exit;

      if Corres.Execute(lSilent, lSecret) then
      begin
        TransactionID := qryPickSlip.FieldByName('SaleID').AsString;
        UserID := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
        EmailDate := Now;

        // ReportType already defined at start of procedure
        TransactionDescription := GetCompanyName + ' ' + ReportType + ' #' +
          qryPickSlip.FieldByName('SaleID').AsString + ' for ' + qryPickSlip.FieldByName('CustomerName').AsString;
        qryEmailedList := TERPQuery.Create(nil);
        qryEmailedList.Connection := CommonDbLib.GetSharedMyDacConnection;
        try
          qryEmailedList.Sql.Clear;
          qryEmailedList.Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType, EmailAddressUsed,TransactionDescription) Values ("' +
            TransactionID + '","' + UserID + '", "' + FormatDateTime(MysqlDateFormat,
            EmailDate) + '", "' + ReportType + '", "' + RecipientAddress + '", "' + TransactionDescription +
            '")');
          qryEmailedList.Execute;
        finally
          DeleteFiles( Commonlib.TempDir , '*.PDF');
          FreeandNil(qryEmailedList);
        end;
      end;
      label4.Visible := false;
    except
      label4.Visible := false;
    end;
  finally
    DeleteFiles( Commonlib.TempDir , '*.PDF');
    FreeAndNil(Corres);
  end;
end;

procedure TfrmPickingSlipsPrn.btnEmailClick(Sender: TObject);
var
  sSQL : string;
  i: integer;
  reportname :String;
  Json: TJsonObject;
begin
  inherited;
    if qryPickSlip.RecordCount = 0 then Exit;
  try
    with qryPickSlip do begin
      DisableControls;
      First;
      for i := 0 to grd.SelectedList.Count - 1 do begin
        if not qryPickSlip.BookmarkValid(grd.SelectedList.Items[i]) then Continue;
        qryPickSlip.GotoBookmark(grd.SelectedList.Items[i]);
        reportname  := tcdatautils.GetDefaultReport(30);
        ssql:= PrintPickingSlipsLib.SQL4PickingSlipreport(reportname,json, IntToStr(qryPickSlipSaleID.asInteger), '');
        PrintTemplateReport(reportname, sSQL, not AppEnv.Employee.ShowPreview, 1 , json);

        Next;
      end;
    end;
  finally
    qryPickSlip.EnableControls;
  end;
end;

procedure TfrmPickingSlipsPrn.chkPrintFlagClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfrmPickingSlipsPrn.btnAddFilterClick(Sender: TObject);
begin
  inherited;
    try
    flstFilter.Add('[' + grd.GetActiveField.FieldName + ']=' +
      QuotedStr(grd.GetActiveField.AsString));
  except
    on e: EStringListError do begin
      {raise Exception.Create('The value you are trying to add is already in your filter list. ' +
                             'Please try again.');}
      CommonLib.MessageDlgXP_Vista('The value you are trying to add is already in your filter list. ' +
        'Please try again.', mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TfrmPickingSlipsPrn.btnExecuteClick(Sender: TObject);
var
  sTemp: string;
begin
  inherited;
  try
    if not Empty(fsFilterString) then begin
      sTemp := ' AND ';
    end;
    qryPickSlip.Filter   := fsFilterString + sTemp + GetFilterString;
    qryPickSlip.Filtered := true;
  except
    on e: Exception do begin
      raise Exception.Create(e.Message + Chr(13) +
        'Please review your filter and try again.' + Chr(13) + 'Filter : ' +
        qryPickSlip.Filter);
    end;
  end;
end;

procedure TfrmPickingSlipsPrn.btnClearClick(Sender: TObject);
begin
  inherited;
  flstFilter.Clear;
  if Empty(fsFilterString) then begin
    qryPickSlip.Filtered := false;
  end else begin
    qryPickSlip.Filter := fsFilterString;
  end;
end;

function TfrmPickingSlipsPrn.GetFilterString: string;
var
  iIndex: integer;
begin
  for iIndex := 0 to flstFilter.Count - 1 do begin
    Result := Result + flstFilter.Strings[iIndex] + ' OR ' + Chr(13);
  end;
  Result := Copy(Result, 0, char_length(Result) - 5);
end;

procedure TfrmPickingSlipsPrn.grdCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
  function isDetailField:Boolean;
  begin
      REsult := (Sysutils.SameText(Field.fieldName , 'Product Name')) or
                (Sysutils.SameText(Field.fieldName , 'ThirdColumn')) or
                (Sysutils.SameText(Field.fieldName , 'SecondColumn' )) or
                (Sysutils.SameText(Field.fieldName , 'FirstColumn')) or
                (Sysutils.SameText(Field.fieldName , 'Type')) or
                (Sysutils.SameText(Field.fieldName , 'Sales Description'));
  end;
begin
  inherited;
  if qryPickSlipCategory.asInteger = 1 then begin
    if isDetailField then Afont.Color := ABrush.Color
    else AFont.Style := AFont.Style + [fsBold];
  end else begin
    if not (isDetailField) then Afont.Color := ABrush.Color;
  end;
end;

procedure TfrmPickingSlipsPrn.grdMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  Accept := qryPickSlipCategory.asInteger=1; 
end;

procedure TfrmPickingSlipsPrn.grpFiltersClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

initialization
  RegisterClassOnce(TfrmPickingSlipsPrn);
end.

