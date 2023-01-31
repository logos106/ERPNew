unit frmPCCImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, DNMSpeedButton, DNMPanel,
  StdCtrls, Buttons, MemDS, Grids, Wwdbigrd, Wwdbgrid, ProgressDialog,
  PrintDAT, wwMemo, Shader, ERPdbComponents, ImgList;

type
  TPCCImport = class(TBaseInputGUI)
    btnCancel: TDNMSpeedButton;
    Bevel1: TBevel;
    edtFileName: TEdit;
    Label1: TLabel;
    rbOPT: TRadioButton;
    rbStarCard: TRadioButton;
    Label2: TLabel;
    Label3: TLabel;
    odFileSelect: TOpenDialog;
    grdTemp: TwwDBGrid;
    tmpQry: TMyQuery;
    dsTemp: TDataSource;
    Bevel2: TBevel;
    lblTotlaRecords: TLabel;
    lblAmountTotal: TLabel;
    lblTotalTaxPortionGST: TLabel;
    btnLoad: TDNMSpeedButton;
    btnSelectFile: TDNMSpeedButton;
    btnInvoice: TDNMSpeedButton;
    MemoDialog: TwwMemoDialog;
    btnSelectAll: TDNMSpeedButton;
    btnUnSelectAll: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    dlgPrint: TPdtPrintDAT;
    rbOnQ: TRadioButton;
    Label4: TLabel;
    btnConfigure: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelectFileClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure tmpQryNewRecord(DataSet: TDataSet);
    procedure btnInvoiceClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnUnSelectAllClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure grdTempDrawFooterCell(Sender: TObject; Canvas: TCanvas; FooterCellRect: TRect; Field: TField; FooterText: String;
                                    var DefaultDrawing: Boolean);
    procedure MemoDialogUserButton1Click(Dialog: TwwMemoDlg; Memo: TMemo);
    procedure btnConfigureClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    ProgressDialog: TProgressDialog;
    Lines : TStringList;
    AmountTotal, TotalGSTEx, TotalGST : Double;  //grid footers
    TotalAmountNet, TotalAmountGross : Double;  //grid footers

    MatchSource, MatchTarget : TStringList;
    fsTableName:String;

    procedure CreateTempTable;
    procedure LoadPOSLines;
    procedure LoadStarCardLines;
    procedure CreatePOSInvoices;
    procedure CreateStarCardInvoices;

    function GetConfiguredStarCardDepartmentID(var DepartmentName : string) : Integer;
    //function GetConfiguredStarCardCustomerCustomFieldNo : integer;
    procedure LoadMatchLists;

    function GetCustomerIdByCardNumber(const CardNumber:string; var CustomerName : string) : integer;
    function GetProductIdByProductCode(const ProductCode:string; var ProductName : string) : integer;
    function GetDepartmentIDByLocationCode(const LocationCode : integer; var DepartmentName : string) : integer;
    function StarcardSurchargeRequired(const LocationCode : string; Var Surcharge: double) : boolean;
    function StarcardElseSurcharge : double;
    function ProductRequiresSurcharge(const ProductCode : string) : boolean;
  public
    { Public declarations }
  end;

var
  PCCImport: TPCCImport;

Const TempTableName = 'PCCImport';

implementation

uses FastFuncs,CommonDbLib, BusObjSales, CommonLib;

{$R *.dfm}

procedure TPCCImport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TPCCImport.FormCreate(Sender: TObject);
begin
  fsTablename := GetUserTemporaryTableName(TempTableName);
  inherited;

end;

procedure TPCCImport.btnSelectFileClick(Sender: TObject);
begin
  inherited;
  odFileSelect.InitialDir := ExtractFilePath(Application.ExeName);
  odFileSelect.Title := 'Select the file to import';
  //odFileSelect.Filter := 'XML Import Definition Files (*.xml)|*.xml';

  if odFileSelect.Execute then begin
    edtFileName.Text := odFileSelect.FileName;
  end; {if}
end;

procedure TPCCImport.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TPCCImport.CreateTempTable;
var
  slSQL: TStringList;
begin
  DestroyUserTemporaryTable(fsTableName);
  slSQL := TStringList.Create;
  try
    slSQL.Clear;
    slSQL.Add('CREATE TABLE `' + fsTableName + '` (');
    slSQL.Add('`RecID` INT(11) AUTO_INCREMENT,');

    if (rbOPT.Checked) or (rbOnQ.Checked) then begin // create fields for POS Import
      slSQL.Add('`RecordType` VARCHAR(2),');
      slSQL.Add('`SiteNumber` INT(5),');
      slSQL.Add('`TransactionNumber` INT(6),');
      slSQL.Add('`AccountNumber` VARCHAR(8),');
      slSQL.Add('`CardNumber` VARCHAR(8),');
      slSQL.Add('`TransactionDate` DATE,');
      slSQL.Add('`TransactionTime` TIME,');
      slSQL.Add('`TransactionType` INT(1),');
      slSQL.Add('`PumpNumber` INT(2),');
      slSQL.Add('`StockOrDepNumber` VARCHAR(12),');
      slSQL.Add('`SaleQty` DOUBLE,');
      slSQL.Add('`UnitPrice` DOUBLE,');
      slSQL.Add('`ExtensionOnAccountAmount` DOUBLE,');
      slSQL.Add('`ReferenceOrOdometer` INT(12),');
      slSQL.Add('`TaxPortionGST` DOUBLE,');
      //slSQL.Add('`NoData` VARCHAR(16,),');
    end
    else if rbStarCard.Checked then begin //create fields for StarCard
      slSQL.Add('`RecordType` VARCHAR(1),');
      slSQL.Add('`ParentCustomerNumber` VARCHAR(10),');
      slSQL.Add('`InvoiceCustomerNumber` VARCHAR(10),');
      slSQL.Add('`InvoiceNumber` VARCHAR(9),');
      slSQL.Add('`CostCentreCode` VARCHAR(10),');
      slSQL.Add('`CardNumber` VARCHAR(19),');
      slSQL.Add('`InvoiceCustomerABNNumber` VARCHAR(11),');
      slSQL.Add('`SystemTraceNumber` VARCHAR(9),');
      slSQL.Add('`TransactionDate` DATE,');
      slSQL.Add('`TransactionTime` TIME,');
      slSQL.Add('`LocationCode` VARCHAR(8),');
      slSQL.Add('`LocationName` VARCHAR(28),');
      slSQL.Add('`LocationState` VARCHAR(1),');
      slSQL.Add('`TransactionFee` DOUBLE,');
      slSQL.Add('`TransFeeSign` VARCHAR(1),');
      slSQL.Add('`DomesticNumber` VARCHAR(16),');
      slSQL.Add('`RegistrationNumber` VARCHAR(12),');
      slSQL.Add('`OdometerReading` INT(9),');
      slSQL.Add('`DriverName` VARCHAR(15),');
      slSQL.Add('`TransactionType` VARCHAR(1),');
      slSQL.Add('`ProductCode` VARCHAR(2),');
      slSQL.Add('`ProductVolume` DOUBLE,');
      //slSQL.Add('`VolumeSign` VARCHAR(1),');
      slSQL.Add('`UnitPrice` DOUBLE,');
      slSQL.Add('`GrossAmount` DOUBLE,');
      //slSQL.Add('`GrossAmountSign` VARCHAR(1),');
      slSQL.Add('`GST` DOUBLE,');
      //slSQL.Add('`GSTSign` VARCHAR(1),');
      slSQL.Add('`NetChargeAmount` DOUBLE,');
      //slSQL.Add('`NetChargeAmountSign` VARCHAR(1),');
      slSQL.Add('`PumpPrice` DOUBLE,');
      slSQL.Add('`FederalTax` DOUBLE,');
      slSQL.Add('`StateTax` DOUBLE,');
      slSQL.Add('`FreightCharge` DOUBLE,');
    end;

    slSQL.Add('PRIMARY KEY (`RecID`)) TYPE=MyISAM;');
    CreateUserTemporaryTable(slSQL);

  finally
    // Free used objects.
    if Assigned(slSQL) then
      FreeAndNil(slSQL);
  end;
end;

procedure TPCCImport.btnLoadClick(Sender: TObject);
var
  SavedCursor: TCursor;
begin
  if not FileExists(edtFileName.Text) then begin
    CommonLib.MessageDlgXP_Vista('File Does Not Exist!', mtWarning, [mbOK], 0);
    Exit;
  end;
  SavedCursor := Screen.Cursor;  
  Lines := TStringList.Create;
  ProgressDialog := TProgressDialog.Create(nil);
  Try
    Screen.Cursor := crHourGlass;
    grdTemp.SelectedList.Clear;
    Try
      Lines.LoadFromFile(edtFileName.Text);
    except
      on E: EFOpenError do begin
        CommonLib.MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
      end;
    end;
    ProgressDialog.Caption := 'Please Wait .......';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := Lines.Count-1;
    ProgressDialog.Step := 1;
    ProgressDialog.Execute;
    inherited;
    CreateTempTable;
    if (rbOPT.Checked) or (rbOnQ.Checked) then begin // create fields for POS Import
      LoadPOSLines;
    end
    else if rbStarCard.Checked then begin //create fields for StarCard
      LoadStarCardLines;
    end;
    tmpQry.SQL.Text := 'SELECT * FROM ' + fsTableName;
    tmpQry.Open;
  finally
    FreeAndNil(Lines);
    FreeAndNil(ProgressDialog);
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TPCCImport.LoadPOSLines;
Var i: Integer;
  Procedure InsertPosLine(const Line : String);
  Var qryTemp : TMyQuery;
  begin
    qryTemp := TMyQuery.Create(nil);
    try
      qryTemp.Options.FlatBuffers := True;
      qryTemp.Connection := GetSharedMyDacConnection;
      qryTemp.SQL.Text := 'INSERT HIGH_PRIORITY INTO ' +  fsTableName +
         '(RecordType, SiteNumber, TransactionNumber, AccountNumber, CardNumber,' +
         ' TransactionDate, TransactionTime, TransactionType, PumpNumber, StockOrDepNumber, ' +
         ' SaleQty, UnitPrice, ExtensionOnAccountAmount, ReferenceOrOdometer, TaxPortionGST) ' +
         ' VALUES (';
      qryTemp.SQL.Add(QuotedStr(Copy(Line,1,2)) + ',');
      qryTemp.SQL.Add(Copy(Line,3,5) + ',');
      qryTemp.SQL.Add(Copy(Line,8,6) + ',');
      qryTemp.SQL.Add(QuotedStr(Copy(Line,14,8)) + ',');
      qryTemp.SQL.Add(QuotedStr(Copy(Line,22,8)) + ',');
      qryTemp.SQL.Add(QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(Copy(Line,30,2) + DateSeparator + Copy(Line,32,2) + DateSeparator + Copy(Line,34,2)))) + ',');
      qryTemp.SQL.Add(QuotedStr(FormatDateTime('hh:nn', StrToTime(Copy(Line,38,2) + TimeSeparator + Copy(Line,36,2)))) + ',');
      qryTemp.SQL.Add(Copy(Line,40,1) + ',');
      if Copy(Line,41,2) = '  ' then
        qryTemp.SQL.Add('0' + ',')
      else
        qryTemp.SQL.Add(Copy(Line,41,2) + ',');
      qryTemp.SQL.Add(QuotedStr(Copy(Line,43,12)) + ',');
      qryTemp.SQL.Add(Copy(Line,62,1) + Copy(Line,55,7) + '/100' + ',');
      qryTemp.SQL.Add(Copy(Line,63,8) + '/10000' + ',');
      qryTemp.SQL.Add(Copy(Line,80,1) + Copy(Line,71,9) + '/100' + ',');
      qryTemp.SQL.Add(Copy(Line,81,12) + ',');
      qryTemp.SQL.Add(Copy(Line,102,1) + Copy(Line,93,9) +'/100' + ')');
      qryTemp.Execute;

      AmountTotal := AmountTotal + StrToFloat(Copy(Line,80,1) + Copy(Line,71,9)) / 100;
      //TotalGSTEx := ???
      if (rbOPT.Checked) then begin
        TotalGST := TotalGST + StrToFloat(Copy(Line,102,1) + Copy(Line,93,9)) / 100;
      end else
      if (rbOnQ.Checked) then begin
        TotalGST := TotalGST + StrToFloat(Copy(Line,102,1) + Copy(Line,93,9)) /100;
      end;

    finally
      FreeAndNil(qryTemp);
    end;
  end;
  Procedure ShowPosTotalLine(const Line : String);
  begin
    lblTotlaRecords.Caption := Format('Total Records:' + ' %d',[Trunc(StrValue(Copy(Line,3,6)))]);
    lblAmountTotal.Caption := Format('Amount Total:' + ' %n',[StrValue(Copy(Line,10,12))/1000]);
    if (rbOPT.Checked) then begin
      lblTotalTaxPortionGST.Caption := Format('Total Tax Portion GST:' + ' %n',[StrValue(Copy(Line,22,10))/100]);
    end else
    if (rbOnQ.Checked) then begin
      lblTotalTaxPortionGST.Caption := Format('Total Tax Portion GST:' + ' %n',[StrValue(Copy(Line,22,10))/100]);
    end;
    lblTotalTaxPortionGST.Visible := true;
  end;

begin //LoadPosLines
  AmountTotal := 0;
  TotalGSTEx := 0;
  TotalGST := 0;

  try
    for i:= 0 to Lines.Count-2 do begin // -2 because last line is a totals do not need to load it but show on form
      InsertPOSLine(Lines[i]);
      ProgressDialog.StepIt;
    end;
    ShowPosTotalLine(Lines[Lines.Count-1]);
  except
    on e: Exception do CommonLib.MessageDlgXP_Vista('Error Occured During Import.'+#13+#10+'Possibly File Type Mismatch.' + #13#10 + e.Message , mtError, [mbOK], 0);
  end;
end;

procedure TPCCImport.LoadStarCardLines;
Var i: Integer;
  Procedure ShowStarCardHeaderLine(const Line : String);
  Var sign : string[1];
  Begin
    sign := '';
    lblTotlaRecords.Caption := Format('Total Records:' + ' %d',[Trunc(StrValue(Copy(Line,13,6)))]);
    if Copy(Line,36,1) = '-' then sign := '-';
    lblAmountTotal.Caption := sign + Format('Amount Total:' + ' %n',[StrValue(Copy(Line,26,10))/100]);
    lblTotalTaxPortionGST.Visible := false;
  End;

  Procedure InsertStarCardLine(const Line : String);
  Var qryTemp : TMyQuery;
  begin
    qryTemp := TMyQuery.Create(nil);
    try
      qryTemp.Options.FlatBuffers := True;
      qryTemp.Connection := GetSharedMyDacConnection;
      qryTemp.SQL.Text := 'INSERT HIGH_PRIORITY INTO ' +  fsTableName +
         '(RecordType,                  '+
         ' ParentCustomerNumber,        '+
         ' InvoiceCustomerNumber,       '+
         ' InvoiceNumber,               '+
         ' CostCentreCode,              '+
         ' CardNumber,                  '+
         ' InvoiceCustomerABNNumber,    '+
         ' SystemTraceNumber,           '+
         ' TransactionDate,             '+
         ' TransactionTime,             '+
         ' LocationCode,                '+
         ' LocationName,                '+
         ' LocationState,               '+
         ' TransactionFee,              '+
         //' TransFeeSign,                '+
         ' DomesticNumber,              '+
         ' RegistrationNumber,          '+
         ' OdometerReading,             '+
         ' DriverName,                  '+
         ' TransactionType,             '+
         ' ProductCode,                 '+
         ' ProductVolume,               '+
         //' VolumeSign,                  '+
         ' UnitPrice,                   '+
         ' GrossAmount,                 '+
         //' GrossAmountSign,             '+
         ' GST,                         '+
         //' GSTSign,                     '+
         ' NetChargeAmount,             '+
         //' NetChargeAmountSign,         '+
         ' PumpPrice,                   '+
         ' FederalTax,                  '+
         ' StateTax,                    '+
         ' FreightCharge                '+
         ') ' +
         ' VALUES (';
      qryTemp.SQL.Add(QuotedStr(Copy(Line,1,1)) + ',');
      qryTemp.SQL.Add(QuotedStr(Copy(Line,2,10)) + ',');
      qryTemp.SQL.Add(QuotedStr(Copy(Line,12,10)) + ',');
      qryTemp.SQL.Add(QuotedStr(Copy(Line,22,9)) + ',');
      qryTemp.SQL.Add(QuotedStr(Copy(Line,31,10)) + ',');
      qryTemp.SQL.Add(QuotedStr(Copy(Line,41,19)) + ',');
      qryTemp.SQL.Add(QuotedStr(Copy(Line,60,11)) + ',');
      qryTemp.SQL.Add(QuotedStr(Copy(Line,71,9)) + ',');
      qryTemp.SQL.Add(QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(Copy(Line,86,2) + DateSeparator + Copy(Line,84,2) + DateSeparator + Copy(Line,80,4)))) + ',');
      qryTemp.SQL.Add(QuotedStr(FormatDateTime('hh:nn:ss', StrToTime(Copy(Line,88,2) + TimeSeparator + Copy(Line,90,2) + TimeSeparator + Copy(Line,92,2)))) + ',');
      qryTemp.SQL.Add(QuotedStr(Copy(Line,94,8)) + ',');
      qryTemp.SQL.Add(QuotedStr(Copy(Line,102,28)) + ',');
      qryTemp.SQL.Add(QuotedStr(Copy(Line,130,1)) + ',');
      qryTemp.SQL.Add(Copy(Line,136,1) + Copy(Line,132,4) + ',');
      qryTemp.SQL.Add(QuotedStr(Copy(Line,137,16)) + ',');
      qryTemp.SQL.Add(QuotedStr(Copy(Line,153,12)) + ',');
      qryTemp.SQL.Add(Copy(Line,165,9) + ',');
      qryTemp.SQL.Add(QuotedStr(Copy(Line,174,15)) + ',');
      qryTemp.SQL.Add(QuotedStr(Copy(Line,189,1)) + ',');
      qryTemp.SQL.Add(QuotedStr(Copy(Line,190,2)) + ',');
      qryTemp.SQL.Add(Copy(Line,199,1) + Copy(Line,192,7) + '/100' + ',');
      qryTemp.SQL.Add(Copy(Line,200,7) + '/10000' + ',');
      qryTemp.SQL.Add(Copy(Line,215,1) + Copy(Line,207,8) + '/100' + ',');
      qryTemp.SQL.Add(Copy(Line,222,1) + Copy(Line,216,6) + '/100' + ',');
      qryTemp.SQL.Add(Copy(Line,231,1) + Copy(Line,223,8) + '/100' + ',');
      qryTemp.SQL.Add(Copy(Line,232,7) + '/10000' + ',');
      qryTemp.SQL.Add(Copy(Line,239,5) + '/100' + ',');
      qryTemp.SQL.Add(Copy(Line,244,5) + '/100' + ',');
      qryTemp.SQL.Add(Copy(Line,249,5) + '/100' + ')');
      qryTemp.Execute;

      TotalAmountNet := TotalAmountNet + StrToFloat(Copy(Line,231,1) + Copy(Line,223,8)) /100;
      TotalGST := TotalGST + StrToFloat(Copy(Line,222,1) + Copy(Line,216,6)) /100;
      TotalAmountGross := TotalAmountGross + StrToFloat(Copy(Line,215,1) + Copy(Line,207,8)) /100;

    finally
      FreeAndNil(qryTemp);
    end;
  End;

begin
  TotalAmountNet := 0;
  TotalAmountGross := 0;
  TotalGST := 0;

  try
    ShowStarCardHeaderLine(Lines[0]);
    ProgressDialog.MaxValue := Lines.Count-1;
    for i:= 1 to Lines.Count-1 do begin // Start from 1 because first line is a header do not need to load it but show on form
      InsertStarCardLine(Lines[i]);
      ProgressDialog.StepIt;
    end;
  except
    on e: Exception do CommonLib.MessageDlgXP_Vista('Error Occured During Import.'+#13+#10+'Possibly File Type Mismatch.' + #13#10 + e.Message , mtError, [mbOK], 0);
  end;    
end;

procedure TPCCImport.tmpQryNewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.Cancel;
end;

procedure TPCCImport.btnInvoiceClick(Sender: TObject);
Var SavedCursor : TCursor;
begin
  if grdTemp.SelectedList.Count = 0 then begin
    CommonLib.MessageDlgXP_Vista('Nothing is selected!', mtWarning, [mbOK], 0);
    Exit;
  end;

  SavedCursor := Screen.Cursor;

  try
    MatchSource := TStringList.Create;
    MatchTarget := TStringList.Create;


    Screen.Cursor := crHourGlass;

    ProgressDialog := TProgressDialog.Create(nil);
    ProgressDialog.Caption := 'Please Wait .......';
    ProgressDialog.MinValue := 0;
    ProgressDialog.Step := 1;
    ProgressDialog.MaxValue := grdTemp.SelectedList.Count - 1;
    ProgressDialog.Execute;

    MemoDialog.Lines.Clear;

    if (rbOPT.Checked) or (rbOnQ.Checked) then begin
      CreatePOSInvoices;
    end
    else if rbStarCard.Checked then begin
      CreateStarCardInvoices;
    end;

    MemoDialog.Execute;

  finally
    Screen.Cursor := SavedCursor;
    FreeAndNil(ProgressDialog);
    FreeAndNil(MatchSource);
    FreeAndNil(MatchTarget);
  end;  
end;

procedure TPCCImport.btnSelectAllClick(Sender: TObject);
begin
  inherited;
  If grdTemp.DataSource.DataSet.Active then
    grdTemp.SelectAll;
end;

procedure TPCCImport.btnUnSelectAllClick(Sender: TObject);
begin
  inherited;
  If grdTemp.DataSource.DataSet.Active then
    grdTemp.UnselectAll;
end;

procedure TPCCImport.CreatePOSInvoices;
Var i : integer;
    CustomerName, ProductName : String;
    CustomerID, ProductId : integer;
    Count : integer;
    CustomerCode : string;

  Procedure CreateInvoice;
  Var Inv : TInvoice;
      DepartmentName : string;
      DepartmentID : integer;
  begin
    inherited;
    Inv := TInvoice.Create(nil);
    try
      Inv.New;
      Inv.SilentMode := true;
      Inv.OverrideHoldSale := true;
      Inv.CreationDate := tmpQry.FieldByName('TransactionDate').AsDateTime;
      Inv.SaleDate := tmpQry.FieldByName('TransactionDate').AsDateTime;
      Inv.CustomerID := CustomerID;
      Inv.CustomerName := CustomerName;

      DepartmentID := GetDepartmentIDByLocationCode(tmpQry.FieldByName('SiteNumber').AsInteger,DepartmentName);
      if DepartmentID > 0 then begin
        Inv.SaleClassId := DepartmentID;
        Inv.SaleClassName := DepartmentName;
      end;        

      Inv.Lines.ProductName := ProductName;
      //Inv.Lines.ProductId :=;
      Inv.Lines.QtySold := tmpQry.FieldByName('SaleQty').AsFloat;
      Inv.Lines.QtyShipped := tmpQry.FieldByName('SaleQty').AsFloat;
      Inv.Lines.LinePriceInc := tmpQry.FieldByName('UnitPrice').AsFloat;
      if (rbOPT.Checked) then begin
        Inv.Lines.LineTaxTotal := tmpQry.FieldByName('ExtensionOnAccountAmount').AsFloat - tmpQry.FieldByName('TaxPortionGST').AsFloat;
      end else
      if (rbOnQ.Checked) then begin
        Inv.Lines.LineTaxTotal := tmpQry.FieldByName('TaxPortionGST').AsFloat;
      end;
      Inv.Lines.TotalLineAmount := tmpQry.FieldByName('ExtensionOnAccountAmount').AsFloat - Inv.Lines.LineTaxTotal;
      Inv.Lines.TotalLineAmountInc := tmpQry.FieldByName('ExtensionOnAccountAmount').AsFloat;
      Inv.Save;
    finally
      FreeAndNil(Inv);
    end;
  End;

begin //CreatePOSInvoices
  try
    Count := 0;

    for I := 0 to grdTemp.SelectedList.Count - 1 do begin
      tmpQry.GotoBookmark(grdTemp.SelectedList.Items[i]);
      if (rbOPT.Checked) then begin
        CustomerID := GetCustomerIdByCardNumber(FastFuncs.Trim(tmpQry.FieldByName('CardNumber').AsString), CustomerName);
        CustomerCode := FastFuncs.Trim(tmpQry.FieldByName('CardNumber').AsString);
      end else
      if (rbOnQ.Checked) then begin
        CustomerID := GetCustomerIdByCardNumber(FastFuncs.Trim(tmpQry.FieldByName('AccountNumber').AsString), CustomerName);
        CustomerCode := FastFuncs.Trim(tmpQry.FieldByName('AccountNumber').AsString);
      end;

      if CustomerId > 0 then begin
        ProductId := GetProductIdByProductCode(FastFuncs.Trim(tmpQry.FieldByName('StockOrDepNumber').AsString),ProductName);
        if ProductId > 0 then begin
          CreateInvoice;
          Inc(Count);
        end
        else begin
          MemoDialog.Lines.Add('Line ' + tmpQry.FieldByName('RecID').AsString + '. No Product Found For Code : ' + tmpQry.FieldByName('StockOrDepNumber').AsString + '. No Invoice Created!');
        end;
      end
      else begin
        MemoDialog.Lines.Add('Line ' + tmpQry.FieldByName('RecID').AsString + '. No Customer Found For Card Number : ' + CustomerCode + '. No Invoice Created!');
      end;
      ProgressDialog.StepIt;
    end;
    MemoDialog.Lines.Add('Invoices created : ' + FastFuncs.IntToStr(Count) + '                                     ');
  finally

  end;
end;

procedure TPCCImport.CreateStarCardInvoices;
Var SystemTraceNumber, CardNumber : string;
    TransactionDate : TDateTime;
    RecIDList : TStringList;
    qry : TMyQuery;
    Inv : TInvoice;
    Count, I : integer;
    CustomerName, ProductName, DepartmentName : String;
    CustomerID, ProductId : integer;
    InvoiceActive : boolean;
    Surcharge : Double;
begin
  Inv := nil;
  RecIdList := TStringList.Create;
  qry := TMyQuery.Create(nil);
  try
    InvoiceActive := false;
    // find RecIDs of selected record and put them into RecIDlist
    for I := 0 to grdTemp.SelectedList.Count - 1 do begin
      tmpQry.GotoBookmark(grdTemp.SelectedList.Items[i]);
      RecIdList.Add(tmpQry.FieldByName('RecID').AsString);
    end;
    qry.Options.FlatBuffers := True;
    qry.Connection := tmpQry.Connection;
    qry.SQL.Text := tmpQry.SQL.Text + ' WHERE RecID IN (' + RecIDList.CommaText + ') ORDER BY TransactionDate, SystemTraceNumber' ;
    qry.Open;

    CardNumber := '';
    SystemTraceNumber := '';
    TransactionDate := 0;

    Count := 0;

    while not qry.EOF do begin
      if (qry.FieldByName('SystemTraceNumber').AsString <> SystemTraceNumber) or (qry.FieldByName('TransactionDate').AsDateTime <> TransactionDate) then begin
        if Assigned(Inv) then begin
          Inv.Save;
          FreeAndNil(Inv);
          InvoiceActive := false;
          Inc(Count);
        end;
        CardNumber := qry.FieldByName('CardNumber').AsString;
        SystemTraceNumber := qry.FieldByName('SystemTraceNumber').AsString;
        TransactionDate := qry.FieldByName('TransactionDate').AsDateTime;
        CustomerID := GetCustomerIdByCardNumber(FastFuncs.Trim(qry.FieldByName('CardNumber').AsString), CustomerName);
        if CustomerId > 0 then begin
          ProductId := GetProductIdByProductCode(FastFuncs.Trim(qry.FieldByName('ProductCode').AsString),ProductName);
          if ProductId > 0 then begin
            //Create New Invoice
            Inv := TInvoice.Create(nil);
            Inv.New;
            Inv.SilentMode := true;
            Inv.OverrideHoldSale := true;
            Inv.CreationDate := TransactionDate;
            Inv.SaleDate := Inv.CreationDate;
            Inv.CustomerID := CustomerID;
            Inv.CustomerName := CustomerName;

            if GetConfiguredStarCardDepartmentID(DepartmentName) > 0 then
              Inv.SaleClassId := GetConfiguredStarCardDepartmentID(DepartmentName);
              Inv.SaleClassName := DepartmentName;
            InvoiceActive := true;
          end
          else begin
            MemoDialog.Lines.Add('Line ' + qry.FieldByName('RecID').AsString + '. No Product Found For Code : ' + qry.FieldByName('ProductCode').AsString + '. No Invoice Created!');
          end;
        end
        else begin
          MemoDialog.Lines.Add('Line ' + qry.FieldByName('RecID').AsString + '. No Customer Found For Card Number : ' + qry.FieldByName('CardNumber').AsString + '. No Invoice Created!');
        end;
      end;
      if InvoiceActive then begin // if card number is the same, just add lines to existing invoice
        ProductId := GetProductIdByProductCode(FastFuncs.Trim(qry.FieldByName('ProductCode').AsString),ProductName);
        if ProductId > 0 then begin
          //Add Invoice Line
          Surcharge := 0;

          if ProductRequiresSurcharge(FastFuncs.Trim(qry.FieldByName('ProductCode').AsString)) then begin
            if not StarcardSurchargeRequired(Copy(qry.FieldByName('LocationCode').AsString,4,5),Surcharge) then
              Surcharge := StarcardElseSurcharge;
          end;
          Inv.Lines.New;
          Inv.Lines.ProductName := ProductName;
          if qry.FieldByName('ProductVolume').AsFloat = 0 then begin // non inventory product (non-fuel)
            Inv.Lines.QtySold := 1;
            Inv.Lines.QtyShipped := 1;
            Inv.Lines.LinePriceInc := qry.FieldByName('NetChargeAmount').AsFloat;
            Inv.Lines.LinePrice := qry.FieldByName('GrossAmount').AsFloat;
          end
          else begin
            Inv.Lines.QtySold := qry.FieldByName('ProductVolume').AsFloat;
            Inv.Lines.QtyShipped := qry.FieldByName('ProductVolume').AsFloat;
            Inv.Lines.LinePriceInc := qry.FieldByName('UnitPrice').AsFloat + Surcharge;
          end;
          if Surcharge = 0 then begin
            Inv.Lines.LineTaxTotal := qry.FieldByName('GST').AsFloat;
            Inv.Lines.TotalLineAmountInc := qry.FieldByName('NetChargeAmount').AsFloat;
          end
          else begin
            Inv.Lines.TotalLineAmountInc := (qry.FieldByName('UnitPrice').AsFloat + Surcharge) * qry.FieldByName('ProductVolume').AsFloat;
            //Inv.Lines.LineTaxTotal := ;            
          end;

          LoadMatchLists;

          for i := 0 to MatchSource.Count - 1 do begin
            if (Length(FastFuncs.Trim(MatchSource[i])) > 0) and (Length(FastFuncs.Trim(MatchTarget[i])) > 0) then begin
              Inv.Lines.Dataset.Edit;
              Inv.Lines.Dataset.FieldByName(MatchTarget[i]).AsString := qry.FieldByName(MatchSource[i]).AsString;
              Self.Update;
            end;
          end;
        end
        else begin
          MemoDialog.Lines.Add('No Product Found For Code : ' + qry.FieldByName('ProductCode').AsString + '. No Invoice Created!');
        end;
      end;
      qry.Next;
      ProgressDialog.StepIt;
    end;

    if Assigned(Inv) then begin
      Inv.Save;
      FreeAndNil(Inv);
      Inc(Count);
    end;

    MemoDialog.Lines.Add('Invoices created : ' + FastFuncs.IntToStr(Count));

  finally
    FreeAndNil(qry);
    FreeAndNil(RecIdList);
  end;
end;

function TPCCImport.GetCustomerIdByCardNumber(const CardNumber: string; var CustomerName: string): integer;
Var qryCustomer : TMyQuery;
Begin
  Result :=0;
  qryCustomer := TMyQuery.Create(nil);
  try
    qryCustomer.Options.FlatBuffers := True;
    qryCustomer.Connection := GetSharedMyDacConnection;
    qryCustomer.SQL.Text := 'SELECT Company, ClientId, CardNumber FROM tblClients WHERE Customer = "T" AND ' +
       ' CardNumber = :xCardNumber';
    qryCustomer.ParamByName('xCardNumber').AsString := CardNumber;
    qryCustomer.Open;
    if qryCustomer.RecordCount > 0 then begin
      Result := qryCustomer.FieldByName('ClientID').AsInteger;
      CustomerName := qryCustomer.FieldByName('Company').AsString;
    end;
  finally
    FreeAndNil(qryCustomer);
  end;
End;

function TPCCImport.GetProductIdByProductCode(const ProductCode: string; var ProductName: string): integer;
Var qryProduct : TMyQuery;
Begin
  Result :=0;
  qryProduct := TMyQuery.Create(nil);
  try
    qryProduct.Options.FlatBuffers := True;
    qryProduct.Connection := GetSharedMyDacConnection;
    qryProduct.SQL.Text := 'SELECT ProductID, ProductName '+
        ' FROM tblpccimportedproductcode D ' +
        ' INNER JOIN tblpccproductcode M ON D.PCC_ProductCode = M.PccProductCodeID' +
        ' WHERE D.Active = "T" AND ProductCode = :xProductCode';

    qryProduct.ParamByName('xProductCode').AsString := ProductCode;
    qryProduct.Open;
    if qryProduct.RecordCount > 0 then begin
      Result := qryProduct.FieldByName('ProductID').AsInteger;
      ProductName := qryProduct.FieldByName('ProductName').AsString;
    end;
  finally
    FreeAndNil(qryProduct);
  end;
End;

function TPCCImport.ProductRequiresSurcharge(const ProductCode: string): boolean; Var qryProductCode : TMyQuery;
begin
  result := false;
  qryProductCode := TMyQuery.Create(nil);
  try
    qryProductCode.Options.FlatBuffers := True;
    qryProductCode.Connection := GetSharedMyDacConnection;
    qryProductCode.SQL.Text := 'SELECT * '+
             ' FROM tblpccimportratesproductcodes '+
             ' WHERE Active = "T" AND ProductCode = :xProductCode';
    qryProductCode.ParamByName('xProductCode').AsString := ProductCode;
    qryProductCode.Open;
    if qryProductCode.RecordCount > 0 then begin
      Result := true;
    end;
  finally
    FreeAndNil(qryProductCode);
  end;
end;

function TPCCImport.StarcardSurchargeRequired(const LocationCode: string; Var Surcharge: double): boolean;
Var qryLocationCode : TMyQuery;
begin
  result := false;
  qryLocationCode := TMyQuery.Create(nil);
  try
    qryLocationCode.Options.FlatBuffers := True;
    qryLocationCode.Connection := GetSharedMyDacConnection;
    qryLocationCode.SQL.Text := 'SELECT * '+
             ' FROM tblpccimportrateseftcodes '+
             ' WHERE Active = "T" AND EFTCode = :xEFTCode';
    qryLocationCode.ParamByName('xEFTCode').AsString := LocationCode;
    qryLocationCode.Open;
    if qryLocationCode.RecordCount > 0 then begin
      Result := true;
      Surcharge := qryLocationCode.FieldByName('AddPrice').AsFloat;
    end;
  finally
    FreeAndNil(qryLocationCode);
  end;
end;

function TPCCImport.StarcardElseSurcharge: double;
Var qryElseSurcharge : TMyQuery;
begin
  Result := 0;
  qryElseSurcharge := TMyQuery.Create(nil);
  try
    qryElseSurcharge.Options.FlatBuffers := True;
    qryElseSurcharge.Connection := GetSharedMyDacConnection;
    qryElseSurcharge.SQL.Text := 'SELECT ElseRate '+
             ' FROM tblpccimportrates';
    qryElseSurcharge.Open;
    if qryElseSurcharge.RecordCount > 0 then begin
      Result := qryElseSurcharge.FieldByName('ElseRate').AsFloat;
    end;
  finally
    FreeAndNil(qryElseSurcharge);
  end;
end;

procedure TPCCImport.btnPrintClick(Sender: TObject);
begin
  inherited;
  dlgPrint.Print;
end;

procedure TPCCImport.grdTempDrawFooterCell(Sender: TObject;
  Canvas: TCanvas; FooterCellRect: TRect; Field: TField;
  FooterText: String; var DefaultDrawing: Boolean);
begin
  inherited;
  if (rbOPT.Checked) or (rbOnQ.Checked) then begin
    grdTemp.ColumnByName('ExtensionOnAccountAmount').FooterValue :=
      FloatToStrF(AmountTotal, ffNumber, 15, 2);

    grdTemp.ColumnByName('TaxPortionGST').FooterValue :=
      FloatToStrF(TotalGST, ffNumber, 15, 2);
   end;

  if (rbStarCard.Checked) then begin
    grdTemp.ColumnByName('GrossAmount').FooterValue :=
      FloatToStrF(TotalAmountGross, ffNumber, 15, 2);

    grdTemp.ColumnByName('GST').FooterValue :=
      FloatToStrF(TotalGST, ffNumber, 15, 2);

    grdTemp.ColumnByName('NetChargeAmount').FooterValue :=
      FloatToStrF(TotalAmountNet, ffNumber, 15, 2);
   end;

end;


procedure TPCCImport.MemoDialogUserButton1Click(Dialog: TwwMemoDlg;
  Memo: TMemo);
Var LB : TListBox;
begin
  inherited;
  LB := TListbox.Create(nil);
  Try
    LB.Width := 500;
    //LB.Left := 2000;
    LB.Parent := Self;
    LB.Items := Memo.Lines;
    dlgPrint.ObjectToPrint := LB;
    dlgPrint.Print;
    dlgPrint.ObjectToPrint := grdTemp;
  Finally
    FreeAndNil(LB);
  end;
end;

procedure TPCCImport.btnConfigureClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TPCCImportConfigure');
  if Assigned(Form) then begin //if has acess
    with TForm(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

function TPCCImport.GetConfiguredStarCardDepartmentID(Var DepartmentName : string): integer;
Var qryDepartment : TMyQuery;
begin
  result := 0;
  qryDepartment := TMyQuery.Create(nil);
  try
    qryDepartment.Options.FlatBuffers := True;
    qryDepartment.Connection := GetSharedMyDacConnection;
    qryDepartment.SQL.Text := 'SELECT IC.DepartmentID, C.ClassName '+
             ' FROM tblPCCImportConfigure IC '+
             ' LEFT JOIN tblClass C ON C.ClassID = IC.DepartmentID '+
             ' WHERE IC.Active = "T" ';
    qryDepartment.Open;
    if qryDepartment.RecordCount > 0 then begin
      Result := qryDepartment.FieldByName('DepartmentID').AsInteger;
      DepartmentName := qryDepartment.FieldByName('ClassName').AsString;
    end;
  finally
    FreeAndNil(qryDepartment);
  end;
end;

procedure TPCCImport.LoadMatchLists;
Var qryMatch : TMyQuery;
begin
  qryMatch := TMyQuery.Create(nil);
  try
    qryMatch.Options.FlatBuffers := True;
    qryMatch.Connection := GetSharedMyDacConnection;
    qryMatch.SQL.Text := 'SELECT * '+
             ' FROM tblPCCImportConfigureMatch WHERE Active = "T" ';
    qryMatch.Open;
    if qryMatch.RecordCount > 0 then begin
      while not qryMatch.EOF do begin
       MatchSource.Add(qryMatch.FieldByName('FieldNameSource').AsString);
       MatchTarget.Add(qryMatch.FieldByName('FieldNameTarget').AsString);
       qryMatch.Next;
      end;
    end;
  finally
    FreeAndNil(qryMatch);
  end;
end;

function TPCCImport.GetDepartmentIDByLocationCode(const LocationCode: integer; var DepartmentName: string): integer;
Var qryDep : TMyQuery;
Begin
  Result :=0;
  qryDep := TMyQuery.Create(nil);
  try
    qryDep.Options.FlatBuffers := True;
    qryDep.Connection := GetSharedMyDacConnection;
    qryDep.SQL.Text := 'SELECT DepID, DepName '+
        ' FROM tblPCCImpConfImportedDepNo D ' +
        ' INNER JOIN tblPCCImpConfNativeDep M ON D.Internal_DepID = M.PCCImpConfNativeDepID' +
        ' WHERE D.Active = "T" AND LocationCode = :xLocationCode';

    qryDep.ParamByName('xLocationCode').AsInteger := LocationCode;
    qryDep.Open;
    if qryDep.RecordCount > 0 then begin
      Result := qryDep.FieldByName('DepID').AsInteger;
      DepartmentName := qryDep.FieldByName('DepName').AsString;
    end;
  finally
    FreeAndNil(qryDep);
  end;
end;

initialization
  RegisterClassOnce(TPCCImport);

end.
