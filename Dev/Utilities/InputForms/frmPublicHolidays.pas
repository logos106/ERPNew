unit frmPublicHolidays;
{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 ??/??/?? 1.00.01  ???  Initial Version
 19/12/05 1.00.02  AL   Removed "Instance"  *Task306*
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  ExtCtrls,
  DNMPanel, StdCtrls, Buttons, DNMSpeedButton, Grids, Wwdbigrd, Wwdbgrid,
  wwdbdatetimepicker, DBAccess, MyAccess,ERPdbComponents, MemDS, DataState, Menus, AdvMenus, Shader,
  ImgList, ProgressDialog;

type
  TfrmPublicHolidaysGUI = class(TBaseInputGUI)
    dsHolidays: TDataSource;
    FqryHolidays: TERPQuery;
    cmdOK: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    grdHolidays: TwwDBGrid;
    btnDelete: TwwIButton;
    dtDay: TwwDBDateTimePicker;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    FqryHolidaysDay: TDateField;
    FqryHolidaysDescription: TWideStringField;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdOKClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure grdHolidaysExit(Sender: TObject);
    procedure FqryHolidaysBeforePost(DataSet: TDataSet);

  private
    { Private declarations }
  public
    { Public declarations }
    function qryHolidays: TERPQuery;
  end;

implementation

uses
  DNMExceptions, CommonLib, FastFuncs;
  
{$R *.dfm}

procedure TfrmPublicHolidaysGUI.cmdCancelClick(Sender: TObject);
begin
  inherited;
  // Failed! Rollback Transaction and Cancel
  RollbackTransaction;
  Close;
end;


procedure TfrmPublicHolidaysGUI.FormCreate(Sender: TObject);
begin
  inherited;
  UserLock.Enabled := true;
end;

procedure TfrmPublicHolidaysGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      OpenQueries;

      // Put our Database Connection into transaction mode.
      BeginTransaction;

      EditNoAbort(FqryHolidays);

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

procedure TfrmPublicHolidaysGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  // Close down our query controls.
  CloseQueries;

  // Free form from memory.
  Action := caFree;
end;

procedure TfrmPublicHolidaysGUI.cmdOKClick(Sender: TObject);
begin
  try
    // By Moving the record pointer, if in edit mode
    // it will force a post.
    if FqryHolidays.State = dsEdit then begin
      FqryHolidays.Post;
    end;

    FqryHolidays.DisableControls;
    FqryHolidays.First;
    while not FqryHolidays.Eof do begin
      if Trim(FqryHolidays.FieldByName('Description').AsString) = '' then begin
        CommonLib.MessageDlgXP_Vista('Descriptions must not be blank!', mtWarning, [mbOK], 0);
        FqryHolidays.EnableControls;
        SetControlFocus(grdHolidays);
        grdHolidays.SetActiveField('Description');
        Exit;
      end;

      FqryHolidays.Next;
    end;


    CommitTransaction;
    
  except
    // Failed! Rollback Transaction and Cancel
    RollbackTransaction;
  end;

  // Close the form down.
  Close;
end;

procedure TfrmPublicHolidaysGUI.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if FqryHolidays.recordcount =0 then exit;
  if FqryHolidays.eof then FqryHolidays.Prior;
  if FqryHolidays.BOf then FqryHolidays.next;
  FqryHolidays.Delete;
end;

function TfrmPublicHolidaysGUI.qryHolidays: TERPQuery;
begin
  Result := FqryHolidays;
end;

procedure TfrmPublicHolidaysGUI.grdHolidaysExit(Sender: TObject);
begin
  inherited;
  if (grdHolidays.DataSource.DataSet.Active) and ((grdHolidays.DataSource.DataSet.RecordCount > 0)
    or (grdHolidays.DataSource.DataSet.State in [dsInsert])) then begin
    grdHolidays.DataSource.DataSet.Edit;                                                 
    grdHolidays.DataSource.DataSet.Post;
    grdHolidays.DataSource.DataSet.Edit;
  end;
end;

procedure TfrmPublicHolidaysGUI.FqryHolidaysBeforePost(DataSet: TDataSet);
Var qry : TERPQuery;
begin
  inherited;
  if FqryHolidays.State = dsInsert then begin
    qry := TERPQuery.Create(nil);
    qry.Options.FlatBuffers := True;
    qry.Connection := TERPQuery(DataSet).Connection;
    qry.SQL.Text := 'SELECT ID FROM tblpublicholidays WHERE Day = :xDay;';
    qry.ParamByName('xDay').AsDate := DataSet.FieldByName('Day').asDateTime;
    qry.Open;
    if qry.RecordCount > 0 then begin
      CommonLib.MessageDlgXP_Vista('Duplicate dates are not allowed!'+#13+#10+'Please change date.', mtWarning, [mbOK], 0);
    end;
  end;  
end;

initialization
  RegisterClassOnce(TfrmPublicHolidaysGUI);
end.
