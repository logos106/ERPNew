unit frmPayDeptSelectionGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, DNMSpeedButton, StdCtrls,
  CheckLst, ImgList, wwcheckbox, MemDS, ProgressDialog, DNMPanel,
  IntegerListObj;

type
  TfrmPayDeptSelection = class(TBaseInputGUI)
    chkDepartments: TCheckListBox;
    DNMPanel1: TDNMPanel;
    DNMPanel3: TDNMPanel;
    DNMSpeedButton2: TDNMSpeedButton;
    DNMSpeedButton3: TDNMSpeedButton;
    DNMSpeedButton4: TDNMSpeedButton;
    chkShowSubTotals: TwwCheckBox;
    chkshowinactive: TwwCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure chkshowinactiveClick(Sender: TObject);
  private
    { Private declarations }

    procedure GetDepartments;
    Function IsClassActive(ClassID: Integer): boolean;
  Protected
    procedure updateSelectedList;
  public
    SelectedList: TStringList;
    FunctionMode: boolean;
    ReturnIDs: boolean;
  end;

  function DoDepartmentSelection(var DeptList: TStrings; var ShowSubtotals: boolean; HideShowSubTotals: boolean = false; ReturnIDs: boolean = false): boolean; overload;
  function DoDepartmentSelection(var DeptList: TIntegerList; var ShowSubtotals: boolean; HideShowSubTotals: boolean = false): boolean; overload;

implementation

uses
  CommonDBLib, CommonLib, DbSharedObjectsObj;
{$R *.dfm}

function DoDepartmentSelection(var DeptList: TIntegerList; var ShowSubtotals: boolean; HideShowSubTotals: boolean = false): boolean; overload;
var
  sl: TStrings;
begin
  sl := TStringList.Create;
  try
    sl.CommaText := DeptList.CommaText;
    result := DoDepartmentSelection(sl, ShowSubtotals, HideShowSubTotals, true);
    DeptList.CommaText := sl.CommaText;
  finally
    sl.Free;
  end;
end;


function DoDepartmentSelection(var DeptList: TStrings; var ShowSubtotals: boolean; HideShowSubTotals: boolean = false; ReturnIDs: boolean = false): boolean;
var
  form: TfrmPayDeptSelection;
begin
  result:= false;
  form:= TfrmPayDeptSelection.Create(nil);
  try
    form.ReturnIDs := ReturnIDs;
    form.SelectedList.Text:= DeptList.Text;
    form.FunctionMode:= true;
    form.chkShowSubTotals.Visible:= true;
    form.chkShowSubTotals.Checked:= ShowSubtotals;
    form.chkshowinactive.Visible:= not(ShowSubtotals);
    form.chkshowinactive.Checked := False;

    if HideShowSubTotals then begin
      form.chkShowSubTotals.Visible := false;
    end;
    if form.ShowModal = mrOk then begin
      result:= true;
      DeptList.Text:= form.SelectedList.Text;
      ShowSubtotals:= form.chkShowSubTotals.Checked;
    end;
  finally
    form.Free;
  end;
end;

procedure TfrmPayDeptSelection.GetDepartments; //( var chkDepartments: TStrings);
begin
  chkDepartments.Clear;
  with TERPQuery.Create(nil) do try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.Add('SELECT ClassName,Active,ClassId FROM tblclass ' +
              iif(chkshowinactive.checked , '' , ' WHERE Active = "T" ') +
              ' ORDER BY ClassName');
      Open;
      while not Eof do begin
        chkDepartments.Items.AddObject(FieldByName('ClassName').AsString, TObject(FieldByName('ClassId').AsInteger));
        Next;
      end;
    finally
      Free;
    end;
end;


function TfrmPayDeptSelection.IsClassActive(ClassID: Integer): boolean;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Qry.SQL.Text := 'Select Active from tblclass where classId =' + inttostr(ClassID);
    Qry.open;
    result := Qry.Fieldbyname('Active').AsBoolean
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TfrmPayDeptSelection.FormShow(Sender: TObject);
var
  x: integer;
  classId: integer;
begin
  inherited;
  chkDepartments.MultiSelect := True;
  GetDepartments;//(chkDepartments);
  if SelectedList.Count > 0 then begin
    for x:= 0 to SelectedList.Count -1 do begin
      if ReturnIDs then begin
        classID := StrToInt(SelectedList[x]);
        if chkDepartments.Items.IndexOfObject(TObject(classId)) >= 0 then
          chkDepartments.Checked[chkDepartments.Items.IndexOfObject(TObject(classId))] := true;
      end
      else
        chkDepartments.Checked[x]:= SelectedList.IndexOf(chkDepartments.Items[x]) >= 0;
    end;
  end;
end;
Procedure TfrmPayDeptSelection.updateSelectedList;
var
  x: integer;
begin
  SelectedList.Clear;
    for x:= 0 to chkDepartments.Count -1 do begin
      if chkDepartments.Checked[x] then begin
        if self.ReturnIDs then
          SelectedList.Add(IntToStr(Integer(chkDepartments.Items.Objects[x])))
        else
          SelectedList.Add(chkDepartments.Items[x]);
      end;
    end;
end;
procedure TfrmPayDeptSelection.btnSaveClick(Sender: TObject);
  function AnyChecked: boolean;
  var i: integer;
  begin
    result:= false;
    for i := 0 to chkDepartments.Count -1 do begin
      if chkDepartments.Checked[i] then begin
        result := true;
        break;
      end;
    end;
  end;

begin
  if FunctionMode then begin
    updateSelectedList;
  end else begin
    if not AnyChecked then begin
      Self.ModalResult := mrNone;
      CommonLib.MessageDlgXP_Vista('You have not selected any Departments.', mtInformation,      [mbOk], 0);
      Exit;
    end;
  end;
  inherited;

end;

procedure TfrmPayDeptSelection.chkshowinactiveClick(Sender: TObject);
var
  x:Integer;
begin
  inherited;
  if chkshowinactive.Checked= False then
    for x:= 0 to chkDepartments.Count -1 do begin
      if (chkDepartments.Checked[x] = true) and (not(IsClassActive(Integer(chkDepartments.Items.Objects[x]))))  then
        chkDepartments.Checked[x] := False;
    end;
  inherited;
  Formshow(Nil);
end;

procedure TfrmPayDeptSelection.DNMSpeedButton1Click(Sender: TObject);
var
  x:Integer;
begin
  inherited;
    for x:= 0 to chkDepartments.Count -1 do begin
      if chkDepartments.Checked[x] = false then
        chkDepartments.Checked[x] := True;
    end;
end;

procedure TfrmPayDeptSelection.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmPayDeptSelection.FormCreate(Sender: TObject);
begin
  inherited;
  FunctionMode:= false;
  SelectedList:= TStringList.Create;
end;

procedure TfrmPayDeptSelection.FormDestroy(Sender: TObject);
begin
  SelectedList.Free;
  inherited;
end;

initialization
  RegisterClassOnce(TfrmPayDeptSelection);
end.
