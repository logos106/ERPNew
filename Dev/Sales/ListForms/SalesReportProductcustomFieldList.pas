unit SalesReportProductcustomFieldList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesReportForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TSalesReportProductcustomFieldListGUI = class(TSalesReportGUI)
    qryMainCUSTFLD1  : TWideStringField;
    qryMainCUSTFLD2  : TWideStringField;
    qryMainCUSTFLD3  : TWideStringField;
    qryMainCUSTFLD4  : TWideStringField;
    qryMainCUSTFLD5  : TWideStringField;
    qryMainCUSTFLD6  : TWideStringField;
    qryMainCUSTFLD7  : TWideStringField;
    qryMainCUSTFLD8  : TWideStringField;
    qryMainCUSTFLD9  : TWideStringField;
    qryMainCUSTFLD10  : TWideStringField;
    qryMainCUSTFLD11  : TWideStringField;
    qryMainCUSTFLD12  : TWideStringField;
    qryMainCUSTFLD13  : TWideStringField;
    qryMainCUSTFLD14  : TWideStringField;
    qryMainCUSTFLD15  : TWideStringField;
    qryMainCUSTDATE1  : TDateTimefield;
    qryMainCUSTDATE2  : TDateTimefield;
    qryMainCUSTDATE3  : TDateTimefield;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
  Protected
    Function Extrafields:String;Override;
    Function ProductcustomFields(Const Tablealias:String) :String;Override;
    function Customfields:String;Override;
    Function TablenameSufix:String;Override;
    procedure SetGridColumns; Override;
  public
    procedure RefreshQuery; override;
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TSalesReportProductcustomFieldListGUI }

function TSalesReportProductcustomFieldListGUI.Customfields: String;
begin
    result := 'Alter table ' + fsTablename + ' Add column CUSTFLD1 varchar(255);' +
              'Alter table ' + fsTablename + ' Add column CUSTFLD2 varchar(255);' +
              'Alter table ' + fsTablename + ' Add column CUSTFLD3 varchar(255);' +
              'Alter table ' + fsTablename + ' Add column CUSTFLD4 varchar(255);' +
              'Alter table ' + fsTablename + ' Add column CUSTFLD5 varchar(255);' +
              'Alter table ' + fsTablename + ' Add column CUSTFLD6 varchar(255);' +
              'Alter table ' + fsTablename + ' Add column CUSTFLD7 varchar(255);' +
              'Alter table ' + fsTablename + ' Add column CUSTFLD8 varchar(255);' +
              'Alter table ' + fsTablename + ' Add column CUSTFLD9 varchar(255);' +
              'Alter table ' + fsTablename + ' Add column CUSTFLD10 varchar(255);' +
              'Alter table ' + fsTablename + ' Add column CUSTFLD11 varchar(255);' +
              'Alter table ' + fsTablename + ' Add column CUSTFLD12 varchar(255);' +
              'Alter table ' + fsTablename + ' Add column CUSTFLD13 varchar(255);' +
              'Alter table ' + fsTablename + ' Add column CUSTFLD14 varchar(255);' +
              'Alter table ' + fsTablename + ' Add column CUSTFLD15 varchar(255);' +
              'Alter table ' + fsTablename + ' Add column CUSTDATE1 DATETIME;' +
              'Alter table ' + fsTablename + ' Add column CUSTDATE2 DATETIME;' +
              'Alter table ' + fsTablename + ' Add column CUSTDATE3 DATETIME;' ;

end;

function TSalesReportProductcustomFieldListGUI.Extrafields: String;
var
  st:TStringlist;
begin
  st:= tStringlist.create;
  try
    st.Add('CUSTFLD1 as  CUSTFLD1  ,');
    st.Add('CUSTFLD2 as  CUSTFLD2  ,');
    st.Add('CUSTFLD3 as  CUSTFLD3  ,');
    st.Add('CUSTFLD4 as  CUSTFLD4  ,');
    st.Add('CUSTFLD5 as  CUSTFLD5  ,');
    st.Add('CUSTFLD6 as  CUSTFLD6  ,');
    st.Add('CUSTFLD7 as  CUSTFLD7  ,');
    st.Add('CUSTFLD8 as  CUSTFLD8  ,');
    st.Add('CUSTFLD9 as  CUSTFLD9  ,');
    st.Add('CUSTFLD10 as  CUSTFLD10  ,');
    st.Add('CUSTFLD11 as  CUSTFLD11  ,');
    st.Add('CUSTFLD12 as  CUSTFLD12  ,');
    st.Add('CUSTFLD13 as  CUSTFLD13  ,');
    st.Add('CUSTFLD14 as  CUSTFLD14  ,');
    st.Add('CUSTFLD15 as  CUSTFLD15  ,');
    st.Add('CUSTDATE1 as  CUSTDATE1  ,');
    st.Add('CUSTDATE2 as  CUSTDATE2  ,');
    st.Add('CUSTDATE3 as  CUSTDATE3  ,');
    Result := st.Text
  finally
    Freeandnil(st);
  end;
end;

procedure TSalesReportProductcustomFieldListGUI.FormCreate(Sender: TObject);
begin
  //NonSearchMode := True;
  inherited;
end;

procedure TSalesReportProductcustomFieldListGUI.FormShow(Sender: TObject);
begin
  inherited;
  TitleLabel.caption := 'Product Custom Fields';
end;

function TSalesReportProductcustomFieldListGUI.ProductcustomFields(Const Tablealias:String): String;
  Function Prefix:String; begin result :='' ; if Tablealias <> '' then result := Tablealias +'.'; end;
begin
    result := Prefix +'CUSTFLD1 , ' +
              Prefix +'CUSTFLD2 , ' +
              Prefix +'CUSTFLD3 , ' +
              Prefix +'CUSTFLD4 , ' +
              Prefix +'CUSTFLD5 , ' +
              Prefix +'CUSTFLD6 , ' +
              Prefix +'CUSTFLD7 , ' +
              Prefix +'CUSTFLD8 , ' +
              Prefix +'CUSTFLD9 , ' +
              Prefix +'CUSTFLD10 , ' +
              Prefix +'CUSTFLD11 , ' +
              Prefix +'CUSTFLD12 , ' +
              Prefix +'CUSTFLD13 , ' +
              Prefix +'CUSTFLD14 , ' +
              Prefix +'CUSTFLD15 , ' +
              Prefix +'CUSTDATE1 , ' +
              Prefix +'CUSTDATE2 , ' +
              Prefix +'CUSTDATE3 , ' ;

end;

procedure TSalesReportProductcustomFieldListGUI.RefreshQuery;
begin
  inherited;

end;
procedure TSalesReportProductcustomFieldListGUI.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Product');
end;

function TSalesReportProductcustomFieldListGUI.TablenameSufix: String;
begin
  REsult :='Prod';
end;

initialization
  RegisterClassOnce(TSalesReportProductcustomFieldListGUI);

end.

