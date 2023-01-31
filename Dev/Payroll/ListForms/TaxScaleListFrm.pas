unit TaxScaleListFrm;

interface                                                             

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, wwcheckbox,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog, kbmMemTable, 
  wwdblook, Shader, DAScript, MyScript, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TTaxScaleList = class(TBaseListingGUI)
    chkActive: TwwCheckBox;
    qryMainGlobalRef: TWideStringField;
    qryMainScaleID: TIntegerField;
    qryMainDescription: TWideStringField;
    qryMainLastUpdated: TDateField;
    qryMainActive: TWideStringField;
    qryMainMaximum: TFloatField;
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure qryMainBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  TaxScale, CommonLib, Forms, AppEnvironment, tcTypes, frmTaxScaleUSA;


{$R *.dfm}

procedure TTaxScaleList.cmdNewClick(Sender: TObject);
var  
  tmpComponent: TComponent;
  rtype: TRegionType;
begin
  inherited;

  if AppEnv.RegionalOptions.RegionType <> rUSA then begin
    tmpComponent := GetComponentByClassName('TTaxScaleForm');

    if not Assigned(tmpComponent) then Exit;

    with TTaxScaleForm(tmpComponent) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end
  else begin
    tmpComponent := GetComponentByClassName('TTaxScaleUSForm');

    if not Assigned(tmpComponent) then Exit;

    with TTaxScaleUSForm(tmpComponent) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TTaxScaleList.FormShow(Sender: TObject);
begin
  inherited;
  if not qryMain.Active then Exit;
  if fbFormOpenedOk then begin
    grpFiltersClick(Sender);
  end;
end;

procedure TTaxScaleList.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Active=' + QuotedStr('T');
      end;
    1: 
      begin
        GroupFilterString := 'Active=' + QuotedStr('F');
      end;
  end;
  inherited;
end;

procedure TTaxScaleList.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Qrymain.parambyname('RegionID').asInteger := AppEnv.RegionalOptions.ID;
end;

initialization
  RegisterClassOnce(TTaxScaleList);
end.
