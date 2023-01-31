unit DispatchesReportForm;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 07/06/05  1.00.01 IJB  Changed anchors of chkBasedOnShipped and its label for
                        correct positioning when form maximised.
 18/07/05  1.00.02 BJ   Warranty ends on and Warranty period fields are added to
                        this report. The caption of the field is changed based
                        on the preference.
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  Mask, wwdbedit, DBCtrls, wwDialog, Wwlocate,
  SelectionDialog, DNMPanel, Math, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdblook,
  wwcheckbox, wwdbdatetimepicker,  Shader,
  kbmMemTable, ProgressDialog, DAScript, MyScript, CustomInputBox;

type
  TDispatchesReportGUI= class(TBaseListingGUI)
    chkBaseOnShipped: TCheckBox;
    qryMainComments: TWideMemoField;
    qryMainSaleId: TIntegerField;
    qryMainShipped: TFloatField;
    qryMainUnitOfMeasureSaleLines: TWideStringField;
    qryMainUnitOfMeasureShipped: TFloatField;
    qryMainConNote: TWideStringField;
    qryMainPartName: TWideStringField;
    qryMainProduct_Description: TWideStringField;
    qryMainName: TWideStringField;
    qryMainShipToAddress: TWideStringField;
    qryMainDepartment: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainShipDate: TDateField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainCUSTDATE1: TDateTimeField;
    qryMainCUSTDATE2: TDateTimeField;
    qryMainCUSTDATE3: TDateTimeField;
    qryMainTotalUOMWeight: TFloatField;
    qryMainTotalWeight: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure chkBaseOnShippedClick(Sender: TObject);
  private
  protected
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure OnSetUpcustomFields(CustfieldVisible:Boolean;fieldno :Integer;  FlagFieldname , fieldname, DisplayLabel:String );Override;
  public
    procedure RefreshQuery; override;
  end;

implementation

uses
    CommonDbLib, DNMLib, Forms, tcConst,
  AppEnvironment, CommonLib, MySQLConst, FastFuncs, tcDataUtils, ProductQtyLib,
  CommonFormLib, TempTableUtils;

{$R *.dfm}

procedure TDispatchesReportGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  chkBaseOnShipped.checked :=  GuiPrefs.Node['Options.BaseOnShipped'].AsBoolean;
end;

procedure TDispatchesReportGUI.RefreshQuery;
begin
  Qrymain.ParamByName('UseSaledate').asString := iif(chkBaseOnShipped.checked , 'T' , 'F');
  Qrymain.ParamByName('UseallClass').asString := iif(SelectedClassID=0 , 'T' , 'F');
  Qrymain.ParamByName('Classid').asInteger := SelectedClassID ;

  InitDateFromnDateto;
  inherited;
end;

procedure TDispatchesReportGUI.FormCreate(Sender: TObject);
begin
  inherited;
  SelectionOption := soClass;
  showcontrolhint(chkBaseOnShipped , 'When Ticked, Report is filterd on the Sales Ship Date' +NL +
                                    'When not Ticked, Report is filterd on the Invoice Date' );
end;

procedure TDispatchesReportGUI.OnSetUpcustomFields(CustfieldVisible:Boolean;fieldno :Integer;  FlagFieldname , fieldname, DisplayLabel:String );
begin
  inherited;
  if fieldno = 7 then begin
    qryMainTotalWeight.DisplayLabel := 'Total ' + DisplayLabel +'~Shipped';
    qryMainTotalUOMWeight.DisplayLabel := qryMainTotalWeight.DisplayLabel  +'(UOM)';
  end;
end;

procedure TDispatchesReportGUI.chkBaseOnShippedClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
  DateRangeSelectionHint := iif(chkBaseOnShipped.checked ,  'Report is filterd on the Sales Ship Date' , 'Report is filterd on the Invoice Date') ;
end;


procedure TDispatchesReportGUI.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Product');
end;

procedure TDispatchesReportGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.BaseOnShipped'].AsBoolean := chkBaseOnShipped.checked;
end;

initialization
  RegisterClassOnce(TDispatchesReportGUI);
end.





