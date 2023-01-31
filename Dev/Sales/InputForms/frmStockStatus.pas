unit frmStockStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, StdCtrls,
  wwclearbuttongroup, wwradiogroup, Grids, Wwdbigrd, Wwdbgrid,
  DNMSpeedButton, ExtCtrls, DNMPanel, Shader, DAScript, ComCtrls, MyScript,
  GuiPrefsObj, Menus, SelectionDialog  , BusobjCrossStockCompanies, ProductQtyinCrossStockCompanies , FrmClassLookup;

type
  TfmStockStatus = class(TBaseForm)
    qrymain: TERPQuery;
    dsmain: TDataSource;
    qrymainID: TIntegerField;
    qrymainclassId: TIntegerField;
    qrymainDefaultStockClassID: TIntegerField;
    qrymainOtherClassId: TIntegerField;
    qrymainSaleID: TIntegerField;
    qrymainsaleLineId: TIntegerField;
    qrymainProductId: TIntegerField;
    qrymainProductname: TWideStringField;
    qrymainOtherClassname: TWideStringField;
    qrymainSold: TFloatField;
    qrymainUOMsold: TFloatField;
    qrymainShipped: TFloatField;
    qrymainUOMShipped: TFloatField;
    qrymainBackOrder: TFloatField;
    qrymainUOMBackOrder: TFloatField;
    qrymainUOM: TWideStringField;
    qrymainsUOM: TWideStringField;
    qrymainUOMID: TIntegerField;
    qrymainUOMMultiplier: TFloatField;
    qrymainAvailableStock: TFloatField;
    qrymainoAvailableStock: TFloatField;
    qrymainUOMAvailableStock: TFloatField;
    qrymainoUOMAvailableStock: TFloatField;
    qrymainEnoughStock: TWideStringField;
    qrymainDoCrosscheckCompanies: TWideStringField;
    qrymainDocheckDepartments: TWideStringField;
    qrymainAssociatedPOsReceived: TWideStringField;
    qrymainShipmentOption: TWideStringField;
    DNMPanel1: TDNMPanel;
    qrymaincalcAssociatedPOsReceived: TWideStringField;
    qrymaincalcEnoughStock: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qrymainReceived: TFloatField;
    qrymainETA: TDateTimeField;
    qrymainPurchaseOrderID: TIntegerField;
    qrymainBaseLineno: TIntegerField;
    qrymainOriginalQty: TFloatField;
    pnlPanles: TDNMPanel;
    DNMPanel3: TDNMPanel;
    DNMPanel4: TDNMPanel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    grdMain: TwwDBGrid;
    Label4: TLabel;
    pnl3: TDNMPanel;
    DNMSpeedButton1: TDNMSpeedButton;
    chkDoCrosscheckCompanies: TCheckBox;
    pnlDepts: TDNMPanel;
    pnl1: TDNMPanel;
    pnlQtyoptions: TDNMPanel;
    DNMPanel7: TDNMPanel;
    ReceiveOption4: TRadioButton;
    ReceiveOption2: TRadioButton;
    DNMPanel8: TDNMPanel;
    ReceiveOption3: TRadioButton;
    ReceiveOption1: TRadioButton;
    pnlCrossStock: TDNMPanel;
    lblOthercompanies: TLabel;
    splBottom1: TSplitter;
    DNMPanel2: TDNMPanel;
    chkShowDetails: TCheckBox;
    chkShowcompanyStock: TCheckBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    chkDocheckDepartments: TCheckBox;
    qrymainQtyRequired: TFloatField;
    qrymainReceivedtoUse: TFloatField;
    qrymainoUOMAvailableStocktoUse: TFloatField;
    qrymainUOMAvailableStocktoUse: TFloatField;
    MyScript1: TERPScript;
    lblDate: TLabel;
    edtdate: TEdit;
    btnHowTo: TDNMSpeedButton;
    chkuseDefaultStockClassID: TCheckBox;


    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure qrymainCalcFields(DataSet: TDataSet);
    procedure ReceiveOption1Click(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure qrymainAfterOpen(DataSet: TDataSet);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkShowDetailsClick(Sender: TObject);
    procedure chkShowcompanyStockClick(Sender: TObject);
    procedure ocateproduct(DataSet: TDataSet);
    function ScriptMain :TERPScript;
    procedure MyScript1Error(Sender: TObject; E: Exception; SQL: string;
      var Action: TErrorAction);
    procedure btnHowToClick(Sender: TObject);
    procedure qrymainBeforeOpen(DataSet: TDataSet);
    procedure chkuseDefaultStockClassIDClick(Sender: TObject);
  private
    fiSaleId: Integer;
    fsTablename :String;
    tmptablename:String;
    fconnection: TERPConnection;
    fProgressBar: TProgressBar;
    GuiPrefs: TFormGuiPrefs;
    css: TProductQtyinCrossStockCompaniesGUI;
    fdSaleDate: TDatetime;
    ClassLookupform :TFmClassLookup;
    fiStockFromOtherClassId:Integer;
    Procedure MakeQry;
    procedure ReadnApplyGuiPrefExtra;
    Procedure WriteGuiPrefExtra;
    procedure DeletenReInitPref;
    procedure GridFields;
    procedure beforeShowcss(Sender: TObject);
    procedure MakeCrossStockList;
    Procedure OncssRecordChange(sender:TObject);
    Procedure OncssREfreshQuery(cc:TCrossStockCompanies; cssTablename:String);
    procedure CalcQtytoUse;
    procedure SetSaleDate(const Value: TDatetime);
    Procedure InitClassLookup;
    procedure OnClassSelection(DataSet: TObject);
    Function ClassStockField(aClassID:Integer):String;
    Function IsClassField(aFieldname:String;aClassID:Integer):Boolean;

    { Private declarations }
  public
    Property SaleId :Integer read fiSaleId Write fiSaleId;
    Property SaleDate :TDatetime read fdSaleDate write SetSaleDate;
    Property Connection :TERPConnection Read fconnection write fconnection;
    Property ProgressBar: TProgressBar read fProgressBar write fProgressBar;
    Property StockFromOtherClassId :Integer read fiStockFromOtherClassId;
  end;

implementation

uses pqalib, CommonLib, FastFuncs, CommonDbLib, ProductQtyLib, BaseInputForm,
   tcDataUtils, AppEnvironment, tcConst, CommonFormLib, BusObjPreference,
  ProgressDialog, LogLib,dateutils, MySQLConst, DocReaderObj,
  DbSharedObjectsObj;

{$R *.dfm}

procedure TfmStockStatus.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  WriteGuiPrefExtra;
  GuiPrefs.SavePrefs;
end;

procedure TfmStockStatus.FormCreate(Sender: TObject);
begin
  inherited;
  css := nil;
  GuiPrefs := TFormGuiPrefs.Create(Self);
  SaleId := 0;
  fProgressBar := nil;
  lbl1.Caption := '1: Use Stock From Current ' + Appenv.DefaultClass.ClassHeading;
  lbl2.Caption := '2: Use Stock From Other ' + Appenv.DefaultClass.ClassHeading;
  Showcontrolhint(ReceiveOption1 , 'Required Stock will be Shipped from the Sales '+Appenv.DefaultClass.ClassHeading+'.'+NL+
                                    'This will make the Current Stock to Negative if not Enough Stock Available'+NL);
  Showcontrolhint(ReceiveOption2 , 'Available Stock from the Sales '+Appenv.DefaultClass.ClassHeading+' is used to ship the Required Stock.'+NL+
                                    'This will Assign the Rest to Back Order if not Enough Stock Available'+NL);

  Showcontrolhint(ReceiveOption3 , 'Stock Received from the Current Sale''s Purchase Order is used to ship the Required Stock.'+NL+
                                    'This will Assign the Rest to Back Order if the Sale Doesn''t have Any Purchase Order Or if not enough Stock Received yet'+NL);

  Showcontrolhint(ReceiveOption4 , 'Don''t Use Stock from the Sales '+Appenv.DefaultClass.ClassHeading+NL);

  showcontrolhint(pnlQtyoptions , 'Choose Option to Use Quantity from the Sales ' + Appenv.DefaultClass.ClassHeading+'.'+NL+
                                 ReceiveOption1.caption + ': '+ ReceiveOption1.hint+NL+NL+
                                 ReceiveOption2.caption + ': '+ ReceiveOption2.hint+NL+NL+
                                 ReceiveOption3.caption + ': '+ ReceiveOption3.hint+NL+NL+
                                 ReceiveOption4.caption + ': '+ ReceiveOption4.hint);

  Showcontrolhint(pnlDepts , 'Use Stock from other ' + Appenv.DefaultClass.ClassHeading+'.'+NL+
                            chkuseDefaultStockClassID.caption +' : When checked, If a  ' + Appenv.DefaultClass.ClassHeading+' is Selected as the "Default Stock" in Product Card, Use Stock from it first.'+NL+
                            ' When not checked, use stock based on the  ' + Appenv.DefaultClass.ClassHeading+' Selected.');
end;

procedure TfmStockStatus.FormShow(Sender: TObject);
begin
  inherited;
  ReadnApplyGuiPrefExtra;
  InitClassLookup;
  ReceiveOption1.color := Self.color;
  ReceiveOption2.color := Self.color;
  ReceiveOption3.color := Self.color;
  ReceiveOption4.color := Self.color;
  TitleShader.color := Self.color;
  MakeQry;
  MakeCrossStockList;
end;
Procedure TfmStockStatus.MakeCrossStockList;
begin
  if css = nil then css:= TProductQtyinCrossStockCompaniesGUI(Getcomponentbyclassname('TProductQtyinCrossStockCompaniesGUI' , False , nil , False));
  css.GrdmainForPanel(pnlCrossStock , beforeShowcss);
end;
procedure TfmStockStatus.FormPaint(Sender: TObject);
begin
//  inherited;
{don;t remove it - form color overriden }
end;

procedure TfmStockStatus.grdMainCalcCellColors(Sender: TObject;Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;ABrush: TBrush);
//var
//  ctr:Integer;
begin
  inherited;

  if Sender = grdmain then begin
    
         if sametext(field.fieldname , QrymainUOMAvailableStock.fieldname ) then begin if qrymainUOMAvailableStocktoUse.asfloat >0 then Abrush.color := GridColFontGreen else if QrymainUOMAvailableStock.asfloat <0 then Abrush.color := GridColFontRed else Abrush.color := clWhite;
    end else if sametext(field.fieldname , qrymainoUOMAvailableStock.fieldname) then begin if qrymainoUOMAvailableStocktoUse.asfloat>0 then Abrush.color := GridColFontGreen else if qrymainoUOMAvailableStock.asfloat<0 then Abrush.color := GridColFontRed else Abrush.color := clWhite;
    end else if sametext(field.fieldname , qrymainReceived.fieldname          ) then begin if qrymainReceivedtoUse.asfloat          >0 then Abrush.color := GridColFontGreen else if qrymainReceived.asfloat          <0 then Abrush.color := GridColFontRed  else Abrush.color := clWhite;
    end else if (chkuseDefaultStockClassID.checked) and  (qrymainDefaultStockClassID.asInteger <> 0) and (IsClassField(field.fieldname , qrymainDefaultStockClassID.asInteger)) then begin Abrush.color := GridColFontGreen;
    end else if (fiStockFromOtherClassId <> 0) and (IsClassField(field.fieldname , fiStockFromOtherClassId)) then begin Abrush.color := GridColFontOlive;
    end else if (fiStockFromOtherClassId =  0) and (IsClassField(field.fieldname , 0)) then begin Abrush.color := GridColFontOlive;

    end;

  end else if assigned(css) and (Sender = css.grdmain) then begin
    if sametext(copy(field.fieldname , 1 , 9) , 'Available') then begin
      if Field.asFloat =0 then afont.color := abrush.color
      else if chkDoCrosscheckCompanies.checked then
        if css.qrymain.fieldbyname('touse'+field.fieldname).asFloat >0 then Abrush.color := GridColFontGreen else if css.qrymain.fieldbyname('touse'+field.fieldname).asFloat <0 then Abrush.color := GridColFontRed ;
    end;
  end;

end;
procedure TfmStockStatus.GridFields;
var
  fieldList : TStringList;

  i:Integer;
  qry :TERPQuery;
begin

  try
    Self.Width := 1200 ;//if chkShowDetails.Checked then Self.Width := 1200 else Self.Width := 1080;
    Makeitcentralized;
    i := trunc((pnlPanles.width-90)/4);
    pnl1.width := i;
    pnlDepts.width := i*2;
    pnl3.width := i;

    fieldList := TStringList.create;
    try
      FieldList.Add(SelectedText('Productname'                  ,'Product'                  ,20 ,''         , True ));
      FieldList.Add(SelectedText('sUOM'                         ,'UOM'                      ,10 ,''         , True ));
      if chkShowDetails.Checked then begin
        FieldList.Add(SelectedText('UOMsold'                    ,'Sold'                     ,7  ,'Quantity' , True ));
        FieldList.Add(SelectedText('UOMShipped'                 ,'Shipped'                  ,7  ,'Quantity' , True ));
        FieldList.Add(SelectedText('UOMBackOrder'               ,'BO'                       ,7  ,'Quantity' , True ));
        FieldList.Add(SelectedText('UOM'                        ,'UOM'                      ,7  ,''         , True ));
        FieldList.Add(SelectedText('calcAssociatedPOsReceived'  ,'Assoc POs~Received?'      ,1  ,''         , True ));
        FieldList.Add(SelectedText('ETA'                        ,'ETA'                      ,7 ,''          , True ));
        FieldList.Add(SelectedText('Received'                    ,'Received~Quantity'        ,7  ,''        , True ));
      end;
      FieldList.Add(SelectedText('UOMAvailableStock'           ,SaleclassNAme(saleID)                    ,8   ,'Available Stock in ' + Appenv.DefaultClass.ClassHeading, True ));
      if chkShowDetails.Checked then begin
          qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
          try
            closedb(qry);
            qry.sql.text := 'select classId, classname from tblclass where active ="T"';
            qry.open;
            if qry.recordcount >0 then begin
                  Qry.first;
                  while Qry.eof = false do begin
                    if qry.fieldbyname('classId').asInteger <> SaleclassId(SaleID) then begin

                      if qryMain.findfield(ClassStockField(qry.fieldbyname('classId').asInteger) ) = nil then begin
                        with TFloatField.Create(Self) do begin
                          fieldKind := fkData;
                          fieldname := ClassStockField(qry.fieldbyname('classId').asInteger);
                          name := ComponentName(self, 'Qrymain'+fieldname);
                          DataSet := qryMain;
                          visible := True;
                        end;
                      end;
                      FieldList.Add(SelectedText(ClassStockField(qry.fieldbyname('classId').asInteger),Qry.fieldbyname('classname').asString ,8   ,'Available Stock in ' + Appenv.DefaultClass.ClassHeading, True ));
                    end;
                    qry.next;
                  end;
              end;
         finally
            DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
          end;
      end;

      FieldList.Add(SelectedText('calcEnoughStock'             ,'Enough~Stock?'            ,3   ,''         , True ));
      FieldList.Add(SelectedText('ShipmentOption'              ,'What do you wish to Receive~From ' + SaleclassNAme(saleID) +' ' +Appenv.DefaultClass.ClassHeading,45  ,''         , False));
      FieldList.Add(SelectedText('DocheckDepartments'          ,Appenv.DefaultClass.ClassHeading  ,1   ,'Check Other'         , False));
      FieldList.Add(SelectedText('DoCrosscheckCompanies'       ,'Companies'    ,1   ,'Check Other'         , False));

      logtext(Fieldlist.Text);
      grdMain.Selected := FieldList;
      grdMain.ApplySelected;
    finally
      Freeandnil(fieldList );
    end;
  Except
    on E:Exception do begin
      // kill the exception
    end;
  end;

end;
procedure TfmStockStatus.qrymainAfterOpen(DataSet: TDataSet);
begin
//
end;

procedure TfmStockStatus.qrymainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  GridFields;
end;

procedure TfmStockStatus.ocateproduct(DataSet: TDataSet);
begin
  inherited;
  if Css = nil then exit;
  Css.LocateProduct(Qrymainproductname.AsString);
end;

procedure TfmStockStatus.OncssRecordChange(sender: TObject);
begin
  if sender is TERPQuery then begin
    if TERPQuery(Sender).FindField('ProductName')<> nil then begin
      if QrymainProductname.AsString <>TERPQuery(Sender).FindField('ProductName').AsString then
      Qrymain.Locate('Productname' , TERPQuery(Sender).FindField('ProductName').AsString , []);
    end;
  end;
end;

procedure TfmStockStatus.qrymainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if QrymainEnoughStock.asBoolean then
    QrymaincalcEnoughStock.asString := 'Yes' else QrymaincalcEnoughStock.asString := 'No';
  if qrymainAssociatedPOsReceived.asString = 'T' then
    qrymainCalcAssociatedPOsReceived.asString := 'Yes'
  else if qrymainAssociatedPOsReceived.asString = 'F' then
    qrymainCalcAssociatedPOsReceived.asString := 'No'
  else qrymainCalcAssociatedPOsReceived.asString := 'N/A';
end;

procedure TfmStockStatus.ReadnApplyGuiPrefExtra;
begin
  if not GuiPrefs.Active then
  try
    GuiPrefs.Active:= true;
  Except
    on E:Exception do begin
      DeletenReInitPref;
    end;
  end;
  if GuiPrefs.Node.Exists('Options.ShowDetails')            then chkShowDetails.checked           := GuiPrefs.Node['Options.showDetails'].asBoolean         else chkShowDetails.checked := TRue;
  if GuiPrefs.Node.Exists('Options.pnlCrossStockheight')    then pnlCrossStock.height             := GuiPrefs.Node['Options.pnlCrossStockheight'].asInteger;
  if GuiPrefs.Node.Exists('Options.ShowcompanyStock')       then chkShowcompanyStock.checked      := GuiPrefs.Node['Options.ShowcompanyStock'].asBoolean    else chkShowcompanyStock.checked := TRue;
  if GuiPrefs.Node.Exists('Options.ReceiveOption1')         then ReceiveOption1.Checked           := GuiPrefs.Node['Options.ReceiveOption1'].asBoolean ;
  if GuiPrefs.Node.Exists('Options.ReceiveOption2')         then ReceiveOption2.Checked           := GuiPrefs.Node['Options.ReceiveOption2'].asBoolean ;
  if GuiPrefs.Node.Exists('Options.ReceiveOption3')         then ReceiveOption3.Checked           := GuiPrefs.Node['Options.ReceiveOption3'].asBoolean ;
  if GuiPrefs.Node.Exists('Options.ReceiveOption4')         then ReceiveOption4.Checked           := GuiPrefs.Node['Options.ReceiveOption4'].asBoolean ;
  if GuiPrefs.Node.Exists('Options.DocheckDepartments')     then chkDocheckDepartments.Checked    := GuiPrefs.Node['Options.DocheckDepartments'].asBoolean ;
  if GuiPrefs.Node.Exists('Options.OtherClassId')           then fiStockFromOtherClassId          := GuiPrefs.Node['Options.OtherClassId'].asInteger;
  if GuiPrefs.Node.Exists('Options.DoCrosscheckCompanies')  then chkDoCrosscheckCompanies.Checked := GuiPrefs.Node['Options.DoCrosscheckCompanies'].asBoolean ;
end;
procedure TfmStockStatus.chkShowcompanyStockClick(Sender: TObject);
begin
  inherited;
  pnlCrossStock.visible := chkShowcompanyStock.Checked;
end;

procedure TfmStockStatus.chkShowDetailsClick(Sender: TObject);
begin
  inherited;
  GridFields;

end;

procedure TfmStockStatus.chkuseDefaultStockClassIDClick(Sender: TObject);
begin
  inherited;
  grdMain.repaint;
end;

procedure TfmStockStatus.DeletenReInitPref;
var
  msg: string;
begin
  TPreference.DeleteUserPrefs(AppEnv.Employee.EmployeeID,msg,Connection);
  GuiPrefs.Active := False;
  GuiPrefs.Active := TRue;
end;

procedure TfmStockStatus.ReceiveOption1Click(Sender: TObject);
begin
  inherited;
  if (sender = ReceiveOption1) or (sender = ReceiveOption2) or (sender = ReceiveOption3) or (sender = ReceiveOption4) then begin
    ReceiveOption1.Checked := Sender = ReceiveOption1;
    ReceiveOption2.Checked := Sender = ReceiveOption2;
    ReceiveOption3.Checked := Sender = ReceiveOption3;
    ReceiveOption4.Checked := Sender = ReceiveOption4;
  end;
  if Qrymain.recordcount = 0 then exit;
  Qrymain.first;
  while qrymain.eof = False do begin
    Editdb(Qrymain);
             if screen.activecontrol = chkDoCrosscheckCompanies  then begin      qrymainDoCrosscheckCompanies.asBoolean := chkDoCrosscheckCompanies.Checked;
    end else if screen.activecontrol = chkDocheckDepartments     then begin      qrymainDocheckDepartments.asBoolean    := chkDocheckDepartments.Checked;
    end else begin
           if ReceiveOption1.checked then qrymainShipmentOption.asString :='C'
      else if ReceiveOption2.checked then qrymainShipmentOption.asString :='A'
      else if ReceiveOption3.checked then qrymainShipmentOption.asString :='R'
      else if ReceiveOption4.checked then qrymainShipmentOption.asString :='D';
    end;
    PostDB(Qrymain);
    Qrymain.Next;
  end;
  CalcQtyToUse;
  if Assigned(css) then begin
    css.reportdate := incsecond(SaleDate,-1);
    css.RefreshQuery;
  end;
  Closedb(qrymain);
  Opendb(qrymain);
  grdMain.RefreshDisplay;
end;

function TfmStockStatus.ScriptMain: TERPScript;
begin
  if (MyScript1.Connection = nil) then
    MyScript1.Connection := CommonDbLib.GetSharedMyDacConnection;

  if  (MyScript1.Connection.Connected = false) then
    MyScript1.Connection := CommonDbLib.GetSharedMyDacConnection;
  REsult := MyScript1;

end;

procedure TfmStockStatus.SetSaleDate(const Value: TDatetime);
begin
  fdSaleDate := Value;
  //lblOthercompanies.Caption := 'Available Stock in Other companies as on ' +FormatDateTime (shortdateformat +' hh:nn:ss' , Value);
  edtdate.text := Formatdatetime(FormatSettings.shortdateformat +' hh:nn:ss AM/PM' , Value);
end;

procedure TfmStockStatus.WriteGuiPrefExtra;
begin
  GuiPrefs.Node['Options.showDetails'].asBoolean := chkShowDetails.checked ;
  GuiPrefs.Node['Options.pnlCrossStockheight'].asInteger := pnlCrossStock.height ;
  GuiPrefs.Node['Options.ShowcompanyStock'].asBoolean := chkShowcompanyStock.checked ;
  GuiPrefs.Node['Options.ReceiveOption1'].asBoolean := ReceiveOption1.Checked;
  GuiPrefs.Node['Options.ReceiveOption2'].asBoolean := ReceiveOption2.Checked;
  GuiPrefs.Node['Options.ReceiveOption3'].asBoolean := ReceiveOption3.Checked;
  GuiPrefs.Node['Options.ReceiveOption4'].asBoolean := ReceiveOption4.Checked;
  GuiPrefs.Node['Options.DocheckDepartments'].asBoolean  := chkDocheckDepartments.Checked;
  GuiPrefs.Node['Options.OtherClassId'].asInteger := fiStockFromOtherClassId;

  GuiPrefs.Node['Options.DoCrosscheckCompanies'].asBoolean  := chkDoCrosscheckCompanies.Checked;
end;

procedure TfmStockStatus.grdMainDblClick(Sender: TObject);
var
  POForm:TBaseInputGUI;
begin
  inherited;
  if QrymainPurchaseOrderID.asInteger = 0 then begin
    if qrymainAssociatedPOsReceived.asString = 'N' then
      commonlib.MessageDlgXP_Vista('Associated Purchase Order is not created for this Sale.' , mtInformation, [mbOk] , 0)
    else
      commonlib.MessageDlgXP_Vista('Associated Purchase Order(s) are received.' , mtInformation, [mbOk] , 0) ;
    Exit;
  end;

  if FormStillOpen('TPurchaseGUI') then begin
      commonlib.MessageDlgXP_Vista('Purchase Order form is already opened. Please close the form to open this transaction' , mtInformation, [mbOk] , 0) ;
      Exit;
  end;
  POForm := TBaseInputGUI(GetComponentByClassName('TPurchaseGUI', true, self));
  if not assigned(POForm) then exit;
  POform.KeyId :=QrymainPurchaseOrderID.asInteger;
  POForm.ShowModal;
  MakeQry;
end;

procedure TfmStockStatus.MakeQry;
var
  strSQL:TstringList;
  Originalno :String;
  Qry :TERPQuery;
  s1, s2:String;
begin
  if Qrymain.active then Qrymain.close;
  strSQL:= TStringList.Create;
  try
    Originalno := getSalesOriginalno(SaleID);
    DestroyUserTemporaryTable(fstablename);
    DestroyUserTemporaryTable(fstablename);
    fstablename := CreateUserTemporaryTable('tmp_StockStatus', '' , 'MYISAM' , nil, fConnection);
    tmpTablename :=GetUserTemporaryTableName('tmpTbl', fConnection);
      {binny : using a different connection because the CREATE SQL will commit the changes
      So if the Sales record is not saved, this form will not work}
      {available Qty}
      strSQL.add('Insert into ' + fsTablename +
            '( Classid, SaleID,saleLineId,BaseLineno, ProductId,Productname,Sold,UOMsold,Shipped,'+
            ' UOMShipped,BackOrder,UOMBackOrder,OriginalQty, UOM,UOMID,UOMMultiplier)'+
            ' SELECT S.CLASSID, SL.SaleID, SL.SaleLineID ,'+
            ' if(ifnull(SL.BaseLineno,0)=0, SL.SaleLineID, SL.BaseLineno), SL.ProductID,SL.ProductName,'+
            ' SL.QtySold,SL.UnitofMeasureQtySold,SL.Shipped,SL.UnitofMeasureShipped,'+
            ' SL.BackOrder,SL.UnitofMeasureBackorder,ifnull(Org.QtySold, Sl.QtySold), SL.UnitofMeasureSaleLines,'+
            ' SL.UnitOfMeasureID,SL.UnitofMeasureMultiplier'+
            ' FROM tblsales AS s'+
            ' Inner Join tblsaleslines AS SL ON s.SaleID = SL.SaleID'+
            ' Left join tblsaleslines As Org on if(ifnull(SL.BaseLineno,0)=0, SL.SaleLineID, SL.BaseLineno) = Org.SaleLineId '+
            ' WHERE s.SaleID =   ' +IntToStr(SaleID)+
            ' and ifnull(SL.Deleted,"F")<> "T" and ifnull(SL.BackOrder,0) <> 0;');
      strSQL.add('update ' + fsTablename +' set OtherclassId = ' + inttostr(fiStockFromOtherClassId)+',Otherclassname =' + quotedstr(GetClassName(fiStockFromOtherClassId))+';');

      strSQL.add('Alter table ' +fsTablename + ' Add column DefaultStockClassID int(11);');
      strSQL.add('update  ' +fsTablename + ' T inner join tblproductclasses PC on T.ProductID = PC.ProductID and IsDefaultStockClass="T" Set  T.DefaultStockClassID = PC.ClassID;');

      strSQL.add('drop TEMPORARY table if exists '+ tmpTablename +';' );

      qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
      try
        closedb(qry);
        s1:=''; s2:='';

        qry.sql.text := 'select classId from tblclass where active ="T"';
        qry.open;
        if qry.recordcount >0 then begin
          Qry.first;
          while Qry.eof = false do begin
            strSQL.add('Alter table ' + fstablename + ' add column classStock_'+ trim(inttostr(qry.fieldbyname('classId').asInteger))+' double;');
            strSQL.add('update ' + fstablename + ' T Set classStock_'+ trim(inttostr(qry.fieldbyname('classId').asInteger))+' = '+
                                                  '(Select Round(Sum( ' +SQL4QtyField(tAvailable)+'),' + IntToStr(tcConst.GeneralRoundPlaces) +') '+
                                                  ' from  tblPQa PQA where (PQA.TransDate < '+Quotedstr(FormatdateTime(mysqldatetimeFormat , SaleDate)) +' )  '+
                                                  ' and PQA.DepartmentID = '+ trim(inttostr(qry.fieldbyname('classId').asInteger))+
                                                  '  and T.productId = PQA.productID and T.UOMID = PQA.UOMID);');
            if qry.fieldbyname('classId').asInteger = SaleclassId(saleID) then s1:=ClassStockField(qry.fieldbyname('classId').asInteger)
              else begin
                if s2<> '' then s2 := s2 +'+';
                s2:= s2 +ClassStockField(qry.fieldbyname('classId').asInteger);
              end;
            qry.next;
          end;
        end;

      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
      end;

      if trim(s1) <> '' then StrSQL.add('update ' +fsTablename +' set AvailableStock = '+s1+';');
      if trim(s2) <> '' then StrSQL.add('update ' +fsTablename +' set oAvailableStock = '+s2+';');
      StrSQL.add('update ' +fsTablename +' set UOMAvailableStock = AvailableStock / UOMMultiplier;');
      StrSQL.add('update ' +fsTablename +' set oUOMAvailableStock = oAvailableStock / UOMMultiplier;');
      StrSQL.add('update ' +fsTablename +' set EnoughStock = "T" where AvailableStock >= BackOrder;');
      StrSQL.add('update ' +fsTablename +' set ShipmentOption = "D" ;');

      {Sale's PO received}
      strSQL.add('drop TEMPORARY table if exists '+ tmpTablename +';' );
      strSQL.add('create TEMPORARY table ' + tmpTablename +
        ' Select distinct SL.SaleLineId  , SL.SaleLineID as BaseLineno, Sum(PL.Shipped) as Shipped'+
                    ' from tblPurchaselines  PL '+
                    ' inner join tblSaleslines SL on SL.SaleLineId = PL.SaleLineId  '+
                    ' inner join tblSales S on S.SaleId = SL.SaleID and S.Originalno = ' +QuotedStr(Originalno)+
                    ' Where  PL.Shipped <>0 and ifnull(SL.BaseLineno,0)=0   ' +
                    ' group by SL.SaleLineId,SL.SaleLineID  ' +
        ' Union all Select distinct SL.SaleLineId  , SL.BaseLineno as BaseLineno, Sum(PL.Shipped) as Shipped'+
                    ' from tblPurchaselines  PL '+
                    ' inner join tblSaleslines SL on SL.BaseLineno = PL.SaleLineId'+
                    ' inner join tblSales S on S.SaleId = SL.SaleID and S.Originalno = ' +QuotedStr(Originalno)+
                    ' Where  PL.Shipped <>0 and ifnull(SL.BaseLineno,0)<>0   ' +
                    ' group by SL.SaleLineId,SL.BaseLineno  ;' );

      StrSQL.add('update ' +fsTablename +' tmp1 inner join ' +tmpTablename +' tmp2 using (BaseLineno)  '+
                    ' Set tmp1.Received = tmp2.Shipped; ');

      strSQL.add('drop TEMPORARY table if exists '+ tmpTablename +';' );
      strSQL.add('create TEMPORARY table ' + tmpTablename +
        ' Select distinct PL.SaleLineID,  PL.ETADAte , PL.PurchaseOrderID '+
                    ' from tblPurchaselines  PL '+
                    ' inner join tblSaleslines SL on SL.SaleLineId = PL.SaleLineId '+
                    ' inner join tblPurchaseOrders PO on PO.PurchaseOrderId = PL.PurchaseOrderId '+
                    ' inner join tblSales S on S.SaleId = SL.SaleID and S.Originalno = ' +QuotedStr(Originalno)+
                    ' Where  PL.backorder <> 0 and PL.Shipped =0 and ifnull(PO.BOID,"")  = "" and  ifnull(Sl.BaseLineno,0) =0' +
        ' union all Select distinct PL.SaleLineID,  PL.ETADAte , PL.PurchaseOrderID '+
                    ' from tblPurchaselines  PL '+
                    ' inner join tblSaleslines SL on Sl.BaseLineno = PL.SaleLineId   '+
                    ' inner join tblPurchaseOrders PO on PO.PurchaseOrderId = PL.PurchaseOrderId '+
                    ' inner join tblSales S on S.SaleId = SL.SaleID and S.Originalno = ' +QuotedStr(Originalno)+
                    ' Where  PL.backorder <> 0 and PL.Shipped =0 and ifnull(PO.BOID,"")  = "" and  ifnull(Sl.BaseLineno,0) <>0;' );

      StrSQL.add('update ' +fsTablename +'  Set AssociatedPOsReceived = "N";');
      StrSQL.add('update ' +fsTablename +' tmp1 inner join tblPurchaselines  on (tmp1.BaseLineno = tblPurchaselines.SaleLineId  ) or  (tmp1.SaleLineId = tblPurchaselines.SaleLineId  ) '+
                    ' Set tmp1.AssociatedPOsReceived = "T" '+
                    ' where ifnull(tblPurchaselines.SaleLineId,0) <> 0 '+
                    ' and tmp1.SaleLineId not in'+
                    ' (Select SaleLineId from ' +tmpTablename +') ;');
      StrSQL.add('update ' +fsTablename +' tmp1 inner join ' +tmpTablename +' tmp2 on tmp1.Baselineno = tmp2.SaleLineId '+
                    ' Set tmp1.AssociatedPOsReceived = "F" ,tmp1.ETA = tmp2.ETADATE, tmp1.PurchaseOrderID =  tmp2.PurchaseOrderID;');
      strSQL.add('update ' +fsTablename + ' Set Received = Received - (OriginalQty-Sold) ;');

      strSQL.add('Alter table ' +fsTablename + ' Add column QtyRequired double DEfault 0;');
      strSQL.add('Alter table ' +fsTablename + ' Add column ReceivedtoUse double DEfault 0;');
      strSQL.add('Alter table ' +fsTablename + ' Add column oUOMAvailableStocktoUse double DEfault 0;');
      strSQL.add('Alter table ' +fsTablename + ' Add column UOMAvailableStocktoUse double DEfault 0;');

      if ReceiveOption1.checked then  strSQL.add('update ' +fsTablename + ' Set ShipmentOption = "C";');
      if ReceiveOption2.checked then  strSQL.add('update ' +fsTablename + ' Set ShipmentOption = "A";');
      if ReceiveOption3.checked then  strSQL.add('update ' +fsTablename + ' Set ShipmentOption = "R";');
      if ReceiveOption4.checked then  strSQL.add('update ' +fsTablename + ' Set ShipmentOption = "D";');

      if chkDocheckDepartments.checked    then  strSQL.add('update ' +fsTablename + ' Set DocheckDepartments = "T";');
      if classlookupform.useall then strSQL.add('update ' +fsTablename + ' Set OtherclassId =0;')
                                else strSQL.add('update ' +fsTablename + ' Set OtherclassId =' + inttostr(classlookupform.LookupID) +';');
      if chkDoCrosscheckCompanies.checked then  strSQL.add('update ' +fsTablename + ' Set DoCrosscheckCompanies = "T";');

      //strSQL.add('update ' +fsTablename + ' Set UOMAvailableStock = UOMAvailableStock - Received ;');
      With scriptmain do begin
        SQL.text :=  strSQL.text;
        DoShowProgressbar(SQL.count , WAITMSG);
        try
          clog(SQL.text);
          Execute;
        finally
          DoHideProgressbar;
        end;
      end;

    CalcQtyToUse;
  finally
    qrymain.connection := fconnection;
    qrymain.SQL.clear;
    qrymain.SQL.add('select t.* , concat(UOM,"(",UOMMultiplier,")") as sUOM  from ' + fsTablename+' as T');
    qrymain.open;
    FreeandNil(strSQL);
  end;
end;
procedure TfmStockStatus.MyScript1Error(Sender: TObject; E: Exception;
  SQL: string; var Action: TErrorAction);
begin
  inherited;
  if devmode then begin
    MessageDlgXP_Vista(E.Message+NL+SQL, mtWarning, [mbOK], 0);
    logtext(E.Message+NL+SQL);
  end;
  action := eaContinue ;
end;

procedure TfmStockStatus.btnHowToClick(Sender: TObject);
begin
  inherited;
//  TDocReaderObj.ShowERPHelp(nil, Self, true, 'How To - Cross Company Stock');
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'Cross Company Stock');
end;

Procedure TfmStockStatus.CalcQtytoUse;
begin
  With scriptmain do begin
    SQL.clear;

    SQL.add('update  ' +fsTablename + '  Set QtyRequired =0;');
    SQL.add('update  ' +fsTablename + '  Set ReceivedtoUse =0;');
    SQL.add('update  ' +fsTablename + '  Set oUOMAvailableStocktoUse =0;');
    SQL.add('update  ' +fsTablename + '  Set UOMAvailableStocktoUse =0;');
    SQL.add('update ' +fsTablename + ' set QtyRequired  = UOMBackOrder;');

    SQL.add('update ' +fsTablename + ' set UOMAvailableStocktoUse = QtyRequired  where ShipmentOption ="C";');
    SQL.add('update ' +fsTablename + ' set QtyRequired            = 0  where ShipmentOption ="C";');

    SQL.add('update ' +fsTablename + ' set ReceivedtoUse          = if(QtyRequired <Received ,QtyRequired , Received)  where ShipmentOption ="R";');
    SQL.add('update ' +fsTablename + ' set QtyRequired            = QtyRequired -  ReceivedtoUse  where ShipmentOption ="R";');

    SQL.add('update ' +fsTablename + ' set UOMAvailableStocktoUse= if(QtyRequired <UOMAvailableStock ,QtyRequired , UOMAvailableStock)  where ShipmentOption ="A" ;');
    SQL.add('update ' +fsTablename + ' set QtyRequired            = QtyRequired -  UOMAvailableStocktoUse  where ShipmentOption ="A";');

    SQL.add('update ' +fsTablename + ' set oUOMAvailableStocktoUse = if(QtyRequired <oUOMAvailableStock ,QtyRequired , oUOMAvailableStock) Where DocheckDepartments ="T";');
    SQL.add('update ' +fsTablename + ' set QtyRequired            = QtyRequired -  oUOMAvailableStocktoUse  Where DocheckDepartments ="T";');
    if SQL.count > 0 then begin logtext(SQL.text);      doShowProgressbar(SQL.count , WAITMSG);    try      Execute;    finally      DoHideProgressbar;    end; end;
  end;
end;

procedure TfmStockStatus.OncssREfreshQuery(cc: TCrossStockCompanies; cssTablename:String);
begin
  if Qrymain.recordcount =0 then exit;
  if css = nil then exit;
  if cc.count =0 then exit;
  cc.First;
  With Scriptmain do begin
    SQL.clear;
    While cc.Eof = False do begin
      //SQL.add('Alter table '+ cssTablename +' Add column ToUseAvailable'+ trim(inttostr(cc.dataset.recno))+' Double DEfault 0;');
      SQL.add('update '+ cssTablename +' T1 inner join ' + fsTablename +' T2  on T1.productname = T2.Productname Set  T1.ToUseAvailable'+ trim(inttostr((*cc.dataset.recno*)cc.id))+' = /*T1.ToUseAvailable'+ trim(inttostr((*cc.dataset.recno*)cc.id))+' - */if(T1.Available'+ trim(inttostr((*cc.dataset.recno*)cc.id))+'<T2.QtyRequired , T1.Available'+ trim(inttostr((*cc.dataset.recno*)cc.id))+' , T2.QtyRequired) where T2.QtyRequired >0 and T1.Available'+ trim(inttostr((*cc.dataset.recno*)cc.id))+' >0;');
      SQL.add('update '+ cssTablename +' T1 inner join ' + fsTablename +' T2  on T1.productname = T2.Productname Set   T2.QtyRequired = T1.ToUseAvailable'+ trim(inttostr((*cc.dataset.recno*)cc.id))+';');
      cc.Next;
    end;
    if SQL.count > 0 then begin logtext(SQL.text);      doShowProgressbar(SQL.count , WAITMSG);    try      Execute;    finally      DoHideProgressbar;    end; end;
  end;
end;

procedure TfmStockStatus.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  if OpenERPFormModal('TfmCrossStockCompanies' , 0 , nil, true)>0 then
    if Assigned(css) then begin
      css.reportdate := incsecond(SaleDate,-1);
      css.RefreshQuery;
    end;
end;


procedure TfmStockStatus.beforeShowcss(Sender: TObject);
begin
  css.reportdate := incsecond(SaleDate,-1);
  css.OnRecordChange := OncssRecordChange;
  css.OnREfreshQuery := OncssREfreshQuery;
  css.grdmain.OnCalcCellColors :=grdMainCalcCellColors;
  css.ShowDefaultDept := False;
  if Qrymain.RecordCount >0 then begin
    Qrymain.First;
    try
      while Qrymain.Eof = False do begin
        css.AddProductname(Qrymainproductname.AsString);
        Qrymain.Next;
      end;
    finally
      Qrymain.First;
    end;
  end;
   css.Grdmain.borderStyle := bssingle;
end;
procedure TfmStockStatus.InitClassLookup;
begin
  ClassLookupform := TFmClassLookup.MakeInstance(Self, pnlDepts, 0,0 , 0 , AlClient, GuiPrefs, OnClassSelection, iif(chkDocheckDepartments.Checked,1,0) , fiStockFromOtherClassId);
  ClassLookupform.cboQry.filter := 'id <> '+ inttostr(SaleclassId(SaleID));
  ClassLookupform.cboQry.filtered := True;
  ClassLookupform.LookupCaption := 'If not Available in Product''s Default ' + Appenv.DefaultClass.ClassHeading+', Check in :';
  ClassLookupform.HidePanel;
  //ClassLookupform.lookupcolor := GridColFontOlive;
end;
procedure TfmStockStatus.OnClassSelection(DataSet: TObject);
begin
  if ClassLookupform.UseAll then fiStockFromOtherClassId := 0 else fiStockFromOtherClassId := ClassLookupform.LookupID;
  chkDocheckDepartments.Checked := True;
  grdMain.repaint;
end;
function TfmStockStatus.ClassStockField(aClassID: Integer): String;
begin
  result := 'classStock_'+ trim(inttostr(aClassID));
end;
Function TfmStockStatus.IsClassField(aFieldname:String;aClassID:Integer):Boolean;
begin
  if aClassID <> 0 then
        result := sametext(ClassStockField(aClassID) , aFieldname)
  else  result := sametext(copy(aFieldname,1,length('classStock_')), 'classStock_');
end;

initialization

  RegisterClassOnce(TfmStockStatus);

end.
