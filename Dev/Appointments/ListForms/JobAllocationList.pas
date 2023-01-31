unit JobAllocationList;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 26/10/05  1.00.01 DSP  First version. Displays a list of jobs allocated to
                        employees. A barcode scanner would have been used for
                        the allocations.
 1/11/05   1.00.02 DLS  Added RegisterClass
 27/01/06  1.00.03 DSP  Changed caption to 'Repair Allocation List'. Moved
                        some fields referenced in tlbrepairjobs to tblrepairs. 

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, CustomInputBox, wwdblook, Shader,
  kbmMemTable;

type
  TJobAllocationListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TStringField;
    qryMainCreationDate: TDateField;
    qryMainEmployeeName: TStringField;
    qryMainStartDateTime: TDateTimeField;
    qryMainFinishDateTime: TDateTimeField;
    qryMainCompany: TStringField;
    qryMainHoursTakenForRepair: TStringField;
    qryMainNotes: TStringField;
    qryMainRepairID: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;  
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
  protected
    procedure RefreshQuery; override;  
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
   AppContextObj, AppEnvironment, CommonLib;

{$R *.dfm}

procedure TJobAllocationListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  cmdNew.Enabled := false;
  ShowChartViewOnPopup := True;
end;

procedure TJobAllocationListGUI.RefreshQuery;
begin
  qryMain.Close;
  qryMain.ParamCheck := true;
  qryMain.Params.ParamByName('dtFrom').AsString := FormatDateTime('yyyy-mm-dd 0:00:00', dtFrom.DateTime);
  qryMain.Params.ParamByName('dtTo').AsString := FormatDateTime('yyyy-mm-dd 23:59:59', dtTo.DateTime);
  inherited;
end;

procedure TJobAllocationListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';

  case grpFilters.ItemIndex of
    0:
      begin
        GroupFilterString := 'Done = ' + QuotedStr('F');
      end;
    1:
      begin
        GroupFilterString := 'Done = ' + QuotedStr('T');
      end;
    2:
      begin
      end;
  end;
  
  inherited;
end;

procedure TJobAllocationListGUI.FormShow(Sender: TObject);
begin
  inherited;

  if fbFormOpenedOk then begin
    grpFiltersClick(Sender);
  end;
end;

procedure TJobAllocationListGUI.grdMainDblClick(Sender: TObject);
begin
  AppContext['Repair'].VarByname['Caption'] := AppEnv.CompanyPrefs.RepairTitle;
  inherited;
end;

initialization
  RegisterClassOnce(TJobAllocationListGUI);
end.
