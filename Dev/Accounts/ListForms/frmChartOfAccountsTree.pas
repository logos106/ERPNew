unit frmChartOfAccountsTree;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 08/04/05  1.00.01 IJB  Changed to use parameters for Active/ Not Active filter.
 15/12/05  1.00.02 IJB  Added RegisterClass.
 08/09/06  1.00.03 DSP  Added two brackets to qrySubAcc SQL to correct the
                        filter logic.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseTreeView, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, DB,
   VirtualTrees, StdCtrls, ExtCtrls, DNMPanel, wwdbdatetimepicker,
  Buttons, DNMSpeedButton, MemDS, DataState, Menus, AdvMenus, Shader,
  ImgList, ProgressDialog, wwradiogroup, wwclearbuttongroup;
type
  TAccNodeData = class(TNodeData)
  private
  public
    Amount: double;
    SubTotal: double;
  end;

  TfmChartOfAccountsTree = class(TBaseTreeViewGUI)
    qryAcc: TERPQuery;
    qrySubAcc: TERPQuery;
    grpFilters: TwwRadioGroup;
    chkTreeMode: TCheckBox;
    Label3: TLabel;
    qryTotalBalances: TERPQuery;
    qryAccAccountType: TWideStringField;
    qryAccAccType: TWideStringField;
    qryAccAccountNumber: TWideStringField;
    qryAccAccountName: TWideStringField;
    qryAccBalance: TFloatField;
    qryAccActive: TWideStringField;
    qryAccLevel1: TWideStringField;
    qryAccLevel2: TWideStringField;
    qryAccLevel3: TWideStringField;
    qryAccLevel4: TWideStringField;
    qryAccTaxCode: TWideStringField;
    qryAccBSB: TWideStringField;
    qryAccBankAccountNumber: TWideStringField;
    qryAccDescription: TWideStringField;
    qryAccBankAccountName: TWideStringField;
    qryAccBankNumber: TWideStringField;
    qryAccTaxCodeDescription: TWideStringField;
    qryAccTotalBalance: TFloatField;
    qrySubAccAccountId: TIntegerField;
    qrySubAccAccountNumber: TWideStringField;
    qrySubAccAccountName: TWideStringField;
    qrySubAccBalance: TFloatField;
    qrySubAccActive: TWideStringField;
    qrySubAccLevel1: TWideStringField;
    qrySubAccLevel2: TWideStringField;
    qrySubAccLevel3: TWideStringField;
    qrySubAccLevel4: TWideStringField;
    qrySubAccTaxCode: TWideStringField;
    qrySubAccBSB: TWideStringField;
    qrySubAccBankAccountNumber: TWideStringField;
    qrySubAccDescription: TWideStringField;
    qrySubAccBankAccountName: TWideStringField;
    qrySubAccBankNumber: TWideStringField;
    qrySubAccTaxCodeDescription: TWideStringField;
    qrySubAccAccounttype: TWideStringField;
    qrySubAccTotalBalance: TFloatField;
    qryAccTypeId: TIntegerfield;
    qryAccAccountId: TIntegerfield;
    qryAccSortOrder: TLargeintField;
    btnEdit: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure TreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure cmdNewClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure chkTreeModeClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);
    procedure qryAccBeforeOpen(DataSet: TDataSet);
    procedure qrySubAccBeforeOpen(DataSet: TDataSet);
    procedure cmdPrintClick(Sender: TObject);
    procedure TreeCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure btnEditClick(Sender: TObject);
  private
    FirstRefresh: boolean;

  protected

    const
      cName               = 0;
      cAccountNo          = 1;
      cTypeBalance        = 2;
      cLevel1             = 3;
      cLevel2             = 4;
      cLevel3             = 5;
      cLevel4             = 6;
      cAccBalance         = 7;
      cTotBalance         = 8;
      cTaxCode            = 9;
      cTaxCodeDescription = 10;
      cBSB                = 11;
      cBankAccNo          = 12;
      cDescription        = 13;
      cBankAccountName    = 14;
      cBankNumber         = 15;
      cActive             = 16;
      cAccountType        = 17;
      cSortOrder          = 18;

    procedure RefreshNode(RecordRec: PNodeRec; qry: TERPQuery);Virtual;
    procedure RefreshTree; override;
    procedure TreeDoubleClick(Node: PVirtualNode; Column: TColumnIndex); override;
    Procedure ConfigureTree;Virtual;
    function IsAccTypeNode(NodeData: PNodeRec):boolean;


    function GetSubAccounts(const AccountName: string; const aParentNode: PVirtualNode): double;
  public
    { Public declarations }

  end;

implementation

{$R *.dfm}

uses
  BaseInputForm, DnMExceptions, frmChartOfAccountsFrm, TransAccountDetailsForm,
  CommonLib,  AppEnvironment, FastFuncs, LogLib, frmAccountListEditPopUp;


procedure TfmChartOfAccountsTree.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  FirstRefresh := true;
  inherited;


  // turn on full row selection
  Tree.TreeOptions.SelectionOptions := Tree.TreeOptions.SelectionOptions + [toFullRowSelect];

  Self.Columns.HeaderColor := Self.color;

  ConfigureTree;

  Columns.Header.Background := Self.color;
end;

procedure TfmChartOfAccountsTree.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveExpandedState;
  inherited;
  Action := caFree;
end;

procedure TfmChartOfAccountsTree.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if MyConnection.InTransaction then Self.RollbackTransaction;

      //Self.BeginTransaction;
      //GetData;
      LoadExpandedState;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;
 Procedure TfmChartOfAccountsTree.RefreshNode(RecordRec: PNodeRec; qry: TERPQuery);
  begin
        RecordRec^.Data                                      := TAccNodeData.Create(Self.Columns);
        if qry <> nil then begin
          RecordRec^.Data.Id                                   := qry.FieldByName('AccountId').AsInteger;
          RecordRec^.Data.KeyStr                               := 'Acc:' + IntToStr(RecordRec^.Data.Id); // a unique key for this node
          TAccNodeData(RecordRec^.Data).Amount                 := qry.FieldByName('Balance').AsFloat;
          RecordRec^.Data.CellData[cName].Value                := qry.FieldByName('AccountName').AsString;
          RecordRec^.Data.CellData[cAccountNo].Value           := qry.FieldByName('AccountNumber').AsString;

          RecordRec^.Data.CellData[cLevel1].Value                := qry.FieldByName('Level1').AsString;
          RecordRec^.Data.CellData[cLevel2].Value                := qry.FieldByName('Level2').AsString;
          RecordRec^.Data.CellData[cLevel3].Value                := qry.FieldByName('Level3').AsString;
          RecordRec^.Data.CellData[cLevel4].Value                := qry.FieldByName('Level4').AsString;
          RecordRec^.Data.CellData[cAccBalance].Value          := FloatToStr(TAccNodeData(RecordRec^.Data).Amount);
          if qryTotalBalances.Locate('AccountID',RecordRec^.Data.Id,[]) then
               RecordRec^.Data.CellData[cTotBalance].Value     := qryTotalBalances.FieldByName('TotalBalance').AsString
          else RecordRec^.Data.CellData[cTotBalance].Value     := '';

          RecordRec^.Data.CellData[cTaxCode].Value             := qry.FieldByName('TaxCode').AsString;
          RecordRec^.Data.CellData[cTaxCodeDescription].Value  := qry.FieldByName('TaxCodeDescription').AsString;
          RecordRec^.Data.CellData[cBSB].Value                 := qry.FieldByName('BSB').AsString;
          RecordRec^.Data.CellData[cBankAccNo].Value           := qry.FieldByName('BankAccountNumber').AsString;
          RecordRec^.Data.CellData[cDescription].Value         := qry.FieldByName('Description').AsString;
          RecordRec^.Data.CellData[cBankAccountName].Value     := qry.FieldByName('BankAccountName').AsString;
          RecordRec^.Data.CellData[cBankNumber].Value          := qry.FieldByName('BankNumber').AsString;
          RecordRec^.Data.CellData[cActive].Value              := qry.FieldByName('Active').AsString;
          RecordRec^.Data.CellData[cAccountType].Value         := qry.FieldByName('AccountType').AsString;
        end else begin
          RecordRec^.Data.Id                                   := 0;
          RecordRec^.Data.KeyStr                               := '';
          TAccNodeData(RecordRec^.Data).Amount                 := 0;
          RecordRec^.Data.CellData[cName].Value                := '';
          RecordRec^.Data.CellData[cAccountNo].Value           := '';

          RecordRec^.Data.CellData[cLevel1].Value              := '';
          RecordRec^.Data.CellData[cLevel2].Value              := '';
          RecordRec^.Data.CellData[cLevel3].Value              := '';
          RecordRec^.Data.CellData[cLevel4].Value              := '';
          RecordRec^.Data.CellData[cAccBalance].Value          := '0';
          RecordRec^.Data.CellData[cTotBalance].Value          := '';

          RecordRec^.Data.CellData[cTaxCode].Value             := '';
          RecordRec^.Data.CellData[cTaxCodeDescription].Value  := '';
          RecordRec^.Data.CellData[cBSB].Value                 := '';
          RecordRec^.Data.CellData[cBankAccNo].Value           := '';
          RecordRec^.Data.CellData[cDescription].Value         := '';
          RecordRec^.Data.CellData[cBankAccountName].Value     := '';
          RecordRec^.Data.CellData[cBankNumber].Value          := '';
          RecordRec^.Data.CellData[cActive].Value              := '';
          RecordRec^.Data.CellData[cAccountType].Value         := '';
        end;
  end;
 function TfmChartOfAccountsTree.GetSubAccounts(const AccountName: string; const aParentNode: PVirtualNode): double;
  var
    Rec2: PNodeRec;
    Node2: PVirtualNode;
    subTotLevel: integer;
    qry: TERPQuery;
  begin
    Result := 0;
    qry:= TERPQuery.Create(nil);
    try
      qry.Connection:= qrySubAcc.Connection;
      qry.SQL.Text:= qrySubAcc.SQL.Text;
      qry.ParamByName('Parent').AsString := AccountName;
      qry.ParamByName('ActiveStr').AsString := grpFilters.Items[grpFilters.ItemIndex];
      qry.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
      qry.Open;
      try
        if qry.recordcount =0 then exit;
        qry.First;
        while not qry.Eof do begin
          Node2 := Tree.AddChild(aParentNode);
          Rec2 := Tree.GetNodeData(Node2);
          REfreshnode(Rec2, qry);
          TAccNodeData(Rec2^.Data).SubTotal := GetSubAccounts(qry.FieldByName('AccountName').AsString, Node2);
          subTotLevel:= Tree.GetNodeLevel(Node2) + 2;
          if subTotLevel < 6 then
            Rec2^.Data.CellData[(*subTotLevel*)cTypeBalance].Value := FloatToStr(TAccNodeData(Rec2^.Data).Subtotal);
          Result := Result + TAccNodeData(Rec2^.Data).Amount + TAccNodeData(Rec2^.Data).SubTotal;
          qry.Next;
        end;
      finally
        qry.Close;
      end;
    finally
      qry.Free;
    end;
  end;
procedure TfmChartOfAccountsTree.RefreshTree;
var
  AccType: string;
  ParentNode, Node: PVirtualNode;
  Rec: PNodeRec;
  Sum: double;
  qryAccTypes: TERPQuery;
  sl: TStringList;
begin
  inherited RefreshTree;
  if FirstRefresh then FirstRefresh := false
  else Self.SaveExpandedState;
  Tree.Clear;
  qryAcc.Close;
  qryAcc.ParamByName('ActiveStr').AsString := grpFilters.Items[grpFilters.ItemIndex];
  qryAcc.Open;
  qryAcc.First;
  AccType := '';
  ParentNode := nil;
  Sum := 0;
  sl:= TStringList.Create;
  try
    while not qryAcc.Eof do begin
      if AccType <> qryAcc.FieldByName('AccountType').AsString then begin
        // a new account type
        // update Subtotal for previous Account Type node
        if Assigned(ParentNode) then begin
          Rec := Tree.GetNodeData(ParentNode);
          TAccNodeData(Rec^.Data).SubTotal := Sum;
          Rec^.Data.CellData[cTypeBalance].Value := FloatToStr(TAccNodeData(Rec^.Data).Subtotal);
          Sum := 0;
        end;

        AccType := qryAcc.FieldByName('AccountType').AsString;
        sl.Add(AccType);
        ParentNode := Tree.AddChild(nil);
        Rec := Tree.GetNodeData(ParentNode);
        Rec^.Data := TAccNodeData.Create(Self.Columns);

        TAccNodeData(Rec^.Data).Amount := 0;
        TAccNodeData(Rec^.Data).SubTotal := 0;
        Rec^.Data.Id := qryAcc.FieldByName('TypeId').AsInteger;
        Rec^.Data.KeyStr := 'AccType:' + IntToStr(Rec^.Data.Id);  // a unique key for this node
        Rec^.Data.CellData[(*0*)cname].Value := AccType;
        Rec^.Data.CellData[(*17*)cSortOrder].Value:= qryAcc.FieldByName('SortOrder').AsString;
      end;

      Node      := Tree.AddChild(ParentNode);
      Rec       := Tree.GetNodeData(Node);
      (*Rec^.Data := TAccNodeData.Create(Self.Columns);
      Rec^.Data.Id     := qryAcc.FieldByName('AccountId').AsInteger;
      Rec^.Data.KeyStr := 'Acc:' + IntToStr(Rec^.Data.Id); // a unique key for this node
      TAccNodeData(Rec^.Data).Amount := qryAcc.FieldByName('Balance').AsFloat;
      Rec^.Data.CellData[0].Value := qryAcc.FieldByName('AccountName').AsString;
      Rec^.Data.CellData[1].Value := qryAcc.FieldByName('AccountNumber').AsString;
      Rec^.Data.CellData[6].Value := FloatToStr(TAccNodeData(Rec^.Data).Amount);
      //Rec^.Data.CellData[7].Value := qryAcc.FieldByName('TotalBalance').AsString;
      if qryTotalBalances.Locate('AccountID',Rec^.Data.Id,[]) then
          Rec^.Data.CellData[cTotBalance].Value := qryTotalBalances.FieldByName('TotalBalance').AsString
      else
          Rec^.Data.CellData[cTotBalance].Value := '';
      Rec^.Data.CellData[8].Value := qryAcc.FieldByName('TaxCode').AsString;
      Rec^.Data.CellData[9].Value := qryAcc.FieldByName('TaxCodeDescription').AsString;
      Rec^.Data.CellData[10].Value := qryAcc.FieldByName('BSB').AsString;
      Rec^.Data.CellData[11].Value := qryAcc.FieldByName('BankAccountNumber').AsString;
      Rec^.Data.CellData[12].Value := qryAcc.FieldByName('Description').AsString;
      Rec^.Data.CellData[13].Value := qryAcc.FieldByName('BankAccountName').AsString;
      Rec^.Data.CellData[14].Value := qryAcc.FieldByName('BankNumber').AsString;
      Rec^.Data.CellData[15].Value := qryAcc.FieldByName('Active').AsString;
      Rec^.Data.CellData[16].Value := qryAcc.FieldByName('AccType').AsString;*)

      REfreshnode(Rec, qryAcc);
      Rec^.Data.KeyStr := 'AccType:' + IntToStr(Rec^.Data.Id);  // a unique key for this node
      TAccNodeData(Rec^.Data).SubTotal := GetSubAccounts(qryAcc.FieldByName('AccountName').AsString, Node);
      Rec^.Data.CellData[cTypeBalance].Value := FloatToStr(TAccNodeData(Rec^.Data).Subtotal);

      Sum := Sum + TAccNodeData(Rec^.Data).Amount + TAccNodeData(Rec^.Data).SubTotal;
      qryAcc.Next;
    end;
    if Assigned(ParentNode) then begin
      Rec := Tree.GetNodeData(ParentNode);
      TAccNodeData(Rec^.Data).SubTotal := Sum;
      Rec^.Data.CellData[(*2*)cTypeBalance].Value := FloatToStr(TAccNodeData(Rec^.Data).Subtotal);
    end;
    qryAcc.Close;
    qryAccTypes:= TERPQuery.Create(nil);
    try
      qryAccTypes.Connection:= qryAcc.Connection;
      qryAccTypes.SQL.Add('select AccDesc, TypeID, SortOrder from tblAccTypeDesc');
      qryAccTypes.Open;
      while not qryAccTypes.Eof do begin
        if sl.IndexOf(qryAccTypes.FieldByName('AccDesc').AsString) < 0 then begin
          AccType := qryAccTypes.FieldByName('AccDesc').AsString;
          ParentNode := Tree.AddChild(nil);
          Rec := Tree.GetNodeData(ParentNode);
          Rec^.Data := TAccNodeData.Create(Self.Columns);

          TAccNodeData(Rec^.Data).Amount := 0;
          TAccNodeData(Rec^.Data).SubTotal := 0;
          Rec^.Data.Id := qryAccTypes.FieldByName('TypeId').AsInteger;
          Rec^.Data.KeyStr := 'AccType:' + IntToStr(Rec^.Data.Id);  // a unique key for this node
          Rec^.Data.CellData[(*0*)cAccountType].Value := AccType;
          Rec^.Data.CellData[(*17*)cSortOrder].Value:= qryAccTypes.FieldByName('SortOrder').AsString;
          Rec^.Data.CellData[(*17*)cName].Value:= qryAccTypes.FieldByName('AccDesc').AsString;
        end;
        qryAccTypes.Next;
      end;

    finally
      qryAccTypes.Free;
    end;
  finally
    sl.Free;
  end;
  Tree.Sort(Tree.RootNode,0,sdAscending,False);
  Self.LoadExpandedState;
end;

procedure TfmChartOfAccountsTree.TreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Rec: PNodeRec;
begin
  inherited;
  Rec := Sender.GetNodeData(Node);
  FreeandNil(Rec^.Data);
end;

procedure TfmChartOfAccountsTree.TreeCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  rec1, rec2: PNodeRec;
  val1, val2: integer;
begin
  inherited;
  result:= 0;
  rec1:= Sender.GetNodeData(Node1);
  rec2:= Sender.GetNodeData(Node2);
  val1:= StrToIntDef(rec1^.Data.CellData[(*17*)cSortOrder].Value, 0);
  val2:= StrToIntDef(rec2^.Data.CellData[(*17*)cSortOrder].Value, 0);
  if val1 > val2 then result:= 1
  else if val1 < val2 then result:= -1;
end;

procedure TfmChartOfAccountsTree.TreeDoubleClick(Node: PVirtualNode; Column: TColumnIndex);
var
  Rec: PNodeRec;
  Var Form : TComponent;
begin
  Rec := Tree.GetNodeData(Node);
  if Tree.GetNodeLevel(Tree.GetFirstSelected) = 0 then begin
    // this is an Account Type so no drill down
  end else begin
    case Column of
      cName, cAccountNo:
        begin  // name or Account code columns
               // this is an Account
          Form := GetComponentByClassName('TfrmChartOfAccounts');
          if Assigned(Form) then begin
            with TfrmChartOfAccounts(Form) do begin
              KeyId := Rec^.Data.Id;
              AttachObserver(Self);
              FormStyle := fsMDIChild;
              BringToFront;
            end;
          end;
        end;
      cAccBalance:
        begin   // Account balance column
          with TTransAccountDetailsGUI.Create(Self) do begin
            ToDate := Now;
            FromDate := 0;
            qryMain.SQL.Add('AND AccountID = ' + IntToStr(Rec^.Data.Id) + ' Group by TransID;');
            WhereString := 'AND ( AccountID = ' + IntToStr(Rec^.Data.Id) + ' )';
            FormStyle := fsmdiChild;
            Show;
          end;
        end;
    end;
  end;
end;


procedure TfmChartOfAccountsTree.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfrmChartOfAccounts');
  if Assigned(Form) then begin
    with TfrmChartOfAccounts(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TfmChartOfAccountsTree.btnCustomizeClick(Sender: TObject);
begin
  inherited;
  //  with GenContext.Node['Tree.Columns'].NodeList.NodeByName['Col1'] do
  //    Attribute['width'].AsInteger:= 56;
  //  GenContext.Save;
end;

procedure TfmChartOfAccountsTree.btnEditClick(Sender: TObject);
begin
  inherited;
  DoEditFromAccountList;
end;

procedure TfmChartOfAccountsTree.chkTreeModeClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  if not FormStillOpen('TChartOfAccountsListGUI') then begin
    TForm(GetComponentByClassName('TChartOfAccountsListGUI')).FormStyle := fsmdiChild;
  end else begin
    Form := GetComponentByClassName('TChartOfAccountsListGUI');
    if Assigned(Form) then TForm(Form).Show;
  end;
  Close;
end;

procedure TfmChartOfAccountsTree.grpFiltersClick(Sender: TObject);
begin
  ProcessingCursor(True);
  try
    RefreshTree;
    inherited;
  finally
    ProcessingCursor(False);
  end;
end;
function TfmChartOfAccountsTree.IsAccTypeNode(NodeData: PNodeRec): boolean;
begin
  result := False;
  TRy
    result := copy(NodeData.Data.KeyStr+ '        ' ,1,8)= 'AccType:' ;
  Except
    on E:Exception do begin
      if devmode then
        MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
    end;
  End;
end;

procedure TfmChartOfAccountsTree.qryAccBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if qryAcc.ParamExists('xRegionID') then
    qryAcc.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfmChartOfAccountsTree.qrySubAccBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qrySubAcc.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfmChartOfAccountsTree.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfmChartOfAccountsTree.ConfigureTree;
begin
  Self.columns.clear;
  Tree.header.columns.clear;
  AddColumn('Name', vtString, 220);                     // 0
  AddColumn('Account No', vtString, 110);           // 1
  AddColumn('Type Balance', vtCurrency, 90,taRightJustify);//2
  AddColumn('Level 1', vtString, 90,taRightJustify);//3
  AddColumn('Level 2', vtString, 90,taRightJustify);//4
  AddColumn('Level 3', vtString, 90,taRightJustify);//5
  AddColumn('Level 4', vtString, 90,taRightJustify);//5
  AddColumn('Acc Balance', vtCurrency, 90,taRightJustify);//6
  AddColumn('Tot Balance', vtCurrency, 90,taRightJustify);//7
  AddColumn('Tax Code', vtString, 80);                   // 8
  AddColumn('Tax Code Description', vtString, 140);      // 9
  AddColumn('BSB', vtString, 75);                        // 10
  AddColumn('Bank Acc No', vtString, 100);               // 11
  AddColumn('Description', vtString, 150);               // 12
  AddColumn('Bank Account Name', vtString, 150);         // 13
  AddColumn('Bank Number', vtString, 130);               // 14
  AddColumn('Active', vtBoolean, 75);                    // 15
  AddColumn('AccountType', vtString, 75);                // 16
  AddColumn('SortOrder', vtInteger, 0);                  // 17
end;

initialization
  RegisterClassOnce(TfmChartOfAccountsTree);

end.
