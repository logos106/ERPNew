unit ERPDatabasesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TERPDatabasesListGUI = class(TBaseListingGUI)
    qryMainDatabasename: TWideStringField;
    qryMainServerName: TWideStringField;
    qryMainemployeename: TWideStringField;
    qryMainPassword: TWideStringField;
    qryMainDPassword: TWideStringField;
    qryMainLogon_Name: TWideStringField;
    qryMainisVS1DB: TWideStringField;
    qryMainClientName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grpFiltersClick(Sender: TObject);
  private
    Procedure MakeQryMain;
  Protected
    procedure SetGridColumns; Override;
  public
    { Public declarations }
  end;

implementation

uses AppEnvironment, AppDatabase, CommonLib, SimpleEncrypt;

{$R *.dfm}

{ TBaseListingGUI1 }

procedure TERPDatabasesListGUI.FormCreate(Sender: TObject);
begin
  MakeQryMain;
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TERPDatabasesListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString(qryMainisVS1DB.fieldname  , ['T','']);
  inherited;
end;

procedure TERPDatabasesListGUI.MakeQryMain;
var
  x:Integer;
  DbRec: TDatabaseRec;

begin
  qrymain.sql.clear;
  for x:= 0 to AppEnv.AppDb.DatabaseList.Count -1 do begin
    DbRec:= TDatabaseRec(AppEnv.AppDb.DatabaseList.Objects[x]);
    if DbRec.Name <> 'erpnewdb' then begin
      if qrymain.sql.count >0 then qrymain.sql.add('union all');
      qrymain.sql.Add('SELECT ');
      qrymain.sql.Add(quotedstr(DbRec.Name)+' as Databasename,');
      qrymain.sql.Add('D.ServerName AS ServerName,');
      qrymain.sql.Add('E.employeename as employeename,');
      qrymain.sql.Add('P.Logon_Name as Logon_Name,');
      qrymain.sql.Add('C.ClientName as ClientName,');
      qrymain.sql.Add('if(' + quotedstr(DbRec.Name) +' LIKE "vs1_cloud%" , "T", "F") AS isVS1DB,');
      qrymain.sql.Add('P.Logon_Password AS Password');
      qrymain.sql.Add('FROM '+ trim(DbRec.Name)+'.tblemployees E '+
                      ' INNER JOIN '+ trim(DbRec.Name)+'.tblpassword P ON E.EmployeeID = P.employeeId'+
                      ' Left join tblVS1_databases  D ON D.DatabaseName = '+ quotedstr(DbRec.Name)+
                      ' Left join tblVS1_clients C ON C.vs1ClientID = D.Vs1_ClientID ');
      qrymain.sql.Add('WHERE ((IFNULL(D.ID,0)=0 OR D.`Status` ="Used"))');
    end;
  end;
  qrymain.sql.add('Order by Databasename, employeename');
end;

procedure TERPDatabasesListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainDPassword.AsString :=   DeCrypt(qryMainPassword.AsString , 'z');
end;

procedure TERPDatabasesListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainPassword.fieldname);
  RemoveFieldfromGrid(qryMainDPassword.fieldname);
end;

initialization
  RegisterClass(TERPDatabasesListGUI);

end.
