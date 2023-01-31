unit LeaveAccrualsReport;

{ Date     Version Who What
 -------- -------- --- ------------------------------------------------------
 25/07/05  1.00.01 IJB Removed HandleUnknownException (now handled by new
                       ExceptionalMagic code).

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, wwdblook, MemDS, DBAccess,
  MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,Forms, 
  Shader, kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TLeaveAccrualsReportGUI = class(TBaseListingGUI)
    Label4: TLabel;
    cboDepartments: TwwDBLookupCombo;
    qryContent: TERPQuery;
    qryClass: TERPQuery;
    chkAllDepartments: TCheckBox;
    Label5: TLabel;
    dsContent: TDataSource;
    qryMainEmployeeName: TWideStringField;
    qryMainType: TWideStringField;
    qryMainOpenningBalanceHrs: TFloatField;
    qryMainAccruedHours: TFloatField;
    qryMainLeaveLoading: TFloatField;
    qryMainClassName: TWideStringField;
    qryMainAmountAccrued: TFloatField;
    qryMainRate: TFloatField;
    qryMainDateAccrued: TDateField;
    qryMainzDetails: TIntegerField;
    qryMainCatagory: TWideStringField;


    procedure FormShow(Sender: TObject);
    procedure chkAllDepartmentsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboDepartmentsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormDestroy(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure actRefreshQryExecute(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: String);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure edtSearchChange(Sender: TObject);

  private
    { Private declarations }
    fsOrderSwitch:String;
    procedure CreateTemporaryTable;
    procedure LoadTempTable;
    procedure DropTemporaryTable;
    procedure DeleteTemporaryTableContents;
    function ReturnTempTableName: string;
    procedure LoadAmounts;
    Function GetOpenBalanceAmounts(const LeaveType:String):Double;
    Function GetOpenBalanceAmount(const LeaveType:String;Const EmployeeID:integer):Double;
    Function GetTotalAccumulatedAmounts(const LeaveType:String):Double;
    Function GetTotalOpenningBalanceHrs(const LeaveType:String):Double;


  protected
    procedure RefreshQuery; override;
    function GetReportTypeID: integer; override;
//    function DoDtFromChange(Sender:Tobject): boolean; override;
//    function DoDtToChange(Sender: TObject): boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  CommonDbLib, DNMExceptions, PayCommon, CommonLib, FastFuncs, MySQLConst, tcConst;

{$R *.dfm}

{ TBaseListingGUI1 }

function TLeaveAccrualsReportGUI.ReturnTempTableName: string;
begin
  Result := 'tmp_leaveaccrualsreport_' + GetMachineIdentification(true, true, true, true);
end;

procedure TLeaveAccrualsReportGUI.CreateTemporaryTable;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;

    qry.Sql.Clear;
    qry.Sql.Add('DROP TABLE IF EXISTS `' + ReturnTempTableName + '`; ');
    qry.Execute;

    qry.SQL.Clear;
    qry.SQL.Add('CREATE TABLE IF NOT EXISTS `' + ReturnTempTableName + '` (');
    qry.SQL.Add('`ID` INT AUTO_INCREMENT, ');
    qry.SQL.Add('`zDetails` INT DEFAULT ''0'' , ');
    qry.SQL.Add('`Catagory` VARCHAR(255), ');
    qry.SQL.Add('`EmployeeID` INT DEFAULT ''0'' , ');
    qry.SQL.Add('`EmployeeName` VARCHAR(255), ');
    qry.SQL.Add('`Type` VARCHAR(255), ');
    qry.SQL.Add('`Rate` DOUBLE DEFAULT ''0'', ');
    qry.SQL.Add('`OpenningBalanceHrs` DOUBLE DEFAULT ''0'', ');
    qry.SQL.Add('`DateAccrued` DATE,');
    qry.SQL.Add('`AccruedHours` DOUBLE DEFAULT ''0'', ');
    qry.SQL.Add('`LeaveLoading` DOUBLE DEFAULT ''0'', ');
    qry.SQL.Add('`AmountAccrued` DOUBLE DEFAULT ''0'', ');
    qry.SQL.Add('`ClassID` INT DEFAULT ''0'' , ');
    qry.SQL.Add('`ClassName` VARCHAR(255) , INDEX(`ID`))  ENGINE = InnoDB;');
    qry.Execute;
  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TLeaveAccrualsReportGUI.LoadTempTable;
var
  qry:TERPQuery;
  sInsert:string;
begin
  sInsert :=  'INSERT HIGH_PRIORITY INTO ' + ReturnTempTableName +
        ' (zDetails,Catagory,EmployeeID,EmployeeName,Type,Rate,OpenningBalanceHrs,DateAccrued,AccruedHours,LeaveLoading,AmountAccrued,ClassID,ClassName)';

  qry := TERPQuery.Create(nil);
  try
    with qry do begin
      Connection := CommonDbLib.GetSharedMyDacConnection;
      SQL.Clear;
      SQL.Add(sInsert);
      SQL.Add('SELECT ');
      SQL.Add('2 as zDetails, ');
      SQL.Add('"DetailRec" as Catagory,');  //this field for debug purposes only
      SQL.Add('L.EmployeeID, ');
      SQL.Add('E.EmployeeName, ');
      SQL.Add('L.Type, ');
      SQL.Add('0 as Rate,');
      SQL.Add('Round(L.OpenningBalanceHrs,'+inttostr(OtherRoundPlaces)+'), ');
      SQL.Add('LA.Date as DateAccrued,');
      SQL.Add('Round(LA.AccruedHours,'+inttostr(OtherRoundPlaces)+'), ');
      SQL.Add('L.LeaveLoading, ');
      SQL.Add('20.1 as AmountAccrued, ');
      SQL.Add('L.ClassID, ');
      SQL.Add('L.ClassName ');
      SQL.Add('FROM tblleave AS L ');
      SQL.Add('INNER JOIN tblleaveaccruals AS LA on LA.EmployeeID = L.EmployeeID AND LA.LeaveType = L.Type ');
      SQL.Add('INNER JOIN tblemployees AS E on L.EmployeeID = E.EmployeeID ');

      if chkAllDepartments.Checked then begin
        if chkIgnoreDates.Checked then begin
          SQL.Add('WHERE LA.Date BETWEEN "' + FormatDateTime(MysqlDateFormat,0));
          SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,MaxDateTime) + '"');
        end
        else begin
          SQL.Add('WHERE LA.Date BETWEEN "' + FormatDateTime(MysqlDateFormat,dtFrom.DateTime));
          SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,dtTo.DateTime) + '"');
        end;
      end else begin
        if chkIgnoreDates.Checked then begin
          SQL.Add('WHERE L.ClassName = ' + QuotedStr(cboDepartments.Text) + ' AND LA.Date BETWEEN "' + FormatDateTime(MysqlDateFormat,0));
          SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,MaxDateTime) + '"');
        end
        else begin
          SQL.Add('WHERE L.ClassName = ' + QuotedStr(cboDepartments.Text) + ' AND LA.Date BETWEEN "' + FormatDateTime(MysqlDateFormat,dtFrom.DateTime));
          SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,dtTo.DateTime) + '"');
        end;
      end;

      SQL.Add('UNION ALL ');

      SQL.Add('SELECT ');
      SQL.Add('1 as zDetails, ');
      SQL.Add('"SubTotal" as Catagory, ');   //this field for debug purposes only
      SQL.Add('L.EmployeeID, ');
      SQL.Add('E.EmployeeName, ');
      SQL.Add('L.Type, ');
      SQL.Add('Space(255) as Rate, ');
      SQL.Add('Round(L.OpenningBalanceHrs,'+inttostr(OtherRoundPlaces)+'), ');
      SQL.Add('LA.Date as DateAccrued, ');
      SQL.Add('Round(Sum(LA.AccruedHours),'+inttostr(OtherRoundPlaces)+'), ');
      SQL.Add('L.LeaveLoading, ');
      SQL.Add('0.0 as AmountAccrued, ');
      SQL.Add('L.ClassID, ');
      SQL.Add('Space(255) as ClassName ');
      SQL.Add('FROM tblleave AS L ');
      SQL.Add('INNER JOIN tblleaveaccruals AS LA on LA.EmployeeID = L.EmployeeID AND LA.LeaveType = L.Type ');
      SQL.Add('INNER JOIN tblemployees AS E on L.EmployeeID = E.EmployeeID ');

      if chkAllDepartments.Checked then begin
        if chkIgnoreDates.Checked then begin
          SQL.Add('WHERE LA.Date BETWEEN "' + FormatDateTime(MysqlDateFormat,0));
          SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,MaxDateTime) + '"');
        end
        else begin
          SQL.Add('WHERE LA.Date BETWEEN "' + FormatDateTime(MysqlDateFormat,dtFrom.DateTime));
          SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,dtTo.DateTime) + '"');
        end;
      end else begin
        if chkIgnoreDates.Checked then begin
          SQL.Add('WHERE L.ClassName = ' + QuotedStr(cboDepartments.Text) + ' AND LA.Date BETWEEN "' + FormatDateTime(MysqlDateFormat,0));
          SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,MaxDateTime) + '"');
        end
        else begin
          SQL.Add('WHERE L.ClassName = ' + QuotedStr(cboDepartments.Text) + ' AND LA.Date BETWEEN "' + FormatDateTime(MysqlDateFormat,dtFrom.DateTime));
          SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,dtTo.DateTime) + '"');
        end;
      end;

      SQL.Add('GROUP BY E.EmployeeName,type ');

      SQL.Add('UNION ALL ');

      SQL.Add('SELECT ');
      SQL.Add('0 as zDetails, ');
       SQL.Add('"Total" as Catagory,');  //this field for debug purposes only
      SQL.Add('L.EmployeeID, ');
      SQL.Add('Space(255) as EmployeeName, ');
      SQL.Add('L.Type, ');
      SQL.Add('Space(255) as Rate,');
      SQL.Add('0.0 as OpenningBalanceHrs,');
      SQL.Add('LA.Date as DateAccrued,');
      SQL.Add('Round(SUM(LA.AccruedHours),'+inttostr(OtherRoundPlaces)+'), ');
      SQL.Add('L.LeaveLoading, ');
      SQL.Add('0.1 as AmountAccrued, ');
      SQL.Add('L.ClassID, ');
      SQL.Add('Space(255) as ClassName ');
      SQL.Add('FROM tblleave AS L ');
      SQL.Add('INNER JOIN tblleaveaccruals AS LA on LA.EmployeeID = L.EmployeeID AND LA.LeaveType = L.Type ');
      SQL.Add('INNER JOIN tblemployees AS E on L.EmployeeID = E.EmployeeID ');
      if chkAllDepartments.Checked then begin
        if chkIgnoreDates.Checked then begin
          SQL.Add('WHERE LA.Date BETWEEN "' + FormatDateTime(MysqlDateFormat,0));
          SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,MaxDateTime) + '"');
        end
        else begin
          SQL.Add('WHERE LA.Date BETWEEN "' + FormatDateTime(MysqlDateFormat,dtFrom.DateTime));
          SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,dtTo.DateTime) + '"');
        end;
      end else begin
        if chkIgnoreDates.Checked then begin
          SQL.Add('WHERE L.ClassName = ' + QuotedStr(cboDepartments.Text) + ' AND LA.Date BETWEEN "' + FormatDateTime(MysqlDateFormat,0));
          SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,MaxDateTime) + '"');
        end
        else begin
          SQL.Add('WHERE L.ClassName = ' + QuotedStr(cboDepartments.Text) + ' AND LA.Date BETWEEN "' + FormatDateTime(MysqlDateFormat,dtFrom.DateTime));
          SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,dtTo.DateTime) + '"');
        end;
      end;

      SQL.Add('GROUP BY L.Type ');
      SQL.Add(' ORDER BY Type,zDetails');

      Execute;

      LoadAmounts;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

Function TLeaveAccrualsReportGUI.GetOpenBalanceAmount(Const LeaveType:String; Const EmployeeID:integer):Double;
var
  qryTotal:TERPQuery;
begin
  Result := 0;
  qryTotal := TERPQuery.Create(nil);
  try
    qryTotal.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTotal.SQL.Clear;
    qryTotal.SQL.Add('SELECT OpenningBalanceHrs,EmployeeID,Type,Rate,AccruedHours,LeaveLoading FROM ' + ReturnTempTableName);
    qryTotal.SQL.Add(' WHERE Type = ' + QuotedStr(LeaveType));
    qryTotal.SQL.Add(' AND EmployeeID = ' + IntToStr(EmployeeID));
    qryTotal.SQL.Add(' AND zDetails = 2');

    if chkAllDepartments.Checked then begin
        qryTotal.SQL.Add('AND DateAccrued BETWEEN "' + FormatDateTime(MysqlDateFormat,dtFrom.DateTime));
        qryTotal.SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,dtTo.DateTime) + '"');
    end else begin
        qryTotal.SQL.Add('AND ClassName = ' + QuotedStr(cboDepartments.Text) + ' AND DateAccrued BETWEEN "' + FormatDateTime(MysqlDateFormat,dtFrom.DateTime));
        qryTotal.SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,dtTo.DateTime) + '"');
    end;

    qryTotal.Open;
    qryTotal.First;

    result := result + qryTotal.FieldByName('OpenningBalanceHrs').AsFloat *
                   qryTotal.FieldByName('Rate').AsFloat *
                      (1 + (qryTotal.FieldByName('LeaveLoading').AsFloat/100));

  finally
    FreeAndNil(qryTotal);
  end;
end;

Function TLeaveAccrualsReportGUI.GetOpenBalanceAmounts(Const LeaveType:String):Double;
var
  qryTotal:TERPQuery;
begin
  Result := 0;
  qryTotal := TERPQuery.Create(nil);
  try
    qryTotal.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTotal.SQL.Clear;
    qryTotal.SQL.Add('SELECT OpenningBalanceHrs,EmployeeName,Type,Rate,AccruedHours,LeaveLoading FROM ' + ReturnTempTableName);
    qryTotal.SQL.Add(' WHERE Type = ' + QuotedStr(LeaveType));
    qryTotal.SQL.Add(' AND zDetails = 2');

    if chkAllDepartments.Checked then begin
        qryTotal.SQL.Add('AND DateAccrued BETWEEN "' + FormatDateTime(MysqlDateFormat,dtFrom.DateTime));
        qryTotal.SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,dtTo.DateTime) + '"');
    end else begin
        qryTotal.SQL.Add('AND ClassName = ' + QuotedStr(cboDepartments.Text) + ' AND DateAccrued BETWEEN "' + FormatDateTime(MysqlDateFormat,dtFrom.DateTime));
        qryTotal.SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,dtTo.DateTime) + '"');
    end;

    qryTotal.SQL.Add(' GROUP BY EmployeeName');
    qryTotal.Open;
    qryTotal.First;
    while not qryTotal.Eof do begin
      result := result + qryTotal.FieldByName('OpenningBalanceHrs').AsFloat *
                   qryTotal.FieldByName('Rate').AsFloat *
                      (1 + (qryTotal.FieldByName('LeaveLoading').AsFloat/100));

      qryTotal.Next;
    end;
  finally
    FreeAndNil(qryTotal);
  end;
end;

Function TLeaveAccrualsReportGUI.GetTotalOpenningBalanceHrs(Const LeaveType:String):Double;
var
  qryTotal:TERPQuery;
begin
  qryTotal := TERPQuery.Create(nil);
  try
    qryTotal.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTotal.SQL.Clear;
    qryTotal.SQL.Add('SELECT  OpenningBalanceHrs,EmployeeName,Type,Rate,AccruedHours,LeaveLoading FROM  ' + ReturnTempTableName);
    qryTotal.SQL.Add(' WHERE Type = ' + QuotedStr(LeaveType));
    qryTotal.SQL.Add('AND zDetails = 2');
    if chkAllDepartments.Checked then begin
        qryTotal.SQL.Add('AND DateAccrued BETWEEN "' + FormatDateTime(MysqlDateFormat,dtFrom.DateTime));
        qryTotal.SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,dtTo.DateTime) + '"');
    end else begin
        qryTotal.SQL.Add('AND ClassName = ' + QuotedStr(cboDepartments.Text) + ' AND DateAccrued BETWEEN "' + FormatDateTime(MysqlDateFormat,dtFrom.DateTime));
        qryTotal.SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,dtTo.DateTime) + '"');
    end;

    qryTotal.SQL.Add(' GROUP BY EmployeeName');
    qryTotal.Open;
    result := 0;
    qryTotal.First;
    while not qryTotal.EOF do begin
      result := result + qryTotal.FieldByName('OpenningBalanceHrs').AsFloat;
      qryTotal.Next;
    end;  
  finally
    FreeAndNil(qryTotal);
  end;
end;


Function TLeaveAccrualsReportGUI.GetTotalAccumulatedAmounts(Const LeaveType:String):Double;
var
  qryTotal:TERPQuery;
begin
  qryTotal := TERPQuery.Create(nil);
  try
    qryTotal.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTotal.SQL.Clear;
    qryTotal.SQL.Add('SELECT SUM(AmountAccrued) as TotalAmount,Type FROM ' + ReturnTempTableName);
    qryTotal.SQL.Add(' WHERE zDetails = 2');
    qryTotal.SQL.Add(' AND Type = ' + QuotedStr(LeaveType));


    if chkAllDepartments.Checked then begin
        qryTotal.SQL.Add('AND DateAccrued BETWEEN "' + FormatDateTime(MysqlDateFormat,dtFrom.DateTime));
        qryTotal.SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,dtTo.DateTime) + '"');
    end else begin
        qryTotal.SQL.Add('AND ClassName = ' + QuotedStr(cboDepartments.Text) + ' AND DateAccrued BETWEEN "' + FormatDateTime(MysqlDateFormat,dtFrom.DateTime));
        qryTotal.SQL.Add('" AND "' + FormatDateTime(MysqlDateFormat,dtTo.DateTime) + '"');
    end;

    qryTotal.SQL.Add(' GROUP BY Type');
    qryTotal.Open;
    result := qryTotal.FieldByName('TotalAmount').AsFloat;
  finally
    FreeAndNil(qryTotal);
  end;
end;

procedure TLeaveAccrualsReportGUI.LoadAmounts;
var
  qry,qryTemp:TERPQuery;
  dRate:Double;
begin
  qry := TERPQuery.Create(nil);
  qryTemp := TERPQuery.Create(nil);
  try
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      Connection := CommonDbLib.GetSharedMyDacConnection;
      SQL.Clear;
      SQL.Add('SELECT * FROM ' + ReturnTempTableName);
      Open;

      First;
      while not Eof do begin  //calc and post each leave amount
        if FieldByName('zDetails').AsInteger = 2 then begin
          Edit;
          dRate := GetEmployeeHourlyRate(FieldByName('EmployeeID').AsInteger);
          FieldByName('Rate').AsFloat := dRate;
          FieldByName('AmountAccrued').AsFloat := dRate * FieldByName('AccruedHours').AsFloat * (1 + (FieldByName('LeaveLoading').AsFloat/100));
          Post;
        end;
        Next;
      end;

      First;
      while not Eof do begin  //calc and post subtotal amounts
        if FieldByName('zDetails').AsInteger = 1 then begin
          Edit;
          dRate := GetEmployeeHourlyRate(FieldByName('EmployeeID').AsInteger);
          FieldByName('Rate').AsFloat := dRate;
          FieldByName('AmountAccrued').AsFloat := (dRate * FieldByName('AccruedHours').AsFloat
             * (1 + (FieldByName('LeaveLoading').AsFloat/100)))
             + GetOpenBalanceAmount(FieldByName('Type').AsString,FieldByName('EmployeeID').AsInteger);
          FieldByName('ClassName').AsString := 'Sub Total';
          Post;
        end;
        Next;
      end;

       //add totals
      First;
      while not eof do begin
        if FieldByName('zDetails').AsInteger = 0 then begin
          Edit;
          FieldByName('AmountAccrued').AsFloat :=  GetTotalAccumulatedAmounts(FieldByName('Type').AsString) + GetOpenBalanceAmounts(FieldByName('Type').AsString);
          FieldByName('ClassName').AsString := 'Total';
          FieldByName('OpenningBalanceHrs').AsFloat := GetTotalOpenningBalanceHrs(FieldByName('Type').AsString);
          Post;
        end;
        Next;
      end;
    end;
  finally
    FreeAndNil(qry);
    FreeAndNil(qryTemp);
  end;
end;

procedure TLeaveAccrualsReportGUI.RefreshQuery;
begin
  qryMain.Close;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT * FROM ' + ReturnTempTableName);
  RefreshOrignalSQL;
  DeleteTemporaryTableContents;
  LoadTempTable;
  qryMain.Open;
  inherited;
  grdMain.columnbyName('OpenningBalanceHrs').DisplayLabel   := 'Opening Balance Hrs';
end;

//procedure TLeaveAccrualsReportGUI.RefreshTotals;
//var
//  qry: TERPQuery;
//begin
//  inherited;
//  qry := TERPQuery.Create(nil);
//  try
//    qry.Options.FlatBuffers := True;
//    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
//    qry.SQL.Clear;
//    qry.SQL.Add('SELECT');
//    qry.SQL.Add('Sum(AnnualLeaveHours) AS TotalALHours, Sum(AnnualStdTotal) AS TotalStdAL, ');
//    qry.SQL.Add('Sum(LeaveLoading) As LeaveLoading, Sum(AnnualLeaveTotal) AS TotalAL, ');
//    qry.SQL.Add('Sum(LongServiceHours) AS LSLHours, Sum(LongServiceTotal) AS TotalLS, ');
//    qry.SQL.Add('Sum(SickHours) AS TotalSickHours');
//    qry.SQL.Add('FROM ' + ReturnTempTableName);
//    qry.Open;
//
//    grdMain.ColumnByName('AnnualLeaveHours').FooterValue := FloatToStrF(qry.FieldByName('TotalALHours').AsFloat,
//      ffFixed, 15, 4);
//    grdMain.ColumnByName('AnnualStdTotal').FooterValue   := FloatToStrF(qry.FieldByName('TotalStdAL').AsFloat,
//      ffCurrency, 15, CurrencyRoundPlaces);
//    grdMain.ColumnByName('LeaveLoading').FooterValue     := FloatToStrF(qry.FieldByName('LeaveLoading').AsFloat,
//      ffCurrency, 15, CurrencyRoundPlaces);
//    grdMain.ColumnByName('AnnualLeaveTotal').FooterValue := FloatToStrF(qry.FieldByName('TotalAL').AsFloat, ffCurrency, 15, CurrencyRoundPlaces);
//    grdMain.ColumnByName('LongServiceHours').FooterValue := FloatToStrF(qry.FieldByName('LSLHours').AsFloat, ffFixed, 15, 4);
//    grdMain.ColumnByName('LongServiceTotal').FooterValue := FloatToStrF(qry.FieldByName('TotalLS').AsFloat, ffCurrency, 15, CurrencyRoundPlaces);
//    grdMain.ColumnByName('SickHours').FooterValue        := FloatToStrF(qry.FieldByName('TotalSickHours').AsFloat, ffFixed, 15, 4);
//    qry.Close;
//  finally
//    // Free object.
//    if Assigned(qry) then FreeAndNil(qry);
//  end;
//end;

procedure TLeaveAccrualsReportGUI.FormShow(Sender: TObject);
begin
  try
    GroupFilterString := 'zDetails = 0';
    inherited;

    if ErrorOccurred then Exit;
    qryClass.Open;

    RefreshQuery;
    //RefreshTotals;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    on e: Exception do raise;
  end;
end;

procedure TLeaveAccrualsReportGUI.chkAllDepartmentsClick(Sender: TObject);
begin
  inherited;
  if chkAllDepartments.Checked then begin
    Label4.Enabled         := false;
    cboDepartments.Enabled := false;
  end else begin
    Label4.Enabled         := true;
    cboDepartments.Enabled := true;
  end;
  cboDepartments.Refresh;
  RefreshQuery;
  //RefreshTotals;
end;

procedure TLeaveAccrualsReportGUI.FormCreate(Sender: TObject);
begin
  fsOrderSwitch := 'ASC';

  inherited;
  if ErrorOccurred then Exit;
  qryMain.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryClass.Connection := CommonDbLib.GetSharedMyDacConnection;

  CreateTemporaryTable;

end;

procedure TLeaveAccrualsReportGUI.cboDepartmentsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
  Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
  //RefreshTotals;
end;

procedure TLeaveAccrualsReportGUI.DropTemporaryTable;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE `' + ReturnTempTableName + ';');
    qry.Execute;
  finally
    // Free used object.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function TLeaveAccrualsReportGUI.GetReportTypeID: integer;
begin
  Result := 54;
end;

procedure TLeaveAccrualsReportGUI.DeleteTemporaryTableContents;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM `' + ReturnTempTableName + '` WHERE ID > 0; ');
    qry.Execute;
  finally
    // Free used object.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TLeaveAccrualsReportGUI.FormDestroy(Sender: TObject);
begin
  DropTemporaryTable;
  inherited;
end;

procedure TLeaveAccrualsReportGUI.cmdPrintClick(Sender: TObject);
begin
  if chkAdvancedPrinting.Checked then begin
    ReportSQLSupplied := true;
    TemplateSQL       := '{SQL}SELECT * FROM ' + ReturnTempTableName + ' ';
    if not chkAllDepartments.Checked then begin
      TemplateSQL := TemplateSQL + 'WHERE ClassName = ' + QuotedStr(cboDepartments.Text) + ' ';
    end;

    TemplateSQL := TemplateSQL + 'GROUP BY ClassName, EmployeeName ORDER BY ClassName, EmployeeName';
    TemplateSQL := TemplateSQL +
      '~|||~{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO';
  end;

  inherited;
  ReportSQLSupplied := false;
end;

procedure TLeaveAccrualsReportGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Summary}
        GroupFilterString := '(zDetails = 0)';
      end;
    1: 
      begin {Details}
        GroupFilterString := '(zDetails <> 2)';
      end;
    2: 
      begin  {Extra Details}
        GroupFilterString := '(zDetails <> 1)';
      end;
  end;
  inherited;
end;

procedure TLeaveAccrualsReportGUI.actRefreshQryExecute(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TLeaveAccrualsReportGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if qryMain.FieldByName('zDetails').AsInteger = 0 then begin
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

//function TLeaveAccrualsReportGUI.DoDtFromChange(Sender:TObject): boolean;
//begin
//  result:= false;
//  if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) then Exit;
//  if not (dtFrom.DroppedDown) then begin
//    RefreshQuery;
//    result:= true;
//  end;
//end;

//function TLeaveAccrualsReportGUI.DoDtToChange(Sender:TObject): boolean;
//begin
//  result:= false;
//  if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) then Exit;
//  if not (dtTo.DroppedDown) then begin
//    RefreshQuery;
//    result:= true;
//  end;
//end;

procedure TLeaveAccrualsReportGUI.grdMainTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
//  inherited;
  if fsOrderSwitch = 'ASC' then fsOrderSwitch := 'DESC' else fsOrderSwitch := 'ASC';

  with qryMain do begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM ' + ReturnTempTableName);
    SQL.Add(' ORDER BY Type ' + fsOrderSwitch);
    Open;
    grdMain.columnbyName('OpenningBalanceHrs').DisplayLabel   := 'Opening Balance Hrs';
  end;
end;

procedure TLeaveAccrualsReportGUI.edtSearchKeyPress(Sender: TObject;
  var Key: Char);
begin
  UseSortinSearch  := false;
//  inherited;

end;

procedure TLeaveAccrualsReportGUI.edtSearchChange(Sender: TObject);
begin
  UseSortinSearch  := false;
  inherited;

end;

initialization
  RegisterClassOnce(TLeaveAccrualsReportGUI);
end.
