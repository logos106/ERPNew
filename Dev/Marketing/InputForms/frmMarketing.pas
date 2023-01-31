unit frmMarketing;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 26/09/05  1.00.01 DSP  Added 'Script' button and associated dialog display.
 20/10/05  1.00.02 DLS  Added RegisterClass
 24/01/06  1.00.03  AL  Added Dial button and ability to make calls by clicking on the button
                        or by dblclicking on the phone cell in the contactsgrid
 20/02/06  1.00.04  AL  Fixed the AdvAlertWindow height
 29/08/06  1.00.05 DSP  Changed Application.ProcessMessages to Update in
                        SetDNMSpeedButtons
 04/09/06  1.00.06 DSP  Added customise grid functionality.

}

interface

{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB,   StdCtrls, Buttons, DNMSpeedButton,
  wwcheckbox, wwdbdatetimepicker, wwdblook, Grids, Wwdbigrd, Wwdbgrid, DBCtrls,
  Mask, wwdbedit, ComCtrls,AdvOfficeStatusBar, ExtCtrls, DNMPanel, DataState, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, DateUtils, KbmMemTable, AdvAlertWindow,
  BusObjMarketingLeads, 
  MemDS, {PBXDialingObj,} Menus, AdvMenus, Shader, MessageInterface, busobjbase,
  wwriched, ImgList, ProgressDialog;

type
  TfmMarketing = class(TBaseInputGUI)
    pnlTop: TDNMPanel;
    DNMPanel1: TDNMPanel;
    pnlBottom: TDNMPanel;
    btnOk: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    btnNext: TDNMSpeedButton;
    btnLead: TDNMSpeedButton;
    dsContactSelectionList: TDataSource;
    dsLeadLines: TDataSource;
    qryLeadLines: TERPQuery;
    daLeads: TDataSource;
    qryLeads: TERPQuery;
    btnPrev: TDNMSpeedButton;
    btnScript: TDNMSpeedButton;
    aawMessages: TAdvAlertWindow;
    btnDial: TDNMSpeedButton;
    btnNoAnswer: TDNMSpeedButton;
    qryEmployee: TERPQuery;
    qryContactSelectionList: TERPQuery;
    qryContactList: TERPQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryLeadsGlobalRef: TWideStringField;
    qryLeadsLeadID: TIntegerField;
    qryLeadsMarketingContactID: TIntegerField;
    qryLeadsClientID: TIntegerField;
    qryLeadsRepID: TIntegerField;
    qryLeadsEnteredByEmployeeID: TIntegerField;
    qryLeadsIsLead: TWideStringField;
    qryLeadsmsTimeStamp: TDateTimeField;
    qryMarketingcontacts: TERPQuery;
    dsMarketingcontacts: TDataSource;
    qryMarketingcontactsID: TIntegerField;
    qryMarketingcontactsGlobalRef: TWideStringField;
    qryMarketingcontactsCompanyTypeName: TWideStringField;
    qryMarketingcontactsCOMPANY: TWideStringField;
    qryMarketingcontactsStreet: TWideStringField;
    qryMarketingcontactsStreet2: TWideStringField;
    qryMarketingcontactsStreet3: TWideStringField;
    qryMarketingcontactsFaxNumber: TWideStringField;
    qryMarketingcontactsPhone: TWideStringField;
    qryMarketingcontactsAltPhone: TWideStringField;
    qryMarketingcontactsMobile: TWideStringField;
    qryMarketingcontactsSUBURB: TWideStringField;
    qryMarketingcontactsSTATE: TWideStringField;
    qryMarketingcontactsPOSTCODE: TWideStringField;
    qryMarketingcontactsEmployeeSize: TWideStringField;
    qryMarketingcontactsNotes: TWideMemoField;
    qryMarketingcontactsActive: TWideStringField;
    qryMarketingcontactsJobTitle: TWideStringField;
    qryMarketingcontactsTitle: TWideStringField;
    qryMarketingcontactsFirstName: TWideStringField;
    qryMarketingcontactsMiddleName: TWideStringField;
    qryMarketingcontactsLastName: TWideStringField;
    qryMarketingcontactsEmail: TWideStringField;
    qryMarketingcontactsCountry: TWideStringField;
    qryMarketingcontactsDateEntered: TDateTimeField;
    qryMarketingcontactsEnteredEmpID: TIntegerField;
    qryMarketingcontactsDateOfBirth: TDateField;
    qryMarketingcontactsDuration: TDateTimeField;
    qryMarketingcontactsSource: TWideStringField;
    qryMarketingcontactsmsTimeStamp: TDateTimeField;
    qryMarketingcontactsNumUnansweredCalls: TIntegerField;
    qryMarketingcontactsDoNotQualify: TWideStringField;
    qryMarketingcontactsClientID: TIntegerField;
    qryContactListID: TIntegerField;
    qryLeadLinesGlobalRef: TWideStringField;
    qryLeadLinesLeadID: TIntegerField;
    qryLeadLinesLeadLineID: TIntegerField;
    qryLeadLinesActionType: TIntegerField;
    qryLeadLinesActionID: TIntegerField;
    qryLeadLinesFollowupID: TIntegerField;
    qryLeadLinesActionRef: TWideStringField;
    qryLeadLinesCreationDate: TDateTimeField;
    qryLeadLinesUpdateDate: TDateTimeField;
    qryLeadLinesFollowUpDate: TDateTimeField;
    qryLeadLinesStatusID: TIntegerField;
    qryLeadLinesPriority: TIntegerField;
    qryLeadLinesEmployeeID: TIntegerField;
    qryLeadLinesEmployeeName: TWideStringField;
    qryLeadLinesDuration: TWideStringField;
    qryLeadLinesTypeId: TIntegerField;
    qryLeadLinesTypeName: TWideStringField;
    qryLeadLinesHours: TFloatField;
    qryLeadLinesResultTypeId: TIntegerField;
    qryLeadLinesResultTypeName: TWideStringField;
    qryLeadLinesIsPhoneFollowUp: TWideStringField;
    qryLeadLinesEntryCount: TIntegerField;
    qryLeadLinesCreatedByID: TIntegerField;
    qryLeadLinesDone: TWideStringField;
    qryLeadLinesNotes: TWideMemoField;
    qryLeadLinesIsMarketing: TWideStringField;
    qryLeadLinesIsLead: TWideStringField;
    qryLeadLinesmsTimeStamp: TDateTimeField;
    qryLeadsCompany: TWideStringField;
    qrySimpleTypes: TERPQuery;
    StringField4: TWideStringField;
    IntegerField2: TIntegerField;
    StringField5: TWideStringField;
    StringField6: TWideStringField;
    qryLeadLinesActiontypeName: TWideStringField;
    qryActionType: TERPQuery;
    qryActionTypeName: TWideStringField;
    qryActionTypeId: TIntegerField;
    qryActionTypeTypeCode: TWideStringField;
    qryActionTypeActive: TWideStringField;
    qryLeadLinesActionDate: TDateTimeField;
    qryContactListcompany: TWideStringField;
    qryLeadsLeadStatus: TWideStringField;
    dlgMemo: TwwMemoDialog;
    pnlContactDetails: TDNMPanel;
    lblListSelection: TLabel;
    cboRangeSelection: TwwDBLookupCombo;
    chkDisregard: TCheckBox;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    grdContacts: TwwDBGrid;
    pnlActionAndNotes: TDNMPanel;
    pnlAction: TDNMPanel;
    lblFollowUpType: TLabel;
    grdFollowups: TwwDBGrid;
    grdFollowupsIButton: TwwIButton;
    cboActionType: TwwDBLookupCombo;
    edtActionDate: TwwDBDateTimePicker;
    cboEmployee: TwwDBLookupCombo;
    pnlNotes: TDNMPanel;
    Label5: TLabel;
    DBMemo1: TDBMemo;
    btnEmail: TDNMSpeedButton;
    qryLeadsnotes: TWideStringField;
    qryLeadsCreatedOn: TDateTimeField;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cboRangeSelectionCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormCreate(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure grdFollowupsIButtonClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure chkDisregardClick(Sender: TObject);
    procedure btnScriptClick(Sender: TObject);
    procedure btnNoAnswerClick(Sender: TObject);
    procedure cboEmployeeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboFollowUpResultCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure qryLeadsAfterPost(DataSet: TDataSet);
    procedure qryLeadLinesAfterPost(DataSet: TDataSet);
    procedure btnLeadClick(Sender: TObject);
    procedure grdFollowupsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdFollowupsColEnter(Sender: TObject);
    procedure cboActionTypeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdFollowupsRowChanged(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cboActionTypeDblClick(Sender: TObject);
    procedure cboActionTypeNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure grdContactsDblClick(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
  private
    fMsgHandler: TMsgHandler;
    fbUpdatingDone: boolean;
    ClientListSQL: string;
    NewActiontype :String;

    withinMoveRec :Boolean;
    fsMarketingContactName :String;
    LastSetContactListQuery: string;
    procedure SetDNMSpeedButtons;
    Procedure MoveRec(MoveType :String = 'N');
    Procedure SetcontactListQry;
    (*Procedure NewAppointment;*)
    procedure OpenLead(*(CreateAppointment:Boolean = False)*);

  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;

  public
    Followups :TLeads;
    procedure Centralisebuttons(OwnerPanel:TDnMPanel; leftmargin :Integer =0; rightMargin :Integer =0; btngap:Integer=4); override;
    procedure UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil);override;
    Property MarketingContactName :String read fsMarketingContactName Write fsMarketingContactName;
  published
  end;

  TMarketingAppointment = class(TComponent)
  private
    fMsgHandler: TMsgHandler;
  public
    TeleContactID: Integer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
  end;

implementation{$R *.dfm}

uses
    FastFuncs,DNMExceptions,  FormFactory,
    CommonLib, ShellAPI,BusObjConst, DNMLib, //BusobjRangeSelection,
    frmMarketingLead, BusobjMarketingcontacts, XMLDataObj, tcDataUtils,
    frmMarketingContactSelectionRange, ThreadDataset, frmSimpleTypes,
  tcconst, CommonFormLib, frmCorrespondenceCreate, tcTypes,
  frmMarketingContact;

Procedure TfmMarketing.SetcontactListQry;
var
  whereclause: String;
  XML: TXMLData;
  sl: TStringList;
begin
    sl:= TStringList.Create;
    try
      sl.add('SELECT');
      sl.add('MC.ID,MC.Company ');
      sl.add('FROM tblmarketingcontacts as MC');
      if chkDisregard.Enabled = False then
           sl.add('WHERE ID = ' + IntToStr(Followups.MarketingContactID))
      else if (chkDisregard.checked = False ) and (cboRangeSelection.text = '')  then
          sl.add('WHERE ID not in (Select ifnull(marketingcontactId,0) from tblMarketingleads)')
      else  if (cboRangeSelection.text <> '') then begin
          XML := TXMLData.Create(Self);
          try
              XML.Text    := cboRangeSelection.LookupTable.FieldByName('XMLData').AsString;
              whereclause := XML.Node['SQLSelect'].Attribute['SQL'].AsString;
          Finally
              FreeandNil(XML);
          end;
          sl.add('WHERE ' + REplaceStr(WhereClause, 'tblmarketingcontacts' ,'MC'));
          sl.add('AND ID not in (Select ifnull(marketingcontactId,0) from tblMarketingleads)');
      end;
      if LastSetContactListQuery <> sl.Text then begin
        LastSetContactListQuery:= sl.Text;
        qryContactList.Close;
        qryContactList.SQL.Text:= LastSetContactListQuery;
//        qryContactList.open;
        OpenDatasetThread(qryContactList);
      end;
    finally
      sl.Free;
    end;
end;
procedure TfmMarketing.FormShow(Sender: TObject);
var
  QueriesNotToOpen: array of string;
begin
  DisableForm;
  try
    try
      inherited;
      GuiPrefs.DbGridElement[grdFollowups].RemoveFields('LeadID,LeadLineID,ActionID,FollowupID,StatusID,' +
      'EmployeeID,CreatedByID,TypeID');
      if (KeyID=0) and (MarketingContactName<> '') then begin
         KeyId := tcdatautils.LeadID(MarketingContactName);
         if KeyID<>0 then MarketingContactName:='';
      end;
      Followups.Load(KeyID);
      Followups.Lines;
      Followups.Marketingcontacts;
      withinMoveRec := false;
      Followups.connection.BeginTransaction;
      if Self.ErrorOccurred then Exit;

      BringToFront;

      cboRangeSelection.Enabled   :=(Followups.count =0);
      lblListSelection.Enabled    :=(Followups.count =0);
      chkDisregard.Enabled        :=(Followups.count =0);
      Label2.Enabled              :=(Followups.count =0);
      Label1.Enabled              :=(Followups.count =0);
      Label3.Enabled              :=(Followups.count =0);

      SetcontactListQry;
      (*qryActionType.ParamByName('TypeCode').AsString := SimpleTypes_LeadLineActionType;*)
      Setlength(QueriesNotToOpen, 3);
      QueriesNotToOpen[0] := 'qryContact';
      QueriesNotToOpen[1] := 'qryFollowUp';
      QueriesNotToOpen[2] := 'qryContactList';
      OpenQueries(QueriesNotToOpen);
      if Followups.lines.count = 0 then
          if qryMarketingcontacts.RecordCount > 0 then
              Followups.lines.new;

      if (followups.count = 0) and (qryContactList.recordcount > 0) then begin
          if (MarketingContactName <> '') and (qryContactList.Locate('company' ,MarketingContactName , [])) then begin
            MoveRec('R');
          end else
            MoveRec('F');
      end else begin
          SetDNMSpeedButtons;
          Followups.dirty := False;
      end;
      Followups.dirty := false;
    except
      on EAbort do
        HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else
        raise;
    end;
  finally
    EnableForm;
  end;
  if (MarketingContactName <> '') and sametext(qryContactListcompany.AsString ,MarketingContactName ) then
    Setcontrolfocus(grdFollowups);
end;

procedure TfmMarketing.SetDNMSpeedButtons;
begin
    btnOk.Enabled       := Followups.Lines.count > 0;
    btnNext.Enabled     := (qryContactList.RecordCount >1) and (qryContactList.Recno < qryContactList.Recordcount);
    btnPrev.Enabled     := (qryContactList.RecordCount >1) and (qryContactList.Recno >1);
    btnLead.Enabled     := Followups.Lines.count > 0;
    btnEmail.Enabled    := Followups.Lines.count > 0;
    btnScript.Enabled   := Followups.MarketingContactID<> 0;
    btnNoAnswer.Enabled := (Followups.Lines.count > 0) or (Followups.Lines.Dataset.state = dsInsert);
    btnDial.Enabled     := False;
    cmdClose.Enabled    := True;
    Centralisebuttons(pnlBottom);
  Update;
end;


procedure TfmMarketing.FormDestroy(Sender: TObject);
begin
    FreeAndNil(fMsgHandler);
    
    freeandNil(Followups);
    inherited;
end;

procedure TfmMarketing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not Self.ErrorOccurred then begin
    CloseQueries;
  end;
  Action := caFree;
  inherited;
end;

procedure TfmMarketing.cboRangeSelectionCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
    if not modified then exit;
    if cboRangeSelection.text <> '' then chkDisregard.checked := False;
    MoveRec('F');
end;
procedure TfmMarketing.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TLeads             then TLeads(Sender).DataSet             := qryLeads;
        if Sender is TLeadLines         then TLeadLines(Sender).DataSet         := qryLeadLines;
        if Sender is TMarketingContact then TMarketingContact(Sender).DataSet := qryMarketingcontacts;
    end ;
end;
procedure TfmMarketing.FormCreate(Sender: TObject);
begin
    Followups := TLeads.Create(Self);
    Followups.Connection := TMyDacDataConnection.create(Followups);
    Followups.Connection.connection := Myconnection;
    Followups.BusObjEvent := DoBusinessObjectEvent;
    (*Followups.NewAppointment := NewAppointment;*)
    fMsgHandler := TMsgHandler.Create(Self);
    ExcludeGridfromcustomize(grdFollowups);
    AllowCustomiseGrid := True;
    inherited;

    if Self.ErrorOccurred then Exit;
    fbUpdatingDone := false;
    UserLock.Enabled := true;
    ClientListSQL := qryContactList.SQL.Text;

    fbTabSettingEnabled := false;
    MarketingContactName := '';

(*  for Index := 0 to GuiPrefs.Elements.Count - 1 do begin
    if GuiPrefs.Elements.Items[Index].Target = grdContacts then
      GuiPrefs.Elements.Items[Index].Description := 'Contact Details'
    else if GuiPrefs.Elements.Items[Index].Target = grdFollowUps then
      GuiPrefs.Elements.Items[Index].Description := 'Action / Follow up Details'
  end;*)
  GuiPrefs.Active := true;
end;

procedure TfmMarketing.cmdCloseClick(Sender: TObject);
begin 
  inherited;
//  Self.RollbackTransaction;
  if fsModal in Self.FormState then 
    ModalResult := mrCancel 
  else 
    Close;
end;
Procedure TfmMarketing.MoveRec(MoveType :String = 'N');
var
  bFound: boolean;
  ans :Integer;
begin
    if withinMoveRec then Exit;
    withinMoveRec := true;
    try
        if Followups.Dirty or Followups.IsNew then begin
          ans := MessageDlgXP_Vista('Do you wish to Save the changes?' , mtconfirmation , [mbYes,mbNo, mbCancel], 0);
          if ans  = mrcancel then Exit;
          if ans = mryes then begin
            if Followups.IsNew and (followups.Lines.Count < 2) then begin
              MessageDlgXP_Vista('Please add a second Action/ Follow up line' , mtInformation , [mbok], 0);
              exit;
            end;
            if not(Followups.Save) then exit;
            Followups.connection.CommitTransaction;
          end else if ans = mrno then begin
              Followups.connection.RollbackTransaction;
          end;
        end else begin
          Followups.CancelDb;
          Followups.connection.RollbackTransaction;
        end;

        Label1.Caption := 'Searching ....';
        Self.Update;
        bFound := false;
             if MoveType = 'N' then qryContactList.Next
        else if MoveType = 'P' then qryContactList.Prior
        else if MoveType = 'F' then begin
            SetcontactListQry;
            qryContactList.First;
            Movetype := 'N';
        end;
        if qryContactList.recordcount = 0 then begin
            followups.new;
            followups.MarketingContactID :=  0;
            followups.dirty := fAlse;
        end else
        while qryContactList.eof = False do begin
            Followups.Closedb;
            Followups.connection.BeginTransaction;
            Followups.loadSelect('MarketingcontactID = ' +IntToStr(qryContactListID.asInteger));
            if followups.count = 0 then begin
              followups.new;
              followups.MarketingContactID :=  qryContactListID.asInteger;
              followups.PostDB;
              followups.Dirty := False;
              followups.Lines.New;
            end;
            if not(Followups.LockTrans) then begin
                Followups.connection.RollbackTransaction;
                if MoveType = 'N' then qryContactList.Next else if MoveType = 'P' then qryContactList.Prior;
            end else begin
                bfound := true;
                break;
            end;
        end;

        Label1.Caption := 'Records Found : ' + IntToStr(qryContactList.recordcount);
        followups.marketingcontacts;
        Label3.Caption := 'Current Record : ' + IntToStr(qryContactList.Recno); ;//IntToStr(followups.marketingcontacts.Dataset.Recno);
        if not (bFound) then
            CommonLib.MessageDlgXP_Vista('You have reached the end of the list!', mtWarning, [mbOK], 0);
        SetDNMSpeedButtons;
    finally
        withinMoveRec := false;
    end;
end;
procedure TfmMarketing.btnNextClick(Sender: TObject);
begin
    MoveRec;
end;

procedure TfmMarketing.btnPrevClick(Sender: TObject);
begin
    MoveRec('P');
end;

procedure TfmMarketing.grdFollowupsIButtonClick(Sender: TObject);
begin
    if Followups.IsOktoDeleteLine then
        if CommonLib.MessageDlgXP_Vista('Do you want to delete this ' + Followups.Lines.ActionTypeName +' record?', mtConfirmation, [mbyes, mbNo], 0) = mrYes then
              Followups.Lines.delete;
end;

procedure TfmMarketing.btnOkClick(Sender: TObject);
begin
    if not (Followups.Save) then exit;
    Followups.Connection.CommitTransaction;
    self.close;
end;

procedure TfmMarketing.chkDisregardClick(Sender: TObject);
begin
    if Screen.activecontrol <> chkDisregard then exit;
    if chkDisregard.checked then cboRangeSelection.Text := '';
    MoveRec('F');
end;

procedure TfmMarketing.btnScriptClick(Sender: TObject);
var 
  MsgItem: TMsgCollectionItem;
  MsgStr: string;
  frm:TComponent;
begin 
  inherited;
  aawMessages.MaxHeight := TForm(FindExistingComponent('TMainForm')).Height - 120;
  aawMessages.AlertMessages.Clear;
  MsgItem := aawMessages.AlertMessages.Add;
  MsgStr := qryContactSelectionList.FieldByName('Message').AsString;
  if char_length(MsgStr) > 0 then begin
    MsgItem.Text.Add(MsgStr);
    aawMessages.Show;
    aawMessages.Previous;
  end else
    if cboRangeSelection.Text = '' then exit;
    
    if CommonLib.MessageDlgXP_Vista('There is no script assigned for this contact type.Do you wish to add a script?', mtConfirmation,
      [mbYes,mbNo], 0) = mrYes then begin

      frm := TForm(GetComponentByClassType(getClass('TfmMarketingContactSelectionRange'),True));
      if Assigned(frm) then begin
        TfmMarketingContactSelectionRange(frm).KeyID := tcDataUtils.GetRangeSelectionID(cboRangeSelection.Text);
        TfmMarketingContactSelectionRange(frm).OpenScriptForm := True;
        TForm(frm).ShowModal;

      end;
      qryContactSelectionList.Close;
      qryContactSelectionList.Open;
    end;
end;

procedure TfmMarketing.btnNoAnswerClick(Sender: TObject);
begin
  inherited;
  if not (qryContactList.Active) then Exit;
  Followups.marketingcontacts.NumUnansweredCalls := Followups.marketingcontacts.NumUnansweredCalls + 1;
  btnNext.Click;
end;

{ TMarketingAppointment }
constructor TMarketingAppointment.Create(AOwner: TComponent);
begin
  inherited;
  fMsgHandler := TMsgHandler.Create(Self);
end;

destructor TMarketingAppointment.Destroy;
begin
  FreeAndNil(fMsgHandler);
  inherited;
end;

(*Procedure TfmMarketing.NewAppointment;
begin
    OpenLead(True);
end;*)
procedure TfmMarketing.btnEmailClick(Sender: TObject);
begin
  inherited;
    Followups.Lines.PostDB;
    if Followups.MarketingContacts.currentEmailID = '' then begin
      if CommonLib.MessageDlgXP_Vista('The contact ' + Followups.MarketingContacts.Company +
        ' does not have an email address.' + #13 + #10 + 'Do you wish to load the email program anyway?',
        mtConfirmation, [mbYes, mbNo], 0)  = mrNo then Exit;
  end;
  Followups.Lines.New;
  Followups.Lines.ActionTypeName := 'Email';
  Followups.Lines.PostDB;
  MCCreateCorrespondence(ctEmail,self , Followups.MarketingContacts.FirstName);
end;

procedure TfmMarketing.btnLeadClick(Sender: TObject);
begin
  inherited;
    Followups.Lines.PostDB;
    //if Followups.Lines.Actiontype <> tcDataUtils.LeadActionLead then begin
    if followups.Lines.Dataset.locate('Actiontype' ,tcDataUtils.LeadActionLead , []) = False then begin
        Followups.Lines.new;
        Followups.Lines.Actiontype :=tcDataUtils.LeadActionLead ;
      //  Followups.Lines.Actiontype :=tcDataUtils.LeadActionFollowup ; {todo: do we need a line to be lead}
        Followups.Lines.IsLead := True;
        Followups.Lines.PostDB;

        Followups.Lines.new;
        Followups.Lines.Actiontype :=tcDataUtils.LeadActionFollowup ;
        Followups.Lines.IsLead := True;
        Followups.Lines.PostDB;
    end;
    OpenLead;
end;

procedure TfmMarketing.OpenLead(*(CreateAppointment:Boolean = False)*);
var
  Form: TfmMarketingLead;
begin
(*    Followups.Lines.done := True;
    Followups.Lines.PostDB;*)
    Followups.ISLead := True;
    Followups.postDB;
    if not(Followups.Save) then exit;
    Followups.Connection.CommitTransaction;
    Form            := TfmMarketingLead(GetComponentByClassName('TfmMarketingLead'));
    Form.KeyID      := Followups.Id;
    (*Form.CreateAppointment := CreateAppointment;*)
    Form.FormStyle  := fsMDIChild;
    Form.BringToFrontSoon;
    if fsModal in Self.FormState then ModalResult := mrOk
    else Close;
end;

procedure TfmMarketing.cboEmployeeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
    inherited;
    Followups.Lines.EmployeeName := Lookuptable.fieldbyname('EmployeeName').asString;
end;

procedure TfmMarketing.cboFollowUpResultCloseUp(
  Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
    inherited;
    Followups.Lines.postdb;
end;

procedure TfmMarketing.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ErrorOccurred then Exit;

  CanClose := false;
  Followups.Lines.PostDB;
  Followups.PostDB;
  if Followups.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if Followups.Save then begin
            Followups.Connection.CommitTransaction;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          Followups.Connection.RollbackTransaction;
          Followups.Dirty := false;
          CanClose := true;
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
  end;
end;
procedure TfmMarketing.Centralisebuttons(OwnerPanel:TDnMPanel; leftmargin :Integer =0; rightMargin :Integer =0; btngap:Integer=4);
var
    ctr :Integer;
    Procedure Addbutton( button :TDnMspeedButton);
    begin
        if button.visible then begin
            ctr := ctr+1;
            Setlength(Buttons , ctr);
            Buttons[ctr-1] := button.Name;
        end;
    end;
begin
    ctr:= 0;
    Addbutton(btnOk);
    Addbutton(btnPrev);
    Addbutton(btnNext);
    Addbutton(btnLead);
    Addbutton(btnEmail);
    Addbutton(btnDial);
    Addbutton(btnScript);
    Addbutton(btnNoAnswer);
    Addbutton(cmdClose);
    inherited Centralisebuttons(pnlBottom);
end;

procedure TfmMarketing.qryLeadsAfterPost(DataSet: TDataSet);
begin
    inherited;
    SetDNMSpeedButtons;
end;

procedure TfmMarketing.qryLeadLinesAfterPost(DataSet: TDataSet);
begin
  inherited;
    SetDNMSpeedButtons;
end;

procedure TfmMarketing.grdContactsDblClick(Sender: TObject);
var
  form: TfmMarketingContact;
begin
  inherited;
  if Followups.MarketingContactID =0 then exit;

  Followups.PostDb;
  form := TfmMarketingContact.Create(nil);
  try
    form.TransConnection := TERPConnection(Followups.Connection.Connection);
    form.KeyID := Followups.MarketingContactID;
    form.MC.UserLock := Followups.UserLock;
    form.MCF.UserLock := Followups.UserLock;
    if form.ShowModal = mrOk then begin
      Followups.MarketingContacts.RefreshDB;
    end;
  finally
    form.Free;
  end;



//  if Followups.dirty then begin
//    if MessageDlgXP_vista('This will Save current changes and open the Marketing contact Record. Do you like to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
//    if not (Followups.Save) then exit;
//    Followups.Connection.CommitTransaction;
//    Followups.UserLock.UnlockAllCurrentInstance;
//    Followups.Dirty := False;
//  end;
//  UserLock.UnlockAllCurrentInstance;
//  OpenERPForm('TfmMarketingContact' , Followups.MarketingContactID);
//  Self.Close;
end;

procedure TfmMarketing.grdFollowupsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
(*    if Sysutils.SameText(Field.FieldName , 'Actiontypename') then
        ABrush.color := clInactiveBorder;*)
end;

procedure TfmMarketing.grdFollowupsColEnter(Sender: TObject);
begin
  inherited;
  if Sysutils.SameText(grdfollowups.GetActiveField.fieldNAme , 'Status') then
        grdfollowups.SetActiveField('Priority')
    else if not(Sysutils.SameText(grdfollowups.GetActiveField.fieldNAme , 'Notes')) then
        if (Followups.Lines.Dataset.State = dsBrowse) and (Followups.Lines.IsTransationRecord) then
             grdfollowups.options := grdfollowups.options - [dgEditing]
        else grdfollowups.options := grdfollowups.options + [dgEditing];
end;

procedure TfmMarketing.cboActionTypeCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
    Followups.Lines.ActionType  :=    qryActionTypeId.asInteger;
    Followups.Lines.Actiontypename :=   qryActionTypeName.asString;
    Followups.Lines.postdb;
    if Followups.Lines.Actiontype = tcDataUtils.LeadActionLead then begin
        Followups.Lines.IsLead := True;
        btnLead.click;
    end;
end;

procedure TfmMarketing.cboActionTypeDblClick(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_LeadActionType, Followups.lines.ActiontypeName);
end;

procedure TfmMarketing.cboActionTypeNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  fLastComboAccessed := cboActionType;
  NewActiontype := cboActionType.Text;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtconfirmation, [mbyes, mbno], 0) = mrYes then begin
    TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_LeadActionType, NewValue, Self);
  end;
  Accept := False;
end;
procedure TfmMarketing.UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil);
begin
  if Cancelled then begin
  end else begin
    if (Assigned(aObject) and (aObject is TBaseInputGUI) and Assigned(fLastComboAccessed)) then begin
        with fLastComboAccessed do begin
          LookupTable.Close;
          LookupTable.Open;
          closeDb(qrySimpleTypes);
          openDb(qrySimpleTypes);
          if fLastComboAccessed = cboActionType then begin
            if Lookuptable.locate('Name' ,NewActiontype , []) then    Followups.lines.ActiontypeName := NewActiontype;
          end;
        end;
    end;
  end;
end;



procedure TfmMarketing.grdFollowupsRowChanged(Sender: TObject);
begin
  inherited;
    if not(Sysutils.SameText(grdfollowups.GetActiveField.fieldNAme , 'Notes')) then
        if (Followups.Lines.Dataset.State = dsBrowse) and (Followups.Lines.IsTransationRecord) then
             grdfollowups.options := grdfollowups.options - [dgEditing]
        else grdfollowups.options := grdfollowups.options + [dgEditing] ;
end;

procedure TfmMarketing.FormResize(Sender: TObject);
begin
  inherited;
  pnlNotes.Height:=
    Trunc(pnlActionAndNotes.Height / 3);
end;

initialization
  RegisterClassOnce(TfmMarketing);
  with FormFact do begin
    (*RegisterMe(TfmMarketing, 'TRemindersListGUI_*_Marketing Contact FollowUp=ID');*)
    RegisterMe(TfmMarketing, 'TReminderListGUI_*_Marketing Contact FollowUp=ID');
    RegisterMe(TfmMarketing, 'TMarketingGUI_*=LeadID');
    (*RegisterMe(TfmMarketing, 'TMarketingContactGUI_ActionDate=ActionDate');*)
    RegisterMe(TfmMarketing, 'TMarketingContactListDetailGUI_ActionDate=ActionDate');
    RegisterMe(TfmMarketing, 'TMarketingContactListDetailGUI_*_Telemarketing=tmid');
    RegisterMe(TfmMarketing, 'TMarketingContactGUI_*_Telemarketing=LeadID');

  end;
end.



