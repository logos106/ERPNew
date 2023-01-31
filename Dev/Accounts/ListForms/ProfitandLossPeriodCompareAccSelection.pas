unit ProfitandLossPeriodCompareAccSelection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProfitandLossPeriodCompareAccSelectionGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMaindescription: TWideStringField;
    qryMainfinalorder: TIntegerField;
    qryMainTotalAmount: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    fsProfitandLossPeriodComparemaintablename:String;
    fsSelectedPnLIds:String;
    procedure SetProfitandLossPeriodComparemaintablename(const Value: String);
    procedure SelectPnLIds;
  Protected
    procedure SetGridColumns; Override;
  public
    Property ProfitandLossPeriodComparemaintablename :String read fsProfitandLossPeriodComparemaintablename write SetProfitandLossPeriodComparemaintablename;
    Procedure RefreshQuery;Override;
    Property SelectedPnLIds :String read fsSelectedPnLIds write fsSelectedPnLIds;
  end;


implementation

uses CommonLib, tcConst;

{$R *.dfm}
procedure TProfitandLossPeriodCompareAccSelectionGUI.cmdNewClick(
  Sender: TObject);
begin
//  inherited;
  grdMain.SelectedList.Clear;
  if Assigned(fOnGridDataSelect) then begin
    // form is being used as a lookup grid (eg ExpressProduct) so call handler then close
    fOnGridDataSelect(grdMain);
    CloseList;
  end;
end;

procedure TProfitandLossPeriodCompareAccSelectionGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ProfitandLossPeriodComparemaintablename:='';
end;

procedure TProfitandLossPeriodCompareAccSelectionGUI.FormShow(Sender: TObject);
begin
  inherited;
  cmdNew.Caption := 'Unselect';
  cmdNew.Enabled := true;

end;

procedure TProfitandLossPeriodCompareAccSelectionGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  SelectPnLIds;
end;

procedure TProfitandLossPeriodCompareAccSelectionGUI.RefreshQuery;
begin
  Try
    inherited;
  EXcept
    on E:Exception do begin
      if devmode then
        MessageDlgXP_vista(Qrymain.SQL.text +NL + E.message, mtWarning, [mbOK], 0);
    end;
  End;
end;

procedure TProfitandLossPeriodCompareAccSelectionGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainID.fieldname);
  RemoveFieldfromGrid(qryMainfinalorder.fieldname);
end;

procedure TProfitandLossPeriodCompareAccSelectionGUI.SetProfitandLossPeriodComparemaintablename(const Value: String);
begin
  fsProfitandLossPeriodComparemaintablename := Value;
  if value <> '' then begin
    closeDb(Qrymain);
    Qrymain.SQL.text := 'select '+
                      ' ID as ID, '+
                      ' if(ifnull(Accountname,"")="", AccounttypeDesc,concat("   " , Accountname)) description, '+
                      ' finalorder as finalorder, '+
                      ' TotalAmount as TotalAmount '+
                      ' from  '+ Value +
                      ' Where trim(if(ifnull(Accountname,"")="", AccounttypeDesc,Accountname) ) <> "" '+
                      ' Order By FinalOrder,AccountHeaderOrder,AccountSub1Order,AccountSub2Order ,AccountSub3Order,TotalAmount';
    RefreshOrignalSQL;
  end;
end;


procedure TProfitandLossPeriodCompareAccSelectionGUI.SelectPnLIds;
var
  st:TStringlist;
  ctr:Integer;
begin
  grdmain.unselectall;
  if (fsSelectedPnLIds <>'') and (fsSelectedPnLIds <> '0') then begin
    st:= tStringlist.create;
    try
      st.commatext := fsSelectedPnLIds;
      for ctr:= 0 to st.count-1 do begin
        if Qrymain.locate('ID' , st[ctr], []) then
          Grdmain.selectrecord;
      end;
    finally
      freeandnil(st);
    end;
  end;
end;

initialization
  RegisterClassOnce(TProfitandLossPeriodCompareAccSelectionGUI);

end.

