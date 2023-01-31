unit frmEmployeeFixedAssets;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, Mask, wwdbedit,
   wwdblook, Shader, kbmMemTable;

type
  TEmployeesFixedAssetsList = class(TBaseListingGUI)
    qryMainFirstName: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainPosition: TWideStringField;
    qryMainTitle: TWideStringField;
    qryMainEmployeeFAID: TIntegerField;
    qryMainActive: TWideStringField;
    qryMainAssetID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainAssetName: TWideStringField;
    qryMainEmpID: TIntegerField;
    qryMainAssetCode: TWideStringField;
    qryMainAssetType: TWideStringField;
    qryMainPurchaseDate: TDateField;
    qryMainPurchaseCost: TFloatField;
    qryMainEmployeeName: TWideStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EmployeesFixedAssetsList: TEmployeesFixedAssetsList;

implementation

uses CommonLib;

{$R *.dfm}

initialization
  RegisterClassOnce(TEmployeesFixedAssetsList);

end.
