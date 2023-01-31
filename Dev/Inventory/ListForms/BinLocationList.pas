{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 06/02/06 1.00.00  BJ  Initial Version
 08/08/06 1.00.01  BJ  colum width changed to fit it in the Bin allocation form without
                        horizontal scrool bars
}

unit BinLocationList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, wwcheckbox, wwdblook, 
  Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TBinLocationListGUI = class(TBaseListingGUI)
    qryMainBinLocation: TWideStringField;
    qryMainBinNumber: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainvolume: TFloatField;
    qryMainVolumeAvailable: TFloatField;
    qryMainGlobalREf: TWideStringField;
    qryMainBinVolume: TFloatField;
    qryMainBinID: TIntegerField;
    qryMainClassID: TIntegerField;
    qryMainClassName: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure initBinLoc(Sender: TObject);

  public
  Protected
    procedure RefreshQuery; override;
    procedure MakeQrymain; virtual;
  end;

//var
//  BinLocationListGUI: TBinLocationListGUI;

implementation

uses FastFuncs, Forms, CommonLib,  AppEnvironment, 
  frmBinLocation, CommonFormLib;

{$R *.dfm}

procedure TBinLocationListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmbinLocation' , 0 , initBinLoc);
(*  with TfmbinLocation(GetComponentByClassName('TfmbinLocation')) do begin
    AttachObserver(Self);
    Keyid := 0;
    IF cboClassQryclassid.asInteger = 0 THEN classID := AppEnv.DefaultClass.ClassID
    else classID  :=cboClassQryclassid.asInteger;
    FormStyle     := fsMDIChild;
    BringToFront;
  end;*)
end;
procedure TBinLocationListGUI.initBinLoc(Sender: TObject);
begin
  if sender is TfmbinLocation then begin
      IF selectedClassId = 0 THEN TfmbinLocation(Sender).classID := AppEnv.DefaultClass.ClassID
      else TfmbinLocation(Sender).classID  :=selectedClassId;
  end;
end;
procedure TBinLocationListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainVolumeAvailable.asfloat  := qryMainvolume.asFloat    - qryMainBinVolume.asFloat;
end;

procedure TBinLocationListGUI.MakeQrymain;
begin
  Qrymain.Disablecontrols;
  Try
    if Qrymain.Active then qrymain.close;
    QryMain.SQL.Clear;
    QryMain.SQL.Add('Select distinct ');
    QryMain.SQL.Add('tblProductbin.GlobalRef, ');
    QryMain.SQL.Add('tblProductbin.BinID, ');
    QryMain.SQL.Add('tblclass.ClassID,');
    QryMain.SQL.Add('tblProductbin.binLocation,');
    QryMain.SQL.Add('tblProductbin.binnumber, ');
    QryMain.SQL.Add('tblProductbin.Active, ');
    QryMain.SQL.Add('tblProductbin.Volume ,');
    QryMain.SQL.Add('Volume_used as BinVolume,');
    QryMain.SQL.Add('tblclass.ClassName');
    QryMain.SQL.Add('from tblclass');
    QryMain.SQL.Add('inner join tblProductbin on tblclass.ClassId = tblProductbin.ClassId');
    if grpFilters.ItemIndex = 0 then QryMain.SQL.Add('AND tblProductbin.Active = "T"')
    else  if grpFilters.ItemIndex = 1 then QryMain.SQL.Add('AND tblProductbin.Active = "F"');
    if selectedClassId<>0 then
      QryMain.SQL.Add('AND tblProductbin.ClassID = ' + IntToStr(selectedClassId));
  Finally
      Qrymain.EnableControls;
  end;
end;
procedure TBinLocationListGUI.RefreshQuery;
begin
  MakeQrymain;
  inherited;
end;

procedure TBinLocationListGUI.grpFiltersClick(Sender: TObject);
begin
    RefreshQuery;
    SetControlFocus(grdMain);
end;

procedure TBinLocationListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('binLocation') + ' ASC CIS ; ' + QuotedStr('binNumber') + ' ASC CIS';
end;

procedure TBinLocationListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  SelectionOption := soClass;
end;

procedure TBinLocationListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if grpFilters.ItemIndex=-1 then grpFilters.ItemIndex := 0;
end;

initialization
  RegisterClassOnce(TBinLocationListGUI);
finalization
  UnRegisterClass(TBinLocationListGUI);
end.
