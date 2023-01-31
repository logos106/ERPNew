unit frmSTPPayRunDetailList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TfmSTPPayRunDetailList = class(TBaseListingGUI)
    qryMainSTPField: TWideStringField;
    qryMainFieldName: TWideStringField;
    qryMainSubField: TWideStringField;
    qryMainSurname: TWideStringField;
    qryMainFirstName: TWideStringField;
    qryMainPayID: TIntegerField;
    qryMainEmployeeID: TIntegerField;
    qryMainPayDate: TDateField;
    qryMainDatePaid: TDateTimeField;
    qryMainPayCodeDescription: TWideStringField;
    qryMainPeriodAmount: TFloatField;
    qryMainYTDAmount: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FPayRunID: integer;
    procedure SetPayRunID(const Value: integer);
    { Private declarations }
  public
    property PayRunID: integer read FPayRunID write SetPayRunID;
  end;



implementation

{$R *.dfm}

uses
  CommonDbLib, DnmLib, DateUtils, AppEnvironment;

{ TfmSTPPayRunDetailList }

procedure TfmSTPPayRunDetailList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmSTPPayRunDetailList.FormCreate(Sender: TObject);
begin
  inherited;
  qryMain.ParamByName('PayRunID').AsInteger := 0;
  qryMain.ParamByName('DateFrom').AsDateTime := 0;
  qryMain.ParamByName('DateTo').AsDateTime := 0;
  qryMain.ParamByName('RegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfmSTPPayRunDetailList.SetPayRunID(const Value: integer);
var
  qry: TERPQuery;
  YearStart, YearEnd: TDateTime;
begin
  FPayRunID := Value;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text := 'select RunDate from tblPayRun where ID = ' + IntToStr(Value);
    qry.Open;
    YearStart := StartOfTheFY(qry.FieldByName('RunDate').AsDateTime);
    YearEnd := EncodeDate(YearOf(YearStart)+1,7,1);
  finally
    qry.Free;
  end;
  qryMain.Close;
  qryMain.ParamByName('PayRunID').AsInteger := Value;
  qryMain.ParamByName('DateFrom').AsDateTime := YearStart;
  qryMain.ParamByName('DateTo').AsDateTime := YearEnd;
  qryMain.Open;
end;

initialization
  RegisterClass(TfmSTPPayRunDetailList);

end.
