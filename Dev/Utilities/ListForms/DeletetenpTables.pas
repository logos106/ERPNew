unit DeletetenpTables;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TDeletetenpTablesGUI = class(TBaseListingGUI)
    qryMaintable_name: TWideStringField;
    qryMainDescription: TWideStringField;
    btnSelectAll: TDNMSpeedButton;
    btnDelete: TDNMSpeedButton;
    qryMainCREATE_TIME: TDateTimeField;
    qryMaintable_rows: TLargeintField;
    lblListHint: TLabel;
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SctMainError(Sender: TObject; E: Exception; SQL: string;
      var Action: TErrorAction);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure grdMainMultiSelectAllRecords(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
  private
    KeysPressed:String;
    procedure CheckForTableCreationDAte(var Accept: Boolean);
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses AppEnvironment, CommonDbLib, CommonLib, TempTableUtils, MySQLUtils, LogLib;

{$R *.dfm}

{ TBaseListingGUI1 }

procedure TDeletetenpTablesGUI.btnSelectAllClick(Sender: TObject);
begin
  inherited;
  grdmain.selectAll;
end;

procedure TDeletetenpTablesGUI.btnDeleteClick(Sender: TObject);
begin
  inherited;
  IterateProcNo:= 1;
  ScriptMain.SQL.clear;
  IterateselectedRecords();
  clog('');
  if ScriptMain.SQL.count > 0 then begin
    ScriptMain.Execute;
    RefreshQuery;
  end
  else
    CommonLib.MessageDlgXP_Vista('There is Nothing Selected to Delete',mtInformation,[mbOk],0);
  SetcontrolFocus(cmdClose);
  //btndelete.Enabled := False;
end;

procedure TDeletetenpTablesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  KeysPressed:= '';
  lblListHint.caption := 'Temporary Tables Created Since Last Update Batch ' + Quotedstr(formatDatetime(shortdateformat + ' HH:nn:ss am/pm' , Appenv.companyprefs.TransactionTableLastUpdated)) +' Can be Deleted';
  lblListHint.visible := true;
  lblListHint.refresh;
end;

procedure TDeletetenpTablesGUI.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (ssCtrl in Shift ) and (Key in [ord('D') , ord('E') , ord('L') , ord('E') , ord('T'), ord('E')]) then begin
      KeysPressed :=KeysPressed +chr(key);
    if Sysutils.SameText(KeysPressed , 'DELETE') then begin
      btnDelete.Enabled := True;
    end;
  end else KeysPressed := '';
end;

procedure TDeletetenpTablesGUI.grdMainMultiSelectAllRecords(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  //CheckForTableCreationDAte(Accept);
end;
procedure TDeletetenpTablesGUI.CheckForTableCreationDAte(var Accept: Boolean);
begin
  if qryMainCREATE_TIME.asDateTime > Appenv.companyprefs.TransactionTableLastUpdated then begin
    Accept := False;
    listTimerMsg(lblListHint.caption+'.  Found Tables Created After this Date/time, and are Ignored');
  end;
end;

procedure TDeletetenpTablesGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  if Selecting then CheckForTableCreationDAte(Accept);
end;

procedure TDeletetenpTablesGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
var
  fs:String;
begin
  inherited;
  if IterateProcNo= 1 then begin
  try
    if qryMainCREATE_TIME.asDateTime < Appenv.companyprefs.TransactionTableLastUpdated then begin
      fs:= 'insert into tblErpfixtables (Tablename,UserDeleted , DateDeleted, CreateSQL) '+
                  ' Select ' + Quotedstr(qryMaintable_name.AsString ) +',' +
                                quotedstr(Appenv.Employee.EmployeeName) +',' +
                                'CURRENT_TIMESTAMP() , ' +
                                quotedstr(ReadTableStructrue(qryMaintable_name.AsString, GetSharedMyDacConnection));
      ScriptMain.SQL.add(fs+';');
      ScriptMain.SQL.add('Drop table if exists ' + qryMaintable_name.AsString +';');
    end;
  Except
    // kill the exception
  end;
  end;
end;

procedure TDeletetenpTablesGUI.RefreshQuery;
begin
  Qrymain.Parambyname('DbName').asString :=appenv.appdb.Database;
  inherited;

end;

procedure TDeletetenpTablesGUI.SctMainError(Sender: TObject; E: Exception;
  SQL: string; var Action: TErrorAction);
begin
  inherited;
  Logtext(E.Message+':'+SQL);
  action := eaContinue ;
end;

initialization
  RegisterClassOnce(TDeletetenpTablesGUI);

end.

