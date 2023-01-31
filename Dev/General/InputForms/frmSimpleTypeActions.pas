unit frmSimpleTypeActions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, DNMSpeedButton, Grids, Wwdbigrd, Wwdbgrid, Shader, DNMPanel,
  wwdblook, busobjSimpletypeActions, BusObjBase, ProgressDialog;

type
  TfmSimpleTypeActions = class(TBaseInputGUI)
    pnlTop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    grdTypes: TwwDBGrid;
    DNMPanel1: TDNMPanel;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qrySimpleTypeActions: TERPQuery;
    dsSimpleTypeActions: TDataSource;
    qrySimpleTypeActionsGlobalref: TWideStringField;
    qrySimpleTypeActionsID: TIntegerField;
    qrySimpleTypeActionsChoice: TWideStringField;
    qrySimpleTypeActionsSeqno: TIntegerField;
    qrySimpleTypeActionsSimpletypeId: TIntegerField;
    qrySimpleTypeActionsSimpletypeName: TWideStringField;
    qrySimpleTypeActionssimpletypecode: TWideStringField;
    qrySimpleTypeActionsActive: TWideStringField;
    qrySimpleTypeActionsmsTimeStamp: TDateTimeField;
    qrySimpleTypes: TERPQuery;
    qrySimpleTypesName: TWideStringField;
    cboStatus: TwwDBLookupCombo;
    DNMSpeedButton1: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    qrySimpleTypesId: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure cboStatusCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboStatusNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; var Accept: Boolean);
    procedure grdTypesExit(Sender: TObject);

  private
    SimpleTypeActions :TSimpleTypeActions;
    fsTypeToShow: String;
    Procedure RefreshQuery;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Property TypeToShow :String read fsTypeToShow write fsTypeToShow;
    class procedure ListSimpleTypeActions(const aType: string; ismodal:Boolean = False);
  end;


implementation

uses CommonLib, CommonDbLib, BusObjConst, tcDataUtils, frmSimpleTypes,
  FastFuncs;

{$R *.dfm}
{ TfmSimpleTypeActions }

class procedure TfmSimpleTypeActions.ListSimpleTypeActions(
  const aType: string; ismodal:Boolean = False);
var
  form: TfmSimpleTypeActions;
begin
  form :=TfmSimpleTypeActions(GetComponentByClassName('TfmSimpleTypeActions' , False ));
  if not Assigned(Form) then exit;
  Form.TypeToShow := atype;
  if ismodal then begin
    Form.Showmodal;
  end else begin
    Form.FormStyle := fsMDIChild;
    Form.Bringtofront;
  end;
end;


procedure TfmSimpleTypeActions.FormCreate(Sender: TObject);
begin
  inherited;
  fsTypeToShow := '';
  SimpleTypeActions :=TSimpleTypeActions.create(Self);
  SimpleTypeActions.connection := TMyDacDataConnection.create(SimpleTypeActions);
  SimpleTypeActions.Connection.Connection := MyConnection;
  SimpleTypeActions.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmSimpleTypeActions.FormShow(Sender: TObject);
begin
  inherited;
  SimpleTypeActions.LoadSelect('simpletypecode = ' +quotedStr(TypeToShow));
  closeDb(qrySimpleTypes);   qrySimpleTypes.Parambyname('typecode').asString := TypeToShow;   OpenDB(qrySimpleTypes);
  SimpleTypeActions.Connection.BeginTransaction;
end;


procedure TfmSimpleTypeActions.btnOkClick(Sender: TObject);
begin
  inherited;
  SimpleTypeActions.PostDB;
  SimpleTypeActions.Connection.CommitTransaction;
  Self.close;
end;

procedure TfmSimpleTypeActions.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmSimpleTypeActions.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  SimpleTypeActions.Connection.RollbackTransaction;
  Action := caFree;
end;

procedure TfmSimpleTypeActions.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  if SimpleTypeActions.BOF then exit;
  SimpleTypeActions.Connection.BeginTransaction;
  SimpleTypeActions.Connection.BeginNestedTransaction;
  try
    SimpleTypeActions.Seqno := SimpleTypeActions.Seqno - 1;
    SimpleTypeActions.PostDB;
    SimpleTypeActions.Prior;
    SimpleTypeActions.Seqno := SimpleTypeActions.Seqno +1;
    SimpleTypeActions.PostDb;
    SimpleTypeActions.Connection.CommitNestedTransaction;
  Except
    on E:Exception do begin
      SimpleTypeActions.Connection.RollbackNestedTransaction;
      Exit;
    end
  end;
  RefreshQuery;
end;

procedure TfmSimpleTypeActions.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  if SimpleTypeActions.EOF then exit;
  SimpleTypeActions.Connection.BeginTransaction;
  SimpleTypeActions.Connection.BeginNestedTransaction;
  try
    SimpleTypeActions.Seqno := SimpleTypeActions.Seqno + 1;
    SimpleTypeActions.PostDB;
    SimpleTypeActions.Next;
    SimpleTypeActions.Seqno := SimpleTypeActions.Seqno -1;
    SimpleTypeActions.PostDb;
    SimpleTypeActions.Connection.CommitNestedTransaction;
  Except
    on E:Exception do begin
      SimpleTypeActions.Connection.RollbackNestedTransaction;
      Exit;
    end
  end;
  RefreshQuery;

end;

procedure TfmSimpleTypeActions.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TSimpleTypeActions then
      TSimpleTypeActions(Sender).Dataset := qrySimpleTypeActions;
  end;

end;

procedure TfmSimpleTypeActions.RefreshQuery;
var
  bm:TBookmark;
begin
  try
    bm:=qrySimpleTypeActions.GetBookmark;
    try
      closeDb(qrySimpleTypeActions);
      OpenDb(qrySimpleTypeActions);
    finally
      qrySimpleTypeActions.GotoBookmark(bm);
      qrySimpleTypeActions.FreeBookmark(bm);
    end;
  Except
      // kill the exception f bookmark not found
  end;
end;

procedure TfmSimpleTypeActions.cboStatusCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if Modified = false then Exit;
  inherited;
  SimpleTypeActions.SimpletypeId := qrySimpleTypesId.asInteger;
end;

procedure TfmSimpleTypeActions.cboStatusNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  inherited;

  fLastComboAccessed := cboStatus;
  Accept := False;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    if TfmSimpleTypes.DoSimpleTypesAddNew(TypeToShow,NewValue) then begin
      Accept:= true;
      LookupTable.Refresh;
      if LookupTable.Locate('Name' , NewValue, []) then begin
          SimpleTypeActions.SimpletypeName := qrySimpleTypesName.asString;
          SimpleTypeActions.SimpletypeId := qrySimpleTypesId.asInteger;
          SimpleTypeActions.PostDb;
      end;
    end;
  end;  
end;


procedure TfmSimpleTypeActions.grdTypesExit(Sender: TObject);
begin
  inherited;
  SimpleTypeActions.PostDB;
end;

initialization
  RegisterClassOnce( TfmSimpleTypeActions);

end.
