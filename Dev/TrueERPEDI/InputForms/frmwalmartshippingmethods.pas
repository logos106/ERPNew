unit frmwalmartshippingmethods;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase, ActnList, BusobjWalmartCommon, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  wwclearbuttongroup, wwradiogroup;

type
  Tfmwalmartshippingmethods = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    Actionlist: TActionList;
    grdwalmartshippingmethods: TwwDBGrid;
    btnDelete: TwwIButton;
    qrywalmartshippingmethods: TERPQuery;
    dswalmartshippingmethods: TDataSource;
    qrywalmartshippingmethodsID: TIntegerField;
    qrywalmartshippingmethodsGlobalref: TWideStringField;
    qrywalmartshippingmethodsName: TWideStringField;
    qrywalmartshippingmethodsFedEx: TWideStringField;
    qrywalmartshippingmethodsUPS: TWideStringField;
    qrywalmartshippingmethodsUSPS: TWideStringField;
    qrywalmartshippingmethodsCanadaPost: TWideStringField;
    qrywalmartshippingmethodsUSPSEndicia: TWideStringField;
    qrywalmartshippingmethodsWalmartMethodcode: TWideStringField;
    qrywalmartshippingmethodsActive: TWideStringField;
    qrywalmartshippingmethodsmsTimeStamp: TDateTimeField;
    qrywalmartshippingmethodsmsUpdateStiteCode: TWideStringField;
    cboShippingMethod: TwwDBcomboBox;
    grpFilters: TwwRadioGroup;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grdwalmartshippingmethodsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdwalmartshippingmethodsEnter(Sender: TObject);
    procedure grdwalmartshippingmethodsColEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grpFiltersClick(Sender: TObject);
    procedure tmrOnshowTimer(Sender: TObject);
  private
    WalmartShippingMethodsObj: TWalmartShippingMethods;
    function SaveRecord: Boolean;
    Procedure Openrec;
    procedure NewBusObjinstance;
    procedure ReadnApplyGuiPref;
    Procedure WriteGuiPref;
  Protected
    procedure CommitAndNotify;override;
  public
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  end;


implementation

uses CommonLib, BusObjConst, AppEnvironment;

{$R *.dfm}

procedure Tfmwalmartshippingmethods.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function Tfmwalmartshippingmethods.SaveRecord :Boolean;
begin
  result:= False;
  WalmartShippingMethodsObj.PostDB;
  if not(WalmartShippingMethodsObj.Save) then exit;
  Result:= True;

end;

procedure Tfmwalmartshippingmethods.tmrOnshowTimer(Sender: TObject);
begin
  inherited;
  if fitmrOnshowNo = 1 then begin
    qrywalmartshippingmethods.DisableControls;
    try
        WalmartShippingMethodsObj.Closedb;
        try
          WalmartShippingMethodsObj.RepopulateIt;
        finally
          WalmartShippingMethodsObj.Load;
        end;
    finally
      qrywalmartshippingmethods.Enablecontrols;
    end;
  end;
end;

procedure Tfmwalmartshippingmethods.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  WalmartShippingMethodsObj.Connection.CommitTransaction;
  Self.Close;

end;

procedure Tfmwalmartshippingmethods.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  Notify;
end;

procedure Tfmwalmartshippingmethods.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TWalmartShippingMethods then TWalmartShippingMethods(Sender).Dataset  := qrywalmartshippingmethods;
  end;
end;

procedure Tfmwalmartshippingmethods.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  WriteGuiPref;
  action := cafree;
end;

procedure Tfmwalmartshippingmethods.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if WalmartShippingMethodsObj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          WalmartShippingMethodsObj.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure Tfmwalmartshippingmethods.FormCreate(Sender: TObject);
begin
  inherited;
   NewBusObjinstance;
end;
procedure Tfmwalmartshippingmethods.FormShow(Sender: TObject);
begin
  inherited;
  ReadnApplyGuiPref;
  OpenRec;
  EnabletmrOnshow(1,1);
end;

procedure Tfmwalmartshippingmethods.grdwalmartshippingmethodsCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean;
  AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if sametext(field.fieldname , qrywalmartshippingmethodsWalmartMethodcode.fieldname) then
  else Afont.color := clDkGray;
end;

procedure Tfmwalmartshippingmethods.grdwalmartshippingmethodsColEnter(Sender: TObject);
begin
  inherited;
  grdwalmartshippingmethods.SetActiveField(qrywalmartshippingmethodsWalmartMethodcode.fieldname);
end;

procedure Tfmwalmartshippingmethods.grdwalmartshippingmethodsEnter(Sender: TObject);
begin
  inherited;
  grdwalmartshippingmethods.SetActiveField(qrywalmartshippingmethodsWalmartMethodcode.fieldname);
end;

procedure Tfmwalmartshippingmethods.grpFiltersClick(Sender: TObject);
begin
  inherited;
       if grpFilters.Itemindex =0 then qrywalmartshippingmethods.Filter := qrywalmartshippingmethodsFedEx.Fieldname +' = ' + quotedstr('T')
  else if grpFilters.Itemindex =1 then qrywalmartshippingmethods.Filter := qrywalmartshippingmethodsUPS.Fieldname   +' = ' + quotedstr('T')
  else if grpFilters.Itemindex =2 then qrywalmartshippingmethods.Filter := qrywalmartshippingmethodsUSPS.Fieldname  +' = ' + quotedstr('T')
  else if grpFilters.Itemindex =3 then qrywalmartshippingmethods.Filter := qrywalmartshippingmethodsCanadaPost.Fieldname +' = ' + quotedstr('T')
  else qrywalmartshippingmethods.Filter := '';
  qrywalmartshippingmethods.Filtered := qrywalmartshippingmethods.Filter <> '';
end;

procedure Tfmwalmartshippingmethods.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  WalmartShippingMethodsObj := TWalmartShippingMethods.CreateWithNewConn(Self);
  WalmartShippingMethodsObj.Connection.connection := Self.MyConnection;
  WalmartShippingMethodsObj.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
end;


procedure Tfmwalmartshippingmethods.Openrec;
begin
  WalmartShippingMethodsObj.Load;
  WalmartShippingMethodsObj.connection.BeginTransaction;
  openQueries;
  WalmartShippingMethodsObj.Dirty := false;
end;

procedure Tfmwalmartshippingmethods.ReadnApplyGuiPref;
var
  x:Integer;
begin
  if not GuiPrefs.active then GuiPrefs.active := TRue;
  if GuiPrefs.Node.Exists('Grpfilters') then begin
    x := GuiPrefs.Node['Grpfilters.ItemIndex'].asInteger;
    if x > 0 then if grpFilters.Items.Count >= x then grpFilters.ItemIndex := x - 1;
  end;
end;
procedure Tfmwalmartshippingmethods.WriteGuiPref;
begin
  GuiPrefs.Node['Grpfilters.ItemIndex'].asInteger :=  grpFilters.ItemIndex+1;
end;

initialization
  RegisterClassOnce(Tfmwalmartshippingmethods);

end.

