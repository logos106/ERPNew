unit frmDU_base;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, ExtCtrls, StdCtrls, DNMPanel, Shader, Menus;

type
  TfmDU_base = class(TfrmBaseGUI)
    pnlmain: TDNMPanel;
    pnlTop: TDNMPanel;
    Shader1: TShader;
    pnlDEtails: TDNMPanel;
  private
  protected
    class function MakeInstance(AOwner:TComponent): TfmDU_base;overload; virtual;abstract;
    function MainForm :TForm;
  public
    procedure OpenQueries;
    Class Function  MakeInstance(AOwner:TComponent; ParentPanel:TDNMPanel) :TfmDU_base ;overload;virtual;
    Procedure ShowFormHint;virtual;
  end;

implementation

uses MyAccess,CommonLib, frmDataUpdator;

{$R *.dfm}

procedure TfmDU_base.OpenQueries;
var
  iIndex: integer;
begin
      try
        ProcessingCursor;
        for iIndex := 0 to  Self.ComponentCount-1 do
          if Self.Components[iIndex] is TCustomMyDataSet then
            with Self.Components[iIndex] as TCustomMyDataSet do begin
              connection := TfmDataUpdator(Self.Owner).MyConnection;
              Open;
            end;
      finally
        ProcessingCursor(False);
      end;
end;

function TfmDU_base.MainForm: TForm;
begin
  REsult :=TfmDataUpdator(Self.Owner);
end;

class function TfmDU_base.MakeInstance(AOwner: TComponent;ParentPanel: TDNMPanel): TfmDU_base;
begin
    Result:=MakeInstance(AOwner);
    Result.pnlmain.Parent := ParentPanel;
    Result.pnlmain.Align := alclient;
    Result.Shader1.FromColor :=ParentPanel.color;
    Result.Shader1.ToColorMirror :=ParentPanel.color;
end;

procedure TfmDU_base.ShowFormHint;
begin
end;

end.

