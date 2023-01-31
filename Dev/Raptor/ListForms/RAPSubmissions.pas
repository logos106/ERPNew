unit RAPSubmissions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, DNMSpeedButton, CustomInputBox, wwdblook,
  Shader;

type
  TRAPSubmissionsGUI = class(TBaseListingGUI)
    qryMainSubmissionID: TIntegerField;
    qryMainSubmissionDate: TDateField;
    qryMainTotalInvoices: TIntegerField;
    qryMainSubmitted: TStringField;
    qryMainXMLFileName: TStringField;
    qryMainReceivedSubmissionReport: TStringField;
    qryMainfoundErrors: TStringField;
    qryMainSubmissionErrorMessage: TMemoField;
    qryMainParentSubmissionId: TIntegerField;
    qryMainRequestedAmount: TFloatField;
    qryMainPaymentReceived: TStringField;
    qryMainAmountReceived: TFloatField;
    qryMainActive: TStringField;
    qryMainResubmittedID: TIntegerField;
    qryMainParentFile: TStringField;
    qryMainResubmitted: TStringField;
    qryMainchildFile: TStringField;
    qryMainHasParent: TStringField;
    btnresubmit: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure grpFiltersClick(Sender: TObject); override;
    procedure cmdNewClick(Sender: TObject);
    procedure btnresubmitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Procedure REfreshQuery; override;
  end;


implementation

uses CommonLib, frmRAPSubmissions, BusObjRap, BusObjBase, CommonDbLib, Dateutils,
  BaseInputForm;

{$R *.dfm}

Procedure TRAPSubmissionsGUI.REfreshQuery;
begin
  qrymain.disablecontrols;
  try
    qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
    inherited;
  finally
      qrymain.Enablecontrols;
  end;
end;

procedure TRAPSubmissionsGUI.grpFiltersClick(Sender: TObject);
begin
  if grpFilters.Itemindex       = 0 then GroupFilterString := 'Active = "T"'
  else if grpFilters.ItemIndex  = 1 then GroupFilterString := 'Active = "F"'
  else GroupFilterString := '';

  inherited;
end;

procedure TRAPSubmissionsGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmRAPSubmissions');
  if Assigned(Form) then begin
    with TfmRAPSubmissions(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TRAPSubmissionsGUI.btnresubmitClick(Sender: TObject);
var
    i :Integer;
    submissionIDs :String;
    RapObj :TRAPSubmission;
    strSQL :String;
begin

  inherited;
  submissionIDs := '';
  if grdMain.SelectedList.Count = 0 then Exit;
  RapObj := TRAPSubmission.Create(self);
  Try
     RapObj.connection := TMydacDataconnection.Create(RapObj);
     TMydacDataconnection(RapObj.connection).MyDacConnection := commondblib.GetNewMyDacConnection(Self);
     RapObj.Connection.BeginTransaction;
     Try
          for i := 0 to grdMain.SelectedList.Count - 1 do begin
                qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
                RapObj.Load(qryMainSubmissionID.asInteger);
                if not RapObj.UserLock.Lock(RapObj.XMLNodeName) then begin
                    RapObj.ResultStatus.AddItem(false,rssWarning,0,RapObj.UserLock.LockMessage);
                    RapObj.Connection.RollbackTransaction;
                    Exit;
                end;
                if submissionIDs <> '' then submissionIDs := submissionIDs + ',';
                SubmissionIDs := submissionIDs + qryMainSubmissionID.asString;
          end;
          submissionIDs := '(' + submissionIDs +')';
          strSQL := 'update tblRAPSubmission set Submitted = "T" Where submissionID in ' +submissionIDs;
          RapObj.GetNewDataSet(strSQL);
          strSQL := 'update tblRAPSubmission set SubmissionDate = ' + QuotedStr(FormatDatetime('yyyy-mm-dd' , Now)) +
                    ' Where submissionID in ' +submissionIDs;
          RapObj.GetNewDataSet(strSQL);
          strSQL := 'update  tblSales, tblrapsubmissionlines ' +
                    ' Set  RapSubmitstatus = "T"  ' +
                    ' where  tblSales.SaleID = tblrapsubmissionlines.SaleID ' +
                    ' and tblrapsubmissionlines.SubmissionID in ' + submissionIDs;
          RapObj.GetNewDataSet(strSQL);
     finally
         RapObj.Connection.CommitTransaction;
     end;
  Finally
      RapObj.UserLock.Unlock(RapObj.XMLNodeName);
      FreeandNil(RapObj);
  end;

end;
procedure TRAPSubmissionsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  LabelGridFromFieldNames := False;
end;

initialization
  RegisterClassOnce(TRAPSubmissionsGUI);

end.
