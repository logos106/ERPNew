unit frmPartsSubBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Menus, ExtCtrls, StdCtrls, DNMPanel , frmPartsFrm;

type
  TfmPartsSubBase = class(TfrmBaseGUI)
    pnlMain: TDNMPanel;
  private
    { Private declarations }
  Protected
    function PartsForm :TfrmParts;
  public
    Procedure InitInstance(ParentPanel :TDnmPanel);virtual;
    Class function  Makeinstance(AOwner :TfrmParts; ParentPanel :TDnmPanel):TfmPartsSubBase;  virtual;abstract;
    //Class Function Makeinstance(AOwner :TfrmParts):TfmPartsSubBase;  Overload;virtual;abstract;
  end;


implementation

uses CommonDbLib;


{$R *.dfm}

{ TfmPartsSubBase }

function TfmPartsSubBase.PartsForm: TfrmParts;
begin
  result := TfrmParts(Owner);
end;

procedure TfmPartsSubBase.InitInstance(ParentPanel :TDnmPanel);
begin
  pnlmain.Parent := ParentPanel;
  pnlmain.align := alclient;
end;

end.
