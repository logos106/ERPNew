unit frmSelectAccountsForReportsAccount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmChartOfAccountsTree, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, ImgList,
  Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, StdCtrls,
  ExtCtrls, Shader, wwdbdatetimepicker, VirtualTrees, DNMSpeedButton,
  DNMPanel, AccountsSelectedForReports, ProgressDialog , TypesLib;

type


  TfmSelectAccountsForReportsAccount = class(TfmChartOfAccountsTree)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fsAccountType: String;
    fSelectedAccounts: TSelectedAccountsforReports;
    Procedure REfreshGrid;
    { Private declarations }
  Protected
    procedure TreeDoubleClick(Node: PVirtualNode; Column: TColumnIndex); override;
  public
    Procedure RefreshTree; override;
    Property AccountType :String read fsAccountType Write fsAccountType;
    Property SelectedAccounts :TSelectedAccountsforReports Read fSelectedAccounts Write fSelectedAccounts;
    class Function instanceforAccountType(fsAccountType:String; AOwner: TComponent):TfmSelectAccountsForReportsAccount;
  end;


implementation

uses CommonLib, BaseTreeView, BusObjBase, FastFuncs ;

{$R *.dfm}

procedure TfmSelectAccountsForReportsAccount.TreeDoubleClick(Node: PVirtualNode;
  Column: TColumnIndex);
var
  Rec: PNodeRec;
begin
  Rec := Tree.GetNodeData(Node);
  if Tree.GetNodeLevel(Tree.GetFirstSelected) = 0 then begin
    // this is an Account Type so no drill down
  end else begin
    if not assigned(SelectedAccounts) then Exit;
    if SelectedAccounts.Locate('AccountID' ,Rec^.Data.Id , []) = False then begin
        SelectedAccounts.New;
        SelectedAccounts.AccountID    :=  Rec^.Data.Id;
        SelectedAccounts.AccountType  :=  Rec^.Data.cellData[16].asString;
        SelectedAccounts.PostDB;
        RefreshTree;
        RefreshGrid;
    end;
  end;
end;

procedure TfmSelectAccountsForReportsAccount.FormCreate(Sender: TObject);
begin
  inherited;
  fbTabSettingEnabled := false;
// turn on full row selection
  Tree.TreeOptions.SelectionOptions := Tree.TreeOptions.SelectionOptions + [toFullRowSelect];

  Self.Columns.HeaderColor := pnlTop.Color;
  AccountType := '';
end;

class function TfmSelectAccountsForReportsAccount.instanceforAccountType(fsAccountType: String; AOwner: TComponent): TfmSelectAccountsForReportsAccount;
begin
  Result := TfmSelectAccountsForReportsAccount(GetComponentByClassName('TfmSelectAccountsForReportsAccount' , False, Aowner, false));
  Result.accounttype  := fsAccounttype;
  Result.grpFilters.ItemIndex:= 0;
  Result.CloseDB(Result.qryAcc);
  Result.QryAcc.SQL.Text := StringReplace(Result.QryAcc.SQL.Text , 'AND A.Accounttype =  :Accounttype' , 'AND A.Accounttype in  ('+fsAccounttype+')'  ,[rfIgnoreCase] )
end;


procedure TfmSelectAccountsForReportsAccount.REfreshGrid;
var
  bm:TBookmark;
begin
  try
    bm:=SelectedAccounts.Dataset.GetBookmark;
    try
      SelectedAccounts.CloseDB;
      SelectedAccounts.OpenDB;
    finally
        SelectedAccounts.Dataset.GotoBookmark(bm);
        SelectedAccounts.Dataset.FreeBookmark(bm);
    end;
  Except
      on E:Exception do begin
          //kill the exception 
      end;
  end;
end;

procedure TfmSelectAccountsForReportsAccount.RefreshTree;
begin
  inherited;
end;

procedure TfmSelectAccountsForReportsAccount.FormShow(Sender: TObject);
begin
  pnlSearch.Color:= pnlTop.Color;
  Self.TabColor:= pnlTop.Color;
  inherited;

end;

initialization
  RegisterClassOnce(TfmSelectAccountsForReportsAccount);
end.

