unit DepositedList;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 13/09/05  1.00.01 DSP  Added 'Summary' and 'Details' options.
 14/09/05  1.00.02 DSP  Added new query component qryMainSub. This acts as
                        a substitute for the main query when the form is
                        instantiated from TransLockManagementObj.
 15/09/05  1.00.03 DSP  1. Drill down is now allowed on all lines when details
                           are displayed.
                        2. Drill down when using qryMainSub uses an alternative
                           method.
 30/09/05  1.00.04 DSP  Added RegisterClass and moved UseMainSub property to
                        publised so it can be set using delphi TypInfo  unit
                        RTTI methods.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TDepositedListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainDepositNo: TIntegerField;
    qryMainDepositDate: TDateField;
    qryMainType: TWideStringField;
    qryMainAmount: TFloatField;
    qryMainClassName: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainReferenceNo: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainDepositID: TIntegerField;
    qryMainReceivedFrom: TWideStringField;
    qryMainFromAccount: TWideStringField;
    qryMainPaymentMethod: TWideStringField;
    qryMainLineReference: TWideStringField;
    qryMainDetails: TWideStringField;
    btnNewDepositEntry: TDNMSpeedButton;
    qryMainpaymentId: TLargeintField;
    grpDetailsFilter: TwwRadioGroup;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure btnNewDepositEntryClick(Sender: TObject);
  private
    //fUseMainSub: boolean;
  public
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  published
    //property UseMainSub: boolean read fUseMainSub write fUseMainSub;
  end;

implementation

uses
  Forms, frmDepositFrm, BaseInputForm, CommonLib, FastFuncs, AppEnvironment,
  tcConst, CommonFormLib;

{$R *.dfm}

procedure TDepositedListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';

  case grpFilters.ItemIndex of
    0:
      begin
        GroupFilterString := 'Deleted <> ' + QuotedStr('T');

        if grpDetailsFilter.ItemIndex = 0 then GroupFilterString := GroupFilterString + 'AND Details = ' + QuotedStr('F')
      end;

    1:
      begin
        GroupFilterString := 'Deleted = ' + QuotedStr('T');

        if grpDetailsFilter.ItemIndex = 0 then GroupFilterString := GroupFilterString + 'AND Details = ' + QuotedStr('F')
      end;

    2:
      begin
        if grpDetailsFilter.ItemIndex = 0 then GroupFilterString := 'Details = ' + QuotedStr('F')
      end;
  end;

  inherited;
end;

procedure TDepositedListGUI.cmdNewClick(Sender: TObject);
begin
  OpenERPForm('TDepositGUI' , 0);
end;

procedure TDepositedListGUI.RefreshQuery;
begin
(*  if not UseMainSub then begin
    qryMain.Params.ParamByName('txtfrom').AsDate := FilterDateFrom;
    qryMain.Params.ParamByName('txtto').AsDate := filterDAteTo;
  end;*)
  InitDateFromnDateto('txtfrom' , 'txtto');
  inherited;
  TFloatField(qryMain.FieldByName('Amount')).currency := true;
end;

procedure TDepositedListGUI.RefreshTotals;
var
  TotalPayments: double;
begin
  //if not UseMainSub then begin
    TotalPayments := 0;
    qryMain.DisableControls;

    try
      with qryMain do begin
        First;

        while not Eof do begin
          if FieldByName('Details').AsString = 'F' then TotalPayments := TotalPayments + FieldByName('Amount').AsCurrency;

          Next;
        end;

        First;
      end;
    finally
      qryMain.EnableControls;
      grdMain.ColumnByName('Amount').FooterValue := FloatToStrF(TotalPayments, ffCurrency, 15, CurrencyRoundPlaces);
    end;
  //end;
end;

procedure TDepositedListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ShowChartViewOnPopup := True;
end;

procedure TDepositedListGUI.grdMainDblClick(Sender: TObject);
var
  Bookmark: TBookmark;
  CurrentDepositNo: integer;
  Details: TBaseInputGUI;
begin
(*  if UseMainSub then begin
    //
    // This is required as the code in TBaseListingGUI will only look in
    // qryMain for data.
    //
    Details := TDepositGUI(GetComponentByClassName('TDepositGUI'));

    if not Details.Visible then begin
      Details.KeyID := qryMainSub.FieldByName('DepositNo').AsInteger;
      Details.FormStyle := fsMDIChild;
    end;

    Details.BringToFront;
  end else begin*)
    if grpDetailsFilter.ItemIndex = 0 then
      SubsequentID := Chr(95) + Trim(qryMain.FieldByName('Type').AsString)
    else begin
      //
      // When details are displayed find the first record with the current
      // deposit number and use this record to obtain a SubsequentID.
      //
      qryMain.DisableControls;
      Bookmark := qryMain.GetBookmark;

      try
        CurrentDepositNo := qryMain.FieldByName('DepositNo').AsInteger;
        while (not qryMain.Bof) and (CurrentDepositNo = qryMain.FieldByName('DepositNo').AsInteger) do qryMain.Prior;
        if not qryMain.Bof then qryMain.Next;
        SubsequentID := Chr(95) + Trim(qryMain.FieldByName('Type').AsString);
      finally
        qryMain.GotoBookmark(Bookmark);      
        qryMain.FreeBookmark(Bookmark);
        qryMain.EnableControls;
      end;
    end;

    inherited;
  //end;
end;

procedure TDepositedListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }

  if (grpDetailsFilter.ItemIndex = 1) and (qryMain.FieldByName('Details').AsString = 'F') then
    AFont.Style := AFont.Style + [fsBold];
end;

procedure TDepositedListGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('DepositID');
(*  if UseMainSub then begin
    cboDateRange.Hide;
    lblFrom.Hide;
    dtFrom.Hide;
    lblTo.Hide;
    dtTo.Hide;
    grpFilters.Hide;
    grpDetailsFilter.Hide;
    cmdNew.Enabled := false;
    dsMain.DataSet := qryMainSub;
    qryMainSub.Open;
    TFloatField(qryMainSub.FieldByName('Amount')).currency := true;
    lblTotal.Caption := IntToStr(qryMainSub.RecordCount);
  end;*)
end;

procedure TDepositedListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TDepositedListGUI.btnNewDepositEntryClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TDepositEntryGUI' , 0);
end;

procedure TDepositedListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TDepositedListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TDepositedListGUI);
end.
