unit GoogleanalysisCost;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader,
  DNMAction, wwcheckbox, CustomInputBox, wwradiogroup, wwclearbuttongroup;

type
  TGoogleanalysisCostGUI = class(TBaseListingGUI)
    qryMainAccountName: TWideStringField;
    qryMainCampaign: TWideStringField;
    qryMainAdword: TWideStringField;
    qryMainDateTime: TDateTimeField;
    qryMainCost: TFloatField;
    qryMainCostPerTransaction: TFloatField;
    qryMaincostPerconversion: TFloatField;
    qryMainamountPosted: TFloatField;
    btnMakebill: TDNMSpeedButton;
    qryMainCostID: TIntegerField;
    qryMainAccountForPosting: TWideStringField;
    qryMainAccountIDForPosting: TIntegerField;
    qryMainPurchaseOrderId: TIntegerField;
    qryMainPurchaseLineID: TIntegerField;
    actMakeBill: TDNMAction;
    grpExtraFilters: TwwRadioGroup;
    qryMainAmtToPost: TFloatField;
    qryMainBillamount: TFloatField;
    btnMainList: TDNMSpeedButton;
    qryMaindetails: TLargeintField;
    procedure actMakeBillUpdate(Sender: TObject);
    procedure actMakeBillExecute(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);override;
    procedure FormCreate(Sender: TObject);
    procedure btnMainListClick(Sender: TObject);
  private
    FilterItemIndexclean:Integer;
    DTFromClean:TDateTime;
    DTToClean:TdateTime;
    filterClean :String;
    procedure ValidateSelection;
    procedure showDetails;

  Protected
    Procedure RefreshQuery; override;
    procedure SetGridColumns; override;
    procedure DoAfterallSelected; override;
    function isvalidtoSelect:Boolean;override;
    Procedure RefreshTotals;override;
  public
  end;


implementation

uses CommonLib, CommonDbLib, busobjExpenses, AppEnvironment,
  GoogleAnalyticLib, tcConst;

{$R *.dfm}
{ TGoogleanalysisCostGUI }
procedure TGoogleanalysisCostGUI.actMakeBillExecute(Sender: TObject);
var
  Ids:String;
begin
  if (Appenv.companyprefs.SupplierforautoPostingGoogle= '') then begin
      MessageDlgXP_vista('It is not possible to make the Bill as ''supplier for auto Posting of google cost'' is not selected.' +NL +'Please select it in Preference -> EDI and Integration', mtInformation, [mbOK], 0);
      Exit;

  end;

  if  grpExtraFilters.itemindex <> 2 then begin
      MessageDlgXP_vista('Please select ''Extra Details'' and select records to be posted', mtInformation, [mbOK], 0);
      Exit;
  end;
  ValidateSelection;
  if  (grdMain.SelectedList.Count = 0) then begin
      MessageDlgXP_vista('Please select the records to be posted', mtInformation, [mbOK], 0);
      Exit;
  end;

    IDS:= SelectedIDs('costID');
    PostAll(Ids);
    RefreshQuery;
end;

procedure TGoogleanalysisCostGUI.actMakeBillUpdate(Sender: TObject);
begin
  inherited;
  //actMakeBill.Enabled :=  (Appenv.companyprefs.SupplierforautoPostingGoogle<> '') and (grdMain.SelectedList.Count > 0);
end;
procedure TGoogleanalysisCostGUI.btnMainListClick(Sender: TObject);
begin
  inherited;
  Setcontrolfocus(grdmain);
  btnMainList.Visible:= False;
  HighlightControl;
  DtFrom.Date :=   DTFromClean ;
  DTto.Date:=  DTToClean;
  groupfilterString := filterClean ;
  ApplyQueryFilter;
  RefreshfilterLabel;
  RefreshQuery;
  grpExtraFilters.ItemIndex := FilterItemIndexclean;
  Grpfiltersclick(grpExtraFilters);
end;

procedure TGoogleanalysisCostGUI.DoAfterallSelected;
begin
  inherited;
  if grdmain.SelectedList.Count =0 then
    Timermsg(lblNote , 'There are no valid record for posting');
end;

procedure TGoogleanalysisCostGUI.FormCreate(Sender: TObject);
begin
  inherited;
  FilterItemIndexclean:= -1;
  AddCalccolumn(qryMainCost.FieldName, true);
end;

procedure TGoogleanalysisCostGUI.FormShow(Sender: TObject);
begin
  inherited;
  if Appenv.companyprefs.SupplierforautoPostingGoogle= '' then
    btnMakebill.Hint := 'It is not possible to make the Bill as ''supplier for auto Posting of google cost'' is not selected.' +NL +'Please select it in Preference -> EDI and Integration'+NL;
end;

procedure TGoogleanalysisCostGUI.ValidateSelection;
begin
  IterateProcNo:= ItearteProcno4ValidateSelection;
  IterateselectedRecordsReverse;
end;

procedure TGoogleanalysisCostGUI.grdMainCalcCellColors(Sender: TObject;Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;ABrush: TBrush);
begin
  inherited;
  if Grpfilters.itemindex = 2 then begin
    if Qrymaincost.asFloat - QrymainamountPosted.asFloat <> 0 then
      Afont.color := clgreen;
  end;
  if Grpextrafilters.itemindex = 1 then begin
    if qryMainAccountIDForPosting.AsInteger =0 then
      Afont.color := clInactiveCaption;
  end;
end;
procedure TGoogleanalysisCostGUI.showDetails;
var
  sfilter:String;
begin
  sfilter:='';
  btnMainList.Visible:= True;
  HighlightControl(btnMainList);
  btnMainList.bringtofront;
  DTFromClean := DTFrom.Date;
  DTToClean := DTto.Date;
  filterClean := GroupfilterString;
  FilterItemIndexclean:= grpExtraFilters.ItemIndex;

  if dTFrom.date <= QrymainDateTime.asDAtetime then DtFrom.Date:= QrymainDateTime.asDAtetime;
  if DtTo.date   >= QrymainDateTime.asDAtetime then DtTo.Date := QrymainDateTime.asDAtetime;


  if QrymainDetails.asInteger >= 2 then begin
     if sfilter <> '' then sfilter:= sfilter +' and ';
     sfilter := sfilter +
                                QrymainAccountName.fieldname +' =' +Quotedstr(QrymainAccountName.asString) ;
  end;

  if QrymainDetails.asInteger =2 then begin
     if sfilter <> '' then sfilter:= sfilter +' and ';
     sfilter := sfilter +
                                QrymainCampaign.fieldname +' =' +Quotedstr(QrymainCampaign.asString) (*+ ' and ' +
                                Qrymainadword.fieldname +' =' +Quotedstr(Qrymainadword.asString)*) ;
  end;
  RefreshfilterLabel;
  PreviewFilteredReport;
  RefreshQuery;
  grpExtraFilters.ItemIndex :=2;
  if GroupfilterString <> '' then GroupfilterString:= GroupfilterString +' and ';
  GroupfilterString := GroupfilterString + sfilter;
  inherited grpfiltersclick(grpExtraFilters);

end;
procedure TGoogleanalysisCostGUI.grdMainDblClick(Sender: TObject);
begin
  if (grpExtraFilters.ItemIndex <=1) and (Sametext(Activefieldname , Qrymaincost.FieldName)) then begin
    if MessageDlgXP_Vista('This will Refresh the list in ''Extra Details'' for the selected record Range / Campaign / Adword. Would you like to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrYEs then
      showDetails;
  end else begin
    inherited;
  end;

end;

procedure TGoogleanalysisCostGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  if Selecting then begin
    accept := isvalidtoSelect;
  end;
end;

procedure TGoogleanalysisCostGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:begin
        GroupFilterString := 'AmtToPost =0 and cost <> 0';
      end;
    1:begin
        GroupFilterString := 'AmtToPost <>0 and cost <> 0';
      end;
    2:begin
           GroupFilterString := '';
      end;
  end;
      if GroupFilterString <> '' then GroupFilterString := GroupFilterString +' and ';
            if grpExtrafilters.ItemIndex = 0 then GroupFilterString := GroupFilterString +    ' details =3'
      else  if grpExtrafilters.ItemIndex = 1 then GroupFilterString := GroupFilterString +    ' details =2'
      else GroupFilterString := GroupFilterString +    ' details =1';
  inherited;
end;

function TGoogleanalysisCostGUI.isvalidtoSelect:Boolean;
begin
(*    if  (qryMaindefaultsource.asString ='') then begin
      result := False;
      Timermsg(lblNote , qryMainAccountName.AsString +'.' +qryMainTitle.AsString +' doesn''t have a default source');
      Exit;
    end;*)
    if  (qryMainAccountIDForPosting.AsInteger=0) then begin
      result := False;
      Timermsg(lblNote , qryMainAccountName.AsString +' doesn''t have the account selected');
      Exit;
    end;
    if Qrymaincost.AsFloat  - qryMainamountPosted.AsFloat =0 then begin
      result := False;
      Timermsg(lblNote , qryMainAccountName.AsString +' is already posted');
      Exit;
    end;
    (*if qryMaindayssinceupdatetolastcheck.AsInteger <2 then begin
      Timermsg(lblNote , qryMainAccountName.AsString +'.' +qryMainTitle.AsString +'.' +qryMainCampaign.AsString +'.' +qryMainAdword.AsString +'''s last update is only ' +inttostr(qryMaindayssinceupdatetolastcheck.AsInteger) +' days before the last check.');
      result := False;
      Exit;
    end;*)
    result:= true;
end;

procedure TGoogleanalysisCostGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainAmtToPost.AsFloat := Qrymaincost.AsFloat - qryMainamountPosted.AsFloat;
end;

procedure TGoogleanalysisCostGUI.RefreshQuery;
begin
  Qrymain.ParamByName('DateFrom').AsDateTime := FilterDateFrom;
  Qrymain.ParamByName('Dateto').AsDateTime := FilterDateTo;
  inherited;
end;

procedure TGoogleanalysisCostGUI.RefreshTotals;
begin
  inherited;
  CalcnshowFooter;
end;

procedure TGoogleanalysisCostGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainCostId.FieldName);
  RemoveFieldfromGrid(qryMainAccountIDForPosting.FieldName);
  RemoveFieldfromGrid(qryMainPurchaseLineID.FieldName);
  RemoveFieldfromGrid(qryMainDetails.FieldName);
  //RemoveFieldfromGrid(qryMaindayssinceupdatetolastcheck.FieldName);
end;

initialization
  RegisterClassOnce(TGoogleanalysisCostGUI);

end.

