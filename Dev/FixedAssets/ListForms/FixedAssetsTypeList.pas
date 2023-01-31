unit FixedAssetsTypeList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable;

type
  TFixedAssetTypeListGUI = class(TBaseListingGUI)
    qryMainAssetTypeID: TAutoIncField;
    qryMainAssetTypeCode: TWideStringField;
    qryMainAssetTypeName: TWideStringField;
    qryMainNotes: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdNewClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

//var
//  FixedAssetTypeListGUI: TFixedAssetTypeListGUI;

implementation
  
uses frmFixedAssetTypeGUI, CommonLib;
{$R *.dfm}

procedure TFixedAssetTypeListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  FixedAssetTypeListGUI := nil;
end;

procedure TFixedAssetTypeListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TFixedAssetTypeGUI');
    if Assigned(Form) then begin //if has acess
      with TFixedAssetTypeGUI(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;   
end;

procedure TFixedAssetTypeListGUI.RefreshQuery;
begin
  inherited;
  //
end;

procedure TFixedAssetTypeListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TFixedAssetTypeListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TFixedAssetTypeListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TFixedAssetTypeListGUI);
end.
