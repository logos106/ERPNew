unit Analyicreports;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, StdCtrls,BaseListingForm, DAScript, MyScript,
  ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, MemDS, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook,
  DNMSpeedButton, Shader;

type
  TfmAnalyicreports = class(TBaseListingGUI)
    qryMainformID: TIntegerField;
    qryMainformname: TWideStringField;
    qryMaindescription: TWideStringField;
    qryMainAccess: TLargeintField;
    qryMainchartname: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainSkinsGroup: TWideStringField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    procedure SelectChart;
    procedure ViewAnalyticReport;
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;override;
  end;

implementation

uses CommonLib, CommonDbLib, AppEnvironment, frmPopupSelect, tcConst,
  AnalyticReport;

{$R *.dfm}
{ TfmAnalyicreports }

procedure TfmAnalyicreports.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  ViewAnalyticReport;
end;

procedure TfmAnalyicreports.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if QrymainAccess.AsInteger <> 1 then Afont.Color :=clInactiveCaption;
end;

procedure TfmAnalyicreports.grdMainDblClick(Sender: TObject);
begin
  if SameText(ActiveFieldName , Qrymainchartname.FieldName) then begin
    SelectChart;
  end else begin
    ViewAnalyticReport;
  end;
end;
procedure TfmAnalyicreports.ViewAnalyticReport;
begin
  if trim(Qrymainformname.AsString) = '' then begin
    MessageDlgXP_Vista('Invalid List name for ' +Quotedstr(Qrymaindescription.AsString)+'. Please contact ERP', mtWarning, [mbOK], 0);
    exit;
  end;
  if trim(Qrymainchartname.AsString)='' then begin
    //MessageDlgXP_Vista('Please select the chart to view for ' +Quotedstr(Qrymaindescription.AsString), mtWarning, [mbOK], 0);
    TimerMsg(lblNote , 'Please select the chart to view for ' +Quotedstr(Qrymaindescription.AsString));
    SelectChart;
    exit;
  end;
  TAnalyticReportGUI.ViewAnalyticreport(Qrymainformname.AsString,Qrymainchartname.AsString);
end;
procedure TfmAnalyicreports.SelectChart;
var
  Qry :TERPQuery;
  DefaultChart:String;
  bm:TBookmark;
begin
  Qry :=  tempMyQuery;
  Qry.SQL.Text := 'select ID , chartname from tblcustomcharts where reportclassname = ' +quotedstr(Qrymainformname.AsString);
  Qry.Open;
  DefaultChart := SelectRecord('Default Chart' , 'Select the Default chart for ' +NL+Quotedstr(Qrymaindescription.AsString) , Qry ,  qryMainchartname.AsString , 'chartname' , 'ID'  );
  if DefaultChart = '' then exit;
  if sameText(Qrymainchartname.AsString , DefaultChart) then exit;
  try
    ExecuteSQL('insert into tblCustomChartAnalytic '+
                ' Set CustomchartID = ' + DefaultChart +' ,  '+
                ' reportclassname = ' +quotedstr(Qrymainformname.AsString) +
                ' on duplicate key update  CustomchartID = ' + DefaultChart +';');
    bm:= Qrymain.GetBookmark;
    try
      RefreshQuery;
    finally
      Qrymain.GotoBookmark(bm);
      Qrymain.FreeBookmark(bm);
    end;
  Except
    // kill the exception if the record is locaked by someone
  end;
end;

procedure TfmAnalyicreports.RefreshQuery;
begin
(*var
  cls:TPersistentClass;
  st:TStringlist;
  s:String;
begin
  st:= TStringlist.Create;
  try
    st.Add('drop table if exists ' +tablename +';');
    st.Add('create table ' + tablename +
                '  ( `FormID` int(11) NOT NULL AUTO_INCREMENT, '+
                '   `FormName` varchar(50) DEFAULT NULL, '+
                '   `Description` varchar(50) DEFAULT NULL, '+
                '   `Access` int(1) DEFAULT 6, '+
                '   PRIMARY KEY (`FormID`) '+
                ' ) ENGINE=MyIsam  DEFAULT CHARSET=utf8;');

    With TempMyQuery do try
      SQL.Add('Select F.formname , F.description  , if(accesslevels="F" , 1 ,  ifnull(EFA.Access , 6)) Access '+
                ' from tblforms  F '+
                ' left join tblemployeeformsaccess  EFA on F.FormID = EFA.FormID and EFA.EmployeeID =  '+ inttostr(Appenv.employee.employeeID) +
                ' where Isform ="T" order by description');
      open;
      if recordcount > 0 then begin
        first;
        while Eof = False do begin
          try
            cls:= FindClass(Fieldbyname('formname').AsString);
            if Assigned(cls) then begin
              if IsClassParent(cls ,TComponentclass(Self)) then else
              if IsClassParent(cls ,TBaseListingGUI) then begin
                s:= 'insert into ' +tablename +' (Formname , Description , Access) '+
                        'Values (' +
                        Quotedstr(fieldbyname('formname').AsString) +',' +
                        Quotedstr(fieldbyname('Description').AsString)+ ',' +
                        inttostr(fieldbyname('Access').asInteger) +' );';
                St.Add(s);
              end;
            end;
          Except
            // kill the exception
          end;
          next;
        end;
      end;
    finally
      closenFree;
    end;
  finally
    ExecuteSQL(st.text);
    FreeandNil(St);
  end;*)
  Qrymain.ParamByName('EmployeeID').AsInteger :=  Appenv.employee.employeeID;
  inherited;
end;

procedure TfmAnalyicreports.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(qryMainformID.FieldName);
    RemoveFieldfromGrid(qryMainformname.FieldName);
    RemoveFieldfromGrid(qryMainAccess.FieldName);
end;

initialization
  RegisterClassOnce(TfmAnalyicreports);

end.

