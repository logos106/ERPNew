unit ShippingAgent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TShippingAgentGUI = class(TBaseListingGUI)
    qryMainGlobalref: TWideStringField;
    qryMainShippingAgentID: TLargeintField;
    qryMainCode: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainmstimeStamp: TDateTimeField;
    qryMainInsurance: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  Protected
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BaseInputForm;

{$R *.dfm}

{ TShippingAgentGUI }

procedure TShippingAgentGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfmShippingAgent');
    if Assigned(Form) then begin //if has acess
      with TBaseInputGUI(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end
end;

procedure TShippingAgentGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('Globalref,mstimestamp,ShippingAgentID');
end;

initialization
  RegisterClassOnce(TShippingAgentGUI);

end.
