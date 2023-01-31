unit frmComboInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls, DNMSpeedButton, Menus, ExtCtrls;

type
  TfmComboInput = class(TfrmBaseGUI)
    lblMsg: TLabel;
    cboInput: TComboBox;
    cmdPrint: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
  private
    Procedure SaveToFile(filename, Value:String);
  public

  end;

Function ComboInput(FileName, Inputcaption, InputMsg:String;ForceInput:Boolean):String;

implementation

{$R *.dfm}

{ TfmComboInput }

function ComboInput(FileName, Inputcaption, InputMsg: String;ForceInput:Boolean): String;
var
  Form :TfmComboInput;
begin
  REsult := '';
  Form := TfmComboInput.Create(nil);
  try
    With Form do begin
      Caption := InputCaption;
      LblMsg.Caption := InputMsg;
      CboInput.Clear;
      if FileExists(FileName) then CboInput.Items.LoadFromFile(FileName);
      if CboInput.Items.Count>0 then CboInput.Text := CboInput.Items[0];
      if not ForceInput then
        if CboInput.Text <> '' then begin
          result := CboInput.Text;
          Exit;
        end;
      if showModal = mrOk then begin
        result :=CboInput.text;
        if fileName <> '' then SaveToFile(filename, result);
      end;
    end;
  finally
      FreeandNil(form);
  end;
end;

{ TfmComboInput }

procedure TfmComboInput.SaveToFile(filename, Value: String);
var
  st:TStringlist;
begin

    st:= TStringlist.Create;
    try
      if fileExists(fileName) then begin
        st.LoadFromFile(filename);
        if st.IndexOf(Value) <0 then begin
          st.Insert(0 , Value);
          St.SaveToFile(filename);
        end else if st.IndexOf(Value) <> 0 then begin
          St.Move(st.IndexOf(Value) , 0);
          St.SaveToFile(filename);
        end;
      end else begin
        st.add(Value);
        St.SaveToFile(filename);
      end;
    finally
      FreeandNil(st);
    end;
end;

end.

