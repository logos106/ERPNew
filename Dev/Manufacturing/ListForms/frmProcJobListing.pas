unit frmProcJobListing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB, 
  ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, DAScript,
  MyScript, CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TfmProcJobListing = class(TBaseListingGUI)
    chkSelectAll: TCheckBox;
    lblSelectAll: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actlstFiltersUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure chkSelectAllClick(Sender: TObject);
  private
    TempTableName: string;
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

var
  fmProcJobListing: TfmProcJobListing;

implementation

{$R *.dfm}

uses
  ProcessDataUtils, CommonDbLib, BaseInputForm, CommonLib,
  IntegerListObj, BOMLib;

procedure TfmProcJobListing.FormCreate(Sender: TObject);
begin
  TempTableName:= GetUserTemporaryTableName('ProcessPartAllocation');
  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select');
  Qrymain.SQl.add('ID	as	ID	,');
  Qrymain.SQl.add('SaleId	as	SaleId	,');
  Qrymain.SQl.add('SaleDocNumber	as	SaleDocNumber	,');
  Qrymain.SQl.add('CustomerName	as	CustomerName	,');
  Qrymain.SQl.add('SaleDate	as	SaleDate	,');
  Qrymain.SQl.add('SaleShipDate	as	SaleShipDate	,');
  Qrymain.SQl.add('SaleLineId	as	SaleLineId	,');
  Qrymain.SQl.add('LineProductName	as	LineProductName	,');
  Qrymain.SQl.add('LineProductDescription	as	LineProductDescription	,');
  Qrymain.SQl.add('LineQty	as	LineQty	,');
  Qrymain.SQl.add('LineShipDate	as	LineShipDate	,');
  Qrymain.SQl.add('StepStatus	as	StepStatus	,');
  Qrymain.SQl.add('Finalized	as	Finalized	,');
  Qrymain.SQl.add('ProcTreeId	as	ProcTreeId');
  Qrymain.SQl.add('FROM ' + TempTableName);
  inherited;
end;

procedure TfmProcJobListing.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(TempTableName);
  inherited;
end;

procedure TfmProcJobListing.RefreshQuery;
var
  SelectComplete, SelectIncomplete: boolean;
begin
  SelectComplete:= (grpFilters.ItemIndex = 1) or (grpFilters.ItemIndex = 2);
  SelectIncomplete:= (grpFilters.ItemIndex = 0) or (grpFilters.ItemIndex = 2);
  ProcessDataUtils.BuildProductionJobList(TempTableName, SelectIncomplete, SelectComplete, dtFrom.DateTime, dtTo.DateTime);
  closedb(qrymain);
  inherited;
  grdMain.RemoveField('ProcTreeId');
end;

procedure TfmProcJobListing.grdMainDblClick(Sender: TObject);
var
  EditForm: TBaseInputGUI;
begin
//  inherited;
  if qryMain.Active and (not qryMain.IsEmpty) then begin
    EditForm := TBaseInputGUI(GetComponentByClassName('TSalesOrderGUI', false));
    if Assigned(EditForm) then begin
      with EditForm do begin
        EditForm.KeyID:= qryMain.FieldByName('SaleId').AsInteger;
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  end;  
end;

procedure TfmProcJobListing.grpFiltersClick(Sender: TObject);
begin
  inherited;
  self.RefreshQuery;
end;

procedure TfmProcJobListing.cmdNewClick(Sender: TObject);
var
  IdList: TIntegerList;
  x: integer;
  bm: TBookMark;
  allComplete, ConvertIncomplete: boolean;
  msg: string;
begin
  inherited;
  allComplete:= true;
  if grdMain.SelectedList.Count > 0 then begin
    IdList:= TIntegerList.Create;
    try
      bm:= grdMain.DataSource.DataSet.GetBookmark;
      grdMain.DataSource.DataSet.DisableControls;
      try
        for x:= 0 to grdMain.SelectedList.Count -1 do begin
          grdMain.DataSource.DataSet.GotoBookmark(grdMain.SelectedList[x]);
          IdList.Add(grdMain.DataSource.DataSet.FieldByName('SaleId').AsInteger);
          if grdMain.DataSource.DataSet.FieldByName('StepStatus').AsString <> 'Complete' then
            allComplete:= false;
        end;
      finally
        grdMain.DataSource.DataSet.GotoBookmark(bm);
        grdMain.DataSource.DataSet.FreeBookmark(bm);
        grdMain.DataSource.DataSet.EnableControls;
      end;
      ConvertIncomplete:= false;
      if not allComplete then begin
        ConvertIncomplete:=
          MessageDlgXP_Vista('Production is incomplete on some of the selected jobs, ' +
            'do you wish to finalise them anyway?',mtConfirmation,[mbYes,mbNo],0) = mrYes;

      end;
            if DoJobComplete(IdList,ConvertIncomplete, Msg) then begin
              self.RefreshQuery;
              if msg <> '' then CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
            end else
              if msg <> '' then CommonLib.MessageDlgXP_Vista(msg,mtWarning,[mbOk],0);
    finally
      IdList.Free;
    end;  
  end;
end;

procedure TfmProcJobListing.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'ProcTreeId,ID,SaleId,SaleLineId,ProcTreeId');
end;

procedure TfmProcJobListing.actlstFiltersUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  cmdNew.Enabled:= self.AccessLevel < 5;
end;

procedure TfmProcJobListing.chkSelectAllClick(Sender: TObject);
begin
  if chkSelectAll.Checked then begin
    grdMain.SelectAll;
  end else begin
    grdMain.UnselectAll;
  end;
end;

initialization
  RegisterClassOnce(TfmProcJobListing);

end.
