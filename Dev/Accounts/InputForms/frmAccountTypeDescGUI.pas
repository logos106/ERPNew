unit frmAccountTypeDescGUI;
{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 ??/??/?? 1.00.01  ???  Initial Version
 19/12/05 1.00.02  AL   Removed "Instance", added RegisterClass  *Task306*
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, DNMPanel, StdCtrls, Buttons, DNMSpeedButton,
  SelectionDialog, AppEvnts, DB,   kbmMemTable, Mask, DBCtrls,
  DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, MemDS, Shader, ImgList, ProgressDialog;

type
  TAccountTypeDescGUI = class(TBaseInputGUI)
    cmdCancel: TDNMSpeedButton;
    cmdOk: TDNMSpeedButton;
    cmdDefault: TDNMSpeedButton;
    Name_Label: TLabel;
    txtAccountType: TDBEdit;
    qryAcctypes: TERPQuery;
    DSAcctypes: TDataSource;
    memqryAcctypes: TkbmMemTable;
    Label1: TLabel;
    txtAccDesc: TDBEdit;
    qryAcctypesGlobalRef: TWideStringField;
    qryAcctypesAccType: TWideStringField;
    qryAcctypesAccDesc: TWideStringField;
    qryAcctypesOriginalDesc: TWideStringField;
    qryAcctypesEditedFlag: TWideStringField;
    qryAcctypesTypeID: TAutoIncField;
    qryAcctypesSortOrder: TIntegerField;
    Bevel1: TBevel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdOkClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdDefaultClick(Sender: TObject);
    procedure qryAcctypesAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    SID: integer;             
  end;

implementation
  
uses DNMLib, FormFactory, DNMExceptions, CommonLib;
{$R *.dfm}


  { TAccountTypeDescGUI }



procedure TAccountTypeDescGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
  
end;

procedure TAccountTypeDescGUI.cmdOkClick(Sender: TObject);
begin
  try
    if not Empty(txtAccDesc.Text) then begin
      if not (qryAcctypes.State in [dsBrowse]) then begin
        ProcessEditedFlag('Main', Self, memqryAcctypes, qryAcctypes, nil);
        qryAcctypes.Edit;
        qryAcctypes.Post;
        Notify;
      end;
      Self.Close;
    end else begin
      CommonLib.MessageDlgXP_Vista('Description cannot be blank.', mtWarning, [mbOK], 0);
      SetControlFocus(txtAccDesc);
    end;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TAccountTypeDescGUI.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TAccountTypeDescGUI.cmdDefaultClick(Sender: TObject);
begin
  inherited;
  qryAcctypes.Edit;
  qryAcctypesAccDesc.AsString := qryAcctypesOriginalDesc.AsString;
end;

procedure TAccountTypeDescGUI.qryAcctypesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(qryAcctypes, memqryAcctypes);
end;

procedure TAccountTypeDescGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if qryAcctypes.Active then begin
        if not (qryAcctypes.State in [dsBrowse]) then begin
          qryAcctypes.Post;
          Notify;
        end;
        CloseQueries;
      end;
      qryAcctypes.ParamByName('ID').asInteger := KeyID;
      OpenQueries;
      if KeyID = 0 then begin
        CommonLib.MessageDlgXP_Vista('Cannot Create New Account Types !', mtWarning, [mbOK], 0);
        Self.Close;
        Exit;
      end else begin
        qryAcctypes.Edit;
      end;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
    SetControlFocus(txtAccDesc);
  finally
    EnableForm;
  end;
end;

procedure TAccountTypeDescGUI.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
end;

initialization
  RegisterClassOnce(TAccountTypeDescGUI);
  with FormFact do begin
    RegisterMe(TAccountTypeDescGUI, 'TAccountTypesListGUI_*=TypeID');
    RegisterMe(TAccountTypeDescGUI, 'TAccountTypesListGUI_AccountTypes=TypeID');
  end;
end.
