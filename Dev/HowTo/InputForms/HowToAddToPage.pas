unit HowToAddToPage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, ComCtrls, AdvListV, CheckLst,
  Shader, DNMPanel, MenuCustomiseClasses;

type
  TfrmHowToAddToPage = class(TBaseInputGUI)
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkAllUsers: TCheckBox;
    cbPages: TCheckListBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryButtons: TERPQuery;
    qryHowTo: TERPQuery;
    qryWork: TERPQuery;
    qryCount: TERPQuery;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fHowToId: integer;
    fUserId: integer;
    fPrefGroup: string;
    fPrefName: string;
    fPackageId: integer;
    fPageConfig: TPageCollection;
    fMaxSelect: integer;
  protected
    procedure LoadPages;
    procedure OpenMyQueries;
    procedure AddButton(const PageName : string);
    procedure RemoveButton(const PageName : string);

    function LocateForAddition(const aPageName : string) : boolean;
    function TotalButtonCount(const aPageName : string) : integer;


    property UserId : integer read fUserId write fUserId;
    property PrefGroup : string read fPrefGroup write fPrefGroup;
    property PackageId : integer read fPackageId write fPackageId;
    property PrefName : string read fPrefName write fPrefName;
    property PageConfig : TPageCollection read fPageConfig write fPageConfig;
    property MaxSelect : integer read fMaxSelect write fMaxSelect;
  public
    { Public declarations }
    property HowToId : integer read fHowToId write fHowToId;
  end;

implementation

{$R *.dfm}
uses
  tcConst, AppEnvironment, CommonLib;

const
  csButtonCount = 'select PageName, count(*) Buttons from tblTrainingButtons'#13#10 +
                  'where ButtonId not in'#13#10 +
                  '(select T.ButtonId from tblTrainingButtons T'#13#10 +
                  'inner join tblTrainingButtons T1 on T.HowToId = T1.HowToId'#13#10 +
                  'where T.PageName=T1.PageName and'#13#10 +
                  'T1.Employeeid=%d and T.EmployeeId=0)'#13#10 +
                  'and HowToId=%d'#13#10 +
                  'group by PageName';

procedure TfrmHowToAddToPage.AddButton(const PageName: string);
var
  lCount : integer;
begin
  if not qryButtons.Active then
    qryButtons.Open;

  if LocateForAddition(PageName) then
  begin
    // Going to add
    lCount := TotalButtonCount(PageName);
    if lCount > MaxSelect then
    begin
      MessageDlgXP_Vista(Format(
        '%s Page Already Has %d Items. You Can Have Only %d Items In A Page', [PageName, lCount, MaxSelect]), mtWarning, [mbOK], 0);
      exit;
    end;
    // Can add
    qryButtons.Append;
    qryButtons.FieldByName('PageName').asString := PageName;
    qryButtons.FieldByName('HowToId').asInteger := HowToId;
    if chkAllUsers.Checked then
      qryButtons.FieldByName('EmployeeId').asInteger := 0
    else
      qryButtons.FieldByName('EmployeeId').asInteger := UserId;
    qryButtons.Post;
  end;
  (*
  if chkAllUsers.Checked then
  begin
    if not qryButtons.Locate('PageName;EmployeeId;HowToId', VarArrayOf([PageName, 0, HowToId]), [loCaseInsensitive]) then
    begin
      qryButtons.Append;
      qryButtons.FieldByName('PageName').asString := PageName;
      qryButtons.FieldByName('HowToId').asInteger := HowToId;
      qryButtons.FieldByName('EmployeeId').asInteger := 0;
      qryButtons.Post;
    end;
  end
  else
  begin
    if not qryButtons.Locate('PageName;EmployeeId;HowToId', VarArrayOf([PageName, UserId, HowToId]), [loCaseInsensitive]) then
    begin
      qryButtons.Append;
      qryButtons.FieldByName('PageName').asString := PageName;
      qryButtons.FieldByName('HowToId').asInteger := HowToId;
      qryButtons.FieldByName('EmployeeId').asInteger := UserId;
      qryButtons.Post;
    end;
  end;
*)
end;

procedure TfrmHowToAddToPage.btnOkClick(Sender: TObject);
var
  idx : integer;
begin
  inherited;
  qryCount.Close;
  qryCount.Open;

  qryCount.Connection.ExecSQL('DELETE FROM tblTrainingButtons where EmployeeId=' + IntToStr(UserId) + ' AND HowToId=-1', []);
  for idx := 0 to cbPages.Count - 1 do
  begin
    if cbPages.Checked[idx] then
    begin  // Need to add
      AddButton(cbPages.Items[idx]);
    end
    else
    begin  // Remove
      RemoveButton(cbPages.Items[idx]);
    end;

  end;
end;

procedure TfrmHowToAddToPage.FormCreate(Sender: TObject);
begin
  inherited;
  PageConfig := TPageCollection.Create;
  LoadPageConfigData(PageConfig, MainSwitchCustomiseRec);
  PrefGroup := PREF_GROUP_MAIN_SWITCH;
  PrefName := PREF_NAME_MAIN_SWITCH_MENU;
  PackageID := 0;
  UserID := AppEnv.Employee.EmployeeID;
  // values are from MenuCustomiseForm
  if not Devmode then
    MaxSelect := 24
  else
    MaxSelect := 36;

  qryCount.SQL.Text := Format(csButtonCount, [UserId, HowToId]);
end;

procedure TfrmHowToAddToPage.FormDestroy(Sender: TObject);
begin
  inherited;
//
  PageConfig.Free;
end;

procedure TfrmHowToAddToPage.FormShow(Sender: TObject);
begin
  inherited;
  // Load pages
  OpenMyQueries;
  LoadPages;
end;

procedure TfrmHowToAddToPage.LoadPages;
var
  I : integer;
begin
  if PageConfig.Count > 0 then
  begin
    cbPages.Clear;
    for I := 0 to PageConfig.Count - 1 do
    begin
      cbPages.Items.Add(PageConfig.Items[I].PageName);
      if (qryButtons.Locate('PageName;EmployeeId;HowToId', VarArrayOf([PageConfig.Items[I].PageName, UserId, HowToId]), [loCaseInsensitive])) or
         (qryButtons.Locate('PageName;EmployeeId;HowToId', VarArrayOf([PageConfig.Items[I].PageName, 0, HowToId]), [loCaseInsensitive])) then
         cbPages.Checked[i] := true;

    end;
    cbPages.ItemIndex := 0;

  end;

end;

function TfrmHowToAddToPage.LocateForAddition(const aPageName : string): boolean;
begin
  if chkAllUsers.Checked then
    Result :=  not qryButtons.Locate('PageName;EmployeeId;HowToId', VarArrayOf([aPageName, 0, HowToId]), [loCaseInsensitive])
  else
    Result := not qryButtons.Locate('PageName;EmployeeId;HowToId', VarArrayOf([aPageName, UserId, HowToId]), [loCaseInsensitive]);
end;

procedure TfrmHowToAddToPage.OpenMyQueries;
begin
  inherited;
  qryHowTo.ParamByName('HowToId').AsInteger := HowToId;
  qryHowTo.Open;
  qryButtons.ParamByName('HowToId').AsInteger := HowToId;
  qryButtons.Open;
end;

procedure TfrmHowToAddToPage.RemoveButton(const PageName: string);
begin
  if not qryButtons.Active then
    qryButtons.Open;

 if chkAllUsers.Checked then
  begin
    while qryButtons.Locate('PageName;HowToId', VarArrayOf([PageName, HowToId]), [loCaseInsensitive]) do
      qryButtons.Delete;
  end
  else
  begin
    if qryButtons.Locate('PageName;EmployeeId;HowToId', VarArrayOf([PageName, UserId, HowToId]), [loCaseInsensitive]) then
      qryButtons.Delete;
  end;
end;

function TfrmHowToAddToPage.TotalButtonCount(const aPageName: string): integer;
var
  lCount : integer;
begin
  if qryCount.Locate('PageName', aPageName, [loCaseInsensitive]) then
    lCount := qryCount.FieldByName('Buttons').AsInteger
  else
    lCount := 0;
  Result := lCount + PageConfig.GetButtoncount(aPageName);
end;

end.
