unit frmSelectedDates;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls , BaseListingForm, DAScript, MyScript, kbmMemTable,
  CustomInputBox, wwDialog, Wwlocate, ActnList, PrintDAT, AdvOfficeStatusBar,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook,
  DNMSpeedButton, Shader, DNMPanel;

type
  TfmSelectedDates = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    qryMain: TERPQuery;
    dsMain: TDataSource;
    grdMain: TwwDBGrid;
    btnGrid: TwwIButton;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    qryMaincaption: TWideStringField;
    qryMainsun: Tdatefield;
    qryMainMon: Tdatefield;
    qryMainTue: Tdatefield;
    qryMainWed: Tdatefield;
    qryMainThur: Tdatefield;
    qryMainFri: Tdatefield;
    qryMainSat: Tdatefield;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    lblCaption: TLabel;
    qryMainweekno: TIntegerField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string;
      AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
  private

    { Private declarations }
  public
    procedure setDatesSelected(const Value: array of TDateTime);
    Class Function CondirmDates(AOwner:Tform; fDatesSelected:Array of TDateTime ; UserMsg:String):Boolean;
  end;


implementation

uses CommonDbLib, MySQLConst, LogLib;

{$R *.dfm}

{ TfmSelectedDates }

class function TfmSelectedDates.CondirmDates(AOwner:Tform; fDatesSelected: array of TDateTime;UserMsg: String): Boolean;
var
  form :TfmSelectedDates;
begin
  form := TfmSelectedDates.Create(AOwner);
  try
    form.color := aowner.Color;
    form.grdmain.titlecolor :=form.color;
    form.grdmain.footercolor :=form.color;
    form.setDatesSelected(fDatesSelected);
    form.lblCaption.Caption := UserMsg;
    form.showmodal;
    Result :=form.modalresult = mrOk;
  finally
    Freeandnil(form);
  end;

end;

procedure TfmSelectedDates.FormShow(Sender: TObject);
begin
  inherited;
  openQueries;
end;

procedure TfmSelectedDates.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if sametext(field.fieldname , Qrymainsun.fieldname) Or sametext(field.fieldname , Qrymainsat.fieldname) then
    ABrush.color := $00EAEAEA;
  if sametext(field.fieldname , QrymainCaption.fieldname) then
    ABrush.color := $00E8E8FF;
end;

procedure TfmSelectedDates.grdMainCalcTitleAttributes(Sender: TObject;
  AFieldName: string; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
  if sametext(AFieldName , Qrymainsun.fieldname) Or sametext(AFieldName , Qrymainsat.fieldname) then
    ABrush.color := $00EAEAEA;
  if sametext(AFieldName , QrymainCaption.fieldname) then
    ABrush.color := $00E8E8FF;

end;

procedure TfmSelectedDates.setDatesSelected(const Value: array of TDateTime);
  function dateRange:String;
  var
    ctr:Integer;
  begin
    REsult := '';
    for ctr:= low(value) to high(value) do begin
      if result <> '' then result := result +  ' union all ';
      result := result + 'Select ' +  quotedstr(formatDateTime(mySQLDateformat , value[ctr])) +' as dt ';
    end;

  end;
begin
  closedb(qryMain);
  qryMain.SQL.clear;
  qryMain.SQL.Text:= 'Select convert(WEEK(dt) ,SIGNED) weekno, '+
                     ' DATE_FORMAT(dt ,"%M %Y") as caption,'+
                     ' convert(min(if(WEEKDAY(dt)=6 , dt , null)) , date) as sun ,'+
                     ' convert(min(if(WEEKDAY(dt)=0 , dt , null)) , date) as Mon,'+
                     ' convert(min(if(WEEKDAY(dt)=1 , dt , null)) , date) as Tue ,'+
                     ' convert(min(if(WEEKDAY(dt)=2 , dt , null)) , date) as Wed ,'+
                     ' convert(min(if(WEEKDAY(dt)=3 , dt , null)) , date) as Thur ,'+
                     ' convert(min(if(WEEKDAY(dt)=4 , dt , null)) , date) as Fri,'+
                     ' convert(min(if(WEEKDAY(dt)=5 , dt , null)) , date) as Sat'+
                     ' from ('+
                     DateRange +
                     ' order by dt)dates ' +
                     ' group by WEEK(dt)';
  clog(Qrymain.SQL.Text);
end;

end.
