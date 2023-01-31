unit PayCommissionsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,BusObjPaybase, ExtCtrls, DNMPanel, StdCtrls,
  wwcheckbox, Mask, wwdbedit, wwdblook, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  DB, MemDS, DBAccess, MyAccess,ERPdbComponents,BusObjBase, frmPayFormsBase, DNMSpeedButton,
  ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog, Menus, ProgressDialog;

type
  TfrmPayCommissions = Class(TfmPayFormsBase)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    DSPaysCommission: TDataSource;
    qryCommissionPeriod: TERPQuery;
    qryEmployeeCommission: TERPQuery;
    qryCommDesc: TERPQuery;
    qryDepartment: TERPQuery;
    grdCommission: TwwDBGrid;
    btnCommissionDelete: TwwIButton;
    grdPaysCommissionLines: TwwDBGrid;
    btnPaysCommissionLines: TwwIButton;
    DSPaysCommissionLines: TDataSource;
    btnPaycommissionDetails: TwwExpandButton;
    btnCommission: TDNMSpeedButton;
    lblNote: TLabel;
    commPeriod: TwwDBLookupCombo;
    cbDepartment: TwwDBLookupCombo;
    edtDescription: TwwDBEdit;
    procedure btnCommissionDeleteClick(Sender: TObject);
    procedure SetSubPay(Const Value :Tpaybase );
    procedure btnPaysCommissionLinesClick(Sender: TObject);
    procedure btnPaycommissionDetailsAfterCollapse(Sender: TObject);
    procedure btnCommissionClick(Sender: TObject);
    procedure btnPaycommissionDetailsBeforeExpand(Sender: TObject);
    procedure grdCommissionEnter(Sender: TObject);
    procedure grdPaysCommissionLinesEnter(Sender: TObject);
    procedure grdCommissionRowChanged(Sender: TObject);
  private
    fSubPay:Tpaybase;
    Totalamount :Double;
    Hdesc:String;
    xFootertotal:Double;

    procedure HandlePayCommissionErrors;
    procedure SelectCommissions(Sender: TObject);
    Procedure CalctotalCallback(Const Sender: TBusObj; var Abort: boolean);
    Procedure FootertotalCallback(Const Sender: TBusObj; var Abort: boolean);
    Procedure Calctotal(Const Sender: TBusObj; var Abort: boolean); overload;
    Procedure Calctotal;overload;
    Procedure OpenDetails;
    Procedure Footertotal;
    procedure setUSeSalesCommission(const Value: Boolean);
    procedure SetGridPermissions;
  Protected
    Procedure InitForDefaultOptionsGrid;Override;
  public
    property SubPay:Tpaybase  read fSubPay write SetSubPay ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Property USeSalesCommission:Boolean Write setUSeSalesCommission;

  end;     


implementation

{$R *.dfm}
uses
  BusObjConst,CommonLib, SalescommissionList, AppEnvironment,
  BusObjPayCommissionsBASE, wwmemo, tcConst;

procedure TfrmPayCommissions.SetSubPay(Const Value :Tpaybase);
begin
  fSubPay := Value;
end;

procedure TfrmPayCommissions.HandlePayCommissionErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  if not Assigned(SubPay) then exit;
  FatalStatusItem := SubPay.PaysPayRates.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    SetControlFocus(grdCommission);
    case FatalStatusItem.Code of
      BOR_PayCommissions_Err_NoDepartment  : begin
                                               grdCommission.SetActiveField('ClassName');
                                             end;
      BOR_PayCommissions_Err_NoDescription : begin
                                               grdCommission.SetActiveField('CommissionDesc');
                                             end;
      BOR_PayCommissions_Err_NoGross         : begin
                                               grdCommission.SetActiveField('Gross');
                                             end;
      BOR_PayCommissions_Err_NoPeriod      : begin
                                               grdCommission.SetActiveField('CommPeriod');
                                             end;
    end;
  end;
end;


procedure TfrmPayCommissions.InitForDefaultOptionsGrid;
begin
  inherited;
  IncludeForDefaultOptions(grdCommission);
end;

procedure TfrmPayCommissions.btnCommissionDeleteClick(Sender: TObject);
begin
    if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not Assigned(SubPay) then exit;
      SubPay.PayCommissions.Delete;
      SubPay.RecalcAll;
    finally
    end;
  end;
end;

procedure TfrmPayCommissions.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if Value = BusobjEventVal_FailedCommissionValidateData then begin
    HandlePayCommissionErrors;
  end;
end;

procedure TfrmPayCommissions.SelectCommissions(Sender: TObject);
var
  i: Integer;
  str: String;
  prog: TProgressDialog;

begin
   if not (Sender is TwwDBGrid) then exit;
   if TwwDBGrid(Sender).SelectedList.count =0 then exit;
   prog := TProgressDialog.Create(nil);
   try
     prog.MaxValue := TwwDBGrid(Sender).SelectedList.Count;
     prog.Step := 1;
     prog.Execute;
     for i := 0 to TwwDBGrid(Sender).SelectedList.Count - 1 do begin
        TwwDBGrid(Sender).Datasource.dataset.GotoBookmark(TwwDBGrid(Sender).SelectedList.Items[i]);
        if not SubPay.PayCommissions.Locate('ClassID;IsManual' ,VarArrayOf([TwwDBGrid(Sender).Datasource.dataset.FieldByname('ClassId').asInteger,'F']) , []) then begin
          SubPay.PayCommissions.New;
          SubPay.PayCommissions.IsManual:= false;
          { need a desc here so line is not deleted ... desc is updated during Calctotal }
          SubPay.PayCommissions.Commissiondesc:= 'Commission';
          SubPay.PayCommissions.Periodid:= qryCommissionPeriod.FieldByName('PeriodID').AsInteger;
          SubPay.PayCommissions.classId :=TwwDBGrid(Sender).Datasource.dataset.FieldByname('ClassId').asInteger;
          SubPay.PayCommissions.PostDB;
        end;

        if not SubPay.PayCommissions.PaysCommissionLines.Locate('SalesCommissionId' ,TwwDBGrid(Sender).Datasource.dataset.fieldbyname('SalesCommissionId').asInteger , []) then begin
          SubPay.PayCommissions.PaysCommissionLines.New;
          SubPay.PayCommissions.PaysCommissionLines.SalesCommissionId := TwwDBGrid(Sender).Datasource.dataset.fieldbyname('SalesCommissionId').asInteger;
        end;
        SubPay.PayCommissions.PaysCommissionLines.Commissionamount := SubPay.PayCommissions.PaysCommissionLines.Commissionamount + TwwDBGrid(Sender).Datasource.dataset.fieldbyname('Balanceamount').asFloat;
        SubPay.PayCommissions.PaysCommissionLines.DueAmount        := SubPay.PayCommissions.PaysCommissionLines.Dueamount + TwwDBGrid(Sender).Datasource.dataset.fieldbyname('Balanceamount').asFloat;

        str := 'Sale#' + TwwDBGrid(Sender).Datasource.dataset.fieldbyname('SaleID').asString +':' ;

        if TwwDBGrid(Sender).Datasource.dataset.fieldbyname('ProductID').asInteger <> 0 then
          str:= str+' Product Sale ' +'-'
        else
          str:= str+' Employee Commission '+'-';

        if TwwDBGrid(Sender).Datasource.dataset.fieldbyname('IsCommissionPercent').asBoolean then
          str:= str+ TwwDBGrid(Sender).Datasource.dataset.fieldbyname('CommissionRate').asString  + '%age '
        else str:= str+ appenv.RegionalOptions.CurrencySymbol+' ' +TwwDBGrid(Sender).Datasource.dataset.fieldbyname('CommissionRate').asString ;

        if TwwDBGrid(Sender).Datasource.dataset.fieldbyname('ProductID').asInteger <> 0 then
          str:= str+' (' + TwwDBGrid(Sender).Datasource.dataset.fieldbyname('name').asString +')';


        SubPay.PayCommissions.PaysCommissionLines.Description :=str;
        SubPay.PayCommissions.PaysCommissionLines.PostDB;
        prog.StepIt;
     end;
   finally
     prog.Free;
   end;
   Calctotal;
end;

procedure TfrmPayCommissions.Calctotal;
begin
  if SubPay.PayCommissions.IsManual then
    exit;
  SubPay.PayCommissions.DoFieldChangewhenDisabled := True;
  SubPay.PayCommissions.Iteraterecords(Calctotal);
end;


procedure TfrmPayCommissions.btnPaysCommissionLinesClick(Sender: TObject);
begin
  inherited;
  SubPay.PayCommissions.PaysCommissionLines.Delete;
end;


procedure TfrmPayCommissions.CalctotalCallback(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not (Sender is TPaysCommissionLines) then exit;
   Totalamount :=Totalamount +    TPaysCommissionLines(Sender).Commissionamount ;
   if Hdesc <> '' then Hdesc := Hdesc + chr(13) ;
   Hdesc := Hdesc +  TPaysCommissionLines(Sender).Description;
end;

procedure TfrmPayCommissions.btnPaycommissionDetailsAfterCollapse(
  Sender: TObject);
begin
  inherited;
  Calctotal;
end;

procedure TfrmPayCommissions.btnCommissionClick(Sender: TObject);
begin
  
  TSalescommissionListGUI.Listforemployee(fSubPay.Employeeid, 0, Self, SelectCommissions, TERPConnection(fSubPay.connection.connection));
end;

procedure TfrmPayCommissions.btnPaycommissionDetailsBeforeExpand(Sender: TObject);
begin
  inherited;
  OpenDetails;

end;

procedure TfrmPayCommissions.OpenDetails;
begin
  SubPay.PayCommissions.PaysCommissionLines.closedb;
  DSPaysCommissionLines.Dataset := SubPay.PayCommissions.PaysCommissionLines.dataset;
end;

procedure TfrmPayCommissions.Calctotal(const Sender: TBusObj;
  var Abort: boolean);
begin
   if Tpayscommission(SendeR).IsManual then
     exit;
   Totalamount :=0;
   Hdesc:='';
   Tpayscommission(SendeR).PaysCommissionLines.Iteraterecords(CalctotalCallback);
   Tpayscommission(SendeR).CommissionDesc := Hdesc;
   Tpayscommission(SendeR).Gross := Totalamount;
   Tpayscommission(SendeR).PostDB;
end;

procedure TfrmPayCommissions.grdCommissionEnter(Sender: TObject);
begin
  inherited;
  OpenDetails;
end;

procedure TfrmPayCommissions.Footertotal;
begin
  if (grdPaysCommissionLines.datasource = nil) or (grdPaysCommissionLines.datasource.dataset = nil) then exit;
  xFootertotal := 0;
  SubPay.PayCommissions.PaysCommissionLines.Iteraterecords(FootertotalCallback);
  grdPaysCommissionLines.ColumnByName('Commissionamount').FooterValue :=FloatToStrF(xFootertotal, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TfrmPayCommissions.FootertotalCallback(const Sender: TBusObj;
  var Abort: boolean);
begin
  xFootertotal := xFootertotal+TPaysCommissionLines(Sender).Commissionamount;
end;

procedure TfrmPayCommissions.setUSeSalesCommission(const Value: Boolean);
var
  ctr:Integer;
begin
  if not Value then begin
    lblNote.visible := true;
    for ctr := 0 to ComponentCount-1 do begin
      if Components[ctr] is TControl then
        TControl(Components[ctr]).enabled := False;
    end;
    lblNote.Enabled:= true;
    if Appenv.CompanyPrefs.USeSalesCommission then
      lblNote.Caption := 'sales Commission update in Progress';  

  end;
end;

procedure TfrmPayCommissions.grdPaysCommissionLinesEnter(Sender: TObject);
begin
  inherited;
  Footertotal;
end;

procedure TfrmPayCommissions.grdCommissionRowChanged(Sender: TObject);
begin
  inherited;
  SetGridPermissions;
end;

procedure TfrmPayCommissions.SetGridPermissions;
begin
  { only allow user to edit manual commission lines  }
  if grdCommission.DataSource.DataSet.FieldByName('IsManual').AsBoolean or
    (Trim(grdCommission.DataSource.DataSet.FieldByName('CommissionDesc').AsString) = '') then begin
    grdCommission.ColumnByName('CommissionDesc').ReadOnly:= false;
    grdCommission.MemoAttributes:= grdCommission.MemoAttributes - [mViewOnly];
    grdCommission.ColumnByName('cDetails').ReadOnly:= false;
    grdCommission.ColumnByName('Gross').ReadOnly:= false;
    grdCommission.ColumnByName('CommPeriod').ReadOnly:= false;
    grdCommission.ColumnByName('ClassName').ReadOnly:= false;
    grdCommission.ColumnByName('SuperInc').ReadOnly:= false;
    grdCommission.ColumnByName('TaxExempt').ReadOnly:= false;
  end
  else begin
    grdCommission.ColumnByName('CommissionDesc').ReadOnly:= true;
    grdCommission.MemoAttributes:= grdCommission.MemoAttributes + [mViewOnly];
    grdCommission.ColumnByName('cDetails').ReadOnly:= true;
    grdCommission.ColumnByName('Gross').ReadOnly:= true;
    grdCommission.ColumnByName('CommPeriod').ReadOnly:= true;
    grdCommission.ColumnByName('ClassName').ReadOnly:= true;
    grdCommission.ColumnByName('SuperInc').ReadOnly:= true;
    grdCommission.ColumnByName('TaxExempt').ReadOnly:= true;
  end;
  cbDepartment.Enabled:= not grdCommission.ColumnByName('ClassName').ReadOnly;
  edtDescription.Enabled:= not grdCommission.ColumnByName('CommissionDesc').ReadOnly;
  if (SubPay.PayCommissions.Periodid < 1) and qryCommissionPeriod.Active then
    SubPay.PayCommissions.Periodid:= qryCommissionPeriod.FieldByName('PeriodID').AsInteger;
end;

initialization
RegisterClassOnce(TfrmPayCommissions);
end.
