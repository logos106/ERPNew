unit SalesReportSaleslinescustomFieldList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesReportForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TSalesReportSaleslinescustomFieldListGUI = class(TSalesReportGUI)
    qryMainSALESLINESCUSTFIELD1  : TWideStringField;
    qryMainSALESLINESCUSTFIELD2  : TWideStringField;
    qryMainSALESLINESCUSTFIELD3  : TWideStringField;
    qryMainSALESLINESCUSTFIELD4  : TWideStringField;
    qryMainSALESLINESCUSTFIELD5  : TWideStringField;
    qryMainSALESLINESCUSTFIELD6  : TWideStringField;
    qryMainSALESLINESCUSTFIELD7  : TWideStringField;
    qryMainSALESLINESCUSTFIELD8  : TWideStringField;
    qryMainSALESLINESCUSTFIELD9  : TWideStringField;
    qryMainSALESLINESCUSTFIELD10 : TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  Protected
    Function Extrafields:String;Override;
    Function SaleLinescustomfields(Const Tablealias:String)  :String;Override;
    function Customfields:String;Override;
    Function TablenameSufix:String;Override;
  public
    procedure RefreshQuery; override;
  end;


implementation

uses CommonLib, Busobjcustomfields;

{$R *.dfm}
{ TSalesReportSaleslinescustomFieldListGUI }

function TSalesReportSaleslinescustomFieldListGUI.Customfields: String;
begin
    result := 'Alter table ' + fsTablename + ' Add column SALESLINESCUSTFIELD1  varchar(255);' +
              'Alter table ' + fsTablename + ' Add column SALESLINESCUSTFIELD2  varchar(255);' +
              'Alter table ' + fsTablename + ' Add column SALESLINESCUSTFIELD3  varchar(255);' +
              'Alter table ' + fsTablename + ' Add column SALESLINESCUSTFIELD4  varchar(255);' +
              'Alter table ' + fsTablename + ' Add column SALESLINESCUSTFIELD5  varchar(255);' +
              'Alter table ' + fsTablename + ' Add column SALESLINESCUSTFIELD6  varchar(255);' +
              'Alter table ' + fsTablename + ' Add column SALESLINESCUSTFIELD7  varchar(255);' +
              'Alter table ' + fsTablename + ' Add column SALESLINESCUSTFIELD8  varchar(255);' +
              'Alter table ' + fsTablename + ' Add column SALESLINESCUSTFIELD9  varchar(255);' +
              'Alter table ' + fsTablename + ' Add column SALESLINESCUSTFIELD10 varchar(255);' ;

end;

function TSalesReportSaleslinescustomFieldListGUI.Extrafields: String;
var
  st:TStringlist;
begin
  st:= tStringlist.create;
  try
    st.Add('SALESLINESCUSTFIELD1 as  SALESLINESCUSTFIELD1  ,');
    st.Add('SALESLINESCUSTFIELD2 as  SALESLINESCUSTFIELD2  ,');
    st.Add('SALESLINESCUSTFIELD3 as  SALESLINESCUSTFIELD3  ,');
    st.Add('SALESLINESCUSTFIELD4 as  SALESLINESCUSTFIELD4  ,');
    st.Add('SALESLINESCUSTFIELD5 as  SALESLINESCUSTFIELD5  ,');
    st.Add('SALESLINESCUSTFIELD6 as  SALESLINESCUSTFIELD6  ,');
    st.Add('SALESLINESCUSTFIELD7 as  SALESLINESCUSTFIELD7  ,');
    st.Add('SALESLINESCUSTFIELD8 as  SALESLINESCUSTFIELD8  ,');
    st.Add('SALESLINESCUSTFIELD9 as  SALESLINESCUSTFIELD9  ,');
    st.Add('SALESLINESCUSTFIELD10 as  SALESLINESCUSTFIELD10,  ');
    Result := st.Text
  finally
    Freeandnil(st);
  end;
end;


function TSalesReportSaleslinescustomFieldListGUI.SaleLinescustomfields(Const Tablealias:String) : String;
  Function Prefix:String; begin result :='' ; if Tablealias <> '' then result := Tablealias +'.'; end;
begin
    result := Prefix +'SALESLINESCUSTFIELD1  ,' +
              Prefix +'SALESLINESCUSTFIELD2  ,'+
              Prefix +'SALESLINESCUSTFIELD3  ,'+
              Prefix +'SALESLINESCUSTFIELD4  ,'+
              Prefix +'SALESLINESCUSTFIELD5  ,'+
              Prefix +'SALESLINESCUSTFIELD6  ,'+
              Prefix +'SALESLINESCUSTFIELD7  ,'+
              Prefix +'SALESLINESCUSTFIELD8  ,'+
              Prefix +'SALESLINESCUSTFIELD9  ,'+
              Prefix +'SALESLINESCUSTFIELD10,  ';
end;
function TSalesReportSaleslinescustomFieldListGUI.TablenameSufix: String;
begin
  REsult := 'SL';
end;

procedure TSalesReportSaleslinescustomFieldListGUI.FormCreate(Sender: TObject);
begin
  //NonSearchMode := True;
  inherited;
end;

procedure TSalesReportSaleslinescustomFieldListGUI.FormShow(Sender: TObject);
var
  SaleSLinesCustomFieldList :TSaleSLinesCustomFieldList;
  ctr:Integer;
begin
  inherited;
  TitleLabel.caption := 'Sales Lines Custom Fields';
  SaleSLinesCustomFieldList := TSaleSLinesCustomFieldList.CreateWithNewConn(self);
  try
    SaleSLinesCustomFieldList.Load;
    SaleSLinesCustomFieldList.First;
    for ctr:= 1 to 10 do begin
      if SaleSLinesCustomFieldList.Eof then begin
        GuiPrefs.DbGridElement[grdMain].RemoveField('SALESLINESCUSTFIELD'+trim(inttostr(ctr)));
      end else begin
        Qrymain.FindField('SALESLINESCUSTFIELD'+trim(inttostr(ctr))).DisplayLabel := SaleSLinesCustomFieldList.Description;
      end;
      SaleSLinesCustomFieldList.next;
    end;
  finally
    Freeandnil(SaleSLinesCustomFieldList);
  end;
end;
procedure TSalesReportSaleslinescustomFieldListGUI.RefreshQuery;
begin
  inherited;

end;
initialization
  RegisterClassOnce(TSalesReportSaleslinescustomFieldListGUI);

end.

