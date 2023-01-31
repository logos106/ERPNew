unit frmIntrastatDeclarationFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DNMSpeedButton, Menus, AdvMenus, DataState, DB,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, Shader, DNMPanel, Grids, Wwdbigrd, Wwdbgrid, MemDS, Mask,
  wwdbedit, Wwdotdot, Wwdbcomb,BusObjIntrastats, wwcheckbox,
  wwdbdatetimepicker,BusObjBase, wwdblook, Buttons, ImgList, ProgressDialog;

type TRec = class(TObject)
  private
  public
   TraderRef:String;
   LineID:Integer;
   DeliveryTerms:String ;
   TransactionNature:String;
end;


type
  TfrmIntrastatDeclaration = class(TBaseInputGUI)
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnOK: TDNMSpeedButton;
    cboType: TwwDBComboBox;
    DSIntrastats: TDataSource;
    qryIntrastats: TERPQuery;
    qryIntrastatsIntrastatID: TIntegerField;
    qryIntrastatsIntrastatType: TWideStringField;
    qryIntrastatsIsSubmitted: TWideStringField;
    qryIntrastatLines: TERPQuery;
    qryIntrastatLinesIntrastatID: TIntegerField;
    qryIntrastatLinesCommodityCode: TWideStringField;
    qryIntrastatLinesValue: TFloatField;
    qryIntrastatLinesDeliveryTerms: TWideStringField;
    qryIntrastatLinesTransactionNature: TWideStringField;
    qryIntrastatLinesSupplementaryUnit: TWideStringField;
    qryIntrastatLinesCountry: TWideStringField;
    qryIntrastatLinesTraderRef: TWideStringField;
    DSIntrastatLines: TDataSource;
    qryIntrastatLinesIntrastatLineID: TIntegerField;
    cboSubmitDate: TwwDBDateTimePicker;
    chkSubmitted: TwwCheckBox;
    DNMPanel1: TDNMPanel;
    grdLines: TwwDBGrid;
    DNMPanel2: TDNMPanel;
    Label1: TLabel;
    Label2: TLabel;
    qryEuCountries: TERPQuery;
    cboCountries: TwwDBLookupCombo;
    btnPrint: TDNMSpeedButton;
    btnLoadInvoiceLines: TDNMSpeedButton;
    qryInvoicelines: TERPQuery;
    cboDeliveryTerms: TwwDBComboBox;
    btnLoadPOs: TDNMSpeedButton;
    cboMonth: TwwDBComboBox;
    qryIntrastatsGlobalRef: TWideStringField;
    qryIntrastatsSubmittedDate: TDateField;
    qryIntrastatsMonth: TWideStringField;
    Label3: TLabel;
    edIntrastatID: TwwDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    edYear: TwwDBEdit;
    qryIntrastatsYear: TIntegerField;
    qryPOs: TERPQuery;
    qryPOLines: TERPQuery;
    DSPOLines: TDataSource;
    qryPOLinesPurchaseOrderID: TIntegerField;
    qryPOLinesProductID: TIntegerField;
    qryPOLinesTotalLineAmount: TFloatField;
    qryPOLinesPurchaseOrderID_1: TIntegerField;
    qryPOLinesIsPO: TWideStringField;
    qryPOLinesPurchaseOrderNumber: TWideStringField;
    qryPOLinesClientID: TIntegerField;
    qryPOLinesIncludeOnIntrastat: TWideStringField;
    qryPOLinesPartsID: TIntegerField;
    qryPOLinesCommodityCode: TWideStringField;
    qryPOLinesReceivedDate: TDateField;
    qryPOLinesShipped: TFloatField;
    qryIntrastatLinesGlobalRef: TWideStringField;
    qryIntrastatLinesNetMass: TIntegerField;
    qryIntrastatLinesProductID: TIntegerField;
    grdLinesButton: TwwIButton;
    cboProductID: TwwDBLookupCombo;
    qryProducts: TERPQuery;
    qryProductsPartsId: TIntegerField;
    qryProductsPartName: TWideStringField;
    qryProductsActive: TWideStringField;
    qryIntrastatLinesProductName: TWideStringField;
    qryPOLinesNetWeight: TFloatField;
    pnlPrint: TDNMPanel;
    chkPreview: TwwCheckBox;
    qryPOLinesCountry: TWideStringField;
    qryPOLinesCompany: TWideStringField;
    qryInvoicelinesSaleID: TIntegerField;
    qryInvoicelinesProductID: TIntegerField;
    qryInvoicelinesTotalLineAmount: TFloatField;
    qryInvoicelinesSaleID_1: TIntegerField;
    qryInvoicelinesIsInvoice: TWideStringField;
    qryInvoicelinesInvoiceDocNumber: TWideStringField;
    qryInvoicelinesClientID: TIntegerField;
    qryInvoicelinesIncludeOnIntrastat: TWideStringField;
    qryInvoicelinesPartsID: TIntegerField;
    qryInvoicelinesCommodityCode: TWideStringField;
    qryInvoicelinesQtySold: TFloatField;
    qryInvoicelinesShipDate: TDateField;
    qryInvoicelinesNetWeight: TFloatField;
    qryInvoicelinesCountry: TWideStringField;
    qryInvoicelinesSaleLineId: TIntegerField;
    qryIntrastatLinesInvoiceOrPOLineID: TIntegerField;
    qryPOLinesPurchaseLineID: TIntegerField;
    btnElectronic: TDNMSpeedButton;
    qryIntrastatsmsTimeStamp: TDateTimeField;
    qryIntrastatsmsUpdateSiteCode: TWideStringField;
    qryIntrastatLinesmsTimeStamp: TDateTimeField;
    qryIntrastatLinesmsUpdateSiteCode: TWideStringField;
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnLoadInvoiceLinesClick(Sender: TObject);
    procedure cboTypeCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure edYearChange(Sender: TObject);
    procedure cboMonthCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure btnLoadPOsClick(Sender: TObject);
    procedure cboSubmitDateCloseUp(Sender: TObject);
    procedure grdLinesButtonClick(Sender: TObject);
    procedure cboProductIDCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdLinesDblClick(Sender: TObject);
    procedure cboProductIDDblClick(Sender: TObject);
    procedure btnElectronicClick(Sender: TObject);
  private
    fEditingExistingDec: Boolean;
    fFrom,fTo : TDateTime;
    Intrastat:Tintrastats;
    procedure ShowInvoiceOrPO;
    function ValidateDeclaration:Boolean;
    procedure HandleMissingDataErrors;
    procedure SetButtons;
    procedure ResetQrySalesLines;
    procedure ResetQryPOLines;
    procedure SetDates;
    Function DeclarationExits(const sMonth:String; const iYear:integer; const sType:String):Boolean;
    Function GetExistingDeclarationID(const sMonth,sYear,sType:String):integer;
    procedure LoadExistingDeclaration;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    
  end;

implementation

{$R *.dfm}
uses
  BusObjConst,BusObjIntrastatLines,CommonLib,FormFactory,DateUtils,DNMLib,CommonDbLib,
  frmInvoice,frmPurchaseOrders,ReportTemplates,tcDataUtils, FastFuncs,AppEnvironment{,
  frmVATElectronicFrm};

procedure TfrmIntrastatDeclaration.btnCancelClick(Sender: TObject);
begin
  inherited;
  MyConnection.Rollback;
  close;
end;

procedure TfrmIntrastatDeclaration.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if fsModal in FormState then
    ModalResult := mrCancel
  else
    Action := caFree;
end;

procedure TfrmIntrastatDeclaration.FormCreate(Sender: TObject);
begin
  inherited;
  Intrastat := Tintrastats.Create(Self);
end;

procedure TfrmIntrastatDeclaration.FormShow(Sender: TObject);
var
  ADay,AMonth,AYear:word;
begin
  DisableForm;
  try
    inherited;
    MyConnection.StartTransaction;
    qryEuCountries.Open;
    qryProducts.Open;
    Intrastat.BusObjEvent                 := DoBusinessObjectEvent;
    Intrastat.IntrastatLines.BusObjEvent  := DoBusinessObjectEvent;

    if Self.KeyID <> 0 then begin
      Intrastat.Load(Self.KeyID);
      fEditingExistingDec := True;
      btnLoadPOs.caption := 'Refresh';
      btnLoadInvoiceLines.caption :=  'Refresh';
      cboType.Enabled  := False;
      cboMonth.Enabled := False;
      edYear.Enabled   := False;
    end else begin
      Intrastat.Load(0);
      Intrastat.New;
      Intrastat.PostDb;
      KeyID := Intrastat.Id;
      Intrastat.Load(KeyID);

      DecodeDate(Now, AYear, AMonth, ADay);
      Intrastat.Year := AYear;
      Intrastat.Month := GetMonthName(AMonth);
    end;
    SetButtons;
    SetDates;
  finally
    EnableForm;
  end;  
end;

procedure TfrmIntrastatDeclaration.SetButtons;
begin
  if cboType.Text = 'Arrivals' then begin
    btnLoadPOs.Enabled          := True;
    btnLoadInvoiceLines.Enabled := False;
    btnLoadPOs.Visible          := True;
    btnLoadInvoiceLines.Visible := False;
  end else begin
    btnLoadPOs.Enabled          := False;
    btnLoadInvoiceLines.Enabled := True;
    btnLoadPOs.Visible          := False;
    btnLoadInvoiceLines.Visible := True;
  end;
  if AppEnv.CompanyPrefs.UseElectronicIntrastat then begin
    btnElectronic.Visible := True;
    pnlPrint.Left               := 584;
    btnOK.Left                  := 158;
    btnLoadPOs.Left             := 296;
    btnLoadInvoiceLines.Left    := 296;
    btnPrint.Left               := 611;
    btnCancel.Left              := 754;

  end else begin
    pnlPrint.Left               := 520;
    btnOK.Left                  := 207;
    btnLoadPOs.Left             := 374;
    btnLoadInvoiceLines.Left    := 374;
    btnPrint.Left               := 541;
    btnCancel.Left              := 709;
  end;
end;

procedure TfrmIntrastatDeclaration.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TIntrastats then TIntrastats(Sender).Dataset             := qryIntrastats
        else if Sender is TIntrastatLines then TIntrastatLines(Sender).Dataset  := qryIntrastatLines;
    end;
end;

procedure TfrmIntrastatDeclaration.btnOKClick(Sender: TObject);
begin
  inherited;
  if not ValidateDeclaration then begin
    HandleMissingDataErrors;
    exit;
  end;
  Intrastat.PostDb;
  Intrastat.IntrastatLines.PostDb;

  if not Intrastat.ValidateData then exit;

  Intrastat.IntrastatLines.Dataset.First;
  While not Intrastat.IntrastatLines.Dataset.Eof do begin
    if not Intrastat.IntrastatLines.ValidateData then exit;
    Intrastat.IntrastatLines.Dataset.Next;
  end;
    
  CommitTransaction;

  if fsModal in FormState then
    ModalResult := mrOK
  else
    Release;
end;

function TfrmIntrastatDeclaration.ValidateDeclaration:Boolean;
begin
   //stub
   Result := True;
end;

procedure TfrmIntrastatDeclaration.HandleMissingDataErrors;
begin
  //stub
end;

procedure TfrmIntrastatDeclaration.btnPrintClick(Sender: TObject); { TODO -orobin : fix printing landscape problem }
var
  sSQL,sCount,sALLSQL,ReportTemplateName,PipeName,sCountDigit1   :string;
  sCountDigit2,sCountDigit3     :string;
 // PrintTemplate         :TPrintTemplates;
  RTemplates            :TReportTemplates;

  iSQLcounter,iLines    :integer;
  TempMyqry             :TERPQuery;
begin
  DisableForm;
  try
    inherited;
    if not AppEnv.CompanyPrefs.UseElectronicIntrastat then Intrastat.SubmittedDate := Date;
    Intrastat.PostDb;
    Intrastat.IntrastatLines.PostDb;

    iLines := qryIntrastatLines.RecordCount;
    sCount := IntToStr(iLines);
    if iLines < 10 then sCount := Concat('0','0',sCount);
    if (iLines > 9) and (iLines < 100) then sCount := Concat('0',sCount);
    sCountDigit1 := Copy(sCount,1,1);
    sCountDigit2 := Copy(sCount,2,1);
    sCountDigit3 := Copy(sCount,3,1);

    RTemplates := TReportTemplates.Create;
    if not RTemplates.CreatedOk then exit;
    RTemplates.MyConnection :=  Self.MyConnection;

    sSQL := 'SELECT CO.CompanyName,IL.CommodityCode,CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode,' +
            'Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber,' +
            'CO.ABN,IL.Value,IL.DeliveryTerms,IL.TransactionNature,IL.NetMass,IL.SupplementaryUnit,IL.Country,' +
            'IL.TraderRef ,I.IntrastatType,IL.IntrastatLineID,' +

            'CASE i.MONTH  ' +
            '   WHEN  "January" THEN 1 ' +
            '   WHEN "February" THEN 2 ' +
            '   WHEN "March" THEN 3 ' +
            '   WHEN "April" THEN 4 ' +
            '   WHEN "May" THEN 5 ' +
            '   WHEN "June" THEN 6 ' +
            '   WHEN "July" THEN 7 ' +
            '   WHEN "August" THEN 8 ' +
            '   WHEN "September" THEN 9 ' +
            '   WHEN "October" THEN 0 ' +
            '   WHEN "November" THEN 1 ' +
            '   WHEN "December" THEN 2 ' +
            'END As MonthDigit2, ' +

            'CASE i.MONTH ' +
            '   WHEN "January" THEN 0 ' +
            '   WHEN "February" THEN 0 ' +
            '   WHEN "March" THEN 0 ' +
            '   WHEN "April" THEN 0 ' +
            '   WHEN "May" THEN 0 ' +
            '   WHEN "June" THEN 0 ' +
            '   WHEN "July" THEN 0 ' +
            '   WHEN "August" THEN 0 ' +
            '   WHEN "September" THEN 0 ' +
            '   WHEN "October" THEN 1 ' +
            '   WHEN "November" THEN 1 ' +
            '   WHEN "December" THEN 1 ' +
            'END As MonthDigit1, ' +

            'Left(Right( Format(I.Year,0 ),2),1) as YearDigit1 , ' +
            'Mid( Right( Format(I.Year,0 ),2),2,1)    As YearDigit2, ' +

            'Mid(  CommodityCode,1,1)    As CC1, ' +
            'Mid(  CommodityCode,2,1)    As CC2, ' +
            'Mid(  CommodityCode,3,1)    As CC3, ' +
            'Mid(  CommodityCode,4,1)    As CC4, ' +
            'Mid(  CommodityCode,5,1)    As CC5, ' +
            'Mid(  CommodityCode,6,1)    As CC6, ' +
            'Mid(  CommodityCode,7,1)    As CC7, ' +
            'Mid(  CommodityCode,8,1)    As CC8 ' +

            'FROM tblCompanyInformation AS CO ' +
            'JOIN tblintrastats I ' +
            'INNER JOIN tblintrastatlines IL ON I.IntrastatID = IL.IntrastatID ' +
            ' WHERE I.Month = ' + QuotedStr(cboMonth.Text) + ' AND I.Year = ' + edYear.Text +
            ' AND I.IntrastatType = ' + QuotedStr(cboType.Text);

    sCount := 'select count(*), ' + sCountDigit1  + ' As CountDigit1,' +
              sCountDigit2 + ' As CountDigit2,' + sCountDigit3 + ' As CountDigit3   From tblintrastats I ' +
              'INNER JOIN tblintrastatlines IL ON I.IntrastatID = IL.IntrastatID';

    try
      with RTemplates do begin
        ReportTemplateName := 'Intrastat';
        sALLSQL := sSQL+'~|||~'+sCount;

        GetSQLForReport('Intrastat'); // creates  report stream

        try
          for iSQLcounter := 1 to GetSQLCount(ReportTemplateName) do begin
            TempMyqry := GetMyQuery(iSQLcounter );

            if (TempMyqry=nil) then
              Continue;

            TempMyqry.Close;
            TempMyqry.Sql.Clear;
            TempMyqry.Sql.Text := ExtractStrPortion(sALLSQL,'~|||~',iSQLcounter);
            PipeName :=Trim(ExtractStrPortion(ReplaceStr(TempMyqry.Sql.Text, '{', ''), '}', 0));

            if (Trim(TempMyqry.Sql.Text)<>PipeName) then begin
              RTemplates.PipelineUserName[iSQLcounter] := PipeName;
              TempMyqry.Sql.Text := ReplaceStr(TempMyqry.Sql.Text, '{' + PipeName + '}', '');
            end;
            TempMyqry.Open;
          end;
        except

        end;

        ReportStream.Position := 0;
        Report.Template.LoadFromStream(ReportStream);
        Report.ShowPrintDialog := false;

        Report.DeviceType := 'Screen';
        if not chkPreview.checked then begin
          Report.DeviceType := 'Printer';
        end;

        Report.PrinterSetup.Copies := 1;
        Try
          Report.Print;
        except
          on E: Exception do begin
            If Sysutils.SameText(E.Message,'Screen printer does not support printing') then begin
              CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
            end else
              raise;
          end;
        end;

      end;
    finally
      FreeAndNil(RTemplates);
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmIntrastatDeclaration.ResetQrySalesLines;
begin
  if qryInvoiceLines.Active then qryInvoiceLines.Close;
   qryInvoiceLines.Params.ParamByName('xFrom').AsDateTime := fFrom;
   qryInvoiceLines.Params.ParamByName('xTo').AsDateTime := fTo;
end;

procedure TfrmIntrastatDeclaration.ResetQryPOLines;
begin
  if qryPOLines.Active then qryPOLines.Close;
   qryPOLines.Params.ParamByName('xFrom').AsDateTime := fFrom;
   qryPOLines.Params.ParamByName('xTo').AsDateTime := fTo;
end;

Function TfrmIntrastatDeclaration.DeclarationExits(const sMonth:String; const iYear:Integer; const sType:String):Boolean;
var
  qry:TERPQuery;
begin
  Result := False;
  if fEditingExistingDec then exit;

  (*qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;*)
  Qry := commonDBlib.TempMyQuery;
  try
    qry.SQL.Clear;
    qry.SQL.Add('Select IntrastatID,Month,IntrastatType FROM tblIntrastats ' +
      'WHERE Month = ' + QuotedStr(sMonth) + ' AND Year = ' + IntToStr(iYear) + ' AND IntrastatType = ' + QuotedStr(sType) + ';');
    qry.Open;
    if not qry.IsEmpty then begin
      if (qry.RecordCount > 0) then Result := True;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

Function TfrmIntrastatDeclaration.GetExistingDeclarationID(const sMonth:String;const sYear:String;const sType:String):integer;
var
  qry:TERPQuery;
begin
  Result := 0;
  (*qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;*)
  qry := commonDBlib.TempMyQuery;
  try
    qry.SQL.Clear;
    qry.SQL.Add('Select IntrastatID,Month,Year,IntrastatType FROM tblIntrastats ' +
      'WHERE Month = ' + QuotedStr(sMonth) + ' AND Year = ' + sYear +
      ' AND IntrastatType = ' + QuotedStr(sType));
    qry.Open;
    if not qry.IsEmpty then begin
      Result := qry.fieldByName('IntrastatID').AsInteger;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TfrmIntrastatDeclaration.LoadExistingDeclaration;
var
  iTmpDeclarationID:integer;
begin
  iTmpDeclarationID := GetExistingDeclarationID(cboMonth.Text,edYear.Text,cboType.Text);
  Intrastat.Delete;  //delete the exiting empty intrastat
  Intrastat.Load(iTmpDeclarationID);
  fEditingExistingDec := True;
  btnLoadPOs.caption := 'Refresh';
  btnLoadInvoiceLines.caption := 'Refresh';
  cboType.Enabled  := False;
  cboMonth.Enabled := False;
  edYear.Enabled   := False;
end;

procedure TfrmIntrastatDeclaration.btnLoadInvoiceLinesClick(
  Sender: TObject);
var
  tmpRec: TRec;
  RecList: TList;
  i:integer;
begin
  inherited;
  if fEditingExistingDec = False then begin
    if DeclarationExits(cboMonth.Text,Intrastat.Year,cboType.Text) then begin
      case CommonLib.MessageDlgXP_Vista('An Intrastat Declaration already exists for this month. Would you like to edit it?', mtWarning, [mbYes, mbNo], 0) of
        mrYes:
          begin
            LoadExistingDeclaration;
            exit;
          end;
        mrNo:
          begin
            exit;
          end;
      end;
    end;
  end;
   //store manually entered data into a temp stringlist
  RecList := TList.Create; 
  try
    with Intrastat.IntrastatLines.Dataset do begin
       Intrastat.IntrastatLines.First;
       while not Intrastat.IntrastatLines.Eof do begin
         tmpRec := TRec.Create;
         tmpRec.TraderRef := Intrastat.IntrastatLines.traderRef;
         tmpRec.LineID := Intrastat.IntrastatLines.InvoiceOrPOLineID;
         tmpRec.DeliveryTerms := Intrastat.IntrastatLines.DeliveryTerms;
         tmpRec.TransactionNature := Intrastat.IntrastatLines.TransactionNature;
         RecList.Add(tmpRec);

         Intrastat.IntrastatLines.Next;
       end;
     end;

    btnLoadInvoiceLines.caption := 'Refresh';
     //delete busobj dataset recs
    with Intrastat.IntrastatLines.Dataset do begin
      First;
      while not Eof do begin
        Delete;
      end;
    end;

    ResetQrySalesLines;

    With qryInvoiceLines do begin
      Open;
      First;
      while not Eof do begin
        Intrastat.IntrastatLines.New;
        Intrastat.IntrastatLines.CommodityCode     := FieldByName('CommodityCode').AsString;
        Intrastat.IntrastatLines.ProductID         := FieldByName('ProductID').AsInteger;
        Intrastat.IntrastatLines.Value             := System.Round(FieldByName('TotalLineAmount').AsFloat); { TODO -orobin : Round up }
      //   Intrastat.IntrastatLines.DeliveryTerms      := FieldByName('
       //  Intrastat.IntrastatLines.TransactionNature := FieldByName('
        Intrastat.IntrastatLines.InvoiceOrPOLineID := FieldByName('SaleLineID').AsInteger;
        Intrastat.IntrastatLines.NetMass           := Trunc(FieldByName('NetWeight').AsFloat);
        Intrastat.IntrastatLines.SupplementaryUnit := FormatFloat('#0',FieldByName('QtySold').AsFloat);
        if IsEUCountry(FieldByName('Country').AsString) then
          Intrastat.IntrastatLines.Country           := FieldByName('Country').AsString
        else CommonLib.MessageDlgXP_Vista(FieldByName('Company').AsString + ' Country,' + FieldByName('Country').AsString + ',is not an EU country!', mtWarning, [mbOK], 0);
        Intrastat.IntrastatLines.TraderRef         := FieldByName('InvoiceDocNumber').AsString;
        Intrastat.IntrastatLines.PostDb;
        Next;
      end;
    end;

     // go thru the temp stringlist and add re-instate manually enered data
    for i := 0 to RecList.Count - 1 do begin
      if Intrastat.IntrastatLines.Dataset.Locate('InvoiceOrPOLineID',TRec(RecList[i]).LineID, [loCaseInsensitive]) then begin
        Intrastat.IntrastatLines.DeliveryTerms := TRec(RecList[i]).DeliveryTerms;
        Intrastat.IntrastatLines.TransactionNature := TRec(RecList[i]).TransactionNature;
        Intrastat.IntrastatLines.PostDb;
      end;
    end;
  finally
     //empty List
    while RecList.Count > 0 do begin
      TRec(RecList[0]).Free;
      RecList.Delete(0);
    end;

    FreeAndNil(RecList);
  end;
end;

procedure TfrmIntrastatDeclaration.cboTypeCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;
  //fEditingExistingDec := false;
  if DeclarationExits(cboMonth.Text,Intrastat.Year,cboType.Text) then begin
    case CommonLib.MessageDlgXP_Vista('An Intrastat Declaration already exists for this month. Would you like to edit it?', mtWarning, [mbYes, mbNo], 0) of
      mrYes:
        begin
          LoadExistingDeclaration;
          exit;
        end;
      mrNo:
        begin
          exit;
        end;
    end;
  end;

  SetButtons;
end;

procedure TfrmIntrastatDeclaration.SetDates;
var
  wYear,wMonth: Word;
begin
  if cboMonth.Text = '' then exit;
  wMonth := GetMonthNo(cboMonth.Text);
  wYear := Intrastat.Year;
  fFrom := StartOfAMonth(wYear,wMonth); 
  fTo   := EndOfAMonth(wYear,wMonth) + 1;  //the + 1 is a workaround for a mysql 'BETWEEN' bug
end;

procedure TfrmIntrastatDeclaration.edYearChange(Sender: TObject);
begin
  inherited;
  if Intrastat.Month <> '' then SetDates;  
end;

procedure TfrmIntrastatDeclaration.cboMonthCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;
  if DeclarationExits(cboMonth.Text,Intrastat.Year,cboType.Text) then begin
    case CommonLib.MessageDlgXP_Vista('An Intrastat Declaration already exists for this month. Would you like to edit it?', mtWarning, [mbYes, mbNo], 0) of
      mrYes:
        begin
          LoadExistingDeclaration;
          exit;
        end;
      mrNo:
        begin
          exit;
        end;
    end;
  end;
  SetDates;
  if btnLoadInvoiceLines.Enabled then btnLoadInvoiceLines.Click;
  if btnLoadPOs.Enabled then btnLoadPOs.Click;
end;

procedure TfrmIntrastatDeclaration.btnLoadPOsClick(Sender: TObject);
var
  tmpRec: TRec;
  RecList: TList;
  i:integer;
begin
  inherited;
  if fEditingExistingDec = False then begin
    if DeclarationExits(cboMonth.Text,Intrastat.Year,cboType.Text) then begin
      case CommonLib.MessageDlgXP_Vista('An Intrastat Declaration already exists for this month. Would you like to edit it?', mtWarning, [mbYes, mbNo], 0) of
        mrYes:
          begin
            LoadExistingDeclaration;
            exit;
          end;
        mrNo:
          begin
            exit;
          end;
      end;
    end;

    btnLoadPOs.caption := 'Refresh';
  end;
   //store manually entered data into a temp stringlist
  RecList := TList.Create; 
  try

    with Intrastat.IntrastatLines.Dataset do begin
      Intrastat.IntrastatLines.First;
      while not Intrastat.IntrastatLines.Eof do begin
        tmpRec := TRec.Create;
        tmpRec.TraderRef := Intrastat.IntrastatLines.traderRef;
        tmpRec.LineID := Intrastat.IntrastatLines.InvoiceOrPOLineID;
        tmpRec.DeliveryTerms := Intrastat.IntrastatLines.DeliveryTerms;
        tmpRec.TransactionNature := Intrastat.IntrastatLines.TransactionNature;
        RecList.Add(tmpRec);

        Intrastat.IntrastatLines.Next;
      end;
    end;

     //delete busobj dataset recs
    with Intrastat.IntrastatLines.Dataset do begin
      First;
      while not Eof do begin
        Delete;
      end;
    end;

    ResetQryPOLines;

    With qryPOLines do begin
      Open;
      First;
      while not Eof do begin
        Intrastat.IntrastatLines.New;
        Intrastat.IntrastatLines.CommodityCode     := FieldByName('CommodityCode').AsString;
        Intrastat.IntrastatLines.ProductID         := FieldByName('ProductID').AsInteger;
        Intrastat.IntrastatLines.Value             := System.Round(FieldByName('TotalLineAmount').AsFloat); { TODO -orobin : Round up }
      //   Intrastat.IntrastatLines.DeliveryTerms      := FieldByName('
       //  Intrastat.IntrastatLines.TransactionNature := FieldByName('
       Intrastat.IntrastatLines.InvoiceOrPOLineID  := FieldByName('PurchaseLineID').AsInteger;
        Intrastat.IntrastatLines.NetMass           := Trunc(FieldByName('NetWeight').AsFloat);
        Intrastat.IntrastatLines.SupplementaryUnit := FormatFloat('#0',FieldByName('Shipped').AsFloat);
        if IsEUCountry(FieldByName('Country').AsString) then
          Intrastat.IntrastatLines.Country           := FieldByName('Country').AsString
        else CommonLib.MessageDlgXP_Vista(FieldByName('Company').AsString + ' Country,' + FieldByName('Country').AsString + ',is not an EU country!', mtWarning, [mbOK], 0);
          Intrastat.IntrastatLines.TraderRef         := FieldByName('PurchaseOrderNumber').AsString;
        Intrastat.IntrastatLines.PostDb;
        Next;
      end;
    end;

   // go thru the temp stringlist and add re-instate manually enered data
    for i := 0 to RecList.Count - 1 do begin
      if Intrastat.IntrastatLines.Dataset.Locate('InvoiceOrPOLineID',TRec(RecList[i]).LineID, [loCaseInsensitive]) then begin
        Intrastat.IntrastatLines.DeliveryTerms := TRec(RecList[i]).DeliveryTerms;
        Intrastat.IntrastatLines.TransactionNature := TRec(RecList[i]).TransactionNature
      end;
    end;
  finally
     //empty List
    while RecList.Count > 0 do begin
      TRec(RecList[0]).Free;
      RecList.Delete(0);
    end;

    FreeAndNil(RecList);
  end;
end;

procedure TfrmIntrastatDeclaration.cboSubmitDateCloseUp(Sender: TObject);
begin
  inherited;
  if cboSubmitDate.date <> 0 then Intrastat.IsSubmitted := True;
end;

procedure TfrmIntrastatDeclaration.grdLinesButtonClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      Intrastat.IntrastatLines.Delete;
    finally
    end;
  end;
end;

procedure TfrmIntrastatDeclaration.cboProductIDCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  if modified then
  begin
    //clear record
    Intrastat.IntrastatLines.CommodityCode      := '';
    Intrastat.IntrastatLines.Value              := 0;
    Intrastat.IntrastatLines.DeliveryTerms      := '';
    Intrastat.IntrastatLines.TransactionNature  := '';
    Intrastat.IntrastatLines.NetMass            := 0;
    Intrastat.IntrastatLines.SupplementaryUnit  := '';
    Intrastat.IntrastatLines.Country            := '';
    Intrastat.IntrastatLines.TraderRef          := '';
  end;
end;

procedure TfrmIntrastatDeclaration.grdLinesDblClick(Sender: TObject);
begin
 inherited;
 if qryIntrastatLines.recordcount = 0 then exit;
  ShowInvoiceOrPO;
end;

procedure TfrmIntrastatDeclaration.ShowInvoiceOrPO;
var
  frm:TComponent;
  oProductInfo: TProductInfo;
  iInvoiceID,iPartID  : integer;
begin
  try
    if cboType.Text = 'Arrivals' then begin
      if not FormStillOpen('TPurchaseGUI') then begin
        frm := GetComponentByClassName('TPurchaseGUI');
        if Assigned(frm) then begin
          TPurchaseGUI(frm).KeyID := FastFuncs.StrToInt(grdLines.GetFieldValue(9));
          TPurchaseGUI(frm).FormStyle := fsNormal;
          TPurchaseGUI(frm).Position := poScreenCenter;
          TPurchaseGUI(frm).ShowModal;
        end;
      end;
    end else begin
     if not FormStillOpen('TInvoiceGUI') then begin
        iInvoiceID := FastFuncs.StrToInt(grdLines.GetFieldValue(9));
        iPartID    := GetPartID(grdLines.GetFieldValue(2));
        frm := GetComponentByClassName('TInvoiceGUI');
        oProductInfo := GetProductInfo(iPartID);
        if Assigned(frm) then begin
          with TInvoiceGUI(Frm) do begin
            KeyID := iInvoiceID;
            FormStyle := fsMDIChild;
            BringToFront;
            tblDetails.Edit;
            cboProductQry.Locate('PartsID', iPartID, [loCaseInsensitive]);
            cboProductR.Text := oProductInfo.ProductName;
            tblDetails.FieldByName('ProductName').AsString := oProductInfo.ProductName;
            tblDetails.FieldByName('ProductID').AsInteger := iPartID;
            DoOnProductchange;
          end;
        end;
      end;
    end;
  except

  end;
end;

procedure TfrmIntrastatDeclaration.cboProductIDDblClick(Sender: TObject);
begin
  inherited;
  ShowInvoiceOrPO;
end;

procedure TfrmIntrastatDeclaration.btnElectronicClick(Sender: TObject);
//var
//  frm:TComponent;
begin
  inherited;
//  if not FormStillOpen('TfrmVATElectronic') then begin
//    frm := GetComponentByClassName('TfrmVATElectronic');
//    if Assigned(frm) then begin
//      TfrmVATElectronic(frm).FormStyle := fsNormal;
//      TfrmVATElectronic(frm).Position := poScreenCenter;
//      TfrmVATElectronic(frm).ShowModal;
//    end;
//  end;
end;

initialization
  RegisterClassOnce(TfrmIntrastatDeclaration);
  with FormFact do begin
    RegisterMe(TfrmIntrastatDeclaration, 'TfrmIntrastatList_*=IntrastatID');
  end;
end.
