unit SupportModules;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TSupportModulesGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainModuleName: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainmstimeStamp: TDateTimeField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdNewClick(Sender: TObject);
  private
  Protected
    Procedure SetGridColumns;Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, CommonFormLib;

{$R *.dfm}
{ TSupportModulesGUI }

procedure TSupportModulesGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmSupportModule' , 0);
end;

procedure TSupportModulesGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TSupportModulesGUI.SetGridColumns;
begin
  RemoveFieldfromGrid('ID');
  RemoveFieldfromGrid('Globalref');
  RemoveFieldfromGrid('msTimeStamp');
end;

initialization
  RegisterClassOnce(TSupportModulesGUI);

end.
