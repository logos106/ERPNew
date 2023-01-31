unit ProfitLossLayoutsForm;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg ;

type
  TProfitLossLayoutsGUI = class(TBaseListingGUI)
    qryMainLayoutID: TIntegerField;
    qryMainLName: TWideStringField;
    qryMainDefaultLayout: TWideStringField;
    qryMainIsCurrentLayout: TWideStringField;
    qryMainCurrentLayout: TIntegerField;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure cmdPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
        DefaultID : Integer;

  public
    { Public declarations }
  end;

implementation

uses PnLLayouts, CommonLib, Forms, ProfitLossLayoutDataForm;
{$R *.dfm}

procedure TProfitLossLayoutsGUI.cmdNewClick(Sender: TObject);
var
  Form: TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfrmPnlLayouts');
    if Assigned(Form) then begin
      with TfrmPnlLayouts(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TProfitLossLayoutsGUI.grpFiltersClick(Sender: TObject);
begin
//  InitGroupfilterString('Active' , ['T','F','']);
//  inherited;
end;

procedure TProfitLossLayoutsGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TProfitLossLayoutsGUI.DNMSpeedButton1Click(Sender: TObject);
var
  frmLayout : TProfitLossLayoutDataGUI;
begin
  inherited;
  try
    frmLayout := TProfitLossLayoutDataGUI.Create(nil);
    frmLayout.LayoutID := qryMainLayoutID.Value;
    frmLayout.ShowModal;
  finally
    frmLayout.Free;
  end;


end;

procedure TProfitLossLayoutsGUI.FormCreate(Sender: TObject);
begin
  inherited;
 // HaveDateRangeSelection := False;

  with qryMain do
  begin
    Close;
    Open;

//    while not eof do
//    begin
//        ShowMessage(FieldByName('LName').AsString);
//         Next;
//    end;

    FieldByName('LayoutID').Visible := false;

  //  Locate('DefaultLayout', 'T', []);
  //  DefaultID := FieldByName('LayoutID').AsInteger;
  end;

end;

initialization
  RegisterClassOnce(TProfitLossLayoutsGUI);
end.
