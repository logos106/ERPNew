unit ClientTypeListForm;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB,
   Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable;

type
  TClientTypeListGUI = class(TBaseListingGUI)
    qryMainTypeName: TWideStringField;
    qryMainTypeDescription: TWideStringField;
    qryMainTerms: TWideStringField;
    qryMainCreditLimit: TFloatField;
    qryMainGracePeriod: TWordField;
    qryMainActive: TWideStringField;
    qryMainClientTypeID: TIntegerField;
    qryMainTermsID: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  ClientTypeListGUI: TClientTypeListGUI;

implementation

{$R *.dfm}

uses
  ClientTypeForm, CommonLib;

procedure TClientTypeListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  ClientTypeListGUI := nil;
end;

procedure TClientTypeListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TClientTypeGUI');
  if Assigned(Form) then begin
    with TClientTypeGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;  
end;

procedure TClientTypeListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;

procedure TClientTypeListGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('ClientTypeID,TermsID');
  if self.fbFormOpenedOk then begin
    grpFiltersClick(Sender);
  end;
end;

initialization
  RegisterClassOnce(TClientTypeListGUI);
end.
