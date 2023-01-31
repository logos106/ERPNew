unit BarcodeActionObj;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 01/12/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Classes, SysUtils, Controls, BaseBarcodeObj,
  MyAccess,ERPdbComponents, Dialogs;

type
  TActionPrefixType = (aptNone, aptShippingDetails, aptInTransit);

  TBarcodeAction = class(TBaseBarcode)
  private
    procedure DisplayShippingDetails(const BarcodeValue: string);
    procedure SendEmailReport(const BarcodeValue: string);
    procedure PrintLabels(const SaleID, BoxNumber: Integer);
    function DoTranslate(Value: String): String;
  protected
    procedure HandleBarcodeEntry(const BarcodeText: string); override;
    function GetActionPrefixType(const Prefix: string): TActionPrefixType;// virtual;
  public
    procedure SetupDisplay; override;
  end;

implementation

uses
  CommonLib, CommonDbLib, DNMLib, EmailExtraUtils,
  PrintTemplateObj, MessageConst, AppEnvironment, FastFuncs, Forms, MySQLConst,
  tcDataUtils, LanguageTranslationObj, CorrespondenceObj;

{ TBarcodeAction }

procedure TBarcodeAction.DisplayShippingDetails(const BarcodeValue: string);
var
  SaleID: Integer;
  ShippingForm: TForm;
begin
  ShippingForm := TForm(GetComponentByClassName('TShippingDetailsGUI'));

  if Assigned(ShippingForm) then begin
    SaleID := StrToIntDef(BarcodeValue, 0);

    if SaleID > 0 then begin
      SendMessage(ShippingForm.Handle, TX_PerformStartup, SaleID, 0);

      if ShippingForm.ShowModal = mrOK then
        PrintLabels(SaleID, ShippingForm.Tag);
    end;

    ShippingForm.Release;
  end;
end;

function TBarcodeAction.GetActionPrefixType(const Prefix: string): TActionPrefixType;
begin
  if Sysutils.SameText(Prefix, 'SHIP') then
    Result := aptShippingDetails
  else if Sysutils.SameText(Prefix, 'TRANSIT') then
    Result := aptInTransit
  else
    Result := aptNone;
end;

procedure TBarcodeAction.HandleBarcodeEntry(const BarcodeText: string);
var
  Prefix: string;
  PrefixType: TActionPrefixType;
  BarcodeValue: string;
begin
  inherited;
  ExtractPrefixAndValue(BarcodeText, Prefix, BarcodeValue);
  PrefixType := GetActionPrefixType(Prefix);

  case PrefixType of
    aptShippingDetails:
    begin
      AssignValue(Dotranslate('Status'), Dotranslate('Scanned Shipping Details'));
      DisplayShippingDetails(BarcodeValue);
      AssignValue(Dotranslate('Status'), '');
    end;

    aptInTransit:
    begin
      AssignValue(Dotranslate('Status'), Dotranslate('Scanned In Transit'));
      SendEmailReport(BarcodeValue);
      AssignValue(Dotranslate('Status'), '');
    end;
  end;
end;
function TBarcodeAction.DoTranslate(Value:String):String;
begin
  Result := TLanguageTranslationObj.Inst.DoTranslate(Value , TLanguageTranslationObj.Inst.UserLanguageId, []);
end;

procedure TBarcodeAction.PrintLabels(const SaleID, BoxNumber: Integer);
var
  SQLPortion: string;
  PrintTemplate: TPrintTemplates;
begin
  PrintTemplate := TPrintTemplates.Create;

  try
    SQLPortion := ' AND (sd.SaleID = ' + IntToStr(SaleID) + ')';
    PrintTemplate.PrintTemplateReport('Delivery Labels', SQLPortion, not AppEnv.Employee.ShowPreview, BoxNumber);
  finally
    FreeandNil(PrintTemplate);
  end;
end;

procedure TBarcodeAction.SendEmailReport(const BarcodeValue: string);
var
  ClientID: Integer;
  ClientName: string;
  ReportType: string;
  TransactionID: string;
  UserID: string;
  TransactionDescription: string;
  SQLPortion: string;
  EmailDate: TDateTime;
  Corres: TCorrespondenceGui;
  PrintTemplates: TPrintTemplates;
  qryEmailedList: TERPQuery;
  lSilent, lSecret : boolean;
begin
  ReportType := 'Product In Transit';
  Corres := TCorrespondenceGui.Create;
  PrintTemplates := TPrintTemplates.Create;
  qryEmailedList := TERPQuery.Create(nil);
  try
    try
      SQLPortion := ' AND d3.SaleID = ' + BarcodeValue + ' ~|||~ WHERE SaleID = ' + BarcodeValue;
      PrintTemplates.SaveTemplateReport('Product In Transit', SQLPortion, False, 'PDF');
      ClientID := GetClientIDFromSale(StrToIntDef(BarcodeValue, 0));
      ClientName := GetClientName(ClientID);
      Corres.RecipientList := GetClientEmailAddress(ClientID);

        Corres.Subject := 'Product In Transit' + ' #' + BarcodeValue + ' for ' + ClientName;

        Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;
        Corres.AttachmentList.Add(GetCompanyName + ' ' + ReportType + ' #' + BarcodeValue + '.PDF');
        if not EmailShortSendMode(lSilent, lSecret) then
          exit;
        if Corres.Execute(lSilent, lSecret) then begin
          TransactionID := BarcodeValue;
          UserID := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
          EmailDate := Now;
          TransactionDescription := GetCompanyName + ' ' + ReportType + ' #' + BarcodeValue + ' for ' + ClientName;
          qryEmailedList.Connection := CommonDbLib.GetSharedMyDACConnection;
          qryEmailedList.SQL.Clear;
          qryEmailedList.SQL.Add('INSERT INTO tblEmailedReports (TransactionID, UserID, Date, ReportType, TransactionDescription) Values ("' + TransactionID + '","' +
                                 UserID + '", "' + FormatDateTime(MysqlDateFormat, EmailDate) + '", "' + ReportType + '", "' +
                                 TransactionDescription + '")');
          qryEmailedList.Execute;
        end;
        DeleteFiles( Commonlib.TempDir , '*.PDF');
    finally
      FreeandNil(Corres);
      FreeandNil(PrintTemplates);
      FreeandNil(qryEmailedList);
    end;
  except
    CommonLib.MessageDlgXP_Vista('There was an error sending the email', mtWarning, [mbOK], 0);
  end;
end;

procedure TBarcodeAction.SetupDisplay;
var
  CaptionList: TStringList;
begin
  FormCaption := Dotranslate('Barcode Action');
  PanelCaption := Dotranslate('Barcode Action');
  CaptionList := TStringList.Create;
  try
    CaptionList.Add(Dotranslate('Status'));
    CaptionList.Add(Dotranslate('Action'));
    AssignCaptions(CaptionList);
    AssignValue(Dotranslate('Action'), Dotranslate('Scan Barcode'));
    ShowForm;
  finally
    FreeandNil(CaptionList);
  end;
  inherited;
end;

initialization
  RegisterClassOnce(TBarcodeAction);
finalization
  UnRegisterClass(TBarcodeAction);
end.
