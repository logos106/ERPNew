unit HireList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  THireListGUI = class(TBaseListingGUI)
    qryMainHireId: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainShiptoAddress: TWideStringField;
    qryMainCreatedDate: TDateField;
    qryMainclassname: TWideStringField;
    qryMainTotalAmountinc: TFloatField;
    qryMainNotes: TWideMemoField;
    qryMainTerms: TWideStringField;
    qryMainemployeeName: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainSalesTotal: TFloatField;
    qryMainHiretotal: TFloatField;
    qryMainconverted: TWideStringField;
    qryMainHirestatus: TWideStringField;
    btnInvoice: TDNMSpeedButton;
    qryMainMaxHireTo: TWideStringField;
    qryMainMaxActualHireTo: TWideStringField;
    btnDetails: TDNMSpeedButton;
    procedure cmdNewClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure btnInvoiceClick(Sender: TObject);
    procedure btnDetailsClick(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonFormLib, tcConst, BusobjHire, MySQLConst;

{$R *.dfm}

{ THireListGUI }

procedure THireListGUI.btnDetailsClick(Sender: TObject);
begin
  inherited;
//
  OpenERPListForm('THireItemDetailListGUI', nil);
end;

procedure THireListGUI.btnInvoiceClick(Sender: TObject);
begin
  inherited;
  if SelectedRecords =0 then begin
    MessageDlgXP_Vista('Please Choose Records to be Invoiced', mtWarning, [mbOK], 0);
    Exit;
  end;
  if MessageDlgXP_Vista('Do You Wish to Make Invoice for All the Selected Hire Record(s)?'+NL+NL+
                        '(Note : Duplicate Invoices will be Re-Created if it was Already Converted)', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
  IterateProcNO:= 1;
  IterateselectedRecords(TRue);
end;

procedure THireListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenErpform('TfmHire' , 0);
end;

procedure THireListGUI.grpFiltersClick(Sender: TObject);
begin
  //InitGroupfilterString('Hirestatus' , ['Q' , 'O' ,  'R' , 'I' , ''] , False);
       if grpfilters.ItemIndex =0 then GroupfilterString := 'Hirestatus = ' + Quotedstr('Q')
  else if grpfilters.ItemIndex =1 then GroupfilterString := 'Hirestatus = ' + Quotedstr('O')
  else if grpfilters.ItemIndex =2 then
    GroupfilterString := 'Hirestatus = ' + Quotedstr('O') +
    ' and (((MaxHireTo > MaxActualHireTo) and (MaxHireTo > ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,0)) + ') and (MaxHireTo < '+QuotedStr(FormatDateTime(MysqlDateTimeFormat,now))+'))' +
    ' or ((MaxHireTo < MaxActualHireTo) and (MaxActualHireTo > ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,0)) + ') and (MaxActualHireTo < '+QuotedStr(FormatDateTime(MysqlDateTimeFormat,now))+')))'
  else if grpfilters.ItemIndex =3 then GroupfilterString := 'Hirestatus = ' + Quotedstr('R')
  else if grpfilters.ItemIndex =4 then GroupfilterString := 'Converted = ' + Quotedstr('T')
  else GroupfilterString := '';
  inherited;

end;

procedure THireListGUI.IterateselectedRecordsCallback(var Abort: boolean;  SelIndex: Integer);
var
  HireObj :THire;
begin
  inherited;
  if IterateProcNo = 1 then begin
    HireObj := THire.CreateWithNewConn(Self);
    try
      HireObj.SilentMode := True;
      HireObj.Load(Qrymainhireid.AsInteger);
      if HireObj.count =1 then HireObj.CopyToInvoice ;
    finally
      FreeandNil(HireObj);
    end;
  end;
end;

procedure THireListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainTotalAmountinc.asfloat :=  qryMainSalesTotal.asfloat + qryMainHiretotal.asfloat;
end;

procedure THireListGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;

procedure THireListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Hirestatus');
end;

initialization
  RegisterClassOnce(THireListGUI);


end.
