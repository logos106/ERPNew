unit ScopingDefinitionList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, CustomInputBox, wwdblook, Shader;

type
  TScopingDefinitionGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TStringField;
    qryMainTypeName: TStringField;
    qryMainDescription: TStringField;
    qryMainActive: TStringField;
    qryMainDAID: TIntegerField;
    qryMainObjectClass: TStringField;
    qryMainXML: TMemoField;
    qryMainParentID: TIntegerField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainDate: TDateField;
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{var
  ScopingDefinitionGUI: TScopingDefinitionGUI;}

implementation

uses frmScopingDefinitionEditor, CommonLib, Forms;

{$R *.dfm}

procedure TScopingDefinitionGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
    With TScopingDefinitionEditor(GetComponentByClassName('TScopingDefinitionEditor' , true)) do begin
        KeyId := 0;
        FormStyle := fsMDIChild;
        AttachObserver(Self);
        BringToFront; 
    end;
end;

procedure TScopingDefinitionGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Active = ' + QuotedStr('T');
      end;
    1: 
      begin
        GroupFilterString := 'Active = ' + QuotedStr('F');
      end;
    2:
      begin
        GroupFilterString := '';
      end;
  end;
  inherited;
end;

procedure TScopingDefinitionGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpFilters.ItemIndex := 0;
end;

initialization
  RegisterClassOnce(TScopingDefinitionGUI);

end.
