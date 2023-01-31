unit frmCorrespondanceBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, WordXP, OleServer, DNMSpeedButton, wwdblook,
  Shader, DNMPanel , tcTypes, BusObjCorrespondence;
{TfmCorrespondanceBase
    |-------Customer contact  : TfmCustomerCorrespondenceCreate
    |-------Supplier Contact  : TfmSupplierCorrespondenceCreate
    |-------Employee          : TfmEmployeeCorrespondenceCreate
    |-------Marketing Contact : TfmCorrespondenceCreate
    |-------Other contact     : TfmOthercontactCorrespondenceCreate}

type
  TReferencetype =  (rtMarketingcontact, rtEmployee, rtSupplier, rtCustomer , rtcustomercontact , rtSupplierContact ,rtOthercontactcontact, rtRepair);

  TfmCorrespondanceBase = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryReferenceLookup: TERPQuery;
    cboCorrespondencetype: TwwDBLookupCombo;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    WordApplication1: TWordApplication;
    WordDocument1: TWordDocument;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cboCorrespondencetypeNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure qryReferenceLookupBeforeOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
  private
    fiReferenceId: Integer;
    fReferencetype: TReferencetype;
    fiReferencecontactId: Integer;
    fsMessageTo: String;
    fsEmailId: String;
    fsDefaultEmailText: String;
    fOwnerConnection: TERPConnection;
    fiClientID: Integer;
    fsTransData2: String;
    fsTransData1: String;
    procedure SetCorrespondenceType(const Value: tcTYpes.TCorrespondenceType);
    function GetOwnerConnection: TERPConnection;
    procedure MakeEmail(Correspondence:TCorrespondence);
    function  RefTypetoString(const Value:TReferencetype):String;
    procedure SetReftype(const Value: TReferencetype);
    procedure SetEmailId(const Value: String);
    function  PopulateTransData(const Value:String):String;
  Protected
        fCorrespondenceType: TCorrespondenceType;
        Procedure SetReferenceTypeID(var Value :String);virtual;abstract;
        Procedure SetReferenceName(var Value :String);virtual;abstract;
        procedure Setreferencetype(var Value: String);virtual;
        Procedure SetReferenceAddressPart1(Var Value:String);virtual;abstract;
        Procedure SetReferenceAddressPart2(Var Value:String);Virtual;abstract;
        Procedure SetReferenceSalutation(Var Value:String);virtual;abstract;
  public
    AttachmentList: TStringList;
    property CorrespondenceType : TCorrespondenceType read fCorrespondenceType write SetCorrespondenceType;
    Property ReferenceId        : Integer read fiReferenceId write fiReferenceId;
    Property Referencetype      : TReferencetype read fReferencetype write SetReftype;
    Property ReferencecontactId : Integer read fiReferencecontactId write fiReferencecontactId;
    Property ClientID           : Integer read fiClientID write fiClientID;
    Property EmailId            : String read fsEmailId write SetEmailId;
    Property MessageTo          : String read fsMessageTo write fsMessageTo;
    Property DefaultEmailText   : String read fsDefaultEmailText write fsDefaultEmailText;
    property OwnerConnection: TERPConnection read GetOwnerConnection write fOwnerConnection;
    Property TransData1:String read fsTransData1 Write fsTransData1;
    Property TransData2:String read fsTransData2 write fsTransData2;
  end;


implementation

uses frmCorrespondenceReference, CommonLib, frmEmailCorrespondenceReference,
  frmLetterCorrespondenceReference, EmailUtils, EmailExtraUtils, DNMLib,
  {$Warnings Off}
  OleAuto,
  {$Warnings On}
  BusObjBase, AppEnvironment, SimpleEncrypt, tcDataUtils, CommonDbLib,
  Preferences, remainClientFrm, FastFuncs , strUtils, tcConst,
  CorrespondenceObj;


{$R *.dfm}

{ TfmCorrespondanceBase }
Procedure TfmCorrespondanceBase.MakeEmail(Correspondence: TCorrespondence);
var
  Corres: TCorrespondenceGui;
  x: integer;
  lSilent, lSecret : boolean;
begin
  Corres := TCorrespondenceGui.Create;
  try
    Corres.RecipientList := EmailId;
    Corres.Subject := cboCorrespondencetype.Text;

    Correspondence.MessageTo := Messageto;

    { BCC back to sender }
    if not AppEnv.Employee.UseEmpEmailAsFromAddress then begin
      if AppEnv.CompanyInfo.TrackEmails then begin
      end;
      Correspondence.MessageFrom := AppEnv.Employee.EmployeeName + ' (' + AppEnv.CompanyInfo.Email + ')';
    end  else begin
      if AppEnv.Employee.TrackEmails then begin
      end;
      Correspondence.MessageFrom := AppEnv.Employee.EmployeeName + ' (' + AppEnv.Employee.Email + ')';
    end;

    Corres.MessageText := DefaultEmailText + #13#10 + PopulateTransData(qryReferenceLookup.FieldByName('CorrespondenceText').AsString);

    if AttachmentList.Count > 0 then begin
      for x := 0 to AttachmentList.Count -1 do begin
        Corres.AttachmentList.Add(AttachmentList[x]);
      end;

    end;
    Correspondence.PostDb;

    Corres.Correspondence.ContactId := Correspondence.ContactId;
    Corres.Correspondence.CusId := Correspondence.CusId;
    Corres.Correspondence.SupId := Correspondence.SupId;
    Corres.Correspondence.MarketingContactId := Correspondence.MarketingContactId;
    Corres.Correspondence.EmployeeId := Correspondence.EmployeeId;
    Corres.Correspondence.EmployeeId := Correspondence.EmployeeId;
    Corres.Correspondence.OtherContactId := Correspondence.OtherContactId;
    Corres.Correspondence.RepairID := Correspondence.RepairID;

    Correspondence.Delete;
    if not EmailShortSendMode(lSilent, lSecret) then
      exit;
    Corres.Execute(lSilent, lSecret);
  finally
    Corres.Free;
  end;
end;

procedure TfmCorrespondanceBase.qryReferenceLookupBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if Assigned(OwnerConnection) then
    qryReferenceLookup.Connection := OwnerConnection;
end;

function TfmCorrespondanceBase.RefTypetoString(const Value: TReferencetype): String;
begin
       if Value = rtMarketingcontact then result := 'Marketing Contact'
  else if Value = rtEmployee then result := 'Employee'
  else if Value = rtSupplier then result := 'Supplier'
  else if Value = rtCustomer then result := 'Customer'
  else if Value = rtcustomercontact then result := 'Supplier Contact'
  else if Value = rtSupplierContact then result := 'Customer Contact'
  else if value = rtOthercontactcontact then result := 'Other contact contact'
  else if Value = rtRepair              then result := 'Repair';
end;

procedure TfmCorrespondanceBase.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;
function  TfmCorrespondanceBase.PopulateTransData(const Value:String):String;
begin
  Result := Value;
  Result := replacestr(result , '»'+CORRESPONDENCE_FIELD1+'«' , TransData1);
  Result := replacestr(result , '»'+CORRESPONDENCE_FIELD2+'«' , TransData2);
end;
procedure TfmCorrespondanceBase.btnSaveClick(Sender: TObject);
var
  qry: TERPQuery;
  Correspondence: TCorrespondence;
  Option: Word;
  FileNameTemplate: OleVariant;
  FileName: OleVariant;
  wOleF: OleVariant;
  wOleT: OleVariant;
  wDoc: _Document;
  Form : TComponent;
  txtLine: string;
begin
  inherited;
  if Trim(cboCorrespondencetype.Text) = '' then begin
    CommonLib.MessageDlgXP_Vista('You must enter a Reference', mtCustom, [mbOK], 0);
    SetControlFocus(cboCorrespondencetype);
    Exit;
  end else if not IsValidFileName(cboCorrespondencetype.Text) then begin
    CommonLib.MessageDlgXP_Vista('Reference you entered is invalid. It cannot contain characters like \ / : * ? " < > |.',
      mtInformation, [mbOK], 0);
    SetControlFocus(cboCorrespondencetype);
    Exit;
  end;
  qry := TERPQuery.Create(nil);
  Correspondence := TCorrespondence.Create(nil);
  try
    qry.Connection := OwnerConnection;
    Correspondence.Connection := TMyDacDataConnection.Create(Correspondence);
    Correspondence.Connection.Connection := OwnerConnection;
    Correspondence.Load(0);
    if OwnerConnection = MyConnection then
      self.BeginTransaction
    else
      Correspondence.Connection.BeginNestedTransaction;
    Correspondence.New;
    try

      Correspondence.ReferenceTxt := cboCorrespondencetype.Text;
      Correspondence.Ref_Date := now;

      (*if (Owner is TfmMarketingLead) then begin
        Correspondence.MarketingContactId := TfmMarketingLead(Owner).Lead.MarketingContactID;
      end;*)
      if Referencetype          =  rtMarketingcontact then begin Correspondence.MarketingContactId :=ReferenceId;
      end else if Referencetype =  rtEmployee         then begin Correspondence.EmployeeId         :=ReferenceId;
      end else if Referencetype =  rtSupplier         then begin Correspondence.SupId              :=ReferenceId;
      end else if Referencetype =  rtCustomer         then begin Correspondence.CusId              :=ReferenceId;
      end else if Referencetype = rtRepair            then begin
                                    Correspondence.RepairID           := ReferenceId;
                                    Correspondence.CusId              := ClientID;
                                    Correspondence.ContactId          := ReferencecontactId;
      end else if Referencetype = rtCustomerContact then begin
                                    Correspondence.CusId              := ReferenceId;
                                    Correspondence.ContactId          := ReferencecontactId;
      end else if Referencetype = rtOthercontactcontact then begin
                                    Correspondence.OthercontactID     := ReferenceId;
                                    Correspondence.ContactId          := ReferencecontactId;
      end else if Referencetype = rtSupplierContact then begin
                                    Correspondence.SupId              := ReferenceId;
                                    Correspondence.ContactId          := ReferencecontactId;
      end;

      if CorrespondenceType = tcTypes.ctEmail then begin
        Correspondence.Ref_Type := 'Email';
        MakeEmail(Correspondence);
      end else begin
        { Letter or Fax .. }
        {---------------------------------------------------}
        FileName :=  Appenv.DocPath.DocumentPath;
        if FileName <> '' then
          FileName := FileName + '\' + Correspondence.ReferenceTxt
        else FileName := 'C:\' + Correspondence.ReferenceTxt;

        if FileExists(FileName) then begin
          CommonLib.MessageDlgXP_Vista('That Reference is already in use, please enter another Reference', mtCustom, [mbOK], 0);
          SetControlFocus(cboCorrespondencetype);
          Exit;
        end;

        if CorrespondenceType = ctFax then begin
          Correspondence.Ref_Type := 'Fax';
        end else if CorrespondenceType = ctLetter then begin
          Correspondence.Ref_Type := 'Letter';
        end;

        if AppEnv.Employee.UseWord then begin
          WordApplication1.Disconnect;
          try
            WordApplication1.DDETerminateAll;
          except
            option :=  MessageDlgXP_Vista('Could not create MS Word document.' +chr(13)+chr(13)+
                                      'If Word is not installed on this computer would you like to set "Use MS Word" preference to false OR'+chr(13)+ 'Open the Preference form? '
                                      ,mtconfirmation, [mbYes, mbNo], 0, nil , '','', False, nil, 'Open Preference Form');
            if Option = mrYes then begin
              qry := CommonDBLib.TempMyQuery;
              try
                qry.SQL.Add('update tblpersonalpreferences Set UseWord = ''F'' where EmployeeID = '+ IntToStr(AppEnv.Employee.EmployeeID)  + ';');
                qry.Execute;
                AppEnv.Employee.PopulateMe(AppEnv.Employee.EmployeeID, false);
              finally
                FreeAndNil(qry);
              end;
            end else if Option = 100 then begin
              OpenPrefform('Utilities' ,  'chkUseWord');
            end;
            close;
            exit;
          end;
          try
            WordApplication1.Connect;
            WordApplication1.Visible := true;
            WordDocument1.Activate;
            with WordApplication1 do begin
              // Use Doc Template
              try
                if AppEnv.CompanyInfo.Usedocumenttemplate and
                  (FileExists(AppEnv.CompanyInfo.DocumentTemplatePath)) then begin
                  FileNameTemplate := AppEnv.CompanyInfo.DocumentTemplatePath;
                  wOleF := false;
                  wOleT := true;
                  WordDocument1.Close;
                  wDoc := WordApplication1.Documents.Add(FileNameTemplate, wOleF, EmptyParam, EmptyParam);
                  WordDocument1.ConnectTo(wDoc);
                  WordDocument1.SaveAs(FileName);
                end else begin
                  WordDocument1.SaveAs(FileName);
                end;
              except
                on E: EOleException do begin
                  CommonLib.MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
                end;
              end;

              if not AppEnv.CompanyInfo.HideCompanyName then begin
                Selection.TypeParagraph;
                Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
                with Selection.Font do begin
                  if AppEnv.CompanyInfo.FontCompanyName <> '' then
                    Name := AppEnv.CompanyInfo.FontCompanyName
                  else Name := 'Times New Roman';
                  if AppEnv.CompanyInfo.SizeCompanyName > 0 then
                    Size := AppEnv.CompanyInfo.SizeCompanyName
                  else Size := 36;
                  if AppEnv.CompanyInfo.ColorCompanyName <> '' then
                    Color := StringToColor(AppEnv.CompanyInfo.ColorCompanyName)
                  else Color := clBlack;
                  if AppEnv.CompanyInfo.StyleCompanyName <> '' then begin
                    if LeftStr(AppEnv.CompanyInfo.StyleCompanyName, 1) = 'B' then Bold := 1;
                    if MidStr(AppEnv.CompanyInfo.StyleCompanyName, 2, 1) = 'I' then Italic := 1;
                    if MidStr(AppEnv.CompanyInfo.StyleCompanyName, 3, 1) = 'U' then Underline := 1;
                    if MidStr(AppEnv.CompanyInfo.StyleCompanyName, 4, 1) = 'S' then StrikeThrough := 1;
                  end else begin
                    Bold := 1;
                    Italic := 1;
                  end;
                  Selection.TypeText(AppEnv.CompanyInfo.CompanyName);
                end;
              end;

              if (not AppEnv.CompanyInfo.HideAddress) then begin
                Selection.TypeParagraph;
                Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
                with Selection.Font do begin
                  if AppEnv.CompanyInfo.FontAddress <> '' then Name := AppEnv.CompanyInfo.FontAddress
                  else Name := 'Times New Roman';
                  if AppEnv.CompanyInfo.SizeAddress > 0 then Size := AppEnv.CompanyInfo.SizeAddress
                  else Size := 36;
                  if AppEnv.CompanyInfo.ColorAddress <> '' then
                    Color := StringToColor(AppEnv.CompanyInfo.ColorAddress)
                  else Color := clBlack;
                  if AppEnv.CompanyInfo.StyleAddress <> '' then begin
                    if LeftStr(AppEnv.CompanyInfo.StyleAddress, 1) = 'B' then Bold := 1;
                    if MidStr(AppEnv.CompanyInfo.StyleAddress, 2, 1) = 'I' then Italic := 1;
                    if MidStr(AppEnv.CompanyInfo.StyleAddress, 3, 1) = 'U' then Underline := 1;
                    if MidStr(AppEnv.CompanyInfo.StyleAddress, 4, 1) = 'S' then StrikeThrough := 1;
                  end else begin
                    Bold := 1;
                    Italic := 1;
                  end;
                  Selection.TypeText(AppEnv.CompanyInfo.Address);
                end;

                if (not AppEnv.CompanyInfo.HideCity) then begin
                  Selection.TypeParagraph;
                  Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
                  with Selection.Font do begin
                    if AppEnv.CompanyInfo.FontSuburb <> '' then Name := AppEnv.CompanyInfo.FontSuburb
                    else Name := 'Times New Roman';
                    if AppEnv.CompanyInfo.SizeSuburb > 0 then Size := AppEnv.CompanyInfo.SizeSuburb
                    else Size := 36;
                    if AppEnv.CompanyInfo.ColorSuburb <> '' then
                      Color := StringToColor(AppEnv.CompanyInfo.ColorSuburb)
                    else Color := clBlack;
                    if AppEnv.CompanyInfo.StyleSuburb <> '' then begin
                      if LeftStr(AppEnv.CompanyInfo.StyleSuburb, 1) = 'B' then Bold := 1;
                      if MidStr(AppEnv.CompanyInfo.StyleSuburb, 2, 1) = 'I' then Italic := 1;
                      if MidStr(AppEnv.CompanyInfo.StyleSuburb, 3, 1) = 'U' then Underline := 1;
                      if MidStr(AppEnv.CompanyInfo.StyleSuburb, 4, 1) = 'S' then StrikeThrough := 1;
                    end else begin
                      Bold := 1;
                      Italic := 1;
                    end;
                    Selection.TypeText(AppEnv.CompanyInfo.City);
                  end;
                end;

                if (not AppEnv.CompanyInfo.HideCountry) then begin
                  Selection.TypeParagraph;
                  Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
                  with Selection.Font do begin
                    if AppEnv.CompanyInfo.FontSuburb <> '' then Name := AppEnv.CompanyInfo.FontSuburb
                    else Name := 'Times New Roman';
                    if AppEnv.CompanyInfo.SizeSuburb > 0 then Size := AppEnv.CompanyInfo.SizeSuburb
                    else Size := 36;
                    if AppEnv.CompanyInfo.ColorSuburb <> '' then
                      Color := StringToColor(AppEnv.CompanyInfo.ColorSuburb)
                    else Color := clBlack;
                    if AppEnv.CompanyInfo.StyleSuburb <> '' then begin
                      if LeftStr(AppEnv.CompanyInfo.StyleSuburb, 1) = 'B' then Bold := 1;
                      if MidStr(AppEnv.CompanyInfo.StyleSuburb, 2, 1) = 'I' then Italic := 1;
                      if MidStr(AppEnv.CompanyInfo.StyleSuburb, 3, 1) = 'U' then Underline := 1;
                      if MidStr(AppEnv.CompanyInfo.StyleSuburb, 4, 1) = 'S' then StrikeThrough := 1;
                    end else begin
                      Bold := 1;
                      Italic := 1;
                    end;
                    Selection.TypeText(AppEnv.CompanyInfo.Country);
                  end;
                end;

                if (not AppEnv.CompanyInfo.HidePhoneNumber) then begin
                  Selection.TypeParagraph;
                  Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
                  with Selection.Font do begin
                    if AppEnv.CompanyInfo.FontPhone <> '' then Name := AppEnv.CompanyInfo.FontPhone
                    else Name := 'Times New Roman';
                    if AppEnv.CompanyInfo.SizePhone > 0 then Size := AppEnv.CompanyInfo.SizePhone
                    else Size := 36;
                    if AppEnv.CompanyInfo.ColorPhone <> '' then
                      Color := StringToColor(AppEnv.CompanyInfo.ColorPhone)
                    else Color := clBlack;
                    if AppEnv.CompanyInfo.StylePhone <> '' then begin
                      if LeftStr(AppEnv.CompanyInfo.StylePhone, 1) = 'B' then Bold := 1;
                      if MidStr(AppEnv.CompanyInfo.StylePhone, 2, 1) = 'I' then Italic := 1;
                      if MidStr(AppEnv.CompanyInfo.StylePhone, 3, 1) = 'U' then Underline := 1;
                      if MidStr(AppEnv.CompanyInfo.StylePhone, 4, 1) = 'S' then StrikeThrough := 1;
                    end else begin
                      Bold := 1;
                      Italic := 1;
                    end;
                    Selection.TypeText(AppEnv.CompanyInfo.PhoneNumber);
                  end;
                end;

                if (not AppEnv.CompanyInfo.HideABN) then begin
                  Selection.TypeParagraph;
                  Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
                  with Selection.Font do begin
                    if AppEnv.CompanyInfo.FontABN <> '' then Name := AppEnv.CompanyInfo.FontABN
                    else Name := 'Times New Roman';
                    if AppEnv.CompanyInfo.SizeABN > 0 then Size := AppEnv.CompanyInfo.SizeABN
                    else Size := 36;
                    if AppEnv.CompanyInfo.ColorABN <> '' then
                      Color := StringToColor(AppEnv.CompanyInfo.ColorABN)
                    else Color := clBlack;
                    if AppEnv.CompanyInfo.StyleABN <> '' then begin
                      if LeftStr(AppEnv.CompanyInfo.StyleABN, 1) = 'B' then Bold := 1;
                      if MidStr(AppEnv.CompanyInfo.StyleABN, 2, 1) = 'I' then Italic := 1;
                      if MidStr(AppEnv.CompanyInfo.StyleABN, 3, 1) = 'U' then Underline := 1;
                      if MidStr(AppEnv.CompanyInfo.StyleABN, 4, 1) = 'S' then StrikeThrough := 1;
                    end else begin
                      Bold := 1;
                      Italic := 1;
                    end;
                    Selection.TypeText(AppEnv.CompanyInfo.ABN);
                  end;
                end;
              end;

              if (not AppEnv.CompanyInfo.HideCompanyName) and
                (not AppEnv.CompanyInfo.HideABN) and
                (not AppEnv.CompanyInfo.HidePhoneNumber) and
                (not AppEnv.CompanyInfo.HideCountry) and
                (not AppEnv.CompanyInfo.HideCity) and
                (not AppEnv.CompanyInfo.HideAddress) then begin
                Selection.TypeParagraph;
                Selection.TypeParagraph;
              end;

              with Selection.Font do begin
                Name := 'Arial';
                Size := 24;
                Color := clBlack;
                Bold := 1;
              end;
//              ADOQuery1.ParamByName('CID').AsInteger := CID;
//              ADOQuery1.Open;
//              if Ref_Type.Text = 'Email' then begin
//                Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
//                with Selection.Font do begin
//                  Name := 'Arial';
//                  Size := 24;
//                  Color := clBlack;
//                  Bold := 1;
//                  Italic := 0;
//                end;
//                Selection.TypeText('EMAIL');
//                Selection.TypeParagraph;
//                Selection.TypeParagraph;
//              end;
              if CorrespondenceType = ctFax then begin
                Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
                with Selection.Font do begin
                  Name := 'Arial';
                  Size := 24;
                  Color := clBlack;
                  Bold := 1;
                  Italic := 0;
                end;
                if (not AppEnv.CompanyInfo.HideFaxNumber) then Selection.TypeText('FAX');
                Selection.TypeParagraph;
                Selection.TypeParagraph;
                Selection.ParagraphFormat.Alignment := wdAlignParagraphLeft;
                with Selection.Font do begin
                  if AppEnv.CompanyInfo.FontDefault <> '' then Name := AppEnv.CompanyInfo.FontDefault
                  else Name := 'Arial';
                  if AppEnv.CompanyInfo.SizeDefault > 0 then Size := AppEnv.CompanyInfo.SizeDefault
                  else Size := 12;
                  if AppEnv.CompanyInfo.ColorDefault <> '' then
                    Color := StringToColor(AppEnv.CompanyInfo.ColorDefault)
                  else Color := clBlack;
                  if AppEnv.CompanyInfo.StyleDefault <> '' then begin
                    if LeftStr(AppEnv.CompanyInfo.StyleDefault, 1) = 'B' then Bold := 1;
                    if MidStr(AppEnv.CompanyInfo.StyleDefault, 2, 1) = 'I' then Italic := 1;
                    if MidStr(AppEnv.CompanyInfo.StyleDefault, 3, 1) = 'U' then Underline := 1;
                    if MidStr(AppEnv.CompanyInfo.StyleDefault, 4, 1) = 'S' then StrikeThrough := 1;
                  end else begin
                    Bold := 0;
                    Italic := 0;
                  end;
                end;
                Selection.Font.Bold := 1;
                txtLine := 'To: ';
                Selection.TypeText(txtLine);
                txtLine := '';
                if LeftStr(AppEnv.CompanyInfo.StyleDefault, 1) = 'B' then Selection.Font.Bold := 1
                else Selection.Font.Bold := 0;
                Selection.ParagraphFormat.Alignment := wdAlignParagraphLeft;


                (*if (Owner is TfmMarketingLead) then begin
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.Title <> '' then
                    txtLine := TfmMarketingLead(Owner).Lead.MarketingContacts.Title + ' ';
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.FirstName <> '' then
                    txtLine := txtLine + TfmMarketingLead(Owner).Lead.MarketingContacts.FirstName + ' ';
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.LastName <> '' then
                    txtLine := txtLine + TfmMarketingLead(Owner).Lead.MarketingContacts.LastName;
                  Selection.TypeText(txtLine);
                  Selection.Font.Bold := 1;
                  txtLine := '                                        Fax No: ';
                  Selection.TypeText(txtLine);
                  if LeftStr(AppEnv.CompanyInfo.StyleDefault, 1) = 'B' then Selection.Font.Bold := 1
                  else Selection.Font.Bold := 0;
                  txtLine := TfmMarketingLead(Owner).Lead.MarketingContacts.FaxNumber;
                end;*)
                SetReferenceName(txtLine);
                Selection.TypeText(txtLine);
                Selection.Font.Bold := 1;
                Setreferencetype(txtLine);
                Selection.TypeText(txtLine);
                if LeftStr(AppEnv.CompanyInfo.StyleDefault, 1) = 'B' then Selection.Font.Bold := 1
                else Selection.Font.Bold := 0;
                SetReferenceTypeID(txtLine);

                Selection.TypeText(txtLine);
                Selection.TypeParagraph;
                Selection.TypeParagraph;
                Selection.Font.Bold := 1;
                txtLine := 'From: ';
                Selection.TypeText(txtLine);
                if LeftStr(AppEnv.CompanyInfo.StyleDefault, 1) = 'B' then Selection.Font.Bold := 1
                else Selection.Font.Bold := 0;
                txtLine := '';
                if AppEnv.Employee.FirstName <> '' then txtLine := txtLine + AppEnv.Employee.FirstName + Chr(32);
                if AppEnv.Employee.LastName <> '' then txtLine := txtLine + AppEnv.Employee.LastName;
                Selection.TypeText(txtLine);
                Selection.TypeParagraph;
                Selection.TypeParagraph;
                Selection.Font.Bold := 1;
                txtLine := 'Date: ';
                Selection.TypeText(txtLine);
                if LeftStr(AppEnv.CompanyInfo.StyleDefault, 1) = 'B' then Selection.Font.Bold := 1
                else Selection.Font.Bold := 0;
                txtLine := FormatDateTime('dddd, dd mmmm yyyy',now);
                Selection.TypeText(txtLine);
                Selection.TypeParagraph;
                Selection.TypeParagraph;
                Selection.Font.Bold := 1;
                txtLine := 'No. Pages: ';
                Selection.TypeText(txtLine);
                if LeftStr(AppEnv.CompanyInfo.StyleDefault, 1) = 'B' then Selection.Font.Bold := 1
                else Selection.Font.Bold := 0;
                Selection.TypeParagraph;
                Selection.TypeParagraph;
                Selection.Font.Bold := 1;
                txtLine := 'Re: ';
                Selection.TypeText(txtLine);
                if LeftStr(AppEnv.CompanyInfo.StyleDefault, 1) = 'B' then Selection.Font.Bold := 1
                else Selection.Font.Bold := 0;
              end else begin
                { not a Fax  - letter}
                Selection.ParagraphFormat.Alignment := wdAlignParagraphRight;
                with Selection.Font do begin
                  Bold := 0;
                  Italic := 0;
                  if AppEnv.CompanyInfo.FontDefault <> '' then Name := AppEnv.CompanyInfo.FontDefault
                  else Name := 'Arial';
                  if AppEnv.CompanyInfo.SizeDefault > 0 then Size := AppEnv.CompanyInfo.SizeDefault
                  else Size := 12;
                  if AppEnv.CompanyInfo.ColorDefault <> '' then
                    Color := StringToColor(AppEnv.CompanyInfo.ColorDefault)
                  else Color := clBlack;
                  if AppEnv.CompanyInfo.StyleDefault <> '' then begin
                    if LeftStr(AppEnv.CompanyInfo.StyleDefault, 1) = 'B' then Bold := 1;
                    if MidStr(AppEnv.CompanyInfo.StyleDefault, 2, 1) = 'I' then Italic := 1;
                    if MidStr(AppEnv.CompanyInfo.StyleDefault, 3, 1) = 'U' then Underline := 1;
                    if MidStr(AppEnv.CompanyInfo.StyleDefault, 4, 1) = 'S' then StrikeThrough := 1;
                  end;
                  Selection.TypeText(DateToStr(Now));
                end;
                Selection.TypeParagraph;
                Selection.TypeParagraph;
                txtLine := '';
                Selection.ParagraphFormat.Alignment := wdAlignParagraphLeft;
                (*if (Owner is TfmMarketingLead) then begin
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.Title <> '' then
                    txtLine := TfmMarketingLead(Owner).Lead.MarketingContacts.Title + ' ';
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.FirstName <> '' then
                    txtLine := txtLine + TfmMarketingLead(Owner).Lead.MarketingContacts.FirstName + ' ';
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.LastName <> '' then
                    txtLine := txtLine + TfmMarketingLead(Owner).Lead.MarketingContacts.LastName;
                  Selection.TypeText(txtLine);
                  {Contact Address}
                  txtLine := '';
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.Street <> '' then
                    txtLine := TfmMarketingLead(Owner).Lead.MarketingContacts.Street + ' ';
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.Street2 <> '' then
                    txtLine := txtLine + TfmMarketingLead(Owner).Lead.MarketingContacts.Street2 + ' ';
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.Street3 <> '' then
                    txtLine := txtLine + TfmMarketingLead(Owner).Lead.MarketingContacts.Street3;
                  Selection.TypeParagraph;
                  Selection.TypeText(txtLine);
                  {Contact Suburb/State/Postcode}
                  txtLine := '';
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.Suburb <> '' then
                    txtLine := TfmMarketingLead(Owner).Lead.MarketingContacts.Suburb + ' ';
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.State <> '' then
                    txtLine := txtLine + TfmMarketingLead(Owner).Lead.MarketingContacts.State + ' ';
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.Postcode <> '' then
                    txtLine := txtLine + TfmMarketingLead(Owner).Lead.MarketingContacts.Postcode;
                  Selection.TypeParagraph;
                  Selection.TypeText(txtLine);
                  {Two returns}
                  Selection.TypeParagraph;
                  Selection.TypeParagraph;
                  {Salutation}
                  txtLine := '';
                  if TfmMarketingLead(Owner).Lead.MarketingContacts.FirstName <> '' then
                    txtLine := 'Dear ' + TfmMarketingLead(Owner).Lead.MarketingContacts.FirstName;
                end;*)


                SetReferenceName(txtLine);
                Selection.TypeText(txtLine);
                {Contact Address}
                txtLine := '';
                SetReferenceAddressPart1(txtLine);
                Selection.TypeParagraph;
                Selection.TypeText(txtLine);
                {Contact Suburb/State/Postcode}
                txtLine := '';
                SetReferenceAddressPart2(txtLine);
                Selection.TypeParagraph;
                Selection.TypeText(txtLine);
                {Two returns}
                Selection.TypeParagraph;
                Selection.TypeParagraph;
                {Salutation}
                txtLine := '';
                SetReferenceSalutation(txtLine);
                Selection.TypeParagraph;
                Selection.TypeText(txtLine);
                {One returns}
                Selection.TypeParagraph;
              end;
            end;
            try
              try
              WordDocument1.SaveAs(FileName);
              WordApplication1.Activate;
              finally
                WordApplication1.Disconnect;
                WordApplication1.DDETerminateAll;
              end;
            except
            end;
          Except
            on E: Exception do begin
              CommonLib.MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
            end
          End;
        end else begin
          { we are not using Word }
          Form := GetComponentByClassName('TREMainClient');
          if Assigned(Form) then begin
            with TREMainClient(Form) do begin
              (*if (self.Owner is TfmMarketingLead) then
                TREMainClient(Form).MarketingContactId := TfmMarketingLead(self.Owner).Lead.MarketingContactID;*)
                if Referencetype =  rtMarketingcontact then begin
                  TREMainClient(Form).MarketingContactId := ReferenceId;
                end else if Referencetype =  rtEmployee then begin
                  TREMainClient(Form).EmployeeID :=ReferenceId;
                end else if Referencetype =  rtSupplier then begin
                  TREMainClient(Form).SupplierID :=ReferenceId;
                end else if Referencetype =  rtCustomer then begin
                  TREMainClient(Form).customerID :=ReferenceId;
                end else if Referencetype =  rtcustomercontact then begin
                  TREMainClient(Form).customerID :=ReferenceId;
                  TREMainClient(Form).CID :=ReferencecontactId;
                end else if Referencetype =  rtOthercontactcontact then begin
                  TREMainClient(Form).OthercontactID :=ReferenceId;
                  TREMainClient(Form).CID :=ReferencecontactId;
                end else if ReferenceType = rtRepair then begin
                  TREMainClient(Form).RepairID :=ReferenceId;
                end else if Referencetype =  rtSupplierContact then begin
                  TREMainClient(Form).SupplierID :=ReferenceId;
                  TREMainClient(Form).CID:=ReferencecontactId;
                end;


              //TREMainClient(Form).CID := Self.CID;
              Fax.Text := '';
              if CorrespondenceType = ctFax then begin
                TREMainClient(Form).Caption := 'Fax';
                (*if (self.Owner is TfmMarketingLead) then Fax.Text := TfmMarketingLead(self.Owner).Lead.MarketingContacts.FaxNumber;*)
                txtLine:= '';
                SetReferenceTypeID(txtLine);
                Fax.Text :=txtLine;
              end else if CorrespondenceType = ctLetter then
                TREMainClient(Form).Caption := 'Letter';
              TREMainClient(Form).Referencetxt.Text := Correspondence.ReferenceTxt;
              TREMainClient(Form).content := qryReferenceLookup.FieldByName('CorrespondenceText').AsString;
              FormStyle := fsMDIChild;
              BringToFront;
            end;
          end;
        end;

        {---------------------------------------------------}
      end;
    finally
//      if CorrespondenceType = tcTypes.ctEmail then begin
//        if OwnerConnection = MyConnection then
//          self.CommitTransaction
//        else
//          Correspondence.Connection.CommitNestedTransaction;
//      end
//      else begin
//        if not Correspondence.Save then begin
//          if OwnerConnection = MyConnection then
//            self.RollbackTransaction
//          else
//            Correspondence.Connection.RollbackNestedTransaction;
//        end
//        else begin
//          if OwnerConnection = MyConnection then
//            self.CommitTransaction
//          else
//            Correspondence.Connection.CommitNestedTransaction;
//        end;
//      end;

      if Correspondence.Save then begin
        if OwnerConnection = MyConnection then
          self.CommitTransaction
        else
          Correspondence.Connection.CommitNestedTransaction;
      end
      else begin
        if OwnerConnection = MyConnection then
          self.RollbackTransaction
        else
          Correspondence.Connection.RollbackNestedTransaction;
      end;

    end;
  finally
    qry.Free;
    Correspondence.Free;
  end;

  self.Notify(false);
  self.Notify;
  Close;
end;

procedure TfmCorrespondanceBase.cboCorrespondencetypeNotInList(Sender: TObject;  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
var
  form: TfmCorrespondenceReference;
begin
  inherited;
  Accept:= false;
  form:= nil;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    try
      if CorrespondenceType = tcTypes.ctEmail then
        form := TfmEmailCorrespondenceReference.Create(nil)
      else if CorrespondenceType = ctLetter then
        form := TfmLetterCorrespondenceReference.Create(nil)
      else
        exit;

      form.KeyID := 0;
      form.NewReference := NewValue;
      if form.ShowModal = mrOk then begin
        Accept:= true;
        LookupTable.Refresh;
        LookupTable.Locate('Reference',form.qryMainReference.AsString,[loCaseInsensitive]);
        TwwDbLookupCombo(Sender).Text := form.qryMainReference.AsString;
      end;
    finally
      form.Free;
    end;
  end;
end;

procedure TfmCorrespondanceBase.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmCorrespondanceBase.FormCreate(Sender: TObject);
begin
  inherited;
  fsTransData2 :='';
  fsTransData1 :='';
  fOwnerConnection := nil;
  AttachmentList := TStringList.Create;
end;

procedure TfmCorrespondanceBase.FormDestroy(Sender: TObject);
begin
  inherited;
  AttachmentList.Free;
end;

function TfmCorrespondanceBase.GetOwnerConnection: TERPConnection;
begin
  result := fOwnerConnection;
  if result  = nil then
//    if Assigned(Owner) and (Owner is TBaseInputGUI) then
//      result := TBaseInputGUI(Owner).MyConnection;
   result := self.MyConnection;
end;

procedure TfmCorrespondanceBase.SetCorrespondenceType(const Value: tcTYpes.TCorrespondenceType);
begin
  fCorrespondenceType := Value;
  CloseDb(qryReferenceLookup);
  qryReferenceLookup.SQL.Text := 'select * from tblCorrespondenceReference where TypeCode = ' +
    QuotedStr(CorrespondenceTypeToStr(Value)) + ' order by Reference';
  OpenDb(qryReferenceLookup);
end;
procedure TfmCorrespondanceBase.SetEmailId(const Value: String);
begin
  fsEmailId := Value;
end;

procedure TfmCorrespondanceBase.Setreferencetype(var Value: String);
begin
  if CorrespondenceType = ctFax then
        Value := '                                        Fax No: '
  else if CorrespondenceType = tcTypes.ctEmail then
        Value := '                                        Email ID: ';
end;

procedure TfmCorrespondanceBase.SetReftype(const Value: TReferencetype);
begin
  fReferencetype := Value;
  Self.Caption := 'Document Reference ' +RefTypetoString(Value);
end;

end.

