unit frmdebugExtra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls, ExtCtrls, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, wwdbedit, Mask, DBCtrls, DNMSpeedButton, Menus, IdBaseComponent, IdNetworkCalculator, AdvSmoothCalculator,
  ImgList, Shader, ActnList, DNMAction, DNMPanel, AdvMenus, DAScript, MyScript;

type
  TfmdebugExtra = class(TfrmBaseGUI)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ListBox1: TListBox;
    Edit1: TEdit;
    edtamt: TEdit;
    edtrto: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtrndfrom: TEdit;
    value: TLabel;
    Label3: TLabel;
    edtrounded: TEdit;
    Button6: TButton;
    Button7: TButton;
    frmChartofAccountsSrc: TDataSource;
    qryChartofAccounts: TERPQuery;
    qryChartofAccountsAccountID: TAutoIncField;
    qryChartofAccountsAccountNumber: TWideStringField;
    qryChartofAccountsAccountType: TWideStringField;
    qryChartofAccountsAccountGroup: TWideStringField;
    qryChartofAccountsAccountName: TWideStringField;
    qryChartofAccountsDescription: TWideStringField;
    qryChartofAccountsBankNumber: TWideStringField;
    qryChartofAccountsActive: TWideStringField;
    qryChartofAccountsTaxcode: TWideStringField;
    qryChartofAccountsEditedFlag: TWideStringField;
    qryChartofAccountsClass: TWideStringField;
    qryChartofAccountsAllClasses: TWideStringField;
    qryChartofAccountsBankAccountName: TWideStringField;
    qryChartofAccountsLastChequeNo: TIntegerField;
    qryChartofAccountsUseLastChequeNo: TWideStringField;
    qryChartofAccountsRequired: TWideStringField;
    qryChartofAccountsBankCode: TWideStringField;
    qryChartofAccountsAPCANo: TWideStringField;
    qryChartofAccountsBSB: TWideStringField;
    qryChartofAccountsGlobalRef: TWideStringField;
    qryChartofAccountsBalance: TFloatField;
    qryChartofAccountsExtra: TWideStringField;
    qryChartofAccountsOpeningBalance: TFloatField;
    qryChartofAccountsDebits: TFloatField;
    qryChartofAccountsCredits: TFloatField;
    qryChartofAccountsClosingBalance: TFloatField;
    qryChartofAccountsLevel1: TWideStringField;
    qryChartofAccountsLevel2: TWideStringField;
    qryChartofAccountsLevel3: TWideStringField;
    qryChartofAccountsLevel4: TWideStringField;
    qryChartofAccountsIncludeBalanceRecord: TWideStringField;
    qryChartofAccountsIncludeNetTotal: TWideStringField;
    qryChartofAccountsIncludeCreditTotal: TWideStringField;
    qryChartofAccountsIncludeDebitTotal: TWideStringField;
    qryChartofAccountsBankAccountNumber: TWideStringField;
    qryChartofAccountsIsHeader: TWideStringField;
    qryChartofAccountsAllowExpenseClaim: TWideStringField;
    edtBSB: TDBEdit;
    wwDBEdit1: TwwDBEdit;
    DataSource1: TDataSource;
    ERPQuery1: TERPQuery;
    ERPConnection1: TERPConnection;
    ERPQuery1ID: TIntegerField;
    ERPQuery1LanguageID: TIntegerField;
    ERPQuery1EnglishID: TIntegerField;
    ERPQuery1Translation: TWideStringField;
    wwDBEdit2: TwwDBEdit;
    lblstep1: TDBText;
    DNMSpeedButton1: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    ImageList1: TImageList;
    ActionList: TActionList;
    DNMAction1: TDNMAction;
    DNMAction2: TDNMAction;
    ActionList1: TActionList;
    DNMAction3: TDNMAction;
    DNMAction4: TDNMAction;
    DNMSpeedButton5: TDNMSpeedButton;
    DNMSpeedButton6: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    DNMSpeedButton4: TDNMSpeedButton;
    DNMSpeedButton3: TDNMSpeedButton;
    popMnu: TAdvPopupMenu;
    PlayVideo1: TMenuItem;
    PlayWorkflow1: TMenuItem;
    DNMPanel2: TDNMPanel;
    Shader2: TShader;
    Label5: TLabel;
    Shader1: TShader;
    Label4: TLabel;
    pnlPopup: TDNMPanel;
    lblPlayvideo: TLabel;
    lblPlayWorkflow: TLabel;
    mnuDiscountTotal: TAdvPopupMenu;
    DiscountDollarTotal: TMenuItem;
    DiscountPercentTotal: TMenuItem;
    N4: TMenuItem;
    mnuProductNotes: TMenuItem;
    ETAInfo: TMenuItem;
    N3: TMenuItem;
    CustomFields1: TMenuItem;
    N1: TMenuItem;
    DNMSpeedButton7: TDNMSpeedButton;
    DNMSpeedButton8: TDNMSpeedButton;
    btnPopulatepicture: TButton;
    ERPScript1: TERPScript;
    ERPQuery2: TERPQuery;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure DNMSpeedButton7Click(Sender: TObject);
    procedure DNMSpeedButton8Click(Sender: TObject);
    procedure btnPopulatepictureClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib, CommonFormLib, DNMLib, SystemLib , ShlObj, dmMainGUI, ProductQtyLib, LogLib,
  PQALib;

{$R *.dfm}
procedure TfmdebugExtra.btnPopulatepictureClick(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  if ERPConnection1.Connected then ERPConnection1.Connected := False;
  ERPConnection1.Server := 'Dev1';
  ERPConnection1.Database := 'electronauts_llc';
  ERPConnection1.connect;
  ERPQuery2.Connection := ERPConnection1;
  ERPScript1.Connection := ERPConnection1;
  for ctr := 1 to 100 do begin
    ERPScript1.SQL.Clear;
    ERPScript1.SQL.Text := 'insert ignore into tblpartspics (partID , partPic , Pictype) ' +
                            ' select P.partsId , PP.partpic , PP.Pictype ' +
                            ' from tblparts P , tblpartspics PP ' +
                            ' limit ' + inttostr(ctr*1000)+' , '+ inttostr((ctr+1)*1000)+';';
    logtext(ERPScript1.SQL.Text);
    ERPScript1.Execute;
    ERPQuery2.active := False;
    ERPQuery2.open;
    Label6.Caption :=inttostr(ERPQuery2.fieldbyname('ctr').AsInteger);
    Label6.Refresh;
    btnPopulatepicture.caption := inttostr(ctr);
    btnPopulatepicture.Refresh;
  end;
  btnPopulatepicture.caption := 'Populate product pictures';
end;

procedure TfmdebugExtra.Button1Click(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmRecTransSQL',0);
end;

procedure TfmdebugExtra.Button2Click(Sender: TObject);
begin
  inherited;
  OpenERPForm('Tfmdebugclosingsdates',0);
end;

procedure TfmdebugExtra.Button3Click(Sender: TObject);
begin
  inherited;
  Showmessage('insert into tblvouchers (Voucherno , clientID, classId , value , DateCreated , DateIssued, IsIssued, DateRedeemed, IsRedeemed, Active, IssuedBy) ' +
        ' select S.saleId ,  S.ClientID , S.ClassID , SL.TotalLineAmountInc , S.SaleDate, S.SaleDate, "T" , null , "F" , "T" , S.EmployeeID ' +
        ' from tblsaleslines SL inner join tblsales S on S.SaleId = Sl.SaleId ' +
        ' where SL.Productname = "Voucher" and S.saleID not in (select saleId from tblvouchers) ');
end;

procedure TfmdebugExtra.Button4Click(Sender: TObject);
var
  a2 :Array of string (* = ['a','b','c'] *);
  a3 :Array of string (* = ['d','e','f'] *);
  a4 :Array of string (* = ['g','h','i'] *);
  a5 :Array of string (* = ['j','k','l'] *);
  a6 :Array of string (* = ['m','n','o'] *);
  a7 :Array of string (* = ['p','q','r','s'] *);
  a8 :Array of string (* = ['t','u','v'] *);
  a9 :Array of string (* = ['w','x','y' , 'z'] *);
  a10 :Array of string (* = ['w','x','y' , 'z'] *);
  i2,i3,i4,i5,i6,i7,i8,i9, i10:Integer;
  no :String;
  Procedure setarraya2(i:Integer);
  begin
             if i = 0 then begin      SetLength(a2,1); a2[0] := '';
    end else if i = 1 then begin      SetLength(a2,1); a2[0] := '';
    end else if i = 2 then begin      SetLength(a2,3); a2[0] := 'a';      a2[1] := 'b';      a2[2] := 'c';
    end else if i = 3 then begin      SetLength(a2,3);      a2[0] := 'd';      a2[1] := 'e';      a2[2] := 'f';
    end else if i = 4 then begin      SetLength(a2,3);      a2[0] := 'g';      a2[1] := 'h';      a2[2] := 'i';
    end else if i = 5 then begin      SetLength(a2,3);      a2[0] := 'j';      a2[1] := 'k';      a2[2] := 'l';
    end else if i = 6 then begin      SetLength(a2,3);      a2[0] := 'm';      a2[1] := 'n';      a2[2] := 'o';
    end else if i = 7 then begin      SetLength(a2,4);      a2[0] := 'p';      a2[1] := 'q';      a2[2] := 'r';      a2[3] := 's';
    end else if i = 8 then begin      SetLength(a2,3);      a2[0] := 't';      a2[1] := 'u';      a2[2] := 'v';
    end else if i = 9 then begin      SetLength(a2,4);      a2[0] := 'w';      a2[1] := 'x';      a2[2] := 'y';      a2[3] := 'z';
    end;
  end;
  Procedure setarraya3(i:Integer);
  begin
             if i = 0 then begin      SetLength(a3,1); a2[0] := '';
    end else if i = 1 then begin      SetLength(a3,1); a2[0] := '';
    end else if i = 2 then begin      SetLength(a3,3);      a3[0] := 'a';      a3[1] := 'b';      a3[2] := 'c';
    end else if i = 3 then begin      SetLength(a3,3);      a3[0] := 'd';      a3[1] := 'e';      a3[2] := 'f';
    end else if i = 4 then begin      SetLength(a3,3);      a3[0] := 'g';      a3[1] := 'h';      a3[2] := 'i';
    end else if i = 5 then begin      SetLength(a3,3);      a3[0] := 'j';      a3[1] := 'k';      a3[2] := 'l';
    end else if i = 6 then begin      SetLength(a3,3);      a3[0] := 'm';      a3[1] := 'n';      a3[2] := 'o';
    end else if i = 7 then begin      SetLength(a3,4);      a3[0] := 'p';      a3[1] := 'q';      a3[2] := 'r';      a3[3] := 's';
    end else if i = 8 then begin      SetLength(a3,3);      a3[0] := 't';      a3[1] := 'u';      a3[2] := 'v';
    end else if i = 9 then begin      SetLength(a3,4);      a3[0] := 'w';      a3[1] := 'x';      a3[2] := 'y';      a3[3] := 'z';
    end;
  end;
  Procedure setarraya4(i:Integer);
  begin
             if i = 0 then begin      SetLength(a4,1); a2[0] := '';
    end else if i = 1 then begin      SetLength(a4,1); a2[0] := '';
    end else if i = 2 then begin      SetLength(a4,3);      a4[0] := 'a';      a4[1] := 'b';      a4[2] := 'c';
    end else if i = 3 then begin      SetLength(a4,3);      a4[0] := 'd';      a4[1] := 'e';      a4[2] := 'f';
    end else if i = 4 then begin      SetLength(a4,3);      a4[0] := 'g';      a4[1] := 'h';      a4[2] := 'i';
    end else if i = 5 then begin      SetLength(a4,3);      a4[0] := 'j';      a4[1] := 'k';      a4[2] := 'l';
    end else if i = 6 then begin      SetLength(a4,3);      a4[0] := 'm';      a4[1] := 'n';      a4[2] := 'o';
    end else if i = 7 then begin      SetLength(a4,4);      a4[0] := 'p';      a4[1] := 'q';      a4[2] := 'r';      a4[3] := 's';
    end else if i = 8 then begin      SetLength(a4,3);      a4[0] := 't';      a4[1] := 'u';      a4[2] := 'v';
    end else if i = 9 then begin      SetLength(a4,4);      a4[0] := 'w';      a4[1] := 'x';      a4[2] := 'y';      a4[3] := 'z';
    end;
  end;
  Procedure setarraya5(i:Integer);
  begin
             if i = 0 then begin      SetLength(a5,1); a2[0] := '';
    end else if i = 1 then begin      SetLength(a5,1); a2[0] := '';
    end else if i = 2 then begin      SetLength(a5,3);      a5[0] := 'a';      a5[1] := 'b';      a5[2] := 'c';
    end else if i = 3 then begin      SetLength(a5,3);      a5[0] := 'd';      a5[1] := 'e';      a5[2] := 'f';
    end else if i = 4 then begin      SetLength(a5,3);      a5[0] := 'g';      a5[1] := 'h';      a5[2] := 'i';
    end else if i = 5 then begin      SetLength(a5,3);      a5[0] := 'j';      a5[1] := 'k';      a5[2] := 'l';
    end else if i = 6 then begin      SetLength(a5,3);      a5[0] := 'm';      a5[1] := 'n';      a5[2] := 'o';
    end else if i = 7 then begin      SetLength(a5,4);      a5[0] := 'p';      a5[1] := 'q';      a5[2] := 'r';      a5[3] := 's';
    end else if i = 8 then begin      SetLength(a5,3);      a5[0] := 't';      a5[1] := 'u';      a5[2] := 'v';
    end else if i = 9 then begin      SetLength(a5,4);      a5[0] := 'w';      a5[1] := 'x';      a5[2] := 'y';      a5[3] := 'z';
    end;
  end;
  Procedure setarraya6(i:Integer);
  begin
             if i = 0 then begin      SetLength(a6,1); a2[0] := '';
    end else if i = 1 then begin      SetLength(a6,1); a2[0] := '';
    end else if i = 2 then begin      SetLength(a6,3);      a6[0] := 'a';      a6[1] := 'b';      a6[2] := 'c';
    end else if i = 3 then begin      SetLength(a6,3);      a6[0] := 'd';      a6[1] := 'e';      a6[2] := 'f';
    end else if i = 4 then begin      SetLength(a6,3);      a6[0] := 'g';      a6[1] := 'h';      a6[2] := 'i';
    end else if i = 5 then begin      SetLength(a6,3);      a6[0] := 'j';      a6[1] := 'k';      a6[2] := 'l';
    end else if i = 6 then begin      SetLength(a6,3);      a6[0] := 'm';      a6[1] := 'n';      a6[2] := 'o';
    end else if i = 7 then begin      SetLength(a6,4);      a6[0] := 'p';      a6[1] := 'q';      a6[2] := 'r';      a6[3] := 's';
    end else if i = 8 then begin      SetLength(a6,3);      a6[0] := 't';      a6[1] := 'u';      a6[2] := 'v';
    end else if i = 9 then begin      SetLength(a6,4);      a6[0] := 'w';      a6[1] := 'x';      a6[2] := 'y';      a6[3] := 'z';
    end;
  end;
  Procedure setarraya7(i:Integer);
  begin
             if i = 0 then begin      SetLength(a7,1); a2[0] := '';
    end else if i = 1 then begin      SetLength(a7,1); a2[0] := '';
    end else if i = 2 then begin      SetLength(a7,3);      a7[0] := 'a';      a7[1] := 'b';      a7[2] := 'c';
    end else if i = 3 then begin      SetLength(a7,3);      a7[0] := 'd';      a7[1] := 'e';      a7[2] := 'f';
    end else if i = 4 then begin      SetLength(a7,3);      a7[0] := 'g';      a7[1] := 'h';      a7[2] := 'i';
    end else if i = 5 then begin      SetLength(a7,3);      a7[0] := 'j';      a7[1] := 'k';      a7[2] := 'l';
    end else if i = 6 then begin      SetLength(a7,3);      a7[0] := 'm';      a7[1] := 'n';      a7[2] := 'o';
    end else if i = 7 then begin      SetLength(a7,4);      a7[0] := 'p';      a7[1] := 'q';      a7[2] := 'r';      a7[3] := 's';
    end else if i = 8 then begin      SetLength(a7,3);      a7[0] := 't';      a7[1] := 'u';      a7[2] := 'v';
    end else if i = 9 then begin      SetLength(a7,4);      a7[0] := 'w';      a7[1] := 'x';      a7[2] := 'y';      a7[3] := 'z';
    end;
  end;
  Procedure setarraya8(i:Integer);
  begin
             if i = 0 then begin      SetLength(a8,1); a2[0] := '';
    end else if i = 2 then begin      SetLength(a8,1); a2[0] := '';
    end else if i = 2 then begin      SetLength(a8,3);      a8[0] := 'a';      a8[1] := 'b';      a8[2] := 'c';
    end else if i = 3 then begin      SetLength(a8,3);      a8[0] := 'd';      a8[1] := 'e';      a8[2] := 'f';
    end else if i = 4 then begin      SetLength(a8,3);      a8[0] := 'g';      a8[1] := 'h';      a8[2] := 'i';
    end else if i = 5 then begin      SetLength(a8,3);      a8[0] := 'j';      a8[1] := 'k';      a8[2] := 'l';
    end else if i = 6 then begin      SetLength(a8,3);      a8[0] := 'm';      a8[1] := 'n';      a8[2] := 'o';
    end else if i = 7 then begin      SetLength(a8,4);      a8[0] := 'p';      a8[1] := 'q';      a8[2] := 'r';      a8[3] := 's';
    end else if i = 8 then begin      SetLength(a8,3);      a8[0] := 't';      a8[1] := 'u';      a8[2] := 'v';
    end else if i = 9 then begin      SetLength(a8,4);      a8[0] := 'w';      a8[1] := 'x';      a8[2] := 'y';      a8[3] := 'z';
    end;
  end;
  Procedure setarraya9(i:Integer);
  begin
             if i = 0 then begin      SetLength(a9,1); a2[0] := '';
    end else if i = 1 then begin      SetLength(a9,1); a2[0] := '';
    end else if i = 2 then begin      SetLength(a9,3);      a9[0] := 'a';      a9[1] := 'b';      a9[2] := 'c';
    end else if i = 3 then begin      SetLength(a9,3);      a9[0] := 'd';      a9[1] := 'e';      a9[2] := 'f';
    end else if i = 4 then begin      SetLength(a9,3);      a9[0] := 'g';      a9[1] := 'h';      a9[2] := 'i';
    end else if i = 5 then begin      SetLength(a9,3);      a9[0] := 'j';      a9[1] := 'k';      a9[2] := 'l';
    end else if i = 6 then begin      SetLength(a9,3);      a9[0] := 'm';      a9[1] := 'n';      a9[2] := 'o';
    end else if i = 7 then begin      SetLength(a9,4);      a9[0] := 'p';      a9[1] := 'q';      a9[2] := 'r';      a9[3] := 's';
    end else if i = 8 then begin      SetLength(a9,3);      a9[0] := 't';      a9[1] := 'u';      a9[2] := 'v';
    end else if i = 9 then begin      SetLength(a9,4);      a9[0] := 'w';      a9[1] := 'x';      a9[2] := 'y';      a9[3] := 'z';
    end;
  end;
  Procedure setarraya10(i:Integer);
  begin
             if i = 0 then begin      SetLength(a10,1); a2[0] := '';
    end else if i = 1 then begin      SetLength(a10,1); a2[0] := '';
    end else if i = 2 then begin      SetLength(a10,3);      a10[0] := 'a';      a10[1] := 'b';      a10[2] := 'c';
    end else if i = 3 then begin      SetLength(a10,3);      a10[0] := 'd';      a10[1] := 'e';      a10[2] := 'f';
    end else if i = 4 then begin      SetLength(a10,3);      a10[0] := 'g';      a10[1] := 'h';      a10[2] := 'i';
    end else if i = 5 then begin      SetLength(a10,3);      a10[0] := 'j';      a10[1] := 'k';      a10[2] := 'l';
    end else if i = 6 then begin      SetLength(a10,3);      a10[0] := 'm';      a10[1] := 'n';      a10[2] := 'o';
    end else if i = 7 then begin      SetLength(a10,4);      a10[0] := 'p';      a10[1] := 'q';      a10[2] := 'r';      a10[3] := 's';
    end else if i = 8 then begin      SetLength(a10,3);      a10[0] := 't';      a10[1] := 'u';      a10[2] := 'v';
    end else if i = 9 then begin      SetLength(a10,4);      a10[0] := 'w';      a10[1] := 'x';      a10[2] := 'y';      a10[3] := 'z';
    end;
  end;
begin
  inherited;
  SetLength(a2,0);
  SetLength(a3,0);
  SetLength(a4,0);
  SetLength(a5,0);
  SetLength(a6,0);
  SetLength(a7,0);
  SetLength(a8,0);
  SetLength(a9,0);
  SetLength(a10,0);
  ListBox1.Items.clear;
  no := edit1.text;
  setarraya2(strToint(copy(no , 1,1)));
  setarraya3(strToint(copy(no , 2,1)));
  setarraya4(strToint(copy(no , 3,1)));
  setarraya5(strToint(copy(no , 4,1)));
  setarraya6(strToint(copy(no , 5,1)));
  setarraya7(strToint(copy(no , 6,1)));
  setarraya8(strToint(copy(no , 7,1)));
  setarraya9(strToint(copy(no , 8,1)));
  setarraya10(strToint(copy(no , 9,1)));
  for i2:= low(a2) to high(a2) do
  for i3:= low(a3) to high(a3) do
  for i4:= low(a4) to high(a4) do
  for i5:= low(a5) to high(a5) do
  for i6:= low(a6) to high(a6) do
  for i7:= low(a7) to high(a7) do
  for i8:= low(a8) to high(a8) do
  for i9:= low(a9) to high(a9) do
  for i10:= low(a10) to high(a10) do begin
    ListBox1.Items.Add(a2[i2]+
       a3[i3]+
       a4[i4]+
       a5[i5]+
       a6[i6]+
       a7[i7]+
       a8[i8]+
       a9[i9]+
       a10[i10]);
  end;
  ListBox1.Items.Savetofile('c:\temp\'+edit1.text+'.text');
end;

procedure TfmdebugExtra.btn5Click(Sender: TObject);
begin
  inherited;
//  edtrounded.Text := FloattoStr(   RoundTo5C(strtofloat( edtamt.text) , StrtoInt(edtrndfrom.Text), StrtoInt(edtrto.Text)));
end;

procedure TfmdebugExtra.Button6Click(Sender: TObject);
begin
  inherited;
  edtrounded.Text := FloattoStr(   RoundTo5C(strtofloat( edtamt.text) (*, StrtoInt(edtrto.Text)*)));
end;

procedure TfmdebugExtra.Button7Click(Sender: TObject);
begin
  inherited;
  Showmessage(SpecialFolder(CSIDL_PROGRAM_FILESX86));
end;

procedure TfmdebugExtra.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  ExecNewProcess(WinSysDir+'\calc.exe', true);
  MessageDlg('dfsfsdfsdf', mtWarning, [mbOK], 0);
end;

procedure TfmdebugExtra.DNMSpeedButton7Click(Sender: TObject);
begin
  inherited;
  mnuDiscountTotal.Popup(10,10);
end;

procedure TfmdebugExtra.DNMSpeedButton8Click(Sender: TObject);
begin
  inherited;
  logtext( 'Select '+SQL4Qty(tAvailable)+' from ' +ProductTables(tExtraDetails)+' where PBin.binid = 1');
end;

initialization
  RegisterClassOnce(TfmdebugExtra);

end.



