unit frmMarketingContactSelectionRange;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 26/09/05  1.00.01 DSP  Added 'Script' button and associated dialog box for
                        text entry.
 20/10/05  1.00.02 DLS  Added RegisterClass

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm,  DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, DB,  StdCtrls, Mask, DBCtrls, wwcheckbox, Buttons, DNMSpeedButton,
  ExtCtrls, DNMPanel, ActnList, XMLDataObj, frameSQLSelectBuilder, MemDS,
  wwdbedit, Wwdbgrid, Menus, AdvMenus, Shader, BusobjRangeSelection, BusObjBase,
  Grids, Wwdbigrd, DataState, ImgList, ProgressDialog ;

type
  TfmMarketingContactSelectionRange = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    Label50: TLabel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    pnlTop: TDNMPanel;
    Label1: TLabel;
    alMain: TActionList;
    actMainSave: TAction;
    actMainNew: TAction;
    actMainCancel: TAction;
    actDeleteListItem: TAction;
    actAddListItem: TAction;
    QueryBuilder: TfrSQLSelectBuilder;
    edtDescription: TwwDBEdit;
    qryMaster: TERPQuery;
    dsMaster: TDataSource;
    dlgMemo: TwwMemoDialog;
    btnMessage: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryDetails: TERPQuery;
    dsDetails: TDataSource;
    qryMasterRangeSelectionId: TIntegerField;
    qryMasterRangeDescription: TWideStringField;
    qryMasterXMLData: TWideMemoField;
    qryMasterActive: TWideStringField;
    qryMasterGlobalRef: TWideStringField;
    qryMastermsTimeStamp: TDateTimeField;
    qryDetailsMessageID: TIntegerField;
    qryDetailsGlobalRef: TWideStringField;
    qryDetailsRangeSelectionID: TIntegerField;
    qryDetailsMessage: TWideMemoField;
    qryDetailsActive: TWideStringField;
    qryDetailsmsTimeStamp: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure actMainSaveExecute(Sender: TObject);
    procedure actMainNewExecute(Sender: TObject);
    procedure actMainCancelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure QueryBuilderbtnAddListItemClick(Sender: TObject);
    procedure btnMessageClick(Sender: TObject);
    procedure qryMasterBeforePost(DataSet: TDataSet);

  private
    { Private declarations }
    fOpenScriptForm: boolean;
    RangeSelection :TRangeSelection;
    procedure SetDefaults;

  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
    XMLData: TXMLData;
    property OpenScriptForm :boolean read fOpenScriptForm write fOpenScriptForm;
  end;

implementation

{$R *.dfm}

uses
  FormFactory, CommonLib, BusObjConst, FastFuncs ;

procedure TfmMarketingContactSelectionRange.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TRangeSeselectionMessages  then TRangeSeselectionMessages(Sender).DataSet  := qrydetails;
        if Sender is TRangeSelection            then TRangeSelection(Sender).DataSet            := qryMaster;
    end ;
end;
procedure TfmMarketingContactSelectionRange.SetDefaults;
begin
  // set the columns the user can choose from
  QueryBuilder.XMLData.DeleteNode('SQLSelect.Tables');
  with QueryBuilder.XMLData.Node['SQLSelect.Tables.Table0'] do begin
    Attribute['TableName'].AsString := 'tblmarketingcontacts';
    Attribute['Field0'].AsString    := 'Company';
    Attribute['Field1'].AsString    := 'CompanyTypeName';
    Attribute['Field2'].AsString    := 'Suburb';
    Attribute['Field3'].AsString    := 'State';
    Attribute['Field4'].AsString    := 'PostCode';
    Attribute['Field5'].AsString    := 'EmployeeSize';
    Attribute['Field6'].AsString    := 'JobTitle';
    Attribute['Field7'].AsString    := 'Country';
    Attribute['Field8'].AsString    := 'DateEntered';
    Attribute['Field9'].AsString    := 'DateOfBirth';
    Attribute['Field10'].AsString   := 'Source';
  end;
  QueryBuilder.UpdateFromXMLData;
end;
// ---------- Form Events ------------------------------------------------------
procedure TfmMarketingContactSelectionRange.FormCreate(Sender: TObject);
begin
  inherited;
  RangeSelection := TRangeSelection.Create(Self);
  RangeSelection.connection := TMyDacDataConnection.Create(RangeSelection);
  RangeSelection.connection.connection := Self.MyConnection;
  RangeSelection.BusObjEvent := DoBusinessObjectEvent;
  RangeSelection.XMLDataValidateObj :=  QueryBuilder.XMLData;
  if ErrorOccurred then Exit;
  XMLData := TXMLData.Create(self);
end;
procedure TfmMarketingContactSelectionRange.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  (*if qryMain.State in [dsEdit, dsInsert] then qryMain.Cancel;
  RollbackTransaction;*)
  Action := caFree;
 (* QueryBuilder.XMLData.SaveToFile;*)
end;

procedure TfmMarketingContactSelectionRange.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if ErrorOccurred then Exit;

    if Self.AccessLevel = 5 then begin
      QueryBuilder.IsReadOnly := true;
      btnSave.Enabled := false;
      btnNew.Enabled := false;
    end;
    RangeSelection.Load(KeyId);
    if RangeSelection.count = 0 then RangeSelection.New;
    if RangeSelection.XMLData <> '' then
        QueryBuilder.XMLData.Text := RangeSelection.XMLData;
    SetDefaults;
    RangeSelection.Connection.BeginTransaction;
    RangeSelection.Dirty := False;
    if fOpenScriptForm then Self.btnMessage.Click;
  finally
    EnableForm;
  end;   
end;

// ---------- Main Actions ---------- //

procedure TfmMarketingContactSelectionRange.actMainSaveExecute(Sender: TObject);
begin
  inherited;
  if not RangeSelection.Save then Exit;
  RangeSelection.connection.CommitTransaction;
  Notify;
  QueryBuilder.Dirty := false;
  Close;
end;

procedure TfmMarketingContactSelectionRange.actMainNewExecute(Sender: TObject);
begin
    inherited;
    if RangeSelection.Dirty or QueryBuilder.Dirty then begin
        case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
            mrYes:  begin
                        if not RangeSelection.Save then Exit;
                        RangeSelection.Connection.CommitTransaction;
                    end;
            mrNo :  begin
                        RangeSelection.Connection.RollbackTransaction;
                        QueryBuilder.Dirty := false;
                    end;
            mrCancel:   Exit;
        end;
    end;
    RangeSelection.Connection.BeginTransaction;
    RangeSelection.New;
end;

procedure TfmMarketingContactSelectionRange.actMainCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

// ---------- Form Methods/Functions -------------------------------------------

procedure TfmMarketingContactSelectionRange.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if ErrorOccurred then Exit;

  CanClose := false;
  if RangeSelection.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if RangeSelection.Save then begin
            RangeSelection.Connection.CommitTransaction;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          RangeSelection.Connection.RollbackTransaction;
          RangeSelection.Dirty := false;
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

procedure TfmMarketingContactSelectionRange.QueryBuilderbtnAddListItemClick(Sender: TObject);
begin
  inherited;
  QueryBuilder.btnAddListItemClick(Sender);
end;
procedure TfmMarketingContactSelectionRange.btnMessageClick(Sender: TObject);
var
    RangeSelectionID: string;
begin
    inherited;       
    RangeSelectionID := IntToStr(RangeSelection.ID);
    dlgMemo.Lines.Text := RangeSelection.lines.Message;
    if dlgMemo.Execute then begin
        if RangeSelection.Lines.Count = 0 then
            RangeSelection.Lines.New;
        RangeSelection.Lines.Message := dlgMemo.Lines.Text;
        RangeSelection.Lines.PostDB;
    end;
end;
procedure TfmMarketingContactSelectionRange.qryMasterBeforePost(DataSet: TDataSet);
begin
  inherited;
  if not QueryBuilder.ValidateData then Abort;
end;

initialization
  RegisterClassOnce(TfmMarketingContactSelectionRange);
  with FormFact do begin
    RegisterMe(TfmMarketingContactSelectionRange, 'TMarketingContactSelectionRangeListGUI_*=RangeSelectionId');
    RegisterControl(TfmMarketingContactSelectionRange, '*_cboRangeSelection=RangeSelectionId');
  end;
end.
