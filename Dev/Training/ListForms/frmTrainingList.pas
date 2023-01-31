unit frmTrainingList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TfmTrainingList = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainTrainingID: TLargeintField;
    qryMainDescription: TWideStringField;
    qryMainTrainingDate: TDateField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainTotalHours: TFloatField;
    qryMainStartOfTheDay: TTimeField;
    qryMainEndOftheDay: TTimeField;
    btnAssignment: TDNMSpeedButton;
    procedure cmdNewClick(Sender: TObject);
    procedure btnAssignmentClick(Sender: TObject);
  private
  protected
    procedure RefreshTotals; override;
  public
    { Public declarations }
  end;

var
  fmTrainingList: TfmTrainingList;

implementation

{$R *.dfm}

uses
  BaseInputForm, CommonLib, frmTrainingAssignment;

procedure TfmTrainingList.btnAssignmentClick(Sender: TObject);
var
  TrainingAssignment: TfmTrainingAssignment;
begin
  inherited;
  TrainingAssignment := TfmTrainingAssignment(GetComponentByClassName('TfmTrainingAssignment'));
  if Assigned(TrainingAssignment) then begin
    TrainingAssignment.AttachObserver(self);
    TrainingAssignment.KeyID := qryMainTrainingID.AsInteger;
    TrainingAssignment.FormStyle := fsMDIChild;
    TrainingAssignment.BringToFront;
  end;
end;

procedure TfmTrainingList.cmdNewClick(Sender: TObject);
var
  EditForm : TBaseInputGUI;
begin
  inherited;
  EditForm := TBaseInputGUI(GetComponentByClassName('TfmTrainingEdit'));
  if Assigned(EditForm) then begin
    with EditForm do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TfmTrainingList.RefreshTotals;
var
  TotalHours: double;
begin
  qryMain.DisableControls;
  try
    TotalHours := 0;
    with qryMain do begin
      First;
      while not Eof do begin
        TotalHours := TotalHours + self.qryMainTotalHours.AsFloat;
        Next;
      end;
    end;
    grdMain.ColumnByName('TotalHours').FooterValue := FloatToStrF(TotalHours, ffGeneral, 15, 2);
  finally
    qryMain.EnableControls;
  end;
end;

initialization
  RegisterClass(TfmTrainingList);

end.
