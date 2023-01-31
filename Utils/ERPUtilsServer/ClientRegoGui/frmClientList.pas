unit frmClientList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseList, DB, MemDS, DBAccess, MyAccess, Grids, Wwdbigrd,
  Wwdbgrid, ExtCtrls, StdCtrls, Buttons;

type
  TfmClientList = class(TfmBaseList)
    rgClient: TRadioGroup;
    rgActive: TRadioGroup;
    btnClientDelete: TwwIButton;
    qryMainid: TIntegerField;
    qryMainactive: TStringField;
    qryMainname: TStringField;
    qryMaindatetime: TDateTimeField;
    qryMainuser: TStringField;
    qryMainsoftwarereleasetype: TStringField;
    qryMainservers: TStringField;
    qryServers: TMyQuery;
    cboLicence: TComboBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure gdMainTitleButtonClick(Sender: TObject; AFieldName: String);
    procedure rgClientClick(Sender: TObject);
    procedure rgActiveClick(Sender: TObject);
    procedure gdMainDblClick(Sender: TObject);
    procedure btnClientDeleteClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure cboLicenceChange(Sender: TObject);
  private
    CleanSQL: string;
  protected
    procedure LoadConfig; override;
    procedure SaveConfig; override;
  public
    procedure RefreshData; override;
  end;

var
  fmClientList: TfmClientList;

implementation

{$R *.dfm}

uses
  AppConfigObj, frmBaseEdit, ComponentLib;

procedure TfmClientList.cboLicenceChange(Sender: TObject);
begin
  inherited;
  RefreshData;
end;

procedure TfmClientList.FormCreate(Sender: TObject);
begin
  CleanSQL:= qryMain.SQL.Text;
  inherited;
  AutoReopen:= true;
  RefreshData;
end;

procedure TfmClientList.gdMainTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  inherited;
  //
end;

procedure TfmClientList.rgClientClick(Sender: TObject);
begin
  inherited;
  RefreshData;
end;

procedure TfmClientList.rgActiveClick(Sender: TObject);
begin
  inherited;
  RefreshData;
end;

procedure TfmClientList.LoadConfig;
begin
  inherited;
  Inc(LoadingConfig);
  try
    if AppConfig.Data.O[ClassName].I['rgClient_ItemIndex'] > -1 then
      rgClient.ItemIndex:= AppConfig.Data.O[ClassName].I['rgClient_ItemIndex'];
    if AppConfig.Data.O[ClassName].I['rgActive_ItemIndex'] > -1 then
      rgClient.ItemIndex:= AppConfig.Data.O[ClassName].I['rgActive_ItemIndex'];
  finally
    Dec(LoadingConfig);
  end;  
end;

procedure TfmClientList.SaveConfig;
begin
  inherited;
  AppConfig.Data.O[ClassName].I['rgClient_ItemIndex']:= rgClient.ItemIndex;
  AppConfig.Data.O[ClassName].I['rgActive_ItemIndex']:= rgActive.ItemIndex;
end;

procedure TfmClientList.gdMainDblClick(Sender: TObject);
var
  EditForm: TfmBaseEdit;
begin
  inherited;
//  EditForm:= TfmBaseEdit(CreateComponentInst('TfmNewClientEdit'));
  EditForm:= TfmBaseEdit(CreateComponentInst('TfmClientEdit'));
  if Assigned(EditForm) then begin
    EditForm.KeyID:= qryMain.FieldByName('id').AsInteger;
  end;
end;

procedure TfmClientList.RefreshData;
var
  s: string;
begin
  if LoadingConfig > 0 then
    exit;
  if rgClient.ItemIndex = 1 then begin
    if s <> '' then s:= s + ' and ';
    s:= s  + '(name like "UNKNOWN%")';
  end;
  case rgActive.ItemIndex of
    0: begin
         if s <> '' then s:= s + ' and ';
         s:= s  + '(tclientconfig.active = "T")';
       end;
    1: begin
         if s <> '' then s:= s + ' and ';
         s:= s  + '(tclientconfig.active = "F")';
       end;
    2: begin
       end;
  end;
  qryMain.Close;
  qryMain.ParamByName('LicenceStatus').AsString := 'ls' + cboLicence.Text;

  if s <> '' then
//    qryMain.SQL.Text:= CleanSQL + ' where ' + s
    qryMain.SQL.Text:= CleanSQL + ' and ' + s
  else
    qryMain.SQL.Text:= CleanSQL;
  qryMain.Open;
end;

procedure TfmClientList.btnClientDeleteClick(Sender: TObject);
var
  clientId: integer;
  qryComputer: TMyQuery;
  cmd: TMyCommand;
begin
  inherited;
  if qryMain.Active and (not qryMain.IsEmpty) then begin
    if MessageDlg('This will permently delete the Client (' +
      qryMain.FieldByName('name').AsString  +
      '), its Server, Config records and all of its Licence records from the database, ' +
      'is that what you want to do?',mtWarning, [mbNo,mbYes],0) = mrYes then begin
      clientId:= qryMain.FieldByName('id').AsInteger;
      qryComputer:= TMyQuery.Create(nil);
      cmd:= TMyCommand.Create(nil);
      try
        qryComputer.Connection:= qryMain.Connection;
        cmd.Connection:= qryMain.Connection;
        qryComputer.SQL.Text:= 'select * from tcomputer where clientid = ' + IntToStr(clientId);
        qryComputer.Open;
        while not qryComputer.Eof do begin
          cmd.SQL.Text:= 'delete from tcomputerconfig where computerid = ' + qryComputer.FieldByName('id').AsString;
          cmd.Execute;
          cmd.SQL.Text:= 'delete from tsoftwarelicence where computerid = ' + qryComputer.FieldByName('id').AsString;
          cmd.Execute;
          qryComputer.Delete;
        end;
      finally
        qryComputer.Free;
        cmd.Free;
      end;
      qryMain.Delete;
    end;
  end;
end;

procedure TfmClientList.qryMainCalcFields(DataSet: TDataSet);
var
  s: string;
begin
  inherited;
  qryServers.Close;
  qryServers.ParamByName('clientid').AsInteger:= qryMainid.AsInteger;
  qryServers.Open;
  s:= '';
  while not qryServers.Eof do begin
    if s <> '' then s:= s + ',';
    s:= s + qryServers.FieldByName('computername').AsString;
    qryServers.Next;
  end;
  qryMainservers.AsString:= s;
end;


initialization
  RegisterClass(TfmClientList);

end.
