unit ExceptionEmailsListGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, MemDS, DBAccess, MyAccess, ActnList, Menus,
  StdCtrls, Buttons, wwdblook, wwdbdatetimepicker, DNMPanel, Grids,
  Wwdbigrd, Wwdbgrid, ExtCtrls, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, DNMSpeedButton, Shader;

type
  TExceptionEmailsList = class(TBaseListingGUI)
    actFlagDone: TAction;
    N3: TMenuItem;
    Done1: TMenuItem;
    BitBtn1: TDNMSpeedButton;
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure actFlagDoneExecute(Sender: TObject);
    procedure actFlagDoneUpdate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

var
  ExceptionEmailsList: TExceptionEmailsList;

implementation
  Uses ExceptionEmailsLib;
{$R *.dfm}

procedure TExceptionEmailsList.FormDestroy(Sender: TObject);
begin
  inherited;
  ExceptionEmailsList := nil;
end;

procedure TExceptionEmailsList.BitBtn1Click(Sender: TObject);
begin
  inherited;
  ExceptionEmailsLib.ImportExceptionEmails;
end;

procedure TExceptionEmailsList.actFlagDoneExecute(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  If grdMain.SelectedList.Count=0 then Exit;
  for i:= 0 to grdMain.SelectedList.Count-1 do begin
      If Not qryListData.BookmarkValid(grdMain.SelectedList.items[i]) then Continue;
      qryListData.GotoBookmark(grdMain.SelectedList.items[i]);
      qryListData.Edit;
      qryListData.FieldByName('Done').asString := 'True';
      qryListData.Post;
  end;
  grdMain.UnselectAll;
  RefreshQuery;
end;

procedure TExceptionEmailsList.actFlagDoneUpdate(Sender: TObject);
begin
  inherited;
  actFlagDone.Enabled := (grdMain.SelectedList.Count<>0);
end;

procedure TExceptionEmailsList.RefreshQuery;
begin
  Case rgOptions.ItemIndex of
    0: qryListData.Params.ParamByName('xDone').AsString := 'False';
    1: qryListData.Params.ParamByName('xDone').AsString := '%';
  else
    qryListData.Params.ParamByName('xDone').AsString := '%';
  end;
  inherited;
end;

procedure TExceptionEmailsList.cmdPrintClick(Sender: TObject);
begin
  ReportName:='Exception Email List';
  Preview:=True;
  Dataset:=qryListData;
  inherited;
end;

end.
