unit frmQueryAnalyserdetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  Shader, Grids, Wwdbigrd, Wwdbgrid, DAScript, MyScript, Buttons;

type

  TfmQueryAnalyserdetails = class(TBaseInputGUI)
    FooterPanel: TPanel;
    Panel1: TPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Panel2: TPanel;
    OpenDialog1: TOpenDialog;
    QryMain: TERPQuery;
    dsMain: TDataSource;
    ERPScript: TERPScript;
    btnClose: TDNMSpeedButton;
    grdMain: TwwDBGrid;
    btnGrid: TwwIButton;
    wwMemoDialog1: TwwMemoDialog;
    QryMainAUTOID: TIntegerfield;
    QryMainID: TIntegerfield;
    QryMainSelect_Type: TWideStringField;
    QryMainTablename: TWideStringField;
    QryMainQryType: TWideStringField;
    QryMainPossible_Keys: TWideStringField;
    QryMainQryKeys: TWideStringField;
    QryMainKey_Len: TIntegerField;
    QryMainQrySQL: TWideMemoField;
    QryMainref: TWideStringField;
    QryMainQryRows: TIntegerField;
    QryMainextra: TWideStringField;
    mmoSQL: TMemo;
    procedure mmoSQLKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure ERPScriptAfterExecute(Sender: TObject; fsSQL: string);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure formShow(Sender: TObject);

  private
    fsSQL: String;
    tablename :String;
    procedure SetSQL(const Value: String);
  public
    Property SQL:String read fsSQL write SetSQL;
  end;


implementation

uses CommonLib, strutils, types, CommonDbLib, tcConst,  AppVarsObj;

{$R *.dfm}

procedure TfmQueryAnalyserdetails.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmQueryAnalyserdetails.ERPScriptAfterExecute(Sender: TObject;fsSQL: string);
var
  id:Integer;
begin
  inherited;
  StepProgressbar;
  Qrymain.Last;
  ID:= Qrymainid.AsInteger;
  try
    with TempMyQuery do try
      SQL.Add('Explain ' + fsSQL);
      open;
      if recordcount> 0 then begin
        first;
        while eof = False do begin
          Qrymain.Append;
          Qrymainid.AsInteger := id+1;
          QryMainSelect_Type.asString:= fieldbyname('Select_type').AsString;
          QryMainTablename.asString:= fieldbyname('table').AsString;
          QryMainQryType.asString:= fieldbyname('type').AsString;
          QryMainPossible_Keys.asString:= fieldbyname('Possible_keys').AsString;
          QryMainQryKeys.asString:= fieldbyname('Key').AsString;
          QryMainref.asString:= fieldbyname('ref').AsString;
          QryMainextra.asString:= fieldbyname('Extra').AsString;
          QrymainQrySQL.AsString := fsSQL;
          if fieldbyname('Key_Len').value <> null then
            try
              QryMainKey_Len.asInteger:= fieldbyname('Key_Len').asInteger;
            except end;
          if fieldbyname('Rows').Value <> null then
            try
              QryMainQryRows.asInteger:= fieldbyname('Rows').asInteger;
            except end;
          PostDB(Qrymain);
          Next;
        end;
      end;
    finally
      if active then close;
      Free;
    end;
  Except
    //ignore the exception if qry cannot be EXPLAINED. eg: use database
  end;
end;

procedure TfmQueryAnalyserdetails.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmQueryAnalyserdetails.FormCreate(Sender: TObject);
begin
  inherited;
    TableName := CommonDbLib.GetUserTemporaryTableName('SQLanalyserDetails');
    With tempMyScript do try
      SQL.Add('Drop table if exists '+tablename +';' +
            ' CREATE TABLE `'+tablename +'` (' +
            ' 	 AUTOID int(11) NOT NULL AUTO_INCREMENT,' +
            ' 	  ID INT(11),' +
            ' 	  Select_Type varchar(50),' +
            ' 	  Tablename varchar(100),' +
            ' 	  QryType varchar(100),' +
            ' 	  Possible_Keys varchar(255),' +
            ' 	`QrySQL` TEXT NULL DEFAULT NULL,' +
            ' 	  QryKeys varchar(255),' +
            ' 	Key_Len int(11),' +
            ' 	ref varchar(255),' +
            ' 	QryRows int(11),' +
            ' 	extra varchar(255),' +
            ' 	  PRIMARY KEY (`AutoID`)' +
            ' 	)' );
      execute;
    finally
      free;
    end;
  Qrymain.SQL.Text := 'Select * from '+tablename ;
end;

procedure TfmQueryAnalyserdetails.mmoSQLKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i:Integer;
  s:String;
begin
  inherited;
  if (Shift = [ssCtrl]) then begin
    if chr(Key)='A' then begin
      mmoSQL.SelectAll;
    end else if CharInSet(chr(Key),['1','2','3','4','5','6','7','8','9']) then begin
      i:= strToint(chr(Key));
      s:= SubStr(mmoSQL.Lines.Text , ';' , i);
      if s<> '' then begin
        mmoSQL.SelStart := pos(s , mmoSQL.lines.Text);
        mmoSQL.SelLength := length(s);
      end;
    end;
  end;
end;

procedure TfmQueryAnalyserdetails.SetSQL(const Value: String);
begin
  fsSQL := Value;
end;
procedure TfmQueryAnalyserdetails.formShow(Sender:TObject);
begin
  inherited;
  openQueries;
  mmoSQL.Lines.Clear;
  mmoSQL.Lines.Text := Sql;
  showProgressbar(WAITMSG,10);
  try
    with ERPScript do begin
      SQL.Add(self.Sql);
      execute;
    end;
  finally
    hideProgressbar;
  end;
end;

initialization
  RegisterClass(TfmQueryAnalyserdetails);

end.

