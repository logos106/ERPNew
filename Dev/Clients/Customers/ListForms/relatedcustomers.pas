unit relatedcustomers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TrelatedcustomersGUI = class(TBaseListingGUI)
    qryMainMasterCompany: TWideStringField;
    qryMainChildCompany: TWideStringField;
    qryMainRelatedClientID: TIntegerField;
    qryMainMasterClientID: TIntegerField;
    qryMainChildClientID: TIntegerField;
  private
  Protected
    Procedure SetGridColumns;Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}
{ TrelatedcustomersGUI }

procedure TrelatedcustomersGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ChildclientID');
  RemoveFieldfromGrid('MasterclientID');
  RemoveFieldfromGrid('RelatedClientId');
end;

initialization
  RegisterClassOnce(TrelatedcustomersGUI);

end.
