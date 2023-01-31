{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
11/01/06  1.00.00  BJ  Initial verson.
}
unit PoolProfileList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, CustomInputBox, wwdblook, Shader;

type
  TPoolProfileListGUI = class(TBaseListingGUI)
    qryMainclient: TStringField;
    qryMainLocation: TStringField;
    qryMainconstruction: TStringField;
    qryMainSanitizer: TStringField;
    qryMainVolume: TIntegerField;
    qryMainSanitizerLvl: TIntegerField;
    qryMainUsesMSA: TStringField;
    qryMainIsSpa: TStringField;
    qryMainSaltRequired: TIntegerField;
    qryMainPoolProfileId: TIntegerField;
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  PoolProfileListGUI: TPoolProfileListGUI;

implementation

uses frmPoolCustomer, CommonLib, Forms;

{$R *.dfm}
procedure TPoolProfileListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmPoolCustomer');
  if Assigned(Form) then begin
    With TfmPoolCustomer(Form) do begin
        KeyId     := 0;
        CustId    := 0;
        FormStyle := fsMdiChild;
        BringToFront;
    end;
  end;  
end;

initialization
  RegisterClassOnce(TPoolProfileListGUI);

end.
