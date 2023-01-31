unit frmBusObjFilterParamEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, MemDS, Grids, Wwdbigrd,
  Wwdbgrid, DNMSpeedButton, Buttons, StdCtrls, ImgList;

type
  TfmBusObjFilterParamEdit = class(TBaseInputGUI)
    pnlTop: TPanel;
    Panel2: TPanel;
    qryFilterParams: TERPQuery;
    dsFilterParams: TDataSource;
    wwDBGrid1: TwwDBGrid;
    btnOk: TDNMSpeedButton;
    qryFilterParamsGlobalRef: TWideStringField;
    qryFilterParamsBusObjFilterParamID: TIntegerField;
    qryFilterParamsBusObjFilterID: TIntegerField;
    qryFilterParamsParamName: TWideStringField;
    qryFilterParamsDescription: TWideStringField;
    qryFilterParamsmsTimeStamp: TDateTimeField;
    wwDBGrid1IButton: TwwIButton;
    lblFilterName: TLabel;
    lblFilterDescription: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure qryFilterParamsBeforePost(DataSet: TDataSet);
    procedure wwDBGrid1IButtonClick(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  fmBusObjFilterParamEdit: TfmBusObjFilterParamEdit;

implementation

{$R *.dfm}

uses
  DNMExceptions, FormFactory, CommonLib, CommonDbLib;


procedure TfmBusObjFilterParamEdit.FormCreate(Sender: TObject);
begin
  inherited;
//
end;

procedure TfmBusObjFilterParamEdit.FormShow(Sender: TObject);
var
  qry: TERPQuery;
begin
  DisableForm;
  try
    try
      inherited;
      // Roll back any existing transaction
  //    RollbackTransaction;


      // Put our Database Connection into transaction mode.
  //    BeginTransaction;

     // qryProcResource.ParamByName('ProcResourceId').asInteger := KeyID;

      if KeyID = 0 then begin
        raise Exception.Create('No Key Id');
      end else begin
        qryFilterParams.SQL.Text:= 'select * from tblBusObjFilterParam where BusObjFilterId = ' + intToStr(KeyId);
      end;
      qryFilterParams.Open;
      qry:= CommonDbLib.TempMyQuery;
      try
        qry.SQL.Text:= 'select FilterName, Description from tblBusObjFilter where BusObjFilterId = ' + IntToStr(KeyId);
        qry.Open;
        lblFilterName.Caption:= qry.FieldByName('FilterName').AsString;
        lblFilterDescription.Caption:= qry.FieldByName('Description').AsString;
      finally
        qry.Free;
      end;

  //    if ProcResource.Processes.Count > 0 then begin
  //      qryProcessStep.Close;
  //      qryProcessStep.ParamByName('Id').AsInteger := ProcResource.Processes.ProcessStepId;
  //      qryProcessStep.Open;
  //      qryResourceProcessStep.First;
  //      qryResourceProcessStep.IndexFieldNames:= 'ProcessStepDescription ASC';
  //    end;

      //DataState.Activate;

      // Exception Handler
    except
      // Handle these known exceptions.
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;   
end;

procedure TfmBusObjFilterParamEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
//
end;

procedure TfmBusObjFilterParamEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

procedure TfmBusObjFilterParamEdit.FormDestroy(Sender: TObject);
begin
  inherited;
//
end;

procedure TfmBusObjFilterParamEdit.btnOkClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmBusObjFilterParamEdit.qryFilterParamsBeforePost(
  DataSet: TDataSet);
begin
  inherited;
//  if qryFilterParamsParamName.AsString = '' then
//    Abort;
//  qryFilterParams.Cancel;
  if  qryFilterParamsBusObjFilterID.AsInteger <= 0 then
    qryFilterParamsBusObjFilterID.AsInteger:= KeyId;

end;

procedure TfmBusObjFilterParamEdit.wwDBGrid1IButtonClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Are youe sure you want to delete?',mtconfirmation,[mbYes,mbNo],0) = mrYes then
    qryFilterParams.Delete;
end;

initialization
  RegisterClassOnce(TfmBusObjFilterParamEdit);
  with FormFact do begin
    // register all columns on course list form to open this form on DblClick
    RegisterMe(TfmBusObjFilterParamEdit, 'TfmBusObjFilterList_*=BusObjFilterId');
  end;


end.
