unit AssessmentList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, CustomInputBox, wwdblook,
  Shader, kbmMemTable;

type
  TAssessmentListGUI = class(TBaseListingGUI)
    btnInvoice: TDNMSpeedButton;
    qryMainAssessmentID: TIntegerField;
    qryMainAssessmentType: TWideStringField;
    qryMainTimeOn: TTimeField;
    qryMainTimeOff: TTimeField;
    qryMainDate: TDateField;
    qryMainAssessmentToday: TIntegerField;
    qryMainUniformWorn: TWideStringField;
    qryMainRoute: TWideStringField;
    qryMainGarage: TWideStringField;
    qryMainRegNumber: TWideStringField;
    qryMainRunningNumber: TWideStringField;
    qryMainFleetNumber: TWideStringField;
    qryMainVehicleType: TWideStringField;
    qryMainWeatherType: TWideStringField;
    qryMainBusDestination: TWideStringField;
    qryMainJourneyTo: TWideStringField;
    qryMainJourneyFrom: TWideStringField;
    qryMainActive: TWideStringField;
    actInvoice: TAction;
    qryMainConverted: TWideStringField;
    qryMainAssessmentNo: TIntegerField;
    qryMainAssessor: TWideStringField;
    qryMainDriver: TWideStringField;
    qryMainAssessorID: TIntegerField;
    qryMainDriverID: TIntegerField;
    qryMainScore: TIntegerField;
    qryMainRating: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainCovert: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure actInvoiceExecute(Sender: TObject);
    procedure actInvoiceUpdate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;    
  public
    { Public declarations }
  end;

implementation
  
uses CommonLib, AssessmentGUI, AssessmentConvertObj, frmInvoice, tcDatautils;

{$R *.dfm}

procedure TAssessmentListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Active = ' + QuotedStr('T') + ' AND Converted <> ' + QuotedStr('T');
      end;
    1:
      begin
        GroupFilterString := 'Active = ' + QuotedStr('F')
      end;
    2:
      begin
        GroupFilterString := 'Converted = ' + QuotedStr('T');
      end;
    3:
      begin
      end;
  end;
  inherited;
end;

procedure TAssessmentListGUI.cmdNewClick(Sender: TObject);
var
  Form: TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TAssessmentGUI');
  if Assigned(Form) then begin //if has acess
    with TAssessmentGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TAssessmentListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
  inherited;
end;

procedure TAssessmentListGUI.actInvoiceExecute(Sender: TObject);
var
  I, InvID: Integer;
  AssessmentIDs: array of Integer;
  frmInv: TInvoiceGUI;
  fiClientID: Integer;  
begin
  if grdMain.SelectedList.Count = 0 then begin
    CommonLib.MessageDlgXP_Vista('No Assessments have been selected.', mtInformation, [mbOK], 0);
    Exit;
  end;

  SetLength(AssessmentIDs, grdMain.SelectedList.Count);
  for I := 0 to grdMain.SelectedList.Count - 1 do begin
    if not qryMain.BookmarkValid(grdMain.SelectedList.Items[i]) then Continue;
    qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
    AssessmentIDs[I] := qryMainAssessmentID.AsInteger;
  end;

  fiClientID := tcDatautils.GetClientID(qryMainGarage.asString);
  if (fiClientID <> 0) then begin
    InvID := AssessmentConvertObj.ConvertAssessmentToInvoice(fiClientID, AssessmentIDs);
    if InvID = 0 then Exit;
    frmInv := TInvoiceGUI(GetComponentByClassName('TInvoiceGUI'));
    if Assigned(frmInv) then begin
      frmInv.KeyID := InvID;
      frmInv.FormStyle := fsMDIChild;
      frmInv.BringToFront;
    end;
  end;
end;

procedure TAssessmentListGUI.actInvoiceUpdate(Sender: TObject);
begin
  inherited;
  btnInvoice.Enabled := (grdMain.SelectedList.Count > 0)
end;

initialization
  RegisterClassOnce(TAssessmentListGUI);
end.
