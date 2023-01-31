unit frmMailMergeFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls,
  wwclearbuttongroup, wwradiogroup, Shader, DNMPanel, DNMSpeedButton,
  wwcheckbox, MemDS, wwdblook, Mask, wwdbedit, Wwdotdot, DBCtrls,MailMergePrintReportObj,
  ppComm, ppRelatv, ppProd, ppClass, ppReport, ImgList,IntegerListObj, Grids,
  Wwdbigrd, Wwdbgrid, ProgressDialog;


type

  TGroupRec = class(TObject)
  private
  public
    sGroup: string;
    sSend: Boolean;
    sTemplateName: string;
  end;



type
  TfrmMailMerge = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlmain: TDNMPanel;
    qryCustomersTemplates: TERPQuery;
    cmdClose: TDNMSpeedButton;
    btnSend: TDNMSpeedButton;
    qryCustomersTemplatesTemplID: TIntegerField;
    qryCustomersTemplatesTemplName: TWideStringField;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Bevel1: TBevel;
    DNMPanel2: TDNMPanel;
    rgSendMode: TwwRadioGroup;
    edSubject: TwwDBEdit;
    Label11: TLabel;
    lblemail: TLabel;
    qrySuppliersTemplates: TERPQuery;
    qryEmployeesTemplates: TERPQuery;
    qryOtherContactsTemplates: TERPQuery;
    qryLoyaltyTemplates: TERPQuery;
    qryMarketingTemplates: TERPQuery;
    btnSetupHost: TDNMSpeedButton;
    DSMMHost: TDataSource;
    qryMMHost: TERPQuery;
    QryShipingcontainerMailMerge: TERPQuery;
    pnlCustomerList: TDNMPanel;
    Label1: TLabel;
    chkCustomer: TwwCheckBox;
    cboCustomerList: TComboBox;
    btnCustomerList: TDNMSpeedButton;
    cboCustomerTemplate: TwwDBLookupCombo;
    pnlshippingcontainer: TDNMPanel;
    Label8: TLabel;
    chkshippingcontainer: TwwCheckBox;
    cboshippingcontainer: TComboBox;
    btnshippingcontainer: TDNMSpeedButton;
    cboShippingcontainerTemplate: TwwDBLookupCombo;
    pnlMarketingList: TDNMPanel;
    Label6: TLabel;
    chkMarketing: TwwCheckBox;
    cboMarketingList: TComboBox;
    btnMarketingList: TDNMSpeedButton;
    cboMarketingTemplate: TwwDBLookupCombo;
    pnlLoyaltyList: TDNMPanel;
    Label5: TLabel;
    chkLoyalty: TwwCheckBox;
    cboLoyaltyList: TComboBox;
    btnLoyaltyList: TDNMSpeedButton;
    cboLoyaltyTemplate: TwwDBLookupCombo;
    pnlOtherContactsList: TDNMPanel;
    Label4: TLabel;
    chkOtherContacts: TwwCheckBox;
    cboOtherContactsList: TComboBox;
    btnOtherContactsList: TDNMSpeedButton;
    cboOtherTemplate: TwwDBLookupCombo;
    pnlEmployeesList: TDNMPanel;
    Label3: TLabel;
    chkEmployees: TwwCheckBox;
    cboEmployeesList: TComboBox;
    btnEmployeesList: TDNMSpeedButton;
    cboEmployeesTemplate: TwwDBLookupCombo;
    pnlSuppliersList: TDNMPanel;
    Label2: TLabel;
    chkSuppliers: TwwCheckBox;
    cboSuppliersList: TComboBox;
    btnSuppliersList: TDNMSpeedButton;
    cboSuppliersTemplate: TwwDBLookupCombo;
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction); 
    procedure btnSendClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);  
    procedure rgSendModeChange(Sender: TObject);
    procedure cboCustomerListDropDown(Sender: TObject);
    procedure cboCustomerListChange(Sender: TObject);
    procedure cboSuppliersListDropDown(Sender: TObject);
    procedure cboEmployeesListDropDown(Sender: TObject);
    procedure cboOtherContactsListDropDown(Sender: TObject);
    procedure cboLoyaltyListDropDown(Sender: TObject);
    procedure cboMarketingListDropDown(Sender: TObject);
    procedure cboSuppliersListChange(Sender: TObject);
    procedure cboEmployeesListChange(Sender: TObject);
    procedure cboOtherContactsListChange(Sender: TObject);
    procedure cboLoyaltyListChange(Sender: TObject);
    procedure cboMarketingListChange(Sender: TObject);
    procedure chkCustomerClick(Sender: TObject);
    procedure btnSetupHostClick(Sender: TObject);
    procedure cboshippingcontainerChange(Sender: TObject);
  private      
    fModifiedStr:string;
    fMMPrintReport:TMailMergePrintReport;
    procedure LoadIDList(const sGroup:string;const ListClassName:String);
    procedure LoadGroupList;
    procedure OpenFilter(const sGroup:string);
    procedure ClearNotSendsOnForm;
    function DoMessageEvent(const Sender: TMailMergePrintReport; const EventType, Value: string):Boolean;
    Procedure LoadclientIDsoftype(grd:TwwDBGrid;IdList:TIntegerList);
  public
    { Public declarations }
  end;

implementation
uses
  CommonLib,BaseListingForm,frmMailMergeHost,tcDataUtils,
  MemoDialog, FastFuncs, CommonDbLib;

var
  SendDialog: TProgressDialog;  
{$R *.dfm}


procedure TfrmMailMerge.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    OpenQueries;
    fMMPrintReport.OnMessageChange := DoMessageEvent;
  finally
    EnableForm;
  end;  
end;

procedure TfrmMailMerge.cmdCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmMailMerge.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(fMMPrintReport) then FreeAndNil(fMMPrintReport);
  Action := caFree;
end;     

procedure TfrmMailMerge.LoadclientIDsoftype(grd: TwwDBGrid;IdList: TIntegerList);
var
    s:String;
begin
  SelectedIds(grd , 'ClientTypeID' , IdList , true);
  s:= IdList.commatext;
  IDlist.clear;
  if s='' then exit;
  With TERPQuery(TempMyQuery) do try
    SQL.add('Select ClientId from tblClients where ClientTypeID in (' + s+')');
    open;
    s:= Groupconcat('ClientId');
    IDList.commatext := s;
  finally
    ClosenFree;
  end;
end;

procedure TfrmMailMerge.LoadGroupList;
var
  GroupRec: TGroupRec;
begin
  //empty list
  while fMMPrintReport.GroupRecList.Count > 0 do begin
    TGroupRec(fMMPrintReport.GroupRecList[0]).Free;
    fMMPrintReport.GroupRecList.Delete(0);
  end;

      GroupRec := TGroupRec.Create;
      GroupRec.sGroup := 'Customers';
      GroupRec.sSend  := chkCustomer.Checked;
      GroupRec.sTemplateName := cboCustomerTemplate.Text;
      fMMPrintReport.GroupRecList.Add(GroupRec);

      GroupRec := TGroupRec.Create;
      GroupRec.sGroup := 'Suppliers';
      GroupRec.sSend  := chkSuppliers.Checked;
      GroupRec.sTemplateName := cboSuppliersTemplate.Text;
      fMMPrintReport.GroupRecList.Add(GroupRec);

      GroupRec := TGroupRec.Create;
      GroupRec.sGroup := 'Employees';
      GroupRec.sSend  := chkEmployees.Checked;
      GroupRec.sTemplateName := cboEmployeesTemplate.Text;
      fMMPrintReport.GroupRecList.Add(GroupRec);

      GroupRec := TGroupRec.Create;
      GroupRec.sGroup := 'OtherContacts';
      GroupRec.sSend  := chkOtherContacts.Checked;
      GroupRec.sTemplateName := cboOtherTemplate.Text;
      fMMPrintReport.GroupRecList.Add(GroupRec);

      GroupRec := TGroupRec.Create;
      GroupRec.sGroup := 'Loyalty';
      GroupRec.sSend  := chkLoyalty.Checked;
      GroupRec.sTemplateName := cboLoyaltyTemplate.Text;
      fMMPrintReport.GroupRecList.Add(GroupRec);

      GroupRec := TGroupRec.Create;
      GroupRec.sGroup := 'Marketing';
      GroupRec.sSend  := chkMarketing.Checked;
      GroupRec.sTemplateName := cboMarketingTemplate.Text;
      fMMPrintReport.GroupRecList.Add(GroupRec);

      GroupRec := TGroupRec.Create;
      GroupRec.sGroup := 'ShippingContainer';
      GroupRec.sSend  := chkshippingcontainer.Checked;
      GroupRec.sTemplateName := cboShippingcontainerTemplate.Text;
      fMMPrintReport.GroupRecList.Add(GroupRec);
end;

procedure TfrmMailMerge.ClearNotSendsOnForm;
begin
  if not chkCustomer.Checked then begin
    cboCustomerList.ItemIndex := -1;
    cboCustomerTemplate.Text := '';
  end;
  if not chkSuppliers.Checked then begin
    cboSuppliersList.ItemIndex := -1;
    cboSuppliersTemplate.Text := '';
  end;
  if not chkEmployees.Checked then begin
    cboEmployeesList.ItemIndex := -1;
    cboEmployeesTemplate.Text := '';
  end;
  if not chkOtherContacts.Checked then begin
    cboOtherContactsList.ItemIndex := -1;
    cboOtherTemplate.Text := '';
  end;
  if not chkLoyalty.Checked then begin
    cboLoyaltyList.ItemIndex := -1;
    cboLoyaltyTemplate.Text := '';
  end;
  if not chkMarketing.Checked then begin
    cboMarketingList.ItemIndex := -1;
    cboMarketingTemplate.Text := '';
  end;
end;

procedure TfrmMailMerge.btnSendClick(Sender: TObject);
var
  sMode:String;
begin
  DisableForm;
  try
    Processingcursor(True);
    try
      ClearNotSendsOnForm;
      LoadGroupList;

      case rgSendMode.ItemIndex of
        0 : begin
              sMode := 'Sending emails.';
              fMMPrintReport.SendMode := 'email';
              if not tcDataUtils.HasMailMergeHostDetails then begin
                CommonLib.MessageDlgXP_Vista('Host details are not complete.' , mtInformation, [mbOK], 0);
                exit;
              end;
            end;
        1 : begin
              fMMPrintReport.SendMode := 'print';
              sMode := 'Sending to Printer.';
            end;
        2 : begin
              fMMPrintReport.SendMode := 'file';
              sMode := 'Saving files.';
            end;
        3 : begin
              fMMPrintReport.SendMode := 'fax';
              sMode := 'Sending faxes.';
            end;
       end;
       SendDialog.Caption := sMode;
       SendDialog.MaxValue := fMMPrintReport.MaxItemsToSend;
       SendDialog.Step := 1;
       SendDialog.Execute;

       fMMPrintReport.subject := edSubject.Text;
       if not fMMPrintReport.Execute then exit;
       Processingcursor(False);

       MemoDialog.DoMemoDialog('Mail Merge',
         'Mail Merge Completed. ' + IntToStr(fMMPrintReport.documentsprocessed) +
         ' documents processed.' +chr(13) + chr(13) +
         fMMPrintReport.StatusDescription);
       if fMMPrintReport.documentsprocessed > 0 then close;
     finally
       Processingcursor(False);
       SendDialog.CloseDialog;
     end;
  finally
    EnableForm;
  end;   
end;

procedure TfrmMailMerge.FormCreate(Sender: TObject);
begin
  inherited;
  fMMPrintReport := TMailMergePrintReport.Create;
  fMMPrintReport.Connection := MyConnection;
  SendDialog := TProgressDialog.Create(Self);


  qryCustomersTemplates.ParamByName('typeName').asString := 'Customers Mail Merge';
  qrySuppliersTemplates.ParamByName('typeName').asString :=  'Suppliers Mail Merge';
  qryEmployeesTemplates.ParamByName('typeName').asString := 'Employees Mail Merge';
  qryOtherContactsTemplates.ParamByName('typeName').asString := 'Other Contacts Mail Merge';
  qryLoyaltyTemplates.ParamByName('typeName').asString := 'Loyalty Mail Merge';
  qryMarketingTemplates.ParamByName('typeName').asString := 'Marketing Mail Merge';
  QryShipingcontainerMailMerge.ParamByName('typeName').asString := 'Shipping Container Mail Merge';
end;


procedure TfrmMailMerge.LoadIDList(const sGroup:string;const ListClassName:String);
var
  frm:TComponent;
  IDList :TIntegerList;
begin
  if FormStillOpen(ListClassName) then begin
    TForm(FindExistingComponent(ListClassName)).Close;
    Application.ProcessMessages;
  end;
  //CommonLib.MessageDlgXP_Vista('Please Select The Record(s) to Print The Report.  Multiple Records Can Be Selected In The List.' , mtInformation , [mbok] , 0);
  frm := GetComponentByClassName(ListClassName ,True);
  if Assigned(frm) then begin
    try
      with TBaseListingGUI(frm) do begin
        //grdMain.ReadOnly := False;
        grdMain.Enabled  := True;
        EnableMultiSelect('Please Select The Record(s) to Print The Report.  Multiple Records Can Be Selected In The List.');
        showcontrolhint(cmdClose, 'Choose to Cancel the Selection');
        showcontrolhint(cmdPrint, 'Choose to Select the Selection');
        cmdClose.modalresult :=  mrCancel;
        cmdPrint.onclick := nil;
        cmdPrint.modalresult :=  mrOK;
        cmdPrint.Caption := 'Select';
        HighlightControl(cmdPrint);
        HighlightextraControl1(cmdClose);
        ListTimerMsg('Please Select The Record(s) to Print The Report.  Multiple Records Can Be Selected In The List.');
        if ShowModal = mrok then begin
                   if sGroup = 'Customers'          then IDList := fMMPrintReport.CustomersIDList
              else if sGroup = 'Suppliers'          then IDList := fMMPrintReport.SuppliersIDList
              else if sGroup = 'Employees'          then IDList := fMMPrintReport.EmployeesIDList
              else if sGroup = 'OtherContacts'      then IDList := fMMPrintReport.OtherContactsIDList
              else if sGroup = 'Loyalty'            then IDList := fMMPrintReport.LoyaltyIDList
              else if sGroup = 'Marketing'          then IDList := fMMPrintReport.MarketingIDList
              else if sGroup = 'Shippingcontainer'  then IDList := fMMPrintReport.ShippingIDList;

            if not qryMain.Active then exit;
                   if sGroup = 'Customers'          then Commonlib.SelectedIDs(grdmain,'ClientId'     ,IdList, true)
              else if sGroup = 'Suppliers'          then Commonlib.SelectedIDs(grdmain,'ClientId'     ,IdList, true)
              else if sGroup = 'Employees'          then Commonlib.SelectedIDs(grdmain,'employeeID'   ,IdList, true)
              else if sGroup = 'OtherContacts'      then Commonlib.SelectedIDs(grdmain,'ClientId'     ,IdList, true)
              else if sGroup = 'Loyalty'            then (*SelectedIDs(grdmain,'ClientId'     ,IdList, true)*)LoadclientIDsoftype(grdmain,IdList)
              else if sGroup = 'Marketing'          then Commonlib.SelectedIDs(grdmain,'Id'           ,IdList, true)
              else if sGroup = 'Shippingcontainer'  then Commonlib.SelectedIDs(grdmain,'CustomerJobId',IdList, true);
        end;
      end;
    finally
      Freeandnil(frm);
    end;
  end;
end;

procedure TfrmMailMerge.OpenFilter(const sGroup:string);
var
  cbo: TComboBox;
begin
  Processingcursor(True);
  try
    if sGroup = 'Customers' then begin
      fMMPrintReport.CustomersIDList.Clear;
      cbo:= cboCustomerList;
    end else if sGroup = 'Suppliers' then begin
      fMMPrintReport.SuppliersIDList.Clear;
      cbo:= cboSuppliersList;
    end else if sGroup = 'Employees' then begin
      fMMPrintReport.EmployeesIDList.Clear;
      cbo:= cboEmployeesList ;
    end else if sGroup = 'OtherContacts' then begin
      fMMPrintReport.OtherContactsIDList.Clear;
      cbo:= cboOtherContactsList;
    end else if sGroup = 'Loyalty' then begin
      fMMPrintReport.LoyaltyIDList.Clear;
      cbo:= cboLoyaltyList;
    end else if sGroup = 'Marketing' then begin
      fMMPrintReport.MarketingIDList.clear;
      cbo:= cboMarketingList;
    end else if sGroup = 'ShippingContainer' then begin
      fMMPrintReport.ShippingIDList.Clear;
      cbo:= cboshippingcontainer;
    end else exit;
         if (SameText(Sgroup , 'Customers'))        and  SameText(cbo.Text , 'Customer List'          )then LoadIDList('Customers','TCustomerListGUI')
    else if (SameText(Sgroup , 'Customers'))        and  SameText(cbo.Text , 'Customer Details List'  )then LoadIDList('Customers','TCustomerDetailsListGUI')
    else if (SameText(Sgroup , 'Customers'))        and  SameText(cbo.Text , 'Back Order List'        )then LoadIDList('Customers','TBackOrdersListGUI')
    else if (SameText(Sgroup , 'Suppliers'))        and  SameText(cbo.Text , 'Suppliers List'         )then LoadIDList('Suppliers','TSupplierListGUI')
    else if (SameText(Sgroup , 'Suppliers'))        and  SameText(cbo.Text , 'Purchase Order List'    )then LoadIDList('Suppliers','TSupplierListGUI')
    else if (SameText(Sgroup , 'Suppliers'))        and  SameText(cbo.Text , 'Bill List'              )then LoadIDList('Suppliers','TBillListGUI')
    else if (SameText(Sgroup , 'Employees'))        and  SameText(cbo.Text , 'Employees List'         )then LoadIDList('Employees','TfrmEmployeeList')
    else if (SameText(Sgroup , 'Employees'))        and  SameText(cbo.Text , 'Rep List'               )then LoadIDList('Employees','TRepListGUI')
    else if (SameText(Sgroup , 'Employees'))        and  SameText(cbo.Text , 'To Do List'             )then LoadIDList('Employees','TToDoListGUI')
    else if (SameText(Sgroup , 'OtherContacts'))    and  SameText(cbo.Text , 'Other Contacts List'    )then LoadIDList('OtherContacts','TfrmOthersList')
    else if (SameText(Sgroup , 'OtherContacts'))    and  SameText(cbo.Text , 'Appointments List'      )then LoadIDList('OtherContacts','TAppointmentListGUI')
    else if (SameText(Sgroup , 'Loyalty'))          and  SameText(cbo.Text , 'Loyalty List'           )then LoadIDList('Loyalty','TProductRewardPointsGUI')
    else if (SameText(Sgroup , 'Loyalty'))          and  SameText(cbo.Text , 'Customer List'          )then LoadIDList('Customers','TCustomerListGUI')
    else if (SameText(Sgroup , 'Loyalty'))          and  SameText(cbo.Text , 'Sales Order List'       )then LoadIDList('Sales Order List','TSalesOrderListGUI')
    else if (SameText(Sgroup , 'Marketing'))        and  SameText(cbo.Text , 'Marketing List'         )then LoadIDList('Marketing','TMarketingContactGUI')
    else if (SameText(Sgroup , 'Marketing'))        and  SameText(cbo.Text , 'Marketing Leads List'   )then LoadIDList('Marketing','TMarketingLeadsGUI')
    else if (SameText(Sgroup , 'Marketing'))        and  SameText(cbo.Text , 'Telemarketing List'     )then LoadIDList('Marketing','TMarketingGUI')
    else if (SameText(Sgroup , 'ShippingContainer'))and  SameText(cbo.Text , 'Shipping Container list')then LoadIDList('Shippingcontainer','TShippingContainerListDetailsGUI');
  finally
    Processingcursor(False);
  end;
end;



procedure TfrmMailMerge.rgSendModeChange(Sender: TObject);
begin
  inherited;
  case rgSendMode.ItemIndex of
    0: begin
         fMMPrintReport.SendMode := 'Email';
       //  edSubject.Visible := true;
       //  lblemail.Visible  := true;
       end;
    1: begin
         fMMPrintReport.SendMode := 'Print';
       //  edSubject.Visible := false;
       //  lblemail.Visible  := false;
       end;
    2: begin
         fMMPrintReport.SendMode := 'File';
       //  edSubject.Visible := false;
        // lblemail.Visible  := false;
       end;
    3: begin
         fMMPrintReport.SendMode := 'Fax';
       //  edSubject.Visible := false;
        // lblemail.Visible  := false;
       end;
  end;
end;

procedure TfrmMailMerge.cboCustomerListDropDown(Sender: TObject);
begin
  inherited;
  fModifiedStr := cboCustomerList.Text;
end;


procedure TfrmMailMerge.cboSuppliersListDropDown(Sender: TObject);
begin
  inherited;
  fModifiedStr := cboSuppliersList.Text;
end;

procedure TfrmMailMerge.cboEmployeesListDropDown(Sender: TObject);
begin
  inherited;
  fModifiedStr := cboEmployeesList.Text;
end;

procedure TfrmMailMerge.cboOtherContactsListDropDown(Sender: TObject);
begin
  inherited;
  fModifiedStr := cboOtherContactsList.Text;
end;

procedure TfrmMailMerge.cboLoyaltyListDropDown(Sender: TObject);
begin
  inherited;
  fModifiedStr := cboLoyaltyList.Text;
end;

procedure TfrmMailMerge.cboMarketingListDropDown(Sender: TObject);
begin
  inherited;
  fModifiedStr := cboMarketingList.Text;
end;


procedure TfrmMailMerge.chkCustomerClick(Sender: TObject);
begin
  inherited;
  if not TwwCheckBox(Sender).Checked then ClearNotSendsOnForm;
end;

Function TfrmMailMerge.DoMessageEvent(const Sender: TMailMergePrintReport; const EventType, Value: string):boolean;
begin
  Result := False; //Result only used on 'MissingEAddress' for Abort send.
  if EventType = 'StepProgress' then SendDialog.StepIt;

  if EventType = 'MissingSubject' then begin
    SetControlFocus(edSubject);
    CommonLib.MessageDlgXP_Vista(Value, mtWarning , [mbOK], 0);
  end else if EventType = 'MissingEAddress' then begin
    if CommonLib.MessageDlgXP_Vista('Some email addresses are missing. Ignore will skip these. ' + Value, mtWarning, [mbAbort,mbIgnore], 0) = 100 then begin  //MessageDlgXP_Vista bug: returns 100 instead of mrAbort
      Result := True;
    end;
  end;
end;   


procedure TfrmMailMerge.btnSetupHostClick(Sender: TObject);
var
  frm:TComponent;
begin
  DisableForm;
  try
    inherited;
    frm := GetComponentByClassName('TfrmMMHostSetup');
    if not Assigned(frm) then Exit;
    with TfrmMMHostSetup(frm) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmMailMerge.cboshippingcontainerChange(Sender: TObject); begin   inherited;   if fModifiedStr <> cboshippingcontainer.Text  then OpenFilter('ShippingContainer'); end;
procedure TfrmMailMerge.cboCustomerListChange     (Sender: TObject); begin   inherited;   if fModifiedStr <> cboCustomerList.Text       then OpenFilter('Customers');         end;
procedure TfrmMailMerge.cboSuppliersListChange    (Sender: TObject); begin   inherited;   if fModifiedStr <> cboSuppliersList.Text      then OpenFilter('Suppliers');         end;
procedure TfrmMailMerge.cboEmployeesListChange    (Sender: TObject); begin   inherited;   if fModifiedStr <> cboEmployeesList.Text      then OpenFilter('Employees');         end;
procedure TfrmMailMerge.cboOtherContactsListChange(Sender: TObject); begin   inherited;   if fModifiedStr <> cboOtherContactsList.Text  then OpenFilter('OtherContacts');     end;
procedure TfrmMailMerge.cboLoyaltyListChange      (Sender: TObject); begin   inherited;   if fModifiedStr <> cboLoyaltyList.Text        then OpenFilter('Loyalty');           end;
procedure TfrmMailMerge.cboMarketingListChange    (Sender: TObject); begin   inherited;   if fModifiedStr <> cboMarketingList.Text      then OpenFilter('Marketing');         end;

initialization
  RegisterClassOnce(TfrmMailMerge);
end.
