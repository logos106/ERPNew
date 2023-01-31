unit PnLLayout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Grids, Wwdbigrd, Wwdbgrid,
  Generics.Collections, StrUtils, PnLDialog, AdvOfficeStatusBar, DNMPanel, Shader,

    BusObjProfitLoss, Mask, wwdbedit, Wwdotdot, Wwdbcomb;


type
  TfmPnLLayout = class(TBaseInputGUI)
    qryMain: TMyQuery;
    dsMain: TDataSource;
    qryTemp: TMyQuery;
    Label1: TLabel;
    HeaderPanel: TPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    BodyPanel: TPanel;
    grdMain: TwwDBGrid;
    FooterPanel: TDNMPanel;
    btnClose: TDNMSpeedButton;
    btnDefault: TDNMSpeedButton;
    btnMove: TDNMSpeedButton;
    btnGroup: TDNMSpeedButton;
    btnDelete: TDNMSpeedButton;
    btnUp: TDNMSpeedButton;
    btnDown: TDNMSpeedButton;
    Button1: TButton;
    cboLevel1Groups: TwwDBComboBox;
    btnMoveToLevel1Group: TDNMSpeedButton;
    cboLevel2Groups: TwwDBComboBox;
    btnMoveToLevel2Group: TDNMSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    edLevel1Group: TEdit;
    edLevel2Group: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnMoveClick(Sender: TObject);
    procedure btnGroupClick(Sender: TObject);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnDefaultClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);

    procedure btnDownClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure grdMainRowChanged(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnMoveToLevel1GroupClick(Sender: TObject);
    procedure cboLevel1GroupsChange(Sender: TObject);
    procedure cboLevel2GroupsChange(Sender: TObject);

  private
    ObjLayout: TProfitLossLayout;

    Mylist: TList<TBookmark>;
    SelectedID : Integer;

    procedure LoadLayoutData;
    procedure MoveAccounts(AGID: Integer);
    procedure MoveAccount(ASelID: Integer; AGID: Integer);
    procedure AddGroup(ADstID: Integer; AGName: string);
    procedure ChangeGroupName(AGID: Integer; AGName: string);
    procedure DeleteGroup(AGID: Integer);

    // move up & down
    procedure Openrec;
    procedure NewBusObjinstance;

    function SaveRecord :Boolean;

    procedure MoveItem(direction :TMoveModule);
    procedure MoveAccountsToLevel1Group();
    procedure MoveAccountsToLevel2Group();


  public


    LayoutID : Integer;

  end;


implementation

uses CommonLib, tcConst, ClipBrd;

{$R *.dfm}


procedure TfmPnLLayout.FormCreate(Sender: TObject);
begin
  inherited;

  SelectedID := 0;

  NewBusObjinstance;

end;

procedure TfmPnLLayout.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  ObjLayout := TProfitLossLayout.CreateWithNewConn(Self);
  ObjLayout.Connection.connection := Self.MyConnection;
  ObjLayout.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
end;




// move up & down buttons

procedure TfmPnLLayout.Openrec;
begin
  ObjLayout.Load;
  ObjLayout.connection.BeginTransaction;

  OpenQueries;

  ObjLayout.Dirty := false;
end;


procedure TfmPnLLayout.btnUpClick(Sender: TObject);
begin
  inherited;

  MoveItem(mmUp);

end;


procedure TfmPnLLayout.Button1Click(Sender: TObject);
begin
  inherited;

  ObjLayout.GotoRecord(7);

 // ObjLayout.Next;

 //   ShowMessage( '  busobj ID ' + IntToStr(ObjLayout.ID) + '  Pos ' + ObjLayout.Pos);



end;

procedure TfmPnLLayout.cboLevel1GroupsChange(Sender: TObject);
begin
  inherited;

  if cboLevel1Groups.Items.IndexOf(cboLevel1Groups.Text) < 0 then
  begin

       btnMoveToLevel1Group.Caption :=  'Move to New Level 1 Group';

       cboLevel1Groups.Items.Add(cboLevel1Groups.Text);

  end
  else
  begin

       btnMoveToLevel1Group.Caption :=  'Move to Level 1 Group';

 //     cboLevel2Groups.Items := ObjLayout.GetLevel2Groups(cboLevel1Groups.Text);
  end;

end;


procedure TfmPnLLayout.cboLevel2GroupsChange(Sender: TObject);
begin
  inherited;

    if cboLevel2Groups.Items.IndexOf(cboLevel2Groups.Text) < 0 then
  begin

       btnMoveToLevel2Group.Caption :=  'Move to New Level 2 Group';

       cboLevel2Groups.Items.Add(cboLevel2Groups.Text);

  end
  else
  begin

         btnMoveToLevel1Group.Caption :=  'Move to Level 2 Group';

 //     cboLevel2Groups.Items := ObjLayout.GetLevel2Groups(cboLevel1Groups.Text);
  end;


end;

procedure TfmPnLLayout.btnDownClick(Sender: TObject);
begin
  inherited;

    MoveItem(mmDown);

end;



procedure TfmPnLLayout.MoveItem(direction :TMoveModule);
begin

 //    ObjLayout.LoadParamList;

  ObjLayout.MoveLine(Direction, 'Level1Order');
 //  ObjLayout.MoveLine(Direction, ObjLayout , 'OrderNr');

    qryMain.Execute;


  grdMain.unselectall;

  grdMain.SelectRecord;

end;




procedure TfmPnLLayout.MoveAccountsToLevel1Group();
var
  K : Integer;
  enum : TEnumerator<TBookmark>;
  current : TBookmark;
  parents : TList<Integer>;

 // groupName : string;

begin
  parents := TList<Integer>.Create;

  with grdMain, grdMain.DataSource.Dataset do
  begin
    enum := MyList.GetEnumerator;
    while enum.MoveNext do
    begin
      GotoBookmark(enum.Current);

      // Add to parents list
      parents.Add(FieldByName('ID').AsInteger);


   //   ShowMessage('moving ' + FieldByName('AccountName').AsString + ' to group ' + cboLevel1Groups.Text );

      // Move the account or group
      ObjLayout.MoveAccountToLevel1Group(FieldByName('ID').AsString, cboLevel1Groups.Text);
    end;
  end;

  MyList.Clear;
  parents.Free;


  //  qryMain.Execute;


  grdMain.unselectall;

  grdMain.SelectRecord;

end;


procedure TfmPnLLayout.MoveAccountsToLevel2Group();
var
  K : Integer;
  enum : TEnumerator<TBookmark>;
  current : TBookmark;
//  parents : TList<Integer>;

 // groupName : string;

begin
//  parents := TList<Integer>.Create;

  with grdMain, grdMain.DataSource.Dataset do
  begin
    enum := MyList.GetEnumerator;
    while enum.MoveNext do
    begin
      GotoBookmark(enum.Current);

      // Add to parents list
//      parents.Add(FieldByName('ID').AsInteger);


   //   ShowMessage('moving ' + FieldByName('AccountName').AsString + ' to group ' + cboLevel2Groups.Text );

      // Move the account or group
      ObjLayout.MoveAccountToLevel2Group(FieldByName('ID').AsString, cboLevel2Groups.Text);
    end;
  end;

  MyList.Clear;
//  parents.Free;


 //   qryMain.Execute;


  grdMain.unselectall;

  grdMain.SelectRecord;

end;


procedure TfmPnLLayout.btnMoveClick(Sender: TObject);
var
  GID : Integer;
  K : Integer;
  formDlg : TfrmPnLDialog;
begin
  inherited;

  if (MyList = nil) or (MyList.Count = 0) then begin
    MessageDlgXP_Vista('No accounts or groups selected. ' + NL +
                        'Hold down Ctrl key to select multiple accounts.',
                        mtWarning, [mbOK], 0);
    Exit;
  end;

  formDlg := TfrmPnLDialog(GetcomponentByClassName('TfrmPnLDialog'));
  TfrmPnLDialog(formDlg).LayoutID := Self.LayoutID;
  if TBaseInputGUI(formDlg).ShowModal = mrOK then begin
    GID := formDlg.SelectedGroup;

    // Move selected accounts
    MoveAccounts(GID);

    // Reload
    LoadLayoutData;
  end;

  Freeandnil(formDlg);
end;


procedure TfmPnLLayout.btnMoveToLevel1GroupClick(Sender: TObject);
begin
  inherited;

//  if (MyList = nil) or (MyList.Count = 0) then begin
//    MessageDlgXP_Vista('No accounts or groups selected. ' + NL +
//                        'Hold down Ctrl key to select multiple accounts.',
//                        mtWarning, [mbOK], 0);
//    Exit;
//  end;

//  ShowMessage(TDNMSpeedButton(Sender).Name);


   if Sender = btnMoveToLevel1Group then
   begin
    // Move selected accounts
    //   if btnMoveToLevel1Group.Caption = 'Move to New Level 1 Group' then
           ObjLayout.CreateNewLevel1Group(cboLevel1Groups.Text, 'Expense');

    //   MoveAccountsToLevel1Group()
   end
   else if Sender = btnMoveToLevel2Group then
   begin // Move selected accounts

    //   if btnMoveToLevel2Group.Caption = 'Move to New Level 2 Group' then
           ObjLayout.CreateNewLevel2Group(cboLevel2Groups.Text, cboLevel1Groups.Text);

    //  MoveAccountsToLevel2Group();
   end;

    // Reload
    LoadLayoutData;

end;


procedure TfmPnLLayout.btnGroupClick(Sender: TObject);
var
  GID : Integer;
  GName : string;
  formDlg : TfrmPnLDialog;
begin
  formDlg := TfrmPnLDialog(GetcomponentByClassName('TfrmPnLDialog'));
  TfrmPnLDialog(formDlg).IsGroup := True;
  TfrmPnLDialog(formDlg).LayoutID := Self.LayoutID;


  if TBaseInputGUI(formDlg).ShowModal = mrOK then begin
    GID := formDlg.SelectedGroup;
    GName := formDlg.GroupName;

    // Move selected accounts
    AddGroup(GID, GName);

    // Reload
    LoadLayoutData;
  end;

  FreeAndNil(formDlg);
end;


function TfmPnLLayout.SaveRecord :Boolean;
begin
  result:= False;
  ObjLayout.PostDB;
  if not(ObjLayout.Save) then exit;
  Result:= True;

end;


procedure TfmPnLLayout.btnCloseClick(Sender: TObject);
begin
  inherited;

    FreeAndNil(ObjLayout);

//
//  if not SaveRecord then exit;
//
//
//  ObjLayout.Connection.CommitTransaction;
//
  Self.Close;
end;


procedure TfmPnLLayout.btnDefaultClick(Sender: TObject);
begin
  inherited;
  with qryTemp do begin
    SQL.Clear;
    SQL.Add('UPDATE tblPnLLayouts SET DefaultLayout="F" WHERE 1;');
    SQL.Add('UPDATE tblPnLLayouts SET DefaultLayout="T" WHERE LayoutID = ' + IntToStr(LayoutID) + ';');

    SQL.Add('UPDATE tblPnLLayouts SET IsCurrentLayout="F" WHERE 1;');
    SQL.Add('UPDATE tblPnLLayouts SET IsCurrentLayout="T" WHERE LayoutID = ' + IntToStr(LayoutID) + ';');

    Execute;
  end;

  MessageDlgXP_Vista('This layout has been set as default layout.', mtInformation, [mbOK], 0);

end;

procedure TfmPnLLayout.btnDeleteClick(Sender: TObject);
begin
  SelectedID := grdMain.DataSource.DataSet.FieldByName('ID').AsInteger;
  if SelectedID = 0 then Exit;

  if MessageDlgXP_Vista('Are you sure to delete the group?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    DeleteGroup(SelectedID);

  LoadLayoutData;
end;

procedure TfmPnLLayout.FormDestroy(Sender: TObject);
begin
  FreeAndNil(MyList);
end;

procedure TfmPnLLayout.FormShow(Sender: TObject);
begin
  inherited;
  // Load the layout data
  LoadLayoutData;

end;


procedure TfmPnLLayout.grdMainDblClick(Sender: TObject);
var
  GName : string;
  formDlg : TfrmPnLDialog;
  sPos : string;
  iLevel : Integer;
begin
  sPos := grdMain.DataSource.DataSet.FieldByName('Pos').AsString;
  iLevel := Length(sPos) div 2;

  GName := grdMain.DataSource.DataSet.FieldByName('Level' + IntToStr(iLevel)).AsString + 'Order';

  formDlg := TfrmPnLDialog(GetcomponentByClassName('TfrmPnLDialog'));
  TfrmPnLDialog(formDlg).IsRename := True;
  TfrmPnLDialog(formDlg).GroupName := GName;

  if TBaseInputGUI(formDlg).ShowModal = mrOK then begin
    GName := formDlg.GroupName;
    SelectedID := grdMain.DataSource.DataSet.FieldByName('ID').AsInteger;

    // Rename the selected group
    ChangeGroupName(SelectedID, GName);

    LoadLayoutData;
  end;

  FreeAndNil(formDlg);
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



procedure TfmPnLLayout.grdMainRowChanged(Sender: TObject);
begin
  inherited;

  ObjLayout.LocateId(qryMain.FieldByName('ID').AsInteger);

 //  ObjLayout.Locate('ID', qryMain.FieldByName('ID').AsInteger, []);


 // ShowMessage('query ID ' + qryMain.FieldByName('ID').AsString + '  busobj ID ' + IntToStr(ObjLayout.ID) + '  Pos ' + ObjLayout.Pos );





end;



procedure TfmPnLLayout.LoadLayoutData;
var
  K : Integer;
  iLevel : Integer;

   test : Boolean;

   caseStatement : string;

//  Col1 : TColumn;
begin
  // Get max level
  with qryTemp do begin
    SQL.Clear;
    SQL.Add('SELECT (MAX(LENGTH(Pos)) DIV 2) AS MLevel FROM tblPnLLayoutData ld');
    SQL.Add('LEFT JOIN tblPnLLayouts ls ON ld.LayoutID=ls.LayoutID');
    SQL.Add('WHERE ls.LayoutID=' + IntToStr(LayoutID));
    Open;

    iLevel := FieldByName('MLevel').AsInteger;
  end;


   test := true;

   if not test then
   begin
      // Prepare SQL for main grid
      with qryMain do
      begin
         SQL.Clear;
         SQL.Add('SELECT (@row:=@row + 1) AS No, ID, Pos, Parent, IsRoot,');
         for K := 1 to iLevel - 1 do
         begin
            SQL.Add('IF(LENGTH(Pos) = ' + IntToStr(K * 2) + ', `Name`, "") AS Level' +
              IntToStr(K) + ',');
         end;
         SQL.Add('IF(LENGTH(Pos) = ' + IntToStr(K * 2) + ', `Name`, "") AS Level' +
           IntToStr(iLevel));
         SQL.Add('FROM tblPnLLayoutData ld, (SELECT @row:=0) Dummy,');
         SQL.Add('tblPnLLayouts ls WHERE ld.LayoutID=ls.LayoutID');
         SQL.Add('AND ld.LayoutID=' + IntToStr(LayoutID));
         SQL.Add('ORDER BY Pos');
      end;

      // // Hide some columns
//      grdMain.DataSource.DataSet.FieldByName('ID').Visible := false;
//      grdMain.DataSource.DataSet.FieldByName('Pos').Visible := false;
//      grdMain.DataSource.DataSet.FieldByName('Parent').Visible := false;
//      grdMain.DataSource.DataSet.FieldByName('IsRoot').Visible := false;
   end
   else
   begin
      qryMain.SQL.Clear;

      caseStatement := 'CASE '
                     + ' WHEN Level1Order = 0 OR Level1Order > 9999 THEN Name '
                     + ' WHEN Level1Order > 0 && Level2Order = 0 THEN CONCAT("       ", Name) '
                     + ' WHEN Level2Order > 0 && Level3Order = 0 THEN CONCAT("              ", Name) '
                     + ' WHEN Level3Order > 0 THEN CONCAT("                     ", Name) '
                     + ' ELSE Name '
                     + ' END';

      qryMain.SQL.Add('SELECT ID, Parent, Pos, (' + caseStatement + ') AS AccountName , Level0Order, Level1Order, Level2Order, Level3Order, IsLevel0Total, IsLevel1Total, IsLevel2Total, IsLevel3Total, IsRoot, IsAccount, AccountID FROM tblPnLLayoutData ');
    //  qryMain.SQL.Add('SELECT (' + caseStatement + ') AS AccountName , Level0Order, Level1Order, Level2Order, Level3Order, IsLevel0Total, IsLevel1Total, IsLevel2Total, IsLevel3Total, IsRoot, IsAccount, AccountID FROM tblPnLLayoutData ');
      qryMain.SQL.Add(' ORDER BY Level0Order, IsLevel0Total, Level1Order, IsLevel1Total, Level2Order, IsLevel2Total, Level3Order, IsLevel3Total');
   //   qryMain.SQL.Add(' ORDER BY LEFT(Pos, 2), Level1Order, IsLevel1Total, Level2Order, IsLevel2Total, Level3Order, IsLevel3Total');

      ClipBoard.AsText := qryMain.SQL.Text;

     // qryMain.SQL.Add('SELECT ID, Parent, Pos, IsRoot, Name, OrderNr FROM tblPnLLayoutData ORDER BY OrderNr');
   end;

   // Load data
   qryMain.Open;


      cboLevel1Groups.Items := ObjLayout.GetLevel1Groups;

//      grdMain.Columns[0].Visible := false;
//      grdMain.Columns[1].Visible := false;
//     grdMain.Columns[2].Visible := false;



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
  bExist : Boolean;
  iPos : Integer;
begin
  with qryTemp do begin
    // Get target parent's pos
    SQL.Clear;
    SQL.Add('SELECT Pos FROM tblPnLLayoutData ld');
    SQL.Add('LEFT JOIN tblPnLLayouts ls ON ld.LayoutID=ls.LayoutID');
    SQL.Add('WHERE ld.ID=' + IntToStr(AGID));
    SQL.Add('AND ld.LayoutID=' + IntToStr(LayoutID));
    Open;
    sPPos := FieldByName('Pos').AsString;

    // Count my siblings
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) AS Cnt FROM tblPnLLayoutData ld');
    SQL.Add('LEFT JOIN tblPnLLayouts ls ON ld.LayoutID=ls.LayoutID');
    SQL.Add('WHERE ld.Parent=' + IntToStr(AGID));
    SQL.Add('AND ld.LayoutID=' + IntToStr(LayoutID));
    Open;
    iCnt := FieldByName('Cnt').AsInteger;

    // Get pos of siblings
    SQL.Clear;

    SQL.Add('SELECT SUBSTRING(Pos, Length("' + sPPos + '") + 1, 2) AS IDX FROM tblPnLLayoutData ld');
    SQL.Add('LEFT JOIN tblPnLLayouts ls ON ld.LayoutID=ls.LayoutID');
    SQL.Add('WHERE ld.Parent=' + IntToStr(AGID));
    SQL.Add('AND ld.LayoutID=' + IntToStr(LayoutID));

    Open;

    for K := 1 to iCnt + 1 do begin
      bExist := False;
      First;
      while not EOF do begin
        if K = FieldByName('IDX').AsInteger then begin
          bExist := True;
          Break;
        end;
        Next;
      end;

      if not bExist then iPos := K;
    end;

    // Set my pos anew
    SQL.Clear;
    sNewPos := sPPos + Format('%.*d', [2, iPos]);
    SQL.Add('UPDATE tblPnLLayoutData SET Pos="' + sNewPos +'" WHERE ID=' + IntToStr(ASelID));
    SQL.Add('AND LayoutID=' + IntToStr(LayoutID));
    Execute;

    // Change parent of mine
    SQL.Clear;
    SQL.Add('UPDATE tblPnLLayoutData SET Parent=' + IntToStr(AGID) + ' WHERE ID=' + IntToStr(ASelID));
    SQL.Add('AND LayoutID=' + IntToStr(LayoutID));
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
        qryTemp.SQL.Add('UPDATE tblPnLLayoutData SET Pos=CONCAT("' + sNewPos + '", RIGHT(Pos, LENGTH(Pos) - ' + IntToStr(Length(sOldPos)) + ')) WHERE ID=' + IntToStr(FieldByName('ID').AsInteger));
        qryTemp.SQL.Add('AND LayoutID=' + IntToStr(LayoutID));
        qryTemp.Execute;
      end;
    end;

  end;

end;

procedure TfmPnLLayout.AddGroup(ADstID: Integer; AGName: string);
var
  sPPos : string;
  K, iCnt, iPos : Integer;
  bExist : Boolean;
begin
  with qryTemp do begin
// Get target parent's pos
    SQL.Clear;

    SQL.Add('SELECT Pos FROM tblPnLLayoutData ld');
    SQL.Add('LEFT JOIN tblPnLLayouts ls ON ld.LayoutID=ls.LayoutID');
    SQL.Add('WHERE ld.ID=' + IntToStr(ADstID));
    SQL.Add('AND ld.LayoutID=' + IntToStr(LayoutID));

    Open;
    sPPos := FieldByName('Pos').AsString;

    // Count my siblings
    SQL.Clear;

    SQL.Add('SELECT COUNT(*) AS Cnt FROM tblPnLLayoutData ld');
    SQL.Add('LEFT JOIN tblPnLLayouts ls ON ld.LayoutID=ls.LayoutID');
    SQL.Add('WHERE ld.Parent=' + IntToStr(ADstID));
    SQL.Add('AND ld.LayoutID=' + IntToStr(LayoutID));

    Open;
    iCnt := FieldByName('Cnt').AsInteger;

    // Get pos of siblings
    SQL.Clear;

    SQL.Add('SELECT SUBSTRING(Pos, Length("' + sPPos + '") + 1, 2) AS IDX FROM tblPnLLayoutData ld');
    SQL.Add('LEFT JOIN tblPnLLayouts ls ON ld.LayoutID=ls.LayoutID');
    SQL.Add('WHERE ld.Parent=' + IntToStr(ADstID));
    SQL.Add('AND ld.LayoutID=' + IntToStr(LayoutID));

    Open;

    for K := 1 to iCnt + 1 do begin
      bExist := False;
      First;
      while not EOF do begin
        if K = FieldByName('IDX').AsInteger then begin
          bExist := True;
          Break;
        end;
        Next;
      end;

      if not bExist then begin
        iPos := K;
        Break;
      end;
    end;

    // Insert a new record to the target group
    SQL.Clear;
    SQL.Add('INSERT INTO tblPnLLayoutData (LayoutID, Parent, Pos, `Name`) VALUES (:lid, :parent, :pos, :name)');
    Params.ParamByName('lid').Value := LayoutID;
    Params.ParamByName('parent').Value := ADstID;
    Params.ParamByName('pos').Value :=  sPPos + Format('%.*d', [2, iPos]);
    Params.ParamByName('name').Value := AGName;
    Execute;

  end;
end;

procedure TfmPnLLayout.ChangeGroupName(AGID: Integer; AGName: string);
begin
  with qryTemp do begin
    SQL.Clear;
    SQL.Add('UPDATE tblPnLLayoutData SET `Name`=:name WHERE ID=:id');
    SQL.Add('AND LayoutID=' + IntToStr(LayoutID));
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
  chIDs : TList<Integer>;
  K : Integer;
begin
  with qryTemp do begin
    // Get parent's id, pos
    SQL.Clear;

    SQL.Add('SELECT Parent FROM tblPnLLayoutData ld');
    SQL.Add('LEFT JOIN tblPnLLayouts ls ON ld.LayoutID=ls.LayoutID');
    SQL.Add('WHERE ld.ID=' + IntToStr(AGID));
    SQL.Add('AND ld.LayoutID=' + IntToStr(LayoutID));

    Open;
    iPID := FieldByName('Parent').AsInteger;

    SQL.Clear;

    SQL.Add('SELECT Pos FROM tblPnLLayoutData ld');
    SQL.Add('LEFT JOIN tblPnLLayouts ls ON ld.LayoutID=ls.LayoutID');
    SQL.Add('WHERE ld.ID=' + IntToStr(iPID));
    SQL.Add('AND ld.LayoutID=' + IntToStr(LayoutID));

    Open;
    sPPos := FieldByName('Pos').AsString;

    // Delete me
    SQL.Clear;
    SQL.Add('DELETE FROM tblPnLLayoutData WHERE ID=' + IntToStr(AGID));
    SQL.Add('AND LayoutID=' + IntToStr(LayoutID));
    Execute;

    // Get my children's ID
    chIDs := TList<Integer>.Create;

    SQL.Clear;

    SQL.Add('SELECT ID FROM tblPnLLayoutData ld');
    SQL.Add('LEFT JOIN tblPnLLayouts ls ON ld.LayoutID=ls.LayoutID');
    SQL.Add('WHERE ld.Parent=' + IntToStr(AGID));
    SQL.Add('AND ld.LayoutID=' + IntToStr(LayoutID));

    Open;
    while not EOF do begin
      chIDs.Add(FieldByName('ID').AsInteger);
      Next;
    end;

    // Move my children to new parent
    for K := 0 to chIDs.Count - 1 do begin
      MoveAccount(chIDs.Items[K], iPID);
    end;

    chIDs.Free;
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
      qryTemp.SQL.Add('UPDATE tblPnLLayoutData SET Pos=CONCAT(:ppos, RIGHT(Pos, LENGTH(Pos) - :mylen)) WHERE ID=:id');
      qryTemp.SQL.Add('AND LayoutID=' + IntToStr(LayoutID));
      qryTemp.Params.ParamByName('ppos').Value := sPPos;
      qryTemp.Params.ParamByName('mylen').Value := IntToStr(Length(sMyPos));
      qryTemp.Params.ParamByName('id').Value := IntToStr(FieldByName('ID').AsInteger);
      qryTemp.Execute;
    end;
  end;
end;


initialization
  RegisterClassOnce(TfmPnLLayout);

end.
