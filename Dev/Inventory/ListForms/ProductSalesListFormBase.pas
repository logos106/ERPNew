unit ProductSalesListFormBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox;

type
  TProductSalesListFormBaseGUI = class(TBaseListingGUI)
    btnUpdate: TDNMSpeedButton;
    cboClassQry: TERPQuery;
    Panel4: TPanel;
    lblClassTitle: TLabel;
    cboClass: TwwDBLookupCombo;
    btnSolorNotsoldreport: TDNMSpeedButton;
    procedure btnUpdateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
  private
    fiClassId:Integer;
  public
    Property ClassID:Integer read fiClassId write fiClassId;
  end;


implementation

uses CommonLib, CommonDbLib, AppEnvironment, tcConst;

{$R *.dfm}

procedure TProductSalesListFormBaseGUI.btnUpdateClick(Sender: TObject);
var
  MAAQValue: double;
  LinesID: integer;
  UpdateStr: string;
  ErrorPos: integer;
  QueryResult: boolean;
  ResultValue: integer;
  //qryUpdate: TERPQuery;
  x: integer;
begin
  inherited;
  UpdateStr := IntToStr(AppEnv.CompanyPrefs.MonthsStockRetained);

  repeat
    ResultValue := 0;
    QueryResult := InputQuery('Update Preferred Level',
      'Update selected record(s) with the Monthly Average Activity Quantity * Months Stock Retained?' + NL +NL+
      'As per the preference, the Months Stock to be Retained is ' + UpdateStr+'.  Please change it if needed.' , UpdateStr);
    if QueryResult then begin
      Val(UpdateStr, ResultValue, ErrorPos);

      if (ErrorPos > 0) or (ResultValue <= 0) then CommonLib.MessageDlgXP_Vista('Invalid value entered, please re-enter.', mtWarning, [mbOK], 0);
    end;
  until (QueryResult = false) or ((ErrorPos = 0) and (ResultValue > 0));



  if QueryResult then begin
    Processingcursor(True);
    AppEnv.CompanyPrefs.MonthsStockRetained := ResultValue;
    qryMain.DisableControls;
    try
      With TempMyQuery do try
        for x:= 0 to grdMain.SelectedList.Count -1 do begin
          grdMain.DataSource.DataSet.GotoBookmark(grdMain.SelectedList[x]);
          grdMain.DataSource.DataSet.FreeBookmark(grdMain.SelectedList[x]);
          MAAQValue := grdMain.DataSource.DataSet.FieldByName('MAAQ').AsFloat;
          LinesID := grdMain.DataSource.DataSet.FieldByName('LinesID').AsInteger;
          if UserLock.Lock('tblparts' , Qrymain.FieldByName('PartsId').AsInteger , 'Update Preferedlevel from MAAQ') then
            if (MAAQValue <> 0) and (AppEnv.CompanyPrefs.MonthsStockRetained>0) then
              SQL.Add('update tblProductClasses Set PreferredLevel = Round(' +FloattoStr(MAAQValue) +'*' + inttostr(AppEnv.CompanyPrefs.MonthsStockRetained)+') where id = ' + inttostr(LinesID) +';');
        end;
      finally
        if SQL.Count >0 then Execute;
        Userlock.Unlock('Update Preferedlevel from MAAQ');
        Free;
      end;
    finally
      grdMain.SelectedList.Clear;
      RefreshQuery;
      qryMain.EnableControls;
      Processingcursor(False);
    end;
  end;
end;

procedure TProductSalesListFormBaseGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  RefreshQuery;
end;

procedure TProductSalesListFormBaseGUI.FormCreate(Sender: TObject);
begin
  fiClassID:=0;
  inherited;
  GrpfilterSupplied :=True;
end;

procedure TProductSalesListFormBaseGUI.FormShow(Sender: TObject);
begin
    cboClassQry.Open;
    if fiClassId <> 0 then
      cboClassQry.Locate('classID',   fiClassId, [loCaseInsensitive])
    else
    cboClassQry.Locate('ClassName',   AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive]);
    cboClass.Value := cboClassQry.fieldbyname('Classname').AsString;
  inherited;
  btnUpdate.hint := 'To Update all selected Products'' Prefered level = MAAQ  * Preference Months Stock Retained (' + inttostr(Appenv.companyprefs.MonthsStockRetained)+')  '+NL;
  btnUpdate.showhint := True;
end;

end.

