unit frmDoorEditLaminatedFacesDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseProcTreeEdit, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls,
  Shader, AdvEdit, DB, DBAccess, MyAccess,ERPdbComponents;

type
  TfrmDoorEditLaminatedFacesDetailsGUI = class(TBaseProcTreeEditGUI)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtLaminateOne: TAdvEdit;
    Bevel2: TBevel;
    edtLumpSumCostOne: TAdvEdit;
    Label4: TLabel;
    Bevel3: TBevel;
    Label5: TLabel;
    edtLaminateTwo: TAdvEdit;
    Label6: TLabel;
    edtLumpSumCostTwo: TAdvEdit;
    Label7: TLabel;
    edtLabourCharge: TAdvEdit;
    Label8: TLabel;
    edtTotalVeneerCost: TAdvEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib;

{$R *.dfm}

initialization
  RegisterClassOnce(TfrmDoorEditLaminatedFacesDetailsGUI);
finalization
  UnregisterClass(TfrmDoorEditLaminatedFacesDetailsGUI);
end.
