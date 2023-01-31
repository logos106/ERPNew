unit frmtaxscaleCalc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls;

type

  TTaxslabs = record
    FromValue: Double;
    ToValue: double;
    TaxRate :double;
  end;

  TfmtaxscaleCalc = class(TBaseInputGUI)
    btnSAunder65: TButton;
    btnAus: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSAunder65Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAusClick(Sender: TObject);
  private
    SATaxSlabsUnder65 : Array [1..6] of TTaxslabs;
    AusTaxSlabs : Array [1..4] of TTaxslabs;
  public
  end;


implementation

uses CommonLib, CommonDbLib,  tcDataUtils;

{$R *.dfm}
procedure TfmtaxscaleCalc.btnAusClick(Sender: TObject);
var
  ctr :Integer;
  Slab :Integer;
  TaxRate :double;
  Tax :double;
begin
  inherited;
  With tempMyScript do try
    SQL.add('Drop TABLE if exists tmp_AusSlabScales ;');

    SQL.add('CREATE TABLE tmp_AusSlabScales ( '+
              ' ID INT NULL, '+
              ' 	Category INT NULL, '+
              ' 	WeeklyIncome DOUBLE NULL, '+
              ' 	Slab INT NULL, '+
              ' 	TaxRate DOUBLE NULL, '+
              ' 	Tax DOUBLE NULL '+
              ' )  ENGINE=MyISAM;');

    DoShowProgressbar(15000 , 'Please Wait', '' , False);
    try
      for ctr := 0 to 15000 do begin
        if ctr < ausTaxslabs[1].fromValue then begin
          slab := 0;
          Taxrate := 0;
          Tax     := 0;
        end else if ctr < ausTaxslabs[2].fromValue then begin
          slab := 1;
          Taxrate := ausTaxslabs[1].taxrate;
          Tax     := (ctr-ausTaxslabs[1].fromValue)* ausTaxslabs[1].taxrate /100;
        end else if ctr < ausTaxslabs[3].fromValue then begin
          slab := 2;
          Taxrate := ausTaxslabs[2].taxrate;
          Tax := ((ausTaxslabs[1].toValue-ausTaxslabs[1].fromValue) *ausTaxslabs[1].taxrate/100) +
                (ctr-ausTaxslabs[1].toValue *ausTaxslabs[2].taxrate/100)
        end else if ctr < ausTaxslabs[4].fromValue then begin
          slab := 2;
          Taxrate := ausTaxslabs[3].taxrate;
          Tax := ((ausTaxslabs[1].toValue-ausTaxslabs[1].fromValue) *ausTaxslabs[1].taxrate/100) +
                ((ausTaxslabs[2].toValue-ausTaxslabs[1].toValue) *ausTaxslabs[2].taxrate/100) +
                (ctr-ausTaxslabs[2].toValue *ausTaxslabs[3].taxrate/100);
        end else begin
          slab := 3;
          Taxrate := ausTaxslabs[4].taxrate;
          Tax := ((ausTaxslabs[1].toValue-ausTaxslabs[1].fromValue) *ausTaxslabs[1].taxrate/100) +
                ((ausTaxslabs[2].toValue-ausTaxslabs[1].toValue) *ausTaxslabs[2].taxrate/100) +
                ((ausTaxslabs[3].toValue-ausTaxslabs[2].toValue) *ausTaxslabs[3].taxrate/100) +
                (ctr-ausTaxslabs[3].toValue *ausTaxslabs[4].taxrate/100);
        end;
        SQL.add('insert ignore into tmp_AusSlabScales (Category , WeeklyIncome, Slab , TaxRate, Tax) Values (1 , ' +inttostr(ctr) +',' +inttostr(slab) +',' +floatToStr(TaxRate)+',' +floatTostr(Round(Tax,0))+');');
        DoStepProgressbar;
      end;
    finally
      DoHideProgressbar;
    end;
    execute;
  finally
    Free;
  end;

end;

procedure TfmtaxscaleCalc.btnSAunder65Click(Sender: TObject);
var
  ctr :Integer;
  Slab :Integer;
  TaxRate :double;
  Tax :double;
begin
  inherited;
  With tempMyScript do try
    SQL.add('Drop TABLE if exists tmp_SATaxScales ;');

    SQL.add('CREATE TABLE tmp_SATaxScales ( '+
              ' ID INT NULL, '+
              ' 	Category INT NULL, '+
              ' 	WeeklyIncome DOUBLE NULL, '+
              ' 	Slab INT NULL, '+
              ' 	TaxRate DOUBLE NULL, '+
              ' 	Tax DOUBLE NULL '+
              ' )  ENGINE=MyISAM;');

    DoShowProgressbar(15000 , 'Please Wait', '' , False);
    try
      for ctr := 0 to 15000 do begin
        if ctr < SATaxSlabsUnder65[1].fromValue then begin
          slab := 0;
          Taxrate := 0;
          Tax     := 0;
        end else if ctr < SATaxSlabsUnder65[2].fromValue then begin
          slab := 1;
          Taxrate := SATaxSlabsUnder65[1].taxrate;
          Tax     := (ctr-SATaxSlabsUnder65[1].fromValue)* SATaxSlabsUnder65[1].taxrate /100;
        end else if ctr < SATaxSlabsUnder65[3].fromValue then begin
          slab := 2;
          Taxrate := SATaxSlabsUnder65[2].taxrate;
          Tax := ((SATaxSlabsUnder65[1].toValue-SATaxSlabsUnder65[1].fromValue) *SATaxSlabsUnder65[1].taxrate/100) +
                (ctr-SATaxSlabsUnder65[1].toValue *SATaxSlabsUnder65[2].taxrate/100)
        end else if ctr < SATaxSlabsUnder65[4].fromValue then begin
          slab := 2;
          Taxrate := SATaxSlabsUnder65[3].taxrate;
          Tax := ((SATaxSlabsUnder65[1].toValue-SATaxSlabsUnder65[1].fromValue) *SATaxSlabsUnder65[1].taxrate/100) +
                ((SATaxSlabsUnder65[2].toValue-SATaxSlabsUnder65[1].toValue) *SATaxSlabsUnder65[2].taxrate/100) +
                (ctr-SATaxSlabsUnder65[2].toValue *SATaxSlabsUnder65[3].taxrate/100);
        end else if ctr < SATaxSlabsUnder65[5].fromValue then begin
          slab := 3;
          Taxrate := SATaxSlabsUnder65[4].taxrate;
          Tax := ((SATaxSlabsUnder65[1].toValue-SATaxSlabsUnder65[1].fromValue) *SATaxSlabsUnder65[1].taxrate/100) +
                ((SATaxSlabsUnder65[2].toValue-SATaxSlabsUnder65[1].toValue) *SATaxSlabsUnder65[2].taxrate/100) +
                ((SATaxSlabsUnder65[3].toValue-SATaxSlabsUnder65[2].toValue) *SATaxSlabsUnder65[3].taxrate/100) +
                (ctr-SATaxSlabsUnder65[3].toValue *SATaxSlabsUnder65[4].taxrate/100);
        end else if ctr < SATaxSlabsUnder65[6].fromValue then begin
          slab := 4;
          Taxrate := SATaxSlabsUnder65[5].taxrate;
          Tax := ((SATaxSlabsUnder65[1].toValue-SATaxSlabsUnder65[1].fromValue) *SATaxSlabsUnder65[1].taxrate/100) +
                ((SATaxSlabsUnder65[2].toValue-SATaxSlabsUnder65[1].toValue) *SATaxSlabsUnder65[2].taxrate/100) +
                ((SATaxSlabsUnder65[3].toValue-SATaxSlabsUnder65[2].toValue) *SATaxSlabsUnder65[3].taxrate/100) +
                ((SATaxSlabsUnder65[4].toValue-SATaxSlabsUnder65[3].toValue) *SATaxSlabsUnder65[4].taxrate/100) +
                (ctr-SATaxSlabsUnder65[4].toValue *SATaxSlabsUnder65[5].taxrate/100);
        end else begin
          slab := 4;
          Taxrate := SATaxSlabsUnder65[5].taxrate;
          Tax := ((SATaxSlabsUnder65[1].toValue-SATaxSlabsUnder65[1].fromValue) *SATaxSlabsUnder65[1].taxrate/100) +
                ((SATaxSlabsUnder65[2].toValue-SATaxSlabsUnder65[1].toValue) *SATaxSlabsUnder65[2].taxrate/100) +
                ((SATaxSlabsUnder65[3].toValue-SATaxSlabsUnder65[2].toValue) *SATaxSlabsUnder65[3].taxrate/100) +
                ((SATaxSlabsUnder65[4].toValue-SATaxSlabsUnder65[3].toValue) *SATaxSlabsUnder65[4].taxrate/100) +
                ((SATaxSlabsUnder65[5].toValue-SATaxSlabsUnder65[4].toValue) *SATaxSlabsUnder65[5].taxrate/100) +
                (ctr-SATaxSlabsUnder65[5].toValue *SATaxSlabsUnder65[6].taxrate/100);
        end;
        SQL.add('insert ignore into tmp_SATaxScales (Category , WeeklyIncome, Slab , TaxRate, Tax) Values (1 , ' +inttostr(ctr) +',' +inttostr(slab) +',' +floatToStr(TaxRate)+',' +floatTostr(Round(Tax,0))+');');
        DoStepProgressbar;
      end;
    finally
      DoHideProgressbar;
    end;
    execute;
  finally
    Free;
  end;
end;

procedure TfmtaxscaleCalc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmtaxscaleCalc.FormCreate(Sender: TObject);
begin
  inherited;
  SATaxSlabsUnder65[1].FromValue :=1290.60;       SATaxSlabsUnder65[1].ToValue :=165600.00;  SATaxSlabsUnder65[1].TaxRate :=18.00;
  SATaxSlabsUnder65[2].FromValue :=165601.00;  SATaxSlabsUnder65[2].ToValue :=258750.00;  SATaxSlabsUnder65[2].TaxRate :=25.00;
  SATaxSlabsUnder65[3].FromValue :=258751.00;  SATaxSlabsUnder65[3].ToValue :=358110.00;  SATaxSlabsUnder65[3].TaxRate :=30.00;
  SATaxSlabsUnder65[4].FromValue :=358111.00;  SATaxSlabsUnder65[4].ToValue :=500940.00;  SATaxSlabsUnder65[4].TaxRate :=35.00;
  SATaxSlabsUnder65[5].FromValue :=500941.00;  SATaxSlabsUnder65[5].ToValue :=638600.00;  SATaxSlabsUnder65[5].TaxRate :=38.00;
  SATaxSlabsUnder65[6].FromValue :=638601.00;  SATaxSlabsUnder65[6].ToValue :=0;          SATaxSlabsUnder65[6].TaxRate :=40.00;

  AusTaxSlabs[1].FromValue :=350.02;   AusTaxSlabs[1].ToValue :=711.54;   AusTaxSlabs[1].TaxRate :=19.00;
  AusTaxSlabs[2].FromValue :=711.56;   AusTaxSlabs[2].ToValue :=1538.46;  AusTaxSlabs[2].TaxRate :=32.5;
  AusTaxSlabs[3].FromValue :=1538.48;  AusTaxSlabs[3].ToValue :=3461.54;  AusTaxSlabs[3].TaxRate :=37.00;
  AusTaxSlabs[4].FromValue :=3461.56;  AusTaxSlabs[4].ToValue :=0;        AusTaxSlabs[4].TaxRate :=45.00;

end;

initialization
  RegisterClassOnce(TfmtaxscaleCalc);

end.

