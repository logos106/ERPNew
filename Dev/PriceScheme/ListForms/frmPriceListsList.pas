unit frmPriceListsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, DAScript,
  MyScript, CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup;

type
  TfmPriceListsList = class(TBaseListingGUI)
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  BaseInputForm, CommonLib;                

procedure TfmPriceListsList.FormShow(Sender: TObject);
begin
  inherited;
  grdMain.RemoveField('msTimeStamp');
  grdMain.RemoveField('GlobalRef');
  grdMain.RemoveField('PriceListID');
end;

procedure TfmPriceListsList.cmdNewClick(Sender: TObject);
var
  EditForm : TBaseInputGUI;
begin
  inherited;
  EditForm := TBaseInputGUI(GetComponentByClassName('TfmPriceListEdit'));
  if Assigned(EditForm) then begin
    with EditForm do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TfmPriceListsList.RefreshQuery;
begin
  qryMain.Close;
  case grpFilters.ItemIndex of
    0: qryMain.ParamByName('Active').AsString:= 'T';
    1: qryMain.ParamByName('Active').AsString:= 'F';
    2: qryMain.ParamByName('Active').AsString:= '';
  end;
  inherited;
  grdMain.RemoveField('msTimeStamp');
  grdMain.RemoveField('GlobalRef');
  grdMain.RemoveField('PriceListID');
end;

procedure TfmPriceListsList.grpFiltersClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

initialization
  RegisterClassOnce(TfmPriceListsList);

end.
