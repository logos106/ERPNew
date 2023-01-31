unit POSSalesmanGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, MyAccess,ERPdbComponents, Grids, DBGrids, StdCtrls, Buttons, DNMSpeedButton, BaseInputForm,
  MemDS, DBAccess, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  ExtCtrls, ImgList, ProgressDialog;

type
  TPOSSalesmanPopUp = class(TBaseInputGUI)
    dscEmployees: TDataSource;
    grdEmployees: TDBGrid;
    qryEmployees: TERPQuery;
    edtEmpID: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure edtEmpIDKeyPress(Sender: TObject; var Key: char);
    procedure grdEmployeesDblClick(Sender: TObject);
    procedure grdEmployeesKeyPress(Sender: TObject; var Key: char);
    procedure grdEmployeesEnter(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure edtEmpIDExit(Sender: TObject);
  private
    { Private declarations }
    bEmployeeSelected: boolean; // True if grid has been entered
    bNoExit: boolean;   // No exit from this form if true
  public
    { Public declarations }
    sName: string;
    function SetSalesName(const sID: string): boolean;
  end;

implementation

{$R *.dfm}

uses FastFuncs,CommonDbLib, CommonLib;

procedure TPOSSalesmanPopUp.FormCreate(Sender: TObject);
begin
  inherited;
  with qryEmployees do begin
    Connection := CommonDbLib.GetSharedMyDacConnection;
    Close;
    SQL.Clear;
    SQL.Add('SELECT EmployeeID, Concat(FirstName," ", LastName) as Name');
    SQL.Add('FROM tblEmployees WHERE Active = "T"');
    Open;
  end;

  // Initialize funcGrid options
  grdEmployees.Options := grdEmployees.Options + [dgRowSelect];

  edtEmpId.Text := '';
  bEmployeeSelected := false;
  bNoExit := false;
end;

procedure TPOSSalesmanPopUp.edtEmpIDKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then begin
    if SetSalesName(edtEmpID.Text) then begin
      ModalResult := mrOk;
    end else begin
      CommonLib.MessageDlgXP_Vista('Employee ID not found', mtWarning, [mbOK], 0);
      edtEmpID.Text := '';
      SetControlFocus(edtEmpID);
    end;
    Key := #0;
  end;
end;

function TPOSSalesmanPopUp.SetSalesName(const sID: string): boolean;
var
  qry: TERPQuery;
  iEmpID: integer;
  iCode: integer;
begin
  Val(edtEmpID.Text, iEmpID, iCode);
  if iCode = 0 then begin
    qry := TERPQuery.Create(nil);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      with qry do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT FirstName, LastName ');
        SQL.Add('FROM tblEmployees where EmployeeID = :xEmployeeID');
        ParamByName('xEmployeeID').asInteger := iEmpID;
        Open;
        if not IsEmpty then begin
          sName := FieldByName('FirstName').AsString + ' ' + FieldByName('LastName').AsString;
          Result := true;
        end else Result := false;
      end;
    finally
      FreeAndNil(qry);
    end;
  end else begin
    Result := false;
  end;
end;

procedure TPOSSalesmanPopUp.grdEmployeesDblClick(Sender: TObject);
begin
  sName := qryEmployees.FieldByName('Name').AsString;
  edtEmpID.Text := qryEmployees.FieldByName('EmployeeID').AsString;
  ModalResult := mrOk;
end;

procedure TPOSSalesmanPopUp.grdEmployeesKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then begin
    sName         := qryEmployees.FieldByName('Name').AsString;
    edtEmpID.Text := qryEmployees.FieldByName('EmployeeID').AsString;
    ModalResult   := mrOk;
  end;
end;

procedure TPOSSalesmanPopUp.grdEmployeesEnter(Sender: TObject);
begin
  edtEmpId.Text := '';
  bEmployeeSelected := true;
end;

procedure TPOSSalesmanPopUp.btnOKClick(Sender: TObject);
begin
  if char_length(edtEmpId.Text) <> 0 then begin
    SetSalesName(edtEmpId.Text);
  end else begin
    if bEmployeeSelected then begin
      sName := qryEmployees.FieldByName('Name').AsString;
      edtEmpID.Text := qryEmployees.FieldByName('EmployeeID').AsString;
    end else begin
      CommonLib.MessageDlgXP_Vista('No Employee ID Selected', mtWarning, [mbOK], 0);
      bNoExit := true;
    end
  end;
end;

procedure TPOSSalesmanPopUp.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if bNoExit then begin
    CanClose := false;
    bNoExit  := false;
  end else begin
    CanClose := true;
  end;
end;

procedure TPOSSalesmanPopUp.edtEmpIDExit(Sender: TObject);
begin
  inherited;
  if not Empty(edtEmpID.Text) and qryEmployees.Active then begin
    if qryEmployees.Locate('EmployeeID', edtEmpID.Text, [loCaseInsensitive]) then begin
      sName := qryEmployees.FieldByName('Name').AsString;
      edtEmpID.Text := qryEmployees.FieldByName('EmployeeID').AsString;
    end;
  end;
end;

initialization
  RegisterClassOnce(TPOSSalesmanPopUp);

end.


