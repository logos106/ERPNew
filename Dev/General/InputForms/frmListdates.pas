unit frmListdates;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs , frmBase, DNMSpeedButton, StdCtrls,
  wwdbdatetimepicker, Menus, ExtCtrls;

type
  TfmListdates = class(TfrmBaseGUI)
    lblFrom: TLabel;
    dtFrom: TwwDBDateTimePicker;
    lblTo: TLabel;
    dtTo: TwwDBDateTimePicker;
    btnOk: TDNMSpeedButton;
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
  public
  end;


implementation

uses BaseListingForm ;

{$R *.dfm}

procedure TfmListdates.btnOkClick(Sender: TObject);
begin
  inherited;
  if Assigned(Owner) then
    if owner is TBaseListingGUI then begin
      TBaseListingGUI(Owner).Dtfrom.date := Dtfrom.date;
      TBaseListingGUI(Owner).DtTo.Date := DtTo.date;
      TBaseListingGUI(Owner).Refreshdates;
      Self.close;
    end;
end;

procedure TfmListdates.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
end;

procedure TfmListdates.FormShow(Sender: TObject);
begin
  inherited;
  if Assigned(Owner) then
    if owner is TBaseListingGUI then begin
      dtFrom.date :=TBaseListingGUI(OwneR).dtfrom.date;
      dtto.date :=TBaseListingGUI(OwneR).dtto.date;
    end;
end;

end.
