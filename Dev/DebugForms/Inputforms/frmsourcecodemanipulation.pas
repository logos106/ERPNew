unit frmsourcecodemanipulation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Shader, DNMSpeedButton, ExtCtrls,
  DNMPanel;
const
  lablecaption='.caption';
type
  Tfmsourcecodemanipulation = class(TForm)
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel1: TDNMPanel;
    memdetails: TMemo;
    DNMPanel2: TDNMPanel;
    btnExportEnglishconst: TButton;
    edtFilename: TEdit;
    DNMSpeedButton1: TDNMSpeedButton;
    memProjectFiles: TMemo;
    edtProjectFile: TEdit;
    procedure btnExportEnglishconstClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure PopulatepasList;
  public

  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure Tfmsourcecodemanipulation.btnExportEnglishconstClick(Sender: TObject);
begin
  memProjectFiles.Clear;
  PopulatepasList;
  for ctr:= 0 to memProjectFiles.Lines.count-1 do begin
    if FileExists(memProjectFiles.lines[ctr]) then begin
        replacecaptopn(memProjectFiles.lines[ctr]);
    end;
  end;
end;

procedure Tfmsourcecodemanipulation.ReplaceCaption(filename:String);
var
  ctr,x,y, captionpos,equalpos,startpos, endPos:TCursor;
  sl, resultsl: TStringList;
  str1, str2:String;
  found:boolean;
  s1:String;

begin

      sl:= TStringList.Create;
      resultsl:= TStringList.Create;
      try
        sl.LoadFromFile(filename);
        for x:= 1 to sl.count-1 do begin
            str1:= str1+ trim(sl[x]);
              if str1[length(str1)-1) <> ';' then continue;

            ReplaceStr(str1 , labelcaption, labelcaption ); // to make it small letter as the POS function is case-sensitive

            captionpos:=  pos(labelcaption , str1);
            if captionpos >0 then begin
              found := False;
              for y := captionpos+ length(labelcaption) to length(str1)-2 do begin
                if copy(str1 , y, 2) = ':=' then begin
                  equalpos := y;
                  found:= true;
                  break;
                end;
              end;
              if not found then begin
                str1:= '';
                break;
              end;

              startpos:= 0;
              for y:= captionpos-1 downto 0 do
                if str1[y] = ';' then begin
                  startpos:= y;
                  break;
                end;

              endPos:=0;
              for y:= equalpos+1 to length(str1)-1 do
                if str1[y] = ';' then begin
                  endPos:= y;
                  break;
                end;

              if startpos <> 0 then str2:= copy(str1, 1, startpos);
              str2:= str2+'ChangeCaption(';
              str2:= str2+ copy(str1, startpos+1 , captionpos);
              str2:= str2+ ',';
              str2:= str2+ copy(str1, equalpos+2, endpos);
              resultsl.add(str2);
            end else begin
              resultsl.add(str1);
            end;
            str1:= '';
        end;
      finally
        freeandNil(sl);
        FreeandNil(resultsl);
      end;

    end;
  end;
end;

procedure Tfmsourcecodemanipulation.FormCreate(Sender: TObject);
begin
  edtProjectFile.Text:= Replacestr(Application.ExeName , '.exe', '.dpr');
end;

procedure Tfmsourcecodemanipulation.PopulatepasList;
var
  sl,ss: TStringList;
  x: integer;
  s: string;
  pasList: TStringList;
begin
  pasList:= TStringList.Create;
  try
    if FileExists(edtProjectFile.text) then begin
      sl:= TStringList.Create;
      ss:= TStringList.Create;
      try
        sl.LoadFromFile(edtProjectFile.text);
        for x:= 0 to sl.Count -1 do begin
          ss.CommaText:= sl[x];
          if ((ss.count = 5) or ((ss.count = 4) and (Copy(ss[3],Length(ss[3]),1) = ';'))) and
            (ss[1] = 'in') then begin
            s:= Copy(ss[2],2, Pos(ExtractFileExt(ss[2]),ss[2])-2) + '.pas';
            pasList.Add(s);
            memProjectFiles.Lines.Add(s);
          end;
        end;
      finally
        sl.Free;
        ss.Free;
      end;
    end;
  finally
    FreeandNil(pasList);

  end;


end;
initialization
  RegisterClassOnce(Tfmsourcecodemanipulation);

end.
