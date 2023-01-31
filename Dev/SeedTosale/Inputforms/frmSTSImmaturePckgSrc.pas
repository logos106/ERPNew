unit frmSTSImmaturePckgSrc;

interface

uses
  Windows, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwdbedit, Wwdotdot, Wwdbcomb, ExtCtrls, Buttons, Grids, Wwdbigrd, Wwdbgrid,
  DB, MemDS, DBAccess, MyAccess, ERPdbComponents, BusObjSeedToSale;

type
  TfmImmaturePckgSrc = class(TFrame)
    lblStrain: TLabel;
    pnlMain: TPanel;
    pnlLeft: TPanel;
    pnlLTop: TPanel;
    wdbgrdAvailable: TwwDBGrid;
    dsAvailable: TDataSource;
    qry1: TERPQuery;
    qry1Tag: TWideStringField;
    qry1ActiveCount: TLargeintField;
    qry1Check: TBooleanField;
    cbbStrain: TComboBox;
    qry1PackageName: TWideStringField;
    qry1Qty: TIntegerField;
    procedure cbbStrainChange(Sender: TObject);
  private
    FOnChangeStrain: TNotifyEvent;
  public
    constructor Create(AOwner: TComponent; APkgType: TStsPackageType); reintroduce;
    property OnChangeStrain: TNotifyEvent read FOnChangeStrain write FOnChangeStrain;
  end;

implementation

{$R *.dfm}

procedure TfmImmaturePckgSrc.cbbStrainChange(Sender: TObject);
begin
  if Assigned(FOnChangeStrain) then FOnChangeStrain(Sender);
end;

constructor TfmImmaturePckgSrc.Create(AOwner: TComponent; APkgType: TStsPackageType);
begin
  inherited Create(Aowner);

  case APkgType of
    pkgPackage:
      begin
        lblStrain.Visible := False;
        cbbStrain.Visible := False;
      end;
  end;
end;

end.
