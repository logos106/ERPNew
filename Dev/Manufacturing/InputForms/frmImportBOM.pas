unit frmImportBOM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmImportDataMapping, ActnList, DB, ProgressDialog, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog, Menus, ExtCtrls, AdvEdit, StdCtrls, wwclearbuttongroup,
  wwradiogroup, Wwdotdot, Wwdbcomb, Mask, wwdbedit, Shader, wwcheckbox,
  DNMSpeedButton, Grids, AdvObj, BaseGrid, AdvGrid, DNMPanel , busobjbase,
  JSONObject, ExportDataObj;

type
  TfmImportBOM = class(TfmImportDataMapping)
    procedure FormShow(Sender: TObject);
    procedure actImportExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMapCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
  private
    procedure ListintoTree;
  Protected
    Procedure DoDataMapEvent(const DataExporter : TDataExporter; Busobj :TMsBusobj;Map: TJsonObject;   EventValue: string);Override;
  public
  end;

implementation

uses CommonLib, tcDataUtils, DbSharedObjectsObj, CommonDbLib, BusObjConst,
  BusobjBOMList, StringUtils, tcConst, LogLib;

{$R *.dfm}

procedure TfmImportBOM.actImportExecute(Sender: TObject);
var
  scr :TERPScript;
begin
  scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
    if (Commondblib.tableExists('tblBOMListImport'))  then begin
        scr.SQL.Add('truncate tblbomlistimport;');
        scr.Execute;
    end;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;
  TBOMListImport.MakeTable(trunc(grdMap.RowCount/12));

  ImportOK := False;
  inherited;
  if not ImportOK then exit;

  DoShowProgressbar( 10 , WAITMSG, '', true , true);
  try
    dostepProgressbar;
    ListIntoTree;
  finally
    dohideprogressbar;
  end;

  Self.close;
end;
Procedure TfmImportBOM.ListintoTree;
var
  BOMListImport : TBOMListImport;
  QryBOMParts: TERPQuery;
  ErrorMsgs:TStringlist;
begin
  ErrorMsgs:= TStringlist.create;
  try
    QryBOMParts := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      QryBOMParts.SQL.text := 'Select Distinct PartsId, Partname from tblbomlistimport order by partname';
      QryBOMParts.open;
      if QryBOMParts.recordcount =0 then exit;
      QryBOMParts.First;
      While QryBOMParts.Eof = False do begin
          BOMListImport := TBOMListImport.CreateWithNewConn(Self);
          try
            BOMListImport.SQLOrder := 'ID';
            BOMListImport.loadSelect('Partname = ' + Quotedstr(StringReplace(QryBOMParts.fieldbyname('Partname').asString,'\','\\',[rfReplaceAll])));

            if BOMListImport.count =0 then begin
              Logtext('Failed to import : ' + QryBOMParts.fieldbyname('Partname').asString);
              QryBOMParts.Next;
              Continue;
            end;
            if not BOMListImport.ListintoTree then begin
              ErrorMsgs.add(BOMListImport.ListintoTreeError);
            end;
          finally
            Freeandnil(BOMListImport);
          end;
          QryBOMParts.Next;
          dostepProgressbar(QryBOMParts.fieldbyname('Partname').asString+ '   ' + inttostr(QryBOMParts.recno)+' of ' + inttostr(QryBOMParts.recordcount));
      end;
      dohideprogressbar;
      if ErrorMsgs.count <> 0 then begin
        MessageDlgXP_Vista(ErrorMsgs.TExt, mtWarning, [mbOK], 0);
        if devmode then ErrorMsgs.Savetofile('d:\ErrorMsgs.log');
      end
      else MessageDlgXP_Vista('Import Completed.', mtWarning, [mbOK], 0)
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(QryBOMParts);
    end;
  finally
    Freeandnil(ErrorMsgs);
  end;

end;

procedure TfmImportBOM.DoDataMapEvent(const DataExporter: TDataExporter;Busobj: TMsBusobj; Map: TJsonObject;  EventValue: string);
var
  x:Integer;
  MapedItem: TJsonValuePair;
  fieldname :String;

  function isLevelfield(const FieldPrefix:String):Boolean;
  begin
    result := False;
    if length(fieldname) <length(FieldPrefix)+1 then exit;
    if not sametext(copy(fieldname , 1, length(FieldPrefix)) , FieldPrefix) then exit;
    if not isinteger(replacestr(fieldname , FieldPrefix , '')) then exit;
    Result := True;
  end;
  function CaptionField           :boolean;  begin    result := isLevelfield('Caption')           ;end;
  function QuantityField          :boolean;  begin    result := isLevelfield('Quantity')          ;end;
  function PartsIdField           :boolean;  begin    result := isLevelfield('PartsId')           ;end;
  function FormulaNameField       :boolean;  begin    result := isLevelfield('FormulaName')       ;end;
  function ProductUnitPriceField  :boolean;  begin    result := isLevelfield('ProductUnitPrice')  ;end;
  function InfoField              :boolean;  begin    result := isLevelfield('Info')              ;end;
  function DescriptionField       :boolean;  begin    result := isLevelfield('Description')       ;end;
  function commentsField          :boolean;  begin    result := isLevelfield('comments')          ;end;
  function BuildLineNoField       :boolean;  begin    result := isLevelfield('BuildLineNo')       ;end;
  function FormulaQtyValue1_Field :boolean;  begin    result := isLevelfield('FormulaQtyValue1_') ;end;
  function FormulaQtyValue2_Field :boolean;  begin    result := isLevelfield('FormulaQtyValue2_') ;end;
  function FormulaQtyValue3_Field :boolean;  begin    result := isLevelfield('FormulaQtyValue3_') ;end;
  function FormulaQtyValue4_Field :boolean;  begin    result := isLevelfield('FormulaQtyValue4_') ;end;
  function FormulaQtyValue5_Field :boolean;  begin    result := isLevelfield('FormulaQtyValue5_') ;end;
  function TreePricechangedField  :boolean;  begin    result := isLevelfield('TreePricechanged')  ;end;
begin
  inherited;
  if (EventValue = BusObjEventVal_OnBeforeSave  ) then begin
    if busobj is TBOMListImport then begin
      if Assigned (Map) then begin
            for x:= 0 to Map.Count -1 do begin
              MapedItem:= Map.Items[x];
                fieldname := MapedItem.name;
                try if CaptionField           then if busobj.Dataset.FindField(fieldname) <> nil then begin busobj.Editdb; busobj.Dataset.FindField(fieldname).AsString := MapedItem.Value.AsString; end; Except end;
                try if Quantityfield          then if busobj.Dataset.FindField(fieldname) <> nil then begin busobj.Editdb; busobj.Dataset.FindField(fieldname).asFloat  := MapedItem.Value.asFloat; end; Except end;
                try if PartsIdfield           then if busobj.Dataset.FindField(fieldname) <> nil then begin busobj.Editdb; busobj.Dataset.FindField(fieldname).asInteger:= MapedItem.Value.asInteger; end; Except end;
                try if FormulaNameField       then if busobj.Dataset.FindField(fieldname) <> nil then begin busobj.Editdb; busobj.Dataset.FindField(fieldname).asString := MapedItem.Value.asString; end; Except end;
                try if ProductUnitPriceField  then if busobj.Dataset.FindField(fieldname) <> nil then begin busobj.Editdb; busobj.Dataset.FindField(fieldname).asFloat  := MapedItem.Value.asFloat; end; Except end;
                try if InfoField              then if busobj.Dataset.FindField(fieldname) <> nil then begin busobj.Editdb; busobj.Dataset.FindField(fieldname).asString := MapedItem.Value.asString; end; Except end;
                try if DescriptionField       then if busobj.Dataset.FindField(fieldname) <> nil then begin busobj.Editdb; busobj.Dataset.FindField(fieldname).asString := MapedItem.Value.asString; end; Except end;
                try if commentsField          then if busobj.Dataset.FindField(fieldname) <> nil then begin busobj.Editdb; busobj.Dataset.FindField(fieldname).asString := MapedItem.Value.asString; end; Except end;
                try if BuildLineNoField       then if busobj.Dataset.FindField(fieldname) <> nil then begin busobj.Editdb; busobj.Dataset.FindField(fieldname).asString := MapedItem.Value.asString; end; Except end;
                try if FormulaQtyValue1_Field then if busobj.Dataset.FindField(fieldname) <> nil then begin busobj.Editdb; busobj.Dataset.FindField(fieldname).asFloat  := MapedItem.Value.asFloat; end; Except end;
                try if FormulaQtyValue2_Field then if busobj.Dataset.FindField(fieldname) <> nil then begin busobj.Editdb; busobj.Dataset.FindField(fieldname).asFloat  := MapedItem.Value.asFloat; end; Except end;
                try if FormulaQtyValue3_Field then if busobj.Dataset.FindField(fieldname) <> nil then begin busobj.Editdb; busobj.Dataset.FindField(fieldname).asFloat  := MapedItem.Value.asFloat; end; Except end;
                try if FormulaQtyValue4_Field then if busobj.Dataset.FindField(fieldname) <> nil then begin busobj.Editdb; busobj.Dataset.FindField(fieldname).asFloat  := MapedItem.Value.asFloat; end; Except end;
                try if FormulaQtyValue5_Field then if busobj.Dataset.FindField(fieldname) <> nil then begin busobj.Editdb; busobj.Dataset.FindField(fieldname).asFloat  := MapedItem.Value.asFloat; end; Except end;
                try if TreePricechangedField  then if busobj.Dataset.FindField(fieldname) <> nil then begin busobj.Editdb; busobj.Dataset.FindField(fieldname).asString := MapedItem.Value.asString; end; Except end;
            end;
      end;
    end;
  end;
end;

procedure TfmImportBOM.FormCreate(Sender: TObject);
begin
  Showcontrolhint(btnImport , 'Importing will delete the existing Tree for the product.' +NL+
                             'Newly Imported Tree will have 1 Process Step(Assembly) for a Minute on the Root Node.  ' +
                             'Remember to Alter this if Required Before Using it on a Transaction');
  TBOMListImport.MakeTable(BOMTreeLevels+1);
  inherited;
  ReadNonMappedfields := True;
  SavencloseonImport := False;
end;

procedure TfmImportBOM.FormShow(Sender: TObject);
begin
  KeyId := BOMListImportDataMapID;
  inherited;
  if KeyId =0 then begin
    DataMap.typename := 'BOM List';
    DataMap.ImportName := 'BOM List Import';
    DataMap.PostDB;
  end;
  cboImportType.Enabled := False;
  showcontrolhint(grdMap , 'Please Ignore Maping, This is Automatically Done');
  grdMap.HideColumn(Col_MapField);
  grdMap.HideColumn(Col_DataType);
  grdMap.HideColumn(Col_Format);
end;
procedure TfmImportBOM.grdMapCanEditCell(Sender: TObject; ARow, ACol: Integer;  var CanEdit: Boolean);
begin
  inherited;
  CanEdit := false;
end;

initialization
  RegisterClassOnce(TfmImportBOM);

end.
