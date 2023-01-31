unit BusobjBOMList;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  26/07/17  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusobjStock , busobjprocess;


type
  TBOMListImport = class(TMSBusObj)
  private
    fsListintoTreeError: String;
    fiLevels: Integer;
    fiLevelno :Integer;
    FTreeNodeRoot: TProcTreeNode;
    function GetPartsId         : Integer   ;
    function GetPartname        : string    ;
    procedure SetPartsId          (const Value: Integer   );
    procedure SetPartname         (const Value: string    );
    function getProduct: TProduct;
    procedure MakeProductsCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure ListintoTreeCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure CalcQtyFromFormula(TreeNode: TProcTreeNode);
    procedure DoGetParserVariable(Sender: TObject; const VarName: string;     var Value: extended; var FieldFound: Boolean);
    function Partnamefield        :String;
    function PartsIdfieldname     :String;
    function Qtyfieldname         :String;
    function Infoname             :String;
    function Descriptionname      :String;
    function commentsname         :String;
    function BuildLineNoname      :String;
    function Productunitpricename :String;
    Function TreePricechangedName :String;
    function Formulanamename      :String;
    function FormulaQtyValue1name :String;
    function FormulaQtyValue2name :String;
    function FormulaQtyValue3name :String;
    function FormulaQtyValue4name :String;
    function FormulaQtyValue5name :String;

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterOpen(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Function ListintoTree :Boolean;
    Property ListintoTreeError :String read fsListintoTreeError write fsListintoTreeError;
    Property Product :TProduct read getProduct;
    Property BOMLevels :Integer read fiLevels;
    Class procedure MakeTable(const TreeLevels:Integer);
  published
    property PartsId          :Integer     read GetPartsId          write SetPartsId ;
    property Partname         :string      read GetPartname         write SetPartname;
  end;


implementation


uses ERPdbComponents, tcDataUtils, CommonLib, BusObjectListObj, CommonDbLib,
  DbSharedObjectsObj, sysutils, BusObjConst, BusObjNDSBase,
  ProcessDataUtils, BOMLib, BusObjProcessPartNDS, BusObjProcessStep, ParserLib;



  {TBOMListImport}
Class Procedure TBOMListImport.MakeTable(const TreeLevels:Integer);
var
  scr :TERPScript;
  ctr:Integer;
begin

  scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
    scr.SQL.clear;

    if not (Commondblib.tableExists('tblBOMListImport'))  then begin
      scr.SQL.Add('CREATE TABLE tblbomlistimport (  ');
      scr.SQL.Add(' ID INT(11) NOT NULL AUTO_INCREMENT,  ');
      scr.SQL.Add(' PartsId INT(11) NOT NULL,');
      scr.SQL.Add('Partname VARCHAR(255) NULL DEFAULT NULL, ');
      for ctr := 1 to TreeLevels do begin
        scr.SQL.Add('PartsId'  + trim(inttostr(ctr))+ ' int(11) default 0,');
        scr.SQL.Add('Caption'  + trim(inttostr(ctr))+ ' VARCHAR(255)  NULL DEFAULT "",');
        scr.SQL.Add('Quantity' + trim(inttostr(ctr))+ ' DOUBLE NULL DEFAULT 0.0,');
        scr.SQL.Add('FormulaName' + trim(inttostr(ctr))+ '  VARCHAR(255) NULL  DEFAULT "", ');
        scr.SQL.Add(' ProductUnitPrice' + trim(inttostr(ctr))+ '  Double   NULL DEFAULT 0.0,');
        scr.SQL.Add(' Info' + trim(inttostr(ctr))+ '   VARCHAR(255) NULL  DEFAULT "", ');
        scr.SQL.Add(' Description' + trim(inttostr(ctr))+ '   VARCHAR(255) NULL  DEFAULT "", ');
        scr.SQL.Add(' comments' + trim(inttostr(ctr))+ '   VARCHAR(255) NULL  DEFAULT "", ');
        scr.SQL.Add(' BuildLineNo' + trim(inttostr(ctr))+ '   int(11) NULL  DEFAULT 0, ');
        scr.SQL.Add(' FormulaQtyValue' + trim(inttostr(ctr))+ '_1 Double   NULL DEFAULT 0.0,');
        scr.SQL.Add(' FormulaQtyValue' + trim(inttostr(ctr))+ '_2 Double   NULL DEFAULT 0.0,');
        scr.SQL.Add(' FormulaQtyValue' + trim(inttostr(ctr))+ '_3 Double   NULL DEFAULT 0.0,');
        scr.SQL.Add(' FormulaQtyValue' + trim(inttostr(ctr))+ '_4 Double   NULL DEFAULT 0.0,');
        scr.SQL.Add(' FormulaQtyValue' + trim(inttostr(ctr))+ '_5 Double   NULL DEFAULT 0.0,');
        scr.SQL.Add(' TreePricechanged'+ trim(inttostr(ctr))+ ' Varchar(10)   NULL DEFAULT "False",');
      end;
      scr.SQL.Add(' ParentId INT(11) DEFAULT 0,');
      scr.SQL.Add(' Pactive ENUM("T","F") DEfault "T" , ');
      scr.SQL.Add('MsUpdateSitecode VARCHAR(3) NULL DEFAULT NULL, ');
      scr.SQL.Add('`msTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, ');
      scr.SQL.Add(' PRIMARY KEY (ID),  ');
      scr.SQL.Add(' INDEX PartsId (PartsId) )  ');
      scr.SQL.Add(' COLLATE="utf8_general_ci" ENGINE=MyISAM; ');
    end else begin
      for ctr := 2 to TreeLevels do begin
        if not tcdatautils.FieldExists('tblBOMListImport'   , 'PartsId'           + trim(inttostr(ctr))) then scr.SQL.Add('Alter table tblBOMListImport add column PartsId'         + trim(inttostr(ctr))+ ' int(11) Default 0 ;');
        if not tcdatautils.FieldExists('tblBOMListImport'   , 'Caption'           + trim(inttostr(ctr))) then scr.SQL.Add('Alter table tblBOMListImport add column Caption'         + trim(inttostr(ctr))+ ' VARCHAR(255) DEFAULT NULL ;');
        if not tcdatautils.FieldExists('tblBOMListImport'   , 'Quantity'          + trim(inttostr(ctr))) then scr.SQL.Add('Alter table tblBOMListImport add column Quantity'        + trim(inttostr(ctr))+ ' DOUBLE DEFAULT NULL ;');
        if not tcdatautils.FieldExists('tblBOMListImport'   , 'FormulaName'       + trim(inttostr(ctr))) then scr.SQL.Add('Alter table tblBOMListImport add column FormulaName'     + trim(inttostr(ctr))+ ' VARCHAR(255) DEFAULT NULL ;');
        if not tcdatautils.FieldExists('tblBOMListImport'   , 'ProductUnitPrice'  + trim(inttostr(ctr))) then scr.SQL.Add('Alter table tblBOMListImport add column ProductUnitPrice'+ trim(inttostr(ctr))+ ' DOUBLE DEFAULT NULL ;');
        if not tcdatautils.FieldExists('tblBOMListImport'   , 'Info'              + trim(inttostr(ctr))) then scr.SQL.Add('Alter table tblBOMListImport add column Info'            + trim(inttostr(ctr))+ ' VARCHAR(255) DEFAULT NULL ;');
        if not tcdatautils.FieldExists('tblBOMListImport'   , 'Description'       + trim(inttostr(ctr))) then scr.SQL.Add('Alter table tblBOMListImport add column Description'     + trim(inttostr(ctr))+ ' VARCHAR(255) DEFAULT NULL ;');
        if not tcdatautils.FieldExists('tblBOMListImport'   , 'comments'          + trim(inttostr(ctr))) then scr.SQL.Add('Alter table tblBOMListImport add column comments'        + trim(inttostr(ctr))+ ' VARCHAR(255) DEFAULT NULL ;');
        if not tcdatautils.FieldExists('tblBOMListImport'   , 'BuildLineNo'       + trim(inttostr(ctr))) then scr.SQL.Add('Alter table tblBOMListImport add column BuildLineNo'     + trim(inttostr(ctr))+ ' int(11) DEFAULT NULL ;');
        if not tcdatautils.FieldExists('tblBOMListImport'   , 'FormulaQtyValue'   + trim(inttostr(ctr))+'_1') then scr.SQL.Add('Alter table tblBOMListImport add column FormulaQtyValue' + trim(inttostr(ctr))+ '_1 DOUBLE DEFAULT NULL ;');
        if not tcdatautils.FieldExists('tblBOMListImport'   , 'FormulaQtyValue'   + trim(inttostr(ctr))+'_2') then scr.SQL.Add('Alter table tblBOMListImport add column FormulaQtyValue' + trim(inttostr(ctr))+ '_2 DOUBLE DEFAULT NULL ;');
        if not tcdatautils.FieldExists('tblBOMListImport'   , 'FormulaQtyValue'   + trim(inttostr(ctr))+'_3') then scr.SQL.Add('Alter table tblBOMListImport add column FormulaQtyValue' + trim(inttostr(ctr))+ '_3 DOUBLE DEFAULT NULL ;');
        if not tcdatautils.FieldExists('tblBOMListImport'   , 'FormulaQtyValue'   + trim(inttostr(ctr))+'_4') then scr.SQL.Add('Alter table tblBOMListImport add column FormulaQtyValue' + trim(inttostr(ctr))+ '_4 DOUBLE DEFAULT NULL ;');
        if not tcdatautils.FieldExists('tblBOMListImport'   , 'FormulaQtyValue'   + trim(inttostr(ctr))+'_5') then scr.SQL.Add('Alter table tblBOMListImport add column FormulaQtyValue' + trim(inttostr(ctr))+ '_5 DOUBLE DEFAULT NULL ;');
        if not tcdatautils.FieldExists('tblBOMListImport'   , 'TreePricechanged'  + trim(inttostr(ctr)))      then scr.SQL.Add('Alter table tblBOMListImport add column TreePricechanged'+ trim(inttostr(ctr))+ '  Varchar(10)   NULL DEFAULT "False" ;');
      end;
    end;
    if scr.SQL.count > 0 then scr.Execute;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;

end;
constructor TBOMListImport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'BOMLstImport';
  fSQL := 'SELECT * FROM tblbomlistimport';
  //MakeTable;
  fiLevels := BOMTreeLevels+1;
end;


destructor TBOMListImport.Destroy;
begin
  inherited;
end;

function TBOMListImport.ListintoTree: Boolean;
var
  TreeRootId:Integer;
  PP: TProcessPartNDS;
  s:String;
begin
  Result := True;
  ListintoTreeError  := '';
  if count =0 then exit;
  Connection.BeginTransaction;
  try
    {Validate Root Product}
    if (Partname = '') then begin
       ListintoTreeError:= 'Partname should not be blank';
       Result := False;
       Exit;
    end;
    First;
    Iteraterecords(MakeProductsCallback);
    First;
    try
        Repeat
          FTreeNodeRoot := TProcTreeNode.Create(nil);
          FTreeNodeRoot.Storer.Connection := TERPConnection(Self.Connection.Connection) ;
          TreeRootId:= ProcessDataUtils.TreeRootIdForProductTemplate(PartsID , TERPConnection(Self.Connection.Connection));
          if (TreeRootId > 0)  then begin
            FTreeNodeRoot.Id:= TreeRootId;
            FTreeNodeRoot.LoadTree;
            FTreeNodeRoot.DEletetree;
            Freeandnil(FTreeNodeRoot);
          end;
        Until TreeRootId =0; {If the tree already exists, this Repeat-unitl loop will delete it first time and 'TreeRootId' will be 0 sedonf time}


        FTreeNodeRoot.masterId := PartsId;
        FTreeNodeRoot.mastertype := mtProduct;
        FTreeNodeRoot.quantity := 1;
        FTreeNodeRoot.partsId := PartsId;
        FTreeNodeRoot.Caption := Partname;
        fiLevelno := 1;
        s:= FTreeNodeRoot.caption;
        FTreeNodeRoot.Formulaid := getFormulaId(dataset.fieldbyname(Formulanamename).asString);
        FTreeNodeRoot.FormulaQtyValue1:= dataset.fieldbyname(FormulaQtyValue1name).asFloat;
        FTreeNodeRoot.FormulaQtyValue2:= dataset.fieldbyname(FormulaQtyValue2name).asFloat;
        FTreeNodeRoot.FormulaQtyValue3:= dataset.fieldbyname(FormulaQtyValue3name).asFloat;
        FTreeNodeRoot.FormulaQtyValue4:= dataset.fieldbyname(FormulaQtyValue4name).asFloat;
        FTreeNodeRoot.FormulaQtyValue5:= dataset.fieldbyname(FormulaQtyValue5name).asFloat;
        FTreeNodeRoot.ProductUnitPrice:= dataset.fieldbyname(Productunitpricename).asFloat;
        FTreeNodeRoot.TreePricechanged:= dataset.fieldbyname(TreePricechangedName).asBoolean;

        FTreeNodeRoot.TreePartUOM     := Product.UOMSales;
        FTreeNodeRoot.Info            := dataset.fieldbyname(Infoname).asString;
        FTreeNodeRoot.Description     := dataset.fieldbyname(Descriptionname).asString;
        FTreeNodeRoot.comments        := dataset.fieldbyname(commentsname).asString;
        FTreeNodeRoot.BuildLineNo     := dataset.fieldbyname(BuildLineNoname).asInteger;
        FTreeNodeRoot.ParentId :=0;
        //CalcQtyfromformula(FTreeNodeRoot); // rootnode should not use formula

        Iteraterecords(ListintoTreeCallback);
        if FTreeNodeRoot.ProcessStepList.count =0 then begin
          MakeAssemblyProcess;
          pp:= FTreeNodeRoot.ProcessStepList.AddProcessPart;
          pp.PartId                := FTreeNodeRoot.PArtsId;
          pp.ProcessStepID         := TProcessStep.IdForDescription('Assembly' , self.connection.connection , True);
          pp.ProcessStepSeq        :=1;
          pp.ProcTreeId            :=FTreeNodeRoot.ID;
          pp.IsTemplate            := True;
          pp.MakeCoupons           := False;
          pp.Duration              := 60;
        end;
        if not FTreeNodeRoot.savenocheck then begin
          ListintoTreeError:= 'BOM import failed for product :'+FTreeNodeRoot.caption;
          Connection.RollbackTransaction;
          REsult := False;
          Exit;
        end;
        Connection.CommitTransaction;
    finally
      Freeandnil(FTreeNodeRoot);
    end;
  Except
    on E:Exception do begin
       ListintoTreeError:=s+ ': Importing BOM Product List Failed With Error : '+E.message;
       Result := False;
       Connection.RollbackTransaction;
       Exit;
    end;
  end;
end;
procedure TBOMListImport.MakeProductsCallback(Const Sender: TBusObj; var Abort: Boolean);
var
  ctr:Integer;
  fsPartnamefield :String;
  fsPartsIdfieldname :String;
  fProduct :TProduct;
begin
  for ctr := BOMLevels downto 1 do begin
    try
      if ctr =1 then begin
        fsPartnamefield :='Partname';
        fsPartsIdfieldname :='PartsId';
      end else begin
        fsPartnamefield :='Caption'+trim(inttostr(ctr));
        fsPartsIdfieldname :='PartsId'+trim(inttostr(ctr));
      end;
      if Assigned(dataset.Findfield(fsPartnamefield)) then
        if Assigned(dataset.fieldbyname(fsPartnamefield)) and (trim(dataset.fieldbyname(fsPartnamefield).asString) <> '') then begin
          fProduct := TProduct.create(self);
          try
            fProduct.connection := Self.connection;
            fProduct.LoadSelect('Partname =' +quotedstr(trim(dataset.fieldbyname(fsPartnamefield).asString)));
            if fProduct.count =0 then begin
              fProduct.New;
              fProduct.Productname := trim(dataset.fieldbyname(fsPartnamefield).asString);
              fProduct.ProductPrintName := trim(dataset.fieldbyname(fsPartnamefield).asString);
              fProduct.Producttype :='INV';
              if ctr =1 then fProduct.active :=trim(dataset.fieldbyname('Pactive').asString)='T';
              fProduct.PostDB;
            end;
            if dataset.fieldbyname(fsPartsIdfieldname).asInteger <> fProduct.Id then begin
              Editdb;
              dataset.fieldbyname(fsPartsIdfieldname).asInteger :=fProduct.Id;
            end;
          finally
            Freeandnil(fProduct);
          end;
        end;
    Except
      on E:Exception do begin
        if devmode then
          Resultstatus.AddItem(False , rssError , 0,  E.Message , TRue);
      end;
    end;
  end;
  PostDB;
end;
function TBOMListImport.Partnamefield        :String; begin if fiLevelno=1 then result := 'Partname' else  result := 'Caption'          +trim(inttostr(fiLevelno));end;
function TBOMListImport.PartsIdfieldname     :String; begin if fiLevelno=1 then result := 'PartsId'  else  result := 'PartsId'          +trim(inttostr(fiLevelno));end;
function TBOMListImport.Qtyfieldname         :String; begin result := 'Quantity'         +trim(inttostr(fiLevelno));end;
function TBOMListImport.Infoname             :String; begin result := 'Info'             +trim(inttostr(fiLevelno));end;
function TBOMListImport.Descriptionname      :String; begin result := 'Description'      +trim(inttostr(fiLevelno));end;
function TBOMListImport.commentsname         :String; begin result := 'comments'         +trim(inttostr(fiLevelno));end;
function TBOMListImport.BuildLineNoname      :String; begin result := 'BuildLineNo'      +trim(inttostr(fiLevelno));end;
function TBOMListImport.Productunitpricename :String; begin result := 'Productunitprice' +trim(inttostr(fiLevelno));end;
function TBOMListImport.TreePricechangedname :String; begin result := 'TreePricechanged' +trim(inttostr(fiLevelno));end;
function TBOMListImport.Formulanamename      :String; begin result := 'Formulaname'      +trim(inttostr(fiLevelno));end;
function TBOMListImport.FormulaQtyValue1name :String; begin result := 'FormulaQtyValue'+trim(inttostr(fiLevelno))+'_1';end;
function TBOMListImport.FormulaQtyValue2name :String; begin result := 'FormulaQtyValue'+trim(inttostr(fiLevelno))+'_2';end;
function TBOMListImport.FormulaQtyValue3name :String; begin result := 'FormulaQtyValue'+trim(inttostr(fiLevelno))+'_3';end;
function TBOMListImport.FormulaQtyValue4name :String; begin result := 'FormulaQtyValue'+trim(inttostr(fiLevelno))+'_4';end;
function TBOMListImport.FormulaQtyValue5name :String; begin result := 'FormulaQtyValue'+trim(inttostr(fiLevelno))+'_5';end;

procedure TBOMListImport.ListintoTreeCallback(Const Sender: TBusObj; var Abort: Boolean);
var
  ctr:Integer;
  FTreeNode: TProcTreeNode;
  fPArentNode :TProcTreeNode;
  Parentcaption :String;
begin
  if sender is TBOMListImport then begin
    Parentcaption := FTreeNodeRoot.caption;
    fPArentNode :=FTreeNodeRoot;
    for ctr := 2 to BOMLevels do begin
      fiLevelno := ctr;
      if dataset.findfield(Partnamefield)= nil then exit;
      if dataset.fieldbyname(Partnamefield).asString = '' then exit;
       if fPArentNode.Locate(Parentcaption , dataset.fieldbyname(Partnamefield).asString,
                              dataset.fieldbyname(FormulaQtyValue1name).asFloat,
                              dataset.fieldbyname(FormulaQtyValue2name).asFloat,
                              dataset.fieldbyname(FormulaQtyValue3name).asFloat,
                              dataset.fieldbyname(FormulaQtyValue4name).asFloat,
                              dataset.fieldbyname(FormulaQtyValue5name).asFloat, FTreeNode) then begin
       end else begin

          FTreeNode :=  TProcTreeNode.Create(fParentNode);
          FTreeNode.PartsId := dataset.fieldbyname(PartsIdfieldname).asInteger;
          FTreeNode.caption := dataset.fieldbyname(Partnamefield).asString;
          FTreeNode.mastertype  := mtProduct;
          FTreeNode.quantity    := dataset.fieldbyname(Qtyfieldname).asFloat;
          FTreeNode.parentId    := fParentNode.ID;
          FTreeNode.Formulaid   := getFormulaId(dataset.fieldbyname(Formulanamename).asString);
          FTreeNode.Info             := dataset.fieldbyname(infoname).asString;
          FTreeNode.Description      := dataset.fieldbyname(Descriptionname).asString;
          FTreeNode.comments         := dataset.fieldbyname(commentsname).asString;
          FTreeNode.BuildLineNo      := dataset.fieldbyname(BuildLineNoname).asInteger;
          FTreeNode.FormulaQtyValue1 := dataset.fieldbyname(FormulaQtyValue1name).asFloat;
          FTreeNode.FormulaQtyValue2 := dataset.fieldbyname(FormulaQtyValue2name).asFloat;
          FTreeNode.FormulaQtyValue3 := dataset.fieldbyname(FormulaQtyValue3name).asFloat;
          FTreeNode.FormulaQtyValue4 := dataset.fieldbyname(FormulaQtyValue4name).asFloat;
          FTreeNode.FormulaQtyValue5 := dataset.fieldbyname(FormulaQtyValue5name).asFloat;
          FTreeNode.ProductUnitPrice := dataset.fieldbyname(ProductUnitPricename).asFloat;
          FTreeNode.TreePricechanged := dataset.fieldbyname(TreePricechangedname).AsBoolean;


          CalcQtyfromformula(FTreeNode);
          fParentNode.Children.Add(FTreeNode);
       end;
       fParentNode  := FTreeNode;
       Parentcaption:=  fParentNode.Caption;
    end;
  end;
end;
Procedure TBOMListImport.CalcQtyFromFormula(TreeNode:TProcTreeNode );
var
  ErrMsg:String;
  fdQty:Double;
begin
  if (TreeNode.formulaId <>0) then begin
    fdQty := ParserValue(Self , DoGetParserVariable , getFormula(TreeNode.FormulaId), errMsg);
    if errmsg <> '' then
    else  TreeNode.Quantity := fdQty ;
  end;
end;
procedure TBOMListImport.DoGetParserVariable(Sender: TObject; const VarName: string; var Value: extended; var FieldFound: Boolean);
begin
   Value := 0;
       if sametext(VArname , 'Field1') then Value := Dataset.Fieldbyname(FormulaQtyValue1Name).AsFloat
  else if sametext(VArname , 'Field2') then Value := Dataset.Fieldbyname(FormulaQtyValue2Name).AsFloat
  else if sametext(VArname , 'Field3') then Value := Dataset.Fieldbyname(FormulaQtyValue3Name).AsFloat
  else if sametext(VArname , 'Field4') then Value := Dataset.Fieldbyname(FormulaQtyValue4Name).AsFloat
  else if sametext(VArname , 'Field5') then Value := Dataset.Fieldbyname(FormulaQtyValue5Name).AsFloat
  else Exit;
  FieldFound := True;
end;


procedure TBOMListImport.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PartsId');
  SetPropertyFromNode(node,'Partname');
end;


procedure TBOMListImport.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PartsId' ,PartsId);
  AddXMLNode(node,'Partname' ,Partname);
end;

function TBOMListImport.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if Partname = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Partname should not be blank' , True);
    Exit;
  end;
  Result := True;
end;


function TBOMListImport.Save: Boolean ;
begin
  PostDB;
  SendEvent(BusObjEvent_Todo, BusObjEventVal_OnBeforeSave, Self);
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TBOMListImport.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TBOMListImport.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TBOMListImport.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TBOMListImport.GetIDField: string;
begin
  Result := 'ID'
end;



class function TBOMListImport.GetBusObjectTablename: string;
begin
  Result:= 'tblbomlistimport';
end;


function TBOMListImport.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterOpen(Sender);
  if not result then exit;
  if fiLevels < trunc((Dataset.fieldcount-5)/3)+1 then
     fiLevels :=  trunc((Dataset.fieldcount-5)/3)+1; // to cope with the items in importing table
end;

function TBOMListImport.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TBOMListImport.getProduct: TProduct;
begin
  if PartsId <> 0 then
    Result := TProduct(Getcontainercomponent(TProduct, 'PartsId = ' + IntToStr(PartsId), True, True))
  else Result := TProduct(Getcontainercomponent(TProduct, 'PartName = ' + Quotedstr(StringDataForSQL(PartName)), True, True));

end;
{Property Functions}
function  TBOMListImport.GetPartsId         : Integer  ; begin Result := GetIntegerField('PartsId')       ;end;
function  TBOMListImport.GetPartname        : string   ; begin Result := GetStringField('Partname')       ;end;
procedure TBOMListImport.SetPartsId         (const Value: Integer  ); begin SetIntegerField('PartsId'       , Value);end;
procedure TBOMListImport.SetPartname        (const Value: string   ); begin SetStringField('Partname'       , Value);end;
initialization
  RegisterClass(TBOMListImport);
  BusObjectListObj.TBusObjInfoList.Inst.Add('BOM List','TBOMListImport','' , []);
end.
