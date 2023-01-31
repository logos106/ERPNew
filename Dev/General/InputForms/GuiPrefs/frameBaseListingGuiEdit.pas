unit frameBaseListingGuiEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, frameGuiElementEdit, StdCtrls, wwclearbuttongroup, wwradiogroup,
  BaseListingForm, Buttons, DNMSpeedButton, Mask, wwdbedit, Wwdotdot, Wwdbcomb, ExtCtrls,
  DNMPanel;

type
  TfrBaseListingGuiEdit = class(TfrGuiElementEdit)
    pnlBaseListing: TDNMPanel;
    rgCustomisedReport: TGroupBox;
    ReportGUI: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtReportName: TEdit;
    cboReportTab: TwwDBComboBox;
    btnSaveCustomisedReport: TDNMSpeedButton;
    procedure btnSaveCustomisedReportClick(Sender: TObject);
  private
    function GetBaseListing: TBaseListingGUI;
    function CustomReportExists(Const FormClassName, ReportName: string; Const UserId: integer): boolean;
    procedure AddCustomReport(Const FormClassName, ReportName, ReportTab: string; Const UserId: integer);
  private
    property BaseListing: TBaseListingGUI read GetBaseListing;
  private
  public
    procedure DisplayGuiSettings(fUserID:Integer =0); override;
  end;

var
  frBaseListingGuiEdit: TfrBaseListingGuiEdit;

implementation

{$R *.dfm}

uses
  Forms, GuiPrefsObj, MyAccess,ERPdbComponents, CommonDbLib,  CommonLib, AppEnvironment,
  FastFuncs;


{ TfrBaseListingGuiEdit }

function TfrBaseListingGuiEdit.GetBaseListing: TBaseListingGUI;
begin
  if Assigned(TBaseListingGuiElement(Element).BaseListingForm) then
    Result    := TBaseListingGUI(TBaseListingGuiElement(Element).BaseListingForm)
  else Result := nil;
end;

procedure TfrBaseListingGuiEdit.DisplayGuiSettings(fUserID:Integer =0);
var
  PrefsCompanyWide: boolean;

  procedure DisableAllControls(Const aPanel: TPanel);
  var 
    x: integer;
  begin
    for x := 0 to aPanel.ControlCount - 1 do begin
      if aPanel.Controls[x] is TPanel then DisableAllControls(TPanel(aPanel.Controls[x]))
      else aPanel.Controls[x].Enabled := false;
    end;
  end;
begin
  inherited;
  edtReportName.Text := '';
  // if we are editing the settings for the grid used for setting user global
  // base listing grid settings only allow user to edit properties that apply
  // to all base listing grids.
  if self.BaseListing.isPrefSettingsForm(PrefsCompanyWide) then begin
    DisableAllControls(pnlBaseListing);

    if PrefsCompanyWide then self.EditGuiPrefsForm.rgUserType.ItemIndex := 1 // Global
    else self.EditGuiPrefsForm.rgUserType.ItemIndex := 0;                    // User
    self.EditGuiPrefsForm.rgUserType.Enabled  := false;
    self.EditGuiPrefsForm.btnDefaults.Enabled := false;
  end else begin
    cboReportTab.ItemIndex := -1;
    if Element.FormGuiPrefs.UserType = puGlobal then begin
      edtReportName.Enabled := false;
      cboReportTab.Enabled := false;
      btnSaveCustomisedREport.Enabled := false;
    end else if Node.Exists('CustomReportName') then begin
      edtReportName.Text := Node['CustomReportName'].AsString;
      if Node.Exists('CustomReportGroup') then begin
        cboReportTab.ItemIndex := cboReportTab.Items.IndexOf(Node['CustomReportGroup'].AsString)
      end;
      edtReportName.Enabled := false;
      cboReportTab.Enabled := false;
      btnSaveCustomisedREport.Enabled := false;
    end else begin
      edtReportName.Enabled := true;
      cboReportTab.Enabled := true;
      btnSaveCustomisedREport.Enabled := true;
    end;
  end;
end;


function TfrBaseListingGuiEdit.CustomReportExists(Const FormClassName, ReportName: string; Const UserId: integer): boolean;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text   := 'SELECT * FROM tblCustomizedLists WHERE' + ' ClassName = ' + QuotedStr(FormClassName)
      + ' AND Report = ' + QuotedStr(ReportName) + ' AND EmployeeId = ' + IntToStr(UserId);
    qry.Open;
    Result := not qry.IsEmpty;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TfrBaseListingGuiEdit.AddCustomReport(Const FormClassName, ReportName, ReportTab: string; Const UserId: integer);
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text   := 'INSERT HIGH_PRIORITY INTO tblCustomizedLists SET' + ' ClassName = ' + QuotedStr(FormClassName) +
      ',' + ' Report = ' + QuotedStr(ReportName) + ',' + ' ReportTab = ' + QuotedStr(ReportTab) + ',' +
      ' EmployeeId = ' + IntToStr(UserId);
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TfrBaseListingGuiEdit.btnSaveCustomisedReportClick(Sender: TObject);
begin
  inherited;
  if edtReportName.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('No Report Name specified.', mtInformation, [mbOK], 0);
    SetControlFocus(edtReportName);
  end else if CustomReportExists(BaseListing.ClassName, edtReportName.Text,
    AppEnv.Employee.EmployeeID) then begin
    CommonLib.MessageDlgXP_Vista('You already have a report using this name.', mtInformation, [mbOK], 0);
    SetControlFocus(edtReportName);
  end else begin
    AddCustomReport(BaseListing.ClassName, edtReportName.Text, cboReportTab.Text, AppEnv.Employee.EmployeeID);
    Node['CustomReportName'].AsString   := edtReportName.Text;
    Node['CustomReportGroup'].AsString  := cboReportTab.Text;
    BaseListing.CustomReportName        := edtReportName.Text;
    self.Element.FormGuiPrefs.PrefsName := edtReportName.Text;
    self.Element.FormGuiPrefs.SavePrefs;
    EditGuiPrefsForm.Close;
  end;
end;

initialization
  RegisterClassOnce(TfrBaseListingGuiEdit);

finalization
  UnRegisterClass(TfrBaseListingGuiEdit);
end.
