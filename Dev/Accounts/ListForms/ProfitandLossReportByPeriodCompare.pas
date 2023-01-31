unit ProfitandLossReportByPeriodCompare;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProfitandLossPeriodReportBase, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , ReportSQLProfitAndLossPeriod,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProfitandLossReportByPeriodCompareGUI = class(TProfitLossPeriodBase)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
  Protected
    Procedure AddExtrafields(pColumn: pColumnRec);override;
  public
    Procedure RefreshAll; override;

  end;


implementation

uses CommonLib, AppEnvironment, BaseListingForm, tcConst;

{$R *.dfm}
{ TProfitandLossReportByPeriodCompareGUI }

procedure TProfitandLossReportByPeriodCompareGUI.AddExtrafields(pColumn: pColumnRec);
var
  PreviousColumn: pColumnRec;
begin
  inherited;
  With TReportSQLProfitAndLossPeriodCompare(ReportSQLObj) do begin
              if pColumn^.ColumnNo = 1 then {as the first column will not have any comparison } exit;

              if Qrymain.findfield('Amount_diff'+ inttostr(pColumn^.ColumnNo)) <> nil then TFloatfield(Qrymain.findfield('Amount_diff'+ inttostr(pColumn^.ColumnNo) + '')).currency := True;
              if Qrymain.findfield('Amount_Perc'+ inttostr(pColumn^.ColumnNo)) <> nil then TFloatfield(Qrymain.findfield('Amount_Perc'+ inttostr(pColumn^.ColumnNo) + '')).DisplayFormat := '##0.##%';
              if pColumn^.ColumnNo =1 then exit;
              PreviousColumn := LstColumn.Items[pColumn^.ColumnNo-2];
              if PreviousColumn = nil then exit;
              AddGridSelectedfield('' + 'Amount_Diff'+ inttostr(pColumn^.ColumnNo) + ''  ,10,   'Diff '+'~' +PreviousColumn^.ColumnName , pColumn^.ColumnName  );
              AddGridSelectedfield('' + 'Amount_Perc'+ inttostr(pColumn^.ColumnNo) + ''  ,10,   'Percentage '+'~' +PreviousColumn^.ColumnName , pColumn^.ColumnName  );
  end;
  grdMain.TitleLines := 4;
end;

procedure TProfitandLossReportByPeriodCompareGUI.FormCreate(Sender: TObject);
begin
  fReportSQLObj := TReportSQLProfitAndLossPeriodCompare.Create(Self);
  ReportSQLobj.employeeID := Appenv.Employee.EmployeeID;
  Tablename := ReportSQLObj.Temptablename ;
  inherited;
  SearchMode:= smFullList;
  reportCaption :='Profit and Loss by Preiod Compare';

end;

procedure TProfitandLossReportByPeriodCompareGUI.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
end;



procedure TProfitandLossReportByPeriodCompareGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  grdmain.hint := '            ''Diff to the Previous Period'' = ''Curent Period Amount'' - ''Previous Period Amount'' ' +NL+
                '''Percentage to the Previous Period'' =  ''Diff to the Previous Period'' / ''Curent Period Amount'' *100' + NL ;

  try
    if LstColumn.count > 1 then begin
      grdmain.hint := grdmain.hint + NL+'eg: '+NL+
                          '  For Period ' + quotedstr(pColumnRec(LstColumn.Items[1])^.ColumnName) +' Diff to  ' + quotedstr(pColumnRec(LstColumn.Items[0])^.ColumnName) +' =  ' + quotedstr(pColumnRec(LstColumn.Items[1])^.ColumnName) +' -  ' + quotedstr(pColumnRec(LstColumn.Items[0])^.ColumnName) +' and ' + NL+
                          '                       ''Percentage to   ' + quotedstr(pColumnRec(LstColumn.Items[0])^.ColumnName) +' =  ' + quotedstr(pColumnRec(LstColumn.Items[1])^.ColumnName) +' -  ' + quotedstr(pColumnRec(LstColumn.Items[0])^.ColumnName) +'  / ' + quotedstr(pColumnRec(LstColumn.Items[1])^.ColumnName) +' *100' + NL ;
    end;
  Except
  end;
end;

procedure TProfitandLossReportByPeriodCompareGUI.RefreshAll;
begin
  Try
    inherited;
  Except
    on E:Exception do begin
      MessageDlgXP_vista(E.Message, mtWarning, [mbOK], 0);
    end;
  End;

end;

initialization
  RegisterClassOnce(TProfitandLossReportByPeriodCompareGUI);

end.

