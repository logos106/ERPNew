unit CreateIndustry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, Buttons, StdCtrls, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, DAScript, MyScript;

type
  TfrmCreateIndustry = class(TForm)
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    lstIndustries: TListBox;
    edtIndustry: TEdit;
    Label4: TLabel;
    btnCreate: TSpeedButton;
    qryList: TERPQuery;
    qryPref: TERPQuery;
    scr: TERPScript;
    procedure btnCancelClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    fIndustryId: integer;
    fIndustryName: string;
    { Private declarations }
  protected
    procedure RefreshList;
    procedure CreatePreferences;
    procedure ConfirmSwitch(aNew : boolean);
    property IndustryId : integer read fIndustryId write fIndustryId;
    property IndustryName : string read fIndustryName write fIndustryName;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}
uses
  Main, CommonLib, CommonDBLib, tcTypes, MenuCustomiseClasses, AppEnvironment;

procedure TfrmCreateIndustry.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCreateIndustry.btnCreateClick(Sender: TObject);
var
  idx : integer;
begin
  if edtIndustry.Text = '' then
  begin
    MessageDlgXP_Vista('New Indistry Name Is Empty.'#13#10'Cannot Create Industry Without Name', mtWarning, [mbOk], 0);
    exit;
  end;

  for idx := 0 to lstIndustries.Items.Count - 1 do
    if SameText(edtIndustry.Text, lstIndustries.Items[idx]) then
    begin
      MessageDlgXP_Vista('Industry With Name "' + lstIndustries.Items[idx] + '" Already Exists.'#13#10'Cannot Create Industry With Duplicate Name',
        mtWarning, [mbOk], 0);
      exit;
    end;
  qryList.Append;
  qryList.FieldByName('IndustryName').AsString := edtIndustry.Text;
  qryList.Post;
  IndustryId := qryList.FieldByName('IndustryId').asInteger;
  IndustryNAme := edtIndustry.Text;
  CreatePreferences;

  ConfirmSwitch(true);

  RefreshList;
end;

procedure TfrmCreateIndustry.btnOkClick(Sender: TObject);
begin
  ConfirmSwitch(false);
  ModalResult := mrOk;
  Close;
end;

procedure TfrmCreateIndustry.ConfirmSwitch(aNew: boolean);
var
  s : string;
  idx : integer;
  lId : integer;
begin
  s := '';
  lId := 0;
  if aNew then
  begin
    s := 'New Industry "' + IndustryName + '" Has Been Created.'#13#10;
    lId := IndustryId;
  end
  else
  begin
    for idx := 0 to lstIndustries.Count - 1 do
      if lstIndustries.Selected[idx] then
      begin
        lId := integer(lstIndustries.Items.Objects[idx]);
        s := 'You Have Selected Industry "' + lstIndustries.Items[idx] + '"'#13#10;
        Break;
      end;
  end;

  if MessageDlgXP_Vista(s + 'Would You Like To Switch to This Industry?',
    mtConfirmation, [mbYes,mbNo], 0) = mrYes then
  begin
    AppEnv.CompanyInfo.IndustryId := lId;
    AppEnv.CompanyInfo.Save;
    MainForm.TerminateApp;
  end;
end;

procedure TfrmCreateIndustry.CreatePreferences;
var
  sId,
  sIndustry,
  sUser : string;
  iId,
  lId : integer;
begin
  sUser := IntToStr(AppEnv.Employee.EmployeeID);
  sIndustry := IntToStr(IndustryId);
  qryPref.Close;
  qryPref.Connection.StartTransaction;
  try

  qryPref.SQL.Text := 'Select max(id) from tblPageLayout';
  qryPref.Open;
  iId := qryPref.Fields[0].AsInteger + 1;
  sId := IntToStr(iId);
  // copy all preferences of the current employee/industry to the new industry for the same employee
  qryPref.Close;
  qryPref.SQL.Clear;
  qryPref.SQL.Text := 'insert into tblPreferences (PackageId, UserId, UserName, PrefGroup, PrefName, PrefType,PrefValue, PrefDesc, Department, IndustryId)';
  qryPref.sql.Add('select PackageId, UserId, UserName, PrefGroup, PrefName, PrefType,PrefValue, PrefDesc, Department,' + IntToStr(IndustryId));
  qryPref.sql.Add('from tblPreferences');
  qryPref.sql.Add('where UserId=' + IntToStr(AppEnv.Employee.EmployeeId) + ' and IndustryId=' + IntToStr(AppEnv.CompanyInfo.IndustryId));
  qryPref.ExecSQL;

  qryPref.Close;
  qryPref.SQL.Clear;
  (*
  qryPref.SQL.Text := 'insert into tblpagelayout (Packageid, UserId, PageName, ActionName,EndActionName, TopLeft, Top, Width, Height, NodeType, LineWidth, LineHeads,';
  qryPref.sql.add('LineColor, SelectedColor,MarkColor, MarkSize, ArrowColor, LineStyle, Arrow1Kind, Arrow2Kind, Active, IndustryId, id)');
  qryPref.sql.add('select Packageid,' + sUser + ', PageName, ActionName,EndActionName, TopLeft, Top, Width, Height, NodeType, LineWidth, LineHeads,');
  qryPref.sql.add('LineColor, SelectedColor,MarkColor, MarkSize, ArrowColor, LineStyle, Arrow1Kind, Arrow2Kind, Active,');
  qryPref.SQL.Add(sIndustry + ',' + IntToStr(id));
  qryPref.sql.add('from tblPageLayout where userid=' + IntToStr(FromUserId) + ' and Active = "T" and IndustryId=' + IntToStr(AppEnv.CompanyInfo.IndustryId));
  qryPref.ExecSQL;
  *)
  qryPref.SQL.Text := 'select * from tblPageLayout where userid=' + sUser + ' and IndustryId =' + IntToStr(AppEnv.CompanyInfo.IndustryId) +
     ' and Active="T"';
  qryPref.Open;
  scr.SQL.Clear;
  try
    if qryPref.RecordCount = 0 then
      exit;
    lId := qryPref.Fieldbyname('id').AsInteger;
    while not qryPref.eof do
    begin
      if lId <> qryPref.FieldByName('id').asInteger then
      begin
        lId := qryPref.Fieldbyname('id').AsInteger;
        iId := iId + 1;
        sId := IntToStr(iId);
      end;

      scr.SQL.Add('insert into tblpagelayout (Packageid, UserId, PageName, ActionName,EndActionName, TopLeft, Top, Width, Height, NodeType, LineWidth, LineHeads,');
      scr.sql.add('LineColor, SelectedColor,MarkColor, MarkSize, ArrowColor, LineStyle, Arrow1Kind, Arrow2Kind, Active, IndustryId, id)');
      scr.SQL.Add('values (');
      scr.SQL.Add(Format('%s, %s,"%s","%s","%s",%s,%s,%s,%s,%s,%s,%s,',
        [qryPref.Fieldbyname('Packageid').asString, qryPref.Fieldbyname('UserId').asString, qryPref.Fieldbyname('PageName').asString,
         qryPref.Fieldbyname('ActionName').asString,qryPref.Fieldbyname('EndActionName').asString,
         qryPref.Fieldbyname('TopLeft').asString, qryPref.Fieldbyname('Top').asString,
         qryPref.Fieldbyname('Width').asString, qryPref.Fieldbyname('Height').asString, qryPref.Fieldbyname('NodeType').asString,
         qryPref.Fieldbyname('LineWidth').asString, qryPref.Fieldbyname('LineHeads').asString]));
      scr.SQL.Add(Format('%s,%s,%s,%s,%s,%s,%s,%s,"T",' + sIndustry + ',' + sId + ');',
        [qryPref.Fieldbyname('LineColor').asString, qryPref.Fieldbyname('SelectedColor').asString,qryPref.Fieldbyname('MarkColor').asString,
         qryPref.Fieldbyname('MarkSize').asString, qryPref.Fieldbyname('ArrowColor').asString, qryPref.Fieldbyname('LineStyle').asString,
         qryPref.Fieldbyname('Arrow1Kind').asString, qryPref.Fieldbyname('Arrow2Kind').asString]));
      qryPref.Next;
    end;
  finally
    if scr.SQL.Count > 0 then
      scr.Execute;
    qryPref.Close;
    qryPref.Connection.Commit;
  end;
  except
    qryPref.connection.Rollback;
  end;
end;

procedure TfrmCreateIndustry.FormShow(Sender: TObject);
begin
  qryList.Connection := GetSharedMyDacConnection;
  qryPref.Connection := qryList.Connection;
  scr.Connection :=  qryList.Connection;
  RefreshList;
  edtIndustry.Text := '';
end;

procedure TfrmCreateIndustry.RefreshList;
begin
  qryList.Close;
  qryList.Open;
  lstIndustries.Items.Clear;
  while not qryList.Eof do
  begin
    lstIndustries.Items.AddObject(qryList.FieldByName('IndustryName').AsString, pointer(qryList.FieldByName('IndustryId').AsInteger));
    qryList.Next;
  end;
end;

end.
