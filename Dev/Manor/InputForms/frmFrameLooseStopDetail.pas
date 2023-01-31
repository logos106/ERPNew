unit frmFrameLooseStopDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseProcTreeEdit, ExtCtrls, StdCtrls, wwclearbuttongroup,
  MessageConst, wwradiogroup, AdvEdit, DNMSpeedButton, Shader;

type
  TfmFrameLoopStopDetail = class(TBaseProcTreeEditGUI)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblWidthinch: TLabel;
    lblThicknessinch: TLabel;
    lblWidthinchinch: TLabel;
    lblWidthmm: TLabel;
    lblThicknessmm: TLabel;
    lblThicknessinchinch: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    edtTimbercost: TAdvEdit;
    edtWidthinch: TAdvEdit;
    edtThicknessinch: TAdvEdit;
    edtWidthmm: TAdvEdit;
    edtThicknessmm: TAdvEdit;
    edtCostPlm: TAdvEdit;
    rdoshadowGap: TwwRadioGroup;
    edtDescription: TAdvEdit;
    Label11: TLabel;
    edtTotalCost: TAdvEdit;
  private
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
  public
    { Public declarations }
  end;

implementation

uses FrameLooseStopDetail, EditFrameQuotationDetailsObj, CommonLib;

{$R *.dfm}

procedure TfmFrameLoopStopDetail.PerformStartup(var Msg: TMessage);
begin
    inherited;
    if assigned(NodePropLink.Owner) and (NodePropLink.Owner is TEditFrameQuotationDetails) then begin
         TFrameLooseStopDetails(NodePropLink).Widthinch.value    :=TEditFrameQuotationDetails(NodePropLink.owner).WidthInches.Value;
         TFrameLooseStopDetails(NodePropLink).Widthmm.value      :=TEditFrameQuotationDetails(NodePropLink.owner).WidthMills.Value;
         TFrameLooseStopDetails(NodePropLink).Thicknessinch.value:=TEditFrameQuotationDetails(NodePropLink.owner).WebThicknessInches.Value;
         TFrameLooseStopDetails(NodePropLink).Thicknessmm.value  :=TEditFrameQuotationDetails(NodePropLink.owner).WebThicknessMills.Value;
         (*edtWidthinch.enabled         := False;
         edtThicknessinch.enabled     := False;
         edtWidthmm.enabled           := False;
         edtThicknessmm.enabled       := False;
         lblWidthinch.enabled         := False;
         lblThicknessinch.enabled     := False;
         lblWidthinchinch.enabled     := False;
         lblThicknessinchinch.enabled := False;
         lblWidthmm.enabled           := False;
         lblThicknessmm.enabled       := False;*)
    end;
end;
initialization
  RegisterClassOnce(TfmFrameLoopStopDetail);
finalization
  UnregisterClass(TfmFrameLoopStopDetail);

end.
