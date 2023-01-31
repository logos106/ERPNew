unit ScopeList;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 16/11/05 1.00.00  MV   Initial verson.
 01/12/05 1.00.01  MV   Redesigned to support new daBase Class Objects
 02/12/05 1.00.02  MV   Modified to support additional calculated fields and
                        renamed module to frmScopeList.
 06/12/05 1.00.03  MV   Modified to support CategoryName Field required
                        datScopingAddin.
 08/12/05 1.00.04  MV   Added grpFiltersClick filter functionality
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, CustomInputBox, wwdblook, Shader,
  kbmMemTable;

type
  TScopeListForm = class(TBaseListingGUI)
    qryMainDAID: TIntegerField;
    qryEmployeeID: TMyQuery;
    qryMainEmployee: TStringField;
    qryMainReference: TStringField;
    qryMainScopeDefinition: TStringField;
    qryMainName: TStringField;
    qryMainActive: TStringField;
    qryMainDate: TDateField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure grpFiltersClick(Sender: TObject); override;
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
    FCategoryName: string;
    function GetCategoryName: string;
    procedure SetCategoryName(const Value: string);
  public
    { Public declarations }
    property CategoryName: string read GetCategoryName write SetCategoryName;
  end;

{var
  ScopeListForm: TScopeListForm;}

implementation

uses frmScopingInputForm, CommonLib;

{$R *.dfm}

procedure TScopeListForm.FormShow(Sender: TObject);
begin
  //Caption := CategoryName + 'List';
  inherited;
  // Open the main query
  qryMain.Open;
  //pnlHeader.Caption := CategoryName + 'List';
end;

procedure TScopeListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  // Close the main query
  qryMain.Close;
  qryEmployeeID.Close;
  //ScopeListForm := nil;
end;

procedure TScopeListForm.FormCreate(Sender: TObject);
begin
  GroupFilterString := 'Active = ' + QuotedStr('T');
  inherited;
  qryEmployeeID.Open;
end;

function TScopeListForm.GetCategoryName: string;
begin
  Result := FCategoryName;
end;

procedure TScopeListForm.SetCategoryName(const Value: string);
begin
  if FCategoryName <> Value then FCategoryName := Value;
end;

procedure TScopeListForm.grdMainDblClick(Sender: TObject);
begin
  inherited;   
  {Application.CreateForm(TUDDInputForm, UDDInputForm);
  UDDInputForm.CategoryName := CategoryName;
  UDDInputForm.KeyID := qryMain.FieldByName('DAID').AsInteger;
  UDDInputForm.Show;}

end;

procedure TScopeListForm.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Active = ' + QuotedStr('T');
      end;
    1: 
      begin
        GroupFilterString := 'Active = ' + QuotedStr('F');
      end;
    2:
      begin
        GroupFilterString := '';
      end;
  end;
  inherited;
end;

procedure TScopeListForm.cmdNewClick(Sender: TObject);
var
    Form :TScopingInputForm;
begin
  inherited;
    Form := TScopingInputForm(GetComponentByClassName('TScopingInputForm')) ;
    if Assigned(Form) then begin //if has acess
        with Form do begin
            AttachObserver(Self);
            FormStyle := fsMDIChild;
            BringToFront;
        end;
    end;
end;

initialization
  RegisterClassOnce(TScopeListForm);

finalization
  UnRegisterClass(TScopeListForm);
end.
