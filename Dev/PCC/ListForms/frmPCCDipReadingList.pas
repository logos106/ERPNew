unit frmPCCDipReadingList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, DNMSpeedButton, CustomInputBox, wwdblook,
  Shader;

type
  TPCCDipReadingList = class(TBaseListingGUI)
    qryMainTankNo: TIntegerField;
    qryMainReadingDateTime: TDateTimeField;
    qryMainDipReading: TIntegerField;
    qryMainPCCDipReadingID: TIntegerField;
    qryMainActive: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PCCDipReadingList: TPCCDipReadingList;

implementation

uses frmPCCDipReading, CommonLib, Forms;

{$R *.dfm}

procedure TPCCDipReadingList.FormCreate(Sender: TObject);
begin
  inherited;
  fbEnableWebSearch := true;
end;

procedure TPCCDipReadingList.cmdNewClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TPCCDipReading');
  If not Assigned(tmpComponent) then Exit;
  with TPCCDipReading(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TPCCDipReadingList.grpFiltersClick(Sender: TObject);
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
      end;
  end;
  inherited;
end;

initialization
  RegisterClassOnce(TPCCDipReadingList);

end.
