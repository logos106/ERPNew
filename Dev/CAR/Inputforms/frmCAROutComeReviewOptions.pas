unit frmCAROutComeReviewOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCustomFieldValue, DB, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, DNMSpeedButton, wwdbedit,
  Mask, Wwdotdot, Wwdbcomb, StdCtrls, wwdbdatetimepicker, Grids, Wwdbigrd, Wwdbgrid, DNMPanel , Busobjcustomfields;

type
  TfmCAROutComeReviewOptions = class(TfmCustomFieldValue)
    QryCustomfieldValuesValueSelected: TWideStringField;
  private
  Protected
    Procedure Makecustomcontrols;Override;
  public
    Class Function  Instance(Category :TListType;Connection:TERPConnection;MasterId:Integer;ParentPanel:TDNMPanel; CustomFieldListtype:TListType):TfmCustomFieldValue;Override;
  end;


implementation

{$R *.dfm}

{ TfmCAROutComeReviewOptions }

class function TfmCAROutComeReviewOptions.Instance(Category: TListType; Connection: TERPConnection; MasterId: Integer; ParentPanel: TDNMPanel; CustomFieldListtype: TListType): TfmCustomFieldValue;
var
  Form :TfmCustomFieldValue;
begin
  REsult := nil;
  form :=TfmCAROutComeReviewOptions.create(ParentPanel.Owner);
  if not(Assigned(Form)) then exit;
  Form.InitThisInstance(Category,Connection,MasterId,ParentPanel,CustomFieldListtype);
  Result := Form;
end;

procedure TfmCAROutComeReviewOptions.Makecustomcontrols;
begin
  inherited;
  grdmain.ControlType.add('ValueSelected;CheckBox;T;F');
end;

end.

