unit PnLAreaReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , busobjAreaCodes, BusObjBase,PnLReportBase,
  CustomInputBox, wwclearbuttongroup, wwradiogroup;

type
  TPnLAreaReportGUI = class(TPnLReportBaseGUI)
    qryMainID: TIntegerField;
    qryMainDetails: TIntegerField;
    qryMainTransID: TIntegerField;
    qryMainOrderDate: TDateTimeField;
    qryMainWeekno: TIntegerField;
    qryMainmonthno: TIntegerField;
    qryMainQuarterno: TIntegerField;
    qryMainyearno: TIntegerField;
    qryMainPeriodID: TDateTimeField;
    qryMainPeriod: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainTranstype: TWideStringField;
    qryMainCostEx: TFloatField;
    qryMainAmountTax: TFloatField;
    qryMainCostInc: TFloatField;
    qryMainPriceEx: TFloatField;
    qryMainPriceInc: TFloatField;
    qryMainDepartment: TWideStringField;
    btnPnlAreareport: TDNMSpeedButton;
    lblClassTitle: TLabel;
    btnDeptSelect: TDNMSpeedButton;
    Label4: TLabel;
    chkAllClass: TwwCheckBox;
    procedure grpFiltersClick(Sender: TObject);   override;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormDestroy(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnPnlAreareportClick(Sender: TObject);
    procedure btnDeptSelectClick(Sender: TObject);
    procedure chkAllClassClick(Sender: TObject);
  private
    fAreaCode :TAreaCode;
    fsSelectedAreaIds :String;
    SelectedDepartments: TStrings;
    Procedure ShowDetails;
    function AreaCode(const ignoreSelectedIDs:Boolean =False) :TAreaCode;
    procedure beforeShowPnLEmployeereportGUI(Sender: TObject);
    procedure LabelChange(const ignoreGuiPref:Boolean = False);
    procedure LabelChangeCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure MakeAreafields;
    procedure MakeAreafieldsCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure AddAreafields;
    procedure AddAreafieldsCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure Selectedfiedcallback(const Sender: TBusObj; var Abort: Boolean);
    procedure AssignSeletedAreas(Sender: TObject);
    procedure OnAreasselect(Sender: TwwDBGrid);
    procedure ResetFields;
    function allAreaCodes: String;
    Function AreaFieldName(Const AreaCode:String):String;
    function DepartmentList: string;
  Protected
    Procedure MakeQrymain(const PopulateData:boolean = true);    Override;
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    Procedure RefreshTotals;Override;
  public
    Procedure RefreshQuery;override;
    Property SelectedAreaIds :String read fsSelectedAreaIds write fsSelectedAreaIds;
  end;


implementation

uses CommonLib, MySQLUtils,  BusobjCustomFilter, dateUtils, DNMLib,
  frmPnLEmployeeReportoptions, CommonFormLib, CommonDbLib , tcConst,
  AppEnvironment, MySQLConst, Areacodes, PnLAreaEmployeeReport, PnlReportLib,
  LogLib, frmPayDeptSelectionGUI;

const
  Amtfields: array[1..5] of string =
    ('_CostEx', '_AmountTax', '_CostInc', '_PriceEx', '_PriceInc');

{$R *.dfm}
{ TPnLEmployeereportGUI }

procedure TPnLAreaReportGUI.btnDeptSelectClick(Sender: TObject);
var
  fShowSubTotals: boolean;
begin
  inherited;
  if DoDepartmentSelection(SelectedDepartments,fShowSubTotals,true) then begin
    if chkAllClass.Checked then chkAllClass.Checked := False;
//    LabelChange;
//    GuiPrefs.Node['ShowSubTotals'].AsBoolean:= fShowSubTotals;
    if chkAllClass.Checked then
        GuiPrefs.Node['SelectedDepartments'].AsString:= ''
    else GuiPrefs.Node['SelectedDepartments'].AsString:= SelectedDepartments.CommaText;
    RefreshQuery;
  end;
end;

procedure TPnLAreaReportGUI.btnPnlAreareportClick(Sender: TObject);
begin
  inherited;
  OpenERpListForm('TPnLAreaEmployeeReportGUI', copyParamsto);
  Self.Close;
end;

procedure TPnLAreaReportGUI.btnSelectClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormultiselectModal('TAreacodesGUI' , AssignSeletedAreas , OnAreasselect);
end;
procedure TPnLAreaReportGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if chkAllClass.Checked then
      GuiPrefs.Node['SelectedDepartments'].AsString:= ''
  else GuiPrefs.Node['SelectedDepartments'].AsString:= SelectedDepartments.CommaText;
  RefreshQuery;
//  CallLabelChange;
end;

function TPnLAreaReportGUI.DepartmentList: string;
var
  x: integer;
begin
  result := '';
  if chkAllClass.Checked then
    exit;
  for x := 0 to SelectedDepartments.Count - 1 do begin
    if x > 0 then result:= result + ',';
    result := result + '"' + SelectedDepartments[x] + '"';
  end;
end;

procedure TPnLAreaReportGUI.AssignSeletedAreas (Sender: TObject);
begin
  if not(Sender is TAreacodesGUI) then exit;
  TAreacodesGUI(Sender).AreaIdstoSelect:= fsSelectedAreaIds
end;
procedure TPnLAreaReportGUI.OnAreasselect(Sender: TwwDBGrid);
begin
  if not(Sender.Owner is TAreacodesGUI) then exit;
  fsSelectedAreaIds := TAreacodesGUI(Sender.Owner).SelectedIDs('ID' , True);
  if fsSelectedAreaIds = '' then fsSelectedAreaIds := '0';
  RefreshQuery;
  ResetFields;
end;
procedure TPnLAreaReportGUI.ResetFields;
var
  ctr:Integer;
  fiIndex:Integer;
  fsFieldList:String;
begin
    showProgressbar('Organizing Area fields' , Areacode(true).count *2 +2 );
    try
      StepProgressbar;
      fiIndex := Qrymain.fields.count;
      fsFieldList:= '';
      with Areacode(true) do begin
        first;
        while Eof = False do begin
          for ctr:= low(amtfields) to high(Amtfields) do begin
            if fiIndex >Qrymain.fieldbyname(AreafieldName(Trim(Areacode)) + Amtfields[ctr]).Index then  fiIndex := Qrymain.fieldbyname(AreafieldName(Trim(Areacode)) + Amtfields[ctr]).Index;
            if fsFieldList <> '' then fsFieldList := fsFieldList +',';
            fsFieldList := fsFieldList +AreafieldName(Trim(Areacode)) + Amtfields[ctr];
            StepProgressbar;
          end;
          Next;
        end;
      end;
      if fsFieldList <> '' then RemoveFieldsfromGrid(fsFieldList);
      fsFieldList := '';
      with Areacode do begin
        first;
        while Eof = False do begin
          for ctr:= low(amtfields) to high(Amtfields) do begin
            if fsFieldList <> '' then fsFieldList := fsFieldList +',';
            fsFieldList := fsFieldList +AreafieldName(Trim(Areacode)) + Amtfields[ctr];
          end;
          StepProgressbar;
          Next;
        end;
      end;

      AddFieldstoGrid(fsFieldList, fiIndex);
    finally
      HideProgressbar;
    end;
end;

function TPnLAreaReportGUI.AreaCode(const ignoreSelectedIDs:Boolean =False): TAreaCode;
var
  s:String;
begin
  if fAreacode = nil then begin
    fAreaCode := TAreaCode.CreateWithNewConn(Self);
  end;
  s:='active ="T" and ifnull(Areacode,"")<> "" ';
  if ignoreSelectedIDs =false then
    if fsSelectedAreaIds <> '' then
      s:= s +' and Id in (' + fsSelectedAreaIds +')';
  fAreaCode.LoadSelect(s);
  result :=fAreaCode;
end;

function TPnLAreaReportGUI.AreaFieldName(const AreaCode: String): String;
begin
  result := ReplaceStr(AreaCode,' ',  '_');
  result := ReplaceStr(result,'#',  '_');
end;

procedure TPnlAreaReportGui.MakeAreafieldsCallback(const Sender: TBusObj; var Abort: Boolean);
var
  fsFieldName:String;
  ctr:Integer;
begin
  if not(Sender is TAreacode) then exit;
  if AreafieldName(AreafieldName(Trim(TAreacode(Sender).Areacode)))='' then exit;
  for ctr:= low(Amtfields)  to high(Amtfields) do begin
    fsFieldName:=AreafieldName(Trim(TAreacode(Sender).Areacode)) + Amtfields[ctr];
    if qryMain.FindField(fsFieldName) = nil then begin
      with TFloatField.Create(Self) do begin
        Currency := True;
        fieldKind := fkData;
        fieldname := fsFieldName;
        name := ComponentName(self, 'Qrymain'+fsFieldName);
        //Displayformat := AppEnv.RegionalOptions.CurrencySymbol + DOUBLE_FIELD_MASK;
        DataSet := qryMain;
        Tag := TAG_MASK_DC;
        visible := True;
      end;
    end;
  end;
end;
procedure TPnlAreaReportGui.AddAreafieldsCallback(const Sender: TBusObj; var Abort: Boolean);
var
  fsFieldName:String;
  ctr:Integer;
begin
  if not(Sender is TAreacode) then exit;
  if AreafieldName(Trim(TAreacode(Sender).Areacode))='' then exit;
  for ctr:= low(Amtfields)  to high(Amtfields) do begin
    fsFieldName:=AreafieldName(Trim(TAreacode(Sender).Areacode)) + Amtfields[ctr];
    AddCalccolumn(fsFieldName, true);
  end;
end;
Procedure TPnlAreaReportGui.AddAreafields;
begin
  Areacode.IterateRecords(AddAreafieldsCallback);
end;
Procedure TPnlAreaReportGui.MakeAreafields;
var
  ctr:Integer;
  fsFieldName:string;
begin
  Areacode.IterateRecords(MakeAreafieldsCallback);
  for ctr:= low(Amtfields)  to high(Amtfields) do begin
    fsFieldName:='BlankArea' + Amtfields[ctr];
    if qryMain.FindField(fsFieldName) = nil then begin
      with TFloatField.Create(Self) do begin
        fieldKind := fkData;
        fieldname := fsFieldName;
        name := ComponentName(self, 'Qrymain'+fsFieldName);
        currency := True;
        //Displayformat := AppEnv.RegionalOptions.CurrencySymbol + DOUBLE_FIELD_MASK;
        DataSet := qryMain;
        Tag := TAG_MASK_DC;
        visible := True;
      end;
    end;
  end;

end;
procedure TPnLAreaReportGUI.FormCreate(Sender: TObject);
begin
    Self.Caption := replacestr(Self.Caption , 'Area' , AppEnv.CompanyPrefs.Areacolumnname);
    TitleLabel.Caption := replacestr(TitleLabel.Caption , 'Area' , AppEnv.CompanyPrefs.Areacolumnname);
    btnSelect.Caption := replacestr(btnSelect.Caption , 'Area' , AppEnv.CompanyPrefs.Areacolumnname);
    btnPnlAreareport.Caption := replacestr(btnPnlAreareport.Caption , 'Area' , AppEnv.CompanyPrefs.Areacolumnname);


    SelectedDepartments := TStringList.Create;
    fAreaCode :=nil;
    fstablename := commondblib.GetUserTemporaryTableName('Pnlbyarea');
    MakeQrymain(False);
    Qrymain.SQL.Text := 'select * from ' + fsTablename +'2';
    MakeAreafields;
    LabelChange(true);
    inherited;
    //MakeQrymain;
    Freeandnil(fAreacode);
    AddCalccolumn(QrymainCostEx.FieldName, true);
    AddCalccolumn(QrymaincostInc.FieldName, true);
    AddCalccolumn(QrymainPriceEx.FieldName, true);
    AddCalccolumn(QrymainPriceInc.FieldName, true);
    AddCalccolumn(qryMainAmountTax.FieldName, true);
    AddAreafields;
end;

procedure TPnLAreaReportGUI.FormDestroy(Sender: TObject);
begin
  Freeandnil(fAreacode);
  SelectedDepartments.Free;
  inherited;
end;

procedure TPnLAreaReportGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if field is TFloatfield then
      if Field.AsFloat =0 then
        Afont.Color := ABrush.Color;

  if field is TIntegerField then
      if Field.asInteger =0 then
        Afont.Color := ABrush.Color;

end;

procedure TPnLAreaReportGUI.grdMainDblClick(Sender: TObject);
begin
   if QrymainDetails.asInteger=1 then  begin
    SubsequentID := Chr(95) + qryMainTranstype.AsString;
    inherited;
   end else begin
      ShowDetails;
   end;
end;
procedure TPnLAreaReportGUI.LabelChangeCallback(const Sender: TBusObj; var Abort: Boolean);
var
  ctr:Integer;
begin
  if not(Sender is TAreacode) then exit;
  for ctr:= low(Amtfields)  to high(Amtfields) do
    if Qrymain.findfield(AreafieldName(Trim(TAreacode(Sender).Areacode)) + Amtfields[ctr] )   <> nil then TFloatfield(Qrymain.findfield(AreafieldName(Trim(TAreacode(Sender).Areacode)) + Amtfields[ctr])).currency   := True;
end;
procedure TPnLAreaReportGUI.Selectedfiedcallback(const Sender: TBusObj; var Abort: Boolean);
var
  ctr:Integer;
begin
  if not(Sender is TAreacode) then exit;
  for ctr:= low(Amtfields)  to high(Amtfields) do begin
    AddGridSelectedfield(AreafieldName(Trim(TAreacode(Sender).Areacode)) + Amtfields[ctr] ,10,  replacestr(Amtfields[ctr], '_' , '') , TAreacode(Sender).Areacode(*AreafieldName(Trim(TAreacode(Sender).Areacode))*));
  end;
end;

procedure TPnLAreaReportGUI.LabelChange(const ignoreGuiPref:Boolean = False);
var
  ctr:Integer;
begin
  AreaCode.IterateRecords(LabelChangeCallback);
  for ctr:= low(Amtfields)  to high(Amtfields) do begin
      if Qrymain.findfield(replacestr(Amtfields[ctr],'_' , '') )   <> nil then TFloatfield(Qrymain.findfield(replacestr(Amtfields[ctr],'_' , ''))).currency   := True;
      if Qrymain.findfield('BlankArea' + Amtfields[ctr] )   <> nil then TFloatfield(Qrymain.findfield('BlankArea' + Amtfields[ctr])).currency   := True;
  end;

  if ignoreGuiPref  then begin
    FieldList := TStringList.Create;
    try
      AddGridSelectedfield('TransID',20 , 'Sale#');
      AddGridSelectedfield('OrderDate',20 , 'Order Date');
      AddGridSelectedfield('Weekno',20 , 'Week #');
      AddGridSelectedfield('monthno',20 , 'Month #');
      AddGridSelectedfield('Quarterno',20 , 'Quarter #');
      AddGridSelectedfield('yearno',20 , 'Year #');
      AddGridSelectedfield('Period',20 , 'Period');
      AddGridSelectedfield('Description',20 , 'Desription');
      AddGridSelectedfield('AccountName',20 , 'Account Name');
      AddGridSelectedfield('Transtype',20 , 'type');
      for ctr:= low(Amtfields)  to high(Amtfields) do begin
        AddGridSelectedfield( 'BlankArea' + Amtfields[ctr] ,10,  replacestr(Amtfields[ctr], '_' , '') , 'No Area');
      end;
      Areacode.IterateRecords(Selectedfiedcallback);
      for ctr:= low(Amtfields)  to high(Amtfields) do begin
        AddGridSelectedfield( replacestr(Amtfields[ctr], '_' , '') ,12,  replacestr(Amtfields[ctr], '_' , '') , 'Total');
      end;
      grdMain.Selected := FieldList;
      grdMain.ApplySelected;
    finally
      FreeAndNil(FieldList);
    end;
  end;
end;
procedure TPnLAreaReportGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := 'Details =' + inttostr(grpfilters.ItemIndex +1);
  inherited;
       if grpfilters.ItemIndex=0 then qrymainperiod.DisplayLabel := 'Trans Date'
  else if grpfilters.ItemIndex=1 then qrymainperiod.DisplayLabel := 'Trans Date'
  else if grpfilters.ItemIndex=2 then qrymainperiod.DisplayLabel := 'Week no - Year'
  else if grpfilters.ItemIndex=3 then qrymainperiod.DisplayLabel := 'Month - Year'
  else if grpfilters.ItemIndex=4 then qrymainperiod.DisplayLabel := 'Quarter - Year'
  else qrymainperiod.DisplayLabel := 'Year';
end;


Function TPnLAreaReportGUI.allAreaCodes:String;
begin
  result:= TERPQuery(areacode(true).dataset).groupconcat('AreaCode', '' , False, ',' , '' , '' , true, true);
end;
procedure TPnLAreaReportGUI.MakeQrymain(const PopulateData:boolean = true);
var
  s:String;
  ctr:Integer;

begin
  With ScriptMain do try
    SQL.clear;
    SQL.add(PnlTransSQL(fsTablename+'1', False,includePO, includeBill, includeCredit, includecheque, includeinvoice,includeVoucher,  includeSO, includeCashSale, includePOS, includeRefund, includeLayby, includeJE, filterdatefrom, filterDateTo, DepartmentList));
    SQL.Add('Drop table if Exists ' + fsTablename +'2;');
    SQL.Add('CREATE TABLE `' + fsTablename +'2` (');
    SQL.Add('`ID`           int(11)       NOT NULL AUTO_INCREMENT,');
    SQL.Add('`Details`      int(11)       NULL DEFAULT 0,');
    SQL.Add('`TransID`      int(11)       NULL DEFAULT 0,');
    SQL.Add('`OrderDate`    datetime      NULL DEFAULT NULL,');
    SQL.Add('`Weekno`       int(11)       NULL DEFAULT NULL,');
    SQL.Add('`monthno`      int(11)       NULL DEFAULT NULL,');
    SQL.Add('`Quarterno`    int(11)       NULL DEFAULT NULL,');
    SQL.Add('`yearno`       int(11)       NULL DEFAULT NULL,');
    SQL.Add('`PeriodID`     datetime      NULL DEFAULT NULL,');
    SQL.Add('`Period`       varchar(20)   NULL DEFAULT NULL,');
    SQL.Add('`Department`   varchar(255)  NULL DEFAULT NULL,');
    SQL.Add('`Description`  varchar(100)  NULL DEFAULT NULL,');
    SQL.Add('`AccountName`  varchar(100)  NULL DEFAULT NULL,');
    SQL.Add('`Transtype`    varchar(20)   NULL DEFAULT "",');
    SQL.Add('RecInfo varchar(2000) ,');
    With AreaCode(true) do begin
      if count > 0 then begin
        first;
        While Eof = False do begin
          for ctr:= low(Amtfields) to high(Amtfields) do
            ScriptMain.SQL.add('`' + AreafieldName(Trim(Areacode)) + Amtfields[ctr]+'`    Double NOT NULL DEFAULT 0,');
          Next;
        end;
      end;
    end;

    for ctr:= low(Amtfields) to high(Amtfields) do
      ScriptMain.SQL.add('`' + 'BlankArea' + Amtfields[ctr] +'`    double NOT NULL DEFAULT 0,');

    for ctr:= low(Amtfields) to high(Amtfields) do
      ScriptMain.SQL.add('`' + replaceStr(Amtfields[ctr], '_' , '') +'`    double NOT NULL DEFAULT 0,');
    SQL.Add(s);
    SQL.Add('  PRIMARY KEY (`ID`)');
    SQL.Add(') ENGINE=MyISAM DEFAULT CHARSET=utf8;');
    //SQL.Add('ALTER TABLE `' +fstablename+'2` 		ADD INDEX `RecInfo`  (RecInfo);');
    if PopulateData then begin
      SQL.Add('update ' +fstablename+'1  T1 Set T1.Details     =0   where ifnull(T1.details,0)      = 0;');
      SQL.Add('update ' +fstablename+'1  T1 Set T1.TransID     =0   where ifnull(T1.TransID,0)      = 0;');
      SQL.Add('update ' +fstablename+'1  T1 Set T1.OrderDate   =0   where ifnull(T1.OrderDate,0)    = 0;');
      SQL.Add('update ' +fstablename+'1  T1 Set T1.Weekno      =0   where ifnull(T1.Weekno,0)       = 0;');
      SQL.Add('update ' +fstablename+'1  T1 Set T1.monthno     =0   where ifnull(T1.monthno,0)      = 0;');
      SQL.Add('update ' +fstablename+'1  T1 Set T1.Quarterno   =0   where ifnull(T1.Quarterno,0)    = 0;');
      SQL.Add('update ' +fstablename+'1  T1 Set T1.yearno      =0   where ifnull(T1.yearno,0)       = 0;');
      SQL.Add('update ' +fstablename+'1  T1 Set T1.PeriodID    =0   where ifnull(T1.PeriodID,0)     = 0;');
      SQL.Add('update ' +fstablename+'1  T1 Set T1.Period      =0   where ifnull(T1.Period,0)       = 0;');
      SQL.Add('update ' +fstablename+'1  T1 Set T1.Description =""  where ifnull(T1.Description ,"")= "";');
      SQL.Add('update ' +fstablename+'1  T1 Set T1.AccountName =""  where ifnull(T1.AccountName ,"")= "";');
      SQL.Add('update ' +fstablename+'1  T1 Set T1.Transtype   =""  where ifnull(T1.Transtype ,"")  = "";');
      SQL.Add('update ' +fstablename+'1  T1 Set T1.Category    =""  where ifnull(T1.Category ,"")   = "";');
      SQL.Add('update ' +fstablename+'1  T1 Set T1.Department  =""  where ifnull(T1.Department ,"") = "";');
      SQL.Add('update ' +fstablename+'1  Set RecInfo =   concat(`Details` ,  `TransID` ,  `OrderDate` ,  `Weekno` ,  `monthno` ,  `Quarterno` ,  `yearno` ,  `PeriodID` ,  `Period` ,  `Description` ,  `AccountName` ,  `Transtype` );');
      SQL.Add('insert into ' +fstablename+'2 (Details,TransID,OrderDate,Weekno,monthno,Quarterno,yearno,PeriodID,Period,Department,Description,AccountName,Transtype, RecInfo)' +
              ' Select distinct Details,TransID,OrderDate,Weekno,monthno,Quarterno,yearno,PeriodID,Period,Department,Description,AccountName,Transtype,RecInfo from ' +fstablename +'1 ORder by Details, Period, TransType, accountname;');
      With AreaCode(true) do begin
        if count > 0 then begin
          first;
          While Eof = False do begin
            s:= 'update ' +fstablename +'2 T1 inner join ' +fstablename +'1 as T2 on  T1.RecInfo = T2.RecInfo  and T2.Category = ' +quotedstr(Trim(Areacode)) +'   set ';
            for ctr:= low(Amtfields) to high(Amtfields) do begin
              s:= s+ 'T1.`' + AreafieldName(Trim(Areacode)) + Amtfields[ctr]+ '` = T2.' +  replacestr(Amtfields[ctr], '_' , '')+'';
              if ctr<> high(Amtfields) then s:= s + ',' else s:= s +';';
            end;
            ScriptMain.SQL.add(s );
            Next;
          end;
        end;
      end;


      s:= 'update ' +fstablename +'2 T1 inner join ' +fstablename +'1 as T2 on  T1.RecInfo = T2.RecInfo and /*not(T2.Category in  ('  +  allAreaCodes +'))' +'*/ T2.Category= ""   set ';
      for ctr:= low(Amtfields) to high(Amtfields) do begin
              s:= s+ 'T1.`' + 'BlankArea' + Amtfields[ctr]+ '` = T2.' +  replacestr(Amtfields[ctr], '_' , '')+'';
              if ctr<> high(Amtfields) then s:= s + ',' else s:= s+ ';';
      end;
      ScriptMain.SQL.add(s );

      With Areacode(true) do begin
        for ctr:= low(Amtfields) to high(Amtfields) do begin
          s:= 'update ' +fstablename +'2 T1  set T1.' + replacestr(Amtfields[ctr], '_' , '') + ' = ';
          first;
          while eof = False do begin
              s:= s+ 'T1.' + AreafieldName(Trim(Areacode))+ Amtfields[ctr] +'+';
              Next;
          end;
          s:= s+ 'T1.' + 'BlankArea'+ Amtfields[ctr] +';';
          ScriptMain.SQL.add(s );
        end;
      end;
    end;
  finally
    showProgressbar('Making report Data', 40);
    try
      clog(SQl.Text );
      Execute;
    finally
      HideProgressbar;
    end;
  end;
  RefreshOrignalSQL(false);
end;

procedure TPnLAreaReportGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  includePO         := GuiPrefs.Node['Options.IncludePO'].AsBoolean;
  includeBill       := GuiPrefs.Node['Options.Includebill'].AsBoolean;
  includeCredit     := GuiPrefs.Node['Options.IncludeCredit'].AsBoolean;
  includecheque     := GuiPrefs.Node['Options.IncludeCheque'].AsBoolean;
  includeinvoice    := GuiPrefs.Node['Options.IncludeInvoice'].AsBoolean;
  includeVoucher    := GuiPrefs.Node['Options.IncludeVoucher'].AsBoolean;
  includeSO         := GuiPrefs.Node['Options.includeSO'].AsBoolean;
  includeJE         := GuiPrefs.Node['Options.includeJE'].AsBoolean;
  includeCashSale   := GuiPrefs.Node['Options.IncludeCashSale'].AsBoolean;
  includePOS        := GuiPrefs.Node['Options.IncludePOs'].AsBoolean;
  includeRefund     := GuiPrefs.Node['Options.includeRefund'].AsBoolean;
  includeLayby      := GuiPrefs.Node['Options.includeLayby'].AsBoolean;
  fsSelectedAreaIds := GuiPrefs.Node['Options.SelectedArea'].asString;

end;

procedure TPnLAreaReportGUI.RefreshQuery;
begin
    MakeQrymain;
    inherited;
         if grpfilters.ItemIndex=0 then qrymainperiod.DisplayLabel := 'Trans Date'
    else if grpfilters.ItemIndex=1 then qrymainperiod.DisplayLabel := 'Week no - Year'
    else if grpfilters.ItemIndex=2 then qrymainperiod.DisplayLabel := 'Month - Year'
    else if grpfilters.ItemIndex=3 then qrymainperiod.DisplayLabel := 'Quarter - Year'
    else if grpfilters.ItemIndex=4 then qrymainperiod.DisplayLabel := 'Year';
    TimerMsg(lblDateComments, 'Please check the ''OPTIONS'' for the type of transactions included in the report');
    ResetFields;
end;

procedure TPnLAreaReportGUI.RefreshTotals;
begin
  inherited;
  CalcnShowfooter;
end;

procedure TPnLAreaReportGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainPeriodID.FieldName);
  RemoveFieldfromGrid(QrymainDetails.FieldName);
  RemoveFieldfromGrid(qryMainOrderDate.FieldName);
  RemoveFieldfromGrid(qryMainWeekno.FieldName);
  RemoveFieldfromGrid(qryMainmonthno.FieldName);
  RemoveFieldfromGrid(qryMainQuarterno.FieldName);
  RemoveFieldfromGrid(qryMainyearno.FieldName);
end;


procedure TPnLAreaReportGUI.beforeShowPnLEmployeereportGUI(Sender:TObject);
var
  s:String;
  function AreafieldSelected:Boolean;
  var
    fs:String;
    ctr:Integer;
  begin
    fs:= ActivefieldNAme;
    for ctr:= low(Amtfields) to high(Amtfields) do fs:= replaceStr(fs, Amtfields[ctr] , '');
    result:= not(SameText(fs, activefieldname));
  end;

  function AreaoffieldSelected:String;
  var
    ctr:Integer;
  begin
    result:= ActivefieldNAme;
    for ctr:= low(Amtfields) to high(Amtfields) do result:= replaceStr(result, Amtfields[ctr] , '');
  end;

  function Areafilter:String;
  begin
    REsult:= '';
    if AreafieldSelected then Result:= 'Category =' +Quotedstr(AreaoffieldSelected ) +' AND ';
  end;
begin
  if not(Sender is TPnLAreaEmployeeReportGUI) then exit;
  DTFromClean := DTFrom.Date;
  DTToClean := DTto.Date;
  FilterItemIndexclean:= grpfilters.ItemIndex;
  if QrymainDetails.asInteger = 2 then begin
     if dTFrom.date <= QrymainOrderdate.asDAtetime then DtFrom.Date:= QrymainOrderdate.asDAtetime;
     if DtTo.date   >= QrymainOrderDate.asDAtetime then DtTo.Date := QrymainOrderDate.asDAtetime;
     if s <> '' then s:= s +' and ';
     s := s +Areafilter +
            QrymainAccountname.fieldname +' =' +Quotedstr(QrymainAccountname.asString) +' and ' +
            QrymainTransType.fieldname +' =' +Quotedstr(QrymainTransType.asString) ;
  end else if QrymainDetails.asInteger = 3 then begin
     if dTFrom.date <= QrymainOrderdate.asDAtetime then DtFrom.Date := EncodeDateWeek(qrymainyearno.AsInteger, qrymainweekno.AsInteger);
     if DtTo.date   >= QrymainOrderDate.asDAtetime then DtTo.Date := EndOfTheWeek(DtFrom.Date);
     if s <> '' then s:= s +' and ';
     s := s +Areafilter +
            QrymainAccountname.fieldname +' =' +Quotedstr(QrymainAccountname.asString) +' and ' +
            QrymainTransType.fieldname +' =' +Quotedstr(QrymainTransType.asString) ;
  end else if QrymainDetails.asInteger = 4 then begin
     if dTFrom.date <= QrymainOrderdate.asDAtetime then DtFrom.Date := EncodeDate(qrymainyearno.AsInteger, qrymainmonthno.AsInteger , 1);
     if DtTo.date   >= QrymainOrderDate.asDAtetime then DtTo.Date := EndOfTheMonth(DtFrom.Date);
     if s <> '' then s:= s +' and ';
     s := s +Areafilter +
            QrymainAccountname.fieldname +' =' +Quotedstr(QrymainAccountname.asString) +' and ' +
            QrymainTransType.fieldname +' =' +Quotedstr(QrymainTransType.asString) ;
  end else if QrymainDetails.asInteger = 5 then begin
     if dTFrom.date <= QrymainOrderdate.asDAtetime then DtFrom.Date := EncodeDate(qrymainyearno.AsInteger, (QrymainQuarterno.AsInteger - 1) * 3 + 1 , 1);
     if DtTo.date   >= QrymainOrderDate.asDAtetime then DtTo.Date := EndOfTheQuarter(DtFrom.Date);
     if s <> '' then s:= s +' and ';
     s := s +Areafilter +
            QrymainAccountname.fieldname +' =' +Quotedstr(QrymainAccountname.asString) +' and ' +
            QrymainTransType.fieldname +' =' +Quotedstr(QrymainTransType.asString) ;
  end else if QrymainDetails.asInteger = 6 then begin
     if dTFrom.date <= QrymainOrderdate.asDAtetime then DtFrom.Date := EncodeDate(QrymainYearno.asInteger ,1,1);
     if DtTo.date   >= QrymainOrderDate.asDAtetime then DtTo.Date := EndOfTheYear(DtFrom.Date);
     if s <> '' then s:= s +' and ';
     s := s +Areafilter +
            QrymainAccountname.fieldname +' =' +Quotedstr(QrymainAccountname.asString) +' and ' +
            QrymainTransType.fieldname +' =' +Quotedstr(QrymainTransType.asString) ;
  end else if QrymainDetails.asInteger = 7 then begin
     if s <> '' then s:= s +' and ';
     s := s +Areafilter +
            QrymainAccountname.fieldname +' =' +Quotedstr(QrymainAccountname.asString) ;
  end;
  TPnLAreaEmployeeReportGUI(Sender).filterString := s;
  TPnLAreaEmployeeReportGUI(Sender).IsEmployee     := False;
  TPnLAreaEmployeeReportGUI(Sender).IncludePO      := includePO;
  TPnLAreaEmployeeReportGUI(Sender).Includebill    := includeBill;
  TPnLAreaEmployeeReportGUI(Sender).IncludeCredit  := includeCredit;
  TPnLAreaEmployeeReportGUI(Sender).IncludeCheque  := includecheque;
  TPnLAreaEmployeeReportGUI(Sender).IncludeInvoice := includeinvoice;
  TPnLAreaEmployeeReportGUI(Sender).IncludeVoucher := includeVoucher;
  TPnLAreaEmployeeReportGUI(Sender).includeSO      := includeSO;
  TPnLAreaEmployeeReportGUI(Sender).includeJE      := includeJE;
  TPnLAreaEmployeeReportGUI(Sender).IncludeCashSale:= includeCashSale;
  TPnLAreaEmployeeReportGUI(Sender).IncludePOs     := includePOS;
  TPnLAreaEmployeeReportGUI(Sender).includeRefund  := includeRefund;
  TPnLAreaEmployeeReportGUI(Sender).includeLayby   := includeLayby;
end;
procedure TPnLAreaReportGUI.ShowDetails;
begin
  OpenERPListForm('TPnLEmployeereportGUI' ,beforeShowPnLEmployeereportGUI );
end;

procedure TPnLAreaReportGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.IncludePO'].AsBoolean      := includePO;
  GuiPrefs.Node['Options.Includebill'].AsBoolean    := includeBill;
  GuiPrefs.Node['Options.IncludeCredit'].AsBoolean  := includeCredit;
  GuiPrefs.Node['Options.IncludeCheque'].AsBoolean  := includecheque;
  GuiPrefs.Node['Options.IncludeInvoice'].AsBoolean := includeinvoice;
  GuiPrefs.Node['Options.IncludeVoucher'].AsBoolean := includeVoucher;
  GuiPrefs.Node['Options.includeSO'].AsBoolean      := includeSO;
  GuiPrefs.Node['Options.includeJE'].AsBoolean      := includeJE;
  GuiPrefs.Node['Options.IncludeCashSale'].AsBoolean:= includeCashSale;
  GuiPrefs.Node['Options.IncludePOs'].AsBoolean     := includePOS;
  GuiPrefs.Node['Options.includeRefund'].AsBoolean  := includeRefund;
  GuiPrefs.Node['Options.includeLayby'].AsBoolean   := includeLayby;
  GuiPrefs.Node['Options.SelectedArea'].asString    := fsSelectedAreaIds;
  if chkAllClass.Checked then
      GuiPrefs.Node['SelectedDepartments'].AsString:= ''
  else GuiPrefs.Node['SelectedDepartments'].AsString:= SelectedDepartments.CommaText;
end;

initialization
  RegisterClassOnce(TPnLAreaReportGUI);

end.

