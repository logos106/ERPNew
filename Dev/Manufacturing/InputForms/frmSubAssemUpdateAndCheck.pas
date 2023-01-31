unit frmSubAssemUpdateAndCheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls,
  wwclearbuttongroup, wwradiogroup, DNMSpeedButton, Shader, DNMPanel,
  DB, BusObjProcess;

type
  TfmSubAssemUpdateAndCheck = class(TBaseForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    rgAction: TwwRadioGroup;
    memLog: TMemo;
    lblNote: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure rgActionChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    UpdateCount: integer;
    procedure FindAndLink; overload;
    procedure FindAndLink(aTree: TProcTreeNode); overload;
    function NodesMatch(N1, N2: TProcTreeNode): boolean;
    Procedure Log(const aMsg: string);
    procedure FindAndUpdate;
    procedure OnUpdateProgress(Sender: TObject);
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib, CommonDbLib, DbSharedObjectsObj, ERPDbComponents,
  ProcProcessSubAssemblyUpdateObj;

{$R *.dfm}

{ TfmSubAssemUpdateAndCheck }

procedure TfmSubAssemUpdateAndCheck.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmSubAssemUpdateAndCheck.btnOKClick(Sender: TObject);
begin
  inherited;
  memLog.Clear;
  case rgAction.ItemIndex of
    0: FindAndLink;
    1: FindAndUpdate;
  end;
end;

procedure TfmSubAssemUpdateAndCheck.FindAndLink;
var
  qry: TERPQuery;
  Tree: TProcTreeNode;
begin
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  Tree := TProcTreeNode.Create(nil);
  try
    qry.SQL.Text := 'select * from tblproctree where ParentID = 0 and IsTemplate = "T"';
    qry.Open;
    if qry.IsEmpty then begin
      Log('You do not have and Manufactured Inventory Products.');
      exit;
    end;
    while not qry.Eof do begin
      Log('Checking ' + qry.FieldByName('Caption').AsString);
      Tree.Load(qry.FieldByName('ProcTreeID').AsInteger);
      FindAndLink(Tree);
      qry.Next;
    end;
  finally
    Tree.Free;
    DbSharedObj.ReleaseObj(qry);
  end;

  Log('Finished.');
end;


procedure TfmSubAssemUpdateAndCheck.FindAndLink(aTree: TProcTreeNode);
var
  qry: TERPQuery;
  ProdTree: TProcTreeNode;

  function CheckNode(aNode: TProcTreeNode): boolean;
  var
    childIdx: integer;
  begin
    result := false;
    if aNode.PartsId = aTree.PartsId then begin
      if NodesMatch(aTree, aNode) then begin
        if (aNode.InheritFromID <> aTree.Id) or (aNode.InheritFromEditVersion <> aTree.EditVersion) then begin
          result := true;
          aNode.InheritFromID := aTree.Id;
          aNode.InheritFromEditVersion := aTree.EditVersion;
          Log('    Linking to: ' + ProdTree.Caption);
        end
        else begin
          Log('    Existing link to: ' + ProdTree.Caption);
        end;
      end;
    end
    else begin
      { checkthe children }
      for childIdx := 0 to aNode.Children.Count -1 do begin
        if CheckNode(TProcTreeNode(aNode.Children[childIdx])) then
          result := true;
      end;
    end;
  end;

begin
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Text :=
      'select distinct TreeRootId from tblproctree where ParentID > 0 and IsTemplate = "T" and PartsID = ' +
      IntToStr(aTree.PartsId) + ' and ProcTreeID <> ' + IntToStr(aTree.ID);
    qry.Open;
    if not qry.IsEmpty then  begin
      while not qry.Eof do begin

        ProdTree := TProcTreeNode.Create(nil);
        try
          ProdTree.Load(qry.FieldByName('TreeRootID').AsInteger);
          if CheckNode(ProdTree) then begin
            ProdTree.Save;
          end;
        finally
          ProdTree.Free;
        end;
        qry.Next;
      end;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TfmSubAssemUpdateAndCheck.FindAndUpdate;
var
  Updater: TSubAssemblyUpdater;
  qry: TERPQuery;
begin
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  Updater := TSubAssemblyUpdater.Create;
  try
    Updater.OnUpdate := self.OnUpdateProgress;
    qry.SQL.Text := 'select * from tblproctree where ParentID = 0 and IsTemplate = "T"';
    qry.Open;
    while not qry.Eof do begin
      Log('Checking ' + qry.FieldByName('Caption').AsString);
      Updater.SubAssemblyProcTreeID := qry.FieldByName('ProcTreeID').AsInteger;
      UpdateCount := 0;
      Updater.Execute;
      qry.Next;
    end;
  finally
    Updater.Free;
    DbSharedObj.ReleaseObj(qry);
  end;
  Log('Finished');
end;

procedure TfmSubAssemUpdateAndCheck.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmSubAssemUpdateAndCheck.FormShow(Sender: TObject);
begin
  inherited;
  rgAction.ItemIndex := 0;
end;

procedure TfmSubAssemUpdateAndCheck.Log(const aMsg: string);
begin
  memLog.Lines.Add(aMsg);
  Application.ProcessMessages;
end;

function TfmSubAssemUpdateAndCheck.NodesMatch(N1, N2: TProcTreeNode): boolean;
var
  x: integer;
begin
  result := N1.IsEqual(N2);
  if not Result then exit;
  for x := 0 to N1.Children.Count -1 do begin
    if not NodesMatch(TProcTreeNode(N1.Children[x]),TProcTreeNode(N2.Children[x]))  then begin
      result := false;
      exit;
    end;
  end;
end;

procedure TfmSubAssemUpdateAndCheck.OnUpdateProgress(Sender: TObject);
begin
  Inc(UpdateCount);
  if TSubAssemblyUpdater(Sender).ErrMsg <> '' then
    Log('  ' + TSubAssemblyUpdater(Sender).ErrMsg)
  else
    Log('  ' + IntToStr(UpdateCount) + ' of ' + IntToStr(TSubAssemblyUpdater(Sender).SubAssemblyUsedCount));
end;

procedure TfmSubAssemUpdateAndCheck.rgActionChange(Sender: TObject);
begin
  inherited;
  case rgAction.ItemIndex of
    0: lblNote.Caption := 'This will search through all Product BOMs and Link then to other Products BOMs where one is used as a Sub-Assemply of the other.';
    1: lblNote.Caption := 'Thils will update the Costs of BOMs that contain linked Sup-Assembly Boms.';
  end;
end;

initialization
  RegisterClass(TfmSubAssemUpdateAndCheck);

end.
