unit MarketingContactList;

{ Date     Version Who What
 -------- -------- --- ------------------------------------------------------
 26/07/05  1.00.01 IJB Changed list to default to All criteria and both done/not
                       done.
 14/04/07  1.00.02 IJB Added Phone column.

}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, wwdblook, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, XMLDataObj, ProgressDialog, Mask, wwdbedit,
  Wwdotdot, Wwdbcomb, Wwdbspin,  Shader, kbmMemTable,
  BaseMarketingContactList, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TMarketingContactListGUI = class(TBaseMarketingContactListGUI)
    Panel4: TPanel;
    Label4: TLabel;
    qrySelectionList: TERPQuery;
    cboListSelection: TwwDBLookupCombo;
    qrySelectionListRangeSelectionId: TIntegerField;
    qrySelectionListRangeDescription: TWideStringField;
    qrySelectionListXMLData: TWideMemoField;
    qrySelectionListActive: TWideStringField;
    chkAll: TCheckBox;
    btnImport: TDNMSpeedButton;
    qryMainDateEntered: TDateTimeField;
    qryMainGlobalRef: TWideStringField;
    qryMainCompanyTypeName: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainSTATE: TWideStringField;
    qryMainFirstName: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainSUBURB: TWideStringField;
    qryMainSource: TWideStringField;
    qryMainPOSTCODE: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainLastLeaddone: TDateTimeField;
    qryMainID: TIntegerField;
    qryMainLeadId: TIntegerField;
    qryMainURL: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainCompany: TWideStringField;
    qryMainFollowupDate: TDateTimeField;
    qryMainClientID: TIntegerField;
    qryMainActive: TWideStringField;
    qryMainIsCustomer: TWideStringField;
    qryMainIssupplier: TWideStringField;
    qryMainIsothercontact: TWideStringField;
    grpExtrafilter: TRadioGroup;
    qryMainMobile: TWideStringField;
    btnSMS: TDNMSpeedButton;
    btnEmail: TDNMSpeedButton;
    qryMainDoNotContact: TWideStringField;
    procedure cboListSelectionCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormShow(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure chkAllClick(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure cboDurationFilterCloseUp(Sender: TwwDBComboBox;
      Select: Boolean);
    procedure spnDurationFilterChange(Sender: TObject);
    procedure chkIgnoreDatesClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure btnSMSClick(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);

  private
    fXML: TXMLData;
    function XML: TXMLData;
    (*AssignKeyIdDone :Boolean;*)
    procedure SendBulkSMS;
    procedure SendBulkEmail;

  Protected
    (*Procedure AssignKeyId(Popupform :TBaseInputGUI); Override;*)
    ExcludeMCwithLead:boolean;
    Procedure SetGridColumns; override;
    procedure PopulateFilterCombo; override;
    Procedure WriteGuiPrefExtra; override;
    procedure ReadnApplyGuiPrefExtra; override;
    Procedure MakeQry;virtual;
    function FilterBasedOnselection:String;virtual;
    Procedure InitQrymainparams;virtual;
  public
    { Public declarations }
    procedure RefreshQuery; override;
  end;


implementation

uses
  frmImportOptionsFrm,CommonLib, Forms,
  DateUtils, frmMarketingContact, MarketingContactListDetails, BaseInputForm,
  BaseListingForm, tcConst, tcDataUtils, FastFuncs , EmailExtraUtils,
  EmailUtils, AppEnvironment, SMSUtils, CommonDbLib, CorrespondenceObj;

{$R *.dfm}

{ TBaseListingGUI1 }

procedure TMarketingContactListGUI.ReadnApplyGuiPrefExtra;
var
  x: integer;
begin
  inherited;
  if GuiPrefs.Node.Exists('ExtraFilter') then begin
    x := GuiPrefs.Node['ExtraFilter.ItemIndex'].asInteger;
    if x > 0 then grpExtraFilter.ItemIndex := x - 1
    else grpExtraFilter.ItemIndex := 0;
  end
  else
    grpExtraFilter.ItemIndex := 0;
end;

procedure TMarketingContactListGUI.RefreshQuery;
begin
    if Self.ErrorOccurred then Exit;
    Processingcursor(True);
    try
    qryMain.DisableControls;
    initQrymainparams;
    try
      inherited;
    finally
        qryMain.EnableControls;
    end;
    grdMain.ColumnByName('CompanyTypeName').DisplayLabel  := 'Company Type';
    TDatetimefield(qrymain.fieldByname('LastLeaddone')).DisplayFormat := FormatSettings.ShortDateformat;
    TDatetimefield(qrymain.fieldByname('FollowupDate')).DisplayFormat := FormatSettings.ShortDateformat;
    finally
      Processingcursor(False);
    end;
end;

procedure TMarketingContactListGUI.cboListSelectionCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  chkAll.checked := cboListSelection.Text = '';
  MakeQry;
  RefreshQuery;
end;

procedure TMarketingContactListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ExcludeMCwithLead := False;
end;

procedure TMarketingContactListGUI.FormShow(Sender: TObject);
begin
  qrySelectionList.Open;
  MakeQry;
  inherited;
  if Self.ErrorOccurred then Exit;
  if ExcludeMCwithLead then
    TimerMsg(FilterLabel , 'This list will show the Marketing Contact record ONLY if NO Lead/Tele Marking record already created for it', 30);

  if Self.ClassNameIs('TMarketingContactListGUI') then begin
    grpFilters.hint :=   'This list will ONLY show the records that was originally created as a ' + NL+
                       '''Marketing Contact'' and converted to a ''Customer'', ''Supplier'' or ''Prospect''' +NL+NL+
                       'If the ''Marketing contact'' is already converted to a ''Prospect'' the record will only be shown under ''Prospect'''+NL+
                       '''Marketing concat'' is the list of records which is not converted to a Client at all'+NL;
    grdmain.Hint := grpFilters.hint;
    grpFilters.showhint := True;
    grdmain.showhint := True;
  end;
end;

procedure TMarketingContactListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := 'Company ASC CIS; DateEntered ASC CIS';
end;

procedure TMarketingContactListGUI.chkAllClick(Sender: TObject);
begin
  inherited;
  if not Self.fbFormOpenedOk then Exit;
  if chkAll.Checked then begin
    cboListSelection.Enabled := false;
    //     cboDateRange.Enabled := False;
    //     lblFrom.Enabled := False;
    //     dtFrom.Enabled := False;
    //     lblTo.Enabled := False;
    //     dtTo.Enabled := False;
  end else begin
    cboListSelection.Enabled := true;
    //      cboDateRange.Enabled := True;
    //      lblFrom.Enabled := True;
    //      dtFrom.Enabled := True;
    //      lblTo.Enabled := True;
    //      dtTo.Enabled := True;
  end;

  MakeQry;
  RefreshQuery;
end;

procedure TMarketingContactListGUI.dtToChange(Sender: TObject);
begin
  dtTo.Time := Time;
  inherited;
end;

procedure TMarketingContactListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmMarketingContact');
  if Assigned(Form) then begin
    with TfmMarketingContact(Form) do begin
      KeyId := 0;
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TMarketingContactListGUI.btnEmailClick(Sender: TObject);
begin
  inherited;
  SendBulkEmail;
end;

procedure TMarketingContactListGUI.btnImportClick(Sender: TObject);
var
  frm: TfrmImportoptions;
begin
  frm := TfrmImportoptions(GetComponentByClassName('TfrmImportoptions'));
  if Assigned(Frm) then begin //if has acess
    frm.CallingClassName := 'TfrmMarketingContactDetailsListGUI';
    frm.FormStyle := fsNormal;
    frm.ShowModal;
    btnRequery.Click;
  end;
end;
procedure TMarketingContactListGUI.btnSMSClick(Sender: TObject);
begin
  inherited;
  SendBulkSMS;
end;

procedure TMarketingContactListGUI.cboDurationFilterCloseUp(
  Sender: TwwDBComboBox; Select: Boolean);
begin
  inherited;
  btnRequery.Click;
end;

procedure TMarketingContactListGUI.spnDurationFilterChange(
  Sender: TObject);
begin
  inherited;
  btnRequery.Click;
end;

procedure TMarketingContactListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['ExtraFilter.ItemIndex'].asInteger := grpExtraFilter.ItemIndex + 1;
end;

function TMarketingContactListGUI.XML: TXMLData;
begin
  if not Assigned(fXML) then
    fXML:= TXMLData.Create(self);
  result:= fXML;
end;

procedure TMarketingContactListGUI.chkIgnoreDatesClick(Sender: TObject);
begin
  inherited;
  MakeQry;
  RefreshQuery;
end;

procedure TMarketingContactListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;


procedure TMarketingContactListGUI.SendBulkEmail;
var
  List: TStringList;
  Corres: TCorrespondenceGui;
//  lSilent, lSecret : boolean;
begin
  if grdMain.SelectedList.Count = 0 then
  begin
    MessageDlgXP_Vista('No Contacts Have Been Selected In The List.'#13#10'Please Select The Contacts You Want to Send Email To',
      mtInformation, [mbOk], 0);
    exit;
  end;
  List := TStringList.Create;
  Corres := TCorrespondenceGui.Create;
  try
    GetFieldValueList('Email', List, self.qryMainID.FieldName);

    if List.Count = 0 then begin
      CommonLib.MessageDlgXP_Vista('None of the Contacts in the selected list have Email addresses.', mtInformation, [mbOk], 0);
      exit;
    end else if List.Count < grdMain.SelectedList.Count then//qryMain.RecordCount then begin
    begin
      if CommonLib.MessageDlgXP_Vista('Not all of the Prospects in the selected list have email addresses, ' +
        'only ' + IntToStr(List.Count) + ' of the ' + {IntToStr(qryMain.RecordCount) } IntToStr(grdMain.SelectedList.Count) +
        ' have an email address.'#13#10#13#10 +
        'Do you wish to continue with sending an email to the ' + IntToStr(List.Count) + ' Contacts?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        exit;
    end;

//    if not EmailSilentSecret(List.Count, false, lSilent, lSecret) then
//      exit;

    { send Email }

    Corres.CorrespondenceType := ctEmail;
    Corres.RecipientList := '[Multiple Contacts]';
    Corres.GroupRecipientList.Assign(List);
    Corres.RecipientType := rtMarketingContact;
//    Corres.Execute(lSilent, lSecret);
    Corres.Execute(false, false);

  finally
    List.Free;
    Corres.Free;
  end;
end;

procedure TMarketingContactListGUI.SendBulkSMS;
var
  List: TStringList;
  Corres: TCorrespondenceGui;
begin
  List := TStringList.Create;
  Corres := TCorrespondenceGui.Create;
  try
    GetFieldValueList('Mobile',List,self.qryMainID.FieldName);

    if List.Count = 0 then begin
      CommonLib.MessageDlgXP_Vista('None of the Contacts in the selected list have Mobile phone numbers.', mtInformation, [mbOk], 0);
      exit;
    end
    else if List.Count < grdMain.SelectedList.Count then begin
      if CommonLib.MessageDlgXP_Vista('Not all of the Contacts in the selected list have Mobile phone numbers, ' +
        'only ' + IntToStr(List.Count) + ' of the ' + IntToStr(grdMain.SelectedList.Count) + ' have mobile numbers.' + #13#10 + #13#10 +
        'Do you wish to continue with sending an SMS to the ' + IntToStr(List.Count) + ' Contacts?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        exit;
    end;
    { send SMS }

    Corres.CorrespondenceType := ctSMS;
    Corres.RecipientList := '[Multiple Contacts]';
    Corres.GroupRecipientList.Assign(List);
    Corres.RecipientType := rtMarketingContact;
    Corres.Execute();

  finally
    List.Free;
    Corres.Free;
  end;
end;

procedure TMarketingContactListGUI.SetGridColumns;
begin
  inherited;
//  RemoveFieldfromGrid('Dateentered');
  RemoveFieldfromGrid('ID');
  RemoveFieldfromGrid('LeadID');
end;

procedure TMarketingContactListGUI.grdMainDblClick(Sender: TObject);
var
  s:String;
  choice :Word;
  sc:String;
  mcchoice, pchoice,cChoice,sChoice,Cancelchoice, opt:word;
  (*function Iscutomer :Boolean;       begin result := tcDatautils.FieldBynameValue('select customer from tblclients where clientID = ' +IntToStr(QrymainclientID.asInteger)     ,'customer'     , asBoolean ) end;
  function isSupplier :Boolean;      begin result := tcDatautils.FieldBynameValue('select supplier from tblclients where clientID = ' +IntToStr(QrymainclientID.asInteger)     ,'supplier'     , asBoolean ) end;
  function ISOthercontact :Boolean;  begin result := tcDatautils.FieldBynameValue('select othercontact from tblclients where clientID = ' +IntToStr(QrymainclientID.asInteger) ,'othercontact' , asBoolean ) end;*)
begin
  try
    if Assigned(fOnGridDataSelect) then begin
      // form is being used as a lookup grid (eg ExpressProduct) so call handler then close
      //fOnGridDataSelect(grdMain);
      fOnGridDataSelect(twwDbGrid(Sender));
      if CloseOnRecSelect then CloseList;
      Exit;
    end;
  Except
    on E:Exception do begin
      closeList;
    end;
  end;


  opt:= 100;
  s:= 'Marketing Contact'; mcchoice := 100;
  SubsequentID := Chr(95) + 'MC';

  PChoice      := 0;
  CChoice      := 0;
  SChoice      := 0;
  Cancelchoice := 0;

  choice := mcchoice;
  if qryMainClientID.asInteger <> 0 then begin
      if QrymainISOthercontact.asBoolean   then begin s:= s+','+ 'Prospect'; opt:= opt+1; PChoice      := opt; end;
      if qryMainIsCustomer.asBoolean       then begin s:= s+','+ 'Customer'; opt:= opt+1; CChoice      := opt; end;
      if QrymainisSupplier.asBoolean       then begin s:= s+','+ 'Supplier'; opt:= opt+1; SChoice      := opt; end;
      sc:=s;                       s:= s+','+ 'Cancel'  ; opt:= opt+1; Cancelchoice := opt;
      sc := StringReplace(sc , ',' , ' -> ' , [rfReplaceAll]);
    choice := MessageDlgXP_Vista('Please Select the Form to Open Keeping in Mind that ' +chr(13) +
                  'a Marketing Contact Becomes a Prospect and '+chr(13) +
                  'a Prospect Becomes a Customer.' ,mtconfirmation , [] , 0 , nil , sc, '' , False , nil , s );
  end;
       if choice = mcchoice     then   SubsequentID := Chr(95) + 'MC'
  else if choice = pchoice      then   SubsequentID := Chr(95) + 'P'
  else if choice = cChoice      then   SubsequentID := Chr(95) + 'C'
  else if choice = sChoice      then   SubsequentID := Chr(95) + 'S'
  else if choice = Cancelchoice then Exit;
  inherited;
end;
Function TMarketingContactListGUI.filterbasedonSelection:String;
begin

       if grpFilters.itemindex =0 then  REsult :=  'ISCustomer     =' +quotedstr('F') + ' and ISSupplier =' +quotedstr('F') + ' and Isothercontact =' +quotedstr('F')
  else if grpFilters.itemindex =1 then  REsult :=  'Isothercontact =' +quotedstr('T') + ' and ISSupplier =' +quotedstr('F') + ' and IsCustomer =' +quotedstr('F')
  else if grpFilters.itemindex =2 then  REsult :=  'ISCustomer     =' +quotedstr('T')
  else if grpFilters.itemindex =3 then  REsult :=  'ISSupplier     =' +quotedstr('T')
  else REsult :=  '';


end;
procedure TMarketingContactListGUI.grpFiltersClick(Sender: TObject);
var
  s:String;
begin
       if grpExtrafilter.itemindex = 0 then GroupFilterString:= 'Active ="T"'
  else if grpExtrafilter.itemindex = 1 then GroupFilterString:= 'Active ="F"'
  else GroupFilterString:= '';

  s := filterbasedonSelection;

  if s <> '' then   if GroupFilterString = '' then GroupFilterString := s
  else GroupFilterString := GroupFilterString +' and ' + s;

  inherited;

end;

procedure TMarketingContactListGUI.InitQrymainparams;
begin
    qryMain.ParamByName('dtFrom').AsDate:= FilterDAteFrom;
    qryMain.ParamByName('dtTo').AsDate:= FilterDateTo;
end;

procedure TMarketingContactListGUI.MakeQry;
begin
        qryMain.SQL.Clear;
        qryMain.SQL.Add('SELECT DISTINCT');
        qryMain.SQL.Add('MC.DateEntered as DateEntered,');
        qryMain.SQL.Add('MC.GlobalRef as GlobalRef,');
        qryMain.SQL.Add('MC.ID as ID,');
        qryMain.SQL.Add('MC.clientID as clientID,');
        qryMain.SQL.Add('MC.COMPANY AS Company,');
        qryMain.SQL.Add('MC.CompanyTypeName as CompanyTypeName,');
        qryMain.SQL.Add('MC.Phone as Phone,');
        qryMain.SQL.Add('MC.Mobile as Mobile,');
        qryMain.SQL.Add('MC.STATE as STATE,');
        qryMain.SQL.Add('MC.FirstName as FirstName,');
        qryMain.SQL.Add('MC.LastName as LastName,');
        qryMain.SQL.Add('MC.SUBURB as SUBURB,');
        qryMain.SQL.Add('MC.Source as Source,');
        qryMain.SQL.Add('MC.POSTCODE as POSTCODE,');
        qryMain.SQL.Add('MC.Country as Country, ');
        qryMain.SQL.Add('MC.URL as URL, ');
        qryMain.SQL.Add('MC.Email as Email, ');
        qryMain.SQL.Add('MC.Active as Active, ');
        qryMain.SQL.Add('Max(MLL.ActionDate) as LastLeaddone, ');
        qryMain.SQL.Add('MLL.FollowupDate , ');
        qryMain.SQL.Add('MLL.LeadId as LeadId,');
        Qrymain.SQL.add('IfNull(C.Customer,"F") IsCustomer,');
        Qrymain.SQL.add('IfNull(C.supplier,"F") Issupplier,');
        Qrymain.SQL.add('IfNull(C.othercontact,"F") Isothercontact,');
        qryMain.SQL.Add('MC.DoNotContact as DoNotContact');
        qryMain.SQL.Add('FROM tblmarketingcontacts as MC');
        qryMain.SQL.Add('LEFT JOIN tblMarketingleads ML  on ML.MarketingContactID = MC.ID');
        qryMain.SQL.Add('LEFT join tblMarketingleadlines MLL on ML.LeadID = MLL.LeadID and MLL.done = "T"' );
        qryMain.SQL.Add('LEFT join tblclients C on MC.ClientID = C.ClientID');
        qryMain.SQL.Add('where (ifnull(MC.DateEntered,''1899/12/31'') BETWEEN :dtFrom and :dtTo )');

//        if chkIgnoreDates.checked = False then qryMain.SQL.Add('AND ((ifnull(MC.DateEntered,0) BETWEEN ' + QuotedStr(FormatDatetime(MysqlDateFormat , dtFrom.DateTime)) +  ' AND ' + QuotedStr(FormatDatetime(MysqlDateFormat , dtTo.DateTime)) + '))');
        if ExcludeMCwithLead then Qrymain.SQL.add('And ifnull(ML.LeadID,0) =0');
        if chkAll.Checked then begin
          //qryMain.SQL.Add('Group by MC.GlobalRef');
        end else if cboListSelection.Text <> '' then begin
            XML.Text := qrySelectionList.FieldByName('XMLData').AsString;
            if XML.Text <> '' then begin
              if XML.Node['SQLSelect'].Attribute['SQL'].AsString <> '' then
                qryMain.SQL.Add('AND (' + ReplaceStr(XML.Node['SQLSelect'].Attribute['SQL'].AsString, 'tblmarketingcontacts.' , 'MC.') + ')');
            end;
            //qryMain.SQL.Add('Group by MC.GlobalRef');
        end else if (cboListSelection.Text = '') and not (chkAll.Checked) then begin
          //qryMain.SQL.Add('Group by MC.GlobalRef');
        end else begin
          //qryMain.SQL.Add('Group by MC.GlobalRef');
        end;
        qryMain.SQL.Add('Group by MC.GlobalRef');
        qryMain.SQL.Add('order by MC.COMPANY');
        if not ExcludeMCwithLead then
          if (not chkAll.Checked) and (cboListSelection.Text = '') then
            qryMain.SQL.Add('LIMIT 0;');
  RefreshOrignalSQL;
end;

procedure TMarketingContactListGUI.PopulateFilterCombo;
begin
  if grdMain.FieldCount > 0 then
    inherited;
end;

initialization
  RegisterClassOnce(TMarketingContactListGUI);
end.


