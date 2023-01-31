unit frmPayrollServicesCreate;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 08/08/05  1.00.00 IJB  Initial version.
 05/01/01  1.00.01 IJB  Modified CreatePayrollServiceForEmployee to use
                        calculate and use Tax Inc price for new service.
 14/04/07  1.00.02 IJB  Modified CreatePayrollServiceForEmployee to service name
                        as a paramater
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, DB,  ExtCtrls, StdCtrls, Mask, wwdbedit, Wwdotdot,
  Wwdbcomb, DNMPanel, Buttons, DNMSpeedButton, MemDS, wwdblook, wwDbGrid, Wwdbigrd,
  Menus, AdvMenus, Shader, ImgList;

type
  TfmPayrollServicesCreate = class(TBaseInputGUI)
    btnCreate: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkFromEmployee: TCheckBox;
    lblCopyFromEmployee: TLabel;
    chkFromProducts: TCheckBox;
    lblCreateFromParts: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    chkThisEmployee: TCheckBox;
    Label3: TLabel;
    chkAllEmployees: TCheckBox;
    Label4: TLabel;
    qrySourceEmployee: TERPQuery;
    qryDestEmployee: TERPQuery;
    cboTemplateEmployee: TwwDBLookupCombo;
    cboUpdateEmployee: TwwDBLookupCombo;
    Bevel4: TBevel;
    chkCreateNew: TCheckBox;
    Label5: TLabel;
    chkUpdate: TCheckBox;
    Label6: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure chkFromEmployeeClick(Sender: TObject);
    procedure chkFromProductsClick(Sender: TObject);
    procedure chkAllEmployeesClick(Sender: TObject);
    procedure chkThisEmployeeClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure chkCreateNewClick(Sender: TObject);
    procedure chkUpdateClick(Sender: TObject);
  private
    { Private declarations }
    fDbConnection: TERPConnection;
    fCreateForEmployeeID: integer;
    function GetCreateForEmployeeID: integer;
    procedure SetCreateForEmployeeID(const Value: integer);
    procedure SetDbConnection(const Value: TERPConnection);
    procedure ExpressPartsOnSelect(Sender: TwwDbGrid);
    procedure CreatePayrollServiceForEmployee(const EmployeeId, ProductId: integer; const SourceRate: Double;
                                              const UseSourceRate: boolean = false; const aServiceName: string = '');
  public
    { Public declarations }
    
    property DbConnection: TERPConnection read fDbConnection write SetDbConnection;
    property CreateForEmployeeID: integer read GetCreateForEmployeeID write SetCreateForEmployeeID;
  end;

implementation

{$R *.dfm}

uses
  DNMExceptions, ProductListExpressForm, DNMLib, tcDataUtils, CommonLib,
  BusObjStock, FastFuncs, tcConst;

procedure TfmPayrollServicesCreate.FormCreate(Sender: TObject);
begin
  fCreateForEmployeeID := 0;
  self.fbIgnoreAccessLevels := true;
  inherited;
  fDbConnection := nil;
end;

procedure TfmPayrollServicesCreate.FormShow(Sender: TObject);
begin
  try
    inherited;

    // Open our Queries
    OpenQueries;
    if fCreateForEmployeeID > 0 then begin
      qryDestEmployee.Locate('EmployeeID', fCreateForEmployeeID, []);
      cboUpdateEmployee.Text:= qryDestEmployee.FieldByName('EmployeeName').AsString;
    end;

  except
    // Handle these known exceptions.
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end;

procedure TfmPayrollServicesCreate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

function TfmPayrollServicesCreate.GetCreateForEmployeeID: integer;
begin
  if chkThisEmployee.Checked and qryDestEmployee.Active then Result := qryDestEmployee.FieldByName('EmployeeID').AsInteger
  else Result := 0;
end;

procedure TfmPayrollServicesCreate.SetCreateForEmployeeID(const Value: integer);
begin
  fCreateForEmployeeID := Value;
  if cboUpdateEmployee.LookupTable.Active then begin
    if cboUpdateEmployee.LookupTable.Locate('EmployeeID', fCreateForEmployeeID, []) then
      cboUpdateEmployee.Text := cboUpdateEmployee.LookupTable.FieldByName('EmployeeName').AsString;
  end;
end;

procedure TfmPayrollServicesCreate.SetDbConnection(const Value: TERPConnection);
begin
  fDbConnection := Value;
end;

procedure TfmPayrollServicesCreate.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmPayrollServicesCreate.chkFromEmployeeClick(Sender: TObject);
begin
  inherited;
  chkFromProducts.Checked := not TCheckBox(Sender).Checked;
  cboTemplateEmployee.Enabled := chkFromEmployee.Checked;
end;

procedure TfmPayrollServicesCreate.chkFromProductsClick(Sender: TObject);
begin
  inherited;
  chkFromEmployee.Checked := not TCheckBox(Sender).Checked;
  cboTemplateEmployee.Enabled := chkFromEmployee.Checked;
end;

procedure TfmPayrollServicesCreate.chkAllEmployeesClick(Sender: TObject);
begin
  inherited;
  chkThisEmployee.Checked := not TCheckBox(Sender).Checked;
  cboUpdateEmployee.Enabled := chkThisEmployee.Checked;
end;

procedure TfmPayrollServicesCreate.chkThisEmployeeClick(Sender: TObject);
begin
  inherited;
  chkAllEmployees.Checked := not TCheckBox(Sender).Checked;
  cboUpdateEmployee.Enabled := chkThisEmployee.Checked;
end;

procedure TfmPayrollServicesCreate.btnCreateClick(Sender: TObject);
var
  bm: TBookmark;
  qry, qryPart: TERPQuery;
begin
  DisableForm;
  try
  inherited;
    if chkCreateNew.Checked then begin
      if chkFromProducts.Checked then begin
        if chkThisEmployee.Checked and (cboUpdateEmployee.Text = '') then begin
          CommonLib.MessageDlgXP_Vista('Please select an employee.', mtInformation, [mbOK], 0);
          SetControlFocus(cboUpdateEmployee);
        end else begin
          with TProductListExpressGUI.Create(Application) do begin
            FilterString := 'PartType = "OTHER"';
            OnGridDataSelect := ExpressPartsOnSelect;
            grdMain.Options := grdMain.Options + [dgRowSelect, dgMultiSelect];
            ShowModal;
          end;
        end;
      end else if chkFromEmployee.Checked then begin
        if cboTemplateEmployee.Text = '' then begin
          CommonLib.MessageDlgXP_Vista('Please select an employee to copy from.', mtInformation, [mbOK], 0);
          SetControlFocus(cboTemplateEmployee);
        end else if cboUpdateEmployee.Text = '' then begin
          CommonLib.MessageDlgXP_Vista('Please select an employee to create services for.', mtInformation, [mbOK], 0);
          SetControlFocus(cboTemplateEmployee);
        end else begin
          qry := TERPQuery.Create(nil);
          try
            qry.Options.FlatBuffers := True;
            qry.Connection := DbConnection;
            qry.SQL.Text := 'SELECT * FROM tblpaysemployeeservices WHERE' + ' EmployeeId = ' +
              qrySourceEmployee.FieldByName('EmployeeId').AsString;
            qry.Open;
            if chkThisEmployee.Checked then begin
              qry.First;
              while not qry.Eof do begin
                CreatePayrollServiceForEmployee(qryDestEmployee.FieldByName('EmployeeId').AsInteger,
                  qry.FieldByName('PartID').AsInteger, qry.FieldByName('Rate').AsFloat, True, qry.FieldByName('ServiceName').AsString);
                qry.Next;
              end;
            end else if chkAllEmployees.Checked then begin
              bm := qryDestEmployee.GetBookmark;
              try
                qryDestEmployee.First;
                while not qryDestEmployee.Eof do begin
                  if qryDestEmployee.FieldByName('EmployeeID').AsInteger <>
                    qrySourceEmployee.FieldByName('EmployeeID').AsInteger then begin
                    qry.First;
                    while not qry.Eof do begin
                      CreatePayrollServiceForEmployee(qryDestEmployee.FieldByName('EmployeeId').AsInteger,
                        qry.FieldByName('PartID').AsInteger, qry.FieldByName('Rate').AsFloat, True, qry.FieldByName('ServiceName').AsString);
                      qry.Next;
                    end;
                  end;
                  qryDestEmployee.Next;
                end;
              finally
                qryDestEmployee.GotoBookmark(bm);
                qryDestEmployee.FreeBookmark(bm);
              end;
            end;
          finally
            FreeAndNil(qry);
          end;
        end;
      end;
    end else if chkUpdate.Checked then begin
      qry     := TERPQuery.Create(nil);
      qryPart := TERPQuery.Create(nil);
      try
        qry.Options.FlatBuffers := True;
        qryPart.Options.FlatBuffers := True;
        qry.Connection := DbConnection;
        qryPart.Connection := DbConnection;
        qry.SQL.Text := 'SELECT * FROM tblpaysemployeeservices';
        if chkThisEmployee.Checked then qry.SQL.Add('WHERE EmployeeId = ' + qryDestEmployee.FieldByName('EmployeeId').AsString);
        qry.Open;
        while not qry.Eof do begin
          qryPart.SQL.Text := 'SELECT Price1 FROM tblParts WHERE PartsID = ' + qry.FieldByName('PartId').AsString;
          qryPart.Open;
          if not qryPart.IsEmpty then begin
            qry.Edit;
            qry.FieldByName('Rate').AsFloat := GetAmountInc(qryPart.FieldByName('Price1').AsFloat,
              GetTaxRate(GetProductTaxCode(qry.FieldByName('PartID').AsInteger)));
            qry.Post;
          end;
          qryPart.Close;
          qry.Next;
        end;
      finally
        FreeAndNil(qry);
        FreeAndNil(qryPart);
      end;
    end;
    Notify(false);
    Close;
  finally
    EnableForm;
  end;   
end;

procedure TfmPayrollServicesCreate.ExpressPartsOnSelect(Sender: TwwDbGrid);
var
  x: integer;
begin
  if Sender.SelectedList.Count > 0 then begin
    // user has selected a range of products (stored in grids selectedList)
    for x := 0 to Sender.SelectedList.Count - 1 do begin
      Sender.DataSource.DataSet.GotoBookmark(Sender.SelectedList[x]);
      if chkAllEmployees.Checked then CreatePayrollServiceForEmployee(0,
          Sender.DataSource.DataSet.FieldByName('PartsID').AsInteger,0,false)
      else if chkThisEmployee.Checked then CreatePayrollServiceForEmployee(qryDestEmployee.FieldByName('EmployeeId').AsInteger,
          Sender.DataSource.DataSet.FieldByName('PartsID').AsInteger,0,false);
    end;
  end else begin
    // user has selected single product (record that grid dataset is currently on)
    if chkAllEmployees.Checked then CreatePayrollServiceForEmployee(0,
        Sender.DataSource.DataSet.FieldByName('PartsID').AsInteger,0,false)
    else if chkThisEmployee.Checked then CreatePayrollServiceForEmployee(qryDestEmployee.FieldByName('EmployeeId').AsInteger,
        Sender.DataSource.DataSet.FieldByName('PartsID').AsInteger,0,false);
  end;
end;

procedure TfmPayrollServicesCreate.CreatePayrollServiceForEmployee(const EmployeeId, ProductId: integer; Const SourceRate: Double; Const UseSourceRate: boolean = false; Const aServiceName: string = '');
var
  qry: TERPQuery;
  bm: TBookmark;
  Product: TProduct;

  procedure CreateRecord(const aEmployeeID: integer);
  Var
    Rate : double;
    qryDestEmployeeSerices:TERPQuery;
    ServiceName: string;    
  begin
    Product.LoadSelect('PartsID = ' + IntToStr(ProductId));
    //don't add a duplicate record
    qryDestEmployeeSerices := TERPQuery.create(nil);
    try
      with qryDestEmployeeSerices do begin
        Connection := DbConnection;
        SQL.Clear;
        SQL.Add('SELECT * FROM tblpaysemployeeservices WHERE EmployeeId = ' + IntToStr(EmployeeId));
        Open;
        if Locate('PartName', Product.ProductName , [loCaseInsensitive]) then exit ;
      end;
    finally
      FreeAndNil(qryDestEmployeeSerices);
    end;
    
    if UseSourceRate then begin
      Rate := SourceRate;
    end
    else begin
      Rate := Round(Product.SellQty1Price * (1 + Product.TaxSales.Rate),CurrencyRoundPlaces);
    end;

    // Default to product name if service name not provided
    if aServiceName <> '' then
      ServiceName:= aServiceName
    else
      ServiceName:= Product.ProductName;

    qry.SQL.Text :=
      'INSERT HIGH_PRIORITY INTO tblpaysemployeeservices ('+
      ' EmployeeId,' +
      ' ServiceName,'+
      ' PartId,'+
      ' PartName,'+
      ' PartDescription,'+
      ' Rate)' +
      ' VALUES(' +
      IntToStr(aEmployeeId) + ', ' +
      QuotedStr(ServiceName) + ', '+
      IntToStr(ProductID) + ', ' +
      QuotedStr(Product.ProductName) + ', '+
      QuotedStr(Product.SalesDescription) + ', '+
      FloatToStr(Rate) + ')';
    try
      qry.Execute;
    except
      // don't raise exceptioms on duplicates
    end;
  end;

begin
  qry := TERPQuery.Create(nil);
  Product:= TProduct.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := self.DbConnection;
    if EmployeeID > 0 then begin
      CreateRecord(EmployeeID);
    end else begin
      bm := qryDestEmployee.GetBookmark;
      try
        qryDestEmployee.First;
        while not qryDestEmployee.Eof do begin
          CreateRecord(qryDestEmployee.FieldByName('EmployeeId').AsInteger);
          qryDestEmployee.Next;
        end;
      finally
        qryDestEmployee.GotoBookmark(bm);
        qryDestEmployee.FreeBookmark(bm);
      end;
    end;
  finally
    FreeAndNil(qry);
    FreeAndNil(Product);
  end;
end;

procedure TfmPayrollServicesCreate.chkCreateNewClick(Sender: TObject);
begin
  inherited;
  chkUpdate.Checked := not TCheckBox(Sender).Checked;
  chkFromEmployee.Enabled := chkCreateNew.Checked;
  cboTemplateEmployee.Enabled := chkCreateNew.Checked;
  chkFromProducts.Enabled := chkCreateNew.Checked;
  lblCopyFromEmployee.Enabled := chkCreateNew.Checked;
  lblCreateFromParts.Enabled := chkCreateNew.Checked;
end;

procedure TfmPayrollServicesCreate.chkUpdateClick(Sender: TObject);
begin
  inherited;
  chkCreateNew.Checked := not TCheckBox(Sender).Checked;
  chkFromEmployee.Enabled := chkCreateNew.Checked;
  cboTemplateEmployee.Enabled := chkCreateNew.Checked;
  chkFromProducts.Enabled := chkCreateNew.Checked;
  lblCopyFromEmployee.Enabled := chkCreateNew.Checked;
  lblCreateFromParts.Enabled := chkCreateNew.Checked;
end;

Initialization
  RegisterClassOnce(TfmPayrollServicesCreate);

end.
