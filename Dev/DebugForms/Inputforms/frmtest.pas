unit frmtest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, DADump, MyDump, DAScript, MyScript, DBCtrls, DNMSpeedButton, Mask,
  wwdbedit, DNMPanel, ProgressDialog;
const
  LANG_ARABIC = '00000401';
  LANG_ENGLISH = '00000409';

type
  Tfmtest = class(TBaseInputGUI)
    Button1: TButton;
    Label1: TLabel;
    Arabic: TButton;
    English: TButton;
    Edit1: TEdit;
    MyDump1: TMyDump;
    Button2: TButton;
    Button3: TButton;
    dbConn: TMyConnection;
    dbDump: TMyDump;
    Button4: TButton;
    Button5: TButton;
    Memo1: TMemo;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Button6: TButton;
    lblmsg: TLabel;
    Bevel4: TBevel;
    Button7: TButton;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Button8: TButton;
    MyDump2: TMyDump;
    ERPQuery1: TERPQuery;
    Button9: TButton;
    PME: TERPQuery;
    Edit2: TEdit;
    Button10: TButton;
    Button11: TButton;
    Edit3: TEdit;
    Memo2: TMemo;
    Button12: TButton;
    Button13: TButton;
    Memo3: TMemo;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    ERPScript1: TERPScript;
    Label2: TLabel;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    ERPQuery2: TERPQuery;
    procedure Button1Click(Sender: TObject);
    procedure ArabicClick(Sender: TObject);
    procedure EnglishClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure ERPScript1BeforeExecute(Sender: TObject; var SQL: string;
      var Omit: Boolean);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
  private
    Button16ctr:Integer;
    t1:TDateTime;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, CommonDbLib, tcConst, BusObjBase, BusObjStock, LogLib,
  AppEnvironment, IntegerListObj, IdCoderQuotedPrintable, FastFuncs, progressdialog,
  TextFileObj, dateutils, frmPartsFrm;

{$R *.dfm}

procedure Tfmtest.ArabicClick(Sender: TObject);
begin
  inherited;
  LoadKeyboardLayoutA(LANG_ARABIC,KLF_ACTIVATE);
  setcontrolfocus(edit1);
end;

procedure Tfmtest.Button10Click(Sender: TObject);
var
  stream: TFileStream;
  writer: TWriter;
  s:String;
  sbytes :TBytes;
  ctr:Integer;
  ws1:Widestring;
  as1:ansiString;
  uc1:unicodestring;
  x:Integer;
  s1:ansiString;
begin
  inherited;
  (*showmessage(edit2.text);
  showmessage(Widestring(edit2.text));
  showmessage(ansistring(edit2.text));
  exit;*)
  stream:= TFileStream.Create('COM3', fmCreate);
  writer:= TWriter.Create(Stream, 255);
  try
    s1:= '';
    for ctr := 128 to 256 do begin
      Writer.WriteStr(chr(ctr));
      s1 := s1 +chr(ctr);
    end;
    Writer.WriteStr(s1);
    exit;
(*  Writer.WriteStr(ansistring(edit2.text));
  exit;*)
  for ctr := 1 to char_length(edit2.text) do begin
    if integer(edit2.text[ctr]) > 1458 then begin
      Writer.WriteStr(chr(integer(edit2.text[ctr]) - 1458));
      Memo2.Lines.add(inttostr(integer(edit2.text[ctr]) - 1458)+':' + chr(integer(edit2.text[ctr]) - 1458));
    end else begin
      Writer.WriteStr(edit2.text[ctr]);
      Memo2.Lines.add(inttostr(integer(edit2.text[ctr]))+':' +edit2.text[ctr]);
    end;
  end;

  Memo2.lines.clear;
  ws1:='binny';
  as1:='binny';
  uc1:='binny';
  Memo2.Lines.add('Code Page:' +inttostr(stringcodePage(edit2.text)));
  Memo2.Lines.add('Wide.Code Page:' +inttostr(stringcodePage(ws1)));
  Memo2.Lines.add('ansi.Code Page:' +inttostr(stringcodePage(as1)));
  Memo2.Lines.add('unicode.Code Page:' +inttostr(stringcodePage(uc1)));
  Memo2.Lines.add('size of:'+ inttostr(SizeOf(edit2.text)));
  Memo2.Lines.add('string element sixe:'+ inttostr(stringelementsize(edit2.text)));
  Memo2.Lines.add('length:'+ inttostr(char_length(edit2.text)));
  s:=edit2.text;
  for ctr := 0 to char_length(edit2.text) do begin
    sbytes := bytesof(edit2.text[ctr]);
    Memo2.lines.add(edit2.text[ctr]);
    for x := low(sbytes) to high(sbytes) do begin
      memo2.lines.add('     ' + inttostr(integer(sbytes[x])));
    end;
  end;
  Memo2.lines.add('=========================');
  sbytes := bytesof(s);
  for ctr := low(sbytes) to high(sbytes) do begin
    memo2.lines.add(s[ctr]+':' +inttostr(integer(sbytes[ctr]))+ ':' +chr(sbytes[ctr]));
  end;

  exit;

    Writer.WriteString(Widestring(edit2.text));
    (*Writer.WriteUTF8Str(chr(13));
    Writer.WriteWideString(ansistring(edit2.text));*)

(*    Writer.WriteWideString(chr(254));
    Writer.WriteWideString(chr(253));
    Writer.WriteWideString(chr(252));
    Writer.WriteWideString(chr(251));
    Writer.WriteWideString(chr(250));
    Writer.WriteWideString(chr(249));*)
  finally
    writer.Free;
    stream.Free;
  end;

end;

procedure Tfmtest.Button11Click(Sender: TObject);
var
  ctr:Integer;
  x:Byte;
  s:String;
begin
  inherited;
  edit3.text := '';
  for ctr := 1 to char_length(edit2.text) do begin
    x:= ord(edit2.text[ctr]);
    s:= IntToHex(integer(x), 3);
    edit3.text:= edit3.text + '[' + edit2.text[ctr] +':' +s+']';
  end;
end;

procedure Tfmtest.Button12Click(Sender: TObject);
var
  TempList:TStringlist;
  SQLList:TStringlist;
  xfieldList:TStringlist;
  ctr:Integer;
  s:STring;
  fielddesc:String;
const
  varchar   ='VARCHAR';
  char   ='CHAR';
  text      ='TEXT';
  tinytext  ='TINYTEXT';
  mediumtext='MEDIUMTEXT';
  logntext  ='LONGTEXT';
  function readfielddesc(const fieldname:STring):String;
  var
    i:Integer;
  begin
    result := '';
    for i := 0 to xfieldList.count-1 do begin
      if (pos('`' +uppercase(FieldName) +'`' ,uppercase(trim(xfieldList.strings[i]))) <>0) or
        (pos(uppercase(FieldName+' '),uppercase(trim(xfieldList.strings[i]))) = 1) then begin
          result :=xfieldList.strings[i];
          exit;
        end;
    end;
  end;
  function collation:String;
  var
    i:Integer;
    s1:String;
  begin
    result := '';
    s1:=uppercase(FieldDesc);
    i:= pos(uppercase(' COLLATE ')  , s1);
    if i>0 then
      s1:= Trim(copy(s1,i+9 , char_length(s1)));
      i:= pos(' ', s1); if i = 0 then i:= pos(',', s1); if i = 0 then i:= char_length(s1);
      if i > 0 then s1:= copy(s1,1,i);
      result := s1;
  end;
begin
  inherited;
  TempList := TStringlist.create;
  SQLList := TStringlist.create;
  try
    CommonDbLib.GetSharedMyDacConnection.GetTableNames(TempList);
    if TempList.count =0 then exit;
    for ctr := 0 to TempList.count-1 do begin
      With TProgressDialog.NewProgressbar(WAITMSG , TempList.count,1,1) do try
        With TempMyQuery do try
          (*if (Pos(uppercase(Trim(GetTemporaryTableNameSuffix)),uppercase(TempList.Strings[ctr])) <> 0) then
          else if Pos(uppercase('tmp_'),uppercase(TempList.Strings[ctr])) <> 0 then
          else if Pos(uppercase('erpfix'),uppercase(TempList.Strings[ctr])) <> 0 then
          else if Pos(uppercase('erpfic'),uppercase(TempList.Strings[ctr])) <> 0 then
          else if pos(uppercase('debuglog') ,uppercase(TempList.Strings[ctr]))<>0 then
          else if pos(uppercase('inenglish') ,uppercase(TempList.Strings[ctr]))<>0 then
          else if pos(uppercase('erp_redundant_tbl') ,uppercase(TempList.Strings[ctr]))<>0 then
          else if pos(uppercase('vinvoicefooterpref') ,uppercase(TempList.Strings[ctr]))<>0 then
          else if pos(uppercase('vxaxiscombonamepref') ,uppercase(TempList.Strings[ctr]))<>0 then
          else if pos(uppercase('debuglogdetails') ,uppercase(TempList.Strings[ctr]))<>0 then
          else*)
          IF ((pos(uppercase('tmp_') ,uppercase(TempList.Strings[ctr]))<>1) and (pos(uppercase('`tmp_') ,uppercase(TempList.Strings[ctr]))<>1)) AND
              ((pos(uppercase('tbl') ,uppercase(TempList.Strings[ctr]))<>1) and (pos(uppercase('`tbl') ,uppercase(TempList.Strings[ctr]))<>1)) THEN
          (*if (pos(uppercase('tbl') ,uppercase(TempList.Strings[ctr]))<>1) and (pos(uppercase('`tbl') ,uppercase(TempList.Strings[ctr]))<>1) then*)
          (*if (pos(uppercase('tmp_') ,uppercase(TempList.Strings[ctr]))<>1) and (pos(uppercase('`tmp_') ,uppercase(TempList.Strings[ctr]))<>1) then*)
          else if pos(uppercase('tblbusobjfilter') ,uppercase(TempList.Strings[ctr]))<>0 then
          else begin
            SQL.add('show create table ' +TempList[ctr]);
            open;
            xfieldList:= tStringlist.create;
            try
              FastFuncs.Split(Fields[1].AsString , chr(10), xfieldList);
              if active then close;
              SQL.clear;
              SQl.add('DESCRIBE ' +TempList[ctr]);
              open;
              if recordcount > 0  then begin
                First;
                While Eof = False do begin
                  s:= uppercase(Fields[1].asString);
                  (*if (Pos(varchar,s) =1) or (Pos(text,s) =1) or (Pos(tinytext,s) =1) or (Pos(mediumtext,s) =1) or (Pos(logntext,s) =1) then*)
                  if (Pos(char,s) =1) then
                    if Fields[0].asString <> '' then begin
                      fielddesc:= readfielddesc(Fields[0].asString);
                      if pos(' COLLATE ' ,fielddesc)= 0 then begin
                        s:= fieldDesc ;
                        if copy(s, char_length(s),1) = ',' then s:=copy(s, 1,char_length(s)-1);
                        s:= s + ' COLLATE utf8_general_ci ';
                      end else s:= replacestr(fielddesc , collation, 'utf8_general_ci');
                      SQLList.add('ALTER TABLE `'+   TempList[ctr]+'` CHANGE COLUMN `' +  Fields[0].asString+ '` '+s+';');
                    end;
                  Next;
                end;
                //SQLList.add('ALTER TABLE `'+   TempList[ctr]+'`  COLLATE='+Quotedstr('utf8_general_ci')+';');
              end;
            finally
              Freeandnil(xfieldList);
            end;
          end;
        finally
          if active then close;
          Free;
        end;
        StepIt;
      finally
        Free;
      end;
    end;
  finally
    SQLlist.SaveTofile('c:\temp\1.SQL');
    FreeandNil(TempList);
    FreeandNil(SQLList);
  end;
end;

procedure Tfmtest.Button13Click(Sender: TObject);
var
  stream: TFileStream;
  writer: TStreamWriter;
  Reader :TStreamReader;
  s:String;
begin
  inherited;
  stream:= TFileStream.Create('C:\temp\tb\erp.txt', fmCreate);
  try
    writer:= TStreamWriter.Create(stream);
    Writer.writeline(Edit2.text);
    Writer.writeline(Edit1.text);
    Writer.writeline(Edit3.text);
    Writer.writeline(Memo1.Lines.text);
  finally
    writer.Free;
    stream.Free;
  end;

  stream:= TFileStream.Create('C:\temp\tb\erp.txt', fmOpenRead);
  try
    Reader:= TStreamReader.Create(stream);
    Memo3.lines.clear;
    While not REader.EndOfStream do begin
      s:= REader.REadline;
      Memo3.lines.add(s);
    end;
  finally
    writer.Free;
    stream.Free;
  end;
end;

procedure Tfmtest.Button14Click(Sender: TObject);
var
  TF: TTextfile;
begin
  inherited;
  TF:= TTextfile.create('c:\temp\tb\erp.text' , tfmCreate);
  try
    TF.WriteLine('Dene Mills :' +']ثىث ’هممس ');
    TF.WriteLine('Maureen Poppins : ' +'’شعقثثى حخححهىس ');
    TF.WriteLine('Ian Blakeley : ' +' لاهىىغ ٍشته ');
    TF.WriteLine('Binny Jacob : ' +'هثشى لامشنثمثغ');
    TF.WriteLine('Erp Software : ' +' ُقح ٍخبفصشقث ');
    TF.WriteLine('6/183, Currumburra Road: ' +' 6ظ183 }عققعةلاعققش ٌخشي ');
    TF.WriteLine('Ashomore : ' +' ِساخةخقث');
    TF.WriteLine('Gold Coast : ' +' لخمي }خشسف');
    TF.WriteLine('Queensland : ' +' َعثثىسمشىي');
    TF.WriteLine('Australia: ' +' شعسفقشمهش');
  finally
    Freeandnil(TF);
  end;
end;

procedure Tfmtest.Button15Click(Sender: TObject);
var
  TF: TTextfile;
begin
  inherited;
  TF:= TTextfile.create('c:\temp\tb\erp.text' , tfmOpenRead);
  memo3.lines.clear;
  try
    While not TF.EOF do begin
      Memo3.Lines.Add(TF.Readline);
    end;
  finally
    Freeandnil(TF);
  end;
end;

procedure Tfmtest.Button16Click(Sender: TObject);
var
  tt:Tdatetime;
begin
  inherited;
  tt:= now;
  t1:= now;
  Memo1.Lines.clear;
  screen.Cursor := crHourglass;
  try
    Button16ctr:= 0;
    ERPScript1.execute;
  finally
    Screen.cursor := crDefault;;
    button16.caption := inttostr(dateutils.SecondsBetween(tt,now))+ '(s) = ' +inttostr(MinutesBetween(tt, now))+ '(m)';
  end;
  Memo1.Lines.Savetofile('c:\temp\1.txt');
end;

procedure Tfmtest.Button17Click(Sender: TObject);
begin
  inherited;
  ERPScript1.beforeexecute:= nil;
  Button16Click(Button17);
end;

procedure Tfmtest.Button18Click(Sender: TObject);
var
TempList : TStringlist;
ctr:Integer;
s:String;
begin
  inherited;
  TempList := TStringlist.create;
  try
    CommonDbLib.GetSharedMyDacConnection.GetTableNames(TempList);
    if TempList.count =0 then exit;
    s:= '';
    for ctr := 0 to TempList.count-1 do begin
      if ((pos(uppercase('erp') ,uppercase(TempList.Strings[ctr]))=1) or (pos(uppercase('`erp') ,uppercase(TempList.Strings[ctr]))=1)) then
        s:= s +chr(13) +TempList.Strings[ctr];

    end;
    Logtext(s);
  finally

  end;
end;

procedure Tfmtest.Button19Click(Sender: TObject);
var
  dt:TDatetime;
begin
  inherited;
  With commondblib.TempMyQuery do try
    SQL.add('Select * from tblParts limit 10');
    open;
    Close;
    SQL.Clear;
    SQL.add(memo3.lines.text);
    Options.DefaultValues:= False;
    Button19.caption := FormatDateTime('dd-mm-yyyy  hh:nn' , now);
    Button19.refresh;
    dt:= now;
    open;
    Button19.caption := inttostr(secondsbetween(now, dt));
    Button19.refresh;
  finally
    Free;
  end;
end;

procedure Tfmtest.Button1Click(Sender: TObject);
var
  ID: LangID;
  Language: array [0..100] of char;
begin
  ID := GetSystemDefaultLangID;
  VerLanguageName(ID, Language, 100);
  Label1.Caption := String(Language);
end;
procedure Tfmtest.Button2Click(Sender: TObject);
begin
  inherited;
  MyDump1.Connection := commondblib.GetNewERPLanguageConnection(self);
  MyDump1.Connection.connected:= False;
  MyDump1.Connection.options.useunicode:= False;
  MyDump1.Connection.options.charset := 'utf8';
  MyDump1.Connection.connect;
  MyDump1.tablenames:= 'languagetranslation,InEnglish,Languages';
  MyDump1.BackupToFile('c:\temp\2.txt' );
  exit;

  MyDump1.BackupToFile('c:\temp\2.txt' , 'Select * from languagetranslation where ifnull(Translation,"" )<> ""' );
  MyDump1.BackupToFile('c:\temp\1.txt' , 'Select * from languagetranslation where ifnull(Translation,"" )<> ""' );
  MyDump1.Connection.connected:= False;
  MyDump1.Connection.options.useunicode:= False;
  MyDump1.Connection.connect;
  MyDump1.BackupToFile('c:\temp\2.txt' , 'Select * from languagetranslation where ifnull(Translation,"" )<> ""' );
  MyDump1.Connection.connected:= False;
  MyDump1.Connection.options.charset := 'utf8';
  MyDump1.Connection.connect;
  MyDump1.BackupToFile('c:\temp\3.txt' , 'Select * from languagetranslation where ifnull(Translation,"" )<> ""' );
  MyDump1.Connection.connected:= False;
  MyDump1.Connection.options.useunicode:= true;
  MyDump1.Connection.connect;
  MyDump1.BackupToFile('c:\temp\4.txt' , 'Select * from languagetranslation where ifnull(Translation,"" )<> ""' );


end;

procedure Tfmtest.Button3Click(Sender: TObject);
begin
  inherited;
  dbConn.Port:= 3309;
  dbConn.Database:= 'ERPLanguages';
  dbConn.Username:= 'P_One';
  dbConn.Password:= '1w$p&LD07';
  dbConn.Server:= 'localhost';
  dbConn.LoginPrompt:= false;
  dbConn.Options.UseUnicode:= false;
  dbConn.Options.Charset:= 'utf8';
  dbConn.Connect;
  dbDump.Connection:= dbConn;
  dbDump.TableNames:= 'inenglish,languages,languagetranslation';
  dbDump.Options.AddDrop:= false;
  dbDump.Options.GenerateHeader:= false;
  dbDump.Options.AddLock:= false;
  dbDump.Options.CompleteInsert:= true;
  dbDump.Objects:= [doData];
  dbDump.BackupToFile('c:\temp\language.sql');
end;

procedure Tfmtest.Button4Click(Sender: TObject);
begin
  inherited;

  dbDump.Connection := commondblib.GetNewERPLanguageConnection(self);
  dbDump.Connection.connected:= False;
  dbDump.Connection.options.useunicode:= False;
  dbDump.Connection.options.charset := 'utf8';
  dbDump.Connection.connect;
  dbDump.tablenames:= 'languagetranslation,InEnglish,Languages';
  dbDump.BackupToFile('c:\temp\Language.SQL' );
  dbDump.Connection:= dbConn;
  dbDump.TableNames:= 'inenglish,languages,languagetranslation';
end;

procedure Tfmtest.Button5Click(Sender: TObject);
begin
  inherited;
  memo1.clear;
  memo1.lines.add('Port:' + intToStr(dbConn.Port) +'   ' +intToStr(TMyConnection(MyDump1.Connection).Port));
  memo1.lines.add('database:' + (dbConn.Database) +'   ' +(TMyConnection(MyDump1.Connection).Database));
  memo1.lines.add('username:' + (dbConn.Username) +'   ' +(TMyConnection(MyDump1.Connection).Username));
  memo1.lines.add('password:' + (dbConn.Password) +'   ' +(TMyConnection(MyDump1.Connection).Password));
  memo1.lines.add('server:' + (dbConn.Server) +'   ' +(TMyConnection(MyDump1.Connection).Server));
  memo1.lines.add('loginprompt:' + booltostr(dbConn.LoginPrompt) +'   ' +booltostr(TMyConnection(MyDump1.Connection).LoginPrompt));
  memo1.lines.add('useunicode:' + booltostr(dbConn.Options.UseUnicode) +'   ' +booltostr(TMyConnection(MyDump1.Connection).Options.UseUnicode));
  memo1.lines.add('charset:' + (dbConn.Options.Charset) +'   ' +(TMyConnection(MyDump1.Connection).Options.Charset));
  memo1.lines.add('cpmpress:' + booltostr(dbConn.Options.Compress) +'   ' +booltostr(TMyConnection(MyDump1.Connection).Options.Compress));
 // memo1.lines.add('protocol:' + (dbConn.Options.Protocol) +'   ' +(TMyConnection(MyDump1.Connection).Options.Protocol));

end;

procedure Tfmtest.Button6Click(Sender: TObject);
var
  Product :TProduct;
  ctr:Integer;
begin
  inherited;
  for ctr := 1 to 340000 do begin
    Product := TProduct.Create(Self) ;
    try
      Product.Connection := TMydacDataconnection.create(Product);
      Product.Connection.connection := commondblib.GetNewMyDacConnection(Product);
      Product.load(0);
      Product.connection.begintransaction;
      try
        Product.New;
        Product.ProductType:= 'INV';
        Product.ProductName := 'Inv ' +intToStr(ctr);
        Product.BuyQty1 := 1;
        Product.BuyQty2 := 1;
        Product.BuyQty3 := 1;
        Product.BuyQty1Cost:= ctr mod 100;
        if Product.BuyQty1Cost =0 then Product.BuyQty1Cost := 1;
        Product.BuyQty2Cost:= Product.BuyQty1Cost;
        Product.BuyQty3Cost:= Product.BuyQty1Cost;
        Product.SellQty1:= 1;
        Product.SellQty2:= 1;
        Product.SellQty3:= 1;
        Product.SellQty1Price :=Product.BuyQty1Cost*2;
        Product.SellQty2Price :=Product.BuyQty1Cost*2;
        Product.SellQty3Price :=Product.BuyQty1Cost*2;
        Product.Postdb;
        Product.Save;
      Except
            on E:Exception do begin
               Product.connection.rollbacktransaction;
            end;
      end;

    finally
      Freeandnil(Product);
    end;
  end;

end;

procedure Tfmtest.Button7Click(Sender: TObject);
var
  s, s1:String;
  ds1, ds2:TMyQuery;
begin
  inherited;
  clog('/* Database :' + Appenv.AppDb.Server+'.' +Appenv.AppDb.Database+'*/' );
  ds1:= TempMyQuery;
  try
    ds1.SQL.add('show tables');
    ds1.open;
    if ds1.recordcount = 0 then exit;
    ds1.first;
    while ds1.eof = False do begin
      s:= ds1.fields[0].asString;
      try
        if s= '' then continue;
        ds2:= TempMyQuery;
        try
          ds2.SQL.add('show create table ' +s);
          ds2.open;
          if ds2.recordcount = 0 then continue;
          s1:=ds2.fields[1].asstring ;
          if pos(' set(' , s1) = 0 then continue;
          LogText(s +':' + s1);
        finally
          ds2.close;
          freeandnil(ds2);
        end;
      finally
        ds1.Next;
      end;
    end;
  finally
    ds1.close;
    freeandNil(ds1);
  end;
end;

procedure Tfmtest.Button8Click(Sender: TObject);
begin
  inherited;
  MyDump2.connection := MyConnection;
  MyDump2.BackupToFile('c:\temp\1.SQL');
  ERPQuery1.SQL.clear;
  ERPQuery1.connection := MyConnection;
  ERPQuery1.SQL.loadFromfile('c:\temp\1.SQL');
  ERPQuery1.Execute;
end;

procedure Tfmtest.EnglishClick(Sender: TObject);
begin
  inherited;
  LoadKeyboardLayoutA(LANG_ENGLISH,KLF_ACTIVATE);
  setcontrolfocus(edit1);
end;

procedure Tfmtest.ERPScript1BeforeExecute(Sender: TObject; var SQL: string;
  var Omit: Boolean);
begin
  inherited;
  Button16ctr := Button16ctr +1;
  Button16.caption := inttostr(Button16ctr) +' of ' + inttostr(ERPScript1.SQL.count);
  Button16.refresh;
  label2.caption := SQl;
  Label2.refresh;
  Memo1.Lines.Add(inttostr(secondsBetween(t1,now))+' :' +SQL);
  t1:= now;
end;

initialization
  RegisterClassOnce(Tfmtest);

end.
