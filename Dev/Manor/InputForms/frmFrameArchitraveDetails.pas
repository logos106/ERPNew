unit frmFrameArchitraveDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseProcTreeEdit, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls,
  Shader, AdvEdit, wwcheckbox, wwclearbuttongroup, wwradiogroup;

type
  TfrmFrameArchitraveDetailsGUI = class(TBaseProcTreeEditGUI)
    Label1: TLabel;
    edtDescription: TAdvEdit;
    Label2: TLabel;
    edtWidthInches: TAdvEdit;
    Label3: TLabel;
    edtWidthMills: TAdvEdit;
    Label4: TLabel;
    Label5: TLabel;
    edtHeightInches: TAdvEdit;
    Label6: TLabel;
    edtHeightMills: TAdvEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    edtTimberCost: TAdvEdit;
    Label11: TLabel;
    edtCost: TAdvEdit;
    rdgArchitrave: TwwRadioGroup;
    chkFrameTopArchitrave: TwwCheckBox;
    Label9: TLabel;
    edtTotalCost: TAdvEdit;
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
  RegisterClassOnce(TfrmFrameArchitraveDetailsGUI);
finalization
  UnregisterClass(TfrmFrameArchitraveDetailsGUI);
end.
