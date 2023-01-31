unit CustomerExpressList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, BaseListExpress,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TCustomerExpressListGUI = class(TBaseListExpressGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainCompany: TWideStringField;
    qryMainPrintname: TWideStringField;
    qryMainCompanyName: TWideStringField;
    qryMainJobName: TWideStringField;
    qryMainJobNumber: TIntegerField;
    qryMainARBalance: TFloatField;
    qryMainAPBalance: TFloatField;
    qryMainBalance: TFloatField;
    qryMainFirstname: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainIsJob: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainCreditLimit: TFloatField;
    qryMainDefaultClass: TWideStringField;
    qryMainArea: TWideStringField;
    btnSMS: TDNMSpeedButton;
    btnEmail: TDNMSpeedButton;
    qryMainclientcode: TWideStringField;
    qryMainprintjobname: TWideStringField;
    qryMainContactName: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainGracePeriod: TWordField;
    qryMainStopCredit: TWideStringField;
    qryMainStreet: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainStreet3: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainState: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainAccountNo: TWideStringField;
    btnPrintAddressLabel: TDNMSpeedButton;
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnSMSClick(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
    procedure btnPrintAddressLabelClick(Sender: TObject);
  private
    { Private declarations }
    procedure SendBulkSMS;
    procedure SendBulkEmail;
  Protected
    Procedure SetGridColumns;Override;
    Function ExpressDetailListName:String;Override;
  public
  end;

implementation

uses CommonLib, FastFuncs, CommonFormLib, frmCustomerFrm,
  EmailUtils, SMSUtils, CommonDbLib, AppEnvironment, CorrespondenceObj, EmailExtraUtils;

{$R *.dfm}
procedure TCustomerExpressListGUI.grdMainDblClick(Sender: TObject);
begin
    SubsequentID := Chr(95) + qryMain.Fields.FieldByName('IsJob').AsString;
    inherited;
end;

procedure TCustomerExpressListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;

(*class Procedure TCustomerExpressListGUI.ListForfilter(Currentfilter: String; xReadfilter:TNotifyEvent);
var
  ListForm: TCustomerExpressListGUI;
begin
  ListForm:= TCustomerExpressListGUI(GetComponentByClassName('TCustomerExpressListGUI'));
  if ListForm.Visible then begin
    ListForm.Close;
    Freeandnil(ListForm);
    ListForm:= TCustomerExpressListGUI(GetComponentByClassName('TCustomerExpressListGUI'));
  end;
  if Assigned(ListForm) and (ListForm.Visible =False) then begin
    With ListForm do try
      CustomFilterString := CurrentFilter;
      Readfilter := xReadfilter;
      ShowModal;
    finally
        Free;
    end;
  end;
end;*)

procedure TCustomerExpressListGUI.SendBulkEmail;
var
  List: TStringList;
  Corres: TCorrespondenceGui;
  lSilent,
  lSecret : boolean;
begin
  List := TStringList.Create;
  Corres := TCorrespondenceGui.Create;
  try
    GetFieldValueList('Email',List,self.qryMainClientID.FieldName);

    if List.Count = 0 then begin
      CommonLib.MessageDlgXP_Vista('None of the Customers in the selected list have Email addresses.', mtInformation, [mbOk], 0);
      exit;
    end
    else if List.Count < grdMain.SelectedList.Count then begin
      if CommonLib.MessageDlgXP_Vista('Not all of the Customers in the selected list have email addresses, ' +
        'only ' + IntToStr(List.Count) + ' of the ' + IntToStr(grdMain.SelectedList.Count) + ' have an email address.' + #13#10 + #13#10 +
        'Do you wish to continue with sending an email to the ' + IntToStr(List.Count) + ' customers?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        exit;
    end;
    { send Email }

    if not EmailSilentSecret(List.Count, false, lSilent, lSecret) then
      exit;
    Corres.CorrespondenceType := ctEmail;
    Corres.RecipientList := '[Multiple Customers]';
    Corres.GroupRecipientList.Assign(List);
    Corres.RecipientType := rtCustomer;
    Corres.Execute(lSilent, lSecret);
  finally
    List.Free;
    Corres.Free;
  end;
end;

procedure TCustomerExpressListGUI.SendBulkSMS;
var
  List: TStringList;
  Corres: TCorrespondenceGui;
begin
  List := TStringList.Create;
  Corres := TCorrespondenceGui.Create;
  try
    GetFieldValueList('Mobile',List,self.qryMainClientID.FieldName);

    if List.Count = 0 then begin
      CommonLib.MessageDlgXP_Vista('None of the Customers in the selected list have Mobile phone numbers.', mtInformation, [mbOk], 0);
      exit;
    end
    else if List.Count < grdMain.SelectedList.Count then begin
      if CommonLib.MessageDlgXP_Vista('Not all of the Customers in the selected list have Mobile phone numbers, ' +
        'only ' + IntToStr(List.Count) + ' of the ' + IntToStr(grdMain.SelectedList.Count) + ' have mobile numbers.' + #13#10 + #13#10 +
        'Do you wish to continue with sending an SMS to the ' + IntToStr(List.Count) + ' customers?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        exit;
    end;
    { send SMS }

    Corres.CorrespondenceType := ctSMS;
    Corres.RecipientList := '[Multiple Customers]';
    Corres.GroupRecipientList.Assign(List);
    Corres.RecipientType := rtCustomer;
    Corres.Execute();

  finally
    List.Free;
    Corres.Free;
  end;
end;

procedure TCustomerExpressListGUI.SetGridColumns;
begin
    RemoveFieldfromGrid('ParentClientID');
    RemoveFieldfromGrid('ParentRelatedClientID');
    RemoveFieldfromGrid('TermsID');
  inherited;
end;
procedure TCustomerExpressListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;


procedure TCustomerExpressListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if (Grpfilters.ItemIndex= 0) and (Grpfilters.Visible = False) then
    grpFiltersClick(Grpfilters);
end;

procedure TCustomerExpressListGUI.btnEmailClick(Sender: TObject);
begin
  inherited;
  SendBulkEmail;
end;

procedure TCustomerExpressListGUI.btnPrintAddressLabelClick(Sender: TObject);
var
  x: integer;
  RepName: string;
begin
  inherited;
  if grdMain.SelectedList.Count = 0 then exit;
  RepName := GetReportNameForTypeName('Client Ship Address');
  if RepName = '' then
    RepName := 'Client Ship Address Label';
  grdMain.BeginUpdate;
  try
    for x := 0 to grdMain.SelectedList.Count -1 do begin
      qryMain.GotoBookmark(grdMain.SelectedList[x]);
      PrintTemplateReport(RepName,'~|||~ where ClientID = ' + IntToStr(qryMainClientID.AsInteger),true,1);
    end;
  finally
    grdMain.EndUpdate();
  end;
end;

procedure TCustomerExpressListGUI.btnSMSClick(Sender: TObject);
begin
  inherited;
  SendBulkSMS;
end;

procedure TCustomerExpressListGUI.cmdNewClick(Sender: TObject);
(*Var Form : TComponent;*)
begin
  (*DisableForm;
  try
    inherited;
    Form := FindExistingComponent('TfrmCustomer',0);
    if Assigned(Form) then
      TForm(Form).BringToFront
    else begin
      Form := GetComponentByClassName('TfrmCustomer');
      if Assigned(Form) then begin
        with TfrmCustomer(Form) do begin
          AttachObserver(Self);
          FormStyle := fsMDIChild;
          BringToFront;
        end;
      end;
    end;
  finally
    EnableForm;
  end;*)
  OpenERPForm('TfrmCustomer', 0);
end;

function TCustomerExpressListGUI.ExpressDetailListName: String;
begin
  REsult := 'TCustomerListGUI';
end;

initialization
  RegisterClassOnce(TCustomerExpressListGUI);

end.
