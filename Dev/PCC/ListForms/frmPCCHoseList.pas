unit frmPCCHoseList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, DNMSpeedButton, CustomInputBox, wwdblook,
  Shader;

type
  TPCCHoseList = class(TBaseListingGUI)
    qryMainHoseID: TIntegerField;
    qryMainHoseNo: TIntegerField;
    qryMainDispenserNo: TIntegerField;
    qryMainTankNo: TIntegerField;
    qryMainTankDescription: TStringField;
    qryMainGradeName: TStringField;
    qryMainProductName: TStringField;
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
  PCCHoseList: TPCCHoseList;

implementation

uses CommonLib, frmPCCHose, Forms;

{$R *.dfm}

procedure TPCCHoseList.FormCreate(Sender: TObject);
begin
  inherited;
  fbEnableWebSearch := true;
end;

procedure TPCCHoseList.cmdNewClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TPCCHose');
  If not Assigned(tmpComponent) then Exit;
  with TPCCHose(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TPCCHoseList.grpFiltersClick(Sender: TObject);
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
  RegisterClassOnce(TPCCHoseList);

end.
