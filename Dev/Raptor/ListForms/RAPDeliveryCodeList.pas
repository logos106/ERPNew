unit RAPDeliveryCodeList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, ProgressDialog, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, DNMSpeedButton, CustomInputBox, wwdblook,
  Shader;

type
  TRAPDeliveryCodeListGUI = class(TBaseListingGUI)
    qryMainDeliveryCodeID: TIntegerField;
    qryMainDeliveryCode: TStringField;
    qryMainDescription: TStringField;
    qryMainActive: TStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Procedure REfreshQuery; override;
  end;


implementation

uses CommonLib, frmRAPDeliveryCodes, BaseInputForm;

{$R *.dfm}
Procedure TRAPDeliveryCodeListGUI.REfreshQuery;
begin
        qrymain.disablecontrols;
        try
                inherited;
        finally
            qrymain.Enablecontrols;
        end;
end;
procedure TRAPDeliveryCodeListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmRAPDeliveryCodes');
  if Assigned(Form) then begin
    with TfmRAPDeliveryCodes(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TRAPDeliveryCodeListGUI.FormCreate(Sender: TObject);
begin
  NoDateRange := true;
  inherited;
  LabelGridFromFieldNames := False;

end;

initialization
  RegisterClassOnce(TRAPDeliveryCodeListGUI);

end.
