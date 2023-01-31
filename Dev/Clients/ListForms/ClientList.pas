unit ClientList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TClientListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainCompanyName: TWideStringField;
    qryMainFirstname: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainIsJob: TWideStringField;
    qryMainIsCustomer: TWideStringField;
    qryMainIsSupplier: TWideStringField;
    qryMainIsOtherContact: TWideStringField;
    qryMainCompany: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainBillcountry: TWideStringField;
  private
  Protected
  public
    Function ClientID:Integer;
    Function ClientName:String;
    class function SelectAclient(returnID:boolean): Variant;
  end;

implementation

uses CommonLib ;

{$R *.dfm}


{ TClientListGUI }

function TClientListGUI.ClientID: Integer;
begin
  Result :=qryMainClientID.asInteger;
end;

function TClientListGUI.ClientName: String;
begin
  Result :=qryMainCompanyName.asString;
end;

class function TClientListGUI.SelectAclient(returnID:boolean): Variant;
var
  Form : TClientListGUI;
begin
  if returnid then REsult := 0 else result := '';
  Form := nil;
  try
    Form := TClientListGUI(GetComponentByClassName('TClientListGUI', false, nil,False  ));
    if Assigned(Form) then begin //if has acess
        Form.grdMain.Options:=Form.grdMain.Options - [dgMultiSelect];
        Form.grdMain.Options:=Form.grdMain.Options + [dgRowSelect];
        Form.CloseOnRecSelect:= True;
        Form.Showmodal;
        if returnID then REsult := Form.ClientID
        else REsult := Form.ClientNAme;
    end;
  Finally
      Freeandnil(form);
  end;
end;

initialization
  RegisterClass(TClientListGUI);

end.
