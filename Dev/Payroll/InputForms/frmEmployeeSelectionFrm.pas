unit frmEmployeeSelectionFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, CheckLst,
  DNMSpeedButton, wwcheckbox, MemDS, ImgList;

type
  TfrmEmployeeSelection = class(TBaseInputGUI)
    chkEmployees: TCheckListBox;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkSelectAll: TwwCheckBox;
    Label1: TLabel;
    Bevel1: TBevel;
    procedure FormShow(Sender: TObject);
    procedure chkSelectAllClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private

  public
     procedure GetEmployees(iAwardID:integer);
  end;



implementation

{$R *.dfm}
uses
  CommonDBLib,CommonLib, FastFuncs;
  
procedure TfrmEmployeeSelection.GetEmployees(iAwardID:integer);
begin
  chkEmployees.Clear;
  with TERPQuery.Create(nil) do try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.Add('SELECT EmployeeName,Active,EmployeeID FROM tblemployees ');
      SQL.Add('WHERE  Award = ' + IntToStr(iAwardID));
      SQL.Add(' AND Active = "T"');
      SQL.Add(' ORDER BY EmployeeName');
      Open;
      while not Eof do begin
        if fieldbyname('Active').asBoolean then
            chkEmployees.Items.Add(FieldByName('EmployeeName').AsString);
        Next;
      end;
    finally
      Free;
    end;
end;

procedure TfrmEmployeeSelection.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    chkEmployees.MultiSelect := True;
    chkSelectAll.Checked := False;
  finally
    EnableForm;
  end;  
end;

procedure TfrmEmployeeSelection.chkSelectAllClick(Sender: TObject);
var
  iEmployees,i:integer;
begin
  inherited;
  iEmployees := chkEmployees.Items.Count;
  if TwwCheckbox(Sender).Checked = True then begin
    chkEmployees.SelectAll;
    for i := 0 to iEmployees - 1 do begin
      chkEmployees.Checked[i] := True;
    end;
    Label1.Caption := 'Unselect all';
  end else begin
    for i := 0 to iEmployees - 1 do begin
      chkEmployees.Checked[i] := False;
      chkEmployees.Selected[i] := False;
    end;
    Label1.Caption := 'Select all';
  end;
end;

procedure TfrmEmployeeSelection.btnSaveClick(Sender: TObject);
begin
  if chkEmployees.SelCount < 1 then begin
    Self.ModalResult := mrNone;
    CommonLib.MessageDlgXP_Vista('You have not selected any Employees.', mtInformation,      [mbOk], 0);
    Exit;
  end;
  inherited;
end;

initialization
RegisterClassOnce(TfrmEmployeeSelection);
end.
