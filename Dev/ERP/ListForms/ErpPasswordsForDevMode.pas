unit ErpPasswordsForDevMode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TErpPasswordsForDevModeGUI = class(TBaseListingGUI)
    qryMainName: TWideStringField;
    qryMainIPAddress: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainClient: TWideStringField;
    qryMainUser: TWideStringField;
    qryMainPassword: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure grpFiltersClick(Sender: TObject); override;
  private
    fstablename:String;

    Procedure MakeQrymain;
  public
  end;


implementation

uses CommonLib, CommonDbLib , Clipbrd;

{$R *.dfm}
{ TErpPasswordsForDevModeGUI }

procedure TErpPasswordsForDevModeGUI.FormCreate(Sender: TObject);
begin
  fstablename := commondblib.GetUserTemporaryTableName('ERPPass');
  Qrymain.SQL.Text := 'Select * from ' + fstablename+' order by seqno';
  inherited;
  MakeQrymain;
  DisableSortoncolumtitleclick:= TRue;
  HaveDateRangeSelection := False;
end;

procedure TErpPasswordsForDevModeGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  inherited;
end;

procedure TErpPasswordsForDevModeGUI.grdMainDblClick(Sender: TObject);
begin
//  inherited;
(*if sametext(activefieldname, qrymainuser.fieldname) then
  Clipboard.asText:= Activefield.asString
else Clipboard.asText:= qrymainpassword.asString;*)
  Clipboard.asText:= Activefield.asString;
end;

procedure TErpPasswordsForDevModeGUI.grpFiltersClick(Sender: TObject);
begin
  if grpFilters.itemindex = grpFilters.items.count-1 then groupfilterString := ''
  else groupfilterstring :='User = ' + quotedstr(trim(grpFilters.items[grpFilters.itemindex]));
  if grpFilters.itemindex =0 then
    groupfilterString := groupfilterString  +' or  ShowDefault =' + quotedstr('T');
  inherited;
end;

procedure TErpPasswordsForDevModeGUI.MakeQrymain;
var
  i:Integer;
begin
  with scriptmain do begin
    SQL.Clear;
    SQL.add('drop table if exists ' + fsTablename +';' );
    SQL.add('CREATE TABLE ' + fsTablename +' ( '+
             ' Seqno        INT(11)       null DEFAULT 0,' +
             ' Name         VARCHAR(255)  NULL DEFAULT NULL, '+
             ' IPAddress    VARCHAR(255)  NULL DEFAULT NULL, '+
             ' Description  VARCHAR(255)  NULL DEFAULT NULL, '+
             ' Client       VARCHAR(255)  NULL DEFAULT NULL, '+
             ' User         VARCHAR(255)  NULL DEFAULT NULL, '+
             ' PassWord     VARCHAR(255)  NULL DEFAULT NULL, '+
             ' ShowDefault Enum("T","F") default "F" ' +
             ' ) COLLATE="utf8_general_ci" ENGINE=MyISAM ;');
             i:= 0;
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Thinstuff"               '   +', IPAddress ="https://www.thinstuff.com/licensing/index.php?action=login"' +', Description ="Thinstuff Account Login"                                        '   +', Client =""                  '   +', User ="dev@trueerp.com"  , password ="fk104r8hgxs3qt", ShowDefault ="T";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Router"                  '   +', IPAddress ="192.168.1.1"                                             '   +', Description ="Telstra Router"                                                 '   +', Client =""                  '   +', User ="admin"            , password ="1Rooster", ShowDefault ="T";');

              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Erp-svr1";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Erp-svr1"                '   +', IPAddress ="192.168.1.110"                                           '   +', Description ="Virtual Server Host"                                            '   +', Client =""                  '   +', User ="ERPAdmin"         , password ="Pqe5tDAj5m";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Erp-svr1"                '   +', IPAddress ="192.168.1.110"                                           '   +', Description ="Virtual Server Host"                                            '   +', Client =""                  '   +', User ="Hollie"           , password ="873bn4KA83";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Erp-svr1"                '   +', IPAddress ="192.168.1.110"                                           '   +', Description ="Virtual Server Host"                                            '   +', Client =""                  '   +', User ="Binny"            , password ="dSD99PzVfk";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Erp-svr1"                '   +', IPAddress ="192.168.1.110"                                           '   +', Description ="Virtual Server Host"                                            '   +', Client =""                  '   +', User ="Maureen"          , password ="E73vdQpGSu";');

              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Erp-svr1-1"              '   +', IPAddress ="192.168.1.50"                                            '   +', Description ="Win10 Pro 10GB RAM, 500GB HDD, Unlimited User Thinstuff, RDP 3390"'+', Client ="Think Construction" '   +', User ="ERPAdmin"         , password ="j6JmCtThLS", ShowDefault ="T";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Erp-svr1-2"              '   +', IPAddress ="192.168.1.51"                                            '   +', Description ="Win10 Pro 8GB RAM, 500GB HDD, 10 User Thinstuff, RDP 3391"      '   +', Client ="Zummit Ptastics"   '   +', User ="ERPAdmin"         , password ="PNJznMZ54V", ShowDefault ="T";');

              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Vpn-erp-svr1.softether.net";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Vpn-erp-svr1.softether.net"' +', IPAddress ="110.145.181.218"                                         '   +', Description ="SoftEther Server Manager on erp-svr1"                           '   +', Client =""                  '   +', User =""                 , password ="6McKYCGh8v";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Vpn-erp-svr1.softether.net"' +', IPAddress ="110.145.181.218"                                         '   +', Description ="Softether VPN Server for erp-svr1 – VPN USER"                   '   +', Client =""                  '   +', User ="Ian"              , password ="y5dmDBfxEw";');

              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Dev-svr1";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Dev-svr1"                '   +', IPAddress ="192.168.1.115"                                           '   +', Description ="Head office development server"                                 '   +', Client =""                  '   +', User ="ERPAdmin"         , password ="aR64T5qc55";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Dev-svr1"                '   +', IPAddress ="192.168.1.115"                                           '   +', Description ="Head office development server"                                 '   +', Client =""                  '   +', User ="Ian"              , password ="G2qtqyXjCA";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Dev-svr1"                '   +', IPAddress ="192.168.1.115"                                           '   +', Description ="Head office development server"                                 '   +', Client =""                  '   +', User ="Binny"            , password ="r5ULbXwg5S";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Dev-svr1"                '   +', IPAddress ="192.168.1.115"                                           '   +', Description ="Head office development server"                                 '   +', Client =""                  '   +', User ="Tash"             , password ="5eDQj8enuF";');

              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "CoreEDI"                 '   +', IPAddress ="192.168.1.51"                                            '   +', Description =""                                                               '   +', Client =""                  '   +', User ="ERPAdmin"         , password ="XCxUHb6T7b", ShowDefault ="T";');

              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "SVN User";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "SVN User"                '   +', IPAddress =""                                                        '   +', Description ="SVN User"                                                       '   +', Client =""                  '   +', User ="Ian"              , password ="26BbEt4zyr";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "SVN User"                '   +', IPAddress =""                                                        '   +', Description ="SVN User"                                                       '   +', Client =""                  '   +', User ="Binny"            , password ="ytS8Um6LVB";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "SVN User"                '   +', IPAddress =""                                                        '   +', Description ="SVN User"                                                       '   +', Client =""                  '   +', User ="Rasheed"          , password ="AvG9t6yZAt";');

              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Erp-gen1";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Erp-gen1"                '   +', IPAddress ="192.168.1.100"                                           '   +', Description ="Head office ERP Server and Corp data store"                     '   +', Client =""                  '   +', User ="ERPAdmin"         , password ="5DN2Qdk3Rf";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Erp-gen1"                '   +', IPAddress ="192.168.1.100"                                           '   +', Description ="Head office ERP Server and Corp data store"                     '   +', Client =""                  '   +', User ="Ian"              , password ="vUr3J3vVL6";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Erp-gen1"                '   +', IPAddress ="192.168.1.100"                                           '   +', Description ="Head office ERP Server and Corp data store"                     '   +', Client =""                  '   +', User ="Binny"            , password ="h5J5PmnC4a";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Erp-gen1"                '   +', IPAddress ="192.168.1.100"                                           '   +', Description ="Head office ERP Server and Corp data store"                     '   +', Client =""                  '   +', User ="Hollie"           , password ="sBBSat6978";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Erp-gen1"                '   +', IPAddress ="192.168.1.100"                                           '   +', Description ="Head office ERP Server and Corp data store"                     '   +', Client =""                  '   +', User ="Simon"            , password ="4tNX9s56fp";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Erp-gen1"                '   +', IPAddress ="192.168.1.100"                                           '   +', Description ="Head office ERP Server and Corp data store"                     '   +', Client =""                  '   +', User ="Dene"             , password ="W9X54ZNsH7";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Erp-gen1"                '   +', IPAddress ="192.168.1.100"                                           '   +', Description ="Head office ERP Server and Corp data store"                     '   +', Client =""                  '   +', User ="Maureen"          , password ="4a4nh4zGJs";');

              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = ""                        '   +', IPAddress =""                                                        '   +', Description ="SoftEther Server Manager on erp-svr1"                           '   +', Client =""                  '   +', User =""                 , password ="P66gRVV5UE";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "vpn-erp-gen1.softether.net"' +', IPAddress ="110.145.181.218"                                         '   +', Description ="SoftEther VPN Server for erp-gen1 -SoftEther Client"            '   +', Client =""                  '   +', User ="Maureen"          , password ="RSUk8JXsCg4ZjJZt";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "vpn-erp-gen1.softether.net"' +', IPAddress ="110.145.181.218"                                         '   +', Description ="SoftEther VPN Server for erp-gen1 -SoftEther Client"            '   +', Client =""                  '   +', User ="Ian"              , password ="EdCbVPx6LnGBjP6z";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Magento", ShowDefault ="T";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Magento"' +', IPAddress ="http://192.168.1.115:8080/trueerpmagento/"                                  '   +', Description = "User Login" '                                                      +', Client =""                  '   +', User ="webuser@trueerp.com" , password ="trueerpmag@12345", ShowDefault ="T";');
              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "Magento"' +', IPAddress ="http://192.168.1.115:8080/trueerpmagento/admin_1tujdw/"                     '   +', Description = "Admin Login" '                                                     +', Client =""                  '   +', User ="ERPAdmin"            , password ="trueerpmag12345" , ShowDefault ="T";');

              i := i +1; SQL.add('INSERT IGNORE into ' + fstablename +' Set  seqno = ' + inttostr(i)+',name = "WiFi"' +',  password ="0085658824" , ShowDefault ="T";');

    Execute;
  end;
end;

initialization
  RegisterClass(TErpPasswordsForDevModeGUI);

end.
