unit frmSTPTestLoad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls, Buttons,
  DNMSpeedButton, XMLDoc, XMLIntf, ComCtrls, wwdbdatetimepicker;

type
  TfmSTPTestLoad = class(TBaseForm)
    btnSubmit: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    edtFile: TEdit;
    btnLoadHeader: TBitBtn;
    Label2: TLabel;
    memFiles: TMemo;
    btnLoadFiles: TBitBtn;
    OpenDialog: TOpenDialog;
    Label3: TLabel;
    dtPaymentRecordTransactionD: TDateTimePicker;
    Label4: TLabel;
    dtMessageTimestampGenerationDt_Date: TDateTimePicker;
    dtMessageTimestampGenerationDt_Time: TDateTimePicker;
    Label5: TLabel;
    dtEmploymentStartD: TDateTimePicker;
    Label6: TLabel;
    dtStartD: TDateTimePicker;
    Label7: TLabel;
    dtEndD: TDateTimePicker;
    chkUpdate: TCheckBox;
    Label8: TLabel;
    dtPaymentRecordPaymentEffectiveD: TDateTimePicker;
    chkReplaceDates: TCheckBox;
    lblRecCount: TLabel;
    memTestCaseName: TMemo;
    Label9: TLabel;
    chkInvalidated: TCheckBox;
    Label10: TLabel;
    edtSignatureD: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLoadHeaderClick(Sender: TObject);
    procedure btnLoadFilesClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSubmitClick(Sender: TObject);
    procedure chkUpdateClick(Sender: TObject);
  private
    Doc: IXMLDocument;
    procedure LoadXML;
    procedure ChangeDates;
    procedure CreatePayRunRec;
    function GeneratePayRun: boolean;
    procedure GetHeaderRecordCount;

  public
    { Public declarations }
  end;

var
  fmSTPTestLoad: TfmSTPTestLoad;

  function LoadTestSTPData: boolean;


implementation

uses
  IdGlobalProtocols, MyAccess, CommonDbLib, AppEnvironment, DateTimeUtils,
  RandomUtils, JsonObject, JsonObjectUtils;

{$R *.dfm}

function LoadTestSTPData: boolean;
var
  form: TfmSTPTestLoad;
begin
  form := TfmSTPTestLoad.Create(nil);
  try
    result := form.ShowModal = mrOK;
  finally
    form.Free;
  end;
end;

function ConvertDate(aDate: TDateTime): string;
var
  t: TDateTime;
begin
  t := aDate;
  if AppEnv.PayPrefs.STPDatesinUTCFormat  then  begin
    t := t  - GetUTCOffset; // + TimeZoneBias;
    result := FormatDateTime('yyyy-mm-dd',t) + 'Z';
  end else begin
    result := FormatDateTime('yyyy-mm-dd',t) ;
  end;
end;

function ConvertDateTime(aDate: TDateTime): string;
var
  t: TDateTime;
begin
  t := aDate;
  if AppEnv.PayPrefs.STPDatesinUTCFormat  then  begin
    t:= t - GetUTCOffset; // + TimeZoneBias;
    result := FormatDateTime('yyyy-mm-dd',t) + 'T' + FormatDateTime('hh:nn:ss',t) + 'Z';
  end else begin
      result := FormatDateTime('yyyy-mm-dd',t) + 'T' + FormatDateTime('hh:nn:ss',t) ;
  end;
end;

procedure TfmSTPTestLoad.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfmSTPTestLoad.btnLoadFilesClick(Sender: TObject);
begin
  inherited;
  if OpenDialog.Execute  then
    memFiles.Text := OpenDialog.Files.Text;
end;

procedure TfmSTPTestLoad.btnLoadHeaderClick(Sender: TObject);
begin
  inherited;
  if OpenDialog.Execute  then begin
    edtFile.Text := OpenDialog.Files.Text;
    GetHeaderRecordCount;
  end;
end;

procedure TfmSTPTestLoad.btnSubmitClick(Sender: TObject);
begin
  inherited;
  if GeneratePayRun then
    ModalResult := mrOK;
end;

procedure TfmSTPTestLoad.ChangeDates;
var
  I, x: integer;
  node, Payee, Onboarding, Int, TermPay, EmployerConditions,
  Declaration, Rp: IXMLNode;
begin
  if not chkReplaceDates.Checked  then
    exit;

  for I := 0 to Doc.DocumentElement.ChildNodes.Count -1 do begin
    node := Doc.DocumentElement.ChildNodes[I];
    if SameText(node.NodeName, 'tns:PAYEVNT') then begin
      Rp := node.ChildNodes.FindNode('tns:Rp');
      if Assigned(Rp) then begin
        Rp.ChildNodes.FindNode('tns:Payroll').ChildValues['tns:PaymentRecordTransactionD'] :=
          ConvertDate(dtPaymentRecordTransactionD.Date);
        Rp.ChildNodes.FindNode('tns:Payroll').ChildValues['tns:MessageTimestampGenerationDt'] :=
          ConvertDateTime(Trunc(dtMessageTimestampGenerationDt_Date.Date) + Frac(dtMessageTimestampGenerationDt_Time.Time));
        Rp.ChildNodes.FindNode('tns:Declaration').ChildValues['tns:SignatureD'] := edtSignatureD.Text; //     ConvertDate(dtMessageTimestampGenerationDt_Date.Date);
//        Rp.ChildNodes.FindNode('tns:Payroll').ChildValues['tns:InteractionRecordCt'] := IntToStr(memFiles.Lines.Count);
      end;
      Int := node.ChildNodes.FindNode('tns:Int');
      if Assigned(Int) then begin
        Declaration := Int.ChildNodes.FindNode('tns:Declaration');
        if Assigned(Declaration) then begin
          if Assigned(Declaration.ChildNodes.FindNode('tns:SignatureD')) then begin
            if VarIsNull(Declaration.ChildValues['tns:SignatureD']) or (Declaration.ChildValues['tns:SignatureD'] = '') then
              Declaration.ChildValues['tns:SignatureD'] := edtSignatureD.Text; //ConvertDate(dtMessageTimestampGenerationDt_Date.Date);
          end;
        end;
      end;


    end
    else if SameText(node.NodeName, 'tns:PAYEVNTEMP') then begin
      Payee := node.ChildNodes.FindNode('tns:Payee');

      EmployerConditions := Payee.ChildNodes.FindNode('tns:EmployerConditions');

      if Assigned(EmployerConditions) then begin
        if Assigned(EmployerConditions.ChildNodes.FindNode('tns:EmploymentStartD')) then begin
          if VarIsNull(EmployerConditions.ChildValues['tns:EmploymentStartD']) or
             (EmployerConditions.ChildValues['tns:EmploymentStartD'] = '') then
            EmployerConditions.ChildValues['tns:EmploymentStartD'] := ConvertDate(dtEmploymentStartD.Date);
        end;
        if Assigned(EmployerConditions.ChildNodes.FindNode('tns:EmploymentEndD')) then begin
          if VarIsNull(EmployerConditions.ChildValues['tns:EmploymentEndD']) or
             (EmployerConditions.ChildValues['tns:EmploymentEndD'] = '') then
            EmployerConditions.ChildValues['tns:EmploymentEndD'] := ConvertDate(dtEndD.Date);
        end;
      end;

      Payee.ChildNodes.FindNode('tns:RemunerationIncomeTaxPayAsYouGoWithholding').ChildNodes.FindNode('tns:PayrollPeriod').ChildValues['tns:StartD'] := ConvertDate(dtStartD.Date);
      Payee.ChildNodes.FindNode('tns:RemunerationIncomeTaxPayAsYouGoWithholding').ChildNodes.FindNode('tns:PayrollPeriod').ChildValues['tns:EndD'] := ConvertDate(dtEndD.Date);

      node := Payee.ChildNodes.FindNode('tns:RemunerationIncomeTaxPayAsYouGoWithholding').ChildNodes.FindNode('tns:EmploymentTerminationPaymentCollection');
      if Assigned(node) then begin
        for x := 0 to node.ChildNodes.Count -1 do begin
          TermPay := node.ChildNodes[x];
            if Assigned(TermPay.ChildNodes.FindNode('PaymentRecordPaymentEffectiveD')) then
              TermPay.ChildNodes.FindNode('PaymentRecordPaymentEffectiveD').NodeValue := ConvertDate(dtPaymentRecordPaymentEffectiveD.Date);
        end;
      end;

      Onboarding := Payee.ChildNodes.FindNode('tns:Onboarding');
      if Assigned(Onboarding) then begin
        Onboarding.ChildNodes.FindNode('tns:Declaration').ChildValues['tns:SignatureD'] := ConvertDate(dtMessageTimestampGenerationDt_Date.Date);
      end;


    end
  end;
end;

procedure TfmSTPTestLoad.chkUpdateClick(Sender: TObject);
begin
  inherited;
  if chkUpdate.Checked then begin
    dtEndD.Date := dtStartD.Date;

  end
  else begin
    dtEndD.Date := dtStartD.Date + 7;

  end;
end;

procedure TfmSTPTestLoad.CreatePayRunRec;
var
  qry: TMyQuery;
  sl: TStringList;
  x: integer;
//  Json, obj: TJsonObject;
  s: string;
  Id: integer;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text := 'select * from tblPayRun where ID = 0';
    qry.Open;
    qry.Insert;
    qry.FieldByName('EmployeeID').AsInteger := AppEnv.Employee.EmployeeID;
    qry.FieldByName('EmployeeName').AsString := AppEnv.Employee.EmployeeName;
    qry.FieldByName('RunDate').AsDateTime := Date;
    qry.FieldByName('PaysProcessed').AsInteger := 0;
    if chkUpdate.Checked then
      qry.FieldByName('Submitted').AsBoolean := true;
    if chkInvalidated.Checked then
      qry.FieldByName('Invalidated').AsBoolean := true;
    qry.FieldByName('Notes').AsString := 'Conformance Test' + #13#10 +
       ChangeFileExt(ExtractFileName(edtFile.Text),'');
    sl := TStringList.Create;
    try
      sl.Text := Doc.DocumentElement.xml;
      sl.Delete(0);
      sl.Delete(sl.Count -1);
      for x := 0 to sl.Count -1 do begin
        while sl[x][1] = #9 do
          sl[x] := Copy(sl[x],2,Length(sl[x]));
      end;
      qry.FieldByName('ATOMessage').AsString := sl.Text;
    finally
      sl.Free;
    end;

    qry.Post;

    Id := qry.FieldByName('ID').AsInteger;

    qry.Close;
    qry.SQL.Text := 'select * from tblpayruntest';
    qry.Open;
    qry.Insert;
    qry.FieldByName('PayRunID').AsInteger := ID;
    qry.FieldByName('TestCaseName').AsString := ChangeFileExt(ExtractFileName(Trim(edtFile.Text)),'');
    qry.FieldByName('TestCaseDesc').AsString := memTestCaseName.Text;
    if chkUpdate.Checked then begin
      if chkInvalidated.Checked then
        qry.FieldByName('Service').AsString := 'Submit'
      else
        qry.FieldByName('Service').AsString := 'Update';
    end
    else
      qry.FieldByName('Service').AsString := 'Submit';

    qry.FieldByName('TestCaseFiles').AsString := ExtractFileName(Trim(edtFile.Text));
    for x := 0 to memFiles.Lines.Count -1 do begin
      s := ExtractFileName(Trim(memFiles.Lines[x]));
      qry.FieldByName('TestCaseFiles').AsString :=
        qry.FieldByName('TestCaseFiles').AsString + #13#10 + s;

    end;
    qry.Post;


//
//    { create test case record }
//    Json := JO;
//    try
//      if FileExists('stp_conf_tests.json') then
//        Json.LoadFromFile('stp_conf_tests.json');
//      obj := Json.O[IntToStr(qry.FieldByName('ID').AsInteger)];
//      obj.S['Test Case'] := ChangeFileExt(ExtractFileName(Trim(edtFile.Text)),'');
//      if chkUpdate.Checked then
//        obj.S['Service'] := 'Update'
//      else
//        obj.S['Service'] := 'Submit';
//      obj.S['Test Case Name'] := memTestCaseName.Text;
//      obj.A['PAYEVNTEMP Records'];
//      for x := 0 to memFiles.Lines.Count -1 do begin
//        s := Trim(memFiles.Lines[x]);
//        if s <> '' then begin
//          s := ChangeFileExt(ExtractFileName(s),'');
//          obj.A['PAYEVNTEMP Records'].Add(s);
//        end;
//      end;
//
//      JsonToFileFormated(Json,'stp_conf_tests.json');
//    finally
//      Json.Free;
//    end;

  finally
    qry.Free;
  end;
end;

procedure TfmSTPTestLoad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmSTPTestLoad.FormCreate(Sender: TObject);
begin
  inherited;
  Doc := TXMLDocument.Create(nil);
//  Doc.Options := Doc.Options - [doNodeAutoIndent];
//  Doc.ParseOptions := Doc.ParseOptions + [poPreserveWhiteSpace]+[poValidateOnParse];
//  Doc.NodeIndentStr := '';
  dtPaymentRecordTransactionD.DateTime := now;
  dtMessageTimestampGenerationDt_Date.DateTime := now;
  edtSignatureD.Text := ConvertDate(dtMessageTimestampGenerationDt_Date.Date);
  dtMessageTimestampGenerationDt_Time.DateTime := now;
  dtEmploymentStartD.Date := EncodeDate(1975,6,15);
  dtStartD.Date := now - 14;
  dtEndD.Date := dtStartD.Date + 7;
  dtPaymentRecordPaymentEffectiveD.DateTime := dtEndD.Date;
end;

function TfmSTPTestLoad.GeneratePayRun: boolean;
begin
  result := true;
  LoadXML;
  ChangeDates;
  CreatePayRunRec;
end;

procedure TfmSTPTestLoad.GetHeaderRecordCount;
var
  aDoc: IXMLDocument;
  stream: TStringStream;
  x: integer;
  PAYEVNT, RP: IXMLNode;
begin
  aDoc := TXMLDocument.Create(nil);
  stream := TStringStream.Create;
  try
    x := 0;
    aDoc.XML.Add('<?xml version="1.0" encoding="UTF-8"?>');
    aDoc.XML.Add('<ato>');
    stream.LoadFromFile(Trim(edtFile.Text));
    stream.Position := 0;
    aDoc.XML.Add(stream.DataString);
    aDoc.XML.Add('</ato>');
    aDoc.Active := true;
    PAYEVNT := aDoc.DocumentElement.ChildNodes.FindNode('tns:PAYEVNT');
    if Assigned(PAYEVNT) then begin
      Rp := PAYEVNT.ChildNodes.FindNode('tns:Rp');
      if Assigned(Rp) then begin
        if Assigned(Rp.ChildNodes.FindNode('tns:Payroll').ChildNodes.FindNode('tns:InteractionRecordCt')) then
          x := Rp.ChildNodes.FindNode('tns:Payroll').ChildValues['tns:InteractionRecordCt'];
      end;
    end;

    lblRecCount.Caption := 'Record Count: ' + IntToStr(x);
  finally
    stream.Free;
    aDoc := nil;
  end;

end;

procedure TfmSTPTestLoad.LoadXML;
var
  stream: TStringStream;
  I: integer;
  docNo: integer;
  docName: string;
begin
  stream := TStringStream.Create;
  try
    docName:= FormatDateTime('yyyymmddhhnnsszzz',now) + MakeRandomString(8);
    doc.Active := false;
    doc.XML.Clear;
    doc.XML.Add('<?xml version="1.0" encoding="UTF-8"?>');
    doc.XML.Add('<ato>');
    if memFiles.Lines.Count > 0 then
      doc.XML.Add('<Record_Delimiter DocumentID="'+docName+'" DocumentType="PARENT" DocumentName="PAYEVNT" RelatedDocumentID=""/>');
    stream.LoadFromFile(Trim(edtFile.Text));
    stream.Position := 0;
    doc.XML.Add(stream.DataString);
    docNo := 1;
    for I := 0 to memFiles.Lines.Count -1 do begin
      if memFiles.Lines[I] <> '' then begin
        Inc(docNo);
        doc.XML.Add('<Record_Delimiter DocumentID="'+docName + '.' +IntToStr(docNo)+'" DocumentType="CHILD" DocumentName="PAYEVNTEMP" RelatedDocumentID="'+docName+'"/>');
        stream.LoadFromFile(Trim(memFiles.Lines[I]));
        stream.Position := 0;
        doc.XML.Add(stream.DataString);
      end;
    end;
    doc.XML.Add('</ato>');
    doc.Active := true;
  finally
    stream.Free;
  end;
end;

end.
