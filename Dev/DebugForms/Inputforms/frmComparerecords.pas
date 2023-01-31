unit frmComparerecords;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb, Shader,
  ExtCtrls, DNMPanel, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, Grids, Wwdbigrd, Wwdbgrid, wwdblook;

type
  TfmComparerecords = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label1: TLabel;
    edtID1: TEdit;
    edtID2: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Qry1: TERPQuery;
    Qry2: TERPQuery;
    ERPQuery1: TERPQuery;
    DataSource1: TDataSource;
    wwDBGrid1: TwwDBGrid;
    ERPQuery2: TERPQuery;
    cbotablename1: TwwDBLookupCombo;
    ERPQuery2Tables_in_sample_company_1: TWideStringField;
    ERPQuery1id: TIntegerField;
    ERPQuery1fIELDnAME: TWideStringField;
    ERPQuery1Value1: TWideStringField;
    ERPQuery1Value2: TWideStringField;
    cbotablename2: TwwDBLookupCombo;
    Button2: TButton;
    QryComp1: TERPQuery;
    QryComp2: TERPQuery;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    tablename:String;
  public
    { Public declarations }
  end;

implementation

uses CommonDbLib, MySQLUtils, CommonLib;

{$R *.dfm}

procedure TfmComparerecords.Button1Click(Sender: TObject);
var
  ctr: Integer;
  HasGlobalRef: boolean;
begin
  inherited;
  with TempMyScript do try
    SQL.add('Drop table if exists '+ TableName +';');
    SQL.add('create table ' +TableName + ' ( ' +
            ' `id` INT(10) NULL AUTO_INCREMENT, ' +
            ' 	`Fieldname` VARCHAR(255) NULL DEFAULT "", ' +
            ' 	`Value1` VARCHAR(255) NULL DEFAULT  "", ' +
            ' 	`Value2` VARCHAR(255) NULL DEFAULT  "", ' +
            ' 	PRIMARY KEY (`id`) ' +
            ' ) ' +
            ' COLLATE=''utf8_general_ci'' ' +
            ' ENGINE=MyISAM;');
    execute;
  finally
    Free;
  end;
  with ERPQuery1 do begin
    if active then close;
    SQL.clear;
    SQL.add('Select * from '+tablename);
    open;
  end;

      Qry1.SQL.text := 'Select * from ' +cbotablename1.Text +' where ' + MySQLTablePrimaryKey(cbotablename1.Text,TMyconnection(Qry1.Connection),HasGlobalRef) +' = ' + edtID1.text;
      Qry2.SQL.text := 'Select * from ' +cbotablename1.Text +' where ' + MySQLTablePrimaryKey(cbotablename1.Text,TMyconnection(Qry1.Connection),HasGlobalRef) +' = ' + edtID2.text;
      Qry1.open;
      Qry2.open;
      for ctr:= 0 to Qry1.fieldcount-1 do begin
        if Qry1.fields[ctr].value <>Qry2.fields[ctr].value then begin
          ERPQuery1.append;
          ERPQuery1.FieldByName('Fieldname').AsString:= Qry1.fields[ctr].fieldname;
          ERPQuery1.FieldByName('Value1').AsString:=Qry1.fields[ctr].AsString;
          ERPQuery1.FieldByName('Value2').AsString:= Qry2.fields[ctr].AsString;
          ERPQuery1.Post;
        end;
      end;
end;

procedure TfmComparerecords.Button2Click(Sender: TObject);
var
  s: String;
  HasGlobalRef: boolean;
begin
  inherited;
  s:= MySQLTablePrimaryKey(cbotablename1.Text,TMyconnection(Qry1.Connection), HasGlobalRef);

  Closedb(QryComp1);
  Closedb(QryComp2);
  QryComp1.SQL.text := 'Select * from '+cbotablename1.text;
  QryComp2.SQL.text := 'Select * from '+cbotablename2.text;
  Opendb(QryComp1);
  Opendb(QryComp2);


end;

procedure TfmComparerecords.FormCreate(Sender: TObject);
begin
  inherited;
  TableName := GetUserTemporaryTableName('Comparerecs');
end;

procedure TfmComparerecords.FormShow(Sender: TObject);
begin
  inherited;
  ERPQuery2.Open;
end;

initialization
  RegisterClassOnce(TfmComparerecords);

end.

