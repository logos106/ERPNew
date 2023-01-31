unit HowToListFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListExpress, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  THowToListGUI = class(TBaseListExpressGUI)
    qryMainHowToId: TIntegerField;
    qryMainDescription: TWideStringField;
    btnDelete: TwwIButton;
    wwIButton1: TwwIButton;
    btnPhone: TDNMSpeedButton;
    chkStartup: TCheckBox;
    qryMainCompanyName: TWideStringField;
    qryMainAuthorName: TWideStringField;
    btnExportasSQL: TDNMSpeedButton;
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);override;
    procedure btnGridClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);override;
    procedure btnPhoneClick(Sender: TObject);
    procedure chkStartupClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnExportasSQLClick(Sender: TObject);
  private
    function HowtoRecSQL: String;
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex: Integer);Override;
    procedure SetGridColumns; Override;
  public
    Function ExpressDetailListName:String;override;
    procedure RefreshQuery; override;
    procedure UpdateMe; override;
    // is called from ..(TErpMessagesGUI) descendant forms to mimic the behaviour
    procedure SetGrpFilters;
  end;

implementation

{$R *.dfm}
uses
  CommonLib, CommonDBLib, CommonFormLib,
  frmHowTo, frmHowToEdit, frmShowMeERPOffices, AppEnvironment,
  DbSharedObjectsObj, tcConst, BusObjHowTo;

{const

  csQueryMain = 'select h.HowToId, h.Description, e.EmployeeName, ifnull(h.CompanyName, "") as CompanyName'#13#10+
                'from tblHowTo h inner join tblEmployees e on e.Employeeid = h.employeeid'#13#10+
                'union all'#13#10+
                'select h.HowToId, h.Description, "" as EmployeeName, ifnull(h.CompanyName, "") as CompanyName'#13#10+
                'from tblHowTo h where h.EmployeeId = 0'#13#10+
                'order by HowtoId';
}
  (*csQueryMain = 'select * from tblHowTo order by HowToId';*)

procedure THowToListGUI.btnExportasSQLClick(Sender: TObject);
var
  filename :String;
begin
  filename :='';
  if ExporttoSQL('HowTo' , filename) then begin

  end;
end;
procedure THowToListGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
begin
  inherited;
  if IterateProcno = ItearteProcno4ExportToSQL then begin
    fsExportedSQL:= fsExportedSQL + HowtoRecSQL;
  end;
end;

function THowToListGUI.HowtoRecSQL: String;
begin
  result := '';
  if qryMainhowtoID.asInteger =0 then exit;
  result := THowTo.HowtoRecSQL(qryMainhowtoID.asInteger);
end;

procedure THowToListGUI.btnGridClick(Sender: TObject);
var
  scr :TERPScript;
begin
  inherited;
  if qryMain.FieldByName('HowToId').asInteger=0 then exit;
  if MessageDlgXP_Vista('This will Delete the Entry and Will Not be Able to Un-Delete it.' + NL+
                        'Do you wish to Delete it?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

  scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
    scr.SQL.clear;
    scr.SQL.add('DELETE FROM tblHowToLines where HowToId='     + inttostr(qryMain.FieldByName('HowToId').asInteger)+';');
    scr.SQL.add('DELETE FROM tblHowTo where HowToId='          + inttostr(qryMain.FieldByName('HowToId').asInteger)+';');
    scr.SQL.add('DELETE FROM tblTrainingButtons where HowToId='+ inttostr(qryMain.FieldByName('HowToId').asInteger)+';');

    scr.Execute;
    closedb(Qrymain);
    RefreshQuery;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;
end;

procedure THowToListGUI.btnPhoneClick(Sender: TObject);
begin
  inherited;
  TfmShowMeERPOffices.ShowMe;
end;

procedure THowToListGUI.chkStartupClick(Sender: TObject);
begin
  inherited;
  AppEnv.Employee.ShowVideoMenuAtStartup := chkStartup.checked;
end;

procedure THowToListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmHowToEdit' , 0);
end;

function THowToListGUI.ExpressDetailListName: String;
begin
  Result := '';
end;

procedure THowToListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure THowToListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

procedure THowToListGUI.FormDestroy(Sender: TObject);
begin
  inherited;
//
end;

procedure THowToListGUI.FormShow(Sender: TObject);
begin
  qryMain.Open;
  chkStartup.checked := AppEnv.Employee.ShowVideoMenuAtStartup;
  inherited;
end;

procedure THowToListGUI.grdMainDblClick(Sender: TObject);
begin
  grdMain.SelectedField := qryMain.FieldByName('HowToId');
  inherited;
end;

procedure THowToListGUI.grpFiltersClick(Sender: TObject);
begin
//  inherited;
           if (grpFilters.itemindex =6)  then  exit;
       if (grpFilters.itemindex =0) then OpenERPListForm('TERPTrainingVideosGUI', nil)
  else if (grpFilters.itemindex =1) then OpenERPListForm('TERPChangesGUI', nil)
  else if (grpFilters.itemindex =2) then OpenERPListForm('TERPWebSiteChangesGUI', nil)
  else if (grpFilters.itemindex =3) then OpenERPListForm('TERPTabletChangesGUI', nil)
  else if (grpFilters.itemindex =4) then OpenERPListForm('TERPTipsGUI', nil)
  else if (grpFilters.itemindex =5) then OpenERPListForm('TERPPopupsGUI', nil)
  else exit;
  Self.close;
end;

procedure THowToListGUI.RefreshQuery;
begin
  inherited;

end;

procedure THowToListGUI.SetGridColumns;
begin
  inherited;
 RemoveFieldfromGrid(qryMainHowToId.fieldname);
end;

procedure THowToListGUI.SetGrpFilters;
begin

  btnExpressDetail.Visible := false;
  grpFilters.Columns := 7;
  grpFilters.Items.Add('Videos');
  grpFilters.Items.Add('Changes');
  grpFilters.Items.Add('Website');
  grpFilters.Items.Add('Tablet');
  grpFilters.Items.Add('Tips');
  grpFilters.Items.Add('Popups');
  grpFilters.Items.Add('How Tos');
  grpFilters.ItemIndex := 6;

end;

procedure THowToListGUI.UpdateMe;
begin
  inherited;
  (*qryMain.Close;
  qryMain.SQL.Text := csQueryMain;
  qryMain.Open;*)
end;

initialization
  RegisterClassOnce(THowToListGUI);
end.
