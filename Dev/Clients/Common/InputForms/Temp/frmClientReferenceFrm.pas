unit frmClientReferenceFrm;

interface

uses
  Windows, Forms, jpeg, SysUtils, ExtCtrls, DB,  StdCtrls, Buttons, DNMSpeedButton,
  DBCtrls, Controls, Mask, Classes, BaseInputForm, Word2000, OleServer,
  Graphics, strUtils, Variants, MemDS, DBAccess, MyAccess,ERPdbComponents, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts, Shader, DNMPanel, ImgList, WordXP,
  ProgressDialog, BusObjCorrespondence, BusObjBase;

type
  TfrmClientReference = class(TBaseInputGUI)
    Label11: TLabel;
    Referencetxt: TDBEdit;
    Command16: TDNMSpeedButton;
    CancelBtn: TDNMSpeedButton;
    qryContacts: TERPQuery;
    WordApplication1: TWordApplication;
    dsCorrespondence: TDataSource;
    qryEmployeePref: TERPQuery;
    tblDocPath: TMyTable;
    WordDocument1: TWordDocument;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryCorrespondence: TERPQuery;
    qryCompanyInfo: TERPQuery;
    procedure Command16Click(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    Correspondence: TCorrespondence;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
  public
    { Public declarations }
    CID: integer;
    
  end;

//var
//  frmClientReference: TfrmClientReference;

implementation

uses FastFuncs,frmCustomerFrm, Dialogs, ShellAPI,  remainClientFrm,
  frmSupplierFrm, DNMExceptions, CommonDbLib, frmJob, SystemLib, CommonLib,
  AppEnvironment, ComObj,Preferences, PreferenceLib, EmailUtils;

{$R *.DFM}


procedure TfrmClientReference.Command16Click(Sender: TObject);
var
  txtLine: string;
  FileNameTemplate: OleVariant;
  FileName: OleVariant;
  wOleF: OleVariant;
  wOleT: OleVariant;
  wDoc: _Document;
  Form : TComponent;
  Option:Word;
  qry:TERPQuery;
  MailSender: T2cEmailSender;
begin
  if Referencetxt.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('You must enter a Reference', mtCustom, [mbOK], 0);
    SetControlFocus(Referencetxt);
    Exit;
  end else if not IsValidFileName(ReferenceTxt.Text) then begin
    CommonLib.MessageDlgXP_Vista('Reference you entered is invalid. It cannot contain characters like \ / : * ? " < > |.',
      mtInformation, [mbOK], 0);
    SetControlFocus(Referencetxt);
    Exit;
  end;

  if tblDocPath.FieldByName('DocumentPath').AsString <> '' then
    FileName    := tblDocPath.FieldByName('DocumentPath').AsString + '\' + Referencetxt.Text
  else FileName := 'C:\' + Referencetxt.Text;

  if FileExists(FileName) then begin
    CommonLib.MessageDlgXP_Vista('That Reference is already in use, please enter another Reference', mtCustom, [mbOK], 0);
    SetControlFocus(Referencetxt);
    Exit;
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
        (* Form := GetComponentByClassName('TPreferencesGUI');
        try
          if (Assigned(Form)) and (TPreferencesGUI(Form).AccessLevel<= 1) then begin //if has acess
              with TPreferencesGUI(Form) do begin
                SingleButtonCaption := 'Utilities';
                FocusControlName    := 'chkUseWord';
                FormStyle           := fsNormal;
                Position            := poScreenCenter;
                ShowModal;
              end;
          end else MessageDlgXP_Vista('You don''t have enough permission to change the Preferences.',mtWarning, [mbok], 0)
        finally
            FreeandNil(Form);
        end; *)
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
        Try
          if AppEnv.CompanyInfo.Usedocumenttemplate and
              FileExists(AppEnv.CompanyInfo.Documenttemplatepath) then begin
            FileNameTemplate := AppEnv.CompanyInfo.Usedocumenttemplate;
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

        if not AppEnv.CompanyInfo.Hidecompanyname then begin
          Selection.TypeParagraph;
          Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
          with Selection.Font do begin
            if AppEnv.CompanyInfo.Fontcompanyname <> '' then
              Name := AppEnv.CompanyInfo.Fontcompanyname
            else Name := 'Times New Roman';
            if AppEnv.CompanyInfo.Sizecompanyname <> 0 then
              Size := AppEnv.CompanyInfo.Sizecompanyname
            else Size := 36;
            if AppEnv.CompanyInfo.Colorcompanyname <> '' then
              Color := StringToColor(AppEnv.CompanyInfo.Colorcompanyname)
            else Color := clBlack;
            if AppEnv.CompanyInfo.Stylecompanyname <> '' then begin
              if FastFuncs.LeftStr(AppEnv.CompanyInfo.Stylecompanyname, 1) = 'B' then Bold := 1;
              if MidStr(AppEnv.CompanyInfo.Stylecompanyname, 2, 1) = 'I' then Italic := 1;
              if MidStr(AppEnv.CompanyInfo.Stylecompanyname, 3, 1) = 'U' then Underline := 1;
              if MidStr(AppEnv.CompanyInfo.Stylecompanyname, 4, 1) = 'S' then StrikeThrough := 1;
            end else begin
              Bold := 1;
              Italic := 1;
            end;
            Selection.TypeText(AppEnv.CompanyInfo.Companyname);
          end;
        end;

        if not AppEnv.CompanyInfo.Hideaddress then begin
          Selection.TypeParagraph;
          Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
          with Selection.Font do begin
            if AppEnv.CompanyInfo.Fontaddress <> '' then Name := AppEnv.CompanyInfo.Fontaddress
            else Name := 'Times New Roman';
            if AppEnv.CompanyInfo.Sizeaddress <> 0 then Size := AppEnv.CompanyInfo.Sizeaddress
            else Size := 36;
            if AppEnv.CompanyInfo.Coloraddress <> '' then
              Color := StringToColor(AppEnv.CompanyInfo.Coloraddress)
            else Color := clBlack;
            if AppEnv.CompanyInfo.Styleaddress <> '' then begin
              if FastFuncs.LeftStr(AppEnv.CompanyInfo.Styleaddress, 1) = 'B' then Bold := 1;
              if MidStr(AppEnv.CompanyInfo.Styleaddress, 2, 1) = 'I' then Italic := 1;
              if MidStr(AppEnv.CompanyInfo.Styleaddress, 3, 1) = 'U' then Underline := 1;
              if MidStr(AppEnv.CompanyInfo.Styleaddress, 4, 1) = 'S' then StrikeThrough := 1;
            end else begin
              Bold := 1;
              Italic := 1;
            end;
            Selection.TypeText(AppEnv.CompanyInfo.Address);
          end;

          if not AppEnv.CompanyInfo.Hidecity then begin
            Selection.TypeParagraph;
            Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
            with Selection.Font do begin
              if AppEnv.CompanyInfo.Fontsuburb <> '' then Name := AppEnv.CompanyInfo.FontSuburb
              else Name := 'Times New Roman';
              if AppEnv.CompanyInfo.SizeSuburb <> 0 then Size := AppEnv.CompanyInfo.SizeSuburb
              else Size := 36;
              if AppEnv.CompanyInfo.ColorSuburb <> '' then
                Color := StringToColor(AppEnv.CompanyInfo.ColorSuburb)
              else Color := clBlack;
              if AppEnv.CompanyInfo.StyleSuburb <> '' then begin
                if FastFuncs.LeftStr(AppEnv.CompanyInfo.StyleSuburb, 1) = 'B' then Bold := 1;
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

          if not AppEnv.CompanyInfo.Hidecountry then begin
            Selection.TypeParagraph;
            Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
            with Selection.Font do begin
              if AppEnv.CompanyInfo.Fontsuburb <> '' then Name := AppEnv.CompanyInfo.FontSuburb
              else Name := 'Times New Roman';
              if AppEnv.CompanyInfo.SizeSuburb <> 0 then Size := AppEnv.CompanyInfo.SizeSuburb
              else Size := 36;
              if AppEnv.CompanyInfo.ColorSuburb <> '' then
                Color := StringToColor(AppEnv.CompanyInfo.ColorSuburb)
              else Color := clBlack;
              if AppEnv.CompanyInfo.StyleSuburb <> '' then begin
                if FastFuncs.LeftStr(AppEnv.CompanyInfo.StyleSuburb, 1) = 'B' then Bold := 1;
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

          if not AppEnv.CompanyInfo.Hidephonenumber then begin
            Selection.TypeParagraph;
            Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
            with Selection.Font do begin
              if AppEnv.CompanyInfo.FontPhone <> '' then Name := AppEnv.CompanyInfo.FontPhone
              else Name := 'Times New Roman';
              if AppEnv.CompanyInfo.SizePhone <> 0 then Size := AppEnv.CompanyInfo.SizePhone
              else Size := 36;
              if AppEnv.CompanyInfo.ColorPhone <> '' then
                Color := StringToColor(AppEnv.CompanyInfo.ColorPhone)
              else Color := clBlack;
              if AppEnv.CompanyInfo.StylePhone <> '' then begin
                if FastFuncs.LeftStr(AppEnv.CompanyInfo.StylePhone, 1) = 'B' then Bold := 1;
                if MidStr(AppEnv.CompanyInfo.StylePhone, 2, 1) = 'I' then Italic := 1;
                if MidStr(AppEnv.CompanyInfo.StylePhone, 3, 1) = 'U' then Underline := 1;
                if MidStr(AppEnv.CompanyInfo.StylePhone, 4, 1) = 'S' then StrikeThrough := 1;
              end else begin
                Bold := 1;
                Italic := 1;
              end;
              Selection.TypeText(AppEnv.CompanyInfo.Phonenumber);
            end;
          end;

          if not AppEnv.CompanyInfo.Hideabn then Selection.TypeParagraph;
          Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
          with Selection.Font do begin
            if AppEnv.CompanyInfo.FontABN <> '' then Name := AppEnv.CompanyInfo.FontABN
            else Name := 'Times New Roman';
            if AppEnv.CompanyInfo.SizeABN <> 0 then Size := AppEnv.CompanyInfo.SizeABN
            else Size := 36;
            if AppEnv.CompanyInfo.ColorABN <> '' then
              Color := StringToColor(AppEnv.CompanyInfo.ColorABN)
            else Color := clBlack;
            if AppEnv.CompanyInfo.StyleABN <> '' then begin
              if FastFuncs.LeftStr(AppEnv.CompanyInfo.StyleABN, 1) = 'B' then Bold := 1;
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

        if (not AppEnv.CompanyInfo.Hidecompanyname) and
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
        qryContacts.Close;
        qryContacts.ParamByName('CID').AsInteger := CID;
        qryContacts.Open;
        if Correspondence.Ref_Type = 'Email' then begin
          Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
          with Selection.Font do begin
            Name := 'Arial';
            Size := 24;
            Color := clBlack;
            Bold := 1;
            Italic := 0;
          end;
          Selection.TypeText('EMAIL');
          Selection.TypeParagraph;
          Selection.TypeParagraph;
        end;
        if Correspondence.Ref_Type = 'Fax' then begin
          Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
          with Selection.Font do begin
            Name := 'Arial';
            Size := 24;
            Color := clBlack;
            Bold := 1;
            Italic := 0;
          end;
          if not AppEnv.CompanyInfo.Hidefaxnumber then Selection.TypeText('FAX');
          Selection.TypeParagraph;
          Selection.TypeParagraph;
          Selection.ParagraphFormat.Alignment := wdAlignParagraphLeft;
          with Selection.Font do begin
            if AppEnv.CompanyInfo.FontDefault <> '' then Name := AppEnv.CompanyInfo.FontDefault
            else Name := 'Arial';
            if AppEnv.CompanyInfo.SizeDefault <> 0 then Size := AppEnv.CompanyInfo.SizeDefault
            else Size := 12;
            if AppEnv.CompanyInfo.ColorDefault <> '' then
              Color := StringToColor(AppEnv.CompanyInfo.ColorDefault)
            else Color := clBlack;
            if AppEnv.CompanyInfo.StyleDefault <> '' then begin
              if FastFuncs.LeftStr(AppEnv.CompanyInfo.StyleDefault, 1) = 'B' then Bold := 1;
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
          if FastFuncs.LeftStr(AppEnv.CompanyInfo.StyleDefault, 1) = 'B' then Selection.Font.Bold := 1
          else Selection.Font.Bold := 0;
          Selection.ParagraphFormat.Alignment := wdAlignParagraphLeft;
          if qryContacts.FieldByName('ContactTitle').AsString <> '' then
            txtLine := qryContacts.FieldByName('ContactTitle').AsString + ' ';
          if qryContacts.FieldByName('ContactFirstName').AsString <> '' then
            txtLine := txtLine + qryContacts.FieldByName('ContactFirstName').AsString + ' ';
          if qryContacts.FieldByName('ContactSurName').AsString <> '' then
            txtLine := txtLine + qryContacts.FieldByName('ContactSurName').AsString;
          Selection.TypeText(txtLine);
          Selection.Font.Bold := 1;
          txtLine := '                                        Fax No: ';
          Selection.TypeText(txtLine);
          if FastFuncs.LeftStr(AppEnv.CompanyInfo.StyleDefault, 1) = 'B' then Selection.Font.Bold := 1
          else Selection.Font.Bold := 0;
          txtLine := qryContacts.FieldByName('ContactFax').AsString;
          Selection.TypeText(txtLine);
          Selection.TypeParagraph;
          Selection.TypeParagraph;
          Selection.Font.Bold := 1;
          txtLine := 'From: ';
          Selection.TypeText(txtLine);
          if FastFuncs.LeftStr(AppEnv.CompanyInfo.StyleDefault, 1) = 'B' then Selection.Font.Bold := 1
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
          if FastFuncs.LeftStr(AppEnv.CompanyInfo.StyleDefault, 1) = 'B' then Selection.Font.Bold := 1
          else Selection.Font.Bold := 0;
          if qryCompanyInfo.FieldByName('FaxDate').AsString <> '' then
            txtLine := qryCompanyInfo.FieldByName('FaxDate').AsString;
          Selection.TypeText(txtLine);
          Selection.TypeParagraph;
          Selection.TypeParagraph;
          Selection.Font.Bold := 1;
          txtLine := 'No. Pages: ';
          Selection.TypeText(txtLine);
          if FastFuncs.LeftStr(AppEnv.CompanyInfo.StyleDefault, 1) = 'B' then Selection.Font.Bold := 1
          else Selection.Font.Bold := 0;
          Selection.TypeParagraph;
          Selection.TypeParagraph;
          Selection.Font.Bold := 1;
          txtLine := 'Re: ';
          Selection.TypeText(txtLine);
          if FastFuncs.LeftStr(AppEnv.CompanyInfo.StyleDefault, 1) = 'B' then Selection.Font.Bold := 1
          else Selection.Font.Bold := 0;
        end else begin
          Selection.ParagraphFormat.Alignment := wdAlignParagraphRight;
          with Selection.Font do begin
            Bold := 0;
            Italic := 0;
            if AppEnv.CompanyInfo.FontDefault <> '' then Name := AppEnv.CompanyInfo.FontDefault
            else Name := 'Arial';
            if AppEnv.CompanyInfo.SizeDefault <> 0 then Size := AppEnv.CompanyInfo.SizeDefault
            else Size := 12;
            if AppEnv.CompanyInfo.ColorDefault <> '' then
              Color := StringToColor(AppEnv.CompanyInfo.ColorDefault)
            else Color := clBlack;
            if AppEnv.CompanyInfo.StyleDefault <> '' then begin
              if FastFuncs.LeftStr(AppEnv.CompanyInfo.StyleDefault, 1) = 'B' then Bold := 1;
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
          if qryContacts.FieldByName('ContactTitle').AsString <> '' then
            txtLine := qryContacts.FieldByName('ContactTitle').AsString + ' ';
          if qryContacts.FieldByName('ContactFirstName').AsString <> '' then
            txtLine := txtLine + qryContacts.FieldByName('ContactFirstName').AsString + ' ';
          if qryContacts.FieldByName('ContactSurName').AsString <> '' then
            txtLine := txtLine + qryContacts.FieldByName('ContactSurName').AsString;
          Selection.TypeText(txtLine);
          {Contact Address}
          txtLine := '';
          if qryContacts.FieldByName('ContactAddress').AsString <> '' then
            txtLine := qryContacts.FieldByName('ContactAddress').AsString + ' ';
          if qryContacts.FieldByName('ContactAddress2').AsString <> '' then
            txtLine := txtLine + qryContacts.FieldByName('ContactAddress2').AsString;
          Selection.TypeParagraph;
          Selection.TypeText(txtLine);
          {Contact Suburb/State/Postcode}
          txtLine := '';
          if qryContacts.FieldByName('ContactCity').AsString <> '' then
            txtLine := qryContacts.FieldByName('ContactCity').AsString + ' ';
          if qryContacts.FieldByName('ContactState').AsString <> '' then
            txtLine := txtLine + qryContacts.FieldByName('ContactState').AsString + ' ';
          if qryContacts.FieldByName('ContactPcode').AsString <> '' then
            txtLine := txtLine + qryContacts.FieldByName('ContactPcode').AsString;
          Selection.TypeParagraph;
          Selection.TypeText(txtLine);
          {Two returns}
          Selection.TypeParagraph;
          Selection.TypeParagraph;
          {Salutation}
          txtLine := '';
          if qryContacts.FieldByName('ContactFirstName').AsString <> '' then
            txtLine := 'Dear ' + qryContacts.FieldByName('ContactFirstName').AsString;
          Selection.TypeParagraph;
          Selection.TypeText(txtLine);
          {Close Contact Table}
          qryContacts.Close;
          {One returns}
          Selection.TypeParagraph;
        end;
      end;
      try
        WordDocument1.SaveAs(FileName);
        WordApplication1.Activate;
        WordApplication1.Disconnect;
        WordApplication1.DDETerminateAll;
      except
      end;
    Except
      on E: Exception do begin
        CommonLib.MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
      end
    End;
  end else begin
    if Correspondence.Ref_Type <> 'Email' then begin
      Form := GetComponentByClassName('TREMainClient');
      if Assigned(Form) then begin
        with TREMainClient(Form) do begin
          TREMainClient(Form).CID := Self.CID;
          TREMainClient(Form).Caption := Correspondence.Ref_Type;
          TREMainClient(Form).Referencetxt.Text := Self.Referencetxt.Text;
          if Correspondence.Ref_Type = 'Fax' then begin
            Fax.Text := FaxNo.Text;
          end else begin
            Fax.Text := '';
          end;
          FormStyle := fsMDIChild;
          BringToFront;
        end;
      end;
    end else begin
      if Correspondence.Ref_Type = 'Email' then begin
        MailSender:= T2cEmailSender.Create;
        try
          MailSender.Recipients := EmailNo.Text;
          MailSender.Subject := Referencetxt.Text;
          MailSender.Send(false);

        finally
          MailSender.Free;
        end;
      end;
//      if Ref_Type.Text = 'Email' then ShellExecute(Handle, 'open', PChar('mailto:' + EmailNo.Text), '', '', SW_SHOW);
    end;
  end;
  ADOTable1.FieldByName('EmployeeID').AsInteger := AppEnv.Employee.EmployeeID;
  ADOTable1.FieldByName('ContactID').AsInteger := CID;
  ADOTable1.Post;
  if SupID.Text = '' then begin
    if FormStillOpen('TfrmCustomer') then begin
      with TfrmCustomer(FindExistingComponent('TfrmCustomer')) do begin
        qryDocuments.Close;
        qryDocuments.Open;
      end;
    end;
    if FormStillOpen('TJobGUI') then begin
      with TJobGUI(FindExistingComponent('TJobGUI')) do begin
        qryDocuments.Close;
        qryDocuments.Open;
      end;
    end;
  end;
  if SupID.Text <> '' then begin
      if FormStillOpen('TfrmSupplier') then begin
        with TfrmSupplier(FindExistingComponent('TfrmSupplier')) do begin
            qryDocuments.Close;
            qryDocuments.Open;
        end;
      end;
  end;

  Self.Close;
end;

procedure TfrmClientReference.DoBusinessObjectEvent(
  const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TCorrespondence then TCorrespondence(Sender).DataSet:= qryCorrespondence;
  end;
end;

procedure TfrmClientReference.CancelBtnClick(Sender: TObject);
begin
  Close;
end;


procedure TfrmClientReference.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      ADOTable1.Open;
      ADOTable2.Open;
      tblDocPath.Open;
      qryCompanyInfo.Open;
      if KeyID <> 0 then ADOTable1.Edit
      else ADOTable1.Insert;
      SetControlFocus(Referencetxt);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmClientReference.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ADOTable1.Close;
  ADOTable2.Close;
  tblDocPath.Close;
  ADOQuery1.Close;
  ADOQuery2.Close;
  qryCompanyInfo.Close;
  inherited;  
  Action := caFree;
end;

procedure TfrmClientReference.FormCreate(Sender: TObject);
begin
  inherited;
  Correspondence := TCorrespondence.Create(self);
  Correspondence.Connection := TMyDacDataConnection.Create(Correspondence);
  Correspondence.Connection.Connection := MyConnection;
  Correspondence.BusObjEvent := DoBusinessObjectEvent;


//  ADOTable1.Connection := CommonDbLib.GetSharedMyDacConnection;
//  ADOTable2.Connection := CommonDbLib.GetSharedMyDacConnection;
//  tblDocPath.Connection := CommonDbLib.GetSharedMyDacConnection;
//  ADOQuery1.Connection := CommonDbLib.GetSharedMyDacConnection;
//  ADOQuery2.Connection := CommonDbLib.GetSharedMyDacConnection;
//  qryCompanyInfo.Connection := CommonDbLib.GetSharedMyDacConnection;
end;

initialization
  RegisterClassOnce(TfrmClientReference);

end.
