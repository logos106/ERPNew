unit frmPCCGradeList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, DNMSpeedButton, CustomInputBox, wwdblook,
  Shader;

type
  TPCCGradeList = class(TBaseListingGUI)
    qryMainGradeID: TIntegerField;
    qryMainGradeNo: TIntegerField;
    qryMainGradeName: TStringField;
    qryMainGradeDesc: TStringField;
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
  PCCGradeList: TPCCGradeList;

implementation

uses CommonLib, frmPCCGrade, Forms;

{$R *.dfm}

procedure TPCCGradeList.FormCreate(Sender: TObject);
begin
  inherited;
  fbEnableWebSearch := true;
end;

procedure TPCCGradeList.cmdNewClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TPCCGradeForm');
  If not Assigned(tmpComponent) then Exit;
  with TPCCGradeForm(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TPCCGradeList.grpFiltersClick(Sender: TObject);
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
  RegisterClassOnce(TPCCGradeList);

end.
