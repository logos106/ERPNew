unit frmPnLLayout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Grids, Wwdbigrd, Wwdbgrid,
  Generics.Collections, StrUtils;

type
  TfmPnLLayout = class(TBaseInputGUI)
    wwDBGrid1: TwwDBGrid;
    qryMain: TMyQuery;
    dsMain: TDataSource;
    btnCancel: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    btnMove: TDNMSpeedButton;
    btnGroup: TDNMSpeedButton;
    qryTemp: TMyQuery;
    procedure FormCreate(Sender: TObject);
    procedure btnMoveClick(Sender: TObject);
    procedure btnGroupClick(Sender: TObject);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure btnSaveNameClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);

  private
    Mylist: TList<TBookmark>;
    SelectedID : Integer;

    procedure LoadLayoutData;
    procedure MoveAccounts(AGID: Integer);
    procedure MoveAccount(ASelID: Integer; AGID: Integer);
    procedure AddGroup(ADstID: Integer; AGName: string);
    procedure ChangeGroupName(AGID: Integer; AGName: string);
    procedure DeleteGroup(AGID: Integer);

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfmPnLLayout.btnMoveClick(Sender: TObject);
var
  GID : Integer;
  K : Integer;
begin
  inherited;
  if (MyList = nil) or (MyList.Count = 0) then begin
    ShowMessage('Not selected');
    Exit;
  end;

  if TForm(Form4).ShowModal = mrOK then begin
    GID := Form4.SelectedGroup;

    // Move selected accounts
    MoveAccounts(GID);

    // Reload
    LoadLayoutData;
  end;
end;

procedure TfmPnLLayout.FormCreate(Sender: TObject);
begin
  inherited;

  // Load the layout data
  LoadLayoutData;
end;

procedure TfmPnLLayout.LoadLayoutData;
var
  K : Integer;
  iLevel : Integer;
//  Col1 : TColumn;
begin
  // Get max level
  with qryTemp do begin
    SQL.Clear;
    SQL.Add('SELECT Max(Length(Pos) DIV 2) AS MLevel FROM tblPnLLayout');
    Open;

    iLevel := FieldByName('MLevel').AsInteger;

  end;

  // Prepare SQL for main grid
  with qryMain do begin
    SQL.Clear;
    SQL.Add('SELECT (@row:=@row + 1) AS No,');
    for K := 1 to iLevel - 1 do begin
      SQL.Add('IF(LENGTH(Pos) = ' + IntToStr(K * 2) + ', `Name`, "") AS Level' + IntToStr(K) + ',');
    end;
    SQL.Add('IF(LENGTH(Pos) = ' + IntToStr(K * 2) + ', `Name`, "") AS Level' + IntToStr(iLevel));
    SQL.Add('FROM tblPnLLayout, (SELECT @row:=0) Dummy ORDER BY Pos');
  end;

  // Load data
  qryMain.Open;
end;


procedure TfmPnLLayout.btnDeleteClick(Sender: TObject);
begin
  if SelectedID = 0 then Exit;

  case MessageDlg('Are you sure to delete?', mtConfirmation, [mbOK, mbCancel], 0) of
    mrOk:
      begin
        DeleteGroup(SelectedID);
      end;
  end;

  LoadLayoutData;
end;

procedure TfmPnLLayout.btnGroupClick(Sender: TObject);
var
  GID : Integer;
  GName : string;
begin
  Form4.IsGroup := True;

  if TForm(Form4).ShowModal = mrOK then begin
    GID := Form4.SelectedGroup;
    GName := Form4.GroupName;

    // Move selected accounts
    AddGroup(GID, GName);

    // Reload
    LoadLayoutData;
  end;
end;

procedure TfmPnLLayout.btnMoveClick(Sender: TObject);
var
  GID : Integer;
  K : Integer;
begin
  if (MyList = nil) or (MyList.Count = 0) then begin
    ShowMessage('Not selected');
    Exit;
  end;

  if TForm(Form4).ShowModal = mrOK then begin
    GID := Form4.SelectedGroup;

    // Move selected accounts
    MoveAccounts(GID);

    // Reload
    LoadLayoutData;
  end;
end;

procedure TfmPnLLayout.btnSaveNameClick(Sender: TObject);
var
  SelID : Integer;
begin
  // Exit if name is empty
  if (edtGroupName.Text = '') or (SelectedID = 0) then Exit;

  SelID := grdMain.DataSource.DataSet.FieldByName('ID').AsInteger;
  if SelID < 1 then Exit;

  ChangeGroupName(SelID, edtGroupName.Text);

  LoadLayoutData;
end;

procedure TfmPnLLayout.Button1Click(Sender: TObject);
begin
  LoadLayoutData;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  MyConnection.Database := 'wang_developer';
  MyConnection.Connect;

  SelectedID := 0;

  LoadLayoutData;
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin
  FreeAndNil(MyList);
end;

procedure TfmPnLLayout.grdMainDblClick(Sender: TObject);
var
  sPos : string;
  iLevel : Integer;
begin
  SelectedID := grdMain.DataSource.DataSet.FieldByName('ID').AsInteger;

  sPos := grdMain.DataSource.DataSet.FieldByName('Pos').AsString;
  iLevel := Length(sPos) div 2;
  edtGroupName.Text := grdMain.DataSource.DataSet.FieldByName('Level' + IntToStr(iLevel)).AsString;

end;

procedure TfmPnLLayout.grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
  var Accept: Boolean);
var
  enum : TEnumerator<Integer>;
begin
  Accept := True;

  // Reject if root
  if grdMain.DataSource.DataSet.FieldByName('IsRoot').AsBoolean then begin
    Accept := False;
    Exit;
  end;

  if MyList = nil then begin
    MyList := TList<TBookmark>.create;
  end;

  if Selecting then begin
    MyList.Add(grdMain.DataSource.Dataset.Bookmark);
  end
  else begin
    MyList.Remove(grdMain.DataSource.Dataset.Bookmark);
  end;

  Accept := True;
end;

procedure TfmPnLLayout.LoadLayoutData;
var
  K : Integer;
  iLevel : Integer;
//  Col1 : TColumn;
begin
  // Get max level
  with qryTemp do begin
    SQL.Clear;
    SQL.Add('SELECT Max(Length(Pos) DIV 2) AS MLevel FROM tblPnLLayout');
    Open;

    iLevel := FieldByName('MLevel').AsInteger;
  end;

  // Prepare SQL for main grid
  with qryMain do begin
    SQL.Clear;
    SQL.Add('SELECT (@row:=@row + 1) AS No, ID, Pos, Parent, IsRoot,');
    for K := 1 to iLevel - 1 do begin
      SQL.Add('IF(LENGTH(Pos) = ' + IntToStr(K * 2) + ', `Name`, "") AS Level' + IntToStr(K) + ',');
    end;
    SQL.Add('IF(LENGTH(Pos) = ' + IntToStr(K * 2) + ', `Name`, "") AS Level' + IntToStr(iLevel));
    SQL.Add('FROM tblPnLLayout, (SELECT @row:=0) Dummy ORDER BY Pos');
  end;

  // Load data
  qryMain.Open;

  // Hide some columns
  grdMain.DataSource.DataSet.FieldByName('ID').Visible := False;
  grdMain.DataSource.DataSet.FieldByName('Pos').Visible := False;
  grdMain.DataSource.DataSet.FieldByName('Parent').Visible := False;
  grdMain.DataSource.DataSet.FieldByName('IsRoot').Visible := False;
end;

procedure TfmPnLLayout.MoveAccounts(AGID: Integer);
var
  K : Integer;
  enum : TEnumerator<TBookmark>;
  current : TBookmark;
  parents : TList<Integer>;
begin
  parents := TList<Integer>.Create;

  with grdMain, grdMain.DataSource.Dataset do begin
    enum := MyList.GetEnumerator;
    while enum.MoveNext do begin
      GotoBookmark(enum.Current);

      // Add to parents list
      parents.Add(FieldByName('ID').AsInteger);

      // Skip if the same parent
      if FieldByName('Parent').AsInteger = AGID then Continue;

      // Skip if my parent is moved already
      if parents.IndexOf(FieldByName('Parent').AsInteger) > -1 then Continue;

      // No need to oneself
      if FieldByName('ID').AsInteger = AGID then Continue;

//      ShowMessage(IntToSTr(FieldByName('ID').AsInteger));

      // Move the account or group
      MoveAccount(FieldByName('ID').AsInteger, AGID);
    end;
  end;

  MyList.Clear;
  parents.Free;
end;

procedure TfmPnLLayout.MoveAccount(ASelID: Integer; AGID: Integer);
var
  K : Integer;
  sPPos, sNewPos, sOldPos : string;
  iCnt : Integer;
  iLen : Integer;
begin
  with qryTemp do begin
    // Get parent's pos
    SQL.Clear;
    SQL.Add('SELECT Pos FROM tblPnLLayout WHERE ID=' + IntToStr(AGID));
    Open;
    sPPos := FieldByName('Pos').AsString;

    // Rearrange pos for all children
    SQL.Clear;
    SQL.Add('UPDATE tblPnLLayout, (SELECT @idx:=0) T');
    SQL.Add('SET Pos=CONCAT("' + sPPos + '", LPAD(@idx:=@idx+1, 2, 0)) WHERE Parent=' + IntToStr(AGID));
    Execute;

    // Change my parent
    SQL.Clear;
    SQL.Add('UPDATE tblPnLLayout SET Parent=' + IntToStr(AGID) + ' WHERE ID=' + IntToStr(ASelID));
    Execute;

    // Count the siblings
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) AS Cnt FROM tblPnLLayout WHERE Parent=' + IntToStr(AGID));
    Open;
    iCnt := FieldByName('Cnt').AsInteger;

    // Set pos for the selected
    SQL.Clear;
    sNewPos := sPPos + Format('%.*d', [2, iCnt]);
    SQL.Add('UPDATE tblPnLLayout SET Pos="' + sNewPos +'" WHERE ID=' + IntToStr(ASelID));
    Execute;

    // Change my offsprings' pos
    with qryMain do begin
      Locate('ID', ASelID, []);
      sOldPos := FieldByName('Pos').AsString;
      iLen := Length(sOldPos);
      while True do begin
        Next;
        if LeftStr(FieldByName('Pos').AsString, iLen) <> sOldPos then Break;

        // Replace the prefix of pos
        qryTemp.SQL.Clear;
        qryTemp.SQL.Add('UPDATE tblPnLLayout SET Pos=CONCAT("' + sNewPos + '", RIGHT(Pos, LENGTH(Pos) - ' + IntToStr(Length(sOldPos)) + ')) WHERE ID=' + IntToStr(FieldByName('ID').AsInteger));
        qryTemp.Execute;
      end;
    end;

  end;

end;

procedure TfmPnLLayout.AddGroup(ADstID: Integer; AGName: string);
var
  sPPos : string;
begin
  with qryTemp do begin
    // Insert a new record to table
    SQL.Clear;
    SQL.Add('INSERT INTO tblPnLLayout (Parent, Pos, `Name`) VALUES (:parent, :pos, :name)');
    Params.ParamByName('parent').Value := ADstID;
    Params.ParamByName('pos').Value := '';
    Params.ParamByName('name').Value := AGName;
    Execute;

    // Get parent's pos
    SQL.Clear;
    SQL.Add('SELECT Pos FROM tblPnLLayout WHERE ID=' + IntToStr(ADstID));
    Open;
    sPPos := FieldByName('Pos').AsString;

    // Rearrange pos for all siblings
    SQL.Clear;
    SQL.Add('UPDATE tblPnLLayout, (SELECT @idx:=0) T');
    SQL.Add('SET Pos=CONCAT("' + sPPos + '", LPAD(@idx:=@idx+1, 2, 0)) WHERE Parent=' + IntToStr(ADstID));
    Execute;
  end;
end;

procedure TfmPnLLayout.ChangeGroupName(AGID: Integer; AGName: string);
begin
  with qryTemp do begin
    SQL.Clear;
    SQL.Add('UPDATE tblPnLLayout SET `Name`=:name WHERE ID=:id');
    Params.ParamByName('name').Value := AGName;
    Params.ParamByName('id').Value := AGID;
    Execute;
  end;


end;

procedure TfmPnLLayout.DeleteGroup(AGID: Integer);
var
  iPID : Integer;
  sPPos, sMyPos : string;
  iLen : Integer;
begin
  with qryTemp do begin
    // Get parent's id, pos
    SQL.Clear;
    SQL.Add('SELECT Parent FROM tblPnLLayout WHERE ID=' + IntToStr(AGID));
    Open;
    iPID := FieldByName('Parent').AsInteger;

    SQL.Clear;
    SQL.Add('SELECT Pos FROM tblPnLLayout WHERE ID=' + IntToStr(iPID));
    Open;
    sPPos := FieldByName('Pos').AsString;

    // Delete me
    SQL.Clear;
    SQL.Add('DELETE FROM tblPnLLayout WHERE ID=' + IntToStr(AGID));
    Execute;

    // Change my children's parent and Rearrange pos
    SQL.Clear;
    SQL.Add('UPDATE tblPnLLayout, (SELECT @idx:=0) T');
    SQL.Add('SET Parent=:new_parent, Pos=CONCAT(:ppos, LPAD(@idx:=@idx+1, 2, 0)) WHERE Parent=:old_parent');
    Params.ParamByName('new_parent').Value := iPID;
    Params.ParamByName('ppos').Value := sPPos;
    Params.ParamByName('old_parent').Value := AGID;
    Execute;

  end;

  // Change my offsprings' pos
  with qryMain do begin
    Locate('ID', AGID, []);
    sMyPos := FieldByName('Pos').AsString;
    iLen := Length(sMyPos);
    while True do begin
      Next;

      // if not my offspring
      if LeftStr(FieldByName('Pos').AsString, iLen) <> sMyPos then Break;

      // No need for children
      if FieldByName('Parent').AsInteger = AGID then Break;

      // Replace the prefix of pos
      qryTemp.SQL.Clear;
      qryTemp.SQL.Add('UPDATE tblPnLLayout SET Pos=CONCAT(:ppos, RIGHT(Pos, LENGTH(Pos) - :mylen)) WHERE ID=:id');
      qryTemp.Params.ParamByName('ppos').Value := sPPos;
      qryTemp.Params.ParamByName('mylen').Value := IntToStr(Length(sMyPos));
      qryTemp.Params.ParamByName('id').Value := IntToStr(FieldByName('ID').AsInteger);
      qryTemp.Execute;
    end;
  end;
end;



end.
