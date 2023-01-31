unit CustomFilterGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, StdCtrls, Buttons,
  ExtCtrls, DNMPanel, DBCtrls, Mask, wwdbedit, wwcheckbox, DNMSpeedButton,
  Shader;

type
  TCustomFilter = class(TBaseInputGUI)
    qryMasterCustomFilterID: TLargeintField;
    qryMasterUserID: TIntegerField;
    qryMasterFilterName: TStringField;
    qryMasterClassName: TStringField;
    Label1: TLabel;
    Label2: TLabel;
    FilterName: TwwDBEdit;
    Filter: TDBMemo;
    qryMasterFilter: TMemoField;
    qryMasterListName: TStringField;
    wwCheckBox2: TwwCheckBox;
    Label29: TLabel;
    qryMasterDefaultFilter: TStringField;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SaveClick(Sender: TObject);
  private
    { Private declarations }
    fUserID: Integer;
    fFilter: String;
    fClassName: String;
    fListName: String;
    procedure SetDefaultFilter;  
  public
    { Public declarations }
    class function Instance: TBaseInputGUI; override;
    property ListUserID: Integer read fUserID write fUserID;
    property ListFilter: String read fFilter write fFilter;
    property ListClassName: String read fClassName write fClassName;
    property ListName: String read fListName write fListName;
  end;

implementation
  Uses FuncLib, FormFactory, UserInfoObj, FastFuncs;
{$R *.dfm}

var
  CustomFilter: TCustomFilter;

procedure TCustomFilter.FormDestroy(Sender: TObject);
begin
  inherited;
  CustomFilter := Nil;
end;

procedure TCustomFilter.FormShow(Sender: TObject);
begin
  qryMaster.Params.ParseSQL(qryMaster.SQL.Text, True);
  qryMaster.Params.ParamByName('xID').asInteger := KeyID;
  inherited;
  If KeyID=0 then Begin
    qryMasterUserID.AsInteger := fUserID;
    qryMasterClassName.asString := fClassName;
    qryMasterFilter.asString := fFilter;
    qryMasterListName.asString := fListName;
  end;
end;

class function TCustomFilter.Instance: TBaseInputGUI;
begin
  if CustomFilter = nil then begin
    CustomFilter := TCustomFilter.Create(Application);
  end;
  result := CustomFilter;
end;

procedure TCustomFilter.SaveClick(Sender: TObject);
begin
  If Empty(FilterName.Text) then Begin
    MessageDlg('Filter Name Required !', mtWarning, [mbOK], 0);
    Windows.SetFocus(FilterName.Handle);
    Exit;
  end;
  If qryMasterDefaultFilter.AsString = 'True' Then begin
    If qryMaster.State in [dsEdit, dsInsert] then qryMaster.Post;
    SetDefaultFilter;
  end;  
  inherited;

end;

procedure TCustomFilter.SetDefaultFilter;
var
  TempQry: TMyCommand;
Begin
  TempQry := TMyCommand.Create(nil);
  try
    TempQry.Connection := DBConnection;
    TempQry.SQL.Clear;
    TempQry.SQL.Add('UPDATE customfilters SET DefaultFilter= "False" ');
    TempQry.SQL.Add('WHERE ClassName = '+QuotedStr(qryMasterClassName.AsString)+' ');
    TempQry.SQL.Add('AND UserID='+FastFuncs.IntToStr(UserInfo.UserID)+' ');
    TempQry.SQL.Add('AND CustomFilterID<>'+FastFuncs.IntToStr(qryMasterCustomFilterID.AsInteger)+';');
    TempQry.Execute;
  finally
    TempQry.Free;
  end;
end;

Initialization
  with FormFact do begin
    RegisterMe(TCustomFilter, 'TUsersFilterList_*=CustomFilterID');
  end;
end.
