unit frmDebug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DNMSpeedButton, ProgressDialog, DB, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog, Menus, ExtCtrls, StdCtrls, Grids, Wwdbigrd, Wwdbgrid,
  wwdblook, ERPDbLookupCombo, AdvShape, DNMPanel, wwcheckbox, Wwdbdlg, DADump,
  MyDump, AdvGlowButton, ComCtrls, AdvProgr, ExcelXP, OleServer, TaskDialog,
  TaskDialogEx, Shader, AdvPanel;

type
  TfmDebug = class(TBaseInputGUI)
    DNMSpeedButton4: TDNMSpeedButton;
    wwDBGrid1: TwwDBGrid;
    cboCustomerPrintJob: TERPDbLookupCombo;
    cboCustomerJob: TERPDbLookupCombo;
    ERPDbLookupCombo1: TERPDbLookupCombo;
    ERPDbLookupCombo2: TERPDbLookupCombo;
    ERPQuery1: TERPQuery;
    DNMSpeedButton1: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    DNMSpeedButton3: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    Panel1: TPanel;
    Shape1: TShape;
    DNMPanel44: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlFe1: TDNMPanel;
    lblfe1: TLabel;
    Shape2: TShape;
    chkfe1: TwwCheckBox;
    pnlFe2: TDNMPanel;
    lblfe2: TLabel;
    Shape3: TShape;
    chkfe2: TwwCheckBox;
    pnlFe3: TDNMPanel;
    lblfe3: TLabel;
    Shape4: TShape;
    chkfe3: TwwCheckBox;
    pnlFe4: TDNMPanel;
    lblfe4: TLabel;
    Shape5: TShape;
    chkfe4: TwwCheckBox;
    pnlFe5: TDNMPanel;
    lblfe5: TLabel;
    Shape6: TShape;
    chkfe5: TwwCheckBox;
    wwDBLookupCombo1: TwwDBLookupCombo;
    wwDBLookupComboDlg1: TwwDBLookupComboDlg;
    MyDump1: TMyDump;
    DNMSpeedButton5: TDNMSpeedButton;
    qryMain: TERPQuery;
    dsMain: TDataSource;
    qryMainHidePercentage: TWideStringField;
    qryMainAccountID: TIntegerField;
    qryMainAccountType: TWideStringField;
    qryMainAccountTypeDesc: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainAmount_1: TFloatField;
    qryMainPercentage_1: TWideStringField;
    qryMainAdditions_1_amt: TFloatField;
    qryMainAdditions_1_Percent: TFloatField;
    qryMainBankInterest_1_amt: TFloatField;
    qryMainBankInterest_1_Percent: TFloatField;
    qryMainAmount_2: TFloatField;
    qryMainPercentage_2: TWideStringField;
    qryMainChange_2: TFloatField;
    qryMainChangePercent_2: TFloatField;
    qryMainAdditions_2_amt: TFloatField;
    qryMainAdditions_2_Percent: TFloatField;
    qryMainBankInterest_2_amt: TFloatField;
    qryMainBankInterest_2_Percent: TFloatField;
    qryMainAmount_3: TFloatField;
    qryMainPercentage_3: TWideStringField;
    qryMainChange_3: TFloatField;
    qryMainChangePercent_3: TFloatField;
    qryMainAdditions_3_amt: TFloatField;
    qryMainAdditions_3_Percent: TFloatField;
    qryMainBankInterest_3_amt: TFloatField;
    qryMainBankInterest_3_Percent: TFloatField;
    qryMainAmount_4: TFloatField;
    qryMainPercentage_4: TWideStringField;
    qryMainAdditions_4_amt: TFloatField;
    qryMainAdditions_4_Percent: TFloatField;
    qryMainBankInterest_4_amt: TFloatField;
    qryMainBankInterest_4_Percent: TFloatField;
    qryMainAmount_5: TFloatField;
    qryMainPercentage_5: TWideStringField;
    qryMainAdditions_5_amt: TFloatField;
    qryMainAdditions_5_Percent: TFloatField;
    qryMainBankInterest_5_amt: TFloatField;
    qryMainBankInterest_5_Percent: TFloatField;
    qryMainAmount_6: TFloatField;
    qryMainPercentage_6: TWideStringField;
    qryMainAdditions_6_amt: TFloatField;
    qryMainAdditions_6_Percent: TFloatField;
    qryMainBankInterest_6_amt: TFloatField;
    qryMainBankInterest_6_Percent: TFloatField;
    qryMainAmount_7: TFloatField;
    qryMainPercentage_7: TWideStringField;
    qryMainAdditions_7_amt: TFloatField;
    qryMainAdditions_7_Percent: TFloatField;
    qryMainBankInterest_7_amt: TFloatField;
    qryMainBankInterest_7_Percent: TFloatField;
    qryMainAmount_8: TFloatField;
    qryMainPercentage_8: TWideStringField;
    qryMainAdditions_8_amt: TFloatField;
    qryMainAdditions_8_Percent: TFloatField;
    qryMainBankInterest_8_amt: TFloatField;
    qryMainBankInterest_8_Percent: TFloatField;
    qryMainAmount_9: TFloatField;
    qryMainPercentage_9: TWideStringField;
    qryMainAdditions_9_amt: TFloatField;
    qryMainAdditions_9_Percent: TFloatField;
    qryMainBankInterest_9_amt: TFloatField;
    qryMainBankInterest_9_Percent: TFloatField;
    qryMainAmount_10: TFloatField;
    qryMainPercentage_10: TWideStringField;
    qryMainAdditions_10_amt: TFloatField;
    qryMainAdditions_10_Percent: TFloatField;
    qryMainBankInterest_10_amt: TFloatField;
    qryMainBankInterest_10_Percent: TFloatField;
    qryMainAmount_11: TFloatField;
    qryMainPercentage_11: TWideStringField;
    qryMainAdditions_11_amt: TFloatField;
    qryMainAdditions_11_Percent: TFloatField;
    qryMainBankInterest_11_amt: TFloatField;
    qryMainBankInterest_11_Percent: TFloatField;
    qryMainAmount_12: TFloatField;
    qryMainPercentage_12: TWideStringField;
    qryMainAdditions_12_amt: TFloatField;
    qryMainAdditions_12_Percent: TFloatField;
    qryMainBankInterest_12_amt: TFloatField;
    qryMainBankInterest_12_Percent: TFloatField;
    qryMainAmount_13: TFloatField;
    qryMainPercentage_13: TWideStringField;
    qryMainAdditions_13_amt: TFloatField;
    qryMainAdditions_13_Percent: TFloatField;
    qryMainBankInterest_13_amt: TFloatField;
    qryMainBankInterest_13_Percent: TFloatField;
    qryMainAmount_14: TFloatField;
    qryMainPercentage_14: TWideStringField;
    qryMainAdditions_14_amt: TFloatField;
    qryMainAdditions_14_Percent: TFloatField;
    qryMainBankInterest_14_amt: TFloatField;
    qryMainBankInterest_14_Percent: TFloatField;
    qryMainAmount_15: TFloatField;
    qryMainPercentage_15: TWideStringField;
    qryMainAdditions_15_amt: TFloatField;
    qryMainAdditions_15_Percent: TFloatField;
    qryMainBankInterest_15_amt: TFloatField;
    qryMainBankInterest_15_Percent: TFloatField;
    qryMainAmount_16: TFloatField;
    qryMainPercentage_16: TWideStringField;
    qryMainAdditions_16_amt: TFloatField;
    qryMainAdditions_16_Percent: TFloatField;
    qryMainBankInterest_16_amt: TFloatField;
    qryMainBankInterest_16_Percent: TFloatField;
    qryMainAmount_17: TFloatField;
    qryMainPercentage_17: TWideStringField;
    qryMainAdditions_17_amt: TFloatField;
    qryMainAdditions_17_Percent: TFloatField;
    qryMainBankInterest_17_amt: TFloatField;
    qryMainBankInterest_17_Percent: TFloatField;
    qryMainAmount_18: TFloatField;
    qryMainPercentage_18: TWideStringField;
    qryMainAdditions_18_amt: TFloatField;
    qryMainAdditions_18_Percent: TFloatField;
    qryMainBankInterest_18_amt: TFloatField;
    qryMainBankInterest_18_Percent: TFloatField;
    qryMainAmount_19: TFloatField;
    qryMainPercentage_19: TWideStringField;
    qryMainAdditions_19_amt: TFloatField;
    qryMainAdditions_19_Percent: TFloatField;
    qryMainBankInterest_19_amt: TFloatField;
    qryMainBankInterest_19_Percent: TFloatField;
    qryMainAmount_20: TFloatField;
    qryMainPercentage_20: TWideStringField;
    qryMainAdditions_20_amt: TFloatField;
    qryMainAdditions_20_Percent: TFloatField;
    qryMainBankInterest_20_amt: TFloatField;
    qryMainBankInterest_20_Percent: TFloatField;
    qryMainTotalAmount: TFloatField;
    qryMainFinalOrder: TIntegerField;
    qryMainAccountHeaderOrder: TWideStringField;
    qryMainAccountSub1Order: TWideStringField;
    qryMainAccountSub2Order: TWideStringField;
    qryMainAccountSub3Order: TWideStringField;
    qryMainHideTotal: TWideStringField;
    qryMainid: TIntegerField;
    btnCancel: TAdvGlowButton;
    AdvGlowButton1: TAdvGlowButton;
    DNMSpeedButton6: TDNMSpeedButton;
    pnlRequerytmr: TPanel;
    lblhint: TLabel;
    pbRequery: TAdvProgress;
    DNMPanel3: TDNMPanel;
    DNMSpeedButton7: TDNMSpeedButton;
    DNMSpeedButton8: TDNMSpeedButton;
    TmrProgressbar: TTimer;
    AdvTaskDialogEx1: TAdvTaskDialogEx;
    DNMSpeedButton9: TDNMSpeedButton;
    DNMSpeedButton10: TDNMSpeedButton;
    btnfloatcheck: TDNMSpeedButton;
    DNMSpeedButton11: TDNMSpeedButton;
    AdvGlowButton2: TAdvGlowButton;
    MyConnection1: TMyConnection;
    pnltop: TDNMPanel;
    pnlTitle1: TDNMPanel;
    TitleShader1: TShader;
    TitleLabel1: TLabel;
    AdvPanel1: TAdvPanel;
    Button1: TButton;
    procedure DNMSpeedButton4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DNMSpeedButton5Click(Sender: TObject);
    procedure DNMSpeedButton6Click(Sender: TObject);
    procedure DNMSpeedButton7Click(Sender: TObject);
    procedure DNMSpeedButton8Click(Sender: TObject);
    procedure TmrProgressbarTimer(Sender: TObject);
    procedure DNMSpeedButton9Click(Sender: TObject);
    procedure DNMSpeedButton10Click(Sender: TObject);
    procedure btnfloatcheckClick(Sender: TObject);
    procedure DNMSpeedButton11Click(Sender: TObject);
    procedure AdvGlowButton2Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    fNotepadHandle : HWND;
    fi:Integer;
  public
    { Public declarations }
  end;


implementation

uses BusObjClient, BusObjBase, AppEnvironment, CommonLib, CommonDbLib,
  BusObjProcPrefs, ERPErrorEmailUtils, LogLib , DateTimeUtils, ProductQtyLib,
  Registry, tcConst, busobjPQA, SystemLib, shellapi, CipherUtils;


{$R *.dfm}

procedure TfmDebug.AdvGlowButton2Click(Sender: TObject);
var
  Rec: TShellExecuteInfo;
const
  AVerb = 'open';
  AParams = '';
  AFileName ='i:\temp\to be deleted\test.bat';// 'Notepad.exe';
  ADir = '';
begin
if fi =0 then begin
  FillChar(Rec, SizeOf(Rec), #0);

  Rec.cbSize       := SizeOf(Rec);
  Rec.fMask        := SEE_MASK_NOCLOSEPROCESS;
  Rec.lpVerb       := PChar( AVerb );
  Rec.lpFile       := PChar( AfileName );
  Rec.lpParameters := PChar( AParams );
  Rec.lpDirectory  := PChar( Adir );
  Rec.nShow        := SW_SHOW;

  ShellExecuteEx(@Rec);
  WaitForInputIdle(Rec.hProcess, 5000);

  fNotepadHandle := Windows.FindWindow( 'i:\temp\to be deleted\test', nil );
  Windows.SetParent( fNotepadHandle, Handle );
  fi:= 1;

  Resize;
  ShowWindow(fNotepadHandle, SW_SHOW);
end else if fi = 1 then begin
  fNotepadHandle := Windows.FindWindow( 'i:\temp\to be deleted\test.bat', nil );
  Windows.SetParent( fNotepadHandle, Handle );
  fi:= fi+1;
  AdvGlowButton2.caption := inttostr(fi);
end else if fi = 2 then begin
  fNotepadHandle := Windows.FindWindow( 'test.bat', nil );
  Windows.SetParent( fNotepadHandle, Handle );
  fi:= fi+1 ;
  AdvGlowButton2.caption := inttostr(fi);
end else if fi = 3 then begin
  fNotepadHandle := Windows.FindWindow( 'test', nil );
  Windows.SetParent( fNotepadHandle, Handle );
  fi:= fi+1 ;
  AdvGlowButton2.caption := inttostr(fi);
end else if fi = 4 then begin
  fNotepadHandle := Windows.FindWindow( 'cmd', nil );
  Windows.SetParent( fNotepadHandle, Handle );
  fi:= fi+1 ;
  AdvGlowButton2.caption := inttostr(fi);
end;
end;

procedure TfmDebug.btnfloatcheckClick(Sender: TObject);
var
  index :Double;
  s1, s2, s3:String;
begin
  inherited;
  index := 9223372036854775000;
  while true do begin
    index := index +1 ;
    s1:= Floattostr(index) ;
    s2:= FloattostrF( index,ffGeneral,35,0);
    s3:= FormatFloat('###################################',index);
    btnfloatcheck.caption := (*s1 +'   -   ' + *)s3;
    btnfloatcheck.refresh;
    logtext(s1+',' +s2+',' +s3);
   (* if pos('E' , s1)>0 then begin logtext('cond - 1'); break; end;
    if pos('E', s2)>0 then begin logtext('cond - 2'); break; end;*)
    if length(s3)>40 then begin logtext('cond - 3'); break; end;
    if strtoFloat(s3)<> index then begin logtext('cond - 4'); break; end;
  end;

end;

procedure TfmDebug.Button1Click(Sender: TObject);
begin
  inherited;
  CipherUtils.Encrypt('U:\Packages\Prepare\erpserverdetails2.json', 'U:\Packages\Prepare\erpserverdetails2.dat');
end;

procedure TfmDebug.DNMSpeedButton10Click(Sender: TObject);
var
  ErrMsg:String;
begin
  inherited;
  TPQASN.ValidateSN('31016634-0201',0,4172,11, GetSharedMyDacConnection, False, ErrMsg, now);
  logtext(ErrMsg);
end;

procedure TfmDebug.DNMSpeedButton11Click(Sender: TObject);
begin
  clog('All');
  logtext(Searchfile('Bin\log\TrueERP_Mod_EDI_*.Log' , 'All'));
  logtext('====================================================');
  logtext('First');
  logtext(Searchfile('Bin\log\TrueERP_Mod_EDI_*.Log' , 'First'));
  logtext('====================================================');
  logtext('Last');
  logtext(Searchfile('Bin\log\TrueERP_Mod_EDI_*.Log' , 'Last'));
(*var
  Rec:TSearchRec;
  st:TStringlist;
begin
  inherited;
  st:= TStringlist.create;
  try
    st.Sorted:= True;
    if FindFirst (exedir + 'Bin\log\TrueERP_Mod_EDI_*.Log', faAnyFile - faDirectory, Rec) = 0 then begin
      try
      repeat
        st.Add(Rec.Name) ;
      until FindNext(Rec) <> 0;
      finally
        FindClose(Rec) ;
      end;
    end;
  finally
    clog(st.text);
    if st.count >0 then logtext(st[st.count-1]);
    Freeandnil(st);
  end;*)
end;

procedure TfmDebug.DNMSpeedButton4Click(Sender: TObject);
var
    Customer : TCustomer;
    DBMyDacDataConn : TMyDacDataConnection;
    DBConn :TERPConnection;
begin
  inherited;
  try
          //DBConn := TERPConnection.create(Self);
          DBMyDacDataConn :=TMyDAcDataconnection.Create(Nil);
          try
            DBConn :=GetNewMyDacConnection(Self ,'aus_sample_company');
            DBMyDacDataConn.Connection :=DBConn;

                Customer := TCustomer.Create(Nil);
                Try
                  try
                    Customer.connection := DBMyDacDataConn;
                    Customer.silentMode := True;
                    Customer.MakeClientFromCmpanyInfo(Appenv.CompanyInfo , True , False, False);
                    Customer.connection.CommitTransaction;
                  Except
                    on E:Exception do begin
                      Customer.connection.RollbackTransaction;
                      exit;
                    end;
                  end;
                finally
                  Freeandnil(Customer);
                end;
            Except
              on E:Exception do begin
                DBMyDacDataConn.RollbackTransaction;
              end;
            end;
        finally
           DBMyDacDataConn.Connection := nil;
           FreeandNil(DBConn);
           FreeandNil(DBMyDacDataConn);
        end;
end;
procedure TfmDebug.DNMSpeedButton5Click(Sender: TObject);
begin
  inherited;
(*  MyDump1.Connection:= GetSharedMyDacConnection;
  MyDump1.BackupToFile('d:\erp.log', 'Select * from tblparts limit 10' );*)


SendEmailtoErp('Progressbuild-SNMissing',
                  '    (Error Email Copied to the Employee Chosen :' +Quotedstr(ProcPrefs.PPErrorEmailTo) +')'+chr(13)+chr(13)+
                                                        '    Company     :' + Appenv.CompanyInfo.Companyname + chr(13) +
                                                        '    Server      :' + GetSharedMyDacConnection.Server + chr(13) +
                                                        '    Datase      :' + GetSharedMyDacConnection.Database ,
                                                        'emaillog', '', ProcPrefs.PPErrorEmailToEmail);
end;

procedure TfmDebug.DNMSpeedButton6Click(Sender: TObject);
const
  s='2018-11-12T12:50:19.000Z';
begin
  inherited;
clog(SalesAllocationTables);
Exit;
logtext(s);
try logtext('ISO8601ToDateTime : '          + Formatdatetime('dd-mm-yyyy hh:nn:ss:zzzz' , DateTimeUtils.ISO8601ToDateTime(s)));         except on E:Exception do begin logtext('Error in ISO8601ToDateTime : '        + E.message); end; end;
try logtext('RFC3339StrToDateTimeUTC : '    + Formatdatetime('dd-mm-yyyy hh:nn:ss:zzzz' , DateTimeUtils.RFC3339StrToDateTimeUTC(s)));   except on E:Exception do begin logtext('Error in RFC3339StrToDateTimeUTC : '  + E.message); end; end;
try logtext('RFC3339StrToDateTimeLocal : '  + Formatdatetime('dd-mm-yyyy hh:nn:ss:zzzz' , DateTimeUtils.RFC3339StrToDateTimeLocal(s))); except on E:Exception do begin logtext('Error in RFC3339StrToDateTimeLocal : '+ E.message); end; end;
try logtext('RFC3339StrToDateTime : '       + Formatdatetime('dd-mm-yyyy hh:nn:ss:zzzz' , DateTimeUtils.RFC3339StrToDateTime(s)));      except on E:Exception do begin logtext('Error in RFC3339StrToDateTime : '     + E.message); end; end;
try logtext('RFC2822StrToDateTime : '       + Formatdatetime('dd-mm-yyyy hh:nn:ss:zzzz' , DateTimeUtils.RFC2822StrToDateTime(s)));      except on E:Exception do begin logtext('Error in RFC2822StrToDateTime : '     + E.message); end; end;
Logtext('============================================================');
try logtext('utc : '       + Formatdatetime('dd-mm-yyyy hh:nn:ss:zzzz' , LocalToUTC(DateTimeUtils.ISO8601ToDateTime(s))));      except on E:Exception do begin logtext('Error in RFC2822StrToDateTime : '     + E.message); end; end;
try logtext('local : '       + Formatdatetime('dd-mm-yyyy hh:nn:ss:zzzz' , UTCToLocal(LocalToUTC(DateTimeUtils.ISO8601ToDateTime(s)))));      except on E:Exception do begin logtext('Error in RFC2822StrToDateTime : '     + E.message); end; end;

end;

procedure TfmDebug.DNMSpeedButton7Click(Sender: TObject);
const
  UNINST_PATH = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall';
var
  Registry: TRegistry;
  Keys: TStrings;
  Key: string;
  AppName: string;
  AppLookingFor: string;
  IsAppInstalled: Boolean;
begin
//{$APPTYPE CONSOLE}

  AppLookingFor := inputbox('application''s name you''re looking for: ','' , 'Excel');

  Registry := TRegistry.Create;
  Registry.RootKey := HKEY_LOCAL_MACHINE;
  if Registry.OpenKeyReadOnly(UNINST_PATH) then
  begin
    Keys := TStringList.Create;
    try
      Registry.GetKeyNames(Keys);
      Registry.CloseKey();
      clog('');
      for Key in Keys do
      begin
        if Registry.OpenKeyReadOnly(Format('%s\%s', [UNINST_PATH, Key])) then
        begin
          try
            AppName := Registry.ReadString('DisplayName');
            logtext(AppName);
            if not IsAppInstalled then IsAppInstalled := Pos(AnsiUpperCase(AppLookingFor), AnsiUpperCase(AppName)) > 0;
            //if IsAppInstalled then Break;
          finally
            Registry.CloseKey();
          end;
        end;
      end;
    finally
      Keys.Free();
    end;
    if IsAppInstalled then
      logtext(AppLookingFor + ' is installed!')
    else
      logtext(AppLookingFor + ' is unavailable or not installed!');

  end;
end;

procedure TfmDebug.DNMSpeedButton8Click(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  DoShowProgressbar(10, WaitMsg);
  DoStepProgressbar('Wait ... sleeping for 5 seconds');
  TmrProgressbar.enabled := true;
  for ctr := 1 to 3 do begin
    MessageDlgXP_vista('tesing msg on top of progressbar'+NL+
                        'tesing msg on top of progressbar'+NL+
                        'tesing msg on top of progressbar'+NL+
                        'tesing msg on top of progressbar', mtWarning, [mbOK], 0);
    sleep(2000);

  end;
  TmrProgressbar.enabled := False;
  DoHideProgressbar;
end;

procedure TfmDebug.DNMSpeedButton9Click(Sender: TObject);
begin
  inherited;
    MessageDlgXP_vista('tesing msg on top of progressbar'+NL+
                        'tesing msg on top of progressbar'+NL+
                        'tesing msg on top of progressbar'+NL+
                        'tesing msg on top of progressbar', mtWarning, [mbOK], 0);

end;

procedure TfmDebug.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
action := cafree;
MessageDlg('sadsada', mtWarning, [mbOK], 0);
end;

procedure TfmDebug.FormCreate(Sender: TObject);
begin
  inherited;
  fi:=0;
end;

procedure TfmDebug.FormResize(Sender: TObject);
begin
  inherited;
 if IsWindow(fNotepadHandle) then begin
    SetWindowPos(fNotepadHandle, 0, 0, 0, ClientWidth, ClientHeight,
      SWP_ASYNCWINDOWPOS);
  end;
end;

procedure TfmDebug.TmrProgressbarTimer(Sender: TObject);
begin
  inherited;
  DoStepProgressbar('progress step within timer');
end;

initialization
    RegisterClassOnce(TfmDebug);

end.
