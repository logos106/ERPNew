unit frmManifestRoute;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, Mask, DBCtrls, DB,   
  SelectionDialog, ExtCtrls, DNMPanel, Buttons, DNMSpeedButton, AppEvnts,
  wwdblook, kbmMemTable, DBAccess, MyAccess,ERPdbComponents, MemDS, DataState, Menus, AdvMenus,
  Shader, ImgList, ProgressDialog;

type
  TManifestRouteGUI = class(TBaseInputGUI)
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryManifestRoute: TERPQuery;
    DSManifestRoute: TDataSource;
    qryManifestRouteGlobalRef: TWideStringField;
    qryManifestRouteManifestRouteID: TAutoIncField;
    qryManifestRouteRouteFrom: TWideStringField;
    qryManifestRouteRouteTo: TWideStringField;
    qryManifestRouteRouteDesc: TWideStringField;
    qryManifestRouteDistance: TIntegerField;
    qryManifestRouteEditedFlag: TWideStringField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RouteDesc: TDBEdit;
    Label4: TLabel;
    Distance: TDBEdit;
    Suburb: TwwDBLookupCombo;
    Suburb2: TwwDBLookupCombo;
    MemqryManifestRoute: TkbmMemTable;
    Label5: TLabel;
    edtPaletteRate: TDBEdit;
    qryManifestRoutePaletteRate: TFloatField;
    qrySuburb: TERPQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure SuburbEnter(Sender: TObject);
    procedure Suburb2Enter(Sender: TObject);
    procedure Suburb2CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure Suburb2Exit(Sender: TObject);
    procedure qryManifestRouteAfterOpen(DataSet: TDataSet);
    procedure qrySuburbBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    procedure SaveTransaction;    
  public
    { Public declarations }
  end;

implementation

uses
  DNMExceptions, FormFactory, DnMlib,
   AppEnvironment, CommonLib;
{$R *.dfm}

{ TManifestRouteGUI }

procedure TManifestRouteGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
  Notify;
end;

procedure TManifestRouteGUI.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  DisableForm;
  try
    try
      inherited;
      if qryManifestRoute.Active then begin
        if not (qryManifestRoute.State in [dsBrowse]) then begin
          qryManifestRoute.Post;
          Notify;
        end;
        CloseQueries;
      end;

      qryManifestRoute.ParamByName('ID').asInteger := KeyID;

      Setlength(QueryNamesNotToOpen, 1);
      QueryNamesNotToOpen[0] := 'qrySuburb';
      OpenQueries(QueryNamesNotToOpen);

      if KeyID <> 0 then begin
        EditNoAbort(qryManifestRoute);
      end else begin
        qryManifestRoute.Insert;
      end;

      // Our exception handler
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TManifestRouteGUI.btnSaveClick(Sender: TObject);
begin
  inherited;
  // Save transaction.
  SaveTransaction;

  // Notify our attached lists.
  Notify;

  // Close our form.
  Self.Close;
end;

procedure TManifestRouteGUI.btnNewClick(Sender: TObject);
begin
  inherited;
  SaveTransaction;
  CloseQueries;
  KeyID := 0;
  FormShow(Sender);
end;

procedure TManifestRouteGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TManifestRouteGUI.SaveTransaction;
begin
  if Empty(qryManifestRouteRouteFrom.AsString) or Empty(qryManifestRouteRouteFrom.AsString) then Exit;
  with qryManifestRoute do try
      if State <> dsBrowse then begin
        ProcessEditedFlag('Main', Self, memqryManifestRoute, qryManifestRoute, nil);
        Edit;
        Post;
      end;
    except
      raise;
    end;
end;

procedure TManifestRouteGUI.SuburbEnter(Sender: TObject);
begin
  inherited;
  if not (QrySuburb.Active) then begin
    QrySuburb.Active := true;
  end;
end;

procedure TManifestRouteGUI.Suburb2Enter(Sender: TObject);
begin
  inherited;
  if not (QrySuburb.Active) then begin
    QrySuburb.Active := true;
  end;
end;

procedure TManifestRouteGUI.Suburb2CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  //
end;

procedure TManifestRouteGUI.Suburb2Exit(Sender: TObject);
begin
  inherited;
  qryManifestRouteRouteDesc.AsString := Suburb.Text + ' to ' + Suburb2.Text;
end;

procedure TManifestRouteGUI.qryManifestRouteAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(qryManifestRoute, MemqryManifestRoute)
end;

procedure TManifestRouteGUI.qrySuburbBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qrySuburb.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

initialization
  RegisterClassOnce(TManifestRouteGUI);
  with FormFact do begin
    RegisterMe(TManifestRouteGUI, 'TManifestRouteListGUI_*=ManifestRouteID');
    RegisterControl(TManifestRouteGUI, '*_cboRoute=ManifestRouteID');
  end;
end.
