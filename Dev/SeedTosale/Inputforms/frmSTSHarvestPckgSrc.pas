unit frmSTSHarvestPckgSrc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb, Spin, DB, wwdblook;

type
  TfmHarvestPckgSrc = class(TFrame)
    lblHarvestName: TLabel;
    lbQty: TLabel;
    lb1: TLabel;
    lb2: TLabel;
    cbbHarvestName: TComboBox;
    edtPackgQty: TEdit;
    edtHarvestQty: TEdit;
    lbInfo: TLabel;
    lbHarvestUnits: TLabel;
    Label1: TLabel;
    cbbPackgUnits: TwwDBLookupCombo;
    procedure edtHarvestQtyKeyPress(Sender: TObject; var Key: Char);
    procedure cbbHarvestNameChange(Sender: TObject);
    procedure edtHarvestQtyExit(Sender: TObject);
    procedure edtHarvestQtyChange(Sender: TObject);
  private
    FOnHarvestChange: TNotifyEvent;
    FOnHarvestQtyExit: TNotifyEvent;
    FOnHarvestQtyChange: TNotifyEvent;
  public
    property OnHarvestChange:    TNotifyEvent read FOnHarvestChange    write FOnHarvestChange;
    property OnHarvestQtyExit:   TNotifyEvent read FOnHarvestQtyExit   write FOnHarvestQtyExit;
    property OnHarvestQtyChange: TNotifyEvent read FOnHarvestQtyChange write FOnHarvestQtyChange;
  end;

implementation

{$R *.dfm}

uses
  Math;

{ TfmHarvestPckgSrc }

procedure TfmHarvestPckgSrc.cbbHarvestNameChange(Sender: TObject);
begin
  if Assigned(FOnHarvestChange) then
    FOnHarvestChange(Sender);
end;

procedure TfmHarvestPckgSrc.edtHarvestQtyChange(Sender: TObject);
begin
  if Assigned(FOnHarvestQtyChange) then
    FOnHarvestQtyChange(Sender);
end;

procedure TfmHarvestPckgSrc.edtHarvestQtyExit(Sender: TObject);
begin
  if Assigned(FOnHarvestQtyExit) then
    FOnHarvestQtyExit(Sender);
end;

procedure TfmHarvestPckgSrc.edtHarvestQtyKeyPress(Sender: TObject; var Key: Char);
var
  fmtSettings: TFormatSettings;
  charDecimalSep: Char;
begin
  fmtSettings := TFormatSettings.Create;
  charDecimalSep := fmtSettings.DecimalSeparator;

  // allow numbers, point, comma and BackSpace to be entered
  if not CharInSet(Key,['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ',', '.', #8]) then Key := #0;

  // replace wrong decimal separator
  if charDecimalSep = '.' then
    if Key = ',' then Key := '.';

  if charDecimalSep = ',' then
    if Key = '.' then Key := ',';

end;


end.
