unit frmAccountListEditPopUp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls,
  DNMSpeedButton, AdvGlowButton;

type
  TfmAccountListEditPopUp = class(TBaseForm)
    btnAccountType: TAdvGlowButton;
    btnAccountOrder: TAdvGlowButton;
    btnCancel: TAdvGlowButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnAccountTypeClick(Sender: TObject);
    procedure btnAccountOrderClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure DoEditFromAccountList;


implementation

{$R *.dfm}

uses
  CommonFormLib;

procedure DoEditFromAccountList;
var
  form: TfmAccountListEditPopUp;
begin
  form := TfmAccountListEditPopUp.Create(nil);
  try
    form.ShowModal;
  finally
    form.Free;
  end;
end;


procedure TfmAccountListEditPopUp.btnAccountOrderClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmAccountTypeListOrder', 0);
  ModalResult := mrOk;
end;

procedure TfmAccountListEditPopUp.btnAccountTypeClick(Sender: TObject);
begin
  inherited;
  CreatenOpenERPListForm('TAccountTypesListGUI');
  ModalResult := mrOk;
end;

procedure TfmAccountListEditPopUp.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

end.
