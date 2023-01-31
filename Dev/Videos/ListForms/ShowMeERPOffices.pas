unit ShowMeERPOffices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ERPOffices, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,
  CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  Mask, wwdbedit;

type
  TShowMeERPOfficesGUI = class(TERPOfficesGUI)
    qryMainTeamViewer: TStringField;
    btnDetails: TDNMSpeedButton;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnDetailsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    procedure OpenERPSupport;
  Protected
    function TeamviewerIndex: Integer;Override;
    procedure SetGridColumns; Override;
    //procedure InitGridcontrols(Field: TField;AFont: TFont; ABrush: TBrush);Override;
  public
  end;


implementation

uses CommonLib, CommonFormLib, BaseListingForm, AppEnvironment, SystemLib,
  tcConst;

{$R *.dfm}

procedure TShowMeERPOfficesGUI.btnDetailsClick(Sender: TObject);
begin
  inherited;
  openERPListform('TERPOfficesGUI' );
end;

procedure TShowMeERPOfficesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  BaseIndexfields:=  qryMainTimezone.fieldname +' DESC';
end;

procedure TShowMeERPOfficesGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  Afont.size := 16;
  AFont.color := clBlack;
  if qryMainOpenStatus.asString ='Open' then begin
    Abrush.Color := clGreen;
(*  end else begin
    Abrush.Color := clwhite ;
    AFont.color := GridcolInactive;*)
  end;
end;

procedure TShowMeERPOfficesGUI.OpenERPSupport;
var
  s:String;
begin
      s:= '';
      if (FileExists(Appenv.companyprefs.ERPSupportPath +'\TrueERP Support.exe')) then
        s:= '"'+ Appenv.companyprefs.ERPSupportPath +'\TrueERP Support.exe" ';

      if s= '' then
        if (FileExists(Appenv.companyprefs.TeamViewerPath +'\TeamViewer.exe')) then
          s:= '"'+ Appenv.companyprefs.TeamViewerPath +'\TeamViewer.exe';

      if s<> '' then begin
        ExecNewProcess(s, False);
        Exit;
      end;

      MessageDlgXP_Vista('Please Install ERP Support.'  , mtWarning, [mbok], 0) ;
      Exit;
end;

procedure TShowMeERPOfficesGUI.grdMainMouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Sametext(ActiveFieldname , QrymainTeamViewer.fieldname )   then begin
    OpenERPSupport;
    Exit;
  end;
  inherited;
end;

(*procedure TShowMeERPOfficesGUI.InitGridcontrols(Field: TField;AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if Sametext(Field.FieldName, QrymainTeamviewer.FieldName) then begin
    edtTeamViewer.color := ABrush.color;
    edtTeamViewer.font.color := AFont.color;
  end;
end;*)

procedure TShowMeERPOfficesGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainTeamViewer.AsString:= ' . . .';
end;

procedure TShowMeERPOfficesGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(QrymainSundayStartsAt.Fieldname);
    RemoveFieldfromGrid(QrymainMondayStartsAt.Fieldname);
    RemoveFieldfromGrid(QrymainTuesdayStartsAt.Fieldname);
    RemoveFieldfromGrid(QrymainWednesDayStartsAt.Fieldname);
    RemoveFieldfromGrid(QrymainThursDayStartsAt.Fieldname);
    RemoveFieldfromGrid(QrymainFridayStartsAt.Fieldname);
    RemoveFieldfromGrid(QrymainSaturdayStartsAt.Fieldname);
    RemoveFieldfromGrid(QrymainSundayStopsAt.Fieldname);
    RemoveFieldfromGrid(QrymainMondayStopsAt.Fieldname);
    RemoveFieldfromGrid(QrymainTuesdayStopsAt.Fieldname);
    RemoveFieldfromGrid(QrymainWednesdayStopsAt.Fieldname);
    RemoveFieldfromGrid(QrymainThursdayStopsAt.Fieldname);
    RemoveFieldfromGrid(QrymainFridayStopsAt.Fieldname);
    RemoveFieldfromGrid(QrymainSaturdayStopsAt.Fieldname);
end;

function TShowMeERPOfficesGUI.TeamviewerIndex: Integer;
begin
  REsult := QrymainTeamviewer.Index;
end;

initialization
  RegisterClassOnce(TShowMeERPOfficesGUI );

end.
