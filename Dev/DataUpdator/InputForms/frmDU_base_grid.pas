unit frmDU_base_grid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DNMPanel, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, DB, DNMSpeedButton, wwclearbuttongroup, wwradiogroup, wwdblook,
  MemDS, DBAccess, MyAccess, frmBase, frmDU_base, Shader, Menus ;
type
  TfmDU_base_grid = class(TfmDU_base)
    grdmain: TwwDBGrid;
    dsmain: TDataSource;
    btnDelete: TwwIButton;
    OptVariation: TwwRadioGroup;
    opttype: TwwRadioGroup;
  private
  Protected
    function Formhint :string;virtual;abstract;
    Procedure openQueries;
    function Qrymain:TDataset;
  public
    Procedure ShowFormHint;override;
    Class Function  MakeInstance(AOwner:TComponent; ParentPanel:TDNMPanel) :TfmDU_base ;overload;Override;
  end;


implementation

uses frmDataUpdator, tcConst,ERPdbComponents, CommonDbLib;

{$R *.dfm}

{ TfmDU_base_grid }



class function TfmDU_base_grid.MakeInstance(AOwner: TComponent;  ParentPanel: TDNMPanel): TfmDU_base;
begin
  result:= inherited MakeInstance(AOwner,ParentPanel);
  TfmDU_base_grid(Result).grdmain.Align := alclient;
end;

procedure TfmDU_base_grid.openQueries;
var
  ctr:Integer;
begin
  if not(Owner is TfmDataUpdator) then exit;
  for ctr:= 0 to componentcount-1 do begin
    if components[ctr] is TERPQuery then begin
      TERPQuery(Components[ctr]).connection := TfmDataUpdator(Owner).MyConnection;
      opendb(TERPQuery(Components[ctr]));
    end;
  end;

end;

function TfmDU_base_grid.Qrymain: TDataset;
begin
  result:= grdmain.datasource.dataset;
end;

procedure TfmDU_base_grid.ShowFormHint;
begin
  grdmain.hint := Formhint+NL;
  grdmain.showhint := True;
end;

end.




