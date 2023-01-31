unit frmBusObjFilterList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox;

type
  TfmBusObjFilterList = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainBusObjFilterID: TIntegerField;
    qryMainFilterName: TWideStringField;
    qryMainSQLString: TWideMemoField;
    qryMainDescription: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainBusObjName: TWideStringField;
    procedure cmdPrintClick(Sender: TObject);
    procedure btnGridClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmBusObjFilterList: TfmBusObjFilterList;

implementation

uses
  CommonLib, CommonDbLib;

{$R *.dfm}

procedure TfmBusObjFilterList.cmdPrintClick(Sender: TObject);
var
  qry: TERPQuery;
  sl: TStringList;
  lastFilterName, LastClassName: string;
begin
  DisableForm;
  try
  //  inherited;
    qry:= CommonDbLib.TempMyQuery;
    sl:= TStringList.Create;
    try
      qry.SQL.Add('select f.ClassName, f.FilterName, f.Description,');
      qry.SQL.Add('fp.ParamName, fp.Description as ParamDescription');
      qry.SQL.Add('from tblBusObjFilter f');
      qry.SQL.Add('left join tblBusObjFilterParam fp on fp.BusObjFilterId = f.BusObjFilterId');
      qry.SQL.Add('order by f.ClassName, f.FilterName');
      qry.Open;
      while not qry.Eof do begin
        if lastClassName <> qry.FieldByName('ClassName').AsString then begin
          lastClassName:= qry.FieldByName('ClassName').AsString;
          sl.Add(qry.FieldByName('ClassName').AsString);
        end;
        if lastFilterName <> qry.FieldByName('FilterName').AsString then begin
          lastFilterName:= qry.FieldByName('FilterName').AsString;
          sl.Add(qry.FieldByName('FilterName').AsString + #09 +
            qry.FieldByName('Description').AsString);
        end;
        if not qry.fieldByName('ParamName').IsNull then
          sl.Add(#09 + qry.fieldByName('ParamName').AsString + #09 +
            qry.fieldByName('ParamDescription').AsString)
        else
          sl.Add(#09 + '(no parameters)');
        qry.Next;
      end;
    finally
      qry.Free;
      sl.Free;
    end;
  finally
    EnableForm;
  end;   
end;

procedure TfmBusObjFilterList.btnGridClick(Sender: TObject);
var
  cmd: TERPCommand;
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this filter and all of its Parameters?',mtconfirmation,[mbYes,mbNo],0) = mrYes then begin
    cmd:= TERPCommand.Create(nil);
    try
      cmd.Connection:= CommonDbLib.GetSharedMyDacConnection;
      cmd.SQL.Text:= 'delete from tblBusObjFilterParam where BusObjFilterId = ' +
        qryMainBusObjFilterID.AsString;
      cmd.Execute;
      qryMain.Delete;
    finally
      cmd.Free;
    end;
  end;

end;

procedure TfmBusObjFilterList.grdMainDblClick(Sender: TObject);
begin
  if (grdMain.GetActiveField <> nil) and (grdMain.GetActiveField.FieldName <> 'SQLString') then
  inherited;

end;

initialization
  RegisterClassOnce(TfmBusObjFilterList);

end.
