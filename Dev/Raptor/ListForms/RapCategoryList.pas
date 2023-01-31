unit RapCategoryList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, DNMSpeedButton, CustomInputBox, wwdblook,
  Shader;

type
  TRapCategoryListGUI = class(TBaseListingGUI)
    qryMainCategoryID: TIntegerField;
    qryMainItemCode: TStringField;
    qryMainItemNo: TStringField;
    qryMainItemName: TStringField;
    qryMainSeeAlso: TStringField;
    qryMainNote: TMemoField;
    qryMainActive: TStringField;
    procedure grpFiltersClick(Sender: TObject); override;
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BaseInputForm;

{$R *.dfm}

procedure TRapCategoryListGUI.grpFiltersClick(Sender: TObject);
begin
  if grpFilters.Itemindex       = 0 then GroupFilterString := 'Active = "T"'
  else if grpFilters.ItemIndex  = 1 then GroupFilterString := 'Active = "F"'
  else GroupFilterString := '';
    inherited;
end;
procedure TRapCategoryListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmRapCategories');
  if Assigned(Form) then begin
    with TBaseInputGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TRapCategoryListGUI.FormCreate(Sender: TObject);
begin
  NoDateRange := true;
  inherited;
  LabelGridFromFieldNames := False;

end;

initialization
  RegisterClassOnce(TRapCategoryListGUI);

end.




