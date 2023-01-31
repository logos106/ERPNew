
unit MarketingLeads;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Math,
  Dialogs, BaseListingForm, DB,  ProgressDialog, DBAccess,
  MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, StdCtrls, wwdblook, Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar,
  DNMSpeedButton, kbmMemTable, BaseInputForm, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TMarketingLeadsGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainLeadID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainCOMPANY: TWideStringField;
    qryMainRepID: TIntegerField;
    qryMainRep: TWideStringField;
    qryMainEnteredByEmployeeID: TIntegerField;
    qryMainCreatedBy: TWideStringField;
    qryMainStreet: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainStreet3: TWideStringField;
    qryMainSUBURB: TWideStringField;
    qryMainSTATE: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainPOSTCODE: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainContactName: TWideStringField;
    qryMainLeadStatus: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainSource: TWideStringField;
    btnSMS: TDNMSpeedButton;
    btnEmail: TDNMSpeedButton;
    qryMainCreatedOn: TDateTimeField;
    qryMainAppointmentCount: TLargeintField;
    qryCustomFields: TERPQuery;
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure btnSMSClick(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
  private
    fFilterOnSource: boolean;
    fSourceFilter: string;

    procedure SendBulkSMS;
    procedure SendBulkEmail;
    procedure MakeQrymain(const Fields : String; Tables: String);Overload;
    procedure MakeQrymain;Overload;
    Function MasterID:Integer;
  Protected
    Procedure AssignKeyId(Popupform :TBaseInputGUI); override;
    procedure RefreshQuery; override;
    procedure WriteGuiPrefExtra; override;
    procedure ReadnApplyGuiPrefExtra; override;
  public
    property FilterOnSource : boolean read fFilterOnSource write  fFilterOnSource;
    property SourceFilter : string read fSourceFilter write fSourceFilter;
  end;


implementation

uses CommonLib, frmMarketingLead, FormFactory, CommonDbLib,
  SMSUtils, AppEnvironment, EmailUtils, CorrespondenceObj, EmailExtraUtils,
  Busobjcustomfields, CustomFieldListLib;

{$R *.dfm}

procedure TMarketingLeadsGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  //NoDateRange := true;
  MakeQrymain;
  inherited;
end;

Procedure TMarketingLeadsGUI.AssignKeyId(Popupform :TBaseInputGUI);
begin
    if SameText(FormFact.Identifier , 'Company') then
        Popupform.keyid := QrymainID.asInteger
    else inherited;

end;


procedure TMarketingLeadsGUI.btnEmailClick(Sender: TObject);
begin
  inherited;
  SendBulkEmail;
end;

procedure TMarketingLeadsGUI.btnSMSClick(Sender: TObject);
begin
  inherited;
  SendBulkSMS;
end;

procedure TMarketingLeadsGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmMarketingLead');
  if Assigned(Form) then begin
    with TfmMarketingLead(Form) do begin
      KeyId := 0;
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TMarketingLeadsGUI.grdMainDblClick(Sender: TObject);
Var
  CL_Type:String;
begin
  SubsequentID := '';
  if grdMain.GetActiveField.FieldName = 'Company' then begin
    CL_Type := GetClientIDType(qryMainClientID.AsInteger);
    If CL_Type <> 'Unknown' then
      SubsequentID := Chr(95) + CL_Type;
  end;
  inherited;
end;

procedure TMarketingLeadsGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if chkIgnoreDates.visible then
      if GuiPrefs.Node.Exists('Options.Ignoredate') then
        chkIgnoreDates.checked :=  GuiPrefs.Node['Options.Ignoredate'].asBoolean;
end;

procedure TMarketingLeadsGUI.RefreshQuery;
begin
    InitDateFromnDateto;
  inherited;
end;

procedure TMarketingLeadsGUI.SendBulkEmail;
var
  List: TStringList;
  Corres: TCorrespondenceGui;
begin
  List := TStringList.Create;
  Corres := TCorrespondenceGui.Create;
  try
    GetFieldValueList('Email',List, self.qryMainID.FieldName);

    if List.Count = 0 then begin
      CommonLib.MessageDlgXP_Vista('None of the Leads in the selected list have Email addresses.', mtInformation, [mbOk], 0);
      exit;
    end
    else if List.Count < grdMain.SelectedList.Count then begin //qryMain.RecordCount then begin
      if CommonLib.MessageDlgXP_Vista('Not all of the Leads in the selected list have email addresses, ' +
        'only ' + IntToStr(List.Count) + ' of the ' + IntToStr(grdMain.SelectedList.Count{qryMain.RecordCount}) + ' have an email address.' + #13#10 + #13#10 +
        'Do you wish to continue with sending an email to the ' + IntToStr(List.Count) + ' leads?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        exit;
    end;
    { send Email }

    Corres.CorrespondenceType := ctEmail;
    Corres.RecipientList := '[Multiple Leads]';
    Corres.GroupRecipientList.Assign(List);
    Corres.RecipientType := rtUnknown;
    Corres.Execute(false, false);

  finally
    List.Free;
    Corres.Free;
  end;
end;

procedure TMarketingLeadsGUI.SendBulkSMS;
var
  List: TStringList;
  Corres: TCorrespondenceGui;
begin
  List := TStringList.Create;
  Corres := TCorrespondenceGui.Create;
  try
    GetFieldValueList('Mobile',List, self.qryMainID.FieldName);

    if List.Count = 0 then begin
      CommonLib.MessageDlgXP_Vista('None of the Leads in the selected list have Mobile phone numbers.', mtInformation, [mbOk], 0);
      exit;
    end
    else if List.Count < grdMain.SelectedList.Count then begin
      if CommonLib.MessageDlgXP_Vista('Not all of the Leads in the selected list have Mobile phone numbers, ' +
        'only ' + IntToStr(List.Count) + ' of the ' + IntToStr(grdMain.SelectedList.Count) + ' have mobile numbers.' + #13#10 + #13#10 +
        'Do you wish to continue with sending an SMS to the ' + IntToStr(List.Count) + ' Leads?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        exit;
    end;
    { send SMS }

    Corres.CorrespondenceType := ctSMS;
    Corres.RecipientList := '[Multiple Leads]';
    Corres.GroupRecipientList.Assign(List);
    Corres.RecipientType := rtUnknown;
    Corres.Execute();
  finally
    List.Free;
    Corres.Free;
  end;
end;

procedure TMarketingLeadsGUI.WriteGuiPrefExtra;
begin
  inherited;
  if chkIgnoreDates.visible then
      GuiPrefs.Node['Options.Ignoredate'].asBoolean:= chkIgnoreDates.checked;
end;

procedure TMarketingLeadsGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'ID,LeadID,ClientID,RepID,EnteredByEmployeeID');
end;

procedure TMarketingLeadsGUI.MakeQrymain(const Fields : String; Tables: String);
begin
    closedb(Qrymain);
    Qrymain.sql.clear;
    Qrymain.sql.Add('SELECT');
    Qrymain.sql.Add('MC.ID,');
    Qrymain.sql.Add('ML.GlobalRef       as GlobalRef,');
    Qrymain.sql.Add('ML.LeadID          as LeadID,');
    Qrymain.sql.Add('ML.ClientID        as ClientID,');
    Qrymain.sql.Add('MC.COMPANY         as Company,');
    Qrymain.sql.Add('ML.RepID           as RepID,');
    Qrymain.sql.Add('E.EmployeeName     AS Rep,');
    Qrymain.sql.Add('ML.EnteredByEmployeeID as EnteredByEmployeeID,');
    Qrymain.sql.Add('e2.EmployeeName    AS CreatedBy,');
    Qrymain.sql.Add('MC.Street          as Street,');
    Qrymain.sql.Add('MC.Street2         as Street2,');
    Qrymain.sql.Add('MC.Street3         as Street3,');
    Qrymain.sql.Add('MC.SUBURB          as SUBURB,');
    Qrymain.sql.Add('MC.STATE           as STATE,');
    Qrymain.sql.Add('MC.Country         as Country,');
    Qrymain.sql.Add('MC.POSTCODE        as POSTCODE,');
    Qrymain.sql.Add('MC.FaxNumber       as FaxNumber,');
    Qrymain.sql.Add('MC.Phone           as Phone,');
    Qrymain.sql.Add('MC.AltPhone        as AltPhone,');
    Qrymain.sql.Add('MC.Mobile          as Mobile,');
    Qrymain.sql.Add('MC.Source          as Source,');
    Qrymain.sql.Add('ML.CreatedOn       as CreatedOn,');
    Qrymain.sql.Add('CONCAT(MC.FirstName," ",MC.LastName) as ContactName,');
    Qrymain.sql.Add('ML.LeadStatus      as LeadStatus,');
    Qrymain.sql.Add('ifnull(tblclients.Email,MC.Email) as Email,');
    Qrymain.sql.Add(Fields);
    Qrymain.sql.Add('(select Count( * ) from tblmarketingleadlines where tblmarketingleadlines.LeadId = ML.LeadID and tblmarketingleadlines.ResultTypeName = "Appointment") as AppointmentCount');
    Qrymain.sql.Add('FROM tblMarketingLeads as ML');
    Qrymain.sql.Add('inner join tblmarketingcontacts as MC  on (MC.ID = ML.MarketingContactID)');
    Qrymain.sql.Add(Tables);
    Qrymain.sql.Add('left join tblemployees  E on (E.EmployeeID = ML.RepID)');
    Qrymain.sql.Add('left  join tblemployees e2  on (e2.EmployeeID = ML.EnteredByEmployeeID)');
    Qrymain.sql.Add('left join tblclients ON ML.ClientID=tblclients.ClientID');
    Qrymain.sql.Add('Where ML.IsLead <> "F"');
    Qrymain.sql.Add('and IfNull(ML.CreatedOn,0) between :DateFrom and :Dateto');
    Qrymain.sql.Add('AND (Ifnull(ML.ClientID,0) = 0  or tblclients.Active =  "T")');
    Qrymain.sql.Add('AND  MC.Active = "T"');
end;
procedure TMarketingLeadsGUI.MakeQrymain;
begin
  CustomfieldlistSQL(ltLeads, qrymain, 'ML.LeadID' , MakeQrymain , MasterID);
end;

function TMarketingLeadsGUI.MasterID: Integer;
begin
  Result :=0;
end;

procedure TMarketingLeadsGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
    if FilterOnSource and (SourceFilter <> '') then
      if Pos('and MC.Source = "', qrymain.sql[qrymain.sql.Count-1]) = 0 then
        qrymain.sql.Add('and MC.Source = "' + SourceFilter + '"');

end;

initialization
  RegisterClassOnce(TMarketingLeadsGUI);
end.
