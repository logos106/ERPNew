unit frmNABCardFastExportList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls, CardFastLib, wwcheckbox, ProgressDialog,
  CustomInputBox, wwdblook, Shader, kbmMemTable;

type
  TfmNABCardFastExportList = class(TBaseListingGUI)
    qryMainCardHolderName: TStringField;
    qryMainTxReference: TStringField;
    qryMainMerchantID: TStringField;
    qryMainTxType: TStringField;
    qryMainCardNumber: TStringField;
    qryMainExpiryDate: TStringField;
    qryMainAuthID: TStringField;
    qryMainProcessed: TStringField;
    qryMainApply: TStringField;
    chkApplyCardFast: TwwCheckBox;
    qryMainAmount: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure chkApplyCardFastClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    fCardFast: TCardFast;
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses
  CommonDbLib, CommonLib;

procedure TfmNABCardFastExportList.FormCreate(Sender: TObject);
begin
  //  fbIgnoreAccessLevels:= true;
  inherited;
  DefaultMaxGridColumnWidth := 40;

  //
  // Set connection details
  //
  with MyConnection1 do begin
    Password := CommonDbLib.GetSharedMyDacConnection.Password;
    Username := CommonDbLib.GetSharedMyDacConnection.Username;
    Database := CommonDbLib.GetSharedMyDacConnection.Database;
    Server   := CommonDbLib.GetSharedMyDacConnection.Server;
    Port     := CommonDbLib.GetSharedMyDacConnection.Port;
  end;

  qryMain.Connection := MyConnection1;
  MyConnection1.Open;
  qryMain.Open;
  fCardFast := TCardFast.Create(MyConnection1);
end;

procedure TfmNABCardFastExportList.FormDestroy(Sender: TObject);
begin
  FreeandNil(fCardFast);
  inherited;
end;

procedure TfmNABCardFastExportList.FormShow(Sender: TObject);
begin
  inherited;
  qryMainAmount.currency := true;
end;

procedure TfmNABCardFastExportList.RefreshQuery;
begin
  qryMain.Next;
  inherited;
end;

procedure TfmNABCardFastExportList.cmdNewClick(Sender: TObject);
var
  SaveFilter: string;
begin
  inherited;
  qryMain.Next;

  //
  // Save the current filter and then change the filter to only allow csv
  // file selection
  //
  SaveFilter := dlgSave.Filter;
  dlgSave.Filter := 'Comma Delimited Text (*.CSV) | *.csv';

  //
  // Set the default filename to include the current date and time
  //
  dlgSave.FileName := 'NAB CardFast ' + FormatDateTime('dd-mm-yyyy hh.mm.ss AM/PM', Now) + '.csv';

  //
  // Set the filename in the fCardFast object and then export the data from
  // the tblcardfast table to the file specified
  //
  if dlgSave.Execute = true then begin
    qryMain.DisableControls;
    fCardFast.FileName := dlgSave.FileName;
    fCardFast.ExportPayments;
    btnRequery.Click;
    qryMain.EnableControls;
  end;

  //
  // Restore the original filter
  //
  dlgSave.Filter := SaveFilter;
end;

procedure TfmNABCardFastExportList.chkApplyCardFastClick(Sender: TObject);
begin
  if not TwwCheckBox(Sender).DataSource.DataSet.Active then Exit;

  TwwCheckBox(Sender).DataSource.DataSet.Edit;

  if TwwCheckBox(Sender).Checked then TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString :=
      'T'
  else TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'F';
end;

procedure TfmNABCardFastExportList.cmdExportClick(Sender: TObject);
begin
  qryMain.Next;
  inherited;
end;

procedure TfmNABCardFastExportList.grdMainDblClick(Sender: TObject);
begin
  //  inherited;
end;

procedure TfmNABCardFastExportList.cmdCloseClick(Sender: TObject);
begin
  qryMain.Next;
  inherited;
end;

procedure TfmNABCardFastExportList.cmdPrintClick(Sender: TObject);
begin
  qryMain.Next;
  inherited;
end;

initialization
  RegisterClassOnce(TfmNABCardFastExportList);
  
end.
