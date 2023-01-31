unit frmProdAttribmatrix;

interface

Uses TypesLib,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, DNMSpeedButton, DNMPanel,
  StdCtrls, Shader, Buttons, Wwdbigrd, kbmMemTable, Wwdbgrid, Grids,
  BaseGrid, AdvGrid, BusobjProdAttribGroup, busobjPQA, BusObjBase,
  MemDS, ComCtrls, wwdblook, DBCtrls, GradientLabel, ImgList, frmProdAttribMatrixBase,
  AdvObj, ProgressDialog;

type
  TformMode = (fmnone,fmsingleQty, fmTrans, fmInstocklist);

  TfmProdAttribmatrix = class(TfmProdAttribMatrixBase)
    pnlButtons: TDNMPanel;
    btnCreate: TDNMSpeedButton;
    btncancel: TDNMSpeedButton;
    Label1: TLabel;
    lblTotal: TLabel;
    Shape1: TShape;
    Label2: TLabel;
    Shape2: TShape;
    lblTotalQty: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure grdMatrixCellChanging(Sender: TObject; OldRow, OldCol,
      NewRow, NewCol: Integer; var Allow: Boolean);
    procedure grdSelectionButtonClick(Sender: TObject);
    procedure grdMatrixExit(Sender: TObject);
    procedure btncancelClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure FormShow(Sender: TObject); overload;
    procedure FormPaint(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject);
    procedure grdMatrixCellsChanged(Sender: TObject; R: TRect);
    procedure grdMatrixEnter(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure qryToBeCreatedAfterPost(DataSet: TDataSet);
    procedure qryToBeCreatedAfterOpen(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    fTransLine      : TProdQty;
    fCreatetransrec : TGeneralComponentProc;
    ClassId         : Integer;
    fformMode       : TformMode;
    xCol , xRow:Integer;
    fbformShown :boolean;
    Procedure RefreshAll;
    Procedure RefreshCurrentrecord;
    Procedure Refreshcombos;
    procedure SetTransLine(const Value: TProdQty);
    procedure InitcurPos;
    procedure CalcTotal;
    { Private declarations }
  Protected
    Function EnableLookups:Boolean ;Override;
    procedure comboCloseUP(Sender: TObject); override;
    function CurrentRecord(c,r:Integer) :String;Override;
    Procedure InitForm; override;
    Procedure RefreshDetails; override;

  public
    Property TransLine     :TProdQty  Read fTransline       Write SetTransLine;
    Property formMode      :TformMode REad fformMode        Write fformMode;
    Property Createtransrec:TGeneralComponentProc REad fCreatetransrec Write fCreatetransrec;
    class Procedure DoproductAttribute(const AOwner:TBaseInputGUI; const Lineobj: TProdQty;const groupID:Integer; const singleRec :Boolean = False; aDelayObj: TObject = nil); overload;
    class Procedure DoproductAttribute(const AOwner:TBaseInputGUI; const groupID:Integer; const fCreatetransrec :TGeneralComponentProc; aDelayObj: TObject = nil);Overload;
    function OnTabchange:Boolean;
    Procedure SetupGrid;Override;
    procedure FormShow;overload;override;
  end;

  TDelayDoProductMatrix = class
  private
    procedure DoOnTimer(Sender: TObject);
  public
    fTimer: TTimer;
    fOwner: TBaseInputGUI;
    fLineObj: TProdQty;
    fGroupID: integer;
    fSingleRec: boolean;
    fCreateTransRec: TGeneralComponentProc;
    constructor Create;
    destructor Destroy; override;
    class Procedure DoProductAttribute(const AOwner: TBaseInputGUI; const LineObj: TProdQty; const GroupID: Integer; const SingleRec: Boolean = False); overload;
    class Procedure DoProductAttribute(const AOwner: TBaseInputGUI; const GroupID: Integer; const aCreateTransRec: TGeneralComponentProc); Overload;
  end;


implementation

uses pqalib,CommonDbLib, frmProdAttribMain, ProductAttributeLib, FastFuncs,
  CommonLib,  tcConst, BaseTransForm, ProductQtyLib, AppEnvironment,
  BusObjStock;

{$R *.dfm}

{ TfmProdAttribmatrix }




procedure TfmProdAttribmatrix.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//
end;

procedure TfmProdAttribmatrix.FormCreate(Sender: TObject);
begin
  inherited;
  fbformShown :=False;
  formMode        := fmnone;
  fCreatetransrec := nil;
  fTransLine      := nil;
  ClassId         := 0;
end;

procedure TfmProdAttribmatrix.FormDestroy(Sender: TObject);
begin
  inherited;
//
end;

class procedure TfmProdAttribmatrix.DoproductAttribute(const AOwner:TBaseInputGUI;
  const Lineobj: TProdQty; const groupID:Integer;
  const singleRec :Boolean = False; aDelayObj: TObject = nil);
var
  Matrixform :TfmProdAttribmatrix;
begin
  Matrixform              := TfmProdAttribmatrix.Create(AOwner);
  try
    Matrixform.TransLine    := LineObj;
    if singleRec then Matrixform.formMode := fmsingleQty else Matrixform.formMode := fmTrans;
    Matrixform.AttribGroupID:= groupID;
    Matrixform.Showmodal;
  finally
//      FreeandNil(Matrixform);
    MatrixForm.Free;
    aDelayObj.Free;
  end;
end;

procedure TfmProdAttribmatrix.grdMatrixCellChanging(Sender: TObject;OldRow, OldCol, NewRow, NewCol: Integer; var Allow: Boolean);
var
  strSQL:String;
  Qty :Double;
  fid:Integer;
begin
  inherited;
  if not(fbformShown) then exit;
  strSQL := currentrecord(xCol, xRow);
  Qty := NumericCellValue(xCol, xRow);
  fid :=0;
  if (formMode = fmsingleQty) and (Qty = 0) then Exit;
  if strSQL <> '' then begin
    qryToBeCreated.disablecontrols;
    try
      qryToBeCreated.filterSQL := strSQL;
      if qryToBeCreated.recordcount > 0 then begin
        editDB(qryToBeCreated);
        qryToBeCreated.fieldbyname('Qty').asFloat :=  Qty;
        postDB(qryToBeCreated);
        fid := qryToBeCreated.fieldByname('AutoID').asInteger;
      end;
      qryToBeCreated.filterSQL :='Qty <> 0';
      if (formMode = fmsingleQty) and (qryToBeCreated.recordcount> 1) then begin
        qryToBeCreated.first;
        While qryToBeCreated.eof = False do begin
          if fid <>  qryToBeCreated.fieldByname('AutoID').asInteger then
            grdSelectionButtonClick(grdSelectionButton);
          qryToBeCreated.Next;
        end;
        qryToBeCreated.Refresh;
      end;
    finally
      qryToBeCreated.enablecontrols;
    end;
  end;
end;



procedure TfmProdAttribmatrix.grdMatrixCellsChanged(Sender: TObject; R: TRect);
begin
  inherited;
  initCurPos;
end;
Procedure TfmProdAttribmatrix.InitcurPos;
begin
  xCol:=grdMatrix.col;
  xRow:=grdMatrix.Row;
end;
procedure TfmProdAttribmatrix.RefreshAll;
var
  strSQL:String;
  c, r:Integer;
  function IsCellreadonly:Boolean ; begin
    if qryToBeCreated.recordcount > 0 then
      result := qryToBeCreated.fieldbyname('ProductActive').asBoolean=False
    else if formMode <> fmInstocklist then result := True
    else result := true;
  end;
  Procedure ReadonlyCell ; begin
      //grdMatrix.CellProperties[c,r].BrushColor := clInactiveCaption;
      grdMatrix.Cells[c,r] :='X';
      grdMatrix.CellProperties[c,r].BrushColorTo:= clBtnFace;
      grdMatrix.CellProperties[c,r].FontColor  := clRed;
      grdMatrix.CellProperties[c,r].FontSize   := 12;
      grdMatrix.CellProperties[c,r].FontStyle  := grdMatrix.CellProperties[c,r].FontStyle +[fsBold]	;
      grdMatrix.CellProperties[c,r].alignment  := taCenter;
  end;

  Procedure EditableCell ; begin
      //grdMatrix.CellProperties[c,r].BrushColor := clInactiveCaption;
      (*grdMatrix.Cells[c,r] :='X';*)
      grdMatrix.CellProperties[c,r].BrushColorTo:= clWhite;
      grdMatrix.CellProperties[c,r].FontColor  := clBlack;
      grdMatrix.CellProperties[c,r].FontSize   := 10;
      grdMatrix.CellProperties[c,r].FontStyle  := grdMatrix.CellProperties[c,r].FontStyle -[fsBold]	;
      grdMatrix.CellProperties[c,r].alignment  := taRightJustify;
  end;
begin
  qryToBeCreated.Disablecontrols;
  try
    strSQL:=qryToBeCreated.FilterSQL ;
    try
      qryToBeCreated.FilterSQL := '';
      for c := 1 to grdMatrix.ColCount-1 do begin
          for r := 1 to grdMatrix.RowCount-1 do begin
            qryToBeCreated.FilterSQL := currentrecord(c,r);
            grdMatrix.CellProperties[c,r].ReadOnly := IsCellreadonly;
            if IsCellreadonly then
              ReadonlyCell
            else begin
              EditableCell;
              if (qryToBeCreated.recordcount <> 0) and (qryToBeCreated.fieldbyname('ProductActive').asBoolean) then
                grdMatrix.Cells[c,r] :=floattoStr(qryToBeCreated.fieldByname('Qty').asFloat)
              else if (qryToBeCreated.fieldbyname('ProductActive').asBoolean) or (formMode = fmInstocklist) then  grdMatrix.Cells[c,r] :='0' else grdMatrix.Cells[c,r] :='';
            end;
          end;
      end;
    finally
        qryToBeCreated.FilterSQL := strSQL;
    end;
  finally
    qryToBeCreated.EnableControls;
  end;
end;



procedure TfmProdAttribmatrix.grdSelectionButtonClick(Sender: TObject);
begin
  inherited;
  EditDB(qryToBeCreated);
  qryToBeCreated.FieldByName('Qty').asFloat := 0;
  RefreshCurrentrecord;
  PostDB(qryToBeCreated);
  qryToBeCreated.RefreshRecord;
end;

procedure TfmProdAttribmatrix.RefreshCurrentrecord;
var
  i:Integer;
  cmp:TComponent;
  c, r:Integer;
begin
  for i := 0 to comboList.Count-1 do begin
    cmp:= FindComponent(StringReplace(comboList[i].name, 'Attribcombo' , 'Attriblabel' , [rfIgnoreCase]));
    if assigned(cmp) then
      if qryToBeCreated.fieldByname(TLabel(cmp).caption).asString <> TComboBox(comboList[i]).text then Exit;
  end;
  if YAttributeName = '' then
    c:= 1
  else
    for c := 1 to grdMatrix.ColCount-1 do
      if Sysutils.SameText(grdMatrix.Cells[c,0] , qryToBeCreated.fieldByname(YAttributeName).asSTring) then break;
  if XAttributeName = '' then
    r := 1
  else
    for r := 1 to grdMatrix.rowCount-1 do
      if Sysutils.SameText(grdMatrix.Cells[0,r] , qryToBeCreated.fieldByname(xAttributeName).asSTring) then break;
  if (c < grdMatrix.ColCount) and (r < grdMatrix.rowcount) then
     grdMatrix.Cells[c,r] := qryToBeCreated.FieldByname('Qty').asString;
end;

procedure TfmProdAttribmatrix.grdMatrixEnter(Sender: TObject);
begin
  inherited;
  InitcurPos;
end;

procedure TfmProdAttribmatrix.grdMatrixExit(Sender: TObject);
var
  Allow:Boolean;
begin
  inherited;
  Allow := True;
  if (grdMatrix.Rowcount >1) and   (grdMatrix.colcount > 1) then
    grdMatrixCellChanging(sender , grdMatrix.Row,grdMatrix.col , grdMatrix.row, grdMatrix.col , Allow);
end;

procedure TfmProdAttribmatrix.btncancelClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmProdAttribmatrix.btnCreateClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if screen.ActiveControl <> btnCreate then SetControlFocus(btnCreate);
    if not(Assigned(fTransLine)) then begin
      if Assigned(fCreatetransrec ) then fCreatetransrec(Self);
      exit;
    end;
    if qryToBeCreated.recordcount = 0 then exit;
    if (formMode = fmsingleQty) and (qryToBeCreated.fieldByname('ProductName').asString =  fTransLine.ProductName) then begin
      fTransLine.UnitOfMeasure := AppEnv.DefaultClass.DefaultUOM;
      fTransLine.UOMOrderQty :=qryToBeCreated.fieldByname('Qty').asFloat;
      fTransLine.PostDB;
      Exit;
    end;

    { need to delete this line as it was only used to trigger the template }
    fTransLine.Active := False;
    //fTransLine.Delete;
    fTransLine.PostDB;
    qryToBeCreated.first;

    ProgressBar.Max := qryToBeCreated.RecordCount;
    ProgressBar.Min := 1;
    ProgressBar.visible := True;
    try
      while qryToBeCreated.Eof = false do begin
        fTransLine.New;
        fTransLine.ProductName  := qryToBeCreated.fieldByname('ProductName').asString;
        fTransLine.OrderQty:= qryToBeCreated.fieldByname('Qty').asFloat;
        fTransLine.PostDB;
        qryToBeCreated.next;
        ProgressBar.StepIt;
      end;
    finally
        ProgressBar.visible := false;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmProdAttribmatrix.SetTransLine(const Value: TProdQty);
begin
  fTransline := Value;
  qryToBeCreated.connection := Value.connection.connection;
end;

procedure TfmProdAttribmatrix.FormShow(Sender: TObject);
begin
    inherited;
    fbformShown:= True;
end;

procedure TfmProdAttribmatrix.FormShow;
begin
  if assigned(TransLine) then
    Tablename := CommonDbLib.CreateUserTemporaryTable('tmp_productmatrix', 'Matrix','',nil,TERPConnection(TransLine.Connection.Connection))
  else        // when calle from frmProdAttribMain - TransLine does not exists
    Tablename := CommonDbLib.CreateUserTemporaryTable('tmp_productmatrix', 'Matrix');
  inherited;
end;

procedure TfmProdAttribmatrix.FormPaint(Sender: TObject);
begin
  inherited;
(*  TShader(findcomponent('TitleShader')).FromColor := Self.Color;
  TShader(findcomponent('TitleShader')).ToColorMirror := Self.Color;*)
end;

procedure TfmProdAttribmatrix.FormResize(Sender: TObject);
begin
  inherited;
  pnlProducts.Align:= alNone;
  pnlProducts.Height:= Trunc((ClientHeight - pnlCaption.Height - pnlButtons.Height) / 3);
  pnlProducts.Align:= alBottom;
end;

procedure TfmProdAttribmatrix.Refreshcombos;
var
  i:Integer;
  cmp:TComponent;
begin
  for i := 0 to comboList.Count-1 do begin
    cmp:= FindComponent(StringReplace(comboList[i].name, 'Attribcombo' , 'Attriblabel' , [rfIgnoreCase]));
    if assigned(cmp) then
      if qryToBeCreated.fieldByname(TLabel(cmp).caption).asString <> TComboBox(comboList[i]).text then
        TComboBox(comboList[i]).text := qryToBeCreated.fieldByname(TLabel(cmp).caption).asString;
  end;
end;

class procedure TfmProdAttribmatrix.DoproductAttribute(const AOwner: TBaseInputGUI;
  const groupID: Integer;
  const fCreatetransrec: TGeneralComponentProc; aDelayObj: TObject = nil);
var
  Matrixform :TfmProdAttribmatrix;
begin
  Matrixform              := TfmProdAttribmatrix.Create(AOwner);
  try
    Matrixform.Createtransrec    := fCreatetransrec;
    Matrixform.AttribGroupID     := groupID;
    Matrixform.formMode          := fmTrans;
    Matrixform.Showmodal;
  finally
      FreeandNil(Matrixform);
      aDelayObj.Free;
  end;

end;

function TfmProdAttribmatrix.OnTabchange: Boolean;
begin
  REsult := True;
  if qryToBeCreated.state in [dsEdit,dsInsert] then qryToBeCreated.Cancel;
  if qryToBeCreated.active then qryToBeCreated.close;
end;

procedure TfmProdAttribmatrix.qryToBeCreatedAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CalcTotal;
end;
procedure TfmProdAttribmatrix.CalcTotal;
begin
  lblTotal.Caption :=  inttostr(qryToBeCreated.RecordCount);
  with TempMyQuery(TERPConnection(qryToBeCreated.Connection)) do try
    SQL.Add('Select sum(Qty) as Qty from ' +tablename);
    open;
    lbltotalQty.Caption := floattoStrf(fieldbyname('Qty').AsFloat , ffGeneral, 15, 2);
  finally
    closenFree;
  end;
end;

procedure TfmProdAttribmatrix.qryToBeCreatedAfterPost(DataSet: TDataSet);
begin
  inherited;
  CalcTotal;
end;

procedure TfmProdAttribmatrix.SetupGrid;
begin
  ButtonTop := cButtonTopStart;
  formMode := fmInstocklist;
  lblclass.visible  := true;
  cboClass.visible  := true;
  blClass.visible   := true;
  lblclass.Left     := cButtonLeft;
  cboClass.Left     := cButtonLeft;
  lblClass.top      := ButtonTop;
  cboClass.Top      := ButtonTop+16;
  ButtonTop         := ButtonTop+60;

  if not(QryClasses.Active) then QryClasses.open;
  cboClass.items.Clear;
  if QryClasses.recordcount >0 then begin
      QryClasses.First;
      while QryClasses.Eof = false do begin
        cboClass.Items.Add(QryClasses.fieldByname('className').asString);
        QryClasses.Next;
      end;
      if QryClasses.Locate('classId' , Appenv.DefaultClass.ClassId , []) then
        cboClass.ItemIndex := QryClasses.recno -1
      else cboClass.ItemIndex := 0;
      ClassId := QryClasses.fieldByname('ClassId').asInteger;
  end;
  inherited;
end;

procedure TfmProdAttribmatrix.cboClassCloseUp(Sender: TObject);
begin
  inherited;
  if QryClasses.Locate('ClassName' , cboClass.Text , []) then
    classId := QryClasses.fieldByname('ClassId').asInteger else classid := 0;
  ButtonTop         := cButtonTopStart+60;
  FormShow(Self);
end;

function TfmProdAttribmatrix.EnableLookups: Boolean;
begin
  REsult := (comboList.Count <> 0) or (classId <> 0);
end;

procedure TfmProdAttribmatrix.comboCloseUP(Sender: TObject);
begin
  inherited;
  RefreshAll;
end;

function TfmProdAttribmatrix.CurrentRecord(c, r: Integer): String;
begin
  REsult := inherited CurrentRecord(c, r);
  if formMode = fmInstocklist then begin
    if Result <> '' then Result := Result +' and ';
    Result := Result + '( DepartmentID = ' + IntToStr(ClassId) +' or  ifnull(DepartmentID,0) =0)';
  end;

end;

procedure TfmProdAttribmatrix.Initform;
var
    Qtyfield :STring;
begin
  inherited;
  Qtyfield := 'Qtysold';
  if (Assigned(TransLine)) and (TransLine.classnameis('TRefundSaleLine')) then Qtyfield := 'RefundQty';
  if (formMode = fmsingleQty) and Assigned(TransLine)  then
    StrinGList.Add('insert into  ' + tablename +
                    ' (ProductID , ProductName , DepartmentID , Qty)'+
                    ' SELECT Distinct pap.ProductID,pap.ProductName,' + IntToStr(TransLine.ClassID) +', sl.' + Qtyfield + ' as Qty   '+
                    ' from tblproductattributeproducts pap '+
                    ' Left join ' + fTransLine.GetBusObjectTablename +
                    ' sl on sl.ProductId = pap.productID  '+
                    ' and  sl.' +fTransLine.idfieldname + '  = ' + IntToStr(fTransLine.ID) +
                    ' and pap.productID = ' + IntToStr(fTransLine.ProductID) +';')
  else   if formMode = fmtrans then begin
    StrinGList.Add('insert into ' + tablename + ' (ProductID , ProductName ,DepartmentID, Qty)' +
            ' SELECT distinct ProductID,ProductName, 0, 0 as Qty '+
            ' from tblproductattributeproducts '+
            ' where PAG_ID = ' + IntToStr(AttributeGroups.ID) +
            ' order by productName ;');
  end else if formmode = fminstocklist then begin
    StrinGList.Add('insert into ' + tablename + ' (ProductID , ProductName ,DepartmentID, Qty)' +
            ' SELECT P.PartsID,P.PartName, PQA.departmentID, '+ SQL4Qty(tinstock)  +
            ' From ' +  ProductTables(tProductList) +
            ' where P.PartsId in (Select ProductId from tblproductattributeproducts PaP  where   PaP.PAG_ID =' + IntToStr(AttributeGroups.ID) +' )' +
            ' group by P.PartsID,P.PartName ' +
            ' order by P.PartName;');

    grdMatrix.Options := grdMatrix.options - [goediting];
    if Subform.Parent is TDnMPanel then begin
         subform.Height :=TDnMPanel(Subform.Parent).Height;
         subform.Width :=TDnMPanel(Subform.Parent).width;
    end;
  end;
end;

procedure TfmProdAttribmatrix.RefreshDetails;
begin
  inherited;
  if (formMode = fmsingleQty) then REfreshCombos;
  RefreshAll;

end;


{ TDelayDoProductMatrix }

constructor TDelayDoProductMatrix.Create;
begin
  fOwner := nil;
  fLineObj := nil;
  fGroupID := 0;
  fSingleRec := false;
  fCreateTransRec := nil;
  fTimer := TTimer.Create(nil);
  fTimer.Enabled := false;
  fTimer.Interval := 100;
  fTimer.OnTimer := DoOnTimer;
end;

destructor TDelayDoProductMatrix.Destroy;
begin

  inherited;
end;

procedure TDelayDoProductMatrix.DoOnTimer(Sender: TObject);
begin
  fTimer.Enabled := false;
  if Assigned(fLineObj) then
    TfmProdAttribmatrix.DoproductAttribute(fOwner,fLineObj,fGroupID,fSingleRec)
  else
    TfmProdAttribmatrix.DoproductAttribute(fOwner,fGroupID,fCreateTransRec);
end;

class procedure TDelayDoProductMatrix.DoProductAttribute(
  const AOwner: TBaseInputGUI; const LineObj: TProdQty; const GroupID: Integer;
  const SingleRec: Boolean);
var
  inst: TDelayDoProductMatrix;
begin
  inst := TDelayDoProductMatrix.Create;
  inst.fOwner := aOwner;
  inst.fLineObj := LineObj;
  inst.fGroupID := GroupID;
  inst.fSingleRec := SingleRec;
  inst.fTimer.Enabled := true;
end;

class procedure TDelayDoProductMatrix.DoProductAttribute(
  const AOwner: TBaseInputGUI; const GroupID: Integer;
  const aCreateTransRec: TGeneralComponentProc);
var
  inst: TDelayDoProductMatrix;
begin
  inst := TDelayDoProductMatrix.Create;
  inst.fOwner := aOwner;
  inst.fGroupID := GroupID;
  inst.fCreateTransRec := aCreateTransRec;
  inst.fTimer.Enabled := true;
end;

initialization
  RegisterClassOnce(TfmProdAttribmatrix);

end.



