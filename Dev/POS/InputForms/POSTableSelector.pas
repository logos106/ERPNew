unit POSTableSelector;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,
  TableCreatorComp, ExtCtrls, DNMPanel, StdCtrls, Buttons, DNMSpeedButton, DBAccess,
  MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, MemDS, ImgList;

type
  TfrmPOSTableSelectorGUI = class(TBaseInputGUI)
    dsFloorPlan: TDataSource;
    qryFloorPlan: TERPQuery;
    qryFloorPlanRoomPlanName: TWideStringField;
    DNMPanel2: TDNMPanel;
    cmdCancel: TDNMSpeedButton;
    BasicTables1: TBasicTables;
    ImageList1: TImageList;
    btnSetupRoom: TDNMSpeedButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure BasicTables1Error(const ErrMsg: string; const DialogType: TMsgDlgType);
    procedure BasicTables1CellSelected(const CellID: integer; const CellInfo: TCellInfo);
    procedure btnSetupRoomClick(Sender: TObject);

  private
    { Private declarations }
    iKeyID: integer;
    fbStartingUp: boolean;
    
  public
    { Public declarations }
    property KeyID: integer read iKeyID write iKeyID;

  end;

const
  ROOM_NAME: string = 'Roomdata';
  

implementation

uses FastFuncs, DNMLib, DNMExceptions,  POSScreenGUI, CommonLib,tcDataUtils,TableManagementForm;

{$R *.dfm}

procedure TfrmPOSTableSelectorGUI.FormCreate(Sender: TObject);
begin
  // Setup our query.
  inherited;
  fbStartingUp := true;
  
  with qryFloorPlan do begin
    ParamByName('ID').asInteger := KeyID;
  end;
end;

procedure TfrmPOSTableSelectorGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  // Close down our query controls.
  CloseQueries;

  // Free form from memory.
  Action := caFree;

  // NIL our Form Object.
//  frmPOSTableSelectorGUI := nil;
end;

procedure TfrmPOSTableSelectorGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      // Setup our Table Room Displayer Component.
      BasicTables1.RoomID         := KeyID;
      BasicTables1.IsTemplate     := false;
      BasicTables1.ShowScrollBars := false;
      BasicTables1.UseAutoResync  := true;
      BasicTables1.EditMode       := emInUse;
      BasicTables1.ShowTableIDs   := true;
      BasicTables1.GridColour     := BasicTables1.CanvasColour;
      BasicTables1.PlanName       := ROOM_NAME + IntToStr(KeyID);
      BasicTables1.LoadRoomData;
      BasicTables1.EditMode := emInUse;

      // State the startup procedure has successfully initialised.
      fbStartingUp := false;

      // Exception handler.
    except
      on EABort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmPOSTableSelectorGUI.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmPOSTableSelectorGUI.BasicTables1Error(const ErrMsg: string; const DialogType: TMsgDlgType);
begin
  inherited;
  if fbStartingUp then begin
    CommonLib.MessageDlgXP_Vista(ErrMsg, DialogType, [mbOK], 0);
    Close;
  end;
end;

procedure TfrmPOSTableSelectorGUI.BasicTables1CellSelected(const CellID: integer; const CellInfo: TCellInfo);
var
  iClientID: integer;
  sClientName: string;
begin
  inherited;
  // Yes, is this cell occupied by a table?
  if CellInfo.CellType = IsTable then begin
    // Yes, Ensure that the POSScreenGUI is open and instantiated.
    if FormStillOpen('TPOSScreenForm') then begin
      // Formulate Customer Name
      sClientName := 'Table' + IntToStr(CellInfo.TableID);  // + ' (' + GetTableRoomName(BasicTables1.RoomID) + ')';

      // Now fetch its ID.
      iClientID := GetClientID(sClientName);

      // Return this ID to POS Gui and the rest should be taken
      // care of in regards to fetching details.
      TPOSScreenForm(FindExistingComponent('TPOSScreenForm')).edtClientID.Text := IntToStr(iClientID);

      // Close form.
      Close;
    end;
  end;
end;

procedure TfrmPOSTableSelectorGUI.btnSetupRoomClick(Sender: TObject);
var
  tmpComponent:TComponent;
begin
  inherited;    
  if not FormStillOpen('TfrmTableManagement') then begin
    tmpComponent := GetComponentByClassName('TfrmTableManagement');
    If not Assigned(tmpComponent) then Exit;
    with TfrmTableManagement(tmpComponent) do begin
      KeyID := tcDataUtils.getFuncRoomID('DefaultRoom');
    //  FormStyle := fsMDIChild;
    //  BringToFront;
      ShowModal;
    end;
  end;
end;

initialization
  RegisterClassOnce(TfrmPOSTableSelectorGUI);

end.
