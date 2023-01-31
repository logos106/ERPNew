unit fraModGenericConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fraUtilsConfigBase, DNMSpeedButton, StdCtrls, wwclearbuttongroup,
  wwradiogroup, ExtCtrls;

type
  TfrModGenericConfig = class(TfrUtilsConfigBase)
    lblModuleName: TLabel;
    Bevel1: TBevel;
    rgLoggingLevel: TwwRadioGroup;
    btnShowLog: TDNMSpeedButton;
    procedure btnShowLogClick(Sender: TObject);
  private
  protected
//    function GetModuleName: string; override;
    procedure AfterGetModuleConfig; override;
    procedure SetModuleName(const Value: string); override;
  public
    { Public declarations }
  end;

var
  frModGenericConfig: TfrModGenericConfig;

implementation

uses
  Character;

{$R *.dfm}

procedure TfrModGenericConfig.AfterGetModuleConfig;
begin
  inherited;

end;

procedure TfrModGenericConfig.btnShowLogClick(Sender: TObject);
begin
  inherited;
  ShowLog;
end;

procedure TfrModGenericConfig.SetModuleName(const Value: string);
var
  s, cap: string;
  x: integer;
begin
  inherited;
  cap:= '';
  if Pos('ERPMod',Value) = 1 then
    s:= Copy(Value,7,MaxInt)
  else
    s := Value;
  for x := 1 to Length(s) do begin
    if IsUpper(s[x]) then begin
      if (x > 1) then begin
        cap := cap + ' ';
        cap := cap + s[x];
      end
      else
        cap := cap + s[x];
    end
    else
      cap := cap + s[x];
  end;
  lblModuleName.Caption := cap;
end;

end.
