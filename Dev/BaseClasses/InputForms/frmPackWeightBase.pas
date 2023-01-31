unit frmPackWeightBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase , BusObjTrans, Buttons, Wwdbigrd, Grids,
  Wwdbgrid;

type
  TfmPackWeightBase = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    tblPackWeightLines: TERPQuery;
    dsPackWeightLines: TDataSource;
    grdTransactions: TwwDBGrid;
    btnDelete: TwwIButton;
    tblPackWeightLinesID: TIntegerField;
    tblPackWeightLinesPackCount: TIntegerField;
    tblPackWeightLinesAttribValue1: TFloatField;
    tblPackWeightLinesDeleted: TWideStringField;
    tblPackWeightLinesAttribValue2: TFloatField;
    tblPackWeightLinesmstimeStamp: TDateTimeField;
    tblPackWeightLinesmsUpdatesitecode: TWideStringField;
    lblMsg: TLabel;
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tblPackWeightLinesAfterOpen(DataSet: TDataSet);
    procedure btnDeleteClick(Sender: TObject);
    procedure tblPackWeightLinesAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    fTransLine: TTransLineBase;
    (*procedure doBusObjEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);*)
    function SaveRecord: Boolean;
    //Procedure Openrec;
    //procedure NewRecord;
    procedure SetTransLine(const Value: TTransLineBase);
    procedure Refreshtotal;
  Protected
    PackWeightObj: TPackWeightLinesBase;
    function DoPackWeightform(aLine : TTransLineBase):boolean;
    //procedure NewBusObjinstance;Virtual;
  public
    Constructor Create(AOwner:TComponent); override;
    Property TransLine : TTransLineBase read fTransLine write SetTransLine;
  end;


implementation

uses CommonLib, BusObjConst, AppEnvironment , AppEnvVirtualObj , busobjOrders,
  BusObjSales, CommonDbLib, LogLib;

{$R *.dfm}

procedure TfmPackWeightBase.btnDeleteClick(Sender: TObject);
begin
  inherited;
  PackWeightObj.PostDB;
  if (PackWeightObj.count >0) and (not(PackWeightObj.Deleted )) then begin
    PackWeightObj.Deleted := true;
    PackWeightObj.PostDB;
  end;
end;

procedure TfmPackWeightBase.cmdCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

Function TfmPackWeightBase.SaveRecord :Boolean;
begin
  result:= False;
  PackWeightObj.PostDB;
  if not(PackWeightObj.Save) then exit;
  Result:= True;

end;

procedure TfmPackWeightBase.SetTransLine(const Value: TTransLineBase);
begin
  fTransLine := Value;
  if fTransLine <> nil then begin
          if fTransLine is TPurchaseOrderLine then PackWeightObj := TPurchaseOrderLine(fTransLine).PurchaseLinePackWeight
    else  if fTransLine is TSalesLine         then PackWeightObj := TSalesLine(fTransLine).SalesLinePackWeight
    else exit;
    PackWeightObj.Dataset.AfterOpen := tblPackWeightLinesAfterOpen;
    PackWeightObj.Dataset.AfterPost := tblPackWeightLinesAfterPost;
    TransConnection := TERPconnection(fTransLine.Connection.Connection);
    dsPackWeightLines.DataSet :=PackWeightObj.Dataset;
    tblPackWeightLinesAfterOpen(dsPackWeightLines.DataSet);
  end;
end;

procedure TfmPackWeightBase.tblPackWeightLinesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  DataSet.fieldbyname('AttribValue1').DisplayLabel := Appenv.CompanyPrefs.PackWeightField1;
  DataSet.fieldbyname('AttribValue2').DisplayLabel := Appenv.CompanyPrefs.PackWeightField2;

  DataSet.fieldbyname('AttribValue1').Visible := Appenv.CompanyPrefs.EnablePackWeightField1 or Appenv.CompanyPrefs.EnablePackWeightField2;
  DataSet.fieldbyname('AttribValue2').Visible := Appenv.CompanyPrefs.EnablePackWeightField2;
  REfreshtotal;
end;

procedure TfmPackWeightBase.tblPackWeightLinesAfterPost(DataSet: TDataSet);
begin
  inherited;
  REfreshtotal;
end;

procedure TfmPackWeightBase.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  PackWeightObj.Connection.CommitNestedTransaction;
  Modalresult := mrOk;
end;


constructor TfmPackWeightBase.create(AOwner: TComponent);
begin
  PackWeightObj := nil;
  inherited;
  TitleLabel.caption :=   Appenv.CompanyPrefs.PackWeightField1;
  if Appenv.CompanyPrefs.EnablePackWeightField2 then TitleLabel.caption :=   TitleLabel.caption +' and ' + Appenv.CompanyPrefs.PackWeightField2;
  Caption := TitleLabel.Caption;
end;

(*procedure TfmPackWeightBase.doBusObjEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TPackWeightLinesBase then TPackWeightLinesBase(Sender).Dataset  := tblPackWeightLines;
     end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterPost )then begin
        REfreshtotal;
     end;

end;*)

function TfmPackWeightBase.DoPackWeightform(aLine: TTransLineBase):Boolean;
var
  lineId :Integer;
begin
  REsult := False;
  TransLine := aLine;
  if ShowModal = mrOk then begin
    try
             if Appenv.companyPrefs.PackWeightQtyField =2 then ALine.UOMQtySold :=PackWeightObj.TotalAttribValue2
        else ALine.UOMQtySold :=PackWeightObj.TotalAttribValue1;
        ALine.PostDB;
    finally
      PackWeightObj.Dataset.AfterOpen := nil;
      PackWeightObj.Dataset.AfterPost := nil;
      PackWeightObj := nil;
    end;

       lineId :=ALine.ID;
      try
             if (aline is TSalesLine)         then TSalesLine(Aline).SalesLinePackWeightSum.closedb
        else if (aline is TPurchaseOrderLine) then TPurchaseOrderLine(Aline).PurchaseLinePackWeightSum.closedb;
        Aline.closedb;
        Aline.opendb;
           if (aline is TSalesLine)         then TSalesLine(Aline).SalesLinePackWeightSum
      else if (aline is TPurchaseOrderLine) then TPurchaseOrderLine(Aline).PurchaseLinePackWeightSum;
      finally
        ALine.Locate(ALine.IDFieldname , lineId , []);
      end;
      REsult := True;
  end;
end;

procedure TfmPackWeightBase.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if PackWeightObj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            PackWeightObj.Connection.CommitNestedTransaction;
            CanClose := true;
            modalresult := mrok;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and RollbackNested changes
          PackWeightObj.Connection.RollbackNestedTransaction;
          PackWeightObj.Dirty := false;
          CanClose := true;
          modalresult := mrcancel;
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

procedure TfmPackWeightBase.FormCreate(Sender: TObject);
begin
  inherited;
  fbTabSettingEnabled := false;
end;

procedure TfmPackWeightBase.FormShow(Sender: TObject);
begin
  //NewBusObjinstance;
  inherited;
  //OpenRec;
  RefreshTotal;
  if PackWeightObj.count =0 then begin
    PackWeightObj.New;
    PackWeightObj.Packcount :=1;
    grdTransactions.setActiveField('AttribValue1');
  end;
end;
Procedure TfmPackWeightBase.Refreshtotal;
begin
        grdTransactions.ColumnByName('AttribValue1').FooterValue := floatToStrF(PackWeightObj.TotalAttribValue1, ffGeneral,15, 2);
        grdTransactions.ColumnByName('AttribValue2').FooterValue := floatToStrF(PackWeightObj.TotalAttribValue2, ffGeneral,15, 2);
        grdTransactions.ColumnByName('PAckcount').FooterValue    := inttostr(PackWeightObj.TotalPackcount);

        lblMsg.Caption := '';
        if fTransLine <> nil then
              if Appenv.CompanyPrefs.PackWeightQtyField = 2 then lblMsg.Caption := grdTransactions.ColumnByName('AttribValue2').FooterValue
        else  lblMsg.Caption := grdTransactions.ColumnByName('AttribValue1').FooterValue;
        lblMsg.Caption := 'Transaction Quantity :' +  lblMsg.Caption  +' ' + Transline.UnitOfMeasure +'(' + floattostrF(Transline.UOMMultiplier , ffGeneral , 115 , 2)+')';
end;

(*procedure TfmPackWeightBase.NewBusObjinstance;
begin
  PackWeightObj.Connection.connection := TransConnection;//Self.MyConnection;
  PackWeightObj.BusObjEvent := doBusObjEvent;
end;*)

(*procedure TfmPackWeightBase.NewRecord;
begin
    CloseQueries;
    KeyID:= 0;
    NewBusObjinstance;
    AccessLevel:= AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName);
    PackWeightObj.Connection.BeginNestedTransaction;
    //OpenRec;
    Caption:= TitleLabel.Caption + AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel);
    //Setcontrolfocus(edtName);
end;*)

(*procedure TfmPackWeightBase.Openrec;
begin
  PackWeightObj.Load(KeyID);
  PackWeightObj.connection.BeginTransaction;
  if PackWeightObj.count=0 then PackWeightObj.new;
  openQueries;
  PackWeightObj.Dirty := false;
end;*)


end.

