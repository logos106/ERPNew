// Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  //07/09/05  1.00.## ISB	Modified To Work With New Filtering on Baselisting.
  //20/10/05  1.00.01 DLS Added RegisterClass

unit FuncBookingsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,
  wwdbdatetimepicker, ProgressDialog, CustomInputBox, wwdblook, Shader;

type
  TFuncBookingsListGUI = class(TBaseListingGUI)
    qryMainFuncBookingID: TAutoIncField;
    qryMainClientID: TIntegerField;
    qryMainStartBooking: TDateTimeField;
    qryMainEndBooking: TDateTimeField;
    qryMainCompany: TStringField;
    qryMainRoomID: TIntegerField;
    qryMainRoomPrice: TFloatField;
    qryMainMealsPrice: TFloatField;
    qryMainDrinksPrice: TFloatField;
    qryMainTotalInc: TFloatField;
    qryMainFunction: TStringField;
    qryMainExtras: TFloatField;
    qryMainBooking: TAutoIncField;
    qryFuncStatuses: TMyQuery;
    qryMainStatus1: TStringField;
    qryMainStatus2: TStringField;
    qryMainStatus3: TStringField;
    qryMainStatus4: TStringField;
    qryMainStatus5: TStringField;
    qryMainStatus6: TStringField;
    qryFuncStatusesGlobalRef: TStringField;
    qryFuncStatusesID: TAutoIncField;
    qryFuncStatusesStatus1: TStringField;
    qryFuncStatusesStatus2: TStringField;
    qryFuncStatusesStatus3: TStringField;
    qryFuncStatusesStatus4: TStringField;
    qryFuncStatusesStatus5: TStringField;
    qryFuncStatusesStatus6: TStringField;
    qryFuncStatusesEditedFlag: TStringField;
    qryMainCancelled: TStringField;
    qryMainRescheduled: TStringField;
    qryMainBookingDescription: TStringField;
    qryMainConverted: TStringField;
    qryMainGlobalRef: TStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;

  private
    { Private declarations }

  public
    { Public declarations }
    procedure RefreshQuery; override;
  end;

//var
//  FuncBookingsListGUI: TFuncBookingsListGUI;

implementation

uses
  FuncBookingForm, CommonLib, FastFuncs;

{$R *.dfm}

procedure TFuncBookingsListGUI.RefreshQuery;
var
  i: integer;
begin
  inherited;
  for i := 1 to 6 do begin
    if qryMain.FindField('Status' + FastFuncs.IntToStr(i)) <> nil then begin
      if not Empty(FastFuncs.Trim(qryFuncStatuses.FieldByName('Status' + FastFuncs.IntToStr(i)).AsString)) then begin
        qryMain.FindField('Status' + FastFuncs.IntToStr(i)).DisplayLabel :=
          qryFuncStatuses.FieldByName('Status' + FastFuncs.IntToStr(i)).AsString;
      end else begin
        grdMain.RemoveField('Status' + FastFuncs.IntToStr(i));
      end;
    end;
  end;
end;

procedure TFuncBookingsListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TFuncBookingGUI');
  if Assigned(Form) then begin //if has acess
    with TFuncBookingGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;  
end;

procedure TFuncBookingsListGUI.FormShow(Sender: TObject);
begin
  qryFuncStatuses.Open;
  inherited;
end;

procedure TFuncBookingsListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Converted = ' + QuotedStr('F');
      end;
    1: 
      begin
        GroupFilterString := 'Converted = ' + QuotedStr('T');
      end;
  end;
  inherited;
end;

initialization
  RegisterClassOnce(TFuncBookingsListGUI);
end.
