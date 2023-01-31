unit PaymentMethodList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TPaymentMethodListGUI = class(TBaseListingGUI)
    qryMainPayMethodID: TIntegerField;
    qryMainNAME: TWideStringField;
    qryMainIsCreditCard: TWideStringField;
    qryMainActive: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PaymentMethodListGUI: TPaymentMethodListGUI;

implementation

{$R *.dfm}

uses
  BaseInputForm, CommonLib;

procedure TPaymentMethodListGUI.cmdNewClick(Sender: TObject);
var
  EditForm : TBaseInputGUI;
begin
  inherited;
  EditForm := TBaseInputGUI(GetComponentByClassName('TfmPaymentMethod'));
  if Assigned(EditForm) then begin
    with EditForm do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TPaymentMethodListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  KeyIdfieldname := qryMainPayMethodID.Fieldname;
  KeyNamefieldname :=qryMainNAME.Fieldname;

end;

procedure TPaymentMethodListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;

initialization
  RegisterClass(TPaymentMethodListGUI);

end.
