unit frmBaseList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Grids, Wwdbigrd, Wwdbgrid, ExtCtrls, DB, MemDS,
  DBAccess, MyAccess, StdCtrls;

type
  TfmBaseList = class(TfmBase)
    pnlTop: TPanel;
    gdMain: TwwDBGrid;
    qryMain: TMyQuery;
    dsMain: TDataSource;
    MyConnection1: TMyConnection;
    btnRefresh: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gdMainTitleButtonClick(Sender: TObject; AFieldName: String);
    procedure btnRefreshClick(Sender: TObject);
  private
  protected
    procedure LoadConfig; override;
    procedure SaveConfig; override;
  public
  end;

var
  fmBaseList: TfmBaseList;

implementation

uses
  AppDatabaseObj, AppConfigObj, GridFieldsObj;

{$R *.dfm}

procedure TfmBaseList.FormCreate(Sender: TObject);
var
  x: integer;
begin
  inherited;
  qryMain.Close;
  MyConnection1.Disconnect;
  for x := 0 to self.ComponentCount -1 do begin
    if Components[x] is TMyQuery then
      TMyQuery(Components[x]).Connection := AppDatabase.Connection;
  end;
end;

procedure TfmBaseList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

procedure TfmBaseList.gdMainTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  inherited;
  if qryMain.Active then begin
    if Pos(aFieldName,qryMain.IndexFieldNames) > 0 then begin
      {already sorting on this field}
      if Pos('ASC',qryMain.IndexFieldNames) > 0 then
        qryMain.IndexFieldNames:= AFieldName + ' DESC'
      else
        qryMain.IndexFieldNames:= AFieldName + ' ASC';
    end
    else begin
      qryMain.IndexFieldNames:= AFieldName + ' ASC';;
    end;
  end;
end;

procedure TfmBaseList.LoadConfig;
begin
  inherited;
  if AppConfig.Data.O[ClassName].S['selected'] <> '' then
    gdMain.Selected.Text:= AppConfig.Data.O[ClassName].S['selected'];
end;

procedure TfmBaseList.SaveConfig;
begin
  inherited;
  AppConfig.Data.O[ClassName].S['selected']:= GetGridSelectedText(gdMain);
end;

procedure TfmBaseList.btnRefreshClick(Sender: TObject);
begin
  inherited;
  RefreshData;
end;

end.
