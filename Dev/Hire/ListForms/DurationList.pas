unit DurationList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TDurationListGUI = class(TBaseListingGUI)
    qryMainDurationId: TIntegerField;
    qryMainDescription: TWideStringField;
    qryMainDuration: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainStepDuration: TWideStringField;
    qryMainGraceDuration: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
  public
  end;

implementation

uses CommonLib, CommonFormLib;

{$R *.dfm}

{ TDurationListGUI }

procedure TDurationListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenErpform('TfmDuration' , 0);
end;

procedure TDurationListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainDurationId.fieldname);
end;
initialization
  RegisterClassOnce(TDurationListGUI);

end.
