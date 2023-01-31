unit LanguageTranslationObj;

interface
{$I ERP.inc}
uses
  ComCtrls, db,DNMAction, DNMSpeedButton, Classes, ERPdbComponents, StdCtrls, graphics,
  forms, frmBase, menus, ProgressDialog ,  DNMPanel, daScript, sysutils , ExtCtrls,AdvGrid,wwcheckbox , wwradiogroup, customInputBox, ImageDLLLib;

const
  RegionalLanguageClasses : array[1..17] of TPersistentClass = (TLabel, TDNMSpeedbutton, tdnmaction ,TField, ttabsheet, tform, TMenuItem, TProgressDialog, TCustomInputBox, TDNMPanel,TToolButton,TRadioGroup,TCheckbox,TAdvStringGrid,TwwCheckbox , TwwRadioGroup, TERPMainSwitchButton);
  TransDelim = '~|~';

type
  pLc = ^TLanguageComponent;
  TLanguageComponent = record
    LCName:String;
    LCType: String;
    LChint:String;
    LCCaption:String;
    LcfontName:String;
    LCfontsize:Integer;
    LcfontStyle:TfontStyles;
    LCItemIndex:Integer;
  end;


  TLanguageTranslationObj = class(TObject)
    private
      fTranslateQuery:TERPQuery;
      LanguageId:Integer;
      Languagefont:TFont;
      fbIsERPRunning: boolean;
      Qryl, qrye:TERPQuery;
      fConLanguage: TERPConnection;
      fiUserLanguageID: Integer;
      function LcList(Form:Tcomponent):TList;
      Procedure CreateLCList(form:TComponent);
      function TranslateQuery: TERPQuery;
      function normalfont(comp: Tcomponent): Boolean;
      Function Languages: TERPQuery;
      Function Inenglish: TERPQuery;
      function ConLanguage: TERPConnection ;
      function getEnglishID(InEnglish: String): Integer;
      function getLanguageID(Language: String): Integer;
      procedure stepProgressbar(Sender: TObject; var SQL: String; var Omit: Boolean);
      procedure ScriptError(Sender: TObject; E: Exception; SQL: string;      var Action: TErrorAction);
      procedure ScriptExecute(Sender: TObject; SQL: string);
      Procedure CreatelanguageDB;
      procedure Createlanguages(qry: TERPQuery);
      procedure CreateInEnglish(qry: TERPQuery);
      procedure Createlanguagetranslation(qry: TERPQuery);
      procedure CreatelanguagetranslationLocal(qry: TERPQuery);
      Procedure CreateHelpTreeUrl(qry: TERPQuery);
      procedure setUserLanguageID(const Value: Integer);
      Function LanguageName(LanguageID:Integer):String;
      function getUserLanguage_EnglishWhenBlank_Id: Integer;

(*      function LanguageCodes:String;
      Function DialectLangIds:String;*)
    protected
    public
      constructor Create;
      destructor Destroy; override;
      function Translation(const Value:String;LanguageID:Integer;charstoIgnore :Array of char):String;Overload;
      Procedure Translatecomp(fcomp :Tcomponent);
      Procedure DoTranslate(Form :TComponent ; UserLanguageID:Integer); overload;
      Procedure DoTranslate(ds:TDataset ; UserLanguageID:Integer); overload;
      function  DoTranslate(const Value:String;LanguageID:Integer ; const Args: array of string): String; overload;
      function  DoTranslateToEnglish(const Value:String):String;
      procedure TranslateGrids(sourceform: Tform);
      Function  LcItem(Form:Tcomponent;Comp:TComponent):pLc;
      Procedure LoadAllEntriesforLanguage(LanguageID:Integer);
      procedure CleanLc(form: TComponent);
      Procedure AddLcItem(form: TComponent; Sender:Tcomponent;Value:String);
      Procedure FreeLcList(form:TComponent);
      Property UserLanguageID:Integer read fiUserLanguageID write setUserLanguageID;
      Property IsERPRunning :boolean read fbIsERPRunning write fbIsERPRunning ;
      Procedure ChangeLanguage(menuItem :TMenuItem);
      function ExportModified(filename:String; LangID:Integer):Boolean;
      Procedure AllSynchronized(LangID:Integer);
      Function  Doimport(fileName:String):Boolean;
      Procedure DoimportText(fileName:String);
      function REadforminenglish(Form:Tcomponent):String;
      class function Inst: TLanguageTranslationObj;
      class function SafeInst: TLanguageTranslationObj;
      Property UserLanguage_EnglishWhenBlank_Id : Integer read getUserLanguage_EnglishWhenBlank_Id;
  end;

  procedure StrTofont(fFont:TFont ; sfont:String);

var
  fLanguageTranslationObj: TLanguageTranslationObj;

implementation

uses CommonDbLib, Dialogs ,  AppEnvironment, dmMainGUI, CommonLib,
  DNMLib, BaseGUIDatamodule, AddinPackageInfoObj, PackageControl, MAIN,
  JSONObject, FastFuncs, windows, TextFileObj, GridFieldsObj ,Wwdbgrid, LogLib,
  ERPLib;

const
  SQLSearch = 'Select  L.Id, L.DialectLangId,  IE.InEnglish,LT.Translation ' +
                ' from ' +
                ' Languages L ' +
                ' Left join (LanguageTranslation LT ' +
                ' inner join inEnglish IE  on IE.ID = LT.EnglishID and IE.InEnglish = :InEnglish ) on LT.LanguageID = L.ID ' +
                ' where L.Id= :LanguageID ';
 { TLanguageTranslationObj }

class function TLanguageTranslationObj.Inst: TLanguageTranslationObj;
begin
  if not Assigned(fLanguageTranslationObj) then
    fLanguageTranslationObj:= TLanguageTranslationObj.Create;
  result:= fLanguageTranslationObj;
end;


constructor TLanguageTranslationObj.Create;
begin
  inherited;
  Qryl:= nil;
  qrye:= nil;
  fConLanguage := nil;
  fTranslateQuery:= nil;
//  LanguageID := appenv.RegionalOptions.LanguageId;
  Languagefont:= Tfont.create;
  fiUserLanguageId:=0;
  fbIsERPRunning:= False;
  CreateLanguageDB;
end;

procedure TLanguageTranslationObj.CreateHelpTreeUrl(qry: TERPQuery);
begin
  With Qry do begin
    SQL.clear;
    SQL.add('SHOW TABLES LIKE "helptreeurls"');
    open;
    if recordcount = 0 then begin
      SQl.clear;
      SQL.add('CREATE TABLE `helptreeurls` ( ' +
               ' `ID` int(11) NOT NULL AUTO_INCREMENT, ' +
               '   `ParentId` int(11) DEFAULT 0, ' +
               '   `Caption` varchar(255) DEFAULT NULL, ' +
               '   `ContextId` int(11) DEFAULT NULL, ' +
               '   `URL` varchar(255) DEFAULT NULL, ' +
               '   `erphelpdocName` VARCHAR(255) NULL DEFAULT NULL, ' +
               '   `VideoCaption` VARCHAR(255) NULL DEFAULT NULL, ' +
               '   `VideoType` ENUM("vtNone","vtTraining","vtTask") NULL DEFAULT "vtNone", ' +
               '   `VideoID` INT(11) NULL DEFAULT NULL, ' +
               '   `UpdateTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, ' +
               '   PRIMARY KEY (`ID`), ' +
               '   KEY `ParentIdx` (`ParentId`) ' +
               ' ) ENGINE=MyISAM ;');
(*      SQL.add('insert into helptreeurls (id, parentID, Caption , ContextId ,URL ) Values ' +
                    '(1, 0 , "ERP" , 0 , "http://www.trueerp.com/wiki");');*)
      Execute;
    end;

    SQL.clear;
    SQL.add('SHOW TABLES LIKE "helptreeurlslocal"');
    open;
    if recordcount = 0 then begin
      SQl.clear;
      SQL.add('CREATE TABLE `helptreeurlslocal` ( ' +
               ' `ID` int(11) NOT NULL AUTO_INCREMENT, ' +
               '   `ParentId` int(11) DEFAULT 0, ' +
               '   `Caption` varchar(255) DEFAULT NULL, ' +
               '   `ContextId` int(11) DEFAULT NULL, ' +
               '   `URL` varchar(255) DEFAULT NULL, ' +
               '   `erphelpdocName` VARCHAR(255) NULL DEFAULT NULL, ' +
               '   `VideoCaption` VARCHAR(255) NULL DEFAULT NULL, ' +
               '   `VideoType` ENUM("vtNone","vtTraining","vtTask") NULL DEFAULT "vtNone", ' +
               '   `VideoID` INT(11) NULL DEFAULT NULL, ' +
               '   `UpdateTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, ' +
               '   PRIMARY KEY (`ID`), ' +
               '   KEY `ParentIdx` (`ParentId`) ' +
               ' ) ENGINE=MyISAM ;');
      Execute;
    end;
  end;
end;

procedure TLanguageTranslationObj.CreatelanguageDB;
var
  qry: TERPQuery;
begin
  qry:=  commondblib.TempMyQuery;
  try
    Qry.connection := ConLanguage;
    Createlanguages(Qry);
    CreateInEnglish(Qry);
    Createlanguagetranslation(Qry);
    Createlanguagetranslationlocal(Qry);
    CreateHelpTreeUrl(Qry)
  finally
    Qry.Free;
  end;
end;
procedure TLanguageTranslationObj.Createlanguages(qry: TERPQuery);
var
  S:String;
begin
  With Qry do begin
    SQL.clear;
    SQL.add('SHOW TABLES LIKE "languages"');
    open;
    s:= '';
    if recordcount = 0 then begin
        s:= 'CREATE TABLE `languages` ( ' +
                    '  `ID` int(10) NOT NULL AUTO_INCREMENT, ' +
                    '  `Language` varchar(50) DEFAULT NULL, ' +
                    '  `LanguageIdentifier` varchar(100) DEFAULT NULL, ' +
                    '  `Languagefont` varchar(255) DEFAULT NULL, ' +
                    '  `Active` enum("T","F") DEFAULT "T", ' +
                    '  `LanguageCode` varchar(10) DEFAULT NULL, ' +
                    '  `DialectLangId` int(11) DEFAULT NULL, ' +
                    '  PRIMARY KEY (`ID`), ' +
                    '  UNIQUE KEY `Language` (`Language`) ' +
                    ') ENGINE=MyISAM DEFAULT CHARSET=utf8;' +chr(13) +
              ' insert into languages (LanguageIdentifier, Language , Active , LanguageFont) Values ' +
                    '("00000409","English","T", "Arial;9;[fsBold]");';
    end else begin
(*      SQL.clear;
      SQL.add('desc  languages');
      open;
      if not Locate('Field' , 'LanguageCode' , []) then begin
        s:= 'alter table  languages add column   `LanguageCode` varchar(10) DEFAULT NULL;'+
                LanguageCodes;
      end;
      if not Locate('Field' , 'DialectLangId' , []) then begin
        s:= s+ 'alter table  languages add column   `DialectLangId` int(11) DEFAULT NULL;'+
          DialectLangIds;
      end;*)
    end;
    if s<> '' then begin
        SQL.clear;
        SQL.add(s);
        execute;
    end;
  end;
end;
procedure TLanguageTranslationObj.Createlanguagetranslation(qry: TERPQuery);
begin
 With Qry do begin
    SQL.clear;
    SQL.add('SHOW TABLES LIKE "languagetranslation"');
    open;
    if recordcount = 0 then begin
      SQl.clear;
      SQL.add('CREATE TABLE  IF NOT EXISTS  `languagetranslation` ( '+
                ' `ID` int(10) NOT NULL AUTO_INCREMENT, '+
                ' `LanguageID` int(10) NOT NULL, '+
                ' `EnglishID` int(10) NOT NULL, '+
                ' `Translation` varchar(255) , '+
                '  PRIMARY KEY (`ID`), '+
                '  UNIQUE KEY `UniqueIdx` (`LanguageID`,`EnglishID`)) ;');
      Execute;
    end;
  end;
end;
procedure TLanguageTranslationObj.Createlanguagetranslationlocal(qry: TERPQuery);
begin
 With Qry do begin
    SQL.clear;
    SQL.add('SHOW TABLES LIKE "languagetranslationlocal"');
    open;
    if recordcount = 0 then begin
      SQl.clear;
      SQL.add('CREATE TABLE  IF NOT EXISTS  `languagetranslationlocal` ( '+
                ' `ID` int(10) NOT NULL AUTO_INCREMENT, '+
                ' `LanguageID` int(10) NOT NULL, '+
                ' `EnglishID` int(10) NOT NULL, '+
                ' `Translation` varchar(255) , '+
                ' `Modified` enum("T","F") DEFAULT "F", '+
                '  PRIMARY KEY (`ID`), '+
                '  UNIQUE KEY `UniqueIdx` (`LanguageID`,`EnglishID`)) ;');
      Execute;
    end;
  end;
end;

procedure TLanguageTranslationObj.CreateInEnglish(qry: TERPQuery);
begin
  With Qry do begin
    SQL.clear;
    SQL.add('SHOW TABLES LIKE "inenglish"');
    open;
    if recordcount = 0 then begin

      SQl.clear;
      SQL.add('CREATE TABLE IF NOT EXISTS  `inenglish` ( '+
                '  `ID` int(10) NOT NULL AUTO_INCREMENT, '+
                '  `InEnglish` varchar(255) , '+
                '  PRIMARY KEY (`ID`), '+
                '  UNIQUE KEY `InEnglish` (`InEnglish`)) ;');
      Execute;
    end;
  end;
end;


procedure TLanguageTranslationObj.CreateLCList(form: TComponent);
begin
  if form is TfrmBaseGUI then TfrmBaseGUI(form).Lclist  := TList.Create
  else if form is TdtmGUI then TdtmGUI(form).Lclist  := TList.Create
end;

function TLanguageTranslationObj.TranslateQuery: TERPQuery;
begin
    if fTranslateQuery=nil then begin
      fTranslateQuery := CommonDbLib.TempMyQuery;
      fTranslateQuery.Connection :=conlanguage;
      fTranslateQuery.SQL.clear;
      fTranslateQuery.SQL.add(SQLSearch);
    end;
    result := fTranslateQuery;
end;

function TLanguageTranslationObj.Translation(const Value:String;LanguageID:Integer;charstoIgnore :Array of char ):String;
var
  FormatedValue:String;
function  formatValue:Boolean;
  var
    ctr:Integer;
begin
  FormatedValue:= Value;
  for ctr:= low(charstoIgnore) to high(charstoIgnore) do
    FormatedValue := replacestr(FormatedValue ,charstoIgnore[ctr] , '');
  result:= true;
end;
begin
  result := '';
  if LanguageID = 0 then exit;
  With TranslateQuery do try
      if active then close;
        Parambyname('LanguageID').asInteger := LanguageID;
        Parambyname('InEnglish').AsString := trim(Value);
        Open;
      if (recordcount =1) and (fieldbyname('Translation').asString <> '') then begin
          result := fieldbyname('Translation').asString;
          exit;
      end else if (formatValue) and  not(Sametext(Value , FormatedValue )) then begin
        result :=  Translation(FormatedValue, LanguageId , []);
      end else begin
        if fieldbyname('DialectLangId').asInteger= 0 then exit;
        result :=  Translation(Value , fieldbyname('DialectLangId').asInteger , charstoIgnore);
      end;
      
 finally
    if result = '' then result := Value
    else if result =FormatedValue then result := Value;
   if active then close;
 end;
end;

destructor TLanguageTranslationObj.Destroy;
begin
  freeandNil(fTranslateQuery);
  FreeandNil(Qryl);
  FreeandNil(qrye);
  FreeandNil(fConLanguage);
  inherited;
end;

(*function TLanguageTranslationObj.DialectLangIds: String;
begin
  REsult := 'update Languages set  DialectlangId =70 where Id = 4;'+
            'update Languages set  DialectlangId =6 where Id = 7;'+
            'update Languages set  DialectlangId =6 where Id = 8;'+
            'update Languages set  DialectlangId =6 where Id = 9;'+
            'update Languages set  DialectlangId =6 where Id = 10;'+
            'update Languages set  DialectlangId =6 where Id = 11;'+
            'update Languages set  DialectlangId =6 where Id = 12;'+
            'update Languages set  DialectlangId =6 where Id = 13;'+
            'update Languages set  DialectlangId =6 where Id = 14;'+
            'update Languages set  DialectlangId =6 where Id = 15;'+
            'update Languages set  DialectlangId =6 where Id = 16;'+
            'update Languages set  DialectlangId =6 where Id = 17;'+
            'update Languages set  DialectlangId =6 where Id = 18;'+
            'update Languages set  DialectlangId =6 where Id = 19;'+
            'update Languages set  DialectlangId =6 where Id = 20;'+
            'update Languages set  DialectlangId =6 where Id = 21;'+
            'update Languages set  DialectlangId =6 where Id = 22;'+
            'update Languages set  DialectlangId =91 where Id = 24;'+
            'update Languages set  DialectlangId =219 where Id = 25;'+
            'update Languages set  DialectlangId =220 where Id = 30;'+
            'update Languages set  DialectlangId =220 where Id = 31;'+
            'update Languages set  DialectlangId =70 where Id = 32;'+
            'update Languages set  DialectlangId =35 where Id = 36;'+
            'update Languages set  DialectlangId =35 where Id = 37;'+
            'update Languages set  DialectlangId =35 where Id = 38;'+
            'update Languages set  DialectlangId =35 where Id = 39;'+
            'update Languages set  DialectlangId =35 where Id = 40;'+
            'update Languages set  DialectlangId =70 where Id = 41;'+
            'update Languages set  DialectlangId =221 where Id = 42;'+
            'update Languages set  DialectlangId =221 where Id = 43;'+
            'update Languages set  DialectlangId =222 where Id = 48;'+
            'update Languages set  DialectlangId =222 where Id = 49;'+
            'update Languages set  DialectlangId =70 where Id = 71;'+
            'update Languages set  DialectlangId =70 where Id = 72;'+
            'update Languages set  DialectlangId =70 where Id = 73;'+
            'update Languages set  DialectlangId =70 where Id = 74;'+
            'update Languages set  DialectlangId =70 where Id = 75;'+
            'update Languages set  DialectlangId =70 where Id = 76;'+
            'update Languages set  DialectlangId =80 where Id = 81;'+
            'update Languages set  DialectlangId =80 where Id = 82;'+
            'update Languages set  DialectlangId =80 where Id = 83;'+
            'update Languages set  DialectlangId =80 where Id = 84;'+
            'update Languages set  DialectlangId =80 where Id = 85;'+
            'update Languages set  DialectlangId =91 where Id = 88;'+
            'update Languages set  DialectlangId =223 where Id = 102;'+
            'update Languages set  DialectlangId =223 where Id = 103;'+
            'update Languages set  DialectlangId =91 where Id = 106;'+
            'update Languages set  DialectlangId =91 where Id = 111;'+
            'update Languages set  DialectlangId =224 where Id = 120;'+
            'update Languages set  DialectlangId =224 where Id = 121;'+
            'update Languages set  DialectlangId =91 where Id = 122;'+
            'update Languages set  DialectlangId =91 where Id = 127;'+
            'update Languages set  DialectlangId =225 where Id = 133;'+
            'update Languages set  DialectlangId =225 where Id = 134;'+
            'update Languages set  DialectlangId =70 where Id = 135;'+
            'update Languages set  DialectlangId =91 where Id = 136;'+
            'update Languages set  DialectlangId =226 where Id = 140;'+
            'update Languages set  DialectlangId =226 where Id = 141;'+
            'update Languages set  DialectlangId =91 where Id = 142;'+
            'update Languages set  DialectlangId =227 where Id = 143;'+
            'update Languages set  DialectlangId =227 where Id = 144;'+
            'update Languages set  DialectlangId =227 where Id = 145;'+
            'update Languages set  DialectlangId =149 where Id = 150;'+
            'update Languages set  DialectlangId =149 where Id = 151;'+
            'update Languages set  DialectlangId =149 where Id = 152;'+
            'update Languages set  DialectlangId =149 where Id = 153;'+
            'update Languages set  DialectlangId =149 where Id = 154;'+
            'update Languages set  DialectlangId =149 where Id = 155;'+
            'update Languages set  DialectlangId =149 where Id = 156;'+
            'update Languages set  DialectlangId =149 where Id = 157;'+
            'update Languages set  DialectlangId =149 where Id = 158;'+
            'update Languages set  DialectlangId =91 where Id = 159;'+
            'update Languages set  DialectlangId =160 where Id = 161;'+
            'update Languages set  DialectlangId =160 where Id = 162;'+
            'update Languages set  DialectlangId =160 where Id = 163;'+
            'update Languages set  DialectlangId =160 where Id = 164;'+
            'update Languages set  DialectlangId =171 where Id = 172;'+
            'update Languages set  DialectlangId =171 where Id = 173;'+
            'update Languages set  DialectlangId =171 where Id = 174;'+
            'update Languages set  DialectlangId =171 where Id = 175;'+
            'update Languages set  DialectlangId =171 where Id = 176;'+
            'update Languages set  DialectlangId =171 where Id = 177;'+
            'update Languages set  DialectlangId =171 where Id = 178;'+
            'update Languages set  DialectlangId =171 where Id = 179;'+
            'update Languages set  DialectlangId =171 where Id = 180;'+
            'update Languages set  DialectlangId =171 where Id = 181;'+
            'update Languages set  DialectlangId =171 where Id = 182;'+
            'update Languages set  DialectlangId =171 where Id = 183;'+
            'update Languages set  DialectlangId =171 where Id = 184;'+
            'update Languages set  DialectlangId =171 where Id = 185;'+
            'update Languages set  DialectlangId =171 where Id = 186;'+
            'update Languages set  DialectlangId =171 where Id = 187;'+
            'update Languages set  DialectlangId =171 where Id = 188;'+
            'update Languages set  DialectlangId =171 where Id = 189;'+
            'update Languages set  DialectlangId =171 where Id = 190;'+
            'update Languages set  DialectlangId =171 where Id = 191;'+
            'update Languages set  DialectlangId =228 where Id = 193;'+
            'update Languages set  DialectlangId =228 where Id = 194;'+
            'update Languages set  DialectlangId =91 where Id = 198;'+
            'update Languages set  DialectlangId =91 where Id = 200;'+
            'update Languages set  DialectlangId =229 where Id = 211;'+
            'update Languages set  DialectlangId =229 where Id = 212;'+
            'update Languages set  DialectlangId =91 where Id = 220;';

end;*)

function TLanguageTranslationObj.normalfont(comp :Tcomponent):Boolean;
begin
  Result := (TLabel(Comp).font.name = 'Arial') and
                        (TLabel(Comp).font.size = 9) and
                        (TLabel(Comp).font.color = clBlack) and
                        (TLabel(Comp).font.style= [fsBold]);
end;

function TLanguageTranslationObj.LcItem(Form, Comp: TComponent): pLc;
var
  ctr:Integer;
begin
  Result := nil;
  if (Comp = nil) or (form=nil) or (LcList(Form) = nil) or (LcList(Form).count =0) then Exit;
  for ctr := 0 to LcList(Form).count-1 do begin
      if sametext(pLc(LcList(Form).Items[ctr])^.lcname , comp.name) then begin
          result := pLc(LcList(Form).Items[ctr]);
          Exit;
      end;
  end;
end;

procedure TLanguageTranslationObj.Translatecomp(fcomp :Tcomponent);
var
  s:String;
  ctr:Integer;
begin

{01}    if fcomp is TLabel then begin
        s :=Translation(TLabel(fcomp).Caption , LanguageId , ['&']);
        if s<> '' then begin
          TLabel(fcomp).Caption :=s;
          if (TLabel(fcomp).parentfont=false) and (normalfont(fcomp)) then
            TLabel(fcomp).font := Languagefont;
        end;
        s:=Translation(TLabel(fcomp).hint , LanguageId, ['&']);
        if s<> '' then TLabel(fcomp).hint :=s;
{02}  end else if fcomp is TDNMSpeedbutton then begin
        s :=Translation(TDNMSpeedbutton(fcomp).Caption , LanguageId, ['&']);
        if s<> '' then begin
          TDNMSpeedbutton(fcomp).Caption :=s;
          if (TDNMSpeedbutton(fcomp).parentfont=false) and (normalfont(fcomp)) then
            TDNMSpeedbutton(fcomp).font := Languagefont;
        end;
        s:=Translation(TDNMSpeedbutton(fcomp).hint , LanguageId, ['&']);
        if s<> '' then TDNMSpeedbutton(fcomp).hint :=s;
{03}  end else if fcomp is tdnmaction then begin
        s :=Translation(tdnmaction(fcomp).Caption , LanguageId, ['&']);
        if s<> '' then tdnmaction(fcomp).Caption :=s;
        s:=Translation(tdnmaction(fcomp).hint , LanguageId, ['&']);
        if s<> '' then tdnmaction(fcomp).hint :=s;
{04}  end else if fcomp is TField then begin
        s :=Translation(TField(fcomp).DisplayLabel , LanguageId, ['~']);
        if s<> '' then TField(fcomp).DisplayLabel :=s;
{05}  end else if fcomp is ttabsheet then begin
        s :=Translation(ttabsheet(fcomp).Caption , LanguageId, ['&']);
        if s<> '' then begin
          ttabsheet(fcomp).Caption :=s;
          if (ttabsheet(fcomp).parentfont=false) and (normalfont(fcomp))  then
            ttabsheet(fcomp).font := Languagefont;
        end;
        s:=Translation(ttabsheet(fcomp).hint , LanguageId, ['&']);
        if s<> '' then ttabsheet(fcomp).hint :=s;
{06}  end else if fcomp is Tform then begin
        s :=Translation(Tform(fcomp).Caption , LanguageId, ['&']);
        if s<> '' then Tform(fcomp).Caption :=s;
{07}  end else if fcomp is TMenuItem then begin
        TmenuItem(fComp).autohotkeys := maManual(*maAutomatic*);
        s :=Translation(TMenuItem(fcomp).Caption , LanguageId, ['&']);
        if s<> '' then
          TMenuItem(fcomp).Caption :=s;
        s:=Translation(TMenuItem(fcomp).hint , LanguageId, ['&']);
        if s<> '' then TMenuItem(fcomp).hint :=s;
{08}  end else if fcomp is TProgressDialog then begin
        s :=Translation(TProgressDialog(fcomp).Caption , LanguageId, ['&']);
        if s<> '' then
          TProgressDialog(fcomp).Caption :=s;
{09}  end else if fcomp is TCustomInputBox then begin
        s :=Translation(TCustomInputBox(fcomp).Caption , LanguageId, ['&']);
        if s<> '' then
          TCustomInputBox(fcomp).Caption :=s;
{10}  end else if fcomp is TDNMPanel then begin
        s :=Translation(TDNMPanel(fcomp).Caption , LanguageId, ['&']);
        if s<> '' then begin
          TDNMPanel(fcomp).Caption :=s;
          if (TDNMPanel(fcomp).parentfont=false) and (normalfont(fcomp))  then
            TDNMPanel(fcomp).font := Languagefont;
        end;
        s:=Translation(TDNMPanel(fcomp).hint , LanguageId, ['&']);
        if s<> '' then TDNMPanel(fcomp).hint :=s;
{11}  end else if fcomp is TToolButton then begin
        s :=Translation(TToolButton(fcomp).Caption , LanguageId, ['&']);
        if s<> '' then
          TToolButton(fcomp).Caption :=s;
        s:=Translation(TToolButton(fcomp).hint , LanguageId, ['&']);
        if s<> '' then TDNMSpeedbutton(fcomp).hint :=s;
{12}  end else if fcomp is TRadioGroup then begin
        if TRadioGroup(fcomp).Items.Count >0 then
         for ctr := 0 to TRadioGroup(fcomp).Items.Count -1 do begin
          s :=Translation(TRadioGroup(fcomp).Items[ctr] , LanguageId, ['&']);
          if s<> '' then TRadioGroup(fcomp).Items[ctr]:=s;
         end;
        s:=Translation(TRadioGroup(fComp).hint , LanguageId, ['&']);
        if s<> '' then TRadioGroup(fComp).hint :=s;
        s:=Translation(TRadioGroup(fComp).Caption , LanguageId, ['&']);
        if s<> '' then TRadioGroup(fComp).Caption :=s;
{13}  end else if fcomp is Tcheckbox then begin
        s :=Translation(Tcheckbox(fComp).Caption , LanguageId, ['&']);
        if s<>'' then Tcheckbox(fComp).Caption :=s;
        s:=Translation(Tcheckbox(fComp).hint , LanguageId, ['&']);
        if s<> '' then Tcheckbox(fComp).hint :=s;
{14}  end else if fcomp is TAdvStringGrid then begin
        if TAdvStringGrid(fcomp).ColumnHeaders.Count>0 then
         for ctr := 0 to TAdvStringGrid(fcomp).ColumnHeaders.Count -1 do begin
          s :=Translation(TAdvStringGrid(fcomp).ColumnHeaders[ctr] , LanguageId, ['&']);
          if s<> '' then TAdvStringGrid(fcomp).ColumnHeaders[ctr]:=s;
         end;
        s:=Translation(TAdvStringGrid(fcomp).hint , LanguageId, ['&']);
        if s<> '' then TAdvStringGrid(fcomp).hint :=s;
{15}  end else if fcomp is TwwCheckBox then begin
        s :=Translation(TwwCheckBox(fComp).Caption , LanguageId, ['&']);
        if s<>'' then TwwCheckBox(fComp).Caption :=s;
        s:=Translation(TwwCheckBox(fComp).hint , LanguageId, ['&']);
        if s<> '' then TwwCheckBox(fComp).hint :=s;
{16}  end else if fcomp is TwwRadioGroup then begin
        if TwwRadioGroup(fcomp).Items.Count >0 then
         for ctr := 0 to TwwRadioGroup(fcomp).Items.Count -1 do begin
          s :=Translation(TwwRadioGroup(fcomp).Items[ctr] , LanguageId, ['&']);
          if s<> '' then TwwRadioGroup(fcomp).Items[ctr]:=s;
         end;
        s:=Translation(TwwRadioGroup(fComp).hint , LanguageId, ['&']);
        if s<> '' then TwwRadioGroup(fComp).hint :=s;
        s:=Translation(TwwRadioGroup(fComp).Caption , LanguageId, ['&']);
        if s<> '' then TwwRadioGroup(fComp).Caption :=s;
{17}  end else if fcomp is TERPMainSwitchButton then begin
        s :=Translation(TERPMainSwitchButton(fcomp).Caption , LanguageId, ['&']);
        if s<> '' then begin
          TERPMainSwitchButton(fcomp).Caption :=s;
          if (TERPMainSwitchButton(fcomp).parentfont=false) and (normalfont(fcomp)) then
            TERPMainSwitchButton(fcomp).font := Languagefont;
        end;
        s:=Translation(TERPMainSwitchButton(fcomp).hint , LanguageId, ['&']);
        if s<> '' then TERPMainSwitchButton(fcomp).hint :=s;
      end;
end;
function TLanguageTranslationObj.getLanguageID(Language:String):Integer;
begin
  with Self.Languages do try
    Parambyname('Language').asString := Language;
    open;
    result := fieldbyname('ID').asInteger;
  finally
    close;
  end;
end;
function TLanguageTranslationObj.getUserLanguage_EnglishWhenBlank_Id: Integer;
begin
  REsult := UserLanguageID;
  if result = 0 then result := EnglishLanguageID;
end;

function TLanguageTranslationObj.getEnglishID(InEnglish:String):Integer;
begin
  with Self.Inenglish do try
    Parambyname('InEnglish').asString := InEnglish;
    open;
    if recordcount = 0 then begin
      Append;
      FieldByname('InEnglish').asString :=  InEnglish;
      Post;
    end;
    result := fieldbyname('ID').asInteger;
  finally
    close;
  end;

end;
Procedure TLanguageTranslationObj.DoimportText(fileName:String);
var
  x:Integer;
  English:String;
  Language:String;
  Translation:String;
  LineSt, ST:TStringList;
  s:String;
  TF:TTextFile;
  line: string;

  fiEnglish:Integer;
  fiLanguage:integer;
  Function TreatSpecialChar(const Value:String):String;
  begin
    result := replacestr(Value,'\' , '\\');
  end;
begin
  inherited;
      TF:= Ttextfile.Create(fileName, tfmOpenRead);
      st:=tstringlist.create;
      LineSt:=tstringlist.create;
      try
        Line := TF.REadLine;
        x:= 0;
        while not (*EOF(inFile)*)TF.EOF  do begin
          x:= x+1;
          Line := TF.REadLine;
          SplitString(Line, '","' , LineSt);
          if LineSt.count=3 then begin
            English := LineSt[0];
            Language := LineSt[1];
            Translation := LineSt[2];
            if (English <> '') and   (Language<> '')  and  (Translation <> '')  then begin
                fienglish  := getEnglishID(English);
                fiLanguage := getLanguageID(Language);
                if (fienglish<>0) and (fiLanguage<>0) then begin
                  s:= '/*' + inttostr(x) +': */' + 'insert ignore into languagetranslation (EnglishId, languageId,translation ) values  '  +
                    '(' + intToStr(fienglish)+',' +inttostr(fiLanguage)+',' +Quotedstr(TreatSpecialChar(Translation)) +')'+
                    ' on duplicate key update translation = ' +quotedstr(TreatSpecialChar(Translation))+' ;';
                  //if ST.count > 0 then s:= ',' +s;
                  St.add(s);
                end;
            end;
          end;
        end; {while}
        if st.count > 0 then begin
          with TempMyScript do try
                connection :=ConLanguage;
                BeforeExecute :=stepProgressbar;
                AfterExecute := ScriptExecute;
                onError := ScriptError;
                SQL.add(ST.text);
                ProgressDialog.DoShowProgressbar(ST.Count , 'Importing...' );
                try
                  execute;
                finally
                  ProgressDialog.DoHideProgressbar;
                end;
          finally
                free;
          end;
        end;
      finally
        FreeandNil(ST);
        FreeandNil(TF);
        FreeandNil(LineSt);
      end;
end;
function TLanguageTranslationObj.Doimport(fileName: String):boolean;
var
  x:Integer;
  Json: TJsonObject;
  Rec: TJsonObject;
  English:String;
  Language:String;
  Translation:String;
  BaseURL:String;
  ST:TStringList;
  s:String;

  fiEnglish:Integer;
  fiLanguage:integer;
  Category:Integer;
  Function TreatSpecialChar(const Value:String):String;
  begin
    result := replacestr(Value,'\' , '\\');
  end;
begin
  //REsult:= False;
  inherited;
    Json:= JO;
    try
      Json.LoadFromFile(filename);
      st:=tstringlist.create;
      try
        ProgressDialog.DoShowProgressbar(Json.Count , 'Importing...' );
        try
          for x:= 0 to Json.Count -1 do begin
             Rec:= Json.Items[x].Value.AsObject;
             English := Rec.S['English'];
             Language:= Rec.S['Language'];
             Translation := Rec.S['Translation'];
             BaseURL:= Rec.S['BaseURL'];
             Category:= Rec.I['Category'];
             if (Language<> '')  then begin
                fiLanguage := getLanguageID(Language);
                if fiLanguage <> 0 then begin
                  if (Category = 1) then begin
                        s:= '/*' + inttostr(x) +'.BaseURL: */' + 'update languages Set BaseURL = ' + quotedstr(BaseURL)+' where ID = ' + inttostr(fiLanguage)+';';
                        St.add(s);
                  end else begin
                    if (English <> '') and   (Translation <> '')  then begin
                      fienglish  := getEnglishID(English);
                      if fiLanguage <> 0 then begin
                          if (fienglish<>0)  then begin
                            s:= '/*' + inttostr(x) +': */' + 'insert ignore into languagetranslation (EnglishId, languageId,translation ) values  '  +
                              '(' + intToStr(fienglish)+',' +inttostr(fiLanguage)+',' +Quotedstr(TreatSpecialChar(Translation)) +')'+
                              ' on duplicate key update translation = ' +quotedstr(TreatSpecialChar(Translation))+' ;';
                            logtext(filename +'->' +English +' = ' +  Translation ,  replacestr(Application.ExeName, '.EXE' ,'_LanguageTrans.lib') );
                            St.add(s);
                          end;
                      end;
                    end;
                  end;
                end;
             end;
             ProgressDialog.DoStepProgressbar;
          end;
        finally
          ProgressDialog.DoHideProgressbar;
        end;
        //st[0] := 'insert ignore into languagetranslation (EnglishId, languageId,translation ) values  ' + st[0];
        with TempMyScript do try
          connection :=ConLanguage;
          BeforeExecute :=stepProgressbar;
          AfterExecute := ScriptExecute;
          onError := ScriptError;
          SQL.add(ST.text);
          ProgressDialog.DoShowProgressbar(Json.Count , 'Importing...' );
          try
            execute;
            Result:= true;
          finally
            ProgressDialog.DoHideProgressbar;
          end;
        finally
          free;
        end;
      finally
        FreeandNil(ST);
      end;
    finally
      Json.Free;
    end;
end;

class function TLanguageTranslationObj.SafeInst: TLanguageTranslationObj;
begin
  result:= fLanguageTranslationObj;
end;

procedure TLanguageTranslationObj.ScriptError(Sender: TObject; E: Exception;  SQL: string; var Action: TErrorAction);
begin
end;

procedure TLanguageTranslationObj.ScriptExecute(Sender: TObject; SQL: string);
begin
end;

function TLanguageTranslationObj.DoTranslateToEnglish(const Value:String):String;
var
  qry : TERPQuery;
begin
  if (LanguageId = EnglishLanguageID) then
  begin
    Result:= Value;
    Exit;
  end;
  qry := TempMyQuery(ConLanguage);
//  With TempMyQuery(ConLanguage) do try
  try
    qry.SQL.Add('Select E.Inenglish as English, L.Language , Lt.Translation');
    qry.SQL.Add('from LanguageTranslation LT');
    qry.SQL.Add('inner join languages L on L.Id= Lt.LanguageID');
    qry.SQL.Add('inner join inEnglish E on E.ID = Lt.englishID');
    qry.SQL.Add('where Translation = ' +quotedstr(Value));
    qry.SQL.Add('union all ');
    qry.SQL.Add('Select E.Inenglish as English, L.Language , Lt.Translation');
    qry.SQL.Add('from LanguageTranslation LT');
    qry.SQL.Add('inner join languages L on L.Id= Lt.LanguageID');
    qry.SQL.Add('inner join inEnglish E on E.ID = Lt.englishID');
    qry.SQL.Add('where Translation = ' +quotedstr(Value));
    qry.open;
    Result := trim(qry.fieldbyname('English').AsString);
    if result = '' then
      result := Value;
    if Trim(result) = '' then
      result := Value;
  finally
    //if active then close;
    qry.free;
  end;
end;

function TLanguageTranslationObj.DoTranslate(const Value:String;LanguageID:Integer ; const Args: array of String): String;
var
  st:TStringList;
  ctr:Integer;
begin
  result := Value;
  if LanguageID =0 then exit;

  st:= tStringlist.create;
  try
    SplitString(Value, TransDelim, st);
    if st.count > 0 then begin
      for ctr:= 0 to st.count-1 do
        result := replacestr(result, st[ctr] , Translation(st[ctr] , LanguageID, ['&']));

      if length(Args)>0 then
        for ctr := low(Args) to high(Args) do
          Result := StringReplace(result, TransDelim,Translation(args[ctr], languageId, ['&']) , []);// only replace one stance
    end;

  finally
    freeandNil(st);
  end;
end;

Function TLanguageTranslationObj.ExportModified(filename: String; LangID:Integer):Boolean;
var
  Qry :TERPQuery;
  Json: TJsonObject;
begin
  Result := false;
  Qry :=TERPQuery.create(nil);
  try
    try
      Qry.Connection := ConLanguage;
      if CanUpdateLanguageBaseURL then
        Qry.SQL.add('Select 1 as Category , null as English, Language as Language , null as Translation, L.BaseURL  '+
                    ' from languages L ' +
                    ' where L.ID = ' +inttostr(LangID)+
                    ' Union all ' );
      Qry.SQL.add('Select 2 as Category , E.Inenglish as English, L.Language , Lt.Translation, null as BaseURL ' +
                    ' from LanguageTranslationLocal LT ' +
                    ' inner join languages L on L.Id= Lt.LanguageID ' +
                    ' inner join inEnglish E on E.ID = Lt.englishID ' +
                    ' where modified = "T" and LT.LanguageID = ' +inttostr(LangID)+
                    ' order by Category');
      Qry.open;
      if Qry.recordcount = 0 then begin
        REsult := True;
        exit;
      end;
      DoShowProgressbar(qry.recordcount, 'Exporting....');
      try
        Json:= JO;
        try
          Qry.first;
            While Qry.eof = False do begin
              Json.O[intToStr(Qry.recno)].I['Category']:= Qry.fieldbyname('Category').AsInteger;
              Json.O[intToStr(Qry.recno)].S['English']:= Qry.fieldbyname('English').asString;
              Json.O[intToStr(Qry.recno)].S['Language']:=Qry.fieldbyname('Language').asString;
              Json.O[intToStr(Qry.recno)].S['Translation']:= Qry.fieldbyname('Translation').asString;
              Json.O[intToStr(Qry.recno)].S['BaseURL']:= Qry.fieldbyname('BaseURL').asString;
              Qry.Next;
              DoStepProgressbar;
            end;
        finally
          Json.savetofile(filename);
          Result := True;
          Json.Free;
        end;
      finally
        DoHideProgressbar;
      end;
    finally
      freeandNil(Qry);
    end;
  except
    on E:Exception do begin
      MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TLanguageTranslationObj.FreeLcList(form: TComponent);
begin
  if LcList(Form) <> nil then
    try
      while LcList(Form).Count > 0 do begin
        Dispose(pLc(LcList(Form).Items[0]));
        LcList(Form).Delete(0);
      end;
    Except
        // kill the exception -> unexpected exceptions in the error tracker
    end;
end;

function TLanguageTranslationObj.Inenglish: TERPQuery;
begin
  if not(assigned(Qrye)) then begin
    Qrye:= commondblib.TempMyQuery;
    Qrye.connection := ConLanguage;
    Qrye.SQL.text:= 'Select * from inenglish where InEnglish = :InEnglish';
  end;
  result := Qrye;
end;
Procedure TLanguageTranslationObj.DoTranslate(ds:TDataset ; UserLanguageID:Integer);
var
  ctr:Integer;
  s:String;
begin
  for ctr:= 0 to ds.FieldCount-1 do begin
     s:= DoTranslate(replacestr(ds.Fields[ctr].displaylabel , '~' , ' ') , UserLanguageID , ['~']);
     if sametext(s,replacestr(ds.Fields[ctr].displaylabel , '~' , ' ') ) then
      else ds.Fields[ctr].displaylabel:= s;
  end;
end;
Procedure TLanguageTranslationObj.TranslateGrids(sourceform :Tform);
var
  gf: TGridFieldList;
  ctr: Integer;
  x: integer;
  s:String;
begin
    With sourceform do begin
      s:= DoTranslate(replacestr(Caption , '' , ' ') , UserLanguageID , ['~']);
      if sametext(s,caption) then else Caption := s;
      for ctr:=  0 to ComponentCount-1 do begin
        if components[ctr] is TwwDBgrid then begin
          if TwwDBgrid(components[ctr]).UseTFields = False then begin
            gf:= TGridFieldList.create;
            try
              gf.LoadFromGrid(TwwDBgrid(components[ctr]));
              for x:= 0 to gf.Count -1 do begin
                s:= DoTranslate(replacestr(gf.Items[x].displaylabel , '~' , ' ') , UserLanguageID , ['~']);
                if sametext(s,replacestr(gf.Items[x].displaylabel , '~' , ' ') ) then
                else gf.Items[x].displaylabel:= s;

                gf.Items[x].groupname := DoTranslate(gf.Items[x].groupname,UserLanguageId,[]);
              end;
              gf.SaveToGrid(TwwDBgrid(components[ctr]));
            finally
              Freeandnil(gf);
            end;
          end;
        end;
      end;
    end;
end;
Procedure TLanguageTranslationObj.DoTranslate(Form :TComponent ; UserLanguageID:Integer);
var
   ctr:Integer;
   comp:Tcomponent;
   fsLanguage:String;

   {Procedure Logcomp;
   var
      s:String;
   begin
    s:= '';
     if Comp is TLabel then begin
         s:= s+ 'Caption :' +TLabel(comp).Caption+',';
      end else if Comp is TProgressDialog then begin
         s:= s+ 'Caption :' +TProgressDialog(comp).Caption+',';
      end else if Comp is TCustomInputBox then begin
         s:= s+ 'Caption :' +TCustomInputBox(comp).Caption+',';
      end else if Comp is TMenuItem then begin
         s:= s+ 'Caption :' +TMenuItem(comp).Caption +',';
      end else if Comp is TDNMSpeedbutton then begin
         s:= s+ 'Caption :' +TDNMSpeedbutton(comp).Caption+',';
      end else if Comp is TDNMPanel then begin
         s:= s+ 'Caption :' +TDNMPanel(comp).Caption+',';
      end else if Comp is tdnmaction then begin
         s:= s+ 'Caption :' +tdnmaction(comp).Caption +',';
      end else if Comp is TField then begin
         s:= s+ 'Caption :' +TField(comp).displaylabel+',';
      end else if Comp is ttabsheet then begin
         s:= s+ 'Caption :' +ttabsheet(comp).caption +',';
      end else if Comp is tForm then begin
         s:= s+ 'Caption :' +tForm(comp).caption +',';
      end;
     s:= form.ClassName+'(' +form.Name+').'+comp.ClassName+'('+comp.Name+')'+s;
     s:= s+ 'Caption :' +pLc(LcList(Form).Items[ctr])^.lccaption ;
   end;}

   function ISRegionalLanguageClass(const curcomp :Tcomponent) :boolean;
   var
    x:Integer;
   begin
    result := false;
    for x := low(RegionalLanguageClasses) to high(RegionalLanguageClasses) do
      if curcomp is RegionalLanguageClasses[x] then begin
        result := True;
        exit;
      end;
   end;
begin
  comp := nil;
  if not fbIsERPRunning  then exit;
    if (LcList(Form) <> nil) and (LcList(Form).count >0) then begin
      for ctr := 0 to LcList(Form).count-1 do begin
        with pLc(LcList(Form).Items[ctr])^ do begin
            if lcname <> '' then
              try
                if SameText(lcname, form.Name) then begin
                  TForm(Form).Caption    := lcCaption;
                end else begin
                  comp := form.findcomponent(lcname);
                  if assigned(comp) then begin
                    if SameText(lctype , 'TLabel') then begin
                      TLabel(comp).Caption    := lcCaption;
                      TLabel(comp).hint       := lchint;
                      if (TLabel(comp).parentfont=false) then begin
                        TLabel(comp).font.name  := lcfontname;
                        TLabel(comp).font.style := LcfontStyle;
                        TLabel(comp).font.size  := lcfontsize;
                      end;
                      TLabel(comp).refresh;
                    end else if SameText(lctype , 'TProgressDialog') then begin
                      TProgressDialog(comp).Caption    := lcCaption;
                    end else if SameText(lctype , 'TCustomInputBox') then begin
                      TCustomInputBox(comp).Caption    := lcCaption;
                    end else if SameText(lctype , 'TMenuItem') then begin
                      TmenuItem(Comp).autohotkeys := maManual(*maAutomatic*);
                      TMenuItem(comp).Caption    := lcCaption;
                      TMenuItem(comp).hint       := lchint;
                    end else if SameText(lctype , 'TDNMSpeedbutton') then begin
                      TDNMSpeedbutton(comp).Caption    := lcCaption;
                      TDNMSpeedbutton(comp).hint       := lchint;
                      if (TDNMSpeedbutton(comp).parentfont=false) then begin
                        TDNMSpeedbutton(comp).font.name  := lcfontname;
                        TDNMSpeedbutton(comp).font.style := LcfontStyle;
                        TDNMSpeedbutton(comp).font.size  := lcfontsize;
                      end;
                      TDNMSpeedbutton(comp).refresh;
                    end else if SameText(lctype , 'TERPMainSwitchButton') then begin
                      TERPMainSwitchButton(comp).Caption    := lcCaption;
                      TERPMainSwitchButton(comp).hint       := lchint;
                      if (TERPMainSwitchButton(comp).parentfont=false) then begin
                        TERPMainSwitchButton(comp).font.name  := lcfontname;
                        TERPMainSwitchButton(comp).font.style := LcfontStyle;
                        TERPMainSwitchButton(comp).font.size  := lcfontsize;
                      end;
                      TERPMainSwitchButton(comp).refresh;
                    end else if SameText(lctype , 'TToolButton') then begin
                      TToolButton(comp).Caption    := lcCaption;
                      TToolButton(comp).hint       := lchint;
                      TToolButton(comp).refresh;
                    end else if SameText(lctype , 'TDNMPanel') then begin
                      TDNMPanel(comp).Caption    := lcCaption;
                      TDNMPanel(comp).hint       := lchint;
                      if (TDNMPanel(comp).parentfont=false) then begin
                        TDNMPanel(comp).font.name  := lcfontname;
                        TDNMPanel(comp).font.style := LcfontStyle;
                        TDNMPanel(comp).font.size  := lcfontsize;
                      end;
                      TDNMPanel(comp).refresh;
                    end else if SameText(lctype , 'tdnmaction') then begin
                      tdnmaction(comp).Caption    := lcCaption;
                      tdnmaction(comp).hint       := lchint;
                    end else if SameText(lctype , 'TField') then begin
                      TField(comp).displaylabel    := lcCaption;
                    end else if SameText(lctype , 'ttabsheet') then begin
                      ttabsheet(comp).caption    := lcCaption;
                    end else if SameText(lctype , 'tForm') then begin
                      tForm(comp).caption    := lcCaption;
                    end else if SameText(lctype , 'TRadioGroup') then begin
                      TRadioGroup(comp).Hint := lchint;
                      if LcItemIndex =-1 then
                        TRadioGroup(comp).Caption := lcCaption;
                      if LcItemIndex >=0 then
                        if TRadioGroup(comp).Items.Count > LcItemIndex then
                          TRadioGroup(comp).Items[LcItemIndex]:=lcCaption;
                      if (TRadioGroup(comp).parentfont=false) then begin
                        TRadioGroup(comp).font.name  := lcfontname;
                        TRadioGroup(comp).font.style := LcfontStyle;
                        TRadioGroup(comp).font.size  := lcfontsize;
                      end;
                    end else if SameText(lctype , 'TwwRadioGroup') then begin
                      TwwRadioGroup(comp).Hint := lchint;
                      if LcItemIndex =-1 then
                        TwwRadioGroup(comp).Caption := lcCaption;
                      if LcItemIndex >=0 then
                        if TwwRadioGroup(comp).Items.Count > LcItemIndex then
                          TwwRadioGroup(comp).Items[LcItemIndex]:=lcCaption;
                      if (TwwRadioGroup(comp).parentfont=false) then begin
                        TwwRadioGroup(comp).font.name  := lcfontname;
                        TwwRadioGroup(comp).font.style := LcfontStyle;
                        TwwRadioGroup(comp).font.size  := lcfontsize;
                      end;
                    end else if SameText(lctype , 'TAdvStringGrid') then begin
                      TAdvStringGrid(comp).Hint := lchint;
                      if LcItemIndex >=0 then
                        if TAdvStringGrid(comp).Columnheaders.Count > LcItemIndex then
                          TAdvStringGrid(comp).Columnheaders[LcItemIndex]:=lcCaption;
                      if (TAdvStringGrid(comp).parentfont=false) then begin
                        TAdvStringGrid(comp).font.name  := lcfontname;
                        TAdvStringGrid(comp).font.style := LcfontStyle;
                        TAdvStringGrid(comp).font.size  := lcfontsize;
                      end;
                    end else if Sametext(lctype ,'Tcheckbox') then begin
                      Tcheckbox(Comp).Caption := lcCaption;
                      Tcheckbox(comp).Hint := lchint;
                      if (Tcheckbox(comp).parentfont=false) then begin
                        Tcheckbox(comp).font.name  := lcfontname;
                        Tcheckbox(comp).font.style := LcfontStyle;
                        Tcheckbox(comp).font.size  := lcfontsize;
                      end;
                    end else if Sametext(lctype ,'TwwCheckBox') then begin
                      TwwCheckBox(Comp).Caption := lcCaption;
                      TwwCheckBox(comp).Hint := lchint;
                      if (TwwCheckBox(comp).parentfont=false) then begin
                        TwwCheckBox(comp).font.name  := lcfontname;
                        TwwCheckBox(comp).font.style := LcfontStyle;
                        TwwCheckBox(comp).font.size  := lcfontsize;
                      end;
                    end;
                  end else begin
                     (*if Commonlib.DevMode then
                        MessageDlgXP_Vista('Component not found - '+form.classname +'.'+lcname , mtinformation, [mbok], 0);*)
                  end;
                end;
              except
                on E:Exception do begin
                  if Commonlib.DevMode then
                    if assigned(comp) then
                          MessageDlgXP_Vista('Language Translation Failed.' +chr(13) +chr(13) + form.classname +'.'+comp.name +':' +E.Message , mtinformation, [mbok], 0)
                    else  MessageDlgXP_Vista('Language Translation Failed.' +chr(13) +chr(13) + form.classname +':' +E.Message , mtinformation, [mbok], 0);
                end;
              end;
        end;
      end;
      end;
  fsLanguage := LanguageName(UserLanguageID);
  LanguageId := UserLanguageID;
  if not(SameText(fsLanguage , 'English'))  then begin
      for ctr  := 0 to Form.ComponentCount-1 do
          if ISRegionalLanguageClass(form.Components[ctr]) then
            Translatecomp(form.Components[ctr]);
  end

end;

(*function TLanguageTranslationObj.LanguageCodes: String;
begin
result := 'update Languages set  LanguageCode = "EN" where Id = 1;' +
            'update Languages set  LanguageCode = "AF" where Id = 2;' +
            'update Languages set  LanguageCode = "SQ" where Id = 3;' +
            'update Languages set  LanguageCode = "ALS" where Id = 4;' +
            'update Languages set  LanguageCode = "AMH" where Id = 5;' +
            'update Languages set  LanguageCode = "AR" where Id = 6;' +
            'update Languages set  LanguageCode = "ARBA" where Id = 7;' +
            'update Languages set  LanguageCode = "ARBB" where Id = 8;' +
            'update Languages set  LanguageCode = "ARBE" where Id = 9;' +
            'update Languages set  LanguageCode = "ARBI" where Id = 10;' +
            'update Languages set  LanguageCode = "ARBJ" where Id = 11;' +
            'update Languages set  LanguageCode = "ARBK" where Id = 12;' +
            'update Languages set  LanguageCode = "ARBL" where Id = 13;' +
            'update Languages set  LanguageCode = "ARBLB" where Id = 14;' +
            'update Languages set  LanguageCode = "ARBM" where Id = 15;' +
            'update Languages set  LanguageCode = "ARBO" where Id = 16;' +
            'update Languages set  LanguageCode = "ARBQ" where Id = 17;' +
            'update Languages set  LanguageCode = "ARBSA" where Id = 18;' +
            'update Languages set  LanguageCode = "ARBS" where Id = 19;' +
            'update Languages set  LanguageCode = "ARBT" where Id = 20;' +
            'update Languages set  LanguageCode = "ARBU" where Id = 21;' +
            'update Languages set  LanguageCode = "ARBY" where Id = 22;' +
            'update Languages set  LanguageCode = "ARM" where Id = 23;' +
            'update Languages set  LanguageCode = "ASM" where Id = 24;' +
            'update Languages set  LanguageCode = "AZRC" where Id = 25;' +
            'update Languages set  LanguageCode = "AZRL" where Id = 26;' +
            'update Languages set  LanguageCode = "BAS" where Id = 27;' +
            'update Languages set  LanguageCode = "BAQ" where Id = 28;' +
            'update Languages set  LanguageCode = "BEL" where Id = 29;' +
            'update Languages set  LanguageCode = "BENB" where Id = 30;' +
            'update Languages set  LanguageCode = "BENI" where Id = 31;' +
            'update Languages set  LanguageCode = "BRE" where Id = 32;' +
            'update Languages set  LanguageCode = "BUL" where Id = 33;' +
            'update Languages set  LanguageCode = "CAT" where Id = 34;' +
            'update Languages set  LanguageCode = "CHN" where Id = 35;' +
            'update Languages set  LanguageCode = "CHNH" where Id = 36;' +
            'update Languages set  LanguageCode = "CHNM" where Id = 37;' +
            'update Languages set  LanguageCode = "CHNS" where Id = 38;' +
            'update Languages set  LanguageCode = "CHNSN" where Id = 39;' +
            'update Languages set  LanguageCode = "CHNT" where Id = 40;' +
            'update Languages set  LanguageCode = "COR" where Id = 41;' +
            'update Languages set  LanguageCode = "CROB" where Id = 42;' +
            'update Languages set  LanguageCode = "CROC" where Id = 43;' +
            'update Languages set  LanguageCode = "CZE" where Id = 44;' +
            'update Languages set  LanguageCode = "DAN" where Id = 45;' +
            'update Languages set  LanguageCode = "DAR" where Id = 46;' +
            'update Languages set  LanguageCode = "DIV" where Id = 47;' +
            'update Languages set  LanguageCode = "DUTB" where Id = 48;' +
            'update Languages set  LanguageCode = "DUTN" where Id = 49;' +
            'update Languages set  LanguageCode = "ENGA" where Id = 50;' +
            'update Languages set  LanguageCode = "ENGB" where Id = 51;' +
            'update Languages set  LanguageCode = "ENGCN" where Id = 52;' +
            'update Languages set  LanguageCode = "ENGCR" where Id = 53;' +
            'update Languages set  LanguageCode = "ENGIN" where Id = 54;' +
            'update Languages set  LanguageCode = "ENGIR" where Id = 55;' +
            'update Languages set  LanguageCode = "ENGJ" where Id = 56;' +
            'update Languages set  LanguageCode = "ENGM" where Id = 57;' +
            'update Languages set  LanguageCode = "ENGN" where Id = 58;' +
            'update Languages set  LanguageCode = "ENGP" where Id = 59;' +
            'update Languages set  LanguageCode = "ENGSN" where Id = 60;' +
            'update Languages set  LanguageCode = "ENGSA" where Id = 61;' +
            'update Languages set  LanguageCode = "ENGT" where Id = 62;' +
            'update Languages set  LanguageCode = "ENGUK" where Id = 63;' +
            'update Languages set  LanguageCode = "ENGUS" where Id = 64;' +
            'update Languages set  LanguageCode = "ENGZ" where Id = 65;' +
            'update Languages set  LanguageCode = "EST" where Id = 66;' +
            'update Languages set  LanguageCode = "FAR" where Id = 67;' +
            'update Languages set  LanguageCode = "TL" where Id = 68;' +
            'update Languages set  LanguageCode = "FIN" where Id = 69;' +
            'update Languages set  LanguageCode = "FR" where Id = 70;' +
            'update Languages set  LanguageCode = "FRB" where Id = 71;' +
            'update Languages set  LanguageCode = "FRC" where Id = 72;' +
            'update Languages set  LanguageCode = "FRF" where Id = 73;' +
            'update Languages set  LanguageCode = "FRL" where Id = 74;' +
            'update Languages set  LanguageCode = "FRM" where Id = 75;' +
            'update Languages set  LanguageCode = "FRS" where Id = 76;' +
            'update Languages set  LanguageCode = "FRI" where Id = 77;' +
            'update Languages set  LanguageCode = "GAL" where Id = 78;' +
            'update Languages set  LanguageCode = "GOR" where Id = 79;' +
            'update Languages set  LanguageCode = "GER" where Id = 80;' +
            'update Languages set  LanguageCode = "GERA" where Id = 81;' +
            'update Languages set  LanguageCode = "GERG" where Id = 82;' +
            'update Languages set  LanguageCode = "GERLT" where Id = 83;' +
            'update Languages set  LanguageCode = "GERLX" where Id = 84;' +
            'update Languages set  LanguageCode = "GERS" where Id = 85;' +
            'update Languages set  LanguageCode = "GRK" where Id = 86;' +
            'update Languages set  LanguageCode = "GRN" where Id = 87;' +
            'update Languages set  LanguageCode = "GUJ" where Id = 88;' +
            'update Languages set  LanguageCode = "HAS" where Id = 89;' +
            'update Languages set  LanguageCode = "HEB" where Id = 90;' +
            'update Languages set  LanguageCode = "HI" where Id = 91;' +
            'update Languages set  LanguageCode = "HUN" where Id = 92;' +
            'update Languages set  LanguageCode = "ICE" where Id = 93;' +
            'update Languages set  LanguageCode = "IGB" where Id = 94;' +
            'update Languages set  LanguageCode = "IND" where Id = 95;' +
            'update Languages set  LanguageCode = "IT" where Id = 223;' +
            'update Languages set  LanguageCode = "INK" where Id = 97;' +
            'update Languages set  LanguageCode = "INV" where Id = 98;' +
            'update Languages set  LanguageCode = "IR" where Id = 99;' +
            'update Languages set  LanguageCode = "SAX" where Id = 100;' +
            'update Languages set  LanguageCode = "SAS" where Id = 101;' +
            'update Languages set  LanguageCode = "ITI" where Id = 102;' +
            'update Languages set  LanguageCode = "ITS" where Id = 103;' +
            'update Languages set  LanguageCode = "JAP" where Id = 104;' +
            'update Languages set  LanguageCode = "KC" where Id = 105;' +
            'update Languages set  LanguageCode = "KAN" where Id = 106;' +
            'update Languages set  LanguageCode = "KAH" where Id = 107;' +
            'update Languages set  LanguageCode = "KAZ" where Id = 108;' +
            'update Languages set  LanguageCode = "KHM" where Id = 109;' +
            'update Languages set  LanguageCode = "KIN" where Id = 110;' +
            'update Languages set  LanguageCode = "KON" where Id = 111;' +
            'update Languages set  LanguageCode = "KOR" where Id = 112;' +
            'update Languages set  LanguageCode = "KYG" where Id = 113;' +
            'update Languages set  LanguageCode = "LAO" where Id = 114;' +
            'update Languages set  LanguageCode = "LAT" where Id = 115;' +
            'update Languages set  LanguageCode = "LIT" where Id = 116;' +
            'update Languages set  LanguageCode = "LOW" where Id = 117;' +
            'update Languages set  LanguageCode = "LUX" where Id = 118;' +
            'update Languages set  LanguageCode = "MAC" where Id = 119;' +
            'update Languages set  LanguageCode = "MALAYB" where Id = 120;' +
            'update Languages set  LanguageCode = "MALAYM" where Id = 121;' +
            'update Languages set  LanguageCode = "MAL" where Id = 122;' +
            'update Languages set  LanguageCode = "MAT" where Id = 123;' +
            'update Languages set  LanguageCode = "MANP" where Id = 124;' +
            'update Languages set  LanguageCode = "MAO" where Id = 125;' +
            'update Languages set  LanguageCode = "MAP" where Id = 126;' +
            'update Languages set  LanguageCode = "MAR" where Id = 127;' +
            'update Languages set  LanguageCode = "MOH" where Id = 128;' +
            'update Languages set  LanguageCode = "MAN" where Id = 129;' +
            'update Languages set  LanguageCode = "NEP" where Id = 131;' +
            'update Languages set  LanguageCode = "NOR" where Id = 225;' +
            'update Languages set  LanguageCode = "NORB" where Id = 133;' +
            'update Languages set  LanguageCode = "NORN" where Id = 134;' +
            'update Languages set  LanguageCode = "OCC" where Id = 135;' +
            'update Languages set  LanguageCode = "OR" where Id = 136;' +
            'update Languages set  LanguageCode = "PAS" where Id = 137;' +
            'update Languages set  LanguageCode = "PER" where Id = 138;' +
            'update Languages set  LanguageCode = "POL" where Id = 139;' +
            'update Languages set  LanguageCode = "PORB" where Id = 140;' +
            'update Languages set  LanguageCode = "PORP" where Id = 141;' +
            'update Languages set  LanguageCode = "PUN" where Id = 142;' +
            'update Languages set  LanguageCode = "QUEB" where Id = 143;' +
            'update Languages set  LanguageCode = "QUEE" where Id = 144;' +
            'update Languages set  LanguageCode = "QUEP" where Id = 145;' +
            'update Languages set  LanguageCode = "ROM" where Id = 146;' +
            'update Languages set  LanguageCode = "ROMS" where Id = 147;' +
            'update Languages set  LanguageCode = "RUS" where Id = 148;' +
            'update Languages set  LanguageCode = "SAM" where Id = 149;' +
            'update Languages set  LanguageCode = "SAMIF" where Id = 150;' +
            'update Languages set  LanguageCode = "SAMLN" where Id = 151;' +
            'update Languages set  LanguageCode = "SAMLS" where Id = 152;' +
            'update Languages set  LanguageCode = "SAMNF" where Id = 153;' +
            'update Languages set  LanguageCode = "SAMNN" where Id = 154;' +
            'update Languages set  LanguageCode = "SAMNS" where Id = 155;' +
            'update Languages set  LanguageCode = "SAMSF" where Id = 156;' +
            'update Languages set  LanguageCode = "SAMSN" where Id = 157;' +
            'update Languages set  LanguageCode = "SAMSS" where Id = 158;' +
            'update Languages set  LanguageCode = "SAN" where Id = 159;' +
            'update Languages set  LanguageCode = "SEB" where Id = 160;' +
            'update Languages set  LanguageCode = "SEBBC" where Id = 161;' +
            'update Languages set  LanguageCode = "SEBBL" where Id = 162;' +
            'update Languages set  LanguageCode = "SEBC" where Id = 163;' +
            'update Languages set  LanguageCode = "SEBL" where Id = 164;' +
            'update Languages set  LanguageCode = "SES" where Id = 165;' +
            'update Languages set  LanguageCode = "SET" where Id = 166;' +
            'update Languages set  LanguageCode = "SIN" where Id = 167;' +
            'update Languages set  LanguageCode = "SINH" where Id = 168;' +
            'update Languages set  LanguageCode = "SLK" where Id = 169;' +
            'update Languages set  LanguageCode = "SLN" where Id = 170;' +
            'update Languages set  LanguageCode = "SP" where Id = 171;' +
            'update Languages set  LanguageCode = "SPA" where Id = 172;' +
            'update Languages set  LanguageCode = "SPB" where Id = 173;' +
            'update Languages set  LanguageCode = "SPCL" where Id = 174;' +
            'update Languages set  LanguageCode = "SPCB" where Id = 175;' +
            'update Languages set  LanguageCode = "SPCR" where Id = 176;' +
            'update Languages set  LanguageCode = "SPD" where Id = 177;' +
            'update Languages set  LanguageCode = "SPED" where Id = 178;' +
            'update Languages set  LanguageCode = "SPES" where Id = 179;' +
            'update Languages set  LanguageCode = "SPG" where Id = 180;' +
            'update Languages set  LanguageCode = "EPH" where Id = 181;' +
            'update Languages set  LanguageCode = "SPM" where Id = 182;' +
            'update Languages set  LanguageCode = "SPN" where Id = 183;' +
            'update Languages set  LanguageCode = "SPPN" where Id = 184;' +
            'update Languages set  LanguageCode = "SPPG" where Id = 185;' +
            'update Languages set  LanguageCode = "SPPU" where Id = 186;' +
            'update Languages set  LanguageCode = "SPPR" where Id = 187;' +
            'update Languages set  LanguageCode = "SPDM" where Id = 188;' +
            'update Languages set  LanguageCode = "SPST" where Id = 189;' +
            'update Languages set  LanguageCode = "SPU" where Id = 190;' +
            'update Languages set  LanguageCode = "SPV" where Id = 191;' +
            'update Languages set  LanguageCode = "SWA" where Id = 192;' +
            'update Languages set  LanguageCode = "SWEF" where Id = 193;' +
            'update Languages set  LanguageCode = "SWES" where Id = 194;' +
            'update Languages set  LanguageCode = "SYC" where Id = 195;' +
            'update Languages set  LanguageCode = "TAJ" where Id = 196;' +
            'update Languages set  LanguageCode = "TAM" where Id = 197;' +
            'update Languages set  LanguageCode = "TML" where Id = 198;' +
            'update Languages set  LanguageCode = "TAT" where Id = 199;' +
            'update Languages set  LanguageCode = "TEL" where Id = 200;' +
            'update Languages set  LanguageCode = "TH" where Id = 201;' +
            'update Languages set  LanguageCode = "TIB" where Id = 202;' +
            'update Languages set  LanguageCode = "TIG" where Id = 203;' +
            'update Languages set  LanguageCode = "TUR" where Id = 204;' +
            'update Languages set  LanguageCode = "TURT" where Id = 205;' +
            'update Languages set  LanguageCode = "UKR" where Id = 206;' +
            'update Languages set  LanguageCode = "USG" where Id = 207;' +
            'update Languages set  LanguageCode = "URD" where Id = 208;' +
            'update Languages set  LanguageCode = "UYG" where Id = 210;' +
            'update Languages set  LanguageCode = "UZBC" where Id = 211;' +
            'update Languages set  LanguageCode = "UZBL" where Id = 212;' +
            'update Languages set  LanguageCode = "VIT" where Id = 213;' +
            'update Languages set  LanguageCode = "WEL" where Id = 214;' +
            'update Languages set  LanguageCode = "WOL" where Id = 215;' +
            'update Languages set  LanguageCode = "YAK" where Id = 216;' +
            'update Languages set  LanguageCode = "YI" where Id = 217;' +
            'update Languages set  LanguageCode = "AZR" where Id = 219;' +
            'update Languages set  LanguageCode = "BEN" where Id = 220;' +
            'update Languages set  LanguageCode = "CRO" where Id = 221;' +
            'update Languages set  LanguageCode = "DUT" where Id = 222;' +
            'update Languages set  LanguageCode = "MALAY" where Id = 224;' +
            'update Languages set  LanguageCode = "POR" where Id = 226;' +
            'update Languages set  LanguageCode = "QUE" where Id = 227;' +
            'update Languages set  LanguageCode = "SWE" where Id = 228;' +
            'update Languages set  LanguageCode = "UZB" where Id = 229;' ;
end;*)

function TLanguageTranslationObj.LanguageName(LanguageID: Integer): String;
begin
  With TempMyQuery do try
    connection := conLanguage;
    SQL.text := 'Select Language, languagefont from Languages where Id = ' +inttoStr(LanguageID);
    open;
    if recordcount = 1 then begin
      result := fieldByname('Language').asString;
      StrTofont(Languagefont , fieldByname('Languagefont').asString);
    end else result := '';
  finally
    if active then close;
    Free;
  end;
end;

function TLanguageTranslationObj.Languages: TERPQuery;
begin
  if not(assigned(Qryl)) then begin
    Qryl:= commondblib.TempMyQuery;
    Qryl.connection := ConLanguage;
    Qryl.SQL.text:= 'Select * from languages where language =:Language';
  end;
  result := qryl;
end;


function TLanguageTranslationObj.LcList(Form: Tcomponent): TList;
begin
  result:= nil;
  try
    if form is TfrmBaseGUI then result := TfrmBaseGUI(form).LcList
    else if form is TdtmGUI then result := TdtmGUI(form).lclist;
  except
    result:= nil;
  end;
end;

procedure TLanguageTranslationObj.LoadAllEntriesforLanguage(LanguageID: Integer);
var
  s:String;
begin
  s:= {insert all new translations}
      'insert ignore into languagetranslationlocal (LanguageID , EnglishID, Modified, translation)'+
      ' Select LanguageID , englishID , '+quotedstr('F') + ', translation   ' +
        ' From languagetranslation Where languageID = ' +inttostr(LanguageID)+';' +
      {update new translations}
      'update   languagetranslation LT ' +
        ' inner join languagetranslationlocal LTL   ' +
        ' on Lt.EnglishId = LTL.EnglishId  ' +
        ' and LT.LanguageId = LTL.LanguageId '+
        ' Set LTL.translation = Lt.Translation '+
        ' where LTL.modified = "F";'+
      {insert new english entries}
      'insert ignore into languagetranslationlocal (LanguageID , EnglishID, Modified)'+
      ' Select ' +inttostr(LanguageID) +' , id , '+quotedstr('F') + ' From inenglish order by inenglish';
  with commondblib.TempMyScript do try
    connection := ConLanguage;
    SQL.add(s);
    execute;
  finally
    free;
  end;


end;
function TLanguageTranslationObj.REadforminenglish(Form:Tcomponent):String;
var
  ctr:Integer;
begin
  Result := 'Name'+#9+'Type'+#9+'Hint'+#9+'Caption';
  if (form=nil) or (LcList(Form) = nil) or (LcList(Form).count =0) then Exit;
  for ctr := 0 to LcList(Form).count-1 do begin
    with pLc(LcList(Form).Items[ctr])^ do begin
    REsult := Result + chr(13)+
      LCName+#9 +      LCType+#9 +      LChint+#9 +      LCCaption;
    end;
  end;
end;


function TLanguageTranslationObj.ConLanguage: TERPConnection;
begin
  if not Assigned(fConLanguage) then begin
    fConLanguage:= GetNewERPLanguageConnection(nil);
  end;
  result := fConLanguage;
end;

procedure TLanguageTranslationObj.setUserLanguageID(const Value: Integer);
var
  x:Integer;
  SelAddinInfo: TAddinPackageInfo;
begin
  if fiUserLanguageID = Value then exit;
  fiUserLanguageID := Value;

  if not fbIsERPRunning  then exit;

  if Assigned(Mainform) then
    DoTranslate(mainform, value);

  if assigned(dtmMainGUI) then
     DoTranslate(dtmMainGUI, value);

  if Assigned(AddInPackageList) then begin
    for x := 0 to AddinPackageList.Count - 1 do begin
      SelAddinInfo := TAddinPackageInfo(AddinPackageList[x]);
      if Assigned(SelAddinInfo.GuiDataModule) then begin
        DoTranslate(SelAddinInfo.GuiDataModule, value);
      end;
    end;
  end;


  for x := 0 to Screen.FormCount - 1 do begin
    if Screen.Forms[x] is TfrmBaseGUI then
      try
//        if TfrmBaseGUI(Screen.Forms[x]).Visible then begin
          DoTranslate(TfrmBaseGUI(Screen.Forms[x]), value);
          TfrmBaseGUI(Screen.Forms[x]).AfterTranslate;
//        end;
      except
        on E:Exception do begin
          if Commonlib.DevMode then
            MessageDlgXP_Vista(Screen.Forms[x].className +' - Language Translation Failed.' +chr(13) +chr(13) + E.Message , mtinformation, [mbok], 0);
        end;
      end;
  end;
  {to refresh the buttons on the mainmenu}
  application.Minimize;
  application.Restore;
end;

procedure TLanguageTranslationObj.stepProgressbar(Sender: TObject;
  var SQL: String; var Omit: Boolean);
begin
  ProgressDialog.DoStepProgressbar;
end;

procedure TLanguageTranslationObj.AllSynchronized(LangID:Integer);
var
  Qry :TERPQuery;
begin
  Qry :=TERPQuery.create(nil);
  try
      Qry.Connection := ConLanguage;
      (*Qry.SQL.add('update LanguageTranslation set Modified = "F" where Modified = "T" and languageId = '+inttostr(LangID) );*)
      Qry.SQL.add('delete from LanguageTranslationLocal where languageId = '+inttostr(LangID)+';' );
      Qry.SQL.add('insert ignore into LanguageTranslationLocal (LanguageId, EnglishId, Translation , Modified) '+
                  ' select  LanguageId, EnglishId, Translation , "F" from LanguageTranslation   where languageId = '+inttostr(LangID) +';');
      Qry.Execute;
  finally
    freeandnil(Qry);
  end;
end;

procedure TLanguageTranslationObj.ChangeLanguage(menuItem: TMenuItem);
begin
  UserLanguageId := menuItem.tag;
end;

procedure TLanguageTranslationObj.CleanLc(form:TComponent);
var
  pc:pLc;
  ctr,i:Integer;
begin
  CreateLcList(Form);

  System.New(pc);
  if form is Tform then begin
      pc^.lcname:= Tform(form).Name;
      pc^.LCType:= 'TForm';
      pc^.LCCaption:= Tform(form).caption;
      LcList(Form).Add(pc);
  end;
  for ctr := 0 to form.componentcount-1 do begin
    if form.components[ctr] is TLabel then begin
      System.New(pc);
      pc^.lcname:= tLabel(form.components[ctr]).Name;
      pc^.LCType:= 'TLabel';
      pc^.LChint:=tLabel(form.components[ctr]).Hint;
      pc^.LCCaption:= tLabel(form.components[ctr]).caption;
      pc^.LCFontname:= tLabel(form.components[ctr]).font.name;
      pc^.lcfontsize:= tLabel(form.components[ctr]).font.size;
      pc^.lcFontStyle:= tLabel(form.components[ctr]).font.style;
      LcList(Form).Add(pc);
    end else if form.components[ctr] is TProgressDialog then begin
      System.New(pc);
      pc^.lcname:= TProgressDialog(form.components[ctr]).Name;
      pc^.LCType:= 'TProgressDialog';
      pc^.LCCaption:= TProgressDialog(form.components[ctr]).caption;
      LcList(Form).Add(pc);
    end else if form.components[ctr] is TCustomInputBox then begin
      System.New(pc);
      pc^.lcname:= TCustomInputBox(form.components[ctr]).Name;
      pc^.LCType:= 'TCustomInputBox';
      pc^.LCCaption:= TCustomInputBox(form.components[ctr]).caption;
      LcList(Form).Add(pc);
    end else if form.components[ctr] is TMenuItem then begin
      System.New(pc);
      pc^.lcname:= TMenuItem(form.components[ctr]).Name;
      pc^.LCType:= 'TMenuItem';
      pc^.LChint:=TMenuItem(form.components[ctr]).Hint;
      pc^.LCCaption:= TMenuItem(form.components[ctr]).caption;
      LcList(Form).Add(pc);
    end else if form.components[ctr] is TDNMSpeedbutton then begin
      System.New(pc);
      pc^.lcname:= TDNMSpeedbutton(form.components[ctr]).Name;
      pc^.LCType:= 'TDNMSpeedbutton';
      pc^.LChint:=TDNMSpeedbutton(form.components[ctr]).Hint;
      pc^.LCCaption:= TDNMSpeedbutton(form.components[ctr]).caption;
      pc^.LCFontname:= TDNMSpeedbutton(form.components[ctr]).font.name;
      pc^.lcfontsize:= TDNMSpeedbutton(form.components[ctr]).font.size;
      pc^.lcFontStyle:= TDNMSpeedbutton(form.components[ctr]).font.style;
      LcList(Form).Add(pc);
    end else if form.components[ctr] is TERPMainSwitchButton then begin
      System.New(pc);
      pc^.lcname:= TERPMainSwitchButton(form.components[ctr]).Name;
      pc^.LCType:= 'TERPMainSwitchButton';
      pc^.LChint:=TERPMainSwitchButton(form.components[ctr]).Hint;
      pc^.LCCaption:= TERPMainSwitchButton(form.components[ctr]).caption;
      pc^.LCFontname:= TERPMainSwitchButton(form.components[ctr]).font.name;
      pc^.lcfontsize:= TERPMainSwitchButton(form.components[ctr]).font.size;
      pc^.lcFontStyle:= TERPMainSwitchButton(form.components[ctr]).font.style;
      LcList(Form).Add(pc);
    end else if form.components[ctr] is TToolButton then begin
      System.New(pc);
      pc^.lcname:= TToolButton(form.components[ctr]).Name;
      pc^.LCType:= 'TToolButton';
      pc^.LChint:=TToolButton(form.components[ctr]).Hint;
      pc^.LCCaption:= TToolButton(form.components[ctr]).caption;
      LcList(Form).Add(pc);
    end else if form.components[ctr] is TDNMPanel then begin
      System.New(pc);
      pc^.lcname:= TDNMPanel(form.components[ctr]).Name;
      pc^.LCType:= 'TDNMPanel';
      pc^.LChint:=TDNMPanel(form.components[ctr]).Hint;
      pc^.LCCaption:= TDNMPanel(form.components[ctr]).caption;
      pc^.LCFontname:= TDNMPanel(form.components[ctr]).font.name;
      pc^.lcfontsize:= TDNMPanel(form.components[ctr]).font.size;
      pc^.lcFontStyle:= TDNMPanel(form.components[ctr]).font.style;
      LcList(Form).Add(pc);
    end else  if form.components[ctr] is tdnmaction then begin
      System.New(pc);
      pc^.lcname:= tdnmaction(form.components[ctr]).Name;
      pc^.LCType:= 'tdnmaction';
      pc^.LChint:=tdnmaction(form.components[ctr]).Hint;
      pc^.LCCaption:= tdnmaction(form.components[ctr]).caption;
      LcList(Form).Add(pc);
    end else if form.components[ctr] is TField then begin
      System.New(pc);
      pc^.lcname:= TField(form.components[ctr]).Name;
      pc^.LCType:= 'TField';
      pc^.LCCaption:= TField(form.components[ctr]).DisplayLabel;
      LcList(Form).Add(pc);
    end else  if form.components[ctr] is ttabsheet then begin
      System.New(pc);
      pc^.lcname:= ttabsheet(form.components[ctr]).Name;
      pc^.LCType:= 'ttabsheet';
      pc^.LChint:=ttabsheet(form.components[ctr]).Hint;
      pc^.LCCaption:= ttabsheet(form.components[ctr]).caption;
      pc^.LCFontname:= ttabsheet(form.components[ctr]).font.name;
      pc^.lcfontsize:= ttabsheet(form.components[ctr]).font.size;
      pc^.lcFontStyle:= ttabsheet(form.components[ctr]).font.style;
      LcList(Form).Add(pc);
    end else  if form.components[ctr] is tform then begin
      System.New(pc);
      pc^.lcname:= tform(form.components[ctr]).Name;
      pc^.LCType:= 'tform';
      pc^.LChint:=tform(form.components[ctr]).Hint;
      pc^.LCCaption:= tform(form.components[ctr]).caption;
      pc^.LCFontname:= tform(form.components[ctr]).font.name;
      pc^.lcfontsize:= tform(form.components[ctr]).font.size;
      pc^.lcFontStyle:= tform(form.components[ctr]).font.style;
      LcList(Form).Add(pc);
    end else if form.Components[ctr] is Tcheckbox then begin
      System.New(pc);
      pc^.lcname:= Tcheckbox(form.components[ctr]).Name;
      pc^.LCType:= 'Tcheckbox';
      pc^.LChint:=Tcheckbox(form.components[ctr]).Hint;
      pc^.LCCaption:= Tcheckbox(form.components[ctr]).caption;
      pc^.LCFontname:= Tcheckbox(form.components[ctr]).font.name;
      pc^.lcfontsize:= Tcheckbox(form.components[ctr]).font.size;
      pc^.lcFontStyle:= Tcheckbox(form.components[ctr]).font.style;
      LcList(Form).Add(pc);
    end else if form.Components[ctr] is TwwCheckBox then begin
      System.New(pc);
      pc^.lcname:= TwwCheckBox(form.components[ctr]).Name;
      pc^.LCType:= 'TwwCheckBox';
      pc^.LChint:=TwwCheckBox(form.components[ctr]).Hint;
      pc^.LCCaption:= TwwCheckBox(form.components[ctr]).caption;
      pc^.LCFontname:= TwwCheckBox(form.components[ctr]).font.name;
      pc^.lcfontsize:= TwwCheckBox(form.components[ctr]).font.size;
      pc^.lcFontStyle:= TwwCheckBox(form.components[ctr]).font.style;
      LcList(Form).Add(pc);
    end else  if form.components[ctr] is TRadioGroup then begin
      System.New(pc);
      pc^.lcname:= TRadioGroup(form.components[ctr]).Name;
      pc^.LCType:= 'TRadioGroup';
      pc^.LChint:=TRadioGroup(form.components[ctr]).Hint;
      pc^.LCCaption:=TRadioGroup(form.components[ctr]).Caption;
      pc^.LCItemIndex :=-1;
      pc^.LCFontname:= TRadioGroup(form.components[ctr]).font.name;
      pc^.lcfontsize:= TRadioGroup(form.components[ctr]).font.size;
      pc^.lcFontStyle:= TRadioGroup(form.components[ctr]).font.style;
      LcList(Form).Add(pc);

      if TRadioGroup(form.components[ctr]).Items.Count >0 then
        for i := 0 to TRadioGroup(form.components[ctr]).Items.count-1 do begin
          System.New(pc);
          pc^.lcname:= TRadioGroup(form.components[ctr]).Name;
          pc^.LCType:= 'TRadioGroup';
          pc^.LChint:=TRadioGroup(form.components[ctr]).Hint;
          pc^.LCCaption:=TRadioGroup(form.components[ctr]).Caption;
          pc^.LCItemIndex :=i;
          pc^.LCCaption:= TRadioGroup(form.components[ctr]).items[i];
          pc^.LCFontname:= TRadioGroup(form.components[ctr]).font.name;
          pc^.lcfontsize:= TRadioGroup(form.components[ctr]).font.size;
          pc^.lcFontStyle:= TRadioGroup(form.components[ctr]).font.style;
          LcList(Form).Add(pc);
        end;
    end else  if form.components[ctr] is TwwRadioGroup then begin
      System.New(pc);
      pc^.lcname:= TwwRadioGroup(form.components[ctr]).Name;
      pc^.LCType:= 'TwwRadioGroup';
      pc^.LChint:=TwwRadioGroup(form.components[ctr]).Hint;
      pc^.LCCaption:=TwwRadioGroup(form.components[ctr]).Caption;
      pc^.LCItemIndex :=-1;
      pc^.LCFontname:= TwwRadioGroup(form.components[ctr]).font.name;
      pc^.lcfontsize:= TwwRadioGroup(form.components[ctr]).font.size;
      pc^.lcFontStyle:= TwwRadioGroup(form.components[ctr]).font.style;
      LcList(Form).Add(pc);

      if TwwRadioGroup(form.components[ctr]).Items.Count >0 then
        for i := 0 to TwwRadioGroup(form.components[ctr]).Items.count-1 do begin
          System.New(pc);
          pc^.lcname:= TwwRadioGroup(form.components[ctr]).Name;
          pc^.LCType:= 'TwwRadioGroup';
          pc^.LChint:=TwwRadioGroup(form.components[ctr]).Hint;
          pc^.LCCaption:=TwwRadioGroup(form.components[ctr]).Caption;
          pc^.LCItemIndex :=i;
          pc^.LCCaption:= TwwRadioGroup(form.components[ctr]).items[i];
          pc^.LCFontname:= TwwRadioGroup(form.components[ctr]).font.name;
          pc^.lcfontsize:= TwwRadioGroup(form.components[ctr]).font.size;
          pc^.lcFontStyle:= TwwRadioGroup(form.components[ctr]).font.style;
          LcList(Form).Add(pc);
        end;
    end else  if form.components[ctr] is TAdvStringGrid then begin
      if TAdvStringGrid(form.components[ctr]).ColumnHeaders.Count >0 then
        for i := 0 to TAdvStringGrid(form.components[ctr]).ColumnHeaders.count-1 do begin
          System.New(pc);
          pc^.lcname:= TAdvStringGrid(form.components[ctr]).Name;
          pc^.LCType:= 'TAdvStringGrid';
          pc^.LChint:=TAdvStringGrid(form.components[ctr]).Hint;
          pc^.LCItemIndex :=i;
          pc^.LCCaption:= TAdvStringGrid(form.components[ctr]).ColumnHeaders[i];
          pc^.LCFontname:= TAdvStringGrid(form.components[ctr]).font.name;
          pc^.lcfontsize:= TAdvStringGrid(form.components[ctr]).font.size;
          pc^.lcFontStyle:= TAdvStringGrid(form.components[ctr]).font.style;
          LcList(Form).Add(pc);
        end;
    end;
  end;
end;
procedure TLanguageTranslationObj.AddLcItem(form: TComponent; Sender:Tcomponent;Value: String);
var
  ctr:Integer;
  pc:pLc;
begin
  for ctr := 0 to LcList(Form).count-1 do begin
    with pLc(LcList(Form).Items[ctr])^ do begin
      if sameText(sender.name, lcname) and sameText(sender.classname, lctype)  then begin
        LCCaption := Value;
        exit;
      end;
    end;
  end;
  System.New(pc);
  pc^.lcname:= Sender.Name;
  pc^.LCType:= Sender.classname;
  pc^.LCCaption:= Value;
  pc^.LCFontname:= TLanguageTranslationObj.Inst.Languagefont.name;
  pc^.lcfontsize:= TLanguageTranslationObj.Inst.Languagefont.size;
  pc^.lcFontStyle:= TLanguageTranslationObj.Inst.Languagefont.style;
  LcList(Form).Add(pc);
end;
Procedure StrTofont(fFont:TFont ; sfont:String);
var
    st:TStringList;
begin
  try
    if fFont = nil then fFont := Tfont.create;
    {default fFont}
    fFont.name := 'Arial';
    fFont.size:= 9;
    fFont.style := [fsBold];

    if sfont <>'' then begin
      Split(sfont , ';' , st);
      if st.Count>= 1 then fFont.Name:= st[0];
      if st.Count>= 2 then fFont.Size:= strToint(st[1]);
      if st.Count>= 3 then
             if SameText(st[2] ,'[fsBold, fsItalic]') then fFont.Style := [fsBold, fsItalic]
        else if SameText(st[2] ,'[fsItalic]')         then fFont.Style := [fsItalic]
        else if SameText(st[2] ,'[fsBold]')           then fFont.Style := [fsBold]
        else if SameText(st[2] ,'[]')                 then fFont.Style := []
        else fFont.Style := [];
    end;
  finally
    freeandNil(st);
  end;
end;

initialization

finalization
  fLanguageTranslationObj.Free;
  fLanguageTranslationObj:= nil;
end.

