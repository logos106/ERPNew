unit RapPrescriberTypeList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, DNMSpeedButton, CustomInputBox,
  kbmMemTable, wwdblook, Shader;

type
  TRapPrescriberTypeListGUI = class(TBaseListingGUI)
    grpProductdetails: TRadioGroup;
    qryMainDisplayCat: TLargeintField;
    qryMainPrescriberId: TLargeintField;
    qryMainPrescriberCode: TStringField;
    qryMainPrescriberName: TStringField;
    qryMainItemNo: TStringField;
    qryMainItemName: TStringField;
    qryMainProductCode: TStringField;
    qryMainDescription: TStringField;
    qryMainActive: TStringField;
    qryMainRapProductID: TLargeintField;
    qryMainCategoryId: TLargeintField;
    qryMainproviderNum: TStringField;
    qryMainNon_DVAEX: TLargeIntField;
    qryMainNon_DVAInc: TLargeIntField;
    qryMainDVAEX: TLargeintField;
    qryMainDVAInc: TLargeintField;
    procedure grpFiltersClick(Sender: TObject);override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure cmdNewClick(Sender: TObject);
    procedure actExecuteFilterExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grpProductdetailsClick(Sender: TObject);
  private
    tableName :STring;
  Protected
    Procedure RefreshQuery; Override;
  public
    { Public declarations }
  end;


implementation

uses FastFuncs,CommonLib, CommonDbLib, QueryLoadObj, BaseInputForm,
  RapPrescriberTypeListDetails;

{$R *.dfm}

Procedure TRapPrescriberTypeListGUI.REfreshQuery;
var
    QLO :TQueryLoad;
    Dates :TVarParams;
    SQLParams :TVarParams;
begin
    GuiPrefs.Active := false;
    Qrymain.disablecontrols;
    Try
        tablename := CommonDbLib.GetUserTemporaryTableName('tmp_PrescriberList');
        if Qrymain.Active then qrymain.close;
        QryMain.SQL.clear;
        Qrymain.SQL.add('Select * from ' + TableName + ' order by PrescriberId , Displaycat' );
        SQLParams :=TVarParams.create;
        QLO :=TQueryLoad.Create;
        Try
            SQLParams.Add('Tablename' ,TableName);
            //QLO.Connection := TMyConnection(qryMain.Connection);
            QLO.QueryGroup := 'TRapPrescriberTypeListGUI';
            QLO.DropTable(TableName);
            QLO.Execute('CreateTmpTable'    ,SQLParams, 'TRapPrescriberTypeListGUI'   );
            QLO.Execute('InsertPrescribers' ,SQLParams, 'TRapPrescriberTypeListGUI'   );

            Dates := TVarParams.Create;
            Try
                Dates.Add('Date1' ,dtfrom.DateTime);
                Dates.Add('Date2 ' , dtTo.DateTime);
                if Qrymain.Active= False then Qrymain.Open;

                with QLO.Execute('DVASalesamount', Dates) do try
                    if recordcount > 0 then begin
                        first;
                        while eof = False do begin
                            if Qrymain.Locate('PrescriberId;DisplayCat' , VarArrayof([fieldByname('PrescriberID').asInteger , 1]) , []) then begin
                                if Qrymain.state in [dsedit,dsInsert] then else Qrymain.Edit;
                                Qrymain.fieldbyname('DVAEx').asFloat :=Qrymain.fieldbyname('DVAEx').asFloat  + Fieldbyname('TotalLineAmount').asFloat;
                                Qrymain.fieldbyname('DVAinc').asFloat :=Qrymain.fieldbyname('DVAInc').asFloat  + Fieldbyname('TotalLineAmountInc').asFloat;
                                if Qrymain.state in [dsedit,dsInsert] then Qrymain.Post;
                            end;
                            Next;
                        end;
                    end;
                Finally
                    close;
                    Free;
                end;
                with QLO.Execute('Non-DVASalesamount', Dates) do try
                    if recordcount > 0 then begin
                        first;
                        while eof = False do begin
                            if Qrymain.Locate('PrescriberId;DisplayCat' , VarArrayof([fieldByname('PrescriberID').asInteger , 1]), [])  then begin
                                if Qrymain.state in [dsedit,dsInsert] then else Qrymain.Edit;
                                Qrymain.fieldbyname('non_DVAEx').asFloat :=Qrymain.fieldbyname('non_DVAEx').asFloat  + Fieldbyname('TotalLineAmount').asFloat;
                                Qrymain.fieldbyname('non_DVAinc').asFloat :=Qrymain.fieldbyname('non_DVAInc').asFloat  + Fieldbyname('TotalLineAmountInc').asFloat;
                                if Qrymain.state in [dsedit,dsInsert] then Qrymain.Post;
                            end;
                            Next;
                        end;
                    end;
                Finally
                    close;
                    Free;
                end;
            finally
                FreeAndNil(Dates);
            end;
            QLO.Execute('InsertCategory2',SQLParams , 'TRapPrescriberTypeListGUI'   );
        finally
            FreeandNil(QLO);
            FreeAndNil(SQLParams);
        end;
        if qrymain.Active then Qrymain.Close;
        Qrymain.Open;
    Finally
        Qrymain.Enablecontrols;
        GuiPrefs.Active := True;
    end;

(*var
    Qry :TMyQuery;
    tablename : String;
begin
    tablename := CommonDbLib.GetUserTemporaryTableName('tmp_PrescriberList');
    Qry := TMyQuery.Create(Self)
    Try
        Qry.Connection := Qrymain.connection;
        Qry.SQL.add('Drop table if exists ' + tableName);
        Qry.Execute;

        Qry.SQl.Clear;
        Qry.SQL.add('CREATE TABLE ' + tablename + '(';
        Qry.SQL.add('DisplayCat bigint(1) NOT NULL default "0",';
        Qry.SQL.add('  PrescriberId int(10) default NULL,';
        Qry.SQL.add('  PrescriberCode varchar(6) default NULL,';
        Qry.SQL.add('  PrescriberName varchar(100) default NULL,';
        Qry.SQL.add('  ItemNo varchar(4) default NULL,';
        Qry.SQL.add('  ItemName varchar(100) default NULL,';
        Qry.SQL.add('  RapProductID int(10) NOT NULL default "0",';
        Qry.SQL.add('  CategoryId int(10) NOT NULL default "0",';
        Qry.SQL.add('  ProductCode varchar(4) default NULL,';
        Qry.SQL.add('  Description varchar(100) default NULL,';
        Qry.SQL.add('  providerNum varchar(15) NOT NULL default '''',';
        Qry.SQL.add('  Active enum("T","F") default NULL,';
        Qry.SQL.add('  Non_DVAEX bigint(1) NOT NULL default "0",';
        Qry.SQL.add('  Non_DVAInc bigint(1) NOT NULL default "0",';
        Qry.SQL.add('  DVAEX bigint(1) NOT NULL default "0",';
        Qry.SQL.add('  DVAInc bigint(1) NOT NULL default "0"';
        Qry.SQL.add(')';
        Qry.Execute;

        Qry.SQl.Clear;
        Qry.SQL.add('SELECT 2 as DisplayCat,';
        Qry.SQL.add('tblRapPrescriberTypeitems.PrescriberId,tblRapPrescriberType.PrescriberCode,';
        Qry.SQL.add('tblRapPrescriberType.PrescriberName,';
        Qry.SQL.add('tblrapcategories.ItemNo,';
        Qry.SQL.add('tblrapcategories.ItemName,';
        Qry.SQL.add('tblrapproducts.RapProductID,';
        Qry.SQL.add('tblrapcategories.CategoryId,';
        Qry.SQL.add('tblrapproducts.ProductCode,';
        Qry.SQL.add('tblrapproducts.Description,';
        Qry.SQL.add('"               " as providerNum ,';
        Qry.SQL.add('tblRapPrescriberTypeitems.Active , 0 as Non_DVAEX, 0 as Non_DVAInc,0 as DVAEX,0 as DVAInc';
        Qry.SQL.add('FROM';
        Qry.SQL.add('tblRapPrescriberTypeitems';
        Qry.SQL.add('Inner Join tblrapproducts ON tblRapPrescriberTypeitems.RapProductID = tblrapproducts.RapProductID';
        Qry.SQL.add('Inner Join tblrapcategories ON tblrapproducts.RapCategoryID = tblrapcategories.CategoryID';
        Qry.SQL.add('inner join tblRapPrescriberType on  tblRapPrescriberType.PrescriberID =tblRapPrescriberTypeitems.PrescriberId







    Finally
        if Qry.Active then Qry.close;
        FreeandNil(qry);
    End;*)
    LabelGridFromFieldNames := False;
  (*qryMain.Params.ParamByName('Date1').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('Date2').AsDate := dtTo.DateTime;
  qryMain.Params.ParamByName('Date3').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('Date4').AsDate := dtTo.DateTime;*)

    Inherited;
end;
procedure TRapPrescriberTypeListGUI.grpFiltersClick(Sender: TObject);
begin
  if grpFilters.Itemindex       = 0 then GroupFilterString := 'Active = "T"'
  else if grpFilters.ItemIndex  = 1 then GroupFilterString := 'Active = "F"'
  else GroupFilterString := '';

    if GroupFilterString  <> '' then GroupFilterString  := GroupFilterString  + ' and ';
    GroupFilterString  := GroupFilterString  + ' DisplayCat = 1';
    inherited;


(*      cboDateRange.Visible :=  (grpProductdetails.Itemindex = 0) and (Sender = grpProductdetails);
    lblFrom.Visible :=  (grpProductdetails.Itemindex = 0) and (Sender = grpProductdetails);
    dtFrom.Visible :=  (grpProductdetails.Itemindex = 0) and (Sender = grpProductdetails);
    lblTo.Visible :=  (grpProductdetails.Itemindex = 0) and (Sender = grpProductdetails);
    dtTo.Visible :=  (grpProductdetails.Itemindex = 0) and (Sender = grpProductdetails);

if (grpProductdetails.Itemindex = 0) and (Sender = grpProductdetails) then begin
      DtFrom.Datetime := incmonth(Now , -3);
      DtTo.Datetime := Now;
  end else begin
      DtFrom.Datetime := 0;
      DtTo.Datetime := Now;
  end;
  if grpFilters.Itemindex       = 0 then GroupFilterString := 'Active = "T"'
  else if grpFilters.ItemIndex  = 1 then GroupFilterString := 'Active = "F"'
  else GroupFilterString := '';

  if grpProductdetails.ItemIndex = 0 then begin
    if GroupFilterString  <> '' then GroupFilterString  := GroupFilterString  + ' and ';
    GroupFilterString  := GroupFilterString  + ' DisplayCat = 1';
      grdmain.RemoveField('ItemNo');
      GuiPrefs.HideField('ItemNo', qrymain);
      grdmain.RemoveField('ItemName');
      GuiPrefs.HideField('ItemName', qrymain);
      grdmain.RemoveField('ProductCode');
      GuiPrefs.HideField('ProductCode', qrymain);
      grdmain.RemoveField('Description');
      GuiPrefs.HideField('Description', qrymain);
      grdmain.ColumnByname('PrescriberName').DisplayWidth     := 62;

      grdmain.RemoveField('Active');
      GuiPrefs.HideField('Active', qrymain);

      grdmain.AddField('non_DVAEx');
      grdmain.AddField('non_DVAInc');
      grdmain.AddField('DVAEx');
      grdmain.AddField('DVAInc');
      grdmain.ColumnByname('DVAEx').DisplayWidth     := 10;
      grdmain.ColumnByname('DVAInc').DisplayWidth    := 10;
      grdmain.ColumnByname('non_DVAEx').DisplayWidth := 10;
      grdmain.ColumnByname('non_DVAInc').DisplayWidth:= 10;
      grdmain.ColumnByname('non_DVAEx').GroupName := 'Non-DVA';
      grdmain.ColumnByname('non_DVAInc').GroupName:= 'Non-DVA';
      grdmain.ColumnByname('DVAEx').GroupName     := 'DVA';
      grdmain.ColumnByname('DVAInc').GroupName    := 'DVA';
      grdmain.ColumnByname('non_DVAEx').DisplayLabel := 'Sales(Ex)';
      grdmain.ColumnByname('non_DVAInc').DisplayLabel:= 'Sales(Inc)';
      grdmain.ColumnByname('DVAEx').DisplayLabel     := 'Sales(Ex)';
      grdmain.ColumnByname('DVAInc').DisplayLabel    := 'Sales(Inc)';
      grdmain.AddField('Active');
  end else begin
    grdmain.ColumnByname('PrescriberName').DisplayWidth     := 30;
    grdmain.RemoveField('Active');
    GuiPrefs.HideField('Active', qrymain);

    grdmain.AddField('ItemNo');
    grdmain.AddField('ItemName');
    grdmain.AddField('ProductCode');
    grdmain.AddField('Description');

    grdmain.ColumnByname('Itemno').DisplayWidth     := 7;
    grdmain.ColumnByname('ItemName').DisplayWidth   := 30;
    grdmain.ColumnByname('ProductCode').DisplayWidth:= 7;
    grdmain.ColumnByname('Description').DisplayWidth:= 30;

    grdmain.RemoveField('non_DVAEx');
    GuiPrefs.HideField('non_DVAEx', qrymain);
    grdmain.RemoveField('non_DVAInc');
    GuiPrefs.HideField('non_DVAInc', qrymain);
    grdmain.RemoveField('DVAEx');
    GuiPrefs.HideField('DVAEx', qrymain);
    grdmain.RemoveField('DVAInc');
    GuiPrefs.HideField('DVAInc', qrymain);

    grdmain.AddField('Active');
  end;

  inherited;*)
end;

procedure TRapPrescriberTypeListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
    if grpProductdetails.ItemIndex = 0 then Exit;

    if Qrymain.fieldByname('DisplayCat').asInteger = 1 then begin
        AFont.Style := AFont.Style + [fsBold];
        if  Highlight then
            AFont.Color := $A0A0FF
        else
            AFont.Color := clMaroon;
        if (FastFuncs.SameText(Field.Fieldname , 'PrescriberCode')) or (FastFuncs.SameText(Field.Fieldname , 'PrescriberName')) then
        else Afont.Color := ABrush.Color;
    end else begin
        if (FastFuncs.SameText(Field.Fieldname , 'PrescriberCode')) or (FastFuncs.SameText(Field.Fieldname , 'PrescriberName')) then
            Afont.Color := ABrush.Color;
    end;

end;

procedure TRapPrescriberTypeListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmRapPrescriberType');
  if Assigned(Form) then begin
    with TBaseInputGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TRapPrescriberTypeListGUI.actExecuteFilterExecute(Sender: TObject);
begin
  inherited;
    Qrymain.Filtered := False;
    if Qrymain.filter <> '' then Qrymain.filter := '(' + Qrymain.filter + ') or ( DisplayCat=1)';
    Qrymain.Filtered := True;
end;

procedure TRapPrescriberTypeListGUI.FormCreate(Sender: TObject);
begin
  NoDateRange := true;
  inherited;
  LabelGridFromFieldNames := False;

end;

procedure TRapPrescriberTypeListGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    if tableName <> '' then
        with Qrymain do begin
            if Active then Close;
            SQL.clear;
            SQL.add('Drop table if exists ' + tablename);
            Execute;
        end;
  inherited;

end;

procedure TRapPrescriberTypeListGUI.grpProductdetailsClick(
  Sender: TObject);
var
    Form   : TRapPrescriberTypeListDetailsGUI;
begin
  inherited;
    if grpProductdetails.Itemindex = 0 then Exit;
    Form := TRapPrescriberTypeListDetailsGUI(GetComponentByClassName('TRapPrescriberTypeListDetailsGUI'));
    if Assigned(form) then begin
        Form.FormStyle := fsMDIChild;
        form.BringTofront;
        form.grpProductdetails.ItemIndex := 1;
        Form.grpFilters.ItemIndex := grpFilters.ItemIndex;
        Setfocusedcontrol(Form.grpProductdetails);
        self.close;
    end;
end;

initialization
  RegisterClassOnce(TRapPrescriberTypeListGUI);

end.
