unit frmATOPayEvent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, BusObjBase, BusObjPayRun, Mask, DBCtrls, Shader,
  DNMPanel, DNMSpeedButton, wwcheckbox, Grids, Wwdbigrd, Wwdbgrid, JsonObject, ShlObj, MSXML2_TLB, OzEDI_STP2;

type
  TfmATOPayEvent = class(TBaseInputGUI)
    qryPayRun: TERPQuery;
    qryPayRunGlobalRef: TWideStringField;
    qryPayRunID: TIntegerField;
    qryPayRunEmployeeID: TIntegerField;
    qryPayRunEmployeeName: TWideStringField;
    qryPayRunRunDate: TDatetimeField;
    qryPayRunSubmitted: TWideStringField;
    qryPayRunSubmittedDate: TDateField;
    qryPayRunPaysProcessed: TIntegerField;
    qryPayRunInvalidated: TWideStringField;
    qryPayRunFinancialYearFinalRun: TWideStringField;
    qryPayRunNotes: TWideMemoField;
    qryPayRunmsTimeStamp: TDateTimeField;
    qryPayRunmsUpdateSiteCode: TWideStringField;
    dsPayRun: TDataSource;
    pnlBottom: TDNMPanel;
    btnSubmit: TDNMSpeedButton;
    GetStatus: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label1: TLabel;
    edtPayRunDate: TDBEdit;
    Label2: TLabel;
    edtEmployeeName: TDBEdit;
    chkSubmitted: TwwCheckBox;
    chkInvalidated: TwwCheckBox;
    chkYearFinal: TwwCheckBox;
    Label3: TLabel;
    memNotes: TDBMemo;
    pnlPays: TDNMPanel;
    grdPays: TwwDBGrid;
    qryPays: TERPQuery;
    qryPaysGlobalRef: TWideStringField;
    qryPaysPayID: TIntegerField;
    qryPaysEmployeeID: TIntegerField;
    qryPaysPayPeriod: TWideStringField;
    qryPaysEmployeeName: TWideStringField;
    qryPaysPayDate: TDateField;
    qryPaysDatePaid: TDateTimeField;
    qryPaysPayPeriods: TWordField;
    qryPaysWages: TFloatField;
    qryPaysCommission: TFloatField;
    qryPaysDeductions: TFloatField;
    qryPaysWorkplacegiving: TFloatField;
    qryPaysAllowances: TFloatField;
    qryPaysCDEP: TFloatField;
    qryPaysSundries: TFloatField;
    qryPaysSuperannuation: TFloatField;
    qryPaysGross: TFloatField;
    qryPaysTax: TFloatField;
    qryPaysNetCombined: TFloatField;
    qryPaysNetOnly: TFloatField;
    qryPaysPay: TWideStringField;
    qryPaysPaid: TWideStringField;
    qryPaysClassName: TWideStringField;
    qryPaysDeleted: TWideStringField;
    qryPaysPayNo: TIntegerField;
    qryPaysGL: TWideStringField;
    qryPaysSplits: TWideStringField;
    qryPaysFirstName: TWideStringField;
    qryPaysLastName: TWideStringField;
    qryPaysCUSTFLD1: TWideStringField;
    qryPaysCUSTFLD2: TWideStringField;
    qryPaysCUSTFLD3: TWideStringField;
    qryPaysCUSTFLD4: TWideStringField;
    qryPaysCUSTFLD5: TWideStringField;
    qryPaysCUSTFLD6: TWideStringField;
    qryPaysCUSTFLD7: TWideStringField;
    qryPaysCUSTFLD8: TWideStringField;
    qryPaysCUSTFLD9: TWideStringField;
    qryPaysCUSTFLD10: TWideStringField;
    qryPaysCUSTFLD11: TWideStringField;
    qryPaysCUSTFLD12: TWideStringField;
    qryPaysCUSTFLD13: TWideStringField;
    qryPaysCUSTFLD14: TWideStringField;
    qryPaysCUSTFLD15: TWideStringField;
    dsPays: TDataSource;
    Label4: TLabel;
    qryPayRunMessageUuid: TWideStringField;
    qryPayRunMessageType: TWideStringField;
    qryPayRunMessageStatus: TWideStringField;
    qryPayRunComplete: TWideStringField;
    qryPayRunATOMessage: TWideMemoField;
    qryPayRunATOResponse: TWideMemoField;
    btnShowResponse: TDNMSpeedButton;
    Label5: TLabel;
    edtStatus: TDBEdit;
    wwCheckBox1: TwwCheckBox;
    btnSTPDetailList: TDNMSpeedButton;
    btnSTPSubmissionData: TDNMSpeedButton;
    qryPayRunOriginalRef: TWideStringField;
    btnValidateXML: TDNMSpeedButton;
    qryPaysActive: TWideStringField;
    qryPaysTermination: TWideStringField;
    qryPaysEmployeeID2: TIntegerField;
    qryPaysEmpName: TWideStringField;
    qryPaysYearFinal: TERPQuery;
    WideStringField1: TWideStringField;
    DateField1: TDateField;
    WideStringField2: TWideStringField;
    DateTimeField1: TDateTimeField;
    WordField1: TWordField;
    WideStringField3: TWideStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    FloatField5: TFloatField;
    FloatField6: TFloatField;
    FloatField7: TFloatField;
    FloatField8: TFloatField;
    FloatField9: TFloatField;
    FloatField10: TFloatField;
    FloatField11: TFloatField;
    FloatField12: TFloatField;
    WideStringField4: TWideStringField;
    WideStringField5: TWideStringField;
    IntegerField1: TIntegerField;
    WideStringField6: TWideStringField;
    WideStringField7: TWideStringField;
    WideStringField8: TWideStringField;
    WideStringField9: TWideStringField;
    WideStringField10: TWideStringField;
    WideStringField11: TWideStringField;
    WideStringField12: TWideStringField;
    WideStringField13: TWideStringField;
    WideStringField14: TWideStringField;
    WideStringField15: TWideStringField;
    WideStringField16: TWideStringField;
    WideStringField17: TWideStringField;
    WideStringField18: TWideStringField;
    WideStringField19: TWideStringField;
    WideStringField20: TWideStringField;
    WideStringField21: TWideStringField;
    WideStringField22: TWideStringField;
    WideStringField23: TWideStringField;
    WideStringField24: TWideStringField;
    WideStringField25: TWideStringField;
    WideStringField26: TWideStringField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    WideStringField27: TWideStringField;
    WideStringField28: TWideStringField;
    IntegerField4: TIntegerField;
    WideStringField29: TWideStringField;
    qryTerminated: TERPQuery;
    WideStringField30: TWideStringField;
    DateField2: TDateField;
    WideStringField31: TWideStringField;
    DateTimeField2: TDateTimeField;
    WordField2: TWordField;
    WideStringField32: TWideStringField;
    FloatField13: TFloatField;
    FloatField14: TFloatField;
    FloatField15: TFloatField;
    FloatField16: TFloatField;
    FloatField17: TFloatField;
    FloatField18: TFloatField;
    FloatField19: TFloatField;
    FloatField20: TFloatField;
    FloatField21: TFloatField;
    FloatField22: TFloatField;
    FloatField23: TFloatField;
    FloatField24: TFloatField;
    WideStringField33: TWideStringField;
    WideStringField34: TWideStringField;
    IntegerField5: TIntegerField;
    WideStringField35: TWideStringField;
    WideStringField36: TWideStringField;
    WideStringField37: TWideStringField;
    WideStringField38: TWideStringField;
    WideStringField39: TWideStringField;
    WideStringField40: TWideStringField;
    WideStringField41: TWideStringField;
    WideStringField42: TWideStringField;
    WideStringField43: TWideStringField;
    WideStringField44: TWideStringField;
    WideStringField45: TWideStringField;
    WideStringField46: TWideStringField;
    WideStringField47: TWideStringField;
    WideStringField48: TWideStringField;
    WideStringField49: TWideStringField;
    WideStringField50: TWideStringField;
    WideStringField51: TWideStringField;
    WideStringField52: TWideStringField;
    WideStringField53: TWideStringField;
    WideStringField54: TWideStringField;
    WideStringField55: TWideStringField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    WideStringField56: TWideStringField;
    WideStringField57: TWideStringField;
    IntegerField8: TIntegerField;
    WideStringField58: TWideStringField;
    wwDBGrid1: TwwDBGrid;
    dsTerminated: TDataSource;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSubmitClick(Sender: TObject);
    procedure GetStatusClick(Sender: TObject);
    procedure grdPaysDblClick(Sender: TObject);
    procedure btnShowResponseClick(Sender: TObject);
    procedure btnSTPDetailListClick(Sender: TObject);
    procedure btnSTPSubmissionDataClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnValidateXMLClick(Sender: TObject);
    procedure chkYearFinalClick(Sender: TObject);

  private

    ozedi2: TOzEDI2;


    PayRun: TPayRun;
    CleanInvalidated: Boolean;
    aTempfilename: string;

    procedure BeforeShow(Sender: TObject);
    function CheckPrerequisites: boolean;
    procedure DoUpdated;
    procedure Deletetempfile;
    function FinancialYear: Integer;
 protected
 public
    procedure UpdateMe; overload; override;
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); overload; override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); override;
 end;

var
  fmATOPayEvent: TfmATOPayEvent;

implementation

uses
  ERPVersionConst, BusObjConst, XMLIntf, XMLDoc, CommonDbLib, utOzEDIStub,  JsonObjectUtils,
  CommonLib, AppEnvironment, CommonFormLib, frmATOPayEventErrors, SystemLib,
  frmSTPPayRunDetailList, ShellAPI, LogLib, tcConst, DateUtils,
  DbSharedObjectsObj;

{$R *.dfm}

Const
  Pay_Submit = 0;
  Pay_Update = 1;

{ TfmATOPayEvent }


function TfmATOPayEvent.FinancialYear: Integer;
var
   myDate : TDateTime;
  myYear, myMonth, myDay : Word;
  myHour, myMin, mySec, myMilli : Word;

begin
      myDate := qryPayRun.FieldByName('RunDate').AsDateTime;

       DecodeDateTime(myDate, myYear, myMonth, myDay,
                 myHour, myMin, mySec, myMilli);


  result := myYear;

end;



procedure TfmATOPayEvent.BeforeShow(Sender: TObject);
begin
  if Sender is TBaseInputGUI then
    TBaseInputGUI(Sender).AttachObserver(self);
end;


procedure TfmATOPayEvent.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

//function TfmATOPayEvent.CreateEventDocs(var XMLStr, msg: string): boolean;
//end;

procedure TfmATOPayEvent.btnSubmitClick(Sender: TObject);
var
  msg: string;
  messageType: integer;
  TempFileName: string;
  eventDocsCreated: Boolean;

//  ozedi2: TOzEDI2;

  Json: TJsonObject;
  IsConformanceTest: boolean;
  ABN: string;
  stream: TStringStream;
  qry: TMyQuery;
  finYearEnd: Integer;
begin
  inherited;
  IsConformanceTest := false;

  if (PayRun.PaysProcessed = 0) and (Pos('Conformance Test',PayRun.Notes) = 1) then
    IsConformanceTest := true;

  if not CheckPrerequisites then
    exit;

  if not PayRun.FinancialYearFinalRun then begin
    if PayRun.IsLastForFinancialYear then
      case CommonLib.MessageDlgXP_Vista('This may be the last Pay Run this financial year, do you want to tick "Year End"?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
        mrYes: PayRun.FinancialYearFinalRun := true;
        mrNo:;
        mrCancel: exit;
      end;
  end;

  if PayRun.Submitted then begin

    if PayRun.Invalidated then begin
      { it has been invalidate because a pay has been deleted so .. this is a complete replacement }
      messageType := Pay_Submit;
    end
    else begin
      if CommonLib.MessageDlgXP_Vista('This Pay Run has already been submitted to the ATO, do you wish to send it again?', mtConfirmation,[mbNo,mbYes],0) = mrNo then
        exit;
       messageType := Pay_Update;
    end;
  end
  else begin
    { not submitted yet }
    messageType := Pay_Submit;
  end;

   if messageType = Pay_Submit then
        showProgressbar('Submitting New Pay Run' , 100)
   else showProgressbar('Updating Existing Pay Run' , 100);

  Json := JO;
  try
    TempFileName := GetAppTempDir + 'PayRun_' + FormatDateTime('yyyy-mm-dd-hhnnss',now) + '.xml';
    DeleteFile(TempFileName);
      if IsConformanceTest then
      begin
         qry := DbSharedObjectsObj.DbSharedObj.GetQuery(MyConnection);
         try
            qry.SQL.Text := 'select * from tblpayruntest where PayRunID = ' + IntToStr(PayRun.ID);
            qry.Open;
            qry.Edit;
            qry.FieldByName('UploadFileName').AsString := ExtractFileName(TempFileName);
            qry.Post;
         finally
            DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
         end;

         ABN := PayRun.GetABNFromATOMessage;
         stream := TStringStream.Create;
         try
            stream.WriteString(PayRun.ATOMessage);
            stream.Position := 0;
            stream.SaveToFile(TempFileName);
         finally
            stream.Free;
         end;
      end
      else
      begin

    //     PayRun.STPversion := STP_VERSION;

         ABN := AppEnv.CompanyInfo.ABN;
         PayRun.EditDB;

         if chkYearFinal.Checked then
         begin

            finYearEnd := FinancialYear;
            qryPaysYearFinal.ParamByName('Start').AsString := IntToStr(finYearEnd - 1) + '-07-01 00:01:00';
            qryPaysYearFinal.ParamByName('End').AsString := IntToStr(finYearEnd) + '-06-30 23:59:00';
            eventDocsCreated := PayRun.CreateEventDocs(TempFileName, msg, qryPaysYearFinal);
         end
         else
         begin
            eventDocsCreated := PayRun.CreateEventDocs(TempFileName, msg, nil);
         end;

         if not eventDocsCreated then
         begin
            HideProgressbar;
            CommonLib.MessageDlgXP_Vista('Could not create Pay Run Upload File.' + #13#10 + #13#10 +
              msg, mtInformation, [mbOk], 0);
            exit;
         end;
         PayRun.PostDb;
      end;

  //    exit;

      ozedi2 := TOzEDI2.Create;
      try
         try
            ozedi2.STPversion  := STP_VERSION;

            ozedi2.ABN         := ABN;


//            ozedi2.ClientID         := '90922671';
//           ozedi2.SandPitMode := true;
//           ozedi2.UserSandpit := 'api@erpoz.com';
//           ozedi2.PassSandpit := 'erpapi1';

          //      messageType := Pay_Update;

            try
               Json.AsString := ozedi2.Upload(messageType, TempFileName);
            except
               on E: Exception do
               begin
                  logtext(TempFileName);
                  CommonLib.MessageDlgXP_Vista('Error sending Pay Run Message to ATO.' + NL + NL +
                    E.Message, mtInformation, [mbOk], 0);
                  exit;
               end;
            end;
            PayRun.MessageUuid := Json.S['messageUuid'];
            PayRun.messageType := Json.S['messageType'];
            PayRun.MessageStatus := Json.S['messageStatus'];

            if messageType = Pay_Submit then
            begin
               if PayRun.Invalidated then
                  PayRun.AddNote('Replacement Pay Run Message submitted to ATO.')
               else
                  PayRun.AddNote('New Pay Run Message submitted to ATO.');
            end
            else
            begin
               PayRun.AddNote('Updated Pay Run Message submitted to ATO.');
            end;

            PayRun.Submitted := true;
            PayRun.SubmittedDate := now;
            PayRun.Complete := false;
            { only reset this after sucessfully processed by ATO }
            // PayRun.Invalidated := false;
            // Prog.CloseDialog;
            HideProgressbar;
            CommonLib.MessageDlgXP_Vista
              ('Pay Run Details have been sent to the ATO, the Message Status is: ' +
              PayRun.MessageStatus, mtInformation, [mbOk], 0);
         except
            on E: Exception do
            begin
               HideProgressbar;
               PayRun.AddNote('Error submitting: ');
               PayRun.AddNote(E.Message);
               CommonLib.MessageDlgXP_Vista('Error sending Pay Run Message to ATO.' + #13#10 +
                 #13#10 + msg, mtInformation, [mbOk], 0);
            end;
         end;
         PayRun.PostDb;
         CommitTransaction;
         BeginTransaction;
      finally
         ozedi2.Free;
      end;
   finally
      Json.Free;
      PayRun.PostDb;
      self.CommitTransaction;
      self.BeginTransaction;
      HideProgressbar;
   end;
end;


procedure TfmATOPayEvent.btnValidateXMLClick(Sender: TObject);
var
    dir : string;
    xml, xsd: IXMLDOMDocument2;
    cache: IXMLDOMSchemaCollection;
    xmlFile: String;
    result: Boolean;
    err: IXMLDOMParseError;
begin
  inherited;
  dir := GetCurrentDir;
  SHGetFolderPath(0, CSIDL_DESKTOP , 0, 0, PChar(dir));
  xmlFile := dir + '\ERPPayRun_2022-01-28-134410.xml';
  xsd := CoDOMDocument60.Create;
  xsd.Async := False;
  xsd.load(dir + '\ato.payevnt.0004.2020.01.01.xsd');
  cache := CoXMLSchemaCache60.Create;
  cache.add('', xsd);
  xml := CoDOMDocument60.Create;
  xml.async := False;
  xml.schemas := cache;
  result := xml.load(xmlFile);
  if not result then
    err := xml.parseError
  else
    err := nil;
end;


function TfmATOPayEvent.CheckPrerequisites: boolean;
begin
  result := true;

  if AppEnv.PayPrefs.OzEdiClientID = '' then begin
    result := false;
    CommonLib.MessageDlgXP_Vista('Before ATO Pay Events can be processed a Client ID is required.' + #13#10 + #13#10 +
      'Please contact TrueERP Support to obtain your Client ID and then enter ' +
      'this into Preferences > Payroll > Single Touch Payroll > Client ID.',mtInformation,[mbOk],0);
    exit;
  end;

  if AppEnv.PayPrefs.SoftwareInformationBusinessManagementSystemId = '' then begin
    result := false;
    CommonLib.MessageDlgXP_Vista('Before ATO Pay Events can be processed a Software ID is required.' + #13#10 + #13#10 +
      'Please open Preferences > Payroll > Single Touch Payroll > System ID and click on the "Generate" button.',mtInformation,[mbOk],0);
    exit;
  end;

end;


procedure CopyRecord(Source, Destination: TDataSet);
var Ind:longint;
    SField, DField: TField;
begin
 for Ind := 0 to Source.FieldCount - 1 do

   Destination.FieldByName(Source.FieldDefs[Ind].Name).Assign
      (Source.FieldByName(Source.FieldDefs[Ind].Name));
 //  Destination.Fields[Ind].AsVariant := Source.Fields[Ind].AsVariant;
end;


procedure TfmATOPayEvent.chkYearFinalClick(Sender: TObject);
var
  finYearEnd: Integer;
begin
  inherited;

  qryPaysYearFinal.Close;

   if chkYearFinal.Checked then
   begin

 //     qryPays.SQL[qryPays.SQL.Count - 3] := 'WHERE tblpays.DatePaid BETWEEN :Start AND :End';




      finYearEnd := FinancialYear;

      qryPaysYearFinal.ParamByName('Start').AsString := IntToStr(finYearEnd - 1) + '-07-01 00:01:00';
      qryPaysYearFinal.ParamByName('End').AsString := IntToStr(finYearEnd) + '-06-30 23:59:00';

      qryTerminated.ParamByName('Start').AsString := IntToStr(finYearEnd - 1) + '-07-01 00:01:00';
      qryTerminated.ParamByName('End').AsString := IntToStr(finYearEnd) + '-06-30 23:59:00';

      qryTerminated.Open;

      qryPaysYearFinal.Open;



//      qryPays.ParamByName('Start').AsDateTime := FormatDateTime('2008/07/01 00:00:00');
//      qryPays.ParamByName('End').AsDateTime := FormatDateTime('2009/06/30 23:59:00');

   end
   else
   begin

  //       ShowMessage('qryPaysYearFinal.SQLText ' + qryPaysYearFinal.SQLText);

//            qryPays.ParamByName('Start').AsString := '1911-07-01 00:01:00';
//            qryPays.ParamByName('End').AsString := '1911-01-01 23:59:00';


   end;


   qryPaysYearFinal.Open;


   self.BeginTransaction;


end;



procedure TfmATOPayEvent.btnShowResponseClick(Sender: TObject);
begin
  inherited;
  if PayRun.ATOResponse <> '' then begin
    PayRun.PopulateErrors;
    ShowPayEventErrors(PayRun.ErrorList);
  end else
    CommonLib.MessageDlgXP_Vista('There is no Response Message from the ATO',mtInformation,[mbOk],0);
end;

procedure TfmATOPayEvent.btnSTPDetailListClick(Sender: TObject);
var
  ListForm: TfmSTPPayRunDetailList;
begin
  inherited;
  ListForm := TfmSTPPayRunDetailList.Create(Application);
  ListForm.PayRunID := PayRun.ID;
  ListForm.FormStyle := fsMDIChild;
  ListForm.BringToFront;
end;

procedure TfmATOPayEvent.btnSTPSubmissionDataClick(Sender: TObject);
begin
  Deletetempfile;
  aTempfilename := GetTemporaryFileName('STP_'+FormatdateTime('yyyy-mm-dd',date),'.xml');

  if chkYearFinal.Checked then
     clog(PayRun.Payrundata(qryPays), aTempfilename)
  else
      clog(PayRun.Payrundata(nil), aTempfilename);

  if FileExists(aTempfilename) then ShellExecute(Handle, 'Open', PChar(aTempfilename), '', '', SW_SHOWNORMAL);
end;

procedure TfmATOPayEvent.DoBusinessObjectEvent(const Sender: TDatasetBusObj;
  const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if sender is TPayRun then
      TPayRun(Sender).Dataset := qryPayRun;
  end;

end;

procedure TfmATOPayEvent.DoUpdated;
begin
  PayRun.RefreshDB;
  qryPays.Close;
  qryPays.Open;
  if PayRun.Submitted and PayRun.Invalidated and (not CleanInvalidated) then begin
    CleanInvalidated := PayRun.Invalidated;
    CommonLib.MessageDlgXP_Vista('This Pay Run has already been submitted so will now need to be Submitted again after these changes.',mtInformation,[mbOk],0);
  end;
end;

procedure TfmATOPayEvent.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  if Assigned(stp_conf_tests) then
//    JsonToFileFormated(stp_conf_tests,'stp_conf_tests.json');

  Action := caFree;
end;

procedure TfmATOPayEvent.FormCreate(Sender: TObject);
begin
  inherited;
  btnSTPSubmissionData.Visible := Devmode;
  PayRun := TPayRun.CreateWithNewConn(self);
  PayRun.Connection.Connection := MyConnection;
  PayRun.BusObjEvent := DoBusinessObjectEvent;
end;


Procedure TfmATOPayEvent.Deletetempfile;
begin
  if aTempfilename <> '' then
    if FileExists(aTempfilename) then
       sysutils.deletefile(aTempfilename);
end;


procedure TfmATOPayEvent.FormDestroy(Sender: TObject);
begin
  DeleteTempfile;
  inherited;
end;



procedure TfmATOPayEvent.FormShow(Sender: TObject);
var
  finYearEnd: Integer;
  f : Integer;
begin
   inherited;

   PayRun.load(KeyID);
   // TestInst := nil;
   // stp_conf_tests := nil;
   // if PayRun.PaysProcessed = 0 then begin
   // stp_conf_tests := JO;
   // if FileExists('stp_conf_tests.json') then begin
   // stp_conf_tests.LoadFromFile('stp_conf_tests.json');
   // TestInst := stp_conf_tests.O[IntToStr(PayRun.ID)];
   // end;
   // end;
   CleanInvalidated := PayRun.Invalidated;
   qryPays.ParamByName('PayRunID').AsInteger := KeyID;
   qryPays.ParamByName('OriginalPayRunID').AsInteger := PayRun.OriginalID;
   clog(qryPays.SQLText);


   // for i := 0 to qryPays.SQL.Count - 1 do
   // ShowMessage(qryPays.SQL[i]);

    //  qryPays.Open;



   if chkYearFinal.Checked then
   begin

 //     qryPays.SQL[qryPays.SQL.Count - 3] := 'WHERE tblpays.DatePaid BETWEEN :Start AND :End';

  //  try

      finYearEnd := FinancialYear;

      qryPaysYearFinal.ParamByName('Start').AsString := IntToStr(finYearEnd - 1) + '-07-01 00:01:00';
      qryPaysYearFinal.ParamByName('End').AsString := IntToStr(finYearEnd) + '-06-30 23:59:00';

      qryTerminated.ParamByName('Start').AsString := IntToStr(finYearEnd - 1) + '-07-01 00:01:00';
      qryTerminated.ParamByName('End').AsString := IntToStr(finYearEnd) + '-06-30 23:59:00';

      qryTerminated.Open;

      qryPaysYearFinal.Open;

//        while not qryPaysYearFinal.Eof do
//        begin
//          if qryPaysYearFinal.FieldByName('Termination').AsString = 'T' then
//          begin
//             qryPays.Append;
//             CopyRecord( qryPaysYearFinal, qryPays );
//             qryPays.Post;
//          end;
//          qryPaysYearFinal.Next;
//        end;
//
//
//
//       qryPays.Close;

   //   for f := 0 to qryFields.Fields.Count - 1 do
   //     qryPays.Fields.Add(qryFields.Fields[f]);

    //   qryPays.Open;




//  Except

 // End;

     // ShowMessage('qryPays.SQLText ' + qryPays.SQLText);


//      qryPays.ParamByName('Start').AsDateTime := FormatDateTime('2008/07/01 00:00:00');
//      qryPays.ParamByName('End').AsDateTime := FormatDateTime('2009/06/30 23:59:00');

   end
   else
   begin

//            qryPays.ParamByName('Start').AsString := '1911-07-01 00:01:00';
//            qryPays.ParamByName('End').AsString := '1911-01-01 23:59:00';


   end;



   qryPays.Open;


//      while not qryPays.Eof do
//      begin
//
//        totalWages := totalWages + qryPays.FieldByName('Wages').AsFloat;
//        totalGross := totalGross + qryPays.FieldByName('Gross').AsFloat;
//        totalTax := totalTax + qryPays.FieldByName('Tax').AsFloat;
//
//        info := '';
//
//        if qryPays.FieldByName('Termination').AsString = 'T' then
//        begin
//            info := '   Termination ' + qryPays.FieldByName('EmployeeName').AsString;
// //       info := info + 'Active ' + qryPays.FieldByName('Active').AsString + '   Termination ' + qryPays.FieldByName('Term').AsString;
//           ShowMessage(info);
//        end;
//
//        if qryPays.FieldByName('Active').AsString = 'F' then
//        begin
//            info := '   not Active ' + qryPays.FieldByName('EmployeeName').AsString;
// //       info := info + 'Active ' + qryPays.FieldByName('Active').AsString + '   Termination ' + qryPays.FieldByName('Term').AsString;
//           ShowMessage(info);
//        end;
//
//
//        qryPays.Next;
//      end;
//      qryPays.Close;

//      ShowMessage('total Gross ' + FloatToStr(totalGross) + '   total Tax ' + FloatToStr(totalTax));


   self.BeginTransaction;
end;



procedure TfmATOPayEvent.GetStatusClick(Sender: TObject);
var
  NewMessageStatus: string;
begin
  inherited;
  if not CheckPrerequisites then
  begin
   //  ShowMessage('CheckPrerequisites false');
    CommonLib.MessageDlgXP_Vista('CheckPrerequisites false',mtInformation,[mbOK],0);
    exit;
  end;

  if PayRun.Complete then begin
    CommonLib.MessageDlgXP_Vista('This Pay Run is already complete',mtInformation,[mbOK],0);
    exit;
  end;

  self.CommitTransaction;


  TPayRun.CheckRunStatus(PayRun.ID,MyConnection,PayRun.ErrorList, NewMessageStatus);

  PayRun.RefreshDB;
  //PayRun.Load(PayRun.ID);
  self.BeginTransaction;
end;


procedure TfmATOPayEvent.grdPaysDblClick(Sender: TObject);
begin
//  inherited;
  if Assigned(grdPays.SelectedField) then begin
    if (grdPays.SelectedField = qryPaysEmployeeName) or
       (grdPays.SelectedField = qryPaysFirstName) or
       (grdPays.SelectedField = qryPaysLastName) then begin
      OpenERPForm('TfrmEmployee', qryPaysEmployeeID.AsInteger, nil, BeforeShow);
    end
    else begin
      OpenERPForm('TfrmEmployeePay', qryPaysPayID.AsInteger, nil, BeforeShow);
    end;
  end;
end;

procedure TfmATOPayEvent.UpdateMe;
begin
  inherited;
  DoUpdated;
end;

procedure TfmATOPayEvent.UpdateMe(const Cancelled: boolean;
  const aObject: TObject);
begin
  inherited;
  if not Cancelled then begin
    DoUpdated;
  end;
end;

initialization
  RegisterClass(TfmATOPayEvent);

end.
