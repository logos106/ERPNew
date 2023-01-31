unit PayJobList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TPayJobListGUI = class(TBaseListingGUI)
    qryMainPayDate: TDateField;
    qryMainDatePaid: TDateTimeField;
    qryMainPayID: TIntegerField;
    qryMainEmpName: TWideStringField;
    qryMainJob: TWideStringField;
    qryMainWages: TFloatField;
    qryMainAllowances: TFloatField;
    qryMainSundries: TFloatField;
    qryMainTotal: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainUpdateFooter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    sTempTbl: string;
    bFooterCalcInProgress: boolean;
    procedure CreateTempJobTable;
    procedure DeleteTempJobTable;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  public
    { Public declarations }

  end;

implementation

uses
  CommonDbLib, CommonLib, tcConst;

{$R *.dfm}

procedure TPayJobListGUI.CreateTempJobTable;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try

    qry.Sql.Clear;
    qry.Sql.Add('DROP TABLE IF EXISTS ' + sTempTbl);
    qry.Execute;

    qry.Sql.Clear;
    qry.Sql.Add('CREATE TABLE ' + sTempTbl + ' ( ');
    qry.Sql.Add('ID int(11) NOT NULL auto_increment, ');
    qry.Sql.Add('PRIMARY KEY (ID)) ');
    qry.Sql.Add('SELECT P.PayID, P.EmployeeID, EmpName,PayDate,  DatePaid, PayPeriods, ');
    qry.Sql.Add('R.ClientID as ClientID, ');
    qry.Sql.Add('C.Company as Job, ');
    qry.Sql.Add('P.Wages as TotalWages, R.LineTotal as JobWages, ');
    qry.Sql.Add('0.0 as JobAllowAmount, " " as AllowCalcBy, 0.0 as JobAllow, 0.0 as JobSundries ');
    qry.Sql.Add('FROM tblPays as P ');
    qry.Sql.Add('LEFT JOIN tblEmployees as E ON P.EmployeeID=E.EmployeeID ');
    qry.Sql.Add('INNER JOIN tblPaysPayRates as R ON P.PayID = R.PayID ');
    qry.Sql.Add('LEFT JOIN tblClients as C ON R.ClientID = C.ClientID ');
    qry.Sql.Add('WHERE ');
    qry.Sql.Add('Paid = "T" AND Deleted = "F" AND ');
    qry.Sql.Add('R.ClientID <> 0 ');

    qry.Sql.Add('UNION ALL ');
    qry.Sql.Add('SELECT P.PayID, P.EmployeeID, EmpName,PayDate,  DatePaid, PayPeriods, ');
    qry.Sql.Add('A.ClientID as ClientID, ');
    qry.Sql.Add('C.Company as Job, ');
    qry.Sql.Add('P.Wages as TotalWages, 0.0 as JobWages, ');
    qry.Sql.Add('Amount as JobAllowAmount, CalcBy as AllowCalcBy, ');
    qry.Sql.Add('IF (CalcBy = "%", (P.Wages)*(Amount/100.00), Amount)  as JobAllow, ');
    qry.Sql.Add('0.0 as JobSundries ');
    qry.Sql.Add('FROM tblPays as P ');
    qry.Sql.Add('LEFT JOIN tblEmployees as E ON P.EmployeeID=E.EmployeeID ');
    qry.Sql.Add('INNER JOIN tblPaysAllowances as A ON P.PayID = A.PayID ');
    qry.Sql.Add('LEFT JOIN tblClients as C ON A.ClientID = C.ClientID ');
    qry.Sql.Add('WHERE ');
    qry.Sql.Add('Paid = "T" AND Deleted = "F" AND ');
    qry.Sql.Add('A.ClientID <> 0 ');

    qry.Sql.Add('UNION ALL ');
    qry.Sql.Add('SELECT ');
    qry.Sql.Add('P.PayID, P.EmployeeID, EmpName,PayDate,  DatePaid, PayPeriods, ');
    qry.Sql.Add('S.ClientID as ClientID, ');
    qry.Sql.Add('C.Company as Job, ');
    qry.Sql.Add('P.Wages as TotalWages, 0.0 as JobWages, ');
    qry.Sql.Add('0.0 as JobAllowAmount, " " as AllowCalcBy, 0.0 as JobAllow, ');
    qry.Sql.Add('Amount as JobSundries ');
    qry.Sql.Add('FROM tblPays as P ');
    qry.Sql.Add('LEFT JOIN tblEmployees as E ON P.EmployeeID=E.EmployeeID ');
    qry.Sql.Add('INNER JOIN tblPaysSundries as S ON P.PayID = S.PayID ');
    qry.Sql.Add('LEFT JOIN tblClients as C ON S.ClientID = C.ClientID ');
    qry.Sql.Add('WHERE ');
    qry.Sql.Add('Paid = "T" AND Deleted = "F" AND ');
    qry.Sql.Add('S.ClientID <> 0 ');

    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPayJobListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  bFooterCalcInProgress := false;
  sTempTbl := 'tmp_tblpayjobs_' + GetMachineIdentification(true, true, true, true);
  CreateTempJobTable;
  qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'tmp_tbl', sTempTbl);
  RefreshOrignalSQL;
end;

procedure TPayJobListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('xFrom').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('xTo').AsDate := dtTo.DateTime;
  inherited;
  grdMainUpdateFooter(nil);
end;


procedure TPayJobListGUI.grdMainUpdateFooter(Sender: TObject);
var
  dWages, dAllowances, dSundries, dTotal: double;
  oRecPointer: TBookmark;
begin
  inherited;
  if not bFooterCalcInProgress then begin
    bFooterCalcInProgress := true;
    qryMain.DisableControls;
    oRecPointer := qryMain.GetBookmark;
    try
      dWages := 0;
      dAllowances := 0;
      dSundries := 0;
      dTotal := 0;

      qryMain.First;
      while not qryMain.Eof do begin
        dWages := dWages + qryMain.FieldByName('Wages').AsFloat;
        dAllowances := dAllowances + qryMain.FieldByName('Allowances').AsFloat;
        dSundries := dSundries + qryMain.FieldByName('Sundries').AsFloat;
        dTotal := dTotal + qryMain.FieldByName('Total').AsFloat;
        qryMain.Next;
      end;
      grdMain.ColumnByName('Wages').FooterValue := FloatToStrF(dWages, ffCurrency, 15, CurrencyRoundPlaces);
      grdMain.ColumnByName('Allowances').FooterValue := FloatToStrF(dAllowances, ffCurrency, 15, CurrencyRoundPlaces);
      grdMain.ColumnByName('Sundries').FooterValue := FloatToStrF(dSundries, ffCurrency, 15, CurrencyRoundPlaces);
      grdMain.ColumnByName('Total').FooterValue := FloatToStrF(dTotal, ffCurrency, 15, CurrencyRoundPlaces);
    finally
      qryMain.GoToBookmark(oRecPointer);
      qryMain.FreeBookmark(oRecPointer);      
      qryMain.EnableControls;
      bFooterCalcInProgress := false;
    end;
  end;
end;

procedure TPayJobListGUI.RefreshTotals;
begin
  inherited;
  grdMainUpdateFooter(nil);
end;

procedure TPayJobListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if not qryMain.Active then Exit;
end;

procedure TPayJobListGUI.DeleteTempJobTable;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + sTempTbl + '; ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TPayJobListGUI.FormDestroy(Sender: TObject);
begin
  DeleteTempJobTable;
  inherited;
end;

initialization
  RegisterClassOnce(TPayJobListGUI);
end.
