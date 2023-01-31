unit ReportSQLValidate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel;

type
  TReportSQLValidateGUI = class(TBaseListingGUI)
    Memo1: TMemo;
    Horizontal1: TSplitter;
    QryReport: TERPQuery;
    QryReportTemplID: TIntegerField;
    QryReportTemplName: TWideStringField;
    QryReportSQLString: TWideMemoField;
    qryMainDataname: TWideStringField;
    qryMainSQLString: TWideMemoField;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure cmdExportClick(Sender: TObject);
    procedure QryReportAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure QryReportBeforeOpen(DataSet: TDataSet);
    procedure doAnlyse(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    fiReportTemplateID: Integer;
    procedure SetReportSQL(const Value: String);
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex: Integer);Override;
    { Private declarations }
  public
    Property ReportTemplateID:Integer read fiReportTemplateID write fiReportTemplateID;
    Property ReportSQL:String write SetReportSQL;
  end;

implementation

uses Clipbrd, CommonLib, DNMLib, DbSharedObjectsObj, tcConst, LogLib;

{$R *.dfm}

{ TBaseListingGUI1 }

procedure TReportSQLValidateGUI.cmdExportClick(Sender: TObject);
begin
  //inherited;
  clog('');
  IterateProcNo:= 1;
  DoShowProgressbar(Qrymain.RecordCount , waitmsg);
  try
    IterateRecords;
  finally
    DoHideProgressbar;
  end;

end;
procedure TReportSQLValidateGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer);
var
  Qry:TERPQuery;
begin
  if iterateProcno = 1   then begin
    DoStepProgressbar(Qrymaindataname.AsString);
    Qry := dbSharedObj.getQuery(qrymain.connection);
    try
      grdMainDblClick(grdMain);  //Qrymanipulation to manipulate the Qry
      Qry.SQL.text := Memo1.Lines.text;//QrymainSQLString.asString;
      try

        LogText(NL+'~|||~{' +Qrymaindataname.asString+'}'+ Qry.SQL.text);
        Qry.open;
      Except
        on E:Exception do begin
          Memo1.lines.clear;
          Memo1.lines.Text :=QrymainSQLString.asString;
          Clipboard.asText := QrymainSQLString.asString;
          MessageDlgXP_Vista(qryMainDataname.asString +': ' +  e.message, mtWarning, [mbOK], 0);
          Abort := True;
        end;
      end;
    finally
      dbSharedObj.ReleaseObj(Qry);
    end;
  end;
end;
procedure TReportSQLValidateGUI.QryReportAfterOpen(DataSet: TDataSet);
begin
  inherited;
   ReportSQL := QryReportSQLString.AsString
end;

procedure TReportSQLValidateGUI.QryReportBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QryReport.ParamByName('TemplID').AsInteger := fiReportTemplateID;
end;

procedure TReportSQLValidateGUI.cmdNewClick(Sender: TObject);
begin
//  inherited;
end;

procedure TReportSQLValidateGUI.doAnlyse(Sender: TObject);
begin
  inherited;
  ReportSQL := MEmo1.lines.text;

end;

procedure TReportSQLValidateGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ReportTemplateID := 0;
end;

procedure TReportSQLValidateGUI.FormShow(Sender: TObject);
begin
  inherited;
  opendb(QryReport);
end;

procedure TReportSQLValidateGUI.grdMainDblClick(Sender: TObject);
begin
  //inherited;
  QueryManipulationObj.RefreshOrignalSQL(qryMainSQLString.AsString , False);
  Memo1.Lines.Text := QueryManipulationObj.OriginalSQL;
  QueryManipulationObj.RefreshOrignalSQL(Qrymain.SQL.Text, False);
end;
procedure TReportSQLValidateGUI.SetReportSQL(const Value: String);
var
  st:TStringlist;
  ctr:Integer;
  s:String;
begin
  Memo1.Lines.Clear;
  Memo1.Lines.Text := Value;
  st:= TStringlist.Create;
  try
    SplitString(Value, '~|||~' , St);
    closedb(Qrymain);
    Qrymain.SQL.Clear;
    for ctr := 0 to st.Count-1 do begin
      if st[ctr]<> '' then begin
        s:= '';
        st[ctr] := trim(st[ctr]);
        if copy(st[ctr],1,1)='{' then begin
           s:=copy(st[ctr],1,pos('}' , st[ctr]));
           st[ctr] := ReplaceStr(st[ctr] , s, '');
           s:= ReplaceStr(s, '{',''); s:= ReplaceStr(s, '}','');
        end;
        if Qrymain.SQL.count <> 0 then Qrymain.SQL.Add('union all ');
        Qrymain.SQL.Add('Select '+ quotedstr(s) +' as Dataname, ' +Quotedstr(st[ctr] )+' as  SQLString');
        RefreshOrignalSQL(False);
      end;
    end;
      opendb(Qrymain);

  finally
    Freeandnil(st);
  end;


end;

initialization
  RegisterClassOnce(TReportSQLValidateGUI);

end.
