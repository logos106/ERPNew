unit frmProjToSmartForm;
{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 01/02/06  1.00.01 AL  Changed ProductID to GroupProductID in queries's left joins
                       to show correct product
                       why do we need ProductID there?
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  
  ActnList, StdCtrls, Grids, BaseGrid, AdvGrid, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel,
  DBAccess, MyAccess, DataState, Menus, AdvMenus, MemDS, Shader, ImgList;

type
  TProjToSmartGUI = class(TBaseInputGUI)
    qryParts: TMyQuery;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlProject: TDNMPanel;
    qryPartsQty: TMyQuery;
    DNMPanel1: TDNMPanel;
    grdParts: TAdvStringGrid;
    chkNoRemind: TCheckBox;
    Label1: TLabel;
    ActionList1: TActionList;
    actCreateSmartOrder: TAction;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure grdPartsCellChanging(Sender: TObject; OldRow, OldCol, NewRow, NewCol: integer; var Allow: boolean);
    procedure btnCancelClick(Sender: TObject);
    procedure actCreateSmartOrderExecute(Sender: TObject);
    procedure actCreateSmartOrderUpdate(Sender: TObject);
  private
    { Private declarations }
    iManufPartID: integer;
    iProjectID: integer;
    iSmartOrderID: integer;
    sProjectName: string;
    iSaleOrderNo: integer;
    iJobID: integer;
    procedure SetUpGrid;
    procedure CreateProjectSmartOrder;
    procedure GetProjectLine(iProjectLineID: integer);
    procedure DisableReminder;
    function GetJobID: integer;
  public
    { Public declarations }
    
  end;

//var
//  ProjToSmartGUI: TProjToSmartGUI;

implementation

{$R *.dfm}
uses
  DNMExceptions,   
  frmSmartOrderFrm, FormFactory, CommonDbLib, CommonLib, AppEnvironment,
  FastFuncs, BusObjSmartOrder, BusObjBase;

const

  // Grid Columns
  COL_NAME  = 0;
  COL_DESC  = 1;
  COL_RQD   = 2;
  COL_AVAIL = 3;
  COL_ORDER = 4;
  COL_ID    = 5;

procedure TProjToSmartGUI.FormShow(Sender: TObject);
begin
  iSmartOrderID := 0;
  try
    if AccessLevel <> 1 then AccessLevel := 6;
    inherited;
    GetProjectLine(KeyID);
    pnlProject.Caption := 'Project: ' + sProjectName;
    qryParts.ParamByName('xGroupProductID').asInteger := iManufPartID;
    qryPartsQty.ParamByName('xClassID').asInteger := AppEnv.DefaultClass.ClassID;
    qryPartsQty.ParamByName('xGroupProductID').asInteger := iManufPartID;
    OpenQueries;
    SetUpGrid;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
end;

procedure TProjToSmartGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
//  ProjToSmartGUI := nil;
  notify;
end;

procedure TProjToSmartGUI.GetProjectLine(iProjectLineID: integer);
var
  qryProjLines: TMyQuery;
  qryProj: TMyQuery;
begin
  qryProj := TMyQuery.Create(nil);
  qryProj.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryProjLines := TMyQuery.Create(nil);
  qryProjLines.Connection := CommonDbLib.GetSharedMyDacConnection;

  try
    with qryProjLines do begin
      SQL.Clear;
      SQL.Add('SELECT ProjectID, PartsID FROM tblProjectLines ' +
        'WHERE ProjectLineID = :xProjectLineID');
      ParamByName('xProjectLineID').asInteger := iProjectLineID;
      Open;
      if IsEmpty then begin
        CommonLib.MessageDlgXP_Vista('Could not Create Project Smart Order - Project Line not found', mtError, [mbOK], 0);
        Exit;
      end else begin
        iManufPartID := FieldByName('PARTSID').AsInteger;
        iProjectID := FieldByName('ProjectID').AsInteger;
        iSaleOrderNo := FieldByName('ProjectID').AsInteger;
        // the ProjectID is the iSaleOrderID (see project creation in Sale Order form)
      end;
    end;

    with qryProj do begin
      SQL.Clear;
      SQL.Add('SELECT ProjectName, SaleOrderNumber FROM tblProjects ' +
              'WHERE OrderNumber = :xProjectID');
      ParamByName('xProjectID').asInteger := iProjectID;
      Open;
      if IsEmpty then begin
        CommonLib.MessageDlgXP_Vista('Could not Create Project Smart Order - Project Master not found', mtError, [mbOK], 0);
        Exit;
      end else begin
        sProjectName := FieldByName('ProjectName').AsString;
      end;
    end;

  finally
    FreeAndNil(qryProj);
    FreeAndNil(qryProjLines);
  end;
end;


procedure TProjToSmartGUI.CreateProjectSmartOrder;
var
    SmartOrder : TSmartOrder;
    procedure CreateSmartOrderLines;
        var i : Integer;
    begin
        for i := 1 to grdParts.RowCount do
            if grdParts.Cells[COL_ORDER, i] = grdParts.CheckTrue then
                if qryParts.locate('ProductID', grdParts.Cells[COL_ID, i], [loCaseInsensitive]) then begin
                    SmartOrder.Lines.New;
                    SmartOrder.Lines.PARTSNAME      := qryParts.FieldByName('PartName').AsString;
                    SmartOrder.Lines.PODesc         := qryParts.FieldByName('PartsDescription').AsString;
                    SmartOrder.Lines.SupplierID     := qryParts.FieldByName('ClientID').AsInteger;
                    SmartOrder.Lines.Qty            := qryParts.FieldByName('Rqd').AsFloat;
                    SmartOrder.Lines.ClassID        := AppEnv.DefaultClass.ClassID;
                    SmartOrder.Lines.CusJobName     := self.sProjectName;
                    SmartOrder.Lines.PostDB;
                end;
    End;
begin
    iSmartOrderID           := 0;
    SmartOrder              := TsmartOrder.Create(nil);
    SmartOrder.connection   := TMydacdataconnection.Create(SmartOrder);
    SmartOrder.Connection.Connection    := CommonDbLib.GetNewMyDacConnection(nil);
    SmartOrder.Connection.BeginTransaction;
    try
        SmartOrder.New;
        SmartOrder.SmartOrderDesc   := sProjectName;
        SmartOrder.ProjectLineID    := KeyID;
        SmartOrder.PostDB;
        CreateSmartOrderLines;
        SmartOrder.Save;
        iSmartOrderID               := SmartOrder.ID;
    Finally
        SmartOrder.Connection.CommitTransaction;
    End;
end;

procedure TProjToSmartGUI.SetUpGrid;
var
  i: integer;
  iProductID: integer;
begin
  grdParts.HideColumn(COL_ID);
  grdParts.RowCount := 1;

  qryParts.First;
  while not qryParts.Eof do begin
    with grdParts do begin
      AddRow;
      i := RowCount - 1;
      iProductID := qryParts.FieldByName('ProductID').AsInteger;
      //iProductID := qryParts.FieldByName('GroupProductID').AsInteger;
      grdParts.Cells[COL_NAME, i] := qryParts.FieldByName('PartName').AsString;
      Cells[COL_DESC, i] := qryParts.FieldByName('PartsDescription').AsString;
      Cells[COL_RQD, i] := qryParts.FieldByName('Rqd').AsString;
      Cells[COL_ID, i] := FastFuncs.IntToStr(iProductID);
      AddCheckBox(COL_ORDER, i, false, true);

      // check if entry in tblpartsqty, if not then set qty to zero
      if qryPartsQty.Locate('ProductID', iProductID, [loCaseInsensitive]) then begin
        if qryParts.FieldByName('PARTTYPE').AsString <> 'OTHER' then begin
          Cells[COL_AVAIL, i] := qryPartsQty.FieldByName('Qty').AsString;
          if qryPartsQty.FieldByName('Qty').AsInteger < qryPartsQty.FieldByName('Rqd').AsInteger then begin
            grdParts.SetCheckBoxState(COL_ORDER, i, true);
          end else begin
            grdParts.SetCheckBoxState(COL_ORDER, i, false);
          end;
        end else begin
          Cells[COL_AVAIL, i] := 'N/A';
          grdParts.SetCheckBoxState(COL_ORDER, i, true);
        end;
      end else begin
        Cells[COL_AVAIL, i] := '0';
        grdParts.SetCheckBoxState(COL_ORDER, i, true);
      end;

      qryParts.Next;
    end;
  end;
end;

procedure TProjToSmartGUI.grdPartsCellChanging(Sender: TObject; OldRow, OldCol, NewRow, NewCol: integer;
  var Allow: boolean);
begin
  inherited;

  // we don't want them changing any cell other than clicking the ok button
  if NewCol = COL_ORDER then begin
    Allow := true;
  end else begin
    Allow := false;
  end;
end;

procedure TProjToSmartGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  if chkNoRemind.Checked then begin
    DisableReminder;
  end;
  Close;
end;

procedure TProjToSmartGUI.actCreateSmartOrderExecute(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  iJobID := GetJobID;
  CreateProjectSmartOrder;
  if iSmartOrderID <> 0 then begin
    DisableReminder;
    tmpComponent := GetComponentByClassName('TSmartOrderGUI');
    If not Assigned(tmpComponent) then Exit;
    with TSmartOrderGUI(tmpComponent) do begin
      KeyID := self.iSmartOrderID;
      FormStyle := fsMDIChild;
      BringToFront;
    end;
    Close;
  end;
end;

procedure TProjToSmartGUI.actCreateSmartOrderUpdate(Sender: TObject);
var
  i: integer;
  bAtLeastOne: boolean;
begin
  inherited;
  bAtLeastOne := false;
  for i := 1 to grdParts.RowCount - 1 do begin
    if grdParts.Cells[COL_ORDER, i] = grdParts.CheckTrue then begin
      bAtLeastOne := true;
      Break;
    end;
  end;
  actCreateSmartOrder.Enabled := bAtLeastOne;
end;

procedure TProjToSmartGUI.DisableReminder;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(Self);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('UPDATE tblProjectLines SET HavePromptedOrder = "T" ' +
      'WHERE ProjectLineID = :xProjectLineID');
    qry.ParamByName('xProjectLineID').asInteger := KeyID;
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

function TProjToSmartGUI.GetJobID: integer;
var
  qry: TMyQuery;
begin
  Result := 0;
  qry := TMyQuery.Create(Self);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT ClientID ');
      SQL.Add('FROM tblSales where SaleID = :xSaleID');
      ParamByName('xSaleID').asInteger := iSaleOrderNo;
      Open;
      if not IsEmpty then begin
        Result := FieldByName('ClientID').AsInteger;
      end else begin
        CommonLib.MessageDlgXP_Vista('Cannot find Job for this Project', mtWarning, [mbOK], 0);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

initialization
  RegisterClassOnce(TProjToSmartGUI);
  FormFact.RegisterMe(TProjToSmartGUI, 'TRemindersListGUI_*_ProjectPurchase=ProjectLineID');
end.
