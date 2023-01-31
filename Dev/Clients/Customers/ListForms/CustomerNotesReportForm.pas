unit CustomerNotesReportForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, DBAccess, MyAccess, MemDS,
  wwdbdatetimepicker, ProgressDialog, CustomInputBox, wwdblook, Shader,
  kbmMemTable;

type
  TCustomerNotesReportGUI = class(TBaseListingGUI)
    qryMainCompany: TStringField;
    qryMainEquipmentName: TStringField;
    qryMainDescription: TStringField;
    qryMainNotesExtract: TStringField;
    qryMainNotes: TMemoField;
    qryMainIsJob: TStringField;
    qryMainID: TIntegerField;
    qryMainClientID: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdMainDblClick(Sender: TObject); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  CustomerNotesReportGUI: TCustomerNotesReportGUI;

implementation

uses CommonLib;

{$R *.dfm}

procedure TCustomerNotesReportGUI.FormCreate(Sender: TObject);
begin
  //fbIgnoreAccessLevels := True;
  inherited;
end;

procedure TCustomerNotesReportGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  CustomerNotesReportGUI := nil;
end;

procedure TCustomerNotesReportGUI.grdMainDblClick(Sender: TObject);
begin
  if not (grdMain.GetActiveField = qryMainNotes) then begin
    // this allows us to open a customer form or job form according to the
    // .. value of IsJob
    SubsequentID := Chr(95) + qryMain.Fields.FieldByName('IsJob').AsString;
    inherited;
  end;
end;

initialization
  RegisterClassOnce(TCustomerNotesReportGUI);
end.
