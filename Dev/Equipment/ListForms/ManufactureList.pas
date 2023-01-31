unit ManufactureList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TManufactureListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainID: TIntegerField;
    qryMainName: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainCreatedOn: TDateTimeField;
    qryMainmsTimeStamp: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib, frmManufacture;

{$R *.dfm}

procedure TManufactureListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  qryMainCreatedOn.DisplayFormat := FormatSettings.ShortDateformat;
end;

procedure TManufactureListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: GroupFilterString:= 'Active = "T"';
    1: GroupFilterString:= 'Active = "F"';
    2:;
  end;
  inherited;
end;

procedure TManufactureListGUI.cmdNewClick(Sender: TObject);
var
  Form:TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmManufacture');
  if Assigned(Form) then begin //if has acess
    with TfmManufacture(Form) do begin
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

initialization
  RegisterClassOnce(TManufactureListGUI);

end.
