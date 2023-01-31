unit BusObjPayRun;


interface


uses
   BusObjBase, DB, Classes, MyAccess, ConTnrs, XMLIntf, BusObjPayBase, ErpDBComponents;

type
   TPaySlips = array of TPayBase;

type

   TPayRun = class(TMSBusObj)

   private

   //   fSTPversion: string;

      fPayBase: TPayBase;

      fPaySlips: TPayBase;
      // fPaySlips : TPaySlips;

      procedure SetEmployeeID(const Value: integer);
      procedure SetEmployeeName(const Value: string);
      procedure SetFinancialYearFinalRun(const Value: Boolean);
      procedure SetInvalidated(const Value: Boolean);
      procedure SetNotes(const Value: string);
      procedure SetPaysProcessed(const Value: integer);
      procedure SetRunDate(const Value: TDateTime);
      procedure SetSubmitted(const Value: Boolean);
      procedure SetSubmittedDate(const Value: TDateTime);
      function GetEmployeeID: integer;

      function GetEmployeeName: string;

      function GetEmployeeFirstName: string;
      function GetEmployeeLastName: string;
      function GetEmployeeCompany: string;
      function GetEmployeeLastUpdated: TDateTime;
      function GetEmployeeWages: Double;
      function GetEmployeeTax: Double;
      function GetEmployeeSuper: Double;
      function GetEmployeeNet: Double;
      function GetEmployeeActive: Boolean;

      function GetPaySlips: TPayBase;

      function GetPayEmployeeEarnings: string;

      function GetTaxScale(id: integer): string;

      function GetFinancialYearFinalRun: Boolean;
      function GetInvalidated: Boolean;
      function GetNotes: string;
      function GetPaysProcessed: integer;
      function GetRunDate: TDateTime;
      function GetSubmitted: Boolean;
      function GetSubmittedDate: TDateTime;
      procedure SetComplete(const Value: Boolean);
      procedure SetMessageStatus(const Value: string);
      procedure SetMessageType(const Value: string);
      procedure SetMessageUuid(const Value: string);
      function GetComplete: Boolean;
      function GetMessageStatus: string;
      function GetMessageType: string;
      function GetMessageUuid: string;
      function GetATOMessage: string;
      function GetATOResponse: string;
      function GetOriginalRef: string;
      procedure SetATOMessage(const Value: string);
      procedure SetATOResponse(const Value: string);
      procedure SetOriginalRef(const Value: string);
      function GetLastCheckTime: TDateTime;
      procedure SetLastCheckTime(const Value: TDateTime);
      function getOriginalID: integer;
      function PayrunIDFilter: String;
      function MakeNewRunForUpdate: Boolean;

   protected
      function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;

   public
      ErrorList: TObjectList;
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; override;
      class function GetKeyStringField: string; override;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      function ValidateData: Boolean; override;
      function Save: Boolean; override;
      class function AddPayToRun(var PayBatchID: integer; Connection: TCustomMyConnection;
        var msg: string): Boolean;
      class function DeletePayInRun(var PayBatchID: integer; Connection: TCustomMyConnection;
        var msg: string): Boolean;
      function CreateEventDocs(DocList: IInterfaceList; var msg: string; query: TERPQuery): Boolean; overload;
      function CreateEventDocs(const aOutFileName: string; var msg: string; query: TERPQuery): Boolean; overload;
      function Payrundata(query: TERPQuery): String;
      procedure AddNote(const msg: string);
      class function PopulateErrorList(ds: TDataset; aErrorList: TObjectList): string;
      class function LoadResponsePayloadFile(aFileName: string; ds: TDataset;
        aErrorList: TObjectList): string;
      function GetABNFromATOMessage: string;
      function PopulateErrors: string;
      procedure DoFieldOnChange(Sender: TField); override;
      class function CheckRunStatus(aPayRunID: integer; aConn: TMyConnection;
        aErrorList: TObjectList; var NewMessageStatus: string;
        ShowProgressDialog: Boolean = true): string;
      function IsLastForFinancialYear: Boolean;

   published

  //    property STPversion : string read fSTPversion write fSTPversion;

      property EmployeeID: integer read GetEmployeeID write SetEmployeeID;
      property EmployeeName: string read GetEmployeeName write SetEmployeeName;

      property PayRunDetailsEmployeeFirstName: string read GetEmployeeFirstName;
      property PayRunDetailsEmployeeLastName: string read GetEmployeeLastName;
      property PayRunDetailsEmployeeGroup: string read GetEmployeeCompany;
      property PayRunDetailsEmployeeLastEdited: TDateTime read GetEmployeeLastUpdated;
      property PayRunDetailsEmployeeEarnings: Double read GetEmployeeWages;
      property PayRunDetailsEmployeeTax: Double read GetEmployeeTax;
      property PayRunDetailsEmployeeSuperannuation: Double read GetEmployeeSuper;
      property PayRunDetailsEmployeeNetPay: Double read GetEmployeeNet;
      property PayRunDetailsEmployeeActive: Boolean read GetEmployeeActive;

      property PaySlipEmployeeEarnings: string read GetPayEmployeeEarnings;

      property PaySlips: TPayBase read GetPaySlips;

      property RunDate: TDateTime read GetRunDate write SetRunDate;
      property Submitted: Boolean read GetSubmitted write SetSubmitted;
      property SubmittedDate: TDateTime read GetSubmittedDate write SetSubmittedDate;
      property PaysProcessed: integer read GetPaysProcessed write SetPaysProcessed;
      property Invalidated: Boolean read GetInvalidated write SetInvalidated;
      property FinancialYearFinalRun: Boolean read GetFinancialYearFinalRun
        write SetFinancialYearFinalRun;
      property Notes: string read GetNotes write SetNotes;
      property MessageUuid: string read GetMessageUuid write SetMessageUuid;
      property MessageType: string read GetMessageType write SetMessageType;
      property MessageStatus: string read GetMessageStatus write SetMessageStatus;
      property Complete: Boolean read GetComplete write SetComplete;
      property ATOMessage: string read GetATOMessage write SetATOMessage;
      property ATOResponse: string read GetATOResponse write SetATOResponse;
      property OriginalRef: string read GetOriginalRef write SetOriginalRef;
      property LastCheckTime: TDateTime read GetLastCheckTime write SetLastCheckTime;
      Property OriginalID: integer read getOriginalID;

   end;

   TErrorItem = class(TObject)
   private
      FPayID: integer;
      FEmployeeName: string;
      FEmployeeID: integer;
      FErrorLocation: string;
      FSeverityCode: string;
      FErrorMessage: string;
      fLocationInstanceIdentifier: string;
   public
      procedure PopulateFromNode(node: IXMLNode; conn: TCustomMyConnection);
      procedure Assign(aSource: TErrorItem);
      function RecordNumber: integer;
      property PayID: integer read FPayID write FPayID;
      property EmployeeID: integer read FEmployeeID write FEmployeeID;
      property SeverityCode: string read FSeverityCode write FSeverityCode;
      property EmployeeName: string read FEmployeeName write FEmployeeName;
      property ErrorLocation: string read FErrorLocation write FErrorLocation;
      property ErrorMessage: string read FErrorMessage write FErrorMessage;
      property LocationInstanceIdentifier: string read fLocationInstanceIdentifier
        write fLocationInstanceIdentifier;
   end;



   type

      TSTPPayRun = class(TPayRun)

   end;




implementation


{$DEFINE STP_VERSION3}


uses
   AppEnvironment, SysUtils, BusObjEmployee, StringUtils,  Generics.Collections,

{$IFDEF STP_VERSION4}
   atopayevnt000420200101, atopayevntemp000420200101,
{$ENDIF}

{$IFDEF STP_VERSION3}
   atopayevnt000320180100, atopayevntemp000320180100,
{$ENDIF}

   BusObjEmployeeDetails,

   // BusObjPayBase,

   DnmLib, DateUtils, DateTimeUtils, BusObjPaysSuperannuation,
   PayCommon, BusObjCountries, XMLDoc, ActiveX, XMLHelperUtils, CommonDbLib,
   Variants, RandomUtils, ProgressDialog, JsonObject,
   OzEDI_STP2,
   // UTOzEDIStub,
   MessageDlgXP_Vistaobj, Dialogs, CommonLib, LogLib, tcConst,
   DbSharedObjectsObj, StrUtils;

function ConvertDate(aDate: TDateTime): string;
var
   t: TDateTime;
begin
   t := aDate;
   if AppEnv.PayPrefs.STPDatesinUTCFormat then
      t := t - GetUTCOffset; // + TimeZoneBias;
   result := FormatDateTime('yyyy-mm-dd', t) + 'Z';
end;

function ConvertDateTime(aDate: TDateTime): string;
var
   t: TDateTime;
begin
   t := aDate;
   if AppEnv.PayPrefs.STPDatesinUTCFormat then
      t := t - GetUTCOffset; // + TimeZoneBias;
   result := FormatDateTime('yyyy-mm-dd', t) + 'T' + FormatDateTime('hh:nn:ss', t) + 'Z';
end;

{ TPayRun }

procedure TPayRun.AddNote(const msg: string);
begin
   if Notes <> '' then
      Notes := Notes + #13#10;
   Notes := Notes + FormatDateTime('dd mmm yy hh:nn:ss', now) + ' ' + msg;

end;


{$R+}
class function TPayRun.AddPayToRun(var PayBatchID: integer; Connection: TCustomMyConnection;
  var msg: string): Boolean;
var
   inst: TPayRun;
begin
   result := true;
   try
      inst := TPayRun.CreateWithNewConn(nil);
      try
         inst.Connection.Connection := Connection;

        //   inst.Connection.debuginfoforconnection := false;


   //      ShowMessage('loading Payrun');



         inst.Load(PayBatchID);

   //      ShowMessage('loaded Payrun');

         if PayBatchID = 0 then
         begin
            { new run }
            inst.New;
            inst.PaysProcessed := 1;
            if not inst.Save then
            begin
               result := false;
               msg := inst.ResultStatus.Messages;

                  //        ShowMessage('new run ' + msg);

               exit;
            end;
            PayBatchID := inst.id;
         end
         else
         begin
            { existing run }
            if inst.Submitted then
            begin
               { can't add to a submitted run .. so create new }
               inst.Load(0);
               inst.New;
            end;
            inst.PaysProcessed := inst.PaysProcessed + 1;
            if not inst.Save then
            begin
               result := false;
               msg := inst.ResultStatus.Messages;

                //             ShowMessage('existing run ' + msg);


               exit;
            end;
            PayBatchID := inst.id;
         end;
      finally
         inst.Free;
      end;
   except
      on e: exception do
      begin

         //       ShowMessage('exception in AddPayToRun' + msg + '  trace ' + e.StackTrace );

         result := false;
         msg := e.Message;

         // (EAccessViolation(e)).ExceptionRecord.ExceptObject.


      end;
   end;
end;


class function TPayRun.CheckRunStatus(aPayRunID: integer; aConn: TMyConnection;
  aErrorList: TObjectList; var NewMessageStatus: string; ShowProgressDialog: Boolean): string;
var
   Prog: TProgressDialog;
   Json: TJsonObject;
   s: string;

   ozedi: TOzEDI2;
   // ozedi: TOzEDI;

   I, msgNo: integer;
   IsConformanceTest: Boolean;
   qryPayRun, qry, qryPrefs: TMyQuery;

   function GetResponse: string;
   var
      PayLoadFileName: string;
   begin
      result := '';
      PayLoadFileName := ozedi.GetResponsePayload(qryPayRun.FieldByName('MessageUuid').AsString);
      result := LoadResponsePayloadFile(PayLoadFileName, qryPayRun, aErrorList);
      if result <> '' then
      begin
         if Assigned(Prog) then
         begin
            Prog.CloseDialog;
            TMessageDlgXP_Vista.NewMessageDlgXP_Vista
              ('Pay Rum ' + DateTimeToStr(qryPayRun.FieldByName('SubmittedDate').AsDateTime) +
              ' has been Processed by the ATO but errors where found.', mtInformation, [mbOK], 0);
         end;
         exit;
      end
      else
      begin
         qryPayRun.FieldByName('Complete').ASBoolean := true;
         qryPayRun.FieldByName('Invalidated').ASBoolean := false;
      end;
   end;

begin
   result := '';
   IsConformanceTest := false;

   NewMessageStatus := '';
   Prog := nil;
   if ShowProgressDialog then
      Prog := TProgressDialog.Create(nil);
   Json := JO;
   qryPayRun := TMyQuery.Create(nil);
   try
      qryPayRun.Connection := aConn;
      qryPayRun.SQL.Text := 'select * from tblPayRun where ID = ' + IntToStr(aPayRunID);
      qryPayRun.Open;
      qryPayRun.Edit;
      if (qryPayRun.FieldByName('PaysProcessed').AsInteger = 0) and
        (Pos('Conformance Test', qryPayRun.FieldByName('Notes').AsString) = 1) then
      begin
         IsConformanceTest := true;
      end;
      if Assigned(Prog) then
      begin
         Prog.Caption := 'Checking Pay Run';
         Prog.MaxValue := 100;
         Prog.ShowPercent := true;
         Prog.TimerUpdate := true;
         Prog.Execute;
      end;

      ozedi := TOzEDI2.Create;


      try
         qryPrefs := TMyQuery.Create(nil);
         try
            qryPrefs.Connection := aConn;
            qryPrefs.SQL.Text := 'select * from tbldbpreferences where Name = :PrefName';
            qryPrefs.ParamByName('PrefName').AsString := 'OzEDITestMode';
            qryPrefs.Open;
            ozedi.SandpitMode := qryPrefs.FieldByName('FieldValue').AsString = 'T';
            qryPrefs.Close;
            qryPrefs.ParamByName('PrefName').AsString := 'OzEdiClientID';
            qryPrefs.Open;
            ozedi.ClientID := qryPrefs.FieldByName('FieldValue').AsString;
            qryPrefs.Close;
            qryPrefs.SQL.Text := 'select ABN from tblcompanyinformation';
            qryPrefs.Open;
            ozedi.ABN := qryPrefs.FieldByName('ABN').AsString;
         finally
            qryPrefs.Free;
         end;


//           ozedi.ClientID         := '90922671';
//           ozedi.SandPitMode := true;
//           ozedi.UserSandpit := 'api@erpoz.com';
//           ozedi.PassSandpit := 'erpapi1';


         try
            if not SameText(qryPayRun.FieldByName('MessageStatus').AsString, 'RESPONDED') then
            begin



               s := ozedi.GetMessageStatus(qryPayRun.FieldByName('MessageUuid').AsString);
               Json.AsString := s;


               if qryPayRun.FieldByName('MessageStatus').AsString <> Json.s['messageStatus'] then
               begin
                  qryPayRun.FieldByName('MessageStatus').AsString := Json.s['messageStatus'];
                  NewMessageStatus := Json.s['messageStatus'];
               end;
               if SameText(qryPayRun.FieldByName('MessageStatus').AsString,
                 'NORESPONSEAVAILABLE') then
               begin

                  if Assigned(Prog) then
                     Prog.Value := 25;

                  result := GetResponse;

               end;
            end;

            try
               if SameText(qryPayRun.FieldByName('MessageStatus').AsString, 'RESPONDED') then
               begin
                  { now get the response and make sure everything is ok ... }
                  if Assigned(Prog) then
                     Prog.Value := 50;

                  result := GetResponse;

               end;
            finally
               if IsConformanceTest then
               begin
                  qry := TMyQuery.Create(nil);
                  try
                     qry.Connection := aConn;
                     qry.SQL.Text := 'select * from tblpayruntest where PayRunID = ' +
                       IntToStr(aPayRunID);
                     qry.Open;
                     qry.Edit;
                     qry.FieldByName('TestErrors').AsString := '';
                     if result = '' then
                     begin
                        qry.FieldByName('TestResult').AsString := 'Successful';

                     end
                     else
                     begin
                        qry.FieldByName('TestResult').AsString := result;
                     end;

                     s := '';
                     for I := 0 to aErrorList.Count - 1 do
                     begin
                        if s <> '' then
                           s := s + #13#10;

                        if TErrorItem(aErrorList[I]).SeverityCode <> 'Information' then
                        begin

                           s := s + 'Severity: ' + TErrorItem(aErrorList[I]).SeverityCode + #13#10 +
                             '  Message: ' + TErrorItem(aErrorList[I]).ErrorMessage;
                           if TErrorItem(aErrorList[I]).ErrorLocation <> '' then
                              s := s + #13#10 + '  Location: ' + TErrorItem(aErrorList[I])
                                .ErrorLocation;
                        end;
                        qry.FieldByName('TestErrors').AsString := s;
                     end;

                     qry.Post;
                  finally
                     qry.Free;
                  end;
               end;
               qryPayRun.FieldByName('LastCheckTime').AsDateTime := now;
            end;

            if Assigned(Prog) then
            begin
               Prog.CloseDialog;
               if qryPayRun.FieldByName('Complete').ASBoolean then
               begin
                  { pay run processing complete }
                  TMessageDlgXP_Vista.NewMessageDlgXP_Vista
                    ('Pay Rum ' + DateTimeToStr(qryPayRun.FieldByName('SubmittedDate').AsDateTime) +
                    ' has been Processed and Accepted by the ATO', mtInformation, [mbOK], 0);
               end
               else if NewMessageStatus <> '' then
               begin
                  { status has changed .. }
                  TMessageDlgXP_Vista.NewMessageDlgXP_Vista
                    ('Pay Rum ' + DateTimeToStr(qryPayRun.FieldByName('SubmittedDate').AsDateTime) +
                    ' message Status has changed to ' + NewMessageStatus, mtInformation, [mbOK], 0);
               end
               else
               begin
                  { no change .. }
                  TMessageDlgXP_Vista.NewMessageDlgXP_Vista
                    ('Pay Rum ' + DateTimeToStr(qryPayRun.FieldByName('SubmittedDate').AsDateTime) +
                    ' not yet processed by the ATO.', mtInformation, [mbOK], 0);
               end;
            end;

         except
            on e: exception do
            begin
               result := 'Error';
               if Assigned(Prog) then
               begin
                  Prog.CloseDialog;
                  TMessageDlgXP_Vista.NewMessageDlgXP_Vista('Error getting pay run message ststus: '
                    + #13#10 + #13#10 + e.Message, mtWarning, [mbOK], 0);
               end;
            end;
         end;
      finally
         ozedi.Free;
      end;
   finally
      qryPayRun.Post;
      qryPayRun.Free;
      Prog.Free;
      Json.Free;
   end;
end;

constructor TPayRun.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fBusObjectTypeDescription := 'PayRun';
   fSQL := 'SELECT * FROM tblpayrun';
   ErrorList := TObjectList.Create;
end;


function TPayRun.CreateEventDocs(const aOutFileName: string; var msg: string; query: TERPQuery): Boolean;
var
   docs: IInterfaceList;
   stream: TStringStream;
   Writer: TStreamWriter;
   I: integer;
   docName: string;
begin

   if true then
 //  if (not Invalidated) and Submitted then
   begin

      if not MakeNewRunForUpdate then
         exit;
   end;

   docs := TInterfaceList.Create;
   try
      result := CreateEventDocs(docs, msg, query);
      docName := FormatDateTime('yyyymmddhhnnsszzz', now) + MakeRandomString(8);
      if not result then
         exit;
      stream := TStringStream.Create;
      Writer := TStreamWriter.Create(stream);
      try
         Writer.WriteLine('<Record_Delimiter DocumentID="' + docName +
           '" DocumentType="PARENT" DocumentName="PAYEVNT" RelatedDocumentID=""/>');

{$IFDEF STP_VERSION4}
     //    if STP_VERSION = '4' then
         begin
            IXMLNode(docs[0]).SetAttribute('xsi:schemaLocation',
              'http://www.sbr.gov.au/ato/payevnt ato.payevnt.0004.2020.01.01.xsd');
            IXMLNode(docs[0]).SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
         end;
{$ENDIF}

         Writer.WriteLine(IXMLNode(docs[0]).XML);

         for I := 1 to docs.Count - 1 do
         begin
            Writer.WriteLine('<Record_Delimiter DocumentID="' + docName + '.' + IntToStr(I + 1) +
              '" DocumentType="CHILD" DocumentName="PAYEVNTEMP" RelatedDocumentID="' +
              docName + '"/>');

{$IFDEF STP_VERSION4}
      //      if STP_VERSION = '4' then
            begin
               IXMLNode(docs[I]).SetAttribute('xsi:schemaLocation',
                 'http://www.sbr.gov.au/ato/payevntemp ato.payevntemp.0004.2020.01.01.xsd');
               IXMLNode(docs[I]).SetAttribute('xmlns:xsi',
                 'http://www.w3.org/2001/XMLSchema-instance');
            end;
{$ENDIF}

            Writer.WriteLine(IXMLNode(docs[I]).XML);
         end;

         stream.Position := 0;
         ATOMessage := stream.DataString;
         PostDB;
         stream.Position := 0;
         stream.SaveToFile(aOutFileName);
         if not fileExists(aOutFileName) then
            beep;
      finally
         Writer.Free;
         stream.Free;
      end;
   finally
      docs := nil;
   end;
end;

function TPayRun.Payrundata(query: TERPQuery): String;
var
   docs: IInterfaceList;
   I: integer;
   msg: string;
begin
   result := '';
   docs := TInterfaceList.Create;
   try
      CreateEventDocs(docs, msg, query);
      result := '<STP>';
      if docs.Count > 0 then
      begin
         for I := 0 to docs.Count - 1 do
         begin
            result := result + IXMLNode(docs[I]).XML;
         end;
      end;
      result := result + '</STP>';
   finally
      docs := nil;
   end;
end;


Function TPayRun.PayrunIDFilter: String;
begin
   result := '(PayRunID = ' + IntToStr(id) + ' or (tblPays.PayRunID = ' + IntToStr(OriginalID) +
     '  and ' + IntToStr(OriginalID) + ' >0)) ';
end;



Function TPayRun.MakeNewRunForUpdate: Boolean;
var
   qry: TERPQuery;
begin
   result := true;
   if (not Invalidated) and Submitted then
   else
      exit;

   qry := SharedQuery;
   try
      qry.SQL.Text :=
        'Select * from tblpayrun where ifnull(OriginalRef, "") <> "" and  ifnull(OriginalRef, "") = '
        + Quotedstr(Globalref);
      qry.Open;
      if qry.recordcount > 0 then
      begin
         MessageDlgXP_Vista('This Payrun (ID # ' + IntToStr(Self.id) +
           ' ) is already updated and resubmitted (ID#  ' + IntToStr(qry.FieldByName('ID')
           .AsInteger) + ' ).' + NL + 'It is not possible to re-submit this Run Again. ' + NL +
           'Please Re-Submit the Run #   ' + IntToStr(qry.FieldByName('ID').AsInteger) + '.',
           mtWarning, [mbOK], 0);
         result := false;
         exit;
      end;
      with TPayRun.Create(nil) do
         try
            Connection := Self.Connection;
            Load(0);
            New;

            RunDate := Self.RunDate;
            PaysProcessed := Self.PaysProcessed;

            Invalidated := Self.Invalidated;

            Submitted := Self.Submitted;

            FinancialYearFinalRun := Self.FinancialYearFinalRun;
            Notes := Self.Notes;
            OriginalRef := Self.Globalref;
            PostDB;
            Logtext('OriginalRef:' + OriginalRef);
            Self.Notes := Self.Notes + NL + 'Resubmitted on ' + FormatDateTime(Shortdateformat,
              date) + ' ID#' + IntToStr(id);
            Self.PostDB;
            Self.Load(id);
            Logtext('ID:' + IntToStr(Self.id) + ', OriginalRef:' + Self.OriginalRef);
         finally
            Free;
         end;
      result := true;
   finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
   end;

end;



function IsValidPostcode(s: string): Boolean;
var
  n:Integer;
begin
  result := true;

  if not (Length(s) = 4) then
  begin
      result := false;
      exit;
  end;

  for n := 1 to Length(s) do
  begin
    if (s[n] < '0') or (s[n] > '9') then
    begin
       result := false;
       exit;
    end;
  end;

end;



function TPayRun.CreateEventDocs(DocList: IInterfaceList; var msg: string; query: TERPQuery): Boolean;
var
   payevnt: IXMLPAYEVNT;
   PayEmp: IXMLPAYEVNTEMP;

{$IFDEF STP_VERSION4}
   Remuneration: IXMLRemuneration;
   PaidLeave: IXMLPaidLeave;
   SalarySacrifice: IXMLSalarySacrifice;
   LumpSumPayment: IXMLLumpSum;
{$ENDIF}

   qry, tmpQry: TERPQuery;
   lastPayQry : TERPQuery;

   YearFinal : Boolean;

   emp: TEmployeeDetails;
   pay: TPayBase;
   year, month, day: word;
   finYearStart, finYearEnd: TDateTime;

   allowanceCode: string;

   TerminationPayment: IXMLEmploymentTerminationPayment;
   Allowance: IXMLAllowance;
   SuperannuationContribution: IXMLSuperannuationContribution;
   FringeBenefits: IXMLIncomeFringeBenefitsReportable;

   ChildRecordCount: integer;
   AllowanceDescription: string;
   Deduction: IXMLDeduction;
   totalGross: Double;
   totalTax: Double;
   totalChildSupportGarnishee: Double;
   totalChildSupportWithholdingAmount: Double;
   TaxOffset: Double;
   CountryShortCode: string;
   PaymentRecordTransactionDate: TDateTime;
   IsUpdate: Boolean;
   PayGross: Double;
   PayGrossYTD: Double;

   withNewSTPfields: Boolean;

   EmployeeLastDatePaid : TDictionary<Integer, TDateTime> ;
   LastDatePaid : TDateTime;
   EmployeeID : Integer;


   PeriodEndDate : TDateTime;

   function FormatAmount(amt: Double): string;
   begin
      result := FormatFloat('#0.00', Round(amt, 2));
   end;

begin

   withNewSTPfields := true;

   result := true;

   try
      ChildRecordCount := 0;
      totalGross := 0;
      totalTax := 0;
      totalChildSupportGarnishee := 0;
      totalChildSupportWithholdingAmount := 0;
      TaxOffset := 0;
      finYearStart := FiscalYearStart(RunDate, AppEnv.CompanyPrefs.FiscalYearStarts);
      finYearEnd := IncYear(finYearStart, 1) - 1;

      PaymentRecordTransactionDate := 0;

      IsUpdate := (not Invalidated) and Submitted;

//      if IsUpdate then
//         ShowMessage('IsUpdate')
//      else
//         ShowMessage('New');

      (* if IsUpdate then
        if not MakeNewRunForUpdate then exit; *)

      qry := TERPQuery.Create(nil);
      tmpQry := TERPQuery.Create(nil);
      lastPayQry := TERPQuery.Create(nil);


      emp := TEmployeeDetails.CreateWithSharedConn(nil);
      pay := TPayBase.CreateWithSharedConn(nil);

      try
         qry.Connection := Self.Connection.Connection;
         tmpQry.Connection := Self.Connection.Connection;
        lastPayQry.Connection := Self.Connection.Connection;

         { list of pays in this run .. }
         if query = nil then
         begin
            qry.SQL.Text := 'select * from tblpays ' + ' where  ' + PayrunIDFilter +
                             ' and Deleted = "F"' ;

            YearFinal := false;
         end
         else
         begin

     //       qry := query;
            qry.SQL.Text := query.SQL.Text;
            qry.ParamByName('Start').AsString := query.ParamByName('Start').AsString;
            qry.ParamByName('End').AsString := query.ParamByName('End').AsString;

            YearFinal := true;
         end;


      //   ShowMessage('qry.SQL.Text  : ' + qry.SQL.Text);

         qry.Open;
         clog('', 'd:\erp.XML');

    //     ShowMessage('qry.recordcount  ' + IntToStr(qry.recordcount));

         if qry.recordcount = 0 then
         begin
            Logtext(qry.SQLtext);
            result := false;
            msg := ' Pay Run #' + IntToStr(id) + ' Has No Active Pays.' + NL +
              'You Can Submit the Latest Active Pay [All Submissions are Year To Date]. ';
            exit;
         end
         else
         begin

         //   showProgress('Processing pays ', qry.recordcount + 5);
            if YearFinal then
            begin

               EmployeeLastDatePaid := TDictionary<Integer, TDateTime>.Create;


               tmpQry.SQL.Text := 'SELECT DISTINCT EmployeeID FROM tblpays';
               tmpQry.Open;

          //     ShowMessage('tmpQry.RecordCount ' + IntToStr(tmpQry.RecordCount));

               while not tmpQry.Eof do
               begin

                 lastPayQry.SQL.Text := 'SELECT MAX(DatePaid) AS LastDatePaid FROM tblpays '
                                      + ' WHERE EmployeeID = ' + tmpQry.FieldByName('EmployeeID').AsString
                                      + ' AND DatePaid >= "2021-07-01" AND DatePaid <= "2022-06-30"  '
                                     ;


                 lastPayQry.Open;




                   EmployeeID :=  tmpQry.FieldByName('EmployeeID').AsInteger;
                   LastDatePaid := lastPayQry.FieldByName('LastDatePaid').AsDateTime;


           //        ShowMessage('LastDatePaid ' +     DateTimeToStr(LastDatePaid) + ' PeriodEndDate ' + DateTimeToStr(PeriodEndDate));

                   if LastDatePaid > PeriodEndDate then
                           PeriodEndDate :=  LastDatePaid;


         //          ShowMessage('EmployeeID ' + IntToStr(EmployeeID) + '  LastDatePaid ' + DateTimeToStr(LastDatePaid));


   //               if (EmployeeLastDatePaid.TryGetValue(EmployeeID, LastDatePaid) = True) then
   //               begin
   //
   //                     EmployeeLastDatePaid.AddOrSetValue(EmployeeID, LastDatePaid);
   //
   //
   //               end
   //               else
   //               begin

                     EmployeeLastDatePaid.Add(EmployeeID, LastDatePaid);
   //               end;

                  tmpQry.Next;
               end;

            end;

       //     LastPayDate := TDateTime.Create;


//            while not qry.Eof do
//            begin
//
//               pay.Load(qry.FieldByName('PayID').AsInteger);
//
//               if (EmployeeLastPayDate.TryGetValue(pay.EmployeeID, LastPayDate) = True) then
//               begin
//
//                  if pay.PayDate > LastPayDate then
//                  begin
//                     LastPayDate := pay.PayDate;
//                     EmployeeLastPayDate.AddOrSetValue(pay.EmployeeID, LastPayDate);
//
//                  end;
//
//               end
//               else
//               begin
//
//                  EmployeeLastPayDate.Add(pay.EmployeeID, pay.PayDate);
//               end;
//
//               stepProgress('Employee ' + IntToStr(pay.EmployeeID) + '   Pay ' + IntToStr(pay.PayID));
//          //     stepProgress('Employee  ' + IntToStr(pay.EmployeeID) + '   Pay ' + IntToStr(pay.PayID) + '   LastPayDate ' + DateTimeToStr(LastPayDate));
//
//               qry.Next;
//            end;
//
//            qry.First;


            showProgress('Creating documents for pays in the payrun ', qry.recordcount + 5);


            try


               while not qry.Eof do
               begin

                  emp.Load(qry.FieldByName('EmployeeID').AsInteger);
                  pay.Load(qry.FieldByName('PayID').AsInteger);

               //    ShowMessage('pay.EmployeeID ' + IntToStr(pay.EmployeeID) + '  DatePaid ' +  DateTimeToStr(pay.DatePaid) );


                  if (YearFinal and (EmployeeLastDatePaid.TryGetValue(pay.EmployeeID, LastDatePaid) = True)) then
                  begin


                //   ShowMessage('EmpID ' + IntToStr(pay.EmployeeID) + '  DatePaid ' +  DateTimeToStr(pay.DatePaid) + '  LastDatePaid ' + DateTimeToStr(LastDatePaid));


                     if pay.DatePaid < LastDatePaid then
                     begin
                //        stepProgress('skip Empl '+ IntToStr(pay.EmployeeID) + '  PayDate ' + DateTimeToStr(pay.DatePaid)  + '   LastPayDate ' + DateTimeToStr(LastDatePaid));

                      stepProgress;

                        qry.Next;

                        continue;
                     end;



                  end;

             //     ShowMessage('creating record for pay.EmployeeID ' + IntToStr(pay.EmployeeID) + '   LastPayDate ' + DateTimeToStr(LastPayDate));


                  Inc(ChildRecordCount);

                  if PaymentRecordTransactionDate = 0 then
                  begin
                     (* For Submit event, this is the date on which the PAYG withholding for the Payroll Submit Event occurred.
                       It is used to determine what PAYGW period the Payer Gross and PAYGW amounts are to be applied.
                       For Update Event this is the As At date. It must be any date within the financial year that is being updated. *)
                     if IsUpdate then
                     begin
                        { Update }
                        { any date within the financial year that is being updated }
                        PaymentRecordTransactionDate := pay.DatePaid;
                     end
                     else
                     begin
                        { Submit }
                        { date on which the PAYG withholding for the Payroll Submit Event occurred }
                        PaymentRecordTransactionDate := pay.DatePaid;
                     end;

                     // just to get the end of the day  - this is to deal with the datepaid is getting changed to the previous date when converted to UTC.
                     // problem for beri
                     if trunc(PaymentRecordTransactionDate) = PaymentRecordTransactionDate then
                        PaymentRecordTransactionDate :=
                          incsecond(incday(PaymentRecordTransactionDate, 1), -1);

                     if PaymentRecordTransactionDate > now then
                        PaymentRecordTransactionDate := incsecond(now, -1);
                     if PaymentRecordTransactionDate > RunDate then
                        PaymentRecordTransactionDate := incsecond(RunDate, -1);
                  end;

             //     if YearFinal then



                  PayEmp := NewPAYEVNTEMP;
                  DocList.Add(PayEmp);

                  if Trim(emp.TFN) = '' then
                  begin
                     result := false;
                     msg := 'Tax File Number is missing for ' + emp.EmployeeName;
                     exit;
                  end;

                  PayEmp.Payee.Identifiers.TaxFileNumberId := StringReplace(emp.TFN, ' ', '', [rfReplaceAll]);


                  // if emp.ABN <> '' then
                  // PayEmp.Payee.Identifiers.AustralianBusinessNumberId := emp.ABN;
                  PayEmp.Payee.Identifiers.EmploymentPayrollNumberId := emp.Globalref;

                  PayEmp.Payee.PersonNameDetails.FamilyNameT := emp.LastName;
                  PayEmp.Payee.PersonNameDetails.GivenNameT := emp.FirstName;
                  if emp.MiddleName <> '' then
                     PayEmp.Payee.PersonNameDetails.OtherGivenNameT := emp.MiddleName;
                  DecodeDate(emp.DOB, year, month, day);

{$IFDEF STP_VERSION3}
                  PayEmp.Payee.PersonDemographicDetails.BirthDm := day;
                  PayEmp.Payee.PersonDemographicDetails.BirthM := month;
                  PayEmp.Payee.PersonDemographicDetails.BirthY := year;
{$ENDIF}

{$IFDEF STP_VERSION4}
                  PayEmp.Payee.PersonDemographicDetailsBirth.Dm := day;
                  PayEmp.Payee.PersonDemographicDetailsBirth.M := month;
                  PayEmp.Payee.PersonDemographicDetailsBirth.Y := year;
{$ENDIF}

                  if not TEmployee.ValidateAddressFields(emp.id, msg) then
                  begin
                     result := false;
                     exit;
                  end;

                  PayEmp.Payee.AddressDetails.Line1T := emp.Street;
                  PayEmp.Payee.AddressDetails.Line2T := StrJoin(emp.Street2, emp.Street3);
                  PayEmp.Payee.AddressDetails.LocalityNameT := emp.Suburb;

                  if not IsValidPostcode(emp.PostCode) then
                  begin
                      msg := 'The Post Code for the Address of ' + emp.EmployeeName + ' is invalid.';
                      result := false;
                      exit;
                  end;


                  if (UpperCase(Copy(TrimLeft(emp.State), 1, 2)) = 'NO') or (UpperCase(Copy(TrimLeft(emp.State), 1, 2)) = 'NT') or (Copy(emp.PostCode, 1, 2) = '08')  then
                      PayEmp.Payee.AddressDetails.StateOrTerritoryC := 'NT'
                  else if (UpperCase(Copy(TrimLeft(emp.State), 1, 1)) = 'N') or (Copy(emp.PostCode, 1, 1) = '2') then
                      PayEmp.Payee.AddressDetails.StateOrTerritoryC := 'NSW'
                  else if (UpperCase(Copy(TrimLeft(emp.State), 1, 1)) = 'Q') or (Copy(emp.PostCode, 1, 1) = '4') then
                  begin
                      PayEmp.Payee.AddressDetails.StateOrTerritoryC := 'QLD';
                  end
                  else if (UpperCase(Copy(TrimLeft(emp.State), 1, 1)) = 'S') or (Copy(emp.PostCode, 1, 1) = '5') then
                      PayEmp.Payee.AddressDetails.StateOrTerritoryC := 'SA'
                  else if (UpperCase(Copy(TrimLeft(emp.State), 1, 1)) = 'T') or (Copy(emp.PostCode, 1, 1) = '7') then
                      PayEmp.Payee.AddressDetails.StateOrTerritoryC := 'TAS'
                  else if (UpperCase(Copy(TrimLeft(emp.State), 1, 1)) = 'V') or (Copy(emp.PostCode, 1, 1) = '3') then
                      PayEmp.Payee.AddressDetails.StateOrTerritoryC := 'VIC'
                  else if (UpperCase(Copy(TrimLeft(emp.State), 1, 1)) = 'W') or (Copy(emp.PostCode, 1, 1) = '6')  then
                      PayEmp.Payee.AddressDetails.StateOrTerritoryC := 'WA'
                  else if (UpperCase(Copy(TrimLeft(emp.State), 1, 1)) = 'A') or (Copy(emp.PostCode, 1, 1) = '2')  then
                      PayEmp.Payee.AddressDetails.StateOrTerritoryC := 'ACT'
                  else if (UpperCase(Copy(TrimLeft(emp.State), 1, 1)) = 'J') or (Copy(emp.PostCode, 1, 1) = '2')  then
                      PayEmp.Payee.AddressDetails.StateOrTerritoryC := 'ACT'
                  else
                  begin
                      msg := 'The State or Post Code for the Address of ' + emp.EmployeeName + ' is invalid.';
                      result := false;
                      exit;
                     // PayEmp.Payee.AddressDetails.StateOrTerritoryC := 'AAT'
                  end;

              //    PayEmp.Payee.AddressDetails.StateOrTerritoryC := emp.State;

                  PayEmp.Payee.AddressDetails.PostcodeT := emp.PostCode;



                  CountryShortCode := LowerCase(TCountries.ShortCodeForCountry(emp.Country));
                  if CountryShortCode = '' then
                  begin
                     result := false;
                     msg := 'Could not find the Country Short Code for ' + emp.EmployeeName +
                       ', Country: ' + emp.Country;
                     exit;
                  end;

                  // if CountryShortCode = 'AU' then CountryShortCode := '';

                  PayEmp.Payee.AddressDetails.CountryC := CountryShortCode;

                  PayEmp.Payee.ElectronicContact.ElectronicMailAddressT := emp.Email;
                  if emp.Mobile <> '' then
                     PayEmp.Payee.ElectronicContact.TelephoneMinimalN := emp.Mobile
                  else
                     PayEmp.Payee.ElectronicContact.TelephoneMinimalN := emp.Phone;


{$IFDEF STP_VERSION4}

                  PayEmp.Payee.EmployerConditions.EmploymentStartD := ConvertDate(emp.DateStarted);

                  PayEmp.Payee.EmployerConditions.PaymentBasisC := emp.BasisOfPayment;

                  { TODO 1 -oJacob : PayEmp.Payee.EmployerConditions.TaxTreatmentC }
                  // PayEmp.Payee.EmployerConditions.TaxTreatmentC := 'RTSXXX';
                  // PayEmp.Payee.EmployerConditions.TaxTreatmentC := emp.CustFld8;

                  // PayEmp.Payee.EmployerConditions.TaxTreatmentC := emp.GetTaxScale.TaxTreatment;

                  if withNewSTPfields then
                     PayEmp.Payee.EmployerConditions.TaxTreatmentC :=
                       pay.EmployeeDetails.GetTaxScale.TaxTreatment
                  else
                  {PayEmp.Payee.EmployerConditions.TaxTreatmentC := 'RTSXXX'};
{$ENDIF}


                  if pay.IsTermination then
                  begin
                     PayEmp.Payee.EmployerConditions.EmploymentStartD :=
                       ConvertDate(emp.DateStarted);
                     PayEmp.Payee.EmployerConditions.EmploymentEndD :=
                       ConvertDate(emp.DateFinished);


{$IFDEF STP_VERSION4}
                     PayEmp.Payee.EmployerConditions.PaymentBasisC := emp.BasisOfPayment;

                     if emp.IsTerminated and (emp.DateFinished > 0) then
                     begin
                        PayEmp.Payee.EmployerConditions.CessationTypeC := pay.Termination.ETPCode;
                     end;

                     if TaxOffset > 0 then
                     begin
                        PayEmp.Payee.EmployerConditions.TaxOffsetClaimTotalA :=
                          FormatAmount(TaxOffset);
                     end;
{$ENDIF}
                  end;

                  (* For Submit, this is the start date of the pay period.
                    The start and end dates can be the same.
                    For Update, if the message is for the current financial year,
                    then this date must be the same as the pay/update (PaymentRecordTransactionD) date from the payevnt record.
                    If it is to update a previous financial year,
                    this date must be set to the last date of the relevant financial year. *)

{$IFDEF STP_VERSION4}
                  if IsUpdate then
                  begin
                     { Update }
                     if GetCurrentFiscalYearStart <= PaymentRecordTransactionDate then
                     begin
                        { for current financial year }
                        { same as the pay/update (PaymentRecordTransactionD) date from the payevnt record }
                        PayEmp.Payee.PayrollPeriod.StartD :=
                          ConvertDate(PaymentRecordTransactionDate);
                     end
                     else
                     begin
                        { prior financial year }
                        { last date of the relevant financial year }
                        PayEmp.Payee.PayrollPeriod.StartD :=
                        // ConvertDate(GetLastFiscalYearEnd(PaymentRecordTransactionDate));
                          ConvertDate(GetFiscalYearEnd(PaymentRecordTransactionDate));
                     end;
                  end
                  else
                  begin
                     { Submit }
                     { this is the start date of the pay period }
                     PayEmp.Payee.PayrollPeriod.StartD := ConvertDate(pay.PayPeriodStartDate);
                  end;
{$ENDIF}


{$IFDEF STP_VERSION3}
                  if IsUpdate then
                  begin
                     { Update }
                     if GetCurrentFiscalYearStart <= PaymentRecordTransactionDate then
                     begin
                        { for current financial year }
                        { same as the pay/update (PaymentRecordTransactionD) date from the payevnt record }
                        PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.PayrollPeriod.StartD
                          := ConvertDate(PaymentRecordTransactionDate);
                     end
                     else
                     begin
                        { prior financial year }
                        { last date of the relevant financial year }
                        PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.
                          PayrollPeriod.StartD :=
                        // ConvertDate(GetLastFiscalYearEnd(PaymentRecordTransactionDate));
                          ConvertDate(GetFiscalYearEnd(PaymentRecordTransactionDate));
                     end;
                  end
                  else
                  begin
                     { Submit }
                     { this is the start date of the pay period }
                     PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.PayrollPeriod.StartD :=
                       ConvertDate(pay.GetPayPeriodStartDatePaid);
            //         PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.PayrollPeriod.StartD :=
            //           ConvertDate(pay.PayPeriodStartDate);
                  end;
{$ENDIF}


                  { For Submit, this is the end date of the pay period.For Update, the Period End Date must be the same as the Period Start Date. }
{$IFDEF STP_VERSION4}
                  if IsUpdate then
                     { Update }
                     PayEmp.Payee.PayrollPeriod.EndD := PayEmp.Payee.PayrollPeriod.StartD
                  else
                     { Submit }
                     // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.PayrollPeriod.EndD := ConvertDate(pay.PayDate);
                     PayEmp.Payee.PayrollPeriod.EndD := ConvertDate(pay.DatePaid);

                  PayEmp.Payee.PayrollPeriod.RemunerationPayrollEventFinalI :=
                    FinancialYearFinalRun;

{$ENDIF}


{$IFDEF STP_VERSION3}
                  if IsUpdate then
                     { Update }
                     PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.PayrollPeriod.EndD :=
                       PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.PayrollPeriod.StartD
                  else
                     { Submit }
                     // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.PayrollPeriod.EndD := ConvertDate(pay.PayDate);
                     PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.PayrollPeriod.EndD :=
                       ConvertDate(pay.DatePaid);


                 if YearFinal then
                 begin
                      PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.PayrollPeriod.StartD := ConvertDate(GetFiscalYearEnd(pay.DatePaid));

                      PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.PayrollPeriod.EndD := ConvertDate(GetFiscalYearEnd(pay.DatePaid));
                 end;


                  PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.PayrollPeriod.
                    PayrollEventFinalI := FinancialYearFinalRun;
{$ENDIF}


                  PayGross := pay.Wages + pay.Commission +
                    (pay.Allowances - pay.GrossExcludeAllowances);
                  if Assigned(pay.PayBenefits) and (pay.PayBenefits is TPaysSuperannuation) then
                     PayGross := PayGross - TPaysSuperannuation(pay.PayBenefits)
                       .SalarySacrificeTotal;

                  { NOTE the following figures must be Year to Date! }
                  PayGrossYTD := Round(pay.PayTotals.YTDWages + pay.PayTotals.YTDCommission +
                    (pay.PayTotals.YTDAllowances - pay.PayTotals.YTDGrossExcludeAllowances) -
                    TPaysSuperannuation.GetYTDSalarySacrificeTotal(pay.DatePaid,
                    pay.EmployeeID), 2);

{$IFDEF STP_VERSION4}
                  Remuneration := PayEmp.Payee.PayrollPeriod.RemunerationCollection.Add;

                  { TODO 1 -oJacob : Remuneration.IncomeStreamTypeC }

                  if withNewSTPfields then
                     Remuneration.IncomeStreamTypeC := pay.GetIncomeStreamType
                  else
                     { Remuneration.IncomeStreamTypeC := 'SAW' }; // Pay.GetIncomeStreamType;

            //      ShowMessage('emp ' + IntToStr(pay.EmployeeID) + '  IncomeStreamTypeC ' + Remuneration.IncomeStreamTypeC);


                  if AnsiIndexText(Remuneration.IncomeStreamTypeC, ['FEI', 'WHM', 'IAA']) > -1 then
                  begin
                     Remuneration.AddressDetailsCountryC := '';
                  end
                  else
                  begin
                     // Remuneration.AddressDetailsCountryC := CountryShortCode;
                  end;
                  //
                  { TODO 1 -oJacob : Remuneration.IncomeTaxPayAsYouGoWithholdingTaxWithheldA }
                  // Remuneration.IncomeTaxPayAsYouGoWithholdingTaxWithheldA := '0';
                  // Remuneration.IncomeTaxPayAsYouGoWithholdingTaxWithheldA := 777;

                  Remuneration.IncomeTaxPayAsYouGoWithholdingTaxWithheldA :=
                    FormatAmount(pay.PayTotals.YTDTax);

                  if Remuneration.IncomeStreamTypeC = 'FEI' then
                  begin
                     { TODO 1 -oJacob : Remuneration.IncomeTaxForeignWithholdingA }
                     Remuneration.IncomeTaxForeignWithholdingA := '0';
                     { TODO 1 -oJacob : Remuneration.IndividualNonBusinessExemptForeignEmploymentIncomeA }
                     Remuneration.IndividualNonBusinessExemptForeignEmploymentIncomeA := '0';
                  end;

                  Remuneration.GrossA := FormatAmount(PayGrossYTD);
{$ENDIF}


{$IFDEF STP_VERSION3}
                  PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.IndividualNonBusiness.GrossA := FormatAmount(PayGrossYTD);
{$ENDIF}

                  totalGross := totalGross + PayGross;
                  // tmpQry.SQL.Clear;
                  // tmpQry.SQL.Add('select sum(CDEPGross) as CDEP from tblpays');
                  // tmpQry.SQL.Add('where EmployeeID = ' + IntToStr(pay.Employeeid));
                  // tmpQry.SQL.Add('and PayDate Between ' + QuotedStr(FormatDateTime('yyyy-mm-dd',finYearStart)) + ' and ' +
                  // QuotedStr(FormatDateTime('yyyy-mm-dd',finYearEnd)));
                  // tmpQry.SQL.Add('and Deleted = "F" and Paid = "T"');
                  // tmpQry.Open;


{$IFDEF STP_VERSION4}
                  { TODO 1 -oJacob : remove after testing }
                  // Allowance := Remuneration.AllowanceCollection.Add;
                  // Allowance.TypeC := emp.CustFld11;

                  if pay.PayAllowances.Count > 0 then
                  begin
                     pay.PayAllowances.First;
                     while not pay.PayAllowances.Eof do
                     begin
                        if SameText(pay.PayAllowances.DisplayIn, 'Allowances') then
                        begin

                           Allowance := Remuneration.AllowanceCollection.Add;

                           Allowance.TypeC := pay.PayAllowances.getAllowance.allowanceCode;
                           // Allowance.TypeC := pay.PayAllowances.AllowanceType;

                           if SameText(Allowance.TypeC, 'OD') then
                              // if SameText(pay.PayAllowances.AllowanceType, 'Other') then
                              Allowance.OtherAllowanceTypeDe :=
                                pay.PayAllowances.AllowanceDescription;

                           Allowance.EmploymentAllowancesA :=
                             FormatAmount(pay.PayAllowances.YTDMoneyamount(RunDate));
                        end;
                        pay.PayAllowances.Next;
                     end;
                  end;

                  // if pay.Leave in pay then begin
                  if pay.Payleaves.Count > 0 then
                  begin
                     pay.Payleaves.First;
                     while not pay.Payleaves.Eof do
                     begin
                        PaidLeave := Remuneration.PaidLeaveCollection.Add;
                        PaidLeave.TypeC := pay.Payleaves.Leavetype;
                        PaidLeave.PaymentA := FormatAmount(pay.Payleaves.Amount);
                        pay.Payleaves.Next;
                     end;
                  end;


                  if withNewSTPfields then

                     allowanceCode := pay.GetAllowancesObj.getAllowance.allowanceCode
                  else
                     {allowanceCode := 'OD'};


                  With pay.SUMPayAllowanceForSTP
                    [RunDate (* FiscalYearStart(Rundate, AppEnv.CompanyPrefs.FiscalYearStarts) *) ]
                    do
                  begin
                     if Count > 0 then
                     begin
                        First;
                        while not Eof do
                        begin
                           Allowance := Remuneration.AllowanceCollection.Add;

                           Allowance.TypeC := allowanceCode;
                           // Allowance.TypeC := AllowanceType;

                           if SameText(allowanceCode, 'OD') then
                              // if SameText(AllowanceType, 'Other') then
                              Allowance.OtherAllowanceTypeDe := Description;

                           Allowance.EmploymentAllowancesA := FormatAmount(YTDMoneyamount);
                           Next;
                        end;
                     end;

                  end;

                  { TODO 1 -oJacob : Allowance.TypeC }

                  With pay.EmployeePaySettings do
                  begin
                     if STPJobkeeperStartFN <> '' then
                     begin
                        Allowance := Remuneration.AllowanceCollection.Add;
                        Allowance.TypeC := 'OD';
                        // Allowance.TypeC := 'OD';
                        Allowance.OtherAllowanceTypeDe := STPJobkeeperStartFNDesc;
                        Allowance.EmploymentAllowancesA := FormatAmount(0.00);
                     end;
                  end;

                  With pay.EmployeePaySettings do
                  begin
                     if STPTier <> 0 then
                     begin
                        Allowance := Remuneration.AllowanceCollection.Add;
                        Allowance.TypeC := 'OD';
                        // Allowance.TypeC := 'OD';
                        Allowance.OtherAllowanceTypeDe := STPTierDesc;
                        Allowance.EmploymentAllowancesA := FormatAmount(STPTierAmount[pay.Paydate]);
                     end;
                  end;

                  With pay.SUMPayTopUptoJobKeepersAllowanceForSTP
                    [RunDate (* FiscalYearStart(Rundate, AppEnv.CompanyPrefs.FiscalYearStarts) *) ]
                    do
                  begin
                     if Count > 0 then
                     begin
                        Allowance := Remuneration.AllowanceCollection.Add;
                        Allowance.TypeC := 'OD';
                        // Allowance.TypeC := 'OD';
                        Allowance.OtherAllowanceTypeDe := 'JOBKEEPER-TOPUP';
                        Allowance.EmploymentAllowancesA := FormatAmount(YTDMoneyamount + Amount);
                        // needs the current pay's amount as well
                     end;
                  end;

                  With pay.EmployeePaySettings do
                  begin
                     if Trim(STPJobkeeperFinishFN) <> '' then
                     begin
                        Allowance := Remuneration.AllowanceCollection.Add;
                        Allowance.TypeC := 'OD';
                        // Allowance.TypeC := 'OD';
                        Allowance.OtherAllowanceTypeDe := STPJobkeeperFinishFNDesc;
                        Allowance.EmploymentAllowancesA := FormatAmount(0.00);
                     end;
                  end;
{$ENDIF}


{$IFDEF STP_VERSION3}
                  // Depricated from 2020
                  PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.IndividualNonBusiness.
                    CommunityDevelopmentEmploymentProjectA :=
                    FormatAmount(pay.PayTotals.YTDCDEPGross);
                  // FloatToStr(tmpQry.FieldByName('CDEP').AsFloat);
                  // tmpQry.Close;

                  (* Remuneration.OvertimePaymentA := '';
                    Remuneration.GrossBonusesAndCommissionsA := '';
                    Remuneration.GrossDirectorsFeesA := ''; *)

                  PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.IndividualNonBusiness.
                    TaxWithheldA := FormatAmount(pay.PayTotals.YTDTax);
                  totalTax := totalTax + pay.Tax;

                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.IndividualNonBusiness.ExemptForeignEmploymentIncomeA := '';

                  (* //If pay includes salary Sacrifice
                    SalarySacrifice := Remuneration.SalarySacrificeCollection.Add;
                    SalarySacrifice.TypeC := '';
                    SalarySacrifice.PaymentA := '';

                    //if lump sum payments then begin
                    LumpSumPayment := Remuneration.LumpSumCollection.Add;
                    LumpSumPayment.TypeC := '';
                    LumpSumPayment.FinancialY := 0;
                    LumpSumPayment.PaymentsA := '';
                  *)

                  { contractor }
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.VoluntaryAgreement.GrossA
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.VoluntaryAgreement.TaxWithheldA

                  { Labour Hire }
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.LabourHireArrangementPayment.GrossA
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.LabourHireArrangementPayment.TaxWithheldA

                  { Other }
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.SpecifiedByRegulationPayment.GrossA
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.SpecifiedByRegulationPayment.TaxWithheldA

                  { }
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.JointPetroleumDevelopmentAreaPayment.A
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.JointPetroleumDevelopmentAreaPayment.ForeignWithholdingA
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.JointPetroleumDevelopmentAreaPayment.TaxWithheldA

                  { people on working holiday in australia - 417 or 462 visa }
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.WorkingHolidayMaker.GrossA
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.WorkingHolidayMaker.TaxWithheldA

                  { foreign residents }
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.PaymentToForeignResident.GrossA
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.PaymentToForeignResident.ForeignWithholdingA
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.PaymentToForeignResident.TaxWithheldA
                  (*
                    Valid values are:
                    R = ETP made because of one of the following:
                    early retirement scheme, genuine redundancy, invalidity, or compensation for personal injury,
                    unfair dismissal, harassment, or discrimination.
                    O = Other ETP not described by R
                    (for example: golden handshake, gratuity, payment in lieu of notice,
                    payment for unused sick leave, or payment for unused rostered days off).
                    S = ETP code R payment received in the current year and received another ETP
                    (code R or code O), or a transitional termination payment,
                    in an earlier income year for the same termination of employment.
                    P = ETP code O payment received in the current year and received another ETP (code R or code O),
                    or a transitional termination payment,
                    in an earlier income year for the same termination of employment.
                    D = Death benefit ETP paid to a dependant of the deceased.
                    B = Death benefit ETP paid to a non-dependant of the deceased and
                    a termination payment was made to the non-dependant in a previous income year
                    for the same termination.
                    N = Death benefit ETP paid to a non-dependant of the deceased.
                    T = Death benefit ETP paid to a trustee of the deceased estate.
                  *)

                  if pay.IsTermination then
                  begin
                     TerminationPayment := PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.
                       EmploymentTerminationPaymentCollection.Add;
                     TerminationPayment.TypeC := pay.Termination.ETPCode; // 'R';
                     // TerminationPayment.PaymentRecordPaymentEffectiveD := ConvertDate(pay.PayDate);
                     TerminationPayment.PaymentRecordPaymentEffectiveD := ConvertDate(pay.DatePaid);
                     TerminationPayment.SuperannuationTaxFreeComponentA := FormatAmount(pay.Lumpd);
                     TerminationPayment.SuperannuationEmploymentTerminationTaxableComponentTotalA
                       := '0.00';
                     TerminationPayment.TaxWithheldA := '0.00';
                  end;

{$ENDIF}


{$IFDEF STP_VERSION4}
                  if pay.IsTermination then
                  begin
                     TerminationPayment := Remuneration.EmploymentTerminationPaymentCollection.Add;
                     TerminationPayment.IncomeTaxPayAsYouGoWithholdingTypeC :=
                       pay.Termination.ETPCode; // 'R';
                     // TerminationPayment.PaymentRecordPaymentEffectiveD := ConvertDate(pay.PayDate);
                     // TerminationPayment.PaymentRecordPaymentEffectiveD := ConvertDate(pay.datepaid);
                     TerminationPayment.IncomeTaxFreeA := FormatAmount(pay.Lumpd);
                     TerminationPayment.IncomeTaxableA := '0.00';
                     TerminationPayment.IncomePayAsYouGoWithholdingA := '0.00';
                  end;


                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.UnusedAnnualOrLongServiceLeavePayment.LumpSumPaymentA.LumpSumAC := '';
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.UnusedAnnualOrLongServiceLeavePayment.LumpSumPaymentA.LumpSumAA := '';
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.UnusedAnnualOrLongServiceLeavePayment.LumpSumBA := '';
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.UnusedAnnualOrLongServiceLeavePayment.LumpSumDA := '';
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.UnusedAnnualOrLongServiceLeavePayment.LumpSumEA := '';

                  (* if pay.PayDeductions.Count > 0 then begin
                    pay.PayDeductions.First;
                    while not pay.PayDeductions.EOF do begin
                    Deduction := PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.DeductionCollection.Add;
                    if Pay.PayDeductions.IsWorkPlacegiving then
                    Deduction.TypeC := 'Workplace Giving'
                    else  Deduction.TypeC := 'Fees';
                    Deduction.A := FormatAmount(pay.PayDeductions.YTDMoneyAmount(RunDate));
                    pay.PayDeductions.Next;
                    end;
                    end; *)


                  With pay.SUMPayDeductionForSTP
                    [RunDate (* FiscalYearStart(Rundate, AppEnv.CompanyPrefs.FiscalYearStarts) *) ]
                    do
                  begin
                     if Count > 0 then
                     begin
                        First;
                        while not Eof do
                        begin
                           Deduction := PayEmp.Payee.PayrollPeriod.DeductionCollection.Add;
                           if IsChildSupportGarnishee then
                           begin
                              Deduction.RemunerationTypeC := 'G';
                              totalChildSupportGarnishee := totalChildSupportGarnishee + Amount;
                           end
                           else if IsChildSupportDeduction then
                           begin
                              Deduction.RemunerationTypeC := 'D';
                              totalChildSupportWithholdingAmount :=
                                totalChildSupportWithholdingAmount + Amount;
                           end
                           else
                           begin
                              if IsWorkPlacegiving then
                              begin
                                 Deduction.RemunerationTypeC := 'W';
                              end
                              else
                                 Deduction.RemunerationTypeC := 'F';
                           end;
                           Deduction.RemunerationA := FormatAmount(YTDMoneyamount + Amount);
                           Next;
                        end;
                     end;
                  end;
{$ENDIF}



{$IFDEF STP_VERSION3}
                  With pay.SUMPayAllowanceForSTP
                    [RunDate (* FiscalYearStart(Rundate, AppEnv.CompanyPrefs.FiscalYearStarts) *) ]
                    do
                  begin
                     if Count > 0 then
                     begin
                        First;
                        while not Eof do
                        begin
                           Allowance := PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.
                             AllowanceCollection.Add;
                           Allowance.TypeC := AllowanceType;
                           if SameText(AllowanceType, 'Other') then
                              Allowance.OtherAllowanceTypeDe := Description;
                           Allowance.IndividualNonBusinessEmploymentAllowancesA :=
                             FormatAmount(YTDMoneyamount);
                           Next;
                        end;
                     end;
                  end;

                  With pay.EmployeePaySettings do
                  begin
                     if STPJobkeeperStartFN <> '' then
                     begin
                        Allowance := PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.
                          AllowanceCollection.Add;
                        Allowance.TypeC := 'Other';
                        Allowance.OtherAllowanceTypeDe := STPJobkeeperStartFNDesc;
                        Allowance.IndividualNonBusinessEmploymentAllowancesA := FormatAmount(0.00);
                     end;
                  end;

                  With pay.EmployeePaySettings do
                  begin
                     if STPTier <> 0 then
                     begin
                        Allowance := PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.
                          AllowanceCollection.Add;
                        Allowance.TypeC := 'Other';
                        Allowance.OtherAllowanceTypeDe := STPTierDesc;
                        Allowance.IndividualNonBusinessEmploymentAllowancesA :=
                          FormatAmount(STPTierAmount[pay.Paydate]);
                     end;
                  end;

                  With pay.SUMPayTopUptoJobKeepersAllowanceForSTP
                    [RunDate (* FiscalYearStart(Rundate, AppEnv.CompanyPrefs.FiscalYearStarts) *) ]
                    do
                  begin
                     if Count > 0 then
                     begin
                        Allowance := PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.
                          AllowanceCollection.Add;
                        Allowance.TypeC := 'Other';
                        Allowance.OtherAllowanceTypeDe := 'JOBKEEPER-TOPUP';
                        Allowance.IndividualNonBusinessEmploymentAllowancesA :=
                          FormatAmount(YTDMoneyamount + Amount);
                        // needs the current pay's amount as well
                     end;
                  end;

                  With pay.EmployeePaySettings do
                  begin
                     if Trim(STPJobkeeperFinishFN) <> '' then
                     begin
                        Allowance := PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.
                          AllowanceCollection.Add;
                        Allowance.TypeC := 'Other';
                        Allowance.OtherAllowanceTypeDe := STPJobkeeperFinishFNDesc;
                        Allowance.IndividualNonBusinessEmploymentAllowancesA := FormatAmount(0.00);
                     end;
                  end;
                  (* if pay.PayDeductions.Count > 0 then begin
                    pay.PayDeductions.First;
                    while not pay.PayDeductions.EOF do begin
                    Deduction := PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.DeductionCollection.Add;
                    if Pay.PayDeductions.IsWorkPlacegiving then
                    Deduction.TypeC := 'Workplace Giving'
                    else  Deduction.TypeC := 'Fees';
                    Deduction.A := FormatAmount(pay.PayDeductions.YTDMoneyAmount(RunDate));
                    pay.PayDeductions.Next;
                    end;
                    end; *)
                  With pay.SUMPayDeductionForSTP
                    [RunDate (* FiscalYearStart(Rundate, AppEnv.CompanyPrefs.FiscalYearStarts) *) ]
                    do
                  begin
                     if Count > 0 then
                     begin
                        First;
                        while not Eof do
                        begin
                           Deduction := PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.
                             DeductionCollection.Add;
                           if IsWorkPlacegiving then
                              Deduction.TypeC := 'Workplace Giving'
                           else
                              Deduction.TypeC := 'Fees';
                           Deduction.A := FormatAmount(YTDMoneyamount + Amount);
                           Next;
                        end;
                     end;
                  end;



{$ENDIF}

                  (*
                    EmployerContributionsSuperannuationGuaranteeA:
                    Contribution made by an employer for the benefit of an employee as mandated by super guarantee legislation

                    OrdinaryTimeEarningsA:
                    This is the value, during the relevant period, for what an individual has earned during their ordinary hours of work.

                    EmployerReportableA:
                    This is the value, during the relevant period,
                    for employer superannuation contributions that are additional to the
                    compulsory contributions where the employee influenced the rate or amount of contribution.
                  *)


{$IFDEF STP_VERSION4}
                  if Assigned(pay.PayBenefits) and (pay.PayBenefits is TPaysSuperannuation) then
                  begin

                     SuperannuationContribution :=
                       PayEmp.Payee.PayrollPeriod.SuperannuationContributionCollection.Add;

                     { TODO 1 -oJacob : SuperannuationContribution.EntitlementTypeC }
                     // SuperannuationContribution.EntitlementTypeC := 'L'; //entitlement code

                     if withNewSTPfields then

                        SuperannuationContribution.EntitlementTypeC := pay.GetSuperannuationObj.SuperEntitlementCode
                     else
                        {SuperannuationContribution.EntitlementTypeC := 'L'}; // entitlement code

                     SuperannuationContribution.EmployerContributionsYearToDateA :=
                       FormatAmount(TPaysSuperannuation.YTDSuperGuaranteePaid(RunDate,
                       pay.EmployeeID));

                     (* SuperannuationContribution.EmployerContributionsSuperannuationGuaranteeA :=
                       FormatAmount(TPaysSuperannuation.YTDSuperGuaranteePaid(RunDate,Pay.Employeeid)); //    TPaysSuperannuation(pay.PayBenefits).SGCTotal);

                       SuperannuationContribution.OrdinaryTimeEarningsA :=
                       FormatAmount(Pay.PayTotals.YTDWages);

                       SuperannuationContribution.EmployerReportableA :=
                       FormatAmount(TPaysSuperannuation.YTDEmployerReportableTotal(RunDate, Pay.Employeeid)); //   TPaysSuperannuation.EmployerReportableTotal(Pay.PayID)); *)
                  end;
{$ENDIF}


{$IFDEF STP_VERSION3}
                  if Assigned(pay.PayBenefits) and (pay.PayBenefits is TPaysSuperannuation) then
                  begin
//                     PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.
//                       SuperannuationContribution.EmployerContributionsSuperannuationGuaranteeA :=
//                       FormatAmount(TPaysSuperannuation.YTDSuperGuaranteePaid(RunDate,
//                       pay.EmployeeID)); // TPaysSuperannuation(pay.PayBenefits).SGCTotal);

                      PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.
                       SuperannuationContribution.EmployerContributionsSuperannuationGuaranteeA := FormatAmount(TPaysSuperannuation.YTDSuperGuarantee(pay.DatePaid, pay.EmployeeID));
                  //     FormatAmount(TPaysSuperannuation.YTDSuperGuaranteePaid(pay.DatePaid,
                  //     pay.EmployeeID)); // TPaysSuperannuation(pay.PayBenefits).SGCTotal);



                     PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.
                       SuperannuationContribution.OrdinaryTimeEarningsA :=
                       FormatAmount(pay.PayTotals.YTDWages);

                     PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.
                       SuperannuationContribution.EmployerReportableA :=
                       FormatAmount(TPaysSuperannuation.YTDEmployerReportableTotal(RunDate,
                       pay.EmployeeID)); // TPaysSuperannuation.EmployerReportableTotal(Pay.PayID));
                  end;
{$ENDIF}

                  // SuperannuationContribution.EntitlementTypeC := 'L'; //entitlement code
                  // SuperannuationContribution.EntitlementTypeC := emp.CustFld12; //entitlement code

                  { there is no FBT in ERP payroll at this stage }
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.IncomeFringeBenefitsReportable.TaxableIncomeFringeBenefitsReportableA
                  // PayEmp.Payee.RemunerationIncomeTaxPayAsYouGoWithholding.IncomeFringeBenefitsReportable.ExemptIncomeFringeBenefitsReportableA

                  (* if pay.Pay HasFringeBenefits then begin
                    FringeBenefits := PayEmp.Payee.PayrollPeriod.IncomeFringeBenefitsReportableCollection.Add;
                    FringeBenefits.FringeBenefitsReportableExemptionC := '';
                    FringeBenefits.A := '';
                    end;
                  *)              { tax file number declaration .. TFND }
                  // PayEmp.Payee.Onboarding.TFND.PaymentArrangementTerminationC
                  // PayEmp.Payee.Onboarding.TFND.ResidencyTaxPurposesPersonStatusC
                  // PayEmp.Payee.Onboarding.TFND.PaymentArrangementPaymentBasisC
                  // PayEmp.Payee.Onboarding.TFND.TaxOffsetClaimTaxFreeThresholdI
                  // PayEmp.Payee.Onboarding.TFND.IncomeTaxPayAsYouGoWithholdingStudyAndTrainingLoanRepaymentI
                  // PayEmp.Payee.Onboarding.TFND.StudentLoanStudentFinancialSupplementSchemeI

                  { TFND declaration }
                  // PayEmp.Payee.Onboarding.Declaration.StatementAcceptedI := true;
                  // PayEmp.Payee.Onboarding.Declaration.SignatureD := '';

                  Logtext(PayEmp.XML, 'd:\erp.XML');

                  if YearFinal then

                     stepProgress('Final pay of ' + qry.FieldByName('empname').AsString)
                 else
                     stepProgress(qry.FieldByName('empname').AsString + ' : ' + IntToStr(qry.recno) + ' of ' + IntToStr(qry.recordcount));

                  qry.Next;
               end;

               if query = nil then
                  qry.Close;



               stepProgress;

               if PaymentRecordTransactionDate = 0 then
               begin
                  (* For Submit event, this is the date on which the PAYG withholding for the Payroll Submit Event occurred.
                    It is used to determine what PAYGW period the Payer Gross and PAYGW amounts are to be applied.
                    For Update Event this is the As At date. It must be any date within the financial year that is being updated. *)

                  // maybe we have some deleted pays in the period ..
                  // qry.SQL.Text := 'select * from tblpays where PayRunID = ' + IntToStr(ID);


                  if query = nil then
                     qry.SQL.Text := 'select * from tblpays where  ' + PayrunIDFilter;

                  qry.Open;

                  if IsUpdate then
                  begin
                     { Update }
                     { any date within the financial year that is being updated }
                     if not qry.IsEmpty then
                        PaymentRecordTransactionDate := qry.FieldByName('DatePaid').AsDateTime
                     else
                        PaymentRecordTransactionDate := now; // Trunc(now);
                  end
                  else
                  begin
                     { Submit }
                     { date on which the PAYG withholding for the Payroll Submit Event occurred }
                     if not qry.IsEmpty then
                        PaymentRecordTransactionDate := qry.FieldByName('DatePaid').AsDateTime
                     else
                        PaymentRecordTransactionDate := now; // Trunc(now);
                  end;
               end; // query for PAYEVNTEMPs

               stepProgress;

               payevnt := NewPAYEVNT;
               DocList.Insert(0, payevnt); { add to beginning of list }
               payevnt.Rp.SoftwareInformationBusinessManagementSystemId :=
                 AppEnv.PayPrefs.SoftwareInformationBusinessManagementSystemId;
               payevnt.Rp.AustralianBusinessNumberId := AppEnv.CompanyInfo.ABN;
               // payevnt.Rp.WithholdingPayerNumberId  { don't think we need this as we have ABN }
               payevnt.Rp.OrganisationDetailsOrganisationBranchC := '1';
               { default to 1 if no branches }
               payevnt.Rp.OrganisationName.DetailsOrganisationalNameT :=
                 AppEnv.CompanyInfo.CompanyName;

               payevnt.Rp.OrganisationName.PersonUnstructuredNameFullNameT :=
                 StrJoin(AppEnv.CompanyInfo.FirstName, AppEnv.CompanyInfo.LastName);

               payevnt.Rp.ElectronicContact.ElectronicMailAddressT := AppEnv.CompanyInfo.Email;
               payevnt.Rp.ElectronicContact.TelephoneMinimalN := AppEnv.CompanyInfo.PhoneNumber;

{$IFDEF STP_VERSION3}
                payevnt.Rp.AddressDetailsPostal.Line1T := AppEnv.CompanyInfo.PoBox;
                 payevnt.Rp.AddressDetailsPostal.Line2T := StrJoin(AppEnv.CompanyInfo.PoBox2, AppEnv.CompanyInfo.PoBox3);
                 payevnt.Rp.AddressDetailsPostal.LocalityNameT := AppEnv.CompanyInfo.PoCity;
                 payevnt.Rp.AddressDetailsPostal.StateOrTerritoryC := AppEnv.CompanyInfo.PoState;
{$ENDIF}

               payevnt.Rp.AddressDetailsPostal.PostcodeT := AppEnv.CompanyInfo.PoPostcode;

               // payevnt.Rp.AddressDetailsPostal.CountryC := AppEnv.CompanyInfo.PoCountry; { Should be country code. Not required if AU }


               if YearFinal then
                  payevnt.Rp.Payroll.PaymentRecordTransactionD := ConvertDate(PeriodEndDate)
               else
                  payevnt.Rp.Payroll.PaymentRecordTransactionD := ConvertDate(PaymentRecordTransactionDate);

               payevnt.Rp.Payroll.InteractionRecordCt := ChildRecordCount;
               { number of child PAYEVNTEMP records }
               payevnt.Rp.Payroll.MessageTimestampGenerationDt := ConvertDateTime(TTimeZone.Local.ToUniversalTime(now));
               // payevnt.RP.Payroll.PaymentRecordTransactionD;
               payevnt.Rp.Payroll.InteractionTransactionId := Self.Globalref;

               (* This is used to indicate when this submission is a full file replacement.
                 TRUE indicates the data provided in this transaction replaces data previously reported
                 under the provided submission ID.  It cannot be TRUE for Update events.
                 FALSE indicates this is the original submission or an Update event.
               *)
               stepProgress;
               if Self.Invalidated then
                  payevnt.Rp.Payroll.AmendmentI := true
               else
                  payevnt.Rp.Payroll.AmendmentI := false;

//               if IsUpdate then
//                  ShowMessage('payevnt: IsUpdate')
//               else
//                  ShowMessage('payevnt: New');


               if not IsUpdate then
               begin
                  payevnt.Rp.Payroll.IncomeTaxAndRemuneration.PayAsYouGoWithholdingTaxWithheldA :=
                    FormatAmount(totalTax);
                  payevnt.Rp.Payroll.IncomeTaxAndRemuneration.TotalGrossPaymentsWithholdingA :=
                    FormatAmount(totalGross);

{$IFDEF STP_VERSION4}
                  payevnt.Rp.Payroll.IncomeTaxAndRemuneration.ChildSupportGarnisheeA :=
                    FormatAmount(totalChildSupportGarnishee);
                  payevnt.Rp.Payroll.IncomeTaxAndRemuneration.ChildSupportWithholdingA :=
                    FormatAmount(totalChildSupportWithholdingAmount);
{$ENDIF}
               end;

               payevnt.Rp.Declaration.SignatoryIdentifierT := StrJoin(AppEnv.CompanyInfo.FirstName,
                 AppEnv.CompanyInfo.LastName);
               payevnt.Rp.Declaration.SignatureD := ConvertDate(Self.RunDate);
               { the actual date on which the declaration is signed by the reporting entity }
               payevnt.Rp.Declaration.StatementAcceptedI := true;
               stepProgress;
               { Intermediary }
               // payevnt.Int

            finally
               HideProgress
            end;

         end;

      finally
         qry.Free;
         tmpQry.Free;
         emp.Free;
         pay.Free;
      end;
   except
      on e: exception do
      begin
         result := false;
         msg := e.Message;
      end;
   end;
end;

class function TPayRun.DeletePayInRun(var PayBatchID: integer; Connection: TCustomMyConnection;
  var msg: string): Boolean;
var
   inst: TPayRun;
begin
   result := true;
   if PayBatchID < 1 then
      exit;
   try
      inst := TPayRun.CreateWithNewConn(nil);
      try
         inst.Connection.Connection := Connection;
         inst.Load(PayBatchID);
         inst.PaysProcessed := inst.PaysProcessed - 1;
         if inst.Submitted then
         begin
            inst.Invalidated := true;
            inst.AddNote('Deleted pay removed from Submitted Pay Run.');
         end;
         if not inst.Save then
         begin
            result := false;
            msg := inst.ResultStatus.Messages;
            exit;
         end;
      finally
         inst.Free;
      end;
   except
      on e: exception do
      begin
         result := false;
         msg := e.Message;
      end;
   end;
end;

destructor TPayRun.Destroy;
begin
   ErrorList.Free;
   inherited;
end;

function TPayRun.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
   result := inherited;
   EmployeeID := AppEnv.Employee.EmployeeID;
   RunDate := now;
end;

procedure TPayRun.DoFieldOnChange(Sender: TField);
begin
   if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if not DoFieldChangewhenDisabled then
         exit; // we are only interested in data fields.
   inherited;
   If SysUtils.SameText(Sender.FieldName, 'EmployeeID') then
   begin
      EmployeeName := TEmployee.IdToggle(Sender.AsInteger, Connection.Connection);
   end
   else If SysUtils.SameText(Sender.FieldName, 'EmployeeName') then
   begin
      EmployeeID := TEmployee.IdToggle(Sender.AsString, Connection.Connection);
   end;
end;

function TPayRun.GetABNFromATOMessage: string;
var
   doc: IXMLDocument;
   I: integer;
   node, Rp, Int, ABN: IXMLNode;
begin
   result := '';
   doc := TXMLDocument.Create(nil);
   try
      doc.XML.Add('<?xml version="1.0" encoding="UTF-8"?>');
      doc.XML.Add('<ato>');
      doc.XML.Add(ATOMessage);
      doc.XML.Add('</ato>');
      doc.Active := true;
      for I := 0 to doc.DocumentElement.ChildNodes.Count - 1 do
      begin
         node := doc.DocumentElement.ChildNodes[I];
         if SameText(node.NodeName, 'tns:PAYEVNT') then
         begin
            Rp := node.ChildNodes.FindNode('tns:Rp');
            if Assigned(Rp) then
            begin
               ABN := Rp.ChildNodes.FindNode('tns:AustralianBusinessNumberId');
               if Assigned(ABN) then
               begin
                  result := ABN.NodeValue;
                  exit;
               end;
            end;
            Int := node.ChildNodes.FindNode('tns:Int');
            if Assigned(Int) then
            begin
               ABN := Int.ChildNodes.FindNode('tns:AustralianBusinessNumberId');
               if Assigned(ABN) then
               begin
                  result := ABN.NodeValue;
                  exit;
               end;
            end;
         end;
         if SameText(node.NodeName, 'PAYEVNT') then
         begin
            Rp := node.ChildNodes.FindNode('Rp');
            if Assigned(Rp) then
            begin
               ABN := Rp.ChildNodes.FindNode('AustralianBusinessNumberId');
               if Assigned(ABN) then
               begin
                  result := ABN.NodeValue;
                  exit;
               end;
            end;
            Int := node.ChildNodes.FindNode('Int');
            if Assigned(Int) then
            begin
               ABN := Int.ChildNodes.FindNode('AustralianBusinessNumberId');
               if Assigned(ABN) then
               begin
                  result := ABN.NodeValue;
                  exit;
               end;
            end;
         end;
      end;

   finally
      doc := nil;
   end;
end;

function TPayRun.GetATOMessage: string;
begin
   result := GetStringField('ATOMessage');
end;

function TPayRun.GetATOResponse: string;
begin
   result := GetStringField('ATOResponse');
end;

function TPayRun.GetOriginalRef: string;
begin
   result := GetStringField('OriginalRef');
end;

class function TPayRun.GetBusObjectTablename: string;
begin
   result := 'tblpayrun';
end;

function TPayRun.GetComplete: Boolean;
begin
   result := GetBooleanField('Complete');
end;

function TPayRun.GetEmployeeID: integer;
begin
   result := GetIntegerField('EmployeeID');
end;

function TPayRun.GetEmployeeName: string;
begin
   result := GetStringField('EmployeeName');
end;

function TPayRun.GetEmployeeFirstName: string;
var
   EmployeeDetails: TEmployeeDetails;

begin

   EmployeeDetails := TEmployeeDetails(GetContainerComponent(TEmployeeDetails,
     'EmployeeID = ' + IntToStr(EmployeeID)));

   result := EmployeeDetails.FirstName;

end;

function TPayRun.GetEmployeeLastName: string;
var
   EmployeeDetails: TEmployeeDetails;

begin

   EmployeeDetails := TEmployeeDetails(GetContainerComponent(TEmployeeDetails,
     'EmployeeID = ' + IntToStr(EmployeeID)));

   result := EmployeeDetails.LastName;

end;

function TPayRun.GetEmployeeCompany: string;
var
   EmployeeDetails: TEmployeeDetails;

begin

   EmployeeDetails := TEmployeeDetails(GetContainerComponent(TEmployeeDetails,
     'EmployeeID = ' + IntToStr(EmployeeID)));

   result := EmployeeDetails.Company;

end;

function TPayRun.GetEmployeeLastUpdated: TDateTime;
var
   EmployeeDetails: TEmployeeDetails;

begin

   EmployeeDetails := TEmployeeDetails(GetContainerComponent(TEmployeeDetails,
     'EmployeeID = ' + IntToStr(EmployeeID)));

   result := EmployeeDetails.LastUpdated;

end;

function TPayRun.GetEmployeeWages: Double;
var
   EmployeeDetails: TEmployeeDetails;

begin

   EmployeeDetails := TEmployeeDetails(GetContainerComponent(TEmployeeDetails,
     'EmployeeID = ' + IntToStr(EmployeeID)));

   result := EmployeeDetails.Wages;

end;

function TPayRun.GetEmployeeTax: Double;
var
   EmployeeDetails: TEmployeeDetails;

begin

   EmployeeDetails := TEmployeeDetails(GetContainerComponent(TEmployeeDetails,
     'EmployeeID = ' + IntToStr(EmployeeID)));

   result := EmployeeDetails.Tax;

end;

function TPayRun.GetEmployeeSuper: Double;
var
   EmployeeDetails: TEmployeeDetails;

begin

   EmployeeDetails := TEmployeeDetails(GetContainerComponent(TEmployeeDetails,
     'EmployeeID = ' + IntToStr(EmployeeID)));

   result := EmployeeDetails.Super;

end;

function TPayRun.GetEmployeeNet: Double;
var
   EmployeeDetails: TEmployeeDetails;

begin

   EmployeeDetails := TEmployeeDetails(GetContainerComponent(TEmployeeDetails,
     'EmployeeID = ' + IntToStr(EmployeeID)));

   result := EmployeeDetails.Net;

end;

function TPayRun.GetEmployeeActive: Boolean;
var
   EmployeeDetails: TEmployeeDetails;

begin

   EmployeeDetails := TEmployeeDetails(GetContainerComponent(TEmployeeDetails,
     'EmployeeID = ' + IntToStr(EmployeeID)));

   result := EmployeeDetails.Active;

end;

function TPayRun.GetPaySlips: TPayBase;
begin

   result := TPayBase(GetContainerComponent(TPayBase, 'EmployeeID = ' + IntToStr(EmployeeID)));

end;

function TPayRun.GetPayEmployeeEarnings: string;
var
   qry: TERPQuery;
   Wages: string;
   Paydate: string;
begin
   qry := TERPQuery.Create(nil);
   try
      qry.Options.FlatBuffers := true;
      with qry do
      begin
         qry.Connection := TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection);
         SQL.Clear;
         SQL.Add('SELECT Wages, PayDate FROM tblpays WHERE EmployeeID = ' + IntToStr(EmployeeID));
         Open;

         if recordcount <> 0 then
         begin

            while not Eof do
            begin
               Wages := FieldByName('Wages').AsString;
               Paydate := FieldByName('PayDate').AsString;
               Next;
            end;

            result := Wages;
         end;
      end;
   finally
      FreeAndNil(qry);
   end;

end;

function TPayRun.GetTaxScale(id: integer): string;
var
   qry: TERPQuery;

begin

   qry := TERPQuery.Create(nil);
   try
      qry.Options.FlatBuffers := true;
      with qry do
      begin
         qry.Connection := TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection);
         SQL.Clear;
         SQL.Add('SELECT ScaleID, ScaleDescription FROM tbltaxscales WHERE ScaleID = ' +
           IntToStr(id));
         Open;
         if recordcount <> 0 then
         begin
            result := FieldByName('ScaleID').AsString + FieldByName('ScaleDescription').AsString;
         end;
      end;
   finally
      FreeAndNil(qry);
   end;

end;

function TPayRun.GetFinancialYearFinalRun: Boolean;
begin
   result := GetBooleanField('FinancialYearFinalRun');
end;

class function TPayRun.GetIDField: string;
begin
   result := 'ID';
end;

function TPayRun.GetInvalidated: Boolean;
begin
   result := GetBooleanField('Invalidated');
end;

class function TPayRun.GetKeyStringField: string;
begin
   result := inherited;
end;

function TPayRun.GetLastCheckTime: TDateTime;
begin
   result := GetDateTimeField('LastCheckTime');
end;

function TPayRun.GetMessageStatus: string;
begin
   result := GetStringField('MessageStatus');
end;

function TPayRun.GetMessageType: string;
begin
   result := GetStringField('MessageType');
end;

function TPayRun.GetMessageUuid: string;
begin
   result := GetStringField('MessageUuid');
end;

function TPayRun.GetNotes: string;
begin
   result := GetStringField('Notes');
end;

function TPayRun.getOriginalID: integer;
var
   qry: TERPQuery;
   fsOriginalRef: String;
begin
   result := 0;
   if Trim(OriginalRef) = '' then
      exit;

   fsOriginalRef := OriginalRef;
   qry := SharedQuery;
   try
      While true do
      begin
         if Trim(fsOriginalRef) = '' then
            break;
         if qry.Active then
            qry.Close;
         qry.SQL.Clear;
         qry.SQL.Add('Select  ID, OriginalRef from tblpayrun where globalref = ' +
           Quotedstr(fsOriginalRef));
         qry.Open;
         if qry.recordcount = 0 then
            break
         else
         begin
            result := qry.FieldByName('ID').AsInteger;
            fsOriginalRef := qry.FieldByName('OriginalRef').AsString;
         end;
      end;
   finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
   end;
end;

function TPayRun.GetPaysProcessed: integer;
begin
   result := GetIntegerField('PaysProcessed');
end;

function TPayRun.GetRunDate: TDateTime;
begin
   result := GetDateTimeField('RunDate');
end;

function TPayRun.GetSubmitted: Boolean;
begin
   result := GetBooleanField('Submitted');
end;

function TPayRun.GetSubmittedDate: TDateTime;
begin
   result := GetDateTimeField('SubmittedDate');
end;

function TPayRun.IsLastForFinancialYear: Boolean;
var
   qry: TERPQuery;
   YearEnd: TDateTime;
   Days: integer;
begin
   result := false;

   YearEnd := StartOfTheFY(IncYear(RunDate, 1)) - 1;

   Days := 0;
   qry := TERPQuery.Create(nil);
   try
      qry.Connection := Connection.Connection;
      // qry.SQL.Add('select PayPeriod from tblpays where PayRunID = ' + IntToStr(ID));
      qry.SQL.Add('select PayPeriod from tblpays where  ' + PayrunIDFilter);
      qry.SQL.Add('and Deleted = "F"');
      qry.Open;
      while not qry.Eof do
      begin
         if SameText(qry.FieldByName('PayPeriod').AsString, 'Fortnightly') then
         begin
            if Days < 14 then
               Days := 14;
         end
         else if SameText(qry.FieldByName('PayPeriod').AsString, 'Bi-Monthly') then
         begin
            if Days < FloatToInt((DaysInMonth(RunDate) / 2), true) then
               Days := FloatToInt((DaysInMonth(RunDate) / 2), true);
         end
         else if SameText(qry.FieldByName('PayPeriod').AsString, 'Monthly') then
         begin
            if Days < DaysInMonth(RunDate) then
               Days := DaysInMonth(RunDate);
         end
         else if SameText(qry.FieldByName('PayPeriod').AsString, 'Weekly') then
         begin
            if Days < 7 then
               Days := 7;
         end;
         qry.Next;
      end;
   finally
      qry.Free;
   end;

   if (RunDate + Days) > YearEnd then
      result := true;
end;

class function TPayRun.LoadResponsePayloadFile(aFileName: string; ds: TDataset;
  aErrorList: TObjectList): string;
var
   stream: TStringStream;
begin
   result := '';
   stream := TStringStream.Create;
   try
      stream.LoadFromFile(aFileName);
      ds.FieldByName('ATOResponse').AsString := stream.DataString;
   finally
      stream.Free;
   end;
   result := PopulateErrorList(ds, aErrorList);
end;

class function TPayRun.PopulateErrorList(ds: TDataset; aErrorList: TObjectList): string;
var
   doc: IXMLDocument;
   node: IXMLNode;
   qry: TERPQuery;
   RecNum: integer;
   NodeNo: integer;
   ResultStr: string;

   procedure ProcessEvent(aEventNode: IXMLNode);
   var
      s: string;
      n, EventItems, EventItem: IXMLNode;
      I: integer;
      ErrorItem: TErrorItem;
   begin
      s := '';
      n := aEventNode.ChildNodes.FindNode('MaximumSeverity.Code');
      if Assigned(n) then
         s := n.NodeValue
      else
      begin
         n := aEventNode.ChildNodes.FindNode('tns:MaximumSeverity.Code');
         if Assigned(n) then
            s := n.NodeValue
      end;
      if not SameText(s, 'Information') then
         ResultStr := s;

      EventItems := aEventNode.ChildNodes.FindNode('EventItems');
      if not Assigned(EventItems) then
         EventItems := aEventNode.ChildNodes.FindNode('tns:EventItems');
      if Assigned(EventItems) then
      begin
         for I := 0 to EventItems.ChildNodes.Count - 1 do
         begin
            EventItem := EventItems.ChildNodes[I];
            ErrorItem := TErrorItem.Create;
            ErrorItem.PopulateFromNode(EventItem, TMyQuery(ds).Connection);

            { find which pay this was }
            if (Length(ErrorItem.LocationInstanceIdentifier) > 2) then
            begin

               RecNum := ErrorItem.RecordNumber;
               // StrToInt(Copy(ErrorItem.LocationInstanceIdentifier,3,255))-1;
               if RecNum > 0 then
               begin
                  qry.First;
                  while not qry.Eof do
                  begin
                     if qry.recno = RecNum then
                     begin
                        ErrorItem.PayID := qry.FieldByName('PayID').AsInteger;
                        ErrorItem.EmployeeID := qry.FieldByName('EmployeeID').AsInteger;
                        ErrorItem.EmployeeName := qry.FieldByName('EmployeeName').AsString;
                        break;
                     end;
                     qry.Next;
                  end;
               end;
            end;
            aErrorList.Add(ErrorItem);
         end;
      end;
   end;

begin
   ResultStr := '';
   aErrorList.Clear;
   doc := TXMLDocument.Create(nil);
   Coinitialize(nil);
   qry := TERPQuery.Create(nil);
   try
      qry.Connection := TMyQuery(ds).Connection;
      qry.SQL.Add('select PayID, EmployeeID, EmpName as EmployeeName from tblPays');
      qry.SQL.Add('where PayRunID = ' + IntToStr(ds.FieldByName('ID').AsInteger) +
        ' order by PayID');
      qry.Open;
      if Pos('<?xml', Copy(ds.FieldByName('ATOResponse').AsString, 1, 20)) = 1 then
      begin
         doc.XML.Add(ds.FieldByName('ATOResponse').AsString);
      end
      else
      begin
         doc.XML.Add('<?xml version="1.0" encoding="UTF-8"?>');
         doc.XML.Add('<ato>');
         doc.XML.Add(ds.FieldByName('ATOResponse').AsString);
         doc.XML.Add('</ato>');
      end;
      doc.Active := true;

      if SameText(doc.DocumentElement.NodeName, 'Event') then
      begin
         ProcessEvent(doc.DocumentElement);
      end
      else
      begin

         for NodeNo := 0 to doc.DocumentElement.ChildNodes.Count - 1 do
         begin
            node := doc.DocumentElement.ChildNodes[NodeNo];
            if SameText(node.NodeName, 'Event') or SameText(node.NodeName, 'tns:Event') then
            begin
               ProcessEvent(node);
            end;
         end;
      end;

   finally
      doc := nil;
      qry.Free;
      CoUninitialize;
   end;
   result := ResultStr;
end;

function TPayRun.PopulateErrors: string;
begin
   result := PopulateErrorList(Dataset, ErrorList);
end;

function TPayRun.Save: Boolean;
begin
   ResultStatus.Clear;
   Self.PostDB;
   result := ValidateData;
   if not result then
      exit;
   result := inherited;
end;

procedure TPayRun.SetATOMessage(const Value: string);
begin
   SetStringField('ATOMessage', Value);
end;

procedure TPayRun.SetATOResponse(const Value: string);
begin
   SetStringField('ATOResponse', Value);
end;

procedure TPayRun.SetOriginalRef(const Value: string);
begin
   SetStringField('OriginalRef', Value);
end;

procedure TPayRun.SetComplete(const Value: Boolean);
begin
   SetBooleanField('Complete', Value);
end;

procedure TPayRun.SetEmployeeID(const Value: integer);
begin
   SetIntegerField('EmployeeID', Value);
end;

procedure TPayRun.SetEmployeeName(const Value: string);
begin
   SetStringField('EmployeeName', Value);
end;

procedure TPayRun.SetFinancialYearFinalRun(const Value: Boolean);
begin
   SetBooleanField('FinancialYearFinalRun', Value);
end;

procedure TPayRun.SetInvalidated(const Value: Boolean);
begin
   SetBooleanField('Invalidated', Value);
end;

procedure TPayRun.SetLastCheckTime(const Value: TDateTime);
begin
   SetDateTimeField('LastCheckTime', Value);
end;

procedure TPayRun.SetMessageStatus(const Value: string);
begin
   SetStringField('MessageStatus', Value);
end;

procedure TPayRun.SetMessageType(const Value: string);
begin
   SetStringField('MessageType', Value);
end;

procedure TPayRun.SetMessageUuid(const Value: string);
begin
   SetStringField('MessageUuid', Value);
end;

procedure TPayRun.SetNotes(const Value: string);
begin
   SetStringField('Notes', Value);
end;

procedure TPayRun.SetPaysProcessed(const Value: integer);
begin
   SetIntegerField('PaysProcessed', Value);
end;

procedure TPayRun.SetRunDate(const Value: TDateTime);
begin
   SetDateTimeField('RunDate', Value);
end;

procedure TPayRun.SetSubmitted(const Value: Boolean);
begin
   SetBooleanField('Submitted', Value);
end;

procedure TPayRun.SetSubmittedDate(const Value: TDateTime);
begin
   SetDateTimeField('SubmittedDate', Value);
end;

function TPayRun.ValidateData: Boolean;
begin
   result := inherited;
end;

{ TErrorItem }

procedure TErrorItem.Assign(aSource: TErrorItem);
begin
   Self.PayID := aSource.PayID;
   Self.EmployeeID := aSource.EmployeeID;
   Self.SeverityCode := aSource.SeverityCode;
   Self.EmployeeName := aSource.EmployeeName;
   Self.ErrorLocation := aSource.ErrorLocation;
   Self.ErrorMessage := aSource.ErrorMessage;
   Self.LocationInstanceIdentifier := aSource.LocationInstanceIdentifier;
end;

procedure TErrorItem.PopulateFromNode(node: IXMLNode; conn: TCustomMyConnection);
var
   n: IXMLNode;
   sl: TStringList;
   I: integer;
   InParam: Boolean;
   param: string;
   Parameters, Parameter, Locations: IXMLNode;
   qry: TERPQuery;
begin
   sl := TStringList.Create;
   qry := TERPQuery.Create(nil);
   try
      qry.Connection := conn;
      qry.SQL.Add('select Label from tblatopayevntstruct where DocName = "PAYEVNTEMP"');
      qry.SQL.Add('and XmlXPath = :Path');
      if SameText(node.NodeName, 'EventItem') then
      begin
         n := node.ChildNodes.FindNode('Severity.Code');
         if Assigned(n) then
            SeverityCode := n.NodeValue;
         n := node.ChildNodes.FindNode('Short.Description');
         if Assigned(n) and (not VarIsNull(n.NodeValue)) then
         begin
            ErrorMessage := n.NodeValue;
            InParam := false;
            { build a list of parameters that need to be replaced }
            for I := 1 to Length(ErrorMessage) do
            begin
               if InParam then
               begin
                  if ErrorMessage[I] = '}' then
                  begin
                     sl.Add(param);
                     param := '';
                  end
                  else
                     param := param + ErrorMessage[I];
               end
               else
               begin
                  if ErrorMessage[I] = '{' then
                     InParam := true;
               end;
            end;
            if sl.Count > 0 then
            begin
               { now replace params with values }
               Parameters := node.ChildNodes.FindNode('Parameters');
               if Assigned(Parameters) then
               begin
                  for I := 0 to Parameters.ChildNodes.Count - 1 do
                  begin
                     Parameter := Parameters.ChildNodes[I];
                     if sl.IndexOf(Parameter.ChildValues['Parameter.Identifier']) > -1 then
                     begin
                        ErrorMessage := ReplaceStr(ErrorMessage,
                          '{' + Parameter.ChildValues['Parameter.Identifier'] + '}',
                          Parameter.ChildValues['Parameter.Text']);
                     end;
                  end;
               end;
            end;
         end;
      end
      else if SameText(node.NodeName, 'tns:EventItem') then
      begin
         n := node.ChildNodes.FindNode('tns:Severity.Code');
         if Assigned(n) then
            SeverityCode := n.NodeValue;
         n := node.ChildNodes.FindNode('tns:Detailed.Description');
         if Assigned(n) and (not VarIsNull(n.NodeValue)) then
            ErrorMessage := n.NodeValue
         else
         begin
            n := node.ChildNodes.FindNode('tns:Short.Description');
            if Assigned(n) and (not VarIsNull(n.NodeValue)) then
               ErrorMessage := n.NodeValue
         end;
         if ErrorMessage <> '' then
         begin

            { build a list of parameters that need to be replaced }
            sl.Clear;
            InParam := false;
            for I := 1 to Length(ErrorMessage) do
            begin
               if InParam then
               begin
                  if ErrorMessage[I] = '}' then
                  begin
                     sl.Add(param);
                     param := '';
                  end
                  else
                     param := param + ErrorMessage[I];
               end
               else
               begin
                  if ErrorMessage[I] = '{' then
                     InParam := true;
               end;
            end;
            if sl.Count > 0 then
            begin
               { now replace params with values }
               Parameters := node.ChildNodes.FindNode('tns:Parameters');
               if Assigned(Parameters) then
               begin
                  for I := 0 to Parameters.ChildNodes.Count - 1 do
                  begin
                     Parameter := Parameters.ChildNodes[I];
                     if sl.IndexOf(Parameter.ChildValues['tns:Parameter.Identifier']) > -1 then
                     begin
                        ErrorMessage := ReplaceStr(ErrorMessage,
                          '{' + Parameter.ChildValues['tns:Parameter.Identifier'] + '}',
                          Parameter.ChildValues['tns:Parameter.Text']);
                     end;
                  end;
               end;
            end;

         end;
         Locations := node.ChildNodes.FindNode('tns:Locations');
         if Assigned(Locations) and (Locations.ChildNodes.Count > 0) then
         begin
            n := Locations.ChildNodes[0];
            Self.LocationInstanceIdentifier := n.ChildValues['tns:Location.Instance.Identifier'];
            if Assigned(n.ChildNodes.FindNode('tns:Location.Path.Text')) then
            begin
               qry.ParamByName('Path').AsString := n.ChildValues['tns:Location.Path.Text'];
               qry.Open;
               ErrorLocation := qry.FieldByName('Label').AsString;
               qry.Close;
            end;
         end;
      end;
   finally
      sl.Free;
   end;
end;

function TErrorItem.RecordNumber: integer;
var
   x: integer;
begin
   result := 0;
   x := Pos('.', LocationInstanceIdentifier);
   if x > 0 then
      result := StrToInt(Copy(LocationInstanceIdentifier, x + 1, 255)) - 1;
end;



initialization

   RegisterClass(TPayRun);

   RegisterClass(TSTPPayrun);

end.










