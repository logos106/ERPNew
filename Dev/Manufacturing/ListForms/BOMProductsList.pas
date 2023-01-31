unit BOMProductsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup;

type
  TBOMProductsListGUI = class(TBaseListingGUI)
    qryMainpartsId: TIntegerField;
    qryMainpartname: TWideStringField;
    qryMainPactive: TWideStringField;
    cmdImport: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure cmdImportClick(Sender: TObject);
  private
    procedure NewStringField(const fsFieldname: String);
    procedure NewintField(const fsFieldname: String);
    Procedure newfloatfield(const fsfieldname:String; currencyfield:Boolean = False);
    function Grouplabel(ctr: Integer): String;
  Protected
    procedure SetGridColumns; Override;

  public
    Procedure RefreshQuery;Override;
    procedure DoExportdata(const Exportfilename:String);Override;
  end;


implementation

uses tcDataUtils, CommonLib, AppEnvironment, LogLib, DatasetExporter,
  CommonFormLib, tcConst;

{$R *.dfm}

{ TBOMProductsListGUI }
procedure TBOMProductsListGUI.DoExportdata(const Exportfilename: String);
var
  DE : TERPQueryExporter;
begin
    //inherited;
    Processingcursor(True);
    try
      DE:= TERPQueryExporter.create(Self);
          try
            QryMainPartsId.index := 0;
            DE.Query                  := QryMain;
            DE.FieldsToexclude        := 'ID,Caption1,Quantity1';
            //DE.Grid                   := grdMain;
            DE.fileName               := Exportfilename;
            DE.DefaultExtension       := ExtractFileExt(Exportfilename);
            DE.RemoveNonPrintablechar := True;
            DE.FieldNameAsColumnLabel := True;
            if DE.DoExport <> '' then
              MessageDlgXP_Vista('''BOM List'' is exported to  ' + chr(13) + Quotedstr(Exportfilename)+ '.', mtInformation, [mbOK], 0)
            else MessageDlgXP_Vista('Exporting ''BOM List'' Failed.', mtWarning, [mbOK], 0);
      finally
        FreeandNil(DE);
      end;
    finally
      ProcessingCursor(False);
    end;
end;

procedure TBOMProductsListGUI.cmdImportClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmImportBOM', 0);
  Closewait;
end;
  Function TBOMProductsListGUI.Grouplabel(ctr:Integer) :String;
  begin
    if ctr = 1 then     Result := 'BOM Product'
    else     REsult := 'Level ' + trim(inttostr(ctr-1));
  end;

procedure TBOMProductsListGUI.FormCreate(Sender: TObject);
var
  fiLevels : Integer;
  ctr:Integer;
  fiFormulaQtys:Integer;
  s1 , s2:String;
  //PTCtr :Integer;
begin
  Showcontrolhint(cmdImport , 'Importing will delete the existing Tree for the product.' +NL+
                             'Newly Imported Tree will have 1 Process Step(Assembly) for a Minute on the Root Node.  ' +
                             'Remember to Alter this if Required Before Using it on a Transaction');
  IsGridcustomisable      := false;
  fiLevels := BOMTreeLevels+1;
  HaveDateRangeSelection := false;
  closedb(qrymain);
  Qrymain.sql.clear;


  Qrymain.sql.Add('select');
  Qrymain.sql.Add('P.partsId as  partsId ,');
  Qrymain.sql.Add('P.partname as  partname ,');
  if fiLevels > 1 then
    For ctr := 1 to fiLevels do begin
      Qrymain.sql.Add('PT' + trim(inttostr(ctr))+'.Caption as Caption' + trim(inttostr(ctr))+',');
      Qrymain.sql.Add('convert(PT' + trim(inttostr(ctr))+'.comments , char(255)) as comments' + trim(inttostr(ctr))+',');
      Qrymain.sql.Add('Round(PT' + trim(inttostr(ctr))+'.Quantity, 5) as Quantity' + trim(inttostr(ctr))+',');
      Qrymain.sql.Add('CONVERT(PT' + trim(inttostr(ctr))+'.Info, CHAR(255)) as Info' + trim(inttostr(ctr))+',');
      Qrymain.sql.Add('PT' + trim(inttostr(ctr))+'.ProductUnitPrice as ProductUnitPrice' + trim(inttostr(ctr))+',');
      Qrymain.sql.Add('CONVERT(PT' + trim(inttostr(ctr))+'.Description , CHAR(255)) as Description' + trim(inttostr(ctr))+',');
      Qrymain.sql.Add('PF' + trim(inttostr(ctr))+'.FormulaName as FormulaName' + trim(inttostr(ctr))+',');
      Qrymain.sql.Add('PT' + trim(inttostr(ctr))+'.Buildlineno as Buildlineno' + trim(inttostr(ctr))+',');
      Qrymain.sql.Add('PF' + trim(inttostr(ctr))+'.Formula as Formula' + trim(inttostr(ctr))+',');
            for fiFormulaQtys := 1 to 5 do begin
              Qrymain.sql.Add('PT' + trim(inttostr(ctr))+'.FormulaQtyValue' + trim(inttostr(fiformulaQtys))+' as FormulaQtyValue' + trim(inttostr(ctr))+'_'+ trim(inttostr(fiformulaQtys))+',');
            end;
      Qrymain.sql.Add('PT' + trim(inttostr(ctr))+'.TreePricechanged as TreePricechanged' + trim(inttostr(ctr))+',');
    end;
  s1:= ''; s2:= '';
  For ctr := fiLevels downto 1 do begin
    s1:= s1 +'if(ifnull(PT'+ trim(inttostr(ctr))+'.ProctreeId,0)<> 0 , PT'+ trim(inttostr(ctr))+'.SequenceDown , ';
    s2:= s2 +')';
  end;
  if s1<> '' then Qrymain.sql.Add('CONVERT('+s1+'0'+s2+', signed)    as Sequencedown,');

  Qrymain.sql.Add('P.active as Pactive');
  Qrymain.sql.Add('from tblparts P');
  Qrymain.sql.Add('inner join tblproctree PT1 on PT1.MasterId = P.partsId and PT1.MasterType ="mtProduct" and PT1.TreeRootId = PT1.ProcTreeId');
  if fiLevels > 1 then
    For ctr := 2 to  fiLevels do begin
      Qrymain.sql.Add('Left join tblproctree  as PT' + trim(inttostr(ctr))+'  on PT' + trim(inttostr(ctr))+'.ParentId = PT' + trim(inttostr(ctr-1))+'.ProcTreeId ');
    end;
  if fiLevels > 1 then
    For ctr := fiLevels downto 1 do
        Qrymain.sql.Add(' Left join tblfeformula PF'+ trim(inttostr(ctr))+' on PF'+ trim(inttostr(ctr))+'.FormulaID = PT'+ trim(inttostr(ctr))+'.FormulaID' );


  Qrymain.sql.Add('order by P.partname , SequenceDown');


  clog(qrymain.sql.text);

  grdmain.selected.clear;

  inherited;
  if fiLevels > 1 then
    For ctr := 1 to  fiLevels do begin
          NewStringfield('caption'    + trim(inttostr(ctr)));
          NewStringfield('comments'    + trim(inttostr(ctr)));
          Newfloatfield('Quantity' + trim(inttostr(ctr)));
          NewStringfield('FormulaName'+ trim(inttostr(ctr)));
          NewintField('Buildlineno'+ trim(inttostr(ctr)));
          NewStringfield('Formula'    + trim(inttostr(ctr)));
          NewStringfield('Description'+ trim(inttostr(ctr)));
          NewStringfield('Info'       + trim(inttostr(ctr)));

          for fiFormulaQtys := 1 to 5 do
            Newfloatfield('FormulaQtyValue' + trim(inttostr(ctr))+'_'+ trim(inttostr(fiformulaQtys)));
           Newfloatfield('ProductUnitPrice' + trim(inttostr(ctr)));
           NewStringfield('TreePricechanged' + trim(inttostr(ctr)));
      end;

  ctr:= 1;
  grdmain.selected.Clear;
  grdmain.selected.add(SelectedText('partname' ,DoTranslate(AppEnv.DefaultClass.PartColumn) ,20 , Grouplabel(ctr)));
  if fiLevels > 1 then
    For ctr := 2 to  fiLevels do begin
      grdmain.selected.add(SelectedText('caption'    + trim(inttostr(ctr)) ,'Caption' ,15 ,  Grouplabel(ctr)));
      grdmain.selected.add(SelectedText('comments'    + trim(inttostr(ctr)) ,'comments' ,15 ,  Grouplabel(ctr)));
      grdmain.selected.add(SelectedText('Quantity'   + trim(inttostr(ctr)) ,'Quantity' ,15 ,  Grouplabel(ctr)));
      grdmain.selected.add(SelectedText('Description'+ trim(inttostr(ctr)) ,'Description' ,15 ,  Grouplabel(ctr)));
      grdmain.selected.add(SelectedText('Info'       + trim(inttostr(ctr)) ,'Info' ,15 ,  Grouplabel(ctr)));
      if Appenv.companyprefs.FeFieldVisible then begin
        grdmain.selected.add(SelectedText('FormulaName'+ trim(inttostr(ctr)) ,'Formula Name' ,15 ,  Grouplabel(ctr)));
        grdmain.selected.add(SelectedText('Formula'    + trim(inttostr(ctr)) ,'Formula' ,15 ,  Grouplabel(ctr)));
        grdmain.selected.add(SelectedText('Buildlineno'    + trim(inttostr(ctr)) ,'Line No' ,15 ,  Grouplabel(ctr)));
        if Appenv.companyprefs.Fe1Visible then grdmain.selected.add(SelectedText('FormulaQtyValue' + trim(inttostr(ctr))+'_1',AppEnv.companyPrefs.Fe1Name ,10 ,  Grouplabel(ctr)));
        if Appenv.companyprefs.Fe2Visible then grdmain.selected.add(SelectedText('FormulaQtyValue' + trim(inttostr(ctr))+'_2',AppEnv.companyPrefs.Fe2Name ,10 ,  Grouplabel(ctr)));
        if Appenv.companyprefs.Fe3Visible then grdmain.selected.add(SelectedText('FormulaQtyValue' + trim(inttostr(ctr))+'_3',AppEnv.companyPrefs.Fe3Name ,10 ,  Grouplabel(ctr)));
        if Appenv.companyprefs.Fe4Visible then grdmain.selected.add(SelectedText('FormulaQtyValue' + trim(inttostr(ctr))+'_4',AppEnv.companyPrefs.Fe4Name ,10 ,  Grouplabel(ctr)));
        if Appenv.companyprefs.Fe5Visible then grdmain.selected.add(SelectedText('FormulaQtyValue' + trim(inttostr(ctr))+'_5',AppEnv.companyPrefs.Fe5Name ,10 ,  Grouplabel(ctr)));
      end;
      grdmain.selected.add(SelectedText('ProductUnitPrice' + trim(inttostr(ctr)) ,'Unit Price' ,15 ,  Grouplabel(ctr)));
      grdmain.selected.add(SelectedText('TreePricechanged' + trim(inttostr(ctr)) ,'Price Changed' ,15 ,  Grouplabel(ctr)));
    end;

  grdmain.selected.add(SelectedText('PActive'     ,DoTranslate('Active ?') ,5 , ''));
  grdmain.ApplySelected;

end;
procedure TBOMProductsListGUI.NewintField(const fsFieldname: String);
begin
  if Qrymain.findfield(fsFieldname) = nil then begin
        with TIntegerField.Create(Qrymain) do begin
            fieldKind := fkData;
            Fieldname := fsFieldname ;
            name := 'Qrymain'+fsFieldname ;
            DataSet := Qrymain;
            Displaylabel := fsFieldname ;
          end;
  end;
end;
Procedure TBOMProductsListGUI.NewStringField(Const fsFieldname:String);
begin
  if Qrymain.findfield(fsFieldname) = nil then begin
        with TWideStringField.Create(Qrymain) do begin
            fieldKind := fkData;
            Fieldname := fsFieldname ;
            size := 255;
            DisplayWidth := 255;
            name := 'Qrymain'+fsFieldname ;
            DataSet := Qrymain;
            Displaylabel := fsFieldname ;
          end;
  end;
end;
Procedure TBOMProductsListGUI.newfloatfield(const fsFieldname:String; currencyfield:Boolean = False);
begin
  if Qrymain.findfield(fsFieldname) = nil then begin
        with TFloatField.Create(Qrymain) do begin
            fieldKind := fkData;
            fieldname := fsFieldname ;
            DisplayWidth := 10;
            name := 'Qrymain'+fsFieldname ;
            DataSet := Qrymain;
            Currency := currencyfield;
            Displaylabel := fsFieldname ;
          end;
  end;
end;

procedure TBOMProductsListGUI.RefreshQuery;
begin
  inherited;
end;

procedure TBOMProductsListGUI.SetGridColumns;
begin
  inherited;
end;

initialization
  RegisterClassOnce(TBOMProductsListGUI);
end.
