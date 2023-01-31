unit frmClientReferenceFrm;

interface

uses
  Windows, Forms, jpeg, SysUtils, ExtCtrls, DB,  StdCtrls, Buttons, DNMSpeedButton,
  DBCtrls, Controls, Mask, Classes, BaseInputForm, Word2000, OleServer,
  Graphics, strUtils, Variants, MemDS, DBAccess, MyAccess,ERPdbComponents, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts, Shader, DNMPanel, ImgList, WordXP,
  ProgressDialog;

type
  TfrmClientReference = class(TBaseInputGUI)
    RefID: TDBEdit;
    ClientID: TDBEdit;
    Ref_type: TDBEdit;
    Label11: TLabel;
    Ref_Date: TDBEdit;
    ContactID: TDBEdit;
    SupID: TDBEdit;
    EmployeeID: TDBEdit;
    FaxNo: TEdit;
    EditedFlag: TDBCheckBox;
    EmailNo: TEdit;
    Referencetxt: TDBEdit;
    Command16: TDNMSpeedButton;
    CancelBtn: TDNMSpeedButton;
    ADOQuery1: TERPQuery;
    DataSource1: TDataSource;
    frmCompanyInformationSrc: TDataSource;
    qryCompanyInfo: TERPQuery;
    DataSource2: TDataSource;
    ADOTable2: TMyTable;
    WordApplication1: TWordApplication;
    frmEmpReferenceSrc: TDataSource;
    ADOTable1: TMyTable;
    ADOQuery2: TERPQuery;
    DataSource3: TDataSource;
    tblDocPath: TMyTable;
    DataSource4: TDataSource;
    WordDocument1: TWordDocument;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlmsg: TDNMPanel;
    lblMsg: TLabel;
    procedure Command16Click(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CID: integer;

  end;

//var
//  frmClientReference: TfrmClientReference;

implementation

uses FastFuncs,frmCustomerFrm, Dialogs, ShellAPI,  remainClientFrm,
  frmSupplierFrm, DNMExceptions, CommonDbLib, frmJob, SystemLib, CommonLib,
  AppEnvironment, ComObj,Preferences, PreferenceLib, EmailUtils, SimpleEncrypt,
  CorrespondenceObj;

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
//  MailSender: T2cEmailSender;
//  TrackEmails: boolean;
  Corres: TCorrespondenceGui;
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

  ADOQuery2.ParamByName('EmpID').AsInteger := AppEnv.Employee.EmployeeID;
  ADOQuery2.Open;

  if ADOQuery2.Lookup('EmployeeID', AppEnv.Employee.EmployeeID, 'UseWord') = 'T' then begin
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
        Try
          if (ADOTable2.FieldByName('UseDocumentTemplate').AsBoolean) and
            (FileExists(ADOTable2.FieldByName('DocumentTemplatePath').AsString)) then begin
            FileNameTemplate := ADOTable2.FieldByName('DocumentTemplatePath').AsString;
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

        if (qryCompanyInfo.FieldByName('HideCompanyName').AsString <> 'T') then begin
          Selection.TypeParagraph;
          Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
          with Selection.Font do begin
            if ADOTable2.FieldByName('FontCompanyName').AsString <> '' then
              Name := ADOTable2.FieldByName('FontCompanyName').AsString
            else Name := 'Times New Roman';
            if ADOTable2.FieldByName('SizeCompanyName').AsString <> '' then
              Size := ADOTable2.FieldByName('SizeCompanyName').AsInteger
            else Size := 36;
            if ADOTable2.FieldByName('ColorCompanyName').AsString <> '' then
              Color := StringToColor(ADOTable2.FieldByName('ColorCompanyName').AsString)
            else Color := clBlack;
            if ADOTable2.FieldByName('StyleCompanyName').AsString <> '' then begin
              if FastFuncs.LeftStr(ADOTable2.FieldByName('StyleCompanyName').AsString, 1) = 'B' then Bold := 1;
              if MidStr(ADOTable2.FieldByName('StyleCompanyName').AsString, 2, 1) = 'I' then Italic := 1;
              if MidStr(ADOTable2.FieldByName('StyleCompanyName').AsString, 3, 1) = 'U' then Underline := 1;
              if MidStr(ADOTable2.FieldByName('StyleCompanyName').AsString, 4, 1) = 'S' then StrikeThrough := 1;
            end else begin
              Bold := 1;
              Italic := 1;
            end;
            Selection.TypeText(qryCompanyInfo.FieldByName('CompanyName').AsString);
          end;
        end;

        if (qryCompanyInfo.FieldByName('HideAddress').AsString <> 'T') then begin
          Selection.TypeParagraph;
          Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
          with Selection.Font do begin
            if ADOTable2.FieldByName('FontAddress').AsString <> '' then Name := ADOTable2.FieldByName('FontAddress').AsString
            else Name := 'Times New Roman';
            if ADOTable2.FieldByName('SizeAddress').AsString <> '' then Size := ADOTable2.FieldByName('SizeAddress').AsInteger
            else Size := 36;
            if ADOTable2.FieldByName('ColorAddress').AsString <> '' then
              Color := StringToColor(ADOTable2.FieldByName('ColorAddress').AsString)
            else Color := clBlack;
            if ADOTable2.FieldByName('StyleAddress').AsString <> '' then begin
              if FastFuncs.LeftStr(ADOTable2.FieldByName('StyleAddress').AsString, 1) = 'B' then Bold := 1;
              if MidStr(ADOTable2.FieldByName('StyleAddress').AsString, 2, 1) = 'I' then Italic := 1;
              if MidStr(ADOTable2.FieldByName('StyleAddress').AsString, 3, 1) = 'U' then Underline := 1;
              if MidStr(ADOTable2.FieldByName('StyleAddress').AsString, 4, 1) = 'S' then StrikeThrough := 1;
            end else begin
              Bold := 1;
              Italic := 1;
            end;
            Selection.TypeText(qryCompanyInfo.FieldByName('Address').AsString);
          end;

          if (qryCompanyInfo.FieldByName('HideCity').AsString <> 'T') then begin
            Selection.TypeParagraph;
            Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
            with Selection.Font do begin
              if ADOTable2.FieldByName('FontSuburb').AsString <> '' then Name := ADOTable2.FieldByName('FontSuburb').AsString
              else Name := 'Times New Roman';
              if ADOTable2.FieldByName('SizeSuburb').AsString <> '' then Size := ADOTable2.FieldByName('SizeSuburb').AsInteger
              else Size := 36;
              if ADOTable2.FieldByName('ColorSuburb').AsString <> '' then
                Color := StringToColor(ADOTable2.FieldByName('ColorSuburb').AsString)
              else Color := clBlack;
              if ADOTable2.FieldByName('StyleSuburb').AsString <> '' then begin
                if FastFuncs.LeftStr(ADOTable2.FieldByName('StyleSuburb').AsString, 1) = 'B' then Bold := 1;
                if MidStr(ADOTable2.FieldByName('StyleSuburb').AsString, 2, 1) = 'I' then Italic := 1;
                if MidStr(ADOTable2.FieldByName('StyleSuburb').AsString, 3, 1) = 'U' then Underline := 1;
                if MidStr(ADOTable2.FieldByName('StyleSuburb').AsString, 4, 1) = 'S' then StrikeThrough := 1;
              end else begin
                Bold := 1;
                Italic := 1;
              end;
              Selection.TypeText(qryCompanyInfo.FieldByName('Suburb').AsString);
            end;
          end;

          if (qryCompanyInfo.FieldByName('HideCountry').AsString <> 'T') then begin
            Selection.TypeParagraph;
            Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
            with Selection.Font do begin
              if ADOTable2.FieldByName('FontSuburb').AsString <> '' then Name := ADOTable2.FieldByName('FontSuburb').AsString
              else Name := 'Times New Roman';
              if ADOTable2.FieldByName('SizeSuburb').AsString <> '' then Size := ADOTable2.FieldByName('SizeSuburb').AsInteger
              else Size := 36;
              if ADOTable2.FieldByName('ColorSuburb').AsString <> '' then
                Color := StringToColor(ADOTable2.FieldByName('ColorSuburb').AsString)
              else Color := clBlack;
              if ADOTable2.FieldByName('StyleSuburb').AsString <> '' then begin
                if FastFuncs.LeftStr(ADOTable2.FieldByName('StyleSuburb').AsString, 1) = 'B' then Bold := 1;
                if MidStr(ADOTable2.FieldByName('StyleSuburb').AsString, 2, 1) = 'I' then Italic := 1;
                if MidStr(ADOTable2.FieldByName('StyleSuburb').AsString, 3, 1) = 'U' then Underline := 1;
                if MidStr(ADOTable2.FieldByName('StyleSuburb').AsString, 4, 1) = 'S' then StrikeThrough := 1;
              end else begin
                Bold := 1;
                Italic := 1;
              end;
              Selection.TypeText(qryCompanyInfo.FieldByName('Country').AsString);
            end;
          end;

          if (qryCompanyInfo.FieldByName('HidePhoneNumber').AsString <> 'T') then begin
            Selection.TypeParagraph;
            Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
            with Selection.Font do begin
              if ADOTable2.FieldByName('FontPhone').AsString <> '' then Name := ADOTable2.FieldByName('FontPhone').AsString
              else Name := 'Times New Roman';
              if ADOTable2.FieldByName('SizePhone').AsString <> '' then Size := ADOTable2.FieldByName('SizePhone').AsInteger
              else Size := 36;
              if ADOTable2.FieldByName('ColorPhone').AsString <> '' then
                Color := StringToColor(ADOTable2.FieldByName('ColorPhone').AsString)
              else Color := clBlack;
              if ADOTable2.FieldByName('StylePhone').AsString <> '' then begin
                if FastFuncs.LeftStr(ADOTable2.FieldByName('StylePhone').AsString, 1) = 'B' then Bold := 1;
                if MidStr(ADOTable2.FieldByName('StylePhone').AsString, 2, 1) = 'I' then Italic := 1;
                if MidStr(ADOTable2.FieldByName('StylePhone').AsString, 3, 1) = 'U' then Underline := 1;
                if MidStr(ADOTable2.FieldByName('StylePhone').AsString, 4, 1) = 'S' then StrikeThrough := 1;
              end else begin
                Bold := 1;
                Italic := 1;
              end;
              Selection.TypeText(qryCompanyInfo.FieldByName('Phone').AsString);
            end;
          end;

          if (qryCompanyInfo.FieldByName('HideABN').AsString <> 'T') then Selection.TypeParagraph;
          Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
          with Selection.Font do begin
            if ADOTable2.FieldByName('FontABN').AsString <> '' then Name := ADOTable2.FieldByName('FontABN').AsString
            else Name := 'Times New Roman';
            if ADOTable2.FieldByName('SizeABN').AsString <> '' then Size := ADOTable2.FieldByName('SizeABN').AsInteger
            else Size := 36;
            if ADOTable2.FieldByName('ColorABN').AsString <> '' then
              Color := StringToColor(ADOTable2.FieldByName('ColorABN').AsString)
            else Color := clBlack;
            if ADOTable2.FieldByName('StyleABN').AsString <> '' then begin
              if FastFuncs.LeftStr(ADOTable2.FieldByName('StyleABN').AsString, 1) = 'B' then Bold := 1;
              if MidStr(ADOTable2.FieldByName('StyleABN').AsString, 2, 1) = 'I' then Italic := 1;
              if MidStr(ADOTable2.FieldByName('StyleABN').AsString, 3, 1) = 'U' then Underline := 1;
              if MidStr(ADOTable2.FieldByName('StyleABN').AsString, 4, 1) = 'S' then StrikeThrough := 1;
            end else begin
              Bold := 1;
              Italic := 1;
            end;
            Selection.TypeText(qryCompanyInfo.FieldByName('ABN').AsString);
          end;
        end;

        if (qryCompanyInfo.FieldByName('HideCompanyName').AsString <> 'T') and
          (qryCompanyInfo.FieldByName('HideABN').AsString <> 'T') and
          (qryCompanyInfo.FieldByName('HidePhoneNumber').AsString <> 'T') and
          (qryCompanyInfo.FieldByName('HideCountry').AsString <> 'T') and
          (qryCompanyInfo.FieldByName('HideCity').AsString <> 'T') and
          (qryCompanyInfo.FieldByName('HideAddress').AsString <> 'T') then begin
          Selection.TypeParagraph;
          Selection.TypeParagraph;
        end;

        with Selection.Font do begin
          Name := 'Arial';
          Size := 24;
          Color := clBlack;
          Bold := 1;
        end;
        ADOQuery1.ParamByName('CID').AsInteger := CID;
        ADOQuery1.Open;
        if Ref_Type.Text = 'Email' then begin
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
        if Ref_Type.Text = 'Fax' then begin
          Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
          with Selection.Font do begin
            Name := 'Arial';
            Size := 24;
            Color := clBlack;
            Bold := 1;
            Italic := 0;
          end;
          if not (qryCompanyInfo.FieldByName('HideFaxNumber').AsString = 'T') then Selection.TypeText('FAX');
          Selection.TypeParagraph;
          Selection.TypeParagraph;
          Selection.ParagraphFormat.Alignment := wdAlignParagraphLeft;
          with Selection.Font do begin
            if ADOTable2.FieldByName('FontDefault').AsString <> '' then Name := ADOTable2.FieldByName('FontDefault').AsString
            else Name := 'Arial';
            if ADOTable2.FieldByName('SizeDefault').AsString <> '' then Size := ADOTable2.FieldByName('SizeDefault').AsInteger
            else Size := 12;
            if ADOTable2.FieldByName('ColorDefault').AsString <> '' then
              Color := StringToColor(ADOTable2.FieldByName('ColorDefault').AsString)
            else Color := clBlack;
            if ADOTable2.FieldByName('StyleDefault').AsString <> '' then begin
              if FastFuncs.LeftStr(ADOTable2.FieldByName('StyleDefault').AsString, 1) = 'B' then Bold := 1;
              if MidStr(ADOTable2.FieldByName('StyleDefault').AsString, 2, 1) = 'I' then Italic := 1;
              if MidStr(ADOTable2.FieldByName('StyleDefault').AsString, 3, 1) = 'U' then Underline := 1;
              if MidStr(ADOTable2.FieldByName('StyleDefault').AsString, 4, 1) = 'S' then StrikeThrough := 1;
            end else begin
              Bold := 0;
              Italic := 0;
            end;
          end;
          Selection.Font.Bold := 1;
          txtLine := 'To: ';
          Selection.TypeText(txtLine);
          txtLine := '';
          if FastFuncs.LeftStr(ADOTable2.FieldByName('StyleDefault').AsString, 1) = 'B' then Selection.Font.Bold := 1
          else Selection.Font.Bold := 0;
          Selection.ParagraphFormat.Alignment := wdAlignParagraphLeft;
          if ADOQuery1.FieldByName('ContactTitle').AsString <> '' then
            txtLine := ADOQuery1.FieldByName('ContactTitle').AsString + ' ';
          if ADOQuery1.FieldByName('ContactFirstName').AsString <> '' then
            txtLine := txtLine + ADOQuery1.FieldByName('ContactFirstName').AsString + ' ';
          if ADOQuery1.FieldByName('ContactSurName').AsString <> '' then
            txtLine := txtLine + ADOQuery1.FieldByName('ContactSurName').AsString;
          Selection.TypeText(txtLine);
          Selection.Font.Bold := 1;
          txtLine := '                                        Fax No: ';
          Selection.TypeText(txtLine);
          if FastFuncs.LeftStr(ADOTable2.FieldByName('StyleDefault').AsString, 1) = 'B' then Selection.Font.Bold := 1
          else Selection.Font.Bold := 0;
          txtLine := ADOQuery1.FieldByName('ContactFax').AsString;
          Selection.TypeText(txtLine);
          Selection.TypeParagraph;
          Selection.TypeParagraph;
          Selection.Font.Bold := 1;
          txtLine := 'From: ';
          Selection.TypeText(txtLine);
          if FastFuncs.LeftStr(ADOTable2.FieldByName('StyleDefault').AsString, 1) = 'B' then Selection.Font.Bold := 1
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
          if FastFuncs.LeftStr(ADOTable2.FieldByName('StyleDefault').AsString, 1) = 'B' then Selection.Font.Bold := 1
          else Selection.Font.Bold := 0;
          if qryCompanyInfo.FieldByName('FaxDate').AsString <> '' then
            txtLine := qryCompanyInfo.FieldByName('FaxDate').AsString;
          Selection.TypeText(txtLine);
          Selection.TypeParagraph;
          Selection.TypeParagraph;
          Selection.Font.Bold := 1;
          txtLine := 'No. Pages: ';
          Selection.TypeText(txtLine);
          if FastFuncs.LeftStr(ADOTable2.FieldByName('StyleDefault').AsString, 1) = 'B' then Selection.Font.Bold := 1
          else Selection.Font.Bold := 0;
          Selection.TypeParagraph;
          Selection.TypeParagraph;
          Selection.Font.Bold := 1;
          txtLine := 'Re: ';
          Selection.TypeText(txtLine);
          if FastFuncs.LeftStr(ADOTable2.FieldByName('StyleDefault').AsString, 1) = 'B' then Selection.Font.Bold := 1
          else Selection.Font.Bold := 0;
        end else begin
          Selection.ParagraphFormat.Alignment := wdAlignParagraphRight;
          with Selection.Font do begin
            Bold := 0;
            Italic := 0;
            if ADOTable2.FieldByName('FontDefault').AsString <> '' then Name := ADOTable2.FieldByName('FontDefault').AsString
            else Name := 'Arial';
            if ADOTable2.FieldByName('SizeDefault').AsString <> '' then Size := ADOTable2.FieldByName('SizeDefault').AsInteger
            else Size := 12;
            if ADOTable2.FieldByName('ColorDefault').AsString <> '' then
              Color := StringToColor(ADOTable2.FieldByName('ColorDefault').AsString)
            else Color := clBlack;
            if ADOTable2.FieldByName('StyleDefault').AsString <> '' then begin
              if FastFuncs.LeftStr(ADOTable2.FieldByName('StyleDefault').AsString, 1) = 'B' then Bold := 1;
              if MidStr(ADOTable2.FieldByName('StyleDefault').AsString, 2, 1) = 'I' then Italic := 1;
              if MidStr(ADOTable2.FieldByName('StyleDefault').AsString, 3, 1) = 'U' then Underline := 1;
              if MidStr(ADOTable2.FieldByName('StyleDefault').AsString, 4, 1) = 'S' then StrikeThrough := 1;
            end;
            Selection.TypeText(DateToStr(Now));
          end;
          Selection.TypeParagraph;
          Selection.TypeParagraph;
          txtLine := '';
          Selection.ParagraphFormat.Alignment := wdAlignParagraphLeft;
          if ADOQuery1.FieldByName('ContactTitle').AsString <> '' then
            txtLine := ADOQuery1.FieldByName('ContactTitle').AsString + ' ';
          if ADOQuery1.FieldByName('ContactFirstName').AsString <> '' then
            txtLine := txtLine + ADOQuery1.FieldByName('ContactFirstName').AsString + ' ';
          if ADOQuery1.FieldByName('ContactSurName').AsString <> '' then
            txtLine := txtLine + ADOQuery1.FieldByName('ContactSurName').AsString;
          Selection.TypeText(txtLine);
          {Contact Address}
          txtLine := '';
          if ADOQuery1.FieldByName('ContactAddress').AsString <> '' then
            txtLine := ADOQuery1.FieldByName('ContactAddress').AsString + ' ';
          if ADOQuery1.FieldByName('ContactAddress2').AsString <> '' then
            txtLine := txtLine + ADOQuery1.FieldByName('ContactAddress2').AsString;
          Selection.TypeParagraph;
          Selection.TypeText(txtLine);
          {Contact Suburb/State/Postcode}
          txtLine := '';
          if ADOQuery1.FieldByName('ContactCity').AsString <> '' then
            txtLine := ADOQuery1.FieldByName('ContactCity').AsString + ' ';
          if ADOQuery1.FieldByName('ContactState').AsString <> '' then
            txtLine := txtLine + ADOQuery1.FieldByName('ContactState').AsString + ' ';
          if ADOQuery1.FieldByName('ContactPcode').AsString <> '' then
            txtLine := txtLine + ADOQuery1.FieldByName('ContactPcode').AsString;
          Selection.TypeParagraph;
          Selection.TypeText(txtLine);
          {Two returns}
          Selection.TypeParagraph;
          Selection.TypeParagraph;
          {Salutation}
          txtLine := '';
          if ADOQuery1.FieldByName('ContactFirstName').AsString <> '' then
            txtLine := 'Dear ' + ADOQuery1.FieldByName('ContactFirstName').AsString;
          Selection.TypeParagraph;
          Selection.TypeText(txtLine);
          {Close Contact Table}
          ADOQuery1.Close;
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
    if Ref_Type.Text <> 'Email' then begin
      Form := GetComponentByClassName('TREMainClient');
      if Assigned(Form) then begin
        with TREMainClient(Form) do begin
          TREMainClient(Form).CID := Self.CID;
          TREMainClient(Form).Caption := Ref_Type.Text;
          TREMainClient(Form).Referencetxt.Text := Self.Referencetxt.Text;
          if Ref_Type.Text = 'Fax' then begin
            Fax.Text := FaxNo.Text;
          end else begin
            Fax.Text := '';
          end;
          FormStyle := fsMDIChild;
          BringToFront;
        end;
      end;
    end else begin
      if Ref_Type.Text = 'Email' then begin
        Corres := TCorrespondenceGui.Create;
        try
          Corres.RecipientList := EmailNo.Text;
          ADOQuery1.ParamByName('CID').AsInteger := CID;
          ADOQuery1.Open;
          Corres.Correspondence.MessageTo := ADOQuery1.FieldByName('Company').AsString + ' (' + EmailNo.Text + ')';
          ADOQuery1.Close;
          if not AppEnv.Employee.UseEmpEmailAsFromAddress then begin
            Corres.Correspondence.MessageFrom := AppEnv.Employee.EmployeeName + ' (' + AppEnv.CompanyInfo.Email + ')';
          end
          else begin
            Corres.Correspondence.MessageFrom := AppEnv.Employee.EmployeeName + ' (' + AppEnv.Employee.Email + ')';
          end;
          Corres.Subject := Referencetxt.Text;
          ADOTable1.Cancel;
          Corres.Execute();

        finally
          Corres.Free;
        end;
      end;
    end;
  end;



  if Ref_Type.Text <> 'Email' then begin
    EditDb(ADOTable1);
    ADOTable1.FieldByName('ContactID').AsInteger := CID;
    ADOTable1.Post;
  end;
  Notify(false);

  Self.Close;
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
  if Assigned(Owner) and (Owner is TBaseInputGUI) then begin
    ADOTable1.Connection := TBaseInputGUI(Owner).MyConnection;
    ADOQuery1.Connection := TBaseInputGUI(Owner).MyConnection;
  end
  else begin
    ADOTable1.Connection := CommonDbLib.GetSharedMyDacConnection;
    ADOQuery1.Connection := CommonDbLib.GetSharedMyDacConnection;
  end;
  ADOTable2.Connection := CommonDbLib.GetSharedMyDacConnection;
  tblDocPath.Connection := CommonDbLib.GetSharedMyDacConnection;
  ADOQuery2.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCompanyInfo.Connection := CommonDbLib.GetSharedMyDacConnection;
end;

initialization
  RegisterClassOnce(TfrmClientReference);

end.
