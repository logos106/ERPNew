unit frmBaselistingSelectionLookup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Menus, ExtCtrls, StdCtrls, wwdblook, wwcheckbox, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents , GuiPrefsObj;

type
  TfmBaselistingSelectionLookup = class(TfrmBaseGUI)
    cboQry: TERPQuery;
    cboQryID: TIntegerField;
    cboQryName: TWideStringField;
    pnl: TPanel;
    lblTitle: TLabel;
    Panel1: TPanel;
    cbo: TwwDBLookupCombo;
    chkAll: TwwCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure chkAllClick(Sender: TObject);
    procedure cboCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
  private
    fGuiPrefs: TFormGuiPrefs;
    fOnSelection: TNotifyEvent;
    fbShowInactive: Boolean;
    fslokkupQryfilter: String;
    //fiSelectedID: Integer;
    Procedure ReadguiPrefs;
    procedure SetLookupID(const Value: integer);
    function getLookupID: integer;
    function getUseAll: Boolean;
    procedure setUseAll(const Value: Boolean);
    procedure SetLookupCaption(const Value: String);
    procedure Setlookupcolor(const Value: TColor);
    procedure SetPnlalign(const Value: TAlign);
    function getpnlWidth: Integer;
    procedure setlokkupQryfilter(const Value: String);
    function getEnableLookup: Boolean;
    procedure setEnableLookup(const Value: Boolean);
    procedure setpnlWidth(const Value: Integer);
    function getFirstrecid: Integer;
    //procedure SetSelectedID(const Value: Integer);
  Protected
    Function DefaultID:Integer; virtual;
    Procedure InitInstance(AParent: TWIncontrol;fiLeft, fiTop, fiHeight: Integer; aAlign: TAlign; fGuiPrefs: TFormGuiPrefs;fOnSelection: TNotifyEvent; fUseAll, fSelectedID: Integer);
  public
    Procedure HideInstance;
    Procedure Writeguiprefs;
    Procedure HidePanel;
    Property GuiPrefs: TFormGuiPrefs read fGuiPrefs write fGuiPrefs;
    Property LookupID:integer read getLookupID write SetLookupID;
    Property UseAll :Boolean read getUseAll Write setUseAll;
    Property OnSelection :TNotifyEvent read fOnSelection write fOnSelection;
    Property ShowInactive :Boolean read fbShowInactive write fbShowInactive;
    Property LookupCaption :String write SetLookupCaption;
    Property lookupcolor :TColor write Setlookupcolor;
    Property PnlAlign: TAlign write SetPnlalign;
    Property pnlWidth :Integer read getpnlWidth write setpnlWidth;
    Property lokkupQryfilter:String read fslokkupQryfilter write setlokkupQryfilter;
    Property EnableLookup :Boolean read getEnableLookup write setEnableLookup;
    Property FirstRecID:Integer read getFirstrecid;
    //Property SelectedID :Integer read fiSelectedID write SetSelectedID;
  end;

implementation

uses CommonDbLib, CommonLib;

{$R *.dfm}

procedure TfmBaselistingSelectionLookup.cboCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  chkAll.Checked := False;
  if Assigned(fOnSelection) then fOnSelection(Sender);
end;

procedure TfmBaselistingSelectionLookup.chkAllClick(Sender: TObject);
begin
  inherited;
  if Screen.ActiveControl <> chkAll then exit;
  cbo.Enabled := not (chkAll.Checked);
  if not chkAll.Checked then Setcontrolfocus(cbo);
  if cbo.Text= '' then LookupID := DEfaultID;
  if Assigned(fOnSelection) then fOnSelection(Sender);
end;

function TfmBaselistingSelectionLookup.DefaultID: Integer;
begin
  REsult := 0;
end;

procedure TfmBaselistingSelectionLookup.FormCreate(Sender: TObject);
begin
  fbShowInactive:=False;
  //fiSelectedID:=0;
  fOnSelection := nil;
  fGuiPrefs := nil;
  inherited;
  cboQry.Connection := CommonDbLib.GetSharedMyDacConnection;
  chkAll.checked := False;

end;

function TfmBaselistingSelectionLookup.getEnableLookup: Boolean;
begin
  result := pnl.enabled;
end;

function TfmBaselistingSelectionLookup.getFirstrecid: Integer;
begin
  result := 0;
  if not cboqry.active then exit;
  if cboqry.recordcount =0 then exit;
  result := cboQryId.AsInteger;
end;

function TfmBaselistingSelectionLookup.getLookupID: integer;
begin
  result := 0;
  if  chkAll.Checked then exit;
  Result := cboQryId.AsInteger;
end;

function TfmBaselistingSelectionLookup.getpnlWidth: Integer;
begin
  REsult := pnl.Width;
  if pnl.AlignWithMargins then result := result + pnl.Margins.Left +pnl.Margins.Right;
end;

function TfmBaselistingSelectionLookup.getUseAll: Boolean;
begin
  Result := chkAll.Checked;
end;

procedure TfmBaselistingSelectionLookup.HideInstance;
begin
  pnl.Visible := False;
end;

procedure TfmBaselistingSelectionLookup.HidePanel;
begin
   pnl.BevelOuter :=bvNone;
   pnl.BevelInner :=bvNone;
end;

procedure TfmBaselistingSelectionLookup.InitInstance(AParent: TWIncontrol;fiLeft, fiTop, fiHeight: Integer; aAlign: TAlign; fGuiPrefs: TFormGuiPrefs;fOnSelection: TNotifyEvent; fUseAll, fSelectedID: Integer);
begin
  pnl.Parent := aParent;
  pnl.Visible := True;
  pnl.Left   := fiLeft;
  pnl.top    := fiTop;
  pnl.height := fiHeight;
  pnl.align  := aAlign;
  guiprefs        := fGuiPrefs;
  OnSelection     := fOnSelection;
  Readguiprefs;
  Opendb(cboQry);
  if fUseAll       > 0 then UseAll      := fUseAll=1;
  if fSelectedID  > 0 then begin LookupID   := fSelectedID; UseAll      := False; end;
end;

procedure TfmBaselistingSelectionLookup.ReadguiPrefs;
begin
  if fGuiPrefs = nil then exit;

  if GuiPrefs.Node.Exists('Options.UseAll') then chkAll.checked := GuiPrefs.Node['Options.UseAll'].asBoolean else chkAll.checked := TRue;
  if chkAll.checked =False then if GuiPrefs.Node.Exists('Options.LookupID') then LookupID:= GuiPrefs.Node['Options.LookupID'].asInteger;

end;

procedure TfmBaselistingSelectionLookup.setEnableLookup(const Value: Boolean);
begin
  pnl.enabled:= Value;
  //chkAll.Visible:= Value;
end;

procedure TfmBaselistingSelectionLookup.setlokkupQryfilter(const Value: String);
begin
  fslokkupQryfilter := Value;
  if fslokkupQryfilter = '' then exit;
  if cboQry.Filter <> '' then fslokkupQryfilter := '(' + fslokkupQryfilter +') and (' + cboQry.Filter +')';
  cboQry.Filter :=  fslokkupQryfilter;
  cboQry.Filtered := cboQry.Filter <> '';
end;

procedure TfmBaselistingSelectionLookup.SetPnlalign(const Value: TAlign);
begin
  pnl.align  := Value;
  if (value = alleft) or (value = alright) then pnl.width := 200
  else if (value = altop) or (value = albottom) then pnl.height:= 50;
end;

procedure TfmBaselistingSelectionLookup.SetLookupCaption(const Value: String);
begin
  lblTitle.caption := Value;
end;

procedure TfmBaselistingSelectionLookup.SetLookupID(const Value: integer);
begin
  opendb(cboQry);
  if Value <> 0 then begin
    if cboQry.Locate('ID' , Value , []) then begin
        chkAll.Checked := False;
        cbo.Text := cboQryName.AsString;
    end;
  end else begin
    chkAll.Checked := TRue;
  end;
end;

(*procedure TfmBaselistingSelectionLookup.SetSelectedID(const Value: Integer);
begin
  fiSelectedID := Value;
  cboQry.Locate('ID' , Value , []);
end;*)

procedure TfmBaselistingSelectionLookup.setpnlWidth(const Value: Integer);
begin
  pnl.Width := Value;
end;

procedure TfmBaselistingSelectionLookup.setUseAll(const Value: Boolean);
begin
  chkAll.Checked := Value;
end;

procedure TfmBaselistingSelectionLookup.Writeguiprefs;
begin
  if fGuiPrefs = nil then exit;
  GuiPrefs.Node['Options.UseAll'].asBoolean :=chkAll.checked ;
  GuiPrefs.Node['Options.LookupID'].asInteger := LookupID;
end;
procedure TfmBaselistingSelectionLookup.Setlookupcolor(const Value: TColor);
begin
  lblTitle.Font.Color := Value;
  cbo.Font.Color := Value;
  chkAll.Font.Color := Value;
end;

end.
