unit CustomersForStatements;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DAScript, MyScript, ERPdbComponents,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TCustomersForStatementsGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainCompanyName: TWideStringField;
    qryMainTypeName: TWideStringField;
    qryMainClientID: TLargeintField;
    qryMainStopCredit: TWideStringField;
    qryMainJobName: TWideStringField;
    qryMainJobNumber: TIntegerField;
    qryMainSerial: TWideStringField;
    qryMainModel: TWideStringField;
    qryMainManufacture: TWideStringField;
    qryMainARBalance: TFloatField;
    qryMainAPBalance: TFloatField;
    qryMainBalance: TFloatField;
    qryMainFirstname: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainIsJob: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainParentClientID: TIntegerField;
    qryMainParentRelatedClientID: TIntegerField;
    qryMainSOBalance: TFloatField;
    qryMainMiddleName: TWideStringField;
    qryMainStreet: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainState: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainStreet3: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fReadfilter: TNotifyEvent;
  Protected
    Procedure SetGridColumns;Override;
  public
    Class Procedure ListForfilter(Currentfilter:String; xReadfilter:TNotifyEvent);
    Property Readfilter:TNotifyEvent REad fReadfilter Write fReadfilter;
  end;

implementation

uses CommonLib;

{$R *.dfm}
{ TCustomersForStatementsGUI }

procedure TCustomersForStatementsGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(freadFilter) then begin
    if CustomFilterString<>  Trim(CustomFilter.Filterstatement) then
      PreviewFilteredReport;
    freadFilter(Self);
  end;
  inherited;
end;

procedure TCustomersForStatementsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
  fReadfilter:= nil;
end;

procedure TCustomersForStatementsGUI.grdMainDblClick(Sender: TObject);
begin
  if Assigned(freadFilter) then self.close
  else begin
    SubsequentID := Chr(95) + qryMain.Fields.FieldByName('IsJob').AsString;
    inherited;
  end;
end;

class procedure TCustomersForStatementsGUI.ListForfilter(Currentfilter: String;
  xReadfilter: TNotifyEvent);
var
  ListForm: TCustomersForStatementsGUI;
begin
  ListForm:= TCustomersForStatementsGUI(GetComponentByClassName('TCustomersForStatementsGUI'));
  if ListForm.Visible then begin
    ListForm.Close;
    Freeandnil(ListForm);
    ListForm:= TCustomersForStatementsGUI(GetComponentByClassName('TCustomersForStatementsGUI'));
  end;
  if Assigned(ListForm) and (ListForm.Visible =False) then begin
    With ListForm do try
      CustomFilterString := CurrentFilter;
      Readfilter := xReadfilter;
      ShowModal;
    finally
        Free;
    end;
  end;

end;

procedure TCustomersForStatementsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainClientID.fieldname);
  RemoveFieldfromGrid(QrymainGlobalref.fieldname);
  RemoveFieldfromGrid(QrymainParentClientID.fieldname);
  RemoveFieldfromGrid(QrymainParentrelatedClientID.fieldname);
end;

initialization
  RegisterClassOnce(TCustomersForStatementsGUI);

end.
