unit ProfitLossLayoutDataForm;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg,
  Generics.Collections, BusObjProfitLoss, Mask, wwdbedit, Wwdotdot,
  Wwdbcomb ;

type
  TProfitLossLayoutDataGUI = class(TBaseListingGUI)
    DNMPanel1: TDNMPanel;
    btnDown: TDNMSpeedButton;
    btnUp: TDNMSpeedButton;
    edNewGroup: TEdit;
    btnMoveToLevel2Group: TDNMSpeedButton;
    Label2: TLabel;
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure cmdPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainBeforeDrawCell(Sender: TwwCustomDBGrid;
      DrawCellInfo: TwwCustomDrawGridCellInfo);
    procedure grdMainRowChanged(Sender: TObject);
    procedure btnMoveToLevel2GroupClick(Sender: TObject);
  private
    { Private declarations }
    ObjLayout: TProfitLossLayout;

    Mylist: TList<TBookmark>;
    SelectedID : Integer;

     procedure AddLayoutStringField(name : string);
     procedure AddLayoutIntegerField(name : string);
    procedure AddLayoutFloatField(name : string);


    procedure LoadLayoutData;
//    procedure MoveAccounts(AGID: Integer);
//    procedure MoveAccount(ASelID: Integer; AGID: Integer);
//    procedure AddGroup(ADstID: Integer; AGName: string);
//    procedure ChangeGroupName(AGID: Integer; AGName: string);
//    procedure DeleteGroup(AGID: Integer);

    // move up & down
//    procedure Openrec;
    procedure NewBusObjinstance;

//    function SaveRecord :Boolean;

    procedure MoveItem(direction :TMoveModule);
    procedure MoveAccountsToLevel1Group();
    procedure MoveAccountsToLevel2Group();

  public
    { Public declarations }
    LayoutID : Integer;


  end;



implementation

uses PnLLayouts, CommonLib, Forms;
{$R *.dfm}


 procedure TProfitLossLayoutDataGUI.AddLayoutStringField(name : string);
var
  field : TField;

begin

  field := TWideStringField.Create(qryMain);
  field.Name := '';
  field.FieldName := name;
  field.Dataset := qryMain;

end;


procedure TProfitLossLayoutDataGUI.AddLayoutIntegerField(name : string);
var
  field : TField;

begin

  field := TIntegerField.Create(qryMain);
  field.Name := '';
  field.FieldName := name;
  field.Dataset := qryMain;

end;


procedure TProfitLossLayoutDataGUI.AddLayoutFloatField(name : string);
var
  field : TField;

begin

  field := TFloatField.Create(qryMain);
  field.Name := '';
  field.FieldName := name;
  field.Dataset := qryMain;

end;


procedure TProfitLossLayoutDataGUI.btnDownClick(Sender: TObject);
begin
  inherited;

     MoveItem(mmDown);


end;

procedure TProfitLossLayoutDataGUI.btnMoveToLevel2GroupClick(
  Sender: TObject);
begin
  inherited;

    ObjLayout.CreateNewGroup(edNewGroup.Text);


    // Reload
    LoadLayoutData;


end;

procedure TProfitLossLayoutDataGUI.btnUpClick(Sender: TObject);
begin
  inherited;

   MoveItem(mmUp);

end;

procedure TProfitLossLayoutDataGUI.cmdNewClick(Sender: TObject);
var
  Form: TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfrmPnlLayouts');
    if Assigned(Form) then begin
      with TfrmPnlLayouts(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TProfitLossLayoutDataGUI.grdMainBeforeDrawCell(
  Sender: TwwCustomDBGrid; DrawCellInfo: TwwCustomDrawGridCellInfo);
begin
  inherited;

 // TwwCustomDBGrid(Sender).

//  DrawCellInfo.

end;

procedure TProfitLossLayoutDataGUI.grdMainRowChanged(Sender: TObject);
begin
  inherited;

    //        ShowMessage('ID ' + qryMain.FieldByName('ID').AsString);

    ObjLayout.LocateId(qryMain.FieldByName('ID').AsInteger);


end;

procedure TProfitLossLayoutDataGUI.grpFiltersClick(Sender: TObject);
begin
//  InitGroupfilterString('Active' , ['T','F','']);
//  inherited;
end;

procedure TProfitLossLayoutDataGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TProfitLossLayoutDataGUI.FormCreate(Sender: TObject);
begin
  inherited;
 // HaveDateRangeSelection := False;

   SelectedID := 0;

  NewBusObjinstance;

 //       AddLayoutIntegerField('ID');






//  with qryMain do
//  begin
//    Close;
//    Open;
//
//    while not eof do
//    begin
//        ShowMessage(FieldByName('LName').AsString);
//         Next;
//    end;
//
//  //  Locate('DefaultLayout', 'T', []);
//  //  DefaultID := FieldByName('LayoutID').AsInteger;
//  end;

end;


procedure TProfitLossLayoutDataGUI.FormShow(Sender: TObject);
begin
  inherited;

     LoadLayoutData;

end;

procedure TProfitLossLayoutDataGUI.NewBusObjInstance;
begin
  {$WARNINGS OFF}
  ObjLayout := TProfitLossLayout.CreateWithNewConn(Self);
 // ObjLayout.Connection.connection := Self.MyConnection1;
  ObjLayout.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
end;


procedure TProfitLossLayoutDataGUI.LoadLayoutData;
var
  K : Integer;
  iLevel : Integer;

   test : Boolean;

   caseStatement : string;

//  Col1 : TColumn;
begin
  // Get max level
//  with qryTemp do begin
//    SQL.Clear;
//    SQL.Add('SELECT (MAX(LENGTH(Pos)) DIV 2) AS MLevel FROM tblPnLLayoutData ld');
//    SQL.Add('LEFT JOIN tblPnLLayouts ls ON ld.LayoutID=ls.LayoutID');
//    SQL.Add('WHERE ls.LayoutID=' + IntToStr(LayoutID));
//    Open;
//
//    iLevel := FieldByName('MLevel').AsInteger;
//  end;


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


 //      qryMain.SQL.Add('SELECT ID, (' + caseStatement + ') AS Name FROM tblPnLLayoutData ');


      qryMain.SQL.Add('SELECT ID, (' + caseStatement + ') AS Name , Level0Order, Level1Order, Level2Order, Level3Order FROM tblPnLLayoutData ');
    //  qryMain.SQL.Add('SELECT (' + caseStatement + ') AS AccountName , Level0Order, Level1Order, Level2Order, Level3Order, IsLevel0Total, IsLevel1Total, IsLevel2Total, IsLevel3Total, IsRoot, IsAccount, AccountID FROM tblPnLLayoutData ');
      qryMain.SQL.Add(' ORDER BY Level0Order, IsLevel0Total, Level1Order, IsLevel1Total, Level2Order, IsLevel2Total, Level3Order, IsLevel3Total');
   //   qryMain.SQL.Add(' ORDER BY LEFT(Pos, 2), Level1Order, IsLevel1Total, Level2Order, IsLevel2Total, Level3Order, IsLevel3Total');

 //     ClipBoard.AsText := qryMain.SQL.Text;



     // qryMain.SQL.Add('SELECT ID, Parent, Pos, IsRoot, Name, OrderNr FROM tblPnLLayoutData ORDER BY OrderNr');
   end;

//   ShowMessage(qryMain.SQL.Text);

   //       AddLayoutStringField('AccountName');


   // Load data
   qryMain.Open;


  //    cboLevel1Groups.Items := ObjLayout.GetLevel1Groups;

//      grdMain.Columns[0].Visible := false;
//      grdMain.Columns[1].Visible := false;
//     grdMain.Columns[2].Visible := false;



end;



procedure TProfitLossLayoutDataGUI.MoveItem(direction :TMoveModule);
begin

 //    ObjLayout.LoadParamList;

  ObjLayout.MoveLine(Direction, 'Level1Order');
 //  ObjLayout.MoveLine(Direction, ObjLayout , 'OrderNr');

    qryMain.Execute;


  grdMain.unselectall;

  grdMain.SelectRecord;

end;


procedure TProfitLossLayoutDataGUI.MoveAccountsToLevel1Group();
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
   //   ObjLayout.MoveAccountToLevel1Group(FieldByName('ID').AsString, cboLevel1Groups.Text);
    end;
  end;

  MyList.Clear;
  parents.Free;


  //  qryMain.Execute;


  grdMain.unselectall;

  grdMain.SelectRecord;

end;


procedure TProfitLossLayoutDataGUI.MoveAccountsToLevel2Group();
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
  //    ObjLayout.MoveAccountToLevel2Group(FieldByName('ID').AsString, cboLevel2Groups.Text);
    end;
  end;

  MyList.Clear;
//  parents.Free;


 //   qryMain.Execute;


  grdMain.unselectall;

  grdMain.SelectRecord;

end;




initialization
  RegisterClassOnce(TProfitLossLayoutDataGUI);
end.
