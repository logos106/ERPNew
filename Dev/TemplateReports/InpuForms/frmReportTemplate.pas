unit frmReportTemplate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ReportTemplateForm, DB, ProgressDialog, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, StdCtrls, wwcheckbox, wwdblook,
  Mask, DBCtrls, DNMSpeedButton, Shader, DNMPanel;

type
  TfmReportTemplate = class(TReportTemplateGUI)
    procedure FormCreate(Sender: TObject);
    procedure qryTemplatesBeforeOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
  private
    fsTempTypeforNew: String;
    fbOpenDesignonshow: boolean;
    function NewTemplateNameForType: String;
  public
    Property TempTypeforNew :String read fsTempTypeforNew write fsTempTypeforNew;
    Property OpenDesignonshow:boolean read fbOpenDesignonshow write fbOpenDesignonshow;
  end;


implementation

uses CommonLib, ReportTemplateBase, LogLib, DbSharedObjectsObj, CommonDbLib,
  tcDataUtils;

{$R *.dfm}

procedure TfmReportTemplate.FormCreate(Sender: TObject);
begin
  inherited;
  TempTypeforNew  := '';
  OpenDesignonshow := False;
end;

procedure TfmReportTemplate.FormShow(Sender: TObject);
begin
  inherited;
  if KeyId <> 0 then begin
     if qryTemplates.Locate('TemplID' , KeyId , []) then begin
      Setcontrolfocus(edName);
      if OpenDesignonshow then grdTemplatesDblClick(grdTemplates);
     end;
  end;
end;

Function TfmReportTemplate.NewTemplateNameForType:String;
var
  qry: TERPQuery;
  ctr:Integer;
begin
  Result := TempTypeforNew +'-';
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(qryTemplates.connection);
  try
    ctr:=0;
    repeat
      closedb(qry);
      ctr:= ctr+1;
      Result := TempTypeforNew +'-' +trim(inttostr(ctr));
      qry.sql.text := 'Select TemplID from tbltemplates where  TemplName= ' +Quotedstr(result);
      opendb(qry);
    Until qry.fieldbyname('TemplID').asInteger =0;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TfmReportTemplate.qryTemplatesBeforeOpen(DataSet: TDataSet);
var
  qry: TERPQuery;
  s:String;
begin
  if TempTypeforNew <> '' then begin
    s:=TReportTemplateBase.GetReportSQL(TempTypeforNew);
    if s<> '' then begin
      qry := DbSharedObjectsObj.DbSharedObj.GetQuery(qryTemplates.connection);
      try
        qry.SQL.Text :=' Select * from tbltemplates where TemplID =0';
        qry.open;
        qry.Append;
        qry.fieldbyname('TypeID').AsInteger := TemplateTypeID( TempTypeforNew);
        qry.fieldbyname('SQLString').asString := s;
        qry.fieldbyname('TemplName').AsString :=NewTemplateNameForType;
        qry.Post;
        KeyId := qry.fieldbyname('TemplID').AsInteger ;
      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
      end;
    end;
    TempTypeforNew := '';
  end;
  inherited;
end;

initialization
  RegisterClassOnce(TfmReportTemplate);

end.
