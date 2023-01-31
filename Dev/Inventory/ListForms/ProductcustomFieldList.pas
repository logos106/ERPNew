unit ProductcustomFieldList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , BusObjBase;

type
  TProductcustomFieldListGUI = class(TBaseListingGUI)
    qryMainPARTSID: TIntegerField;
    qryMainPARTTYPE: TWideStringField;
    qryMainPARTNAME: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    qryMainPARTSDESCRIPTION: TWideStringField;
    qryMainPURCHASEDESC: TWideStringField;
    qryMainCOST1: TFloatField;
    qryMainAvgCost: TFloatField;
    qryMainCOSTINC1: TFloatField;
    qryMainPRICE1: TFloatField;
    qryMainPRICEINC1: TFloatField;
    qryMainActive: TWideStringField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMaincUSTFLD15: TWideStringField;
    qryMainCUSTDATE1: TDateTimeField;
    qryMainCUSTDATE2: TDateTimeField;
    qryMainCUSTDATE3: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fstablename : String;
    Procedure MakeQrymain;
    procedure updateCustfields(const Sender: TBusObj; var Abort: Boolean);
    procedure PopulateQrymainfields(const Sender: TBusObj; var Abort: Boolean);
  Protected
    Procedure SetGridColumns;override;
  public
  end;

implementation

uses CommonDbLib, DbSharedObjectsObj, Busobjcustomfields , tcConst, CommonLib;

{$R *.dfm}

{ TProductcustomFieldListGUI }

procedure TProductcustomFieldListGUI.FormCreate(Sender: TObject);
begin
  fstablename := commondblib.GetUserTemporaryTableName('Prod_custom');
  MakeQrymain;
  HaveDateRangeSelection := False;
  Qrymain.SQL.Text := 'select * from ' + fsTablename ;
  inherited;

end;

procedure TProductcustomFieldListGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  inherited;
end;

procedure TProductcustomFieldListGUI.MakeQrymain;
var
  fsCustomFieldList :String;
  CustomFieldList : TCustomFieldList;
begin
  closedb(Qrymain);
  fsCustomFieldList :='';
  CustomFieldList:= TCustomFieldList.CreateWithNewConn(Self);
  try
    CustomFieldList.LoadSelect('ListType= ' + quotedstr(ListTypetoString(ltProducts)));
    if CustomFieldList.count >0 then fsCustomFieldList := CustomFieldList.TableStructureSQL;

        With Scriptmain do begin
            SQL.clear;
            SQL.add('drop table if exists ' + fstablename +';');
            SQL.add('Create table ' + fsTablename +'  ( ' +
                          ' PARTSID INT(11) NOT NULL, ' +
                          ' PARTTYPE VARCHAR(13) NULL DEFAULT NULL, ' +
                          ' PARTNAME VARCHAR(60) NULL DEFAULT NULL, ' +
                          ' ProductPrintName VARCHAR(255) NULL DEFAULT NULL, ' +
                          ' PARTSDESCRIPTION VARCHAR(255) NULL DEFAULT NULL, ' +
                          ' PURCHASEDESC VARCHAR(255) NULL DEFAULT NULL, ' +
                          ' COST1 DOUBLE NOT NULL DEFAULT 0, ' +
                          ' AvgCost DOUBLE NOT NULL DEFAULT 0, ' +
                          ' COSTINC1 DOUBLE NOT NULL DEFAULT 0, ' +
                          ' PRICE1 DOUBLE NOT NULL DEFAULT 0, ' +
                          ' PRICEINC1 DOUBLE NOT NULL DEFAULT 0, ' +
                          ' Active ENUM("T","F") NOT NULL DEFAULT "T" , ' +
                          ' CUSTFLD1 VARCHAR(255) NULL DEFAULT NULL, ' +
                          ' CUSTFLD2 VARCHAR(255) NULL DEFAULT NULL, ' +
                          ' CUSTFLD3 VARCHAR(255) NULL DEFAULT NULL, ' +
                          ' CUSTFLD4 VARCHAR(255) NULL DEFAULT NULL, ' +
                          ' CUSTFLD5 VARCHAR(255) NULL DEFAULT NULL, ' +
                          ' CUSTFLD6 VARCHAR(255) NULL DEFAULT NULL, ' +
                          ' CUSTFLD7 VARCHAR(255) NULL DEFAULT NULL, ' +
                          ' CUSTFLD8 VARCHAR(255) NULL DEFAULT NULL, ' +
                          ' CUSTFLD9 VARCHAR(255) NULL DEFAULT NULL, ' +
                          ' CUSTFLD10 VARCHAR(255) NULL DEFAULT NULL, ' +
                          ' CUSTFLD11 VARCHAR(255) NULL DEFAULT NULL, ' +
                          ' CUSTFLD12 VARCHAR(255) NULL DEFAULT NULL, ' +
                          ' CUSTFLD13 VARCHAR(255) NULL DEFAULT NULL, ' +
                          ' CUSTFLD14 VARCHAR(255) NULL DEFAULT NULL, ' +
                          ' CUSTFLD15 VARCHAR(255) NULL DEFAULT NULL, ' +
                          ' CUSTDATE1 DATETIME NULL DEFAULT NULL, ' +
                          ' CUSTDATE2 DATETIME NULL DEFAULT NULL, ' +
                          ' CUSTDATE3 DATETIME NULL DEFAULT NULL, ' +
                          fsCustomFieldList +
                          ' PRIMARY KEY (PARTSID) ) ENGINE=Myisam;');
            SQL.add('insert ignore into ' + fsTablename +'  ( PARTSID,PARTTYPE,PARTNAME ,ProductPrintName ,PARTSDESCRIPTION ,PURCHASEDESC ,'+
                                                              'COST1 ,AvgCost,COSTINC1,PRICE1 ,PRICEINC1 ,Active ,'+
                                                              'CUSTFLD1 ,CUSTFLD2 ,CUSTFLD3 ,CUSTFLD4 ,CUSTFLD5 ,CUSTFLD6 ,CUSTFLD7 ,CUSTFLD8 ,CUSTFLD9 ,CUSTFLD10 ,CUSTFLD11 ,CUSTFLD12 ,CUSTFLD13 ,CUSTFLD14 ,CUSTFLD15 ,'+
                                                              'CUSTDATE1 ,CUSTDATE2 ,CUSTDATE3 ) ' +
                                                        ' Select PARTSID,PARTTYPE,PARTNAME ,ProductPrintName ,PARTSDESCRIPTION ,PURCHASEDESC ,'+
                                                              'COST1 ,AvgCost,COSTINC1,PRICE1 ,PRICEINC1 ,Active ,'+
                                                              'CUSTFLD1 ,CUSTFLD2 ,CUSTFLD3 ,CUSTFLD4 ,CUSTFLD5 ,CUSTFLD6 ,CUSTFLD7 ,CUSTFLD8 ,CUSTFLD9 ,CUSTFLD10 ,CUSTFLD11 ,CUSTFLD12 ,CUSTFLD13 ,CUSTFLD14 ,CUSTFLD15 ,'+
                                                              'CUSTDATE1 ,CUSTDATE2 ,CUSTDATE3  from tblparts;');
            CustomFieldList.IterateRecords(updateCustfields);
            DoShowProgressbar(SQL.Count , WAITMSG);
            try
              Execute;
            finally
              dohideProgressbar;
            end;
        end;
        CustomFieldList.IterateRecords(PopulateQrymainfields);
  finally
    Freeandnil(CustomFieldList);
  end;
end;
Procedure TProductcustomFieldListGUI.PopulateQrymainfields(const Sender: TBusObj;      var Abort: Boolean);
var
  fsFieldname :String;

begin
    if Sender is TCustomFieldList then begin
      fsfieldName := 'CUSTFLDLIST' + trim(inttostr(TCustomFieldList(SendeR).ID));
      if Qrymain.findfield(fsFieldname) = nil then begin
        With TWideStringfield.Create(qryMain) do begin
          fieldKind := fkData;
          fieldname := fsFieldname;
          DataSet   := qryMain;
          Visible   := true;
          DisplayLabel := TCustomFieldList(SendeR).Description;
          //Displaywidth := 255;
          grdmain.selected.Add(SelectedText(fsfieldname, Displaylabel, DisplayWidth , 'Customisable List'));
        end;
      end;
    end;
end;

procedure TProductcustomFieldListGUI.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Product');
  RemoveFieldfromGrid(qryMainPartsId.Fieldname);
end;

Procedure TProductcustomFieldListGUI.updateCustfields(const Sender: TBusObj;      var Abort: Boolean);
begin
    if Sender is TCustomFieldList then begin
      With Scriptmain do begin
        SQL.Add('update ' + fsTablename +' P  inner join tblcustomfieldvaluesProducts CFV_P on CFV_P.masterId = P.partsId and CFV_P.CustomFieldListID = ' + inttostr(TCustomFieldList(SendeR).ID)+
                  ' Set P.CUSTFLDLIST' + trim(inttostr(TCustomFieldList(SendeR).ID))+ ' = CFV_P.Value ;'   )
      end;
    end;
end;

Initialization
RegisterClassOnce(TProductcustomFieldListGUI);

end.
