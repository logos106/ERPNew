unit frmEmpResProcRosternScheduleConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, DNMSpeedButton, Shader, ExtCtrls, DNMPanel, StdCtrls,
  CheckLst, SelectionDialog, Menus;

type
  TAllocatedTimeSlotDetails = record
    ShowStatus:Boolean;
    ShowSaleID:Boolean;
    ShowProduct:Boolean;
    ShowCustomer:Boolean;
    showShipDate:Boolean;
    showManQty:Boolean;
    showDuration:Boolean;
    showLineFeed:Boolean;
  end;

  TfmEmpResProcRosternScheduleConfig = class(TBaseForm)
    Details: TCheckListBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel1: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    chkLineFeed: TCheckBox;
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
  private
    fAllocatedTimeSlotDetails: TAllocatedTimeSlotDetails;
    procedure setAllocatedTimeSlotDetails(
      const Value: TAllocatedTimeSlotDetails);
    function getAllocatedTimeSlotDetails: TAllocatedTimeSlotDetails;

  public
    Property AllocatedTimeSlotDetails : TAllocatedTimeSlotDetails read getAllocatedTimeSlotDetails write setAllocatedTimeSlotDetails;
    Class Function  DoAllocatedTimeSlotDetails(var aAllocatedTimeSlotDetails : TAllocatedTimeSlotDetails):boolean;
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TfmEmpResProcRosternScheduleConfig }

procedure TfmEmpResProcRosternScheduleConfig.cmdCancelClick(Sender: TObject);
begin
  inherited;
  modalresult := mrcancel;
end;

procedure TfmEmpResProcRosternScheduleConfig.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not(Details.checked[0]) and
     not(Details.checked[1]) and
     not(Details.checked[2]) and
     not(Details.checked[3]) and
     not(Details.checked[4]) and
     not(Details.checked[5]) then begin
      MessageDlgXP_Vista('Please Choose atleast one field', mtWarning, [mbOK], 0);
      Exit;
     end;
  modalresult := mrok;
end;

class function TfmEmpResProcRosternScheduleConfig.DoAllocatedTimeSlotDetails(var aAllocatedTimeSlotDetails: TAllocatedTimeSlotDetails):Boolean;
var
  form :TfmEmpResProcRosternScheduleConfig;
begin
  result := False;
  form := TfmEmpResProcRosternScheduleConfig.Create(Nil);
  try
    form.AllocatedTimeSlotDetails := aAllocatedTimeSlotDetails;
    if form.ShowModal = mrok then begin
      aAllocatedTimeSlotDetails := form.AllocatedTimeSlotDetails;
      Result := True;
    end;
  finally
    Freeandnil(Form);
  end;

end;

function TfmEmpResProcRosternScheduleConfig.getAllocatedTimeSlotDetails: TAllocatedTimeSlotDetails;
begin
  fAllocatedTimeSlotDetails.ShowStatus  := Details.checked[0];
  fAllocatedTimeSlotDetails.ShowSaleID  := Details.checked[1];
  fAllocatedTimeSlotDetails.ShowProduct := Details.checked[2];
  fAllocatedTimeSlotDetails.ShowCustomer:= Details.checked[3];
  fAllocatedTimeSlotDetails.showShipDate:= Details.checked[4];
  fAllocatedTimeSlotDetails.showManQty  := Details.checked[5];
  fAllocatedTimeSlotDetails.showDuration:= Details.checked[6];
  fAllocatedTimeSlotDetails.showLineFeed:= chkLineFeed.checked;
  result :=  fAllocatedTimeSlotDetails;
end;

procedure TfmEmpResProcRosternScheduleConfig.setAllocatedTimeSlotDetails(const Value: TAllocatedTimeSlotDetails);
begin
  Details.checked[0] := Value.ShowStatus;
  Details.checked[1] := Value.ShowSaleID;
  Details.checked[2] := Value.ShowProduct;
  Details.checked[3] := Value.ShowCustomer;
  Details.checked[4] := Value.showShipDate;
  Details.checked[5] := Value.showManQty;
  Details.checked[6] := Value.showDuration;
  chkLineFeed.checked:= Value.showLineFeed;
end;

end.
