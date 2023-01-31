unit frmShippingContainerListGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,BusObjShippingContainer,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TfrmShippingContainerList = class(TBaseListingGUI)
    qryMainContainerName: TWideStringField;
    qryMainETDeparture: TDateField;
    qryMainShippingContainerStatus: TWideStringField;
    qryMainDeparturePoint: TWideStringField;
    qryMainVesselName: TWideStringField;
    qryMainETA: TDateField;
    qryMainArrivalPoint: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainShippingContainerID: TIntegerField;
    btnDetails: TDNMSpeedButton;
    qryMainContainerNumber: TWideStringField;
    qryMainContainerSize: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
    procedure dtFromChange(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDetailsClick(Sender: TObject);
  protected
    procedure RefreshQuery;override;
    Procedure SetGridColumns;Override;
  private
    procedure RefreshButtons;
  public
    productId : Integer;
  end;

implementation

uses
  CommonLib,frmShippingContainerGUI, AppEnvironment,FastFuncs,
  CommonFormLib;
{$R *.dfm}


procedure TfrmShippingContainerList.RefreshButtons;
begin
  cmdClose.Repaint;
  cmdPrint.Repaint;
  cmdNew.Repaint;
  cmdExport.Repaint;
  btnCustomize.Repaint;
end;

procedure TfrmShippingContainerList.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').AsDateTime := FilterdateFrom;
  qryMain.Params.ParamByName('txtto').AsDateTime   := filterDateTo;
  (*
  if productid <> -1 then begin
    qryMain.SQL.Add(' AND EXISTS (SELECT 1 FROM  tblshipcontainerdetails SD ');
    qryMain.SQL.Add(' INNER JOIN tblpurchaseLines PL ON SD.PurchaseLineId = PL.PurchaseLineID ');
    qryMain.SQL.Add(' INNER JOIN tblparts ON PL.ProductID=tblparts.PartsID ');
    qryMain.SQL.Add(' WHERE  SC.ShippingContainerID = SD.ShippingContainerID ');
    qryMain.SQL.Add(' AND PartsID = :productId )');
    qryMain.Params.ParamByName('productId').ASInteger := productId;
  end;   *)
  inherited;
(*var
  sFieldName,tmpSearchText,prefix:string;
begin
  if (grpfilters.ItemIndex <> 2) and (grpfilters.ItemIndex <> 3) then begin
    qryMain.Params.ParamByName('txtfrom').AsDateTime := dtFrom.DateTime;
    qryMain.Params.ParamByName('txtto').AsDateTime := dtTo.DateTime;
    inherited;
  end else begin    {bypass the base form because there is no date to filter by}
    if qryMain.Active then qryMain.Close;
    qryMain.SQL.Clear;
    qryMain.SQL.Add('SELECT *');
    qryMain.SQL.Add('FROM tblshippingcontainer');
    if grpfilters.ItemIndex = 2 then
      qryMain.SQL.Add('WHERE ETA is NULL');
    qryMain.Open;
    GroupFilterString := '';

    Processingcursor(True);
    try
      if (edtSearch.Text <> '') and (cboFilter.Text <> '') then begin
        sFieldName := TField(cboFilter.Items.Objects[cboFilter.ItemIndex]).FieldName;
        tmpSearchText := edtSearch.Text;

        //Add Wildcard if Not Used
        if SearchMode = smSearchEngineLike then begin
          prefix := '%';
          Label2.Caption := '"F5,F6,F7" (Like)';
        end else begin
          prefix := '';
          Label2.Caption := '"F5,F6,F7" (Starts with)';
        end;

        tmpSearchText := prefix + Trim(tmpSearchText) + '%';

        if grpfilters.ItemIndex = 2 then begin
          if SearchMode <>  smFullList then
            qryMain.SQL.Add('AND '+ sFieldName + ' LIKE ' + QuotedStr(tmpSearchText));
        end else begin
           if SearchMode <>  smFullList then
            qryMain.SQL.Add('WHERE '+ sFieldName + ' LIKE ' + QuotedStr(tmpSearchText));
        end;

        qryMain.Open;

        qryMain.Locate(sFieldName, tmpSearchText, [loCaseInsensitive, loPartialKey]);
      end;
      Processingcursor(False);
    except
      Processingcursor(False);
    end;
  end;*)
end;


procedure TfrmShippingContainerList.grpFiltersClick(Sender: TObject);
begin
  case grpFilters.ItemIndex of
    0: GroupFilterString := 'ETA <> null and Active = ' + QuotedStr('T');
    1: GroupFilterString := 'ETA <> null and Active = ' + QuotedStr('F');
    2: GroupFilterString := 'ETA = null';
    3: GroupFilterString := '';
  end;
  inherited  ;
(*begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin
        ChangeSQL(True);
        GroupFilterString := 'Active = ' + QuotedStr('T');
      end;
    1:
      begin
        ChangeSQL(True);
        GroupFilterString := 'Active = ' + QuotedStr('F');
      end;
    2:
      begin
        ChangeSQL(False);
        GroupFilterString := 'Active = ' + QuotedStr('T');
      end;
    3:
      begin
        //if qryMain.Active then qryMain.Close;
//        qryMain.SQL.Clear;
//        qryMain.SQL.Add('SELECT *');
//        qryMain.SQL.Add('FROM tblshippingcontainer');
//        qryMain.Open;
//        GroupFilterString := '';
      end;
  end;
  inherited;*)
  //RefreshQuery;
end;

(*procedure TfrmShippingContainerList.ChangeSQL(IsDated:Boolean);
var
  SQLDated:string;
  SQLNotDated:string;
begin
  SQLDated := 'SELECT * FROM tblshippingcontainer ' +
              'WHERE ETA  Between :txtfrom AND :txtto ORDER BY ETA DESC';
  SQLNotDated := 'SELECT * FROM tblshippingcontainer WHERE ETA is NULL';

  if qryMain.Active then qryMain.Close;
  qryMain.SQL.Clear;

  if IsDated then qryMain.SQL.Add(SQLDated) else qryMain.SQL.Add(SQLNotDated);

  qryMain.Open;
end;*)

procedure TfrmShippingContainerList.cmdNewClick(Sender: TObject);
var
  Frm:TComponent;
  thisKeyId : integer;
  mr : TModalResult;
begin
  DisableForm;
  thisKeyId := 0;
  try
    inherited;
    if FormStillOpen('TfrmShipContainer') then
      TForm(FindExistingComponent('TfrmShipContainer')).Close;

    Frm := GetComponentByClassName('TfrmShipContainer');
    if Assigned(Frm) then begin //if has access
      with TfrmShipContainer(Frm) do begin
        AttachObserver(Self);
        if Self.isModalForm then begin
          FormStyle := fsNormal;
          Self.Hide;
          ShowModal;
          thisKeyId := KeyId;
          Self.qryMain.Close;
          Self.qryMain.Open;
          if Self.qryMain.Locate('ShippingContainerId', thisKeyId, [loCaseInsensitive]) then begin
            Self.cmdPrintClick(self.grdMain);
          end;
          Self.Close;
        end else begin
          FormStyle := fsMDIChild;
          BringToFront;
        end;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmShippingContainerList.dtFromChange(Sender: TObject);
begin
  if (grpFilters.ItemIndex = 2) or (grpFilters.ItemIndex = 3) then exit;
  inherited;
end;

procedure TfrmShippingContainerList.dtToChange(Sender: TObject);
begin
  if (grpFilters.ItemIndex = 2) or (grpFilters.ItemIndex = 3) then exit;
  inherited;
end;

procedure TfrmShippingContainerList.FormShow(Sender: TObject);
begin
  inherited;
  // Set From & To dates provided that they have not been set externally
  dtTo.Date := IncMonth(dtTo.Date,1);
  DoDelayObjectProcedure(RefreshButtons,1, Self.classname +'.RefreshButtons');
  cmdNew.Enabled := True;
end;

procedure TfrmShippingContainerList.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmShippingContainerList.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmShippingContainerList.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmShippingContainerList.FormCreate(Sender: TObject);
begin
  inherited;
  Self.fbEnableWebSearch := True;
  UseSortInSearch := False;
  productId := -1;
end;

procedure TfrmShippingContainerList.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid('ShippingContainerID');
end;

procedure TfrmShippingContainerList.btnDetailsClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TShippingContainerListDetailsGUI');
  Self.Close;

end;

initialization
  RegisterClassOnce(TfrmShippingContainerList);
end.
