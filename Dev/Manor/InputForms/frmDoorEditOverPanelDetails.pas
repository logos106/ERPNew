unit frmDoorEditOverPanelDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseProcTreeEdit, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls,
  Shader, wwclearbuttongroup, wwradiogroup, AdvEdit, DB, DBAccess, MyAccess,ERPdbComponents,
  MemDS;

type
  TfrmDoorEditOverPanelDetailsGUI = class(TBaseProcTreeEditGUI)
    rdgOverPanelType: TwwRadioGroup;
    Label1: TLabel;
    Bevel2: TBevel;
    Label2: TLabel;
    edtOverPanelOneWidth: TAdvEdit;
    Label3: TLabel;
    edtOverPanelOneHeight: TAdvEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtOverPanelTwoWidth: TAdvEdit;
    Label8: TLabel;
    edtOverPanelTwoHeight: TAdvEdit;
    Label9: TLabel;
    Label10: TLabel;
    Bevel3: TBevel;
    Label11: TLabel;
    edtOverPanelCost: TAdvEdit;
    qry: TERPQuery;
  private
    { Private declarations }
  protected
    procedure SetPropertyValue(Sender: TObject); override;
  public
    { Public declarations }
  end;

implementation

uses
  DoorEditOverPanelDetailsObj, CommonLib;

{$R *.dfm}

const
  cNoPanel = 0;
  cSingle = 1;
  cPair = 2;
  cEccentricPair = 3;

{ TfrmOverPanelDetailsGUI }

procedure TfrmDoorEditOverPanelDetailsGUI.SetPropertyValue(Sender: TObject);
begin
  inherited;

  if (Sender = rdgOverPanelType) and Assigned(NodePropLink) then begin
    case rdgOverPanelType.ItemIndex of
      cNoPanel:
      begin
        with TOverPanelDetails(NodePropLink) do begin
          if Showing then begin
            OverPanelOneWidth.Value := '0';
            OverPanelOneHeight.Value := '0';
            OverPanelTwoWidth.Value := '0';
            OverPanelTwoHeight.Value := '0';
          end;

          edtOverPanelOneWidth.Enabled := False;
          edtOverPanelOneHeight.Enabled := False;
          edtOverPanelTwoWidth.Enabled := False;
          edtOverPanelTwoHeight.Enabled := False;
       end;
      end;

      cSingle:
      begin
        with TOverPanelDetails(NodePropLink) do begin
          if Showing then begin
            OverPanelTwoWidth.Value := '0';
            OverPanelTwoHeight.Value := '0';
          end;

          edtOverPanelOneWidth.Enabled := True;
          edtOverPanelOneHeight.Enabled := True;
          edtOverPanelTwoWidth.Enabled := False;
          edtOverPanelTwoHeight.Enabled := False;
        end;
      end;

      cPair, cEccentricPair:
      begin
        edtOverPanelOneWidth.Enabled := True;
        edtOverPanelOneHeight.Enabled := True;
        edtOverPanelTwoWidth.Enabled := True;
        edtOverPanelTwoHeight.Enabled := True;
      end;
    end;
  end;
end;

initialization
  RegisterClassOnce(TfrmDoorEditOverPanelDetailsGUI);
finalization
  UnregisterClass(TfrmDoorEditOverPanelDetailsGUI);
end.
