unit ReturnAuthListForm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 05/08/05  1.00.01 DSP  Changed 'Return Authority' caption to 'Return Authority
                        List'.
 20/01/06  1.00.02  AL  Added registerclass to intialization                       

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, ImgList, Menus, AdvMenus, PrintDAT,
  ActnList, wwDialog, Wwlocate, SelectionDialog, DNMPanel,
  MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,
   wwdblook, Shader, kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup;

type
  TReturnAuthListGUI = class(TBaseListingGUI)
    qryMainPurchaseOrderID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainPurchaseOrderNumber: TWideStringField;
    qryMainComments: TWideStringField;
    qryMainContact: TWideStringField;
    qryMainETADate: TDateField;
    qryMainPhone: TWideStringField;
    qryMainInvoiced: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainIsRA: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainSalesComments: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainOrderDate: TDateTimeField;
    qryMainReturnStatus: TWideStringField;
    qryMainConNote: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

  //var
  //  ReturnAuthListGUI: TReturnAuthListGUI;

implementation

uses frmRA, CommonLib, Forms, AppEnvironment, Dateutils, tcConst;

{$R *.dfm}

procedure TReturnAuthListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'ReturnStatus <> ' + QuotedStr('Returned');
      end;
    1: 
      begin
        GroupFilterString := 'ReturnStatus = ' + QuotedStr('Returned');
      end;
  end;
  inherited;
end;

procedure TReturnAuthListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').AsDate := dateof(dtFrom.DateTime);
  qryMain.Params.ParamByName('txtto').AsDate := incday(dateof(dtTo.DateTime));
  inherited;
end;

procedure TReturnAuthListGUI.cmdNewClick(Sender: TObject);
var
  tmpComponent: TComponent;
begin
  DisableForm;
  try
    tmpComponent := GetComponentByClassName('TReturnAGUI');
    if not Assigned(tmpComponent) then Exit;
    with TReturnAGUI(tmpComponent) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TReturnAuthListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  inherited;
end;

procedure TReturnAuthListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TReturnAuthListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TReturnAuthListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TReturnAuthListGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('IsRA,PurchaseOrderId,ClientId');
  grdMain.Hint := 'If any of the lines''s Status is not ''RETURNED'' then ''Return Status'' will be ''Not Returned''.' +NL +
                  'If all of the lines''s Status is     ''RETURNED'' then ''Return Status'' will be ''Returned''.' +NL +
                  '''Order Status'' is the Status on the header'+NL;
  grdMain.Showhint := True;
end;

initialization
  RegisterClassOnce(TReturnAuthListGUI);
end.
