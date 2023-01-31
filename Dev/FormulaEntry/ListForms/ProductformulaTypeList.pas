unit ProductformulaTypeList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel, GIFImg;

type
  TProductformulaTypeListGUI = class(TBaseListingGUI)
    qryMainFormulaTypeId: TIntegerField;
    qryMainFormulaType: TWideStringField;
    qryMainFe1visible: TWideStringField;
    qryMainFe2visible: TWideStringField;
    qryMainFe3visible: TWideStringField;
    qryMainFe4visible: TWideStringField;
    qryMainFe5visible: TWideStringField;
    qryMainActive: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
  public

  end;


implementation

uses CommonLib, CommonFormLib;

{$R *.dfm}

procedure TProductformulaTypeListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TfmProductFormulaTypes' ,0);
end;

procedure TProductformulaTypeListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TProductformulaTypeListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainFormulaTypeId.fieldname);
end;
initialization
  RegisterClassOnce(TProductformulaTypeListGUI);

end.
