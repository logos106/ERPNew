unit frmPayRateListFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwcheckbox, wwDialog, Wwlocate, SelectionDialog, DNMPanel, DBAccess,
  MyAccess,ERPdbComponents, MemDS, wwdbdatetimepicker, ProgressDialog, kbmMemTable,
   wwdblook, Shader, DAScript, MyScript, CustomInputBox;

type
  TfrmPayRateList = class(TBaseListingGUI)
    qryMainRateID: TIntegerField;
    qryMainDescription: TWideStringField;
    qryMainMultiplier: TFloatField;
    qryMainActive: TWideStringField;
    qryMainIsPayRate: TWideStringField;
    qryMainIsLeave: TWideStringField;
    qryMainIsSuperEnabled: TWideStringField;
    qryMainMultiplierOf: TWideStringField;
    qryMainAccrueLeave: TWideStringField;
    qryMainExtraLeaveAccrual: TWideStringField;
    qryMainExtraLeaveMultiplier: TFloatField;
    qryMainLeaveType: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    { Private declarations }
  Protected
    Procedure SetGridColumns;override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  frmPayRatesFrm, CommonLib, Forms, AppEnvironment;

procedure TfrmPayRateList.cmdNewClick(Sender: TObject);
var tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TfrmPayRates');
  If not Assigned(tmpComponent) then Exit;
  with TfrmPayRates(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TfrmPayRateList.grpFiltersClick(Sender: TObject);
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

procedure TfrmPayRateList.FormShow(Sender: TObject);
begin
  inherited;
  if not qryMain.Active then Exit;
  grpFilters.ItemIndex := 0;
end;

procedure TfrmPayRateList.grdMainDblClick(Sender: TObject);
(*var
  sName: string;*)
begin
//  sName := qryMain.FieldByName('Description').AsString;
//  if (sName = 'Annual Leave') or (sName = 'Sick Leave') or (sName = 'Termination') or
//    (sName = 'Long Service') or (sName = 'Normal Hours') then begin
//    CommonLib.MessageDlgXP_Vista('You cannot change the details of the ' + sName + ' Pay Rate type.  This is used for internal operations!',
//      mtWarning, [mbOK], 0);
//    Exit;
//  end;
  inherited;
end;

procedure TfrmPayRateList.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('RateId');
end;

initialization
  RegisterClassOnce(TfrmPayRateList);;
end.
