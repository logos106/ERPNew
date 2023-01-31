unit frmRepFrm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 27/05/05  1.00.01 BJ   NotinList of the employee displays a message and cancels
                        the data already entered. The option to create a new
                        employee from here is being cancelled.
 03/06/05  1.00.02 BJ   The active page is initialised in form create as the
                        form can be called with a different page . eg: when
                        called from the appointment, it should have the rateinfo
 01/09/05  1.00.03 IJB  Changed on exit event for rate grid to prevent attempted
                        posting of blank rows.
 19/10/05  1.00.04 DLS  Added RegisterClass
 08/12/05  1.00.05 MV   Fixed Task Tracker Issue 299 Refres Screen.
 12/12/05  1.00.06 MV   Fixed Task Tracker Issue 300 issue where no service is
                        available when ability has not been specified.  Fixed Issie
                        with Assignment error and new methods implemented for
                        registering modules.
 01/02/07  1.00.07 DSP  Added cboEmployeeType.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Mask, DBCtrls, ExtCtrls, DBCGrids, ComCtrls,AdvOfficeStatusBar,
  BaseInputForm, wwdblook, BaseListingForm, MessageInterface,
  Grids, Wwdbigrd, Wwdbgrid, DNMPanel, Buttons, DNMSpeedButton, kbmMemTable, wwdbedit,
  SelectionDialog, AppEvnts, DBAccess, MyAccess,ERPdbComponents, DataState, MyScript, Menus, AdvMenus,
  MemDS, Shader, ImgList, ProgressDialog;

type
  TfrmRep = class(TBaseInputGUI)
    cboRepNameSrc: TDataSource;
    TabCtl20: TPageControl;
    Rep_Info: TTabSheet;
    Address_Info: TTabSheet;
    Rate_Info: TTabSheet;
    srcTrainerRates: TDataSource;
    History: TTabSheet;
    subfrmTrainerHistorySrc: TDataSource;
    chkActive: TDBCheckBox;
    Label36: TLabel;
    cmdNew: TDNMSpeedButton;
    cmdNotes: TDNMSpeedButton;
    txtTrainerID: TDBEdit;
    txtTrainercode: TDBEdit;
    Label133: TLabel;
    EmployeeSrc: TDataSource;
    EmpID: TDBEdit;
    qryRep: TERPQuery;
    qryTrainerRates: TERPQuery;
    qryTrainerHistory: TERPQuery;      
    qryEmployee: TERPQuery;
    qrycboServices: TERPQuery;
    qrycboAbility: TERPQuery;
    cboRepName: TwwDBLookupCombo;
    dsqrycboServices: TDataSource;
    dsqrycboAbility: TDataSource;
    qryTrainerRatesTrainRateID: TAutoIncField;
    qryTrainerRatesRate: TFloatField;
    qryTrainerRatesPayRate: TFloatField;
    qryTrainerRatesEmployeeID: TIntegerField;
    qryTrainerRatesServiceID: TIntegerField;
    qryTrainerRatesAbilityID: TIntegerField;
    DNMPanel1: TDNMPanel;
    Box72: TBevel;
    Box70: TBevel;
    Box69: TBevel;
    Label25: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label31: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label59: TLabel;
    edtNotes: TDBMemo;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DNMPanel2: TDNMPanel;
    Box76: TBevel;
    Box71: TBevel;
    Label65: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label135: TLabel;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit17: TDBEdit;
    DNMPanel3: TDNMPanel;
    Trainerratessubform_Label: TLabel;
    pnlHistory: TDNMPanel;
    DNMPanel5: TDNMPanel;
    grpHistory: TRadioGroup;
    grdRateInfo: TwwDBGrid;
    btnDetailDelete: TwwIButton;
    qryTrainerRatesServiceName: TWideStringField;
    cboService: TwwDBLookupCombo;
    memqryTrainerRates: TkbmMemTable;
    qryTrainerRatesEditedFlag: TWideStringField;
    qryEmployeeCompany: TWideStringField;
    qryEmployeeEmployeeID: TAutoIncField;
    qryEmployeeTitle: TWideStringField;
    qryEmployeeFirstName: TWideStringField;
    qryEmployeeLastName: TWideStringField;
    qryEmployeePhone: TWideStringField;
    qryEmployeeFaxNumber: TWideStringField;
    qryEmployeeMobile: TWideStringField;
    qryEmployeeAltContact: TWideStringField;
    qryEmployeeNotes: TWideMemoField;
    qryEmployeeStreet: TWideStringField;
    qryEmployeeStreet2: TWideStringField;
    qryEmployeeSuburb: TWideStringField;
    qryEmployeePostcode: TWideStringField;
    qryEmployeeState: TWideStringField;
    qryEmployeeABN: TWideStringField;
    qryEmployeeEmail: TWideStringField;
    qryEmployeeEmployeeName: TWideStringField;
    qryEmployeeRep: TWideStringField;
    memqryEmployee: TkbmMemTable;
    qryEmployeeEditedFlag: TWideStringField;
    cmdOk: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    qryTrainerRatesClientID: TIntegerField;
    qryClients: TERPQuery;
    cboCompany: TwwDBLookupCombo;
    qryTrainerRatesChargeToLookup: TWideStringField;
    Label1: TLabel;
    edtAreas: TwwDBEdit;
    Bevel1: TBevel;
    qryEmployeeAreaRange: TWideStringField;
    btnAddDateTime: TDNMSpeedButton;
    qryEmployeeEmployeeTypeID: TIntegerField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    lblAddress3: TLabel;
    txtAddress3: TDBEdit;
    lblCountry: TLabel;
    txtCountry: TDBEdit;
    qryEmployeeStreet3: TWideStringField;
    qryEmployeeCountry: TWideStringField;
    qryTrainerRatesAbilityDesc: TWideStringField;
    cboAbility: TwwDBLookupCombo;
    procedure cmdNotesClick(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RefreshQueries;
    procedure cboRepNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure TabCtl20Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure qryTrainerRatesServiceIDChange(Sender: TField);
    procedure btnDetailDeleteClick(Sender: TObject);
    procedure cboServiceNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure qryTrainerRatesAfterOpen(DataSet: TDataSet);
    procedure qryEmployeeAfterOpen(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure grdRateInfoExit(Sender: TObject);
    procedure btnAddDateTimeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboRepNameNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cboEmployeeTypeNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: string; var Accept: Boolean);

  private
    fMsgHandler: TMsgHandler;
    ffrmList: TBaseListingGUI;
    fbSaveClicked: boolean;
    sNewService: string;
    fbFromAppNoServices: boolean;
    procedure NotifyAppointmentGUI;
    function ValidateRates: boolean;
  public
    
    property FromAppNoServices: boolean read fbFromAppNoServices write fbFromAppNoServices;
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); override;
  published
    function LoadFromAppNoServices(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
  end;

implementation

{$R *.DFM}

uses
  CommonDbLib, FormFactory, DNMLib,
  frmRepServicesFrm,  DNMExceptions, CommonLib,
  AppEnvironment, FastFuncs, IntegerListObj;

procedure TfrmRep.RefreshQueries;
begin
  try
    CloseQueries;
    qryTrainerRates.ParamByName('RepID').asInteger := KeyID;
    qryTrainerHistory.ParamByName('RepID').asInteger := KeyID;
    qryEmployee.ParamByName('EmpID').asInteger     := KeyID;
    OpenQueries;
    cboRepName.Text := qryEmployee.FieldByName('EmployeeName').AsString;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
end; 

procedure TfrmRep.cboRepNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  cboRepName.Enabled := false;
  KeyID := qryRep.FieldByName('EmployeeID').asInteger;
  RefreshQueries;
  qryEmployee.Edit;
  //qryTrainerRates.Edit;
  qryEmployee.FieldByName('Rep').AsString := 'T';
end;

procedure TfrmRep.cmdNotesClick(Sender: TObject);
begin
  TabCtl20.ActivePageIndex := 0;
  SetControlFocus(edtNotes);
end;

procedure TfrmRep.cmdOkClick(Sender: TObject);
begin
  DisableForm;
  try
    if cboRepName.Text = '' then begin
      CommonLib.MessageDlgXP_Vista('Representative name cannot be empty!', mtInformation, [mbOK], 0);
      Exit;
    end;

    if not self.ValidateRates then begin
      if TabCtl20.ActivePage <> Rate_Info then
        TabCtl20.ActivePage:= Rate_Info;
      CommonLib.MessageDlgXP_Vista('A Service Type can only be used once per Representative!', mtInformation, [mbOK], 0);
      exit;
    end;

   // DBEdit5.Text := DBEdit5.EditText;
  //  DBEdit6.Text := DBEdit6.EditText;
  //  DBEdit7.Text := DBEdit7.EditText;
  //  DBEdit8.Text := DBEdit8.EditText;

    try
      if qryEmployee.State <> dsBrowse then begin
        qryEmployee.Post;
        Notify;
      end;

      ProcessEditedFlag('Rate Lines', Self, memqryTrainerRates, qryTrainerRates, nil);
      qryTrainerRates.Edit;
      if qryTrainerRates.RecordCount > 0 then qryTrainerRates.Post;

      ProcessEditedFlag('Main', Self, memqryEmployee, qryEmployee, nil);
      qryEmployee.Edit;
      qryEmployee.Post;


      //       If (qryTrainerRates.RecordCount=0 ) then Begin
      //        qryTrainerRates.Edit;
      //        qrycboServices.Locate('ServiceDesc', 'Misc', [loCaseInsensitive, loPartialKey]);
      //        qryTrainerRatesServiceID.AsInteger  := qrycboServices.FieldByName('ServiceID').AsInteger;
      //        qrycboAbility.Locate('AbilityDesc', 'Excellent', [loCaseInsensitive, loPartialKey]);
      //        qryTrainerRatesAbilityID.AsInteger  := qrycboAbility.FieldByName('AbilityID').AsInteger;
      //        qryTrainerRatesEmployeeID.AsInteger  := KeyID;
      //        qryTrainerRatesRate.AsCurrency  := 0;
      //        qryTrainerRatesPayRate.AsCurrency  := 0;
      //        qryTrainerRates.Post;
      //       End;

      CommitTransaction;
      fbSaveClicked := true;
      if fbFromAppNoServices then
        NotifyAppointmentGUI;

      Self.Close;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmRep.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    try
      if qryEmployee.State <> dsBrowse then begin
        qryEmployee.Post;
      end;

      ProcessEditedFlag('Rate Lines', Self, memqryTrainerRates, qryTrainerRates, nil);
      qryTrainerRates.Edit;
      if qryTrainerRates.RecordCount > 0 then qryTrainerRates.Post;


      if (qryTrainerRates.RecordCount = 0) then begin
        qryTrainerRates.Edit;
        qrycboServices.Locate('ServiceDesc', 'Misc', [loCaseInsensitive, loPartialKey]);
        qryTrainerRatesServiceID.AsInteger := qrycboServices.FieldByName('ServiceID').AsInteger;
        qrycboAbility.Locate('AbilityDesc', 'Excellent', [loCaseInsensitive, loPartialKey]);
        qryTrainerRatesAbilityID.AsInteger := qrycboAbility.FieldByName('AbilityID').AsInteger;
        qryTrainerRatesEmployeeID.AsInteger := KeyID;
        qryTrainerRatesRate.AsCurrency := 0;
        qryTrainerRatesPayRate.AsCurrency := 0;
        qryTrainerRates.Post;
      end;

      CommitTransaction;
      KeyID := 0;
      RefreshQueries;
      cboRepName.Enabled := true;
      FormShow(nil);

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmRep.cmdCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmRep.FormShow(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    try
      inherited;
      if qryEmployee.Active then begin
        if qryEmployee.State <> dsBrowse then begin
          qryEmployee.Post;
        end;
        Notify;
        CloseQueries;
      end;

      BeginTransaction;

      fbSaveClicked := false;

      qryTrainerRates.ParamByName('RepID').asInteger := KeyID;
      qryTrainerHistory.ParamByName('RepID').asInteger := KeyID;
      qryEmployee.ParamByName('EmpID').asInteger     := KeyID;
      OpenQueries;
      EditNoAbort(qryEmployee);

      if KeyID <> 0 then begin
        cboRepName.Text := qryEmployee.FieldByName('EmployeeName').AsString;
        cboRepName.Enabled := false;
      end else begin
        cboRepName.Enabled := true;
      end;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
    Form := GetComponentByClassName('TfrmRep');
    if Assigned(Form) then begin //if has acess
      if FromAppNoServices then TabCtl20.ActivePage := TTabSheet(TfrmRep(Form).Rate_Info);
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmRep.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseQueries;
  Action := caFree;
  inherited;
end;

procedure TfrmRep.TabCtl20Change(Sender: TObject);
begin
  inherited;
  if TabCtl20.ActivePage = TTabSheet(History) then begin
    if not Assigned(ffrmList) then begin
      ffrmList := TBaseListingGUI(GetComponentByClassName('TAppointmentListGUI', False, Self));
      {To Stop FindExistingComponent Finding This Instance}
      if Assigned(ffrmList) then ffrmList.Tag := 99;
      ffrmList.FilterString := 'TrainerID = ' + IntToStr(KeyID);
      ffrmList.Parent := pnlHistory;
      ffrmList.BorderStyle := bsNone;
      grpHistory.Color := ffrmList.pnlHeader.Color;
      ffrmList.Show;
      ffrmList.edtSearch.Width := 125;
      ffrmList.lblcustomReport.Visible := False;
      ffrmList.cboCustomReports.Visible := False;      
    end;
  end;
end;

procedure TfrmRep.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fMsgHandler);
  if Assigned(ffrmList) then
    FreeandNil(ffrmList);
  inherited;
end;

procedure TfrmRep.FormPaint(Sender: TObject);
begin
  inherited;
  grdRateInfo.SizeLastColumn;
end;

procedure TfrmRep.qryTrainerRatesServiceIDChange(Sender: TField);
begin
  inherited;
  qryTrainerRates.FieldByName('EmployeeID').AsInteger := KeyID;
  qryTrainerRates.FieldByName('Rate').AsBCD := qrycboServices.FieldByName('StandardRate').AsBCD;
end;

procedure TfrmRep.btnDetailDeleteClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?',
    mtConfirmation, [mbYes, mbNo, mbCancel], 0) = mrYes then begin
    try
      qryTrainerRates.Delete;
    except
      {Do nothing - raise a silent exception}
    end;
  end;
end;

procedure TfrmRep.cboServiceNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
var
  frm: TFrmRepServices;
begin
  inherited;
  {NOTE : Need to close the form prior to showing modally, otherwise Access Viol
  trying to modalise a visible form}
  sNewService := '';
  Accept := false;
  frm := nil;
  if CommonLib.MessageDlgXP_Vista('Service not found in list. Would you like to create this Service?',
    mtConfirmation, [mbYes, mbNo, mbCancel], 0) = mrYes then begin
    try
      frm := TfrmRepServices(GetComponentByClassName('TfrmRepServices'));
      if Assigned(Frm) then begin //if has acess
        Frm.fsServiceDesc := NewValue;
        Frm.Position := poScreenCenter;
        Frm.ShowModal;
      end;  
    finally
      qrycboServices.Close;
      qrycboServices.Open;
      sNewService := frm.fsNewService;
      if not Empty(sNewService) then begin
        if qrycboServices.Locate('ServiceDesc', sNewService,
          [loCaseInsensitive, loPartialKey]) then begin
          qryTrainerRates.Edit;
          qryTrainerRatesServiceID.AsInteger :=
            qrycboServices.FieldByName('ServiceID').AsInteger;
          cboService.LookupValue := qrycboServices.FieldByName('ServiceID').AsString;
          Accept := true;
        end;
      end else begin
        SetControlFocus(cboService);
      end;
      FreeandNil(frm);
    end;
  end;
end;

procedure TfrmRep.qryTrainerRatesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(qryTrainerRates, memqryTrainerRates);
end;

procedure TfrmRep.qryEmployeeAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(qryEmployee, memqryEmployee);
end;

procedure TfrmRep.FormCloseQuery(Sender: TObject; var CanClose: boolean);
var
  iExitResult: integer;
begin
  inherited;
  if not fbSaveClicked then begin
    if IsModified(memqryEmployee, qryEmployee) or
      IsModified(memqryTrainerRates, qryTrainerRates) then begin
      iExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation,
        [mbYes, mbNo, mbCancel], 0);
      case iExitResult of
        mrYes: 
          begin
            CanClose := false;
            cmdOK.Click;
          end;
        mrNo: 
          begin;
            RollbackTransaction;
            CanClose := true;
          end;
        mrCancel: CanClose := false;
      end;
    end;
  end;
end;

procedure TfrmRep.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
  cThisKey: char;
begin
  inherited;
  // Convert our KeyCode to a character.
  cThisKey := Chr(Key);
  // Tab Shortcut Keys.
  if Shift = [ssCtrl] then begin
    if cThisKey = 'R' then begin
      TabCtl20.ActivePageIndex := 0;
      TabCtl20Change(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'A' then begin
      TabCtl20.ActivePageIndex := 1;
      TabCtl20Change(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'T' then begin
      TabCtl20.ActivePageIndex := 2;
      TabCtl20Change(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'H' then begin
      TabCtl20.ActivePageIndex := 3;
      TabCtl20Change(Sender);
      Key := 0;
      Exit;
    end;
  end;
end;

procedure TfrmRep.grdRateInfoExit(Sender: TObject);
begin
  inherited;
  qryTrainerRates.Last;
  qryTrainerRates.First;
end;

procedure TfrmRep.btnAddDateTimeClick(Sender: TObject);
begin
  inherited;
  edtNotes.Lines.Text := edtNotes.Lines.Text + ' :- (' + AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName +
    ') ' + FormatDateTime('dddd mmmm d yyyy " at " hh:mm AM/PM', Now) + #13#10;
  qryEmployee.Edit;
  qryEmployeeNotes.AsString := edtNotes.Lines.Text;
  edtNotes.Update;
end;

procedure TfrmRep.FormCreate(Sender: TObject);
begin
  fMsgHandler := TMsgHandler.Create(Self);
  inherited;
  qrycboServices.Connection := CommonDbLib.GetSharedMyDacConnection;
  qrycboAbility.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryClients.Connection := CommonDbLib.GetSharedMyDacConnection;
  TabCtl20.ActivePageIndex := 0
end;

procedure TfrmRep.cboRepNameNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
begin
  //inherited;
  CommonLib.MessageDlgXP_Vista('This employee doesn''t exists in the system', mtWarning, [mbOK], 0);
  cboRepName.Text := '';
  Abort;
end;

procedure TfrmRep.cboEmployeeTypeNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;

  if CommonLib.MessageDlgXP_Vista('Type not found in the list. Create new?',
                 mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    Accept := True;
    LookupTable.Append;
    LookupTable.FieldByName('TypeName').AsString := NewValue;
    LookupTable.Post;

    if not (qryEmployee.State in [dsEdit, dsInsert]) then
      qryEmployee.Edit;

    qryEmployee.FieldByName('EmployeeTypeID').AsInteger := LookupTable.FieldByName('EmployeeTypeID').AsInteger;                    
  end
  else
    Accept := False;
end;

function TfrmRep.LoadFromAppNoServices(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
begin
  FromAppNoServices := True;
  KeyID := MsgObj.IntValue;
  if MsgObj.BoolValue then
    TabCtl20.ActivePage := Rate_Info;
  Result := True;
end;

procedure TfrmRep.NotifyAppointmentGUI;
var
  Form: TForm;
  MsgObj: TMsgObj;
begin
  Form := TForm(FindExistingComponent('TAppointmentGUI'));
  if Assigned(Form) then begin
    MsgObj := TMsgObj.Create;
    MsgObj.ClassStr := 'TAppointmentGUI';
    MsgObj.MethodStr := 'RepServicesFormClosed';
    fMsgHandler.Send(MsgObj);
  end;
end;

function TfrmRep.ValidateRates: boolean;
var
  lst: TIntegerList;
begin
  result:= true;
  lst:= TIntegerList.Create;
  qryTrainerRates.DisableControls;
  try
    qryTrainerRates.First;
    while not qryTrainerRates.Eof do begin
      if lst.InList(qryTrainerRates.FieldByName('ServiceID').AsInteger) then begin
        result:= false;
        break;
      end
      else
        lst.Add(qryTrainerRates.FieldByName('ServiceID').AsInteger);
      qryTrainerRates.Next;  
    end;
  finally
    lst.Free;
    qryTrainerRates.EnableControls;
  end;
end;

procedure TfrmRep.UpdateMe(const Cancelled: boolean; const aObject: TObject);
begin
  inherited;
  if Assigned(aObject) and (aObject is TBaseInputGUI) then begin
    if aObject.ClassNameIs('TfmRepAbilityEdit') then begin
      qryCboAbility.Refresh;
      if qryCboAbility.Locate('AbilityID',TBaseInputGUI(aObject).KeyID,[]) then
        qryTrainerRatesAbilityID.AsInteger:= TBaseInputGUI(aObject).KeyID;
    end;
  end;
end;

initialization
  RegisterClassOnce(TFrmRep);
  with FormFact do begin
    RegisterMe(TfrmRep, 'TRepListGUI_*=EmployeeID');
    RegisterControl(TfrmRep, 'TAppointmentGUI_cboEmployee=TrainerID');
    RegisterControl(TfrmRep, 'TRepairsGUI_cboEmployee=EmployeeID');
  end;
end.
