unit frmBaseListDateSelectionOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, StdCtrls, Spin, DNMSpeedButton, ExtCtrls, DNMPanel,
  SelectionDialog, Menus , BaseListingForm, dateutils;

type
  TfmBaseListDateSelectionOptions = class(TBaseForm)
    pnlMain: TDNMPanel;
    DNMSpeedButton1: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    edt: TSpinEdit;
    cbo: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
  private
    fBaselist : TBaseListingGUI ;
  public

  end;

implementation


{$R *.dfm}

{ TfmBaseListDateSelectionOptions }

procedure TfmBaseListDateSelectionOptions.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  fBaselist.dtTo.Date := fBaselist.dtfrom.Date;
       if cbo.itemindex =0 then fBaselist.dtfrom.Date := incday(fBaselist.dtfrom.Date ,0-edt.Value)
  else if cbo.itemindex =1 then fBaselist.dtfrom.Date := incWeek(fBaselist.dtfrom.Date ,0-edt.Value)
  else if cbo.itemindex =2 then fBaselist.dtfrom.Date := incmonth(fBaselist.dtfrom.Date ,0-edt.Value)
  else if cbo.itemindex =3 then fBaselist.dtfrom.Date := incyear(fBaselist.dtfrom.Date ,0-edt.Value)
  else exit;
  fbaselist.btnRequery.click;

end;

procedure TfmBaseListDateSelectionOptions.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  fBaselist.dtfrom.Date := fBaselist.dtto.Date;
       if cbo.itemindex =0 then fBaselist.dtto.Date := incday(fBaselist.dtto.Date ,edt.Value)
  else if cbo.itemindex =1 then fBaselist.dtto.Date := incWeek(fBaselist.dtto.Date ,edt.Value)
  else if cbo.itemindex =2 then fBaselist.dtto.Date := incmonth(fBaselist.dtto.Date ,edt.Value)
  else if cbo.itemindex =3 then fBaselist.dtto.Date := incyear(fBaselist.dtto.Date ,edt.Value)
  else exit;
  fbaselist.btnRequery.click;

end;

procedure TfmBaseListDateSelectionOptions.FormCreate(Sender: TObject);
begin
  inherited;
  if Assigned(Owner) and (Owner is TBaseListingGUI) then begin
    fBaselist := TBaseListingGUI(Owner);
    pnlmain.parent :=fBaselist.TitleShader.parent;
    pnlmain.align :=alright;
    pnlmain.width := 280;
  end;
end;

end.
