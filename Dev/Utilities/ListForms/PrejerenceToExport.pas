unit PrejerenceToExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel , BusObjPrejerenceToExport;

type
  TPrejerenceToExportGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainPreftypeno: TIntegerField;
    qryMainPrefID: TIntegerField;
    qryMainreftype: TWideStringField;
    qryMainPreftype: TWideStringField;
    qryMainpage: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainGroupDesc: TWideStringField;
    qryMainPrefname: TWideStringField;
    qryMainFieldValue: TWideMemoField;
    qryMaindefaultValue: TWideMemoField;
    qryMainmstimeStamp: TDateTimeField;
    qryMainFieldType: TWideStringField;
    qryMaincFieldValue: TWideStringField;
    qryMaincdefaultValue: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    PrejerenceToExportObj : TPrejerenceToExport;
    Procedure MakeQrymain;
  Protected
    procedure SetGridColumns; Override;
  public
  end;


implementation

uses CommonDbLib, tcConst, CommonLib;

{$R *.dfm}

procedure TPrejerenceToExportGUI.FormCreate(Sender: TObject);
begin
  PrejerenceToExportObj := TPrejerenceToExport.Create(Self);
  MakeQrymain;
  inherited;
  HaveDateRangeSelection := False;
end;
procedure TPrejerenceToExportGUI.FormDestroy(Sender: TObject);
begin
  FreeandNil(PrejerenceToExportObj);
  inherited;
end;

procedure TPrejerenceToExportGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
{  if ((*(Pos('COLOUR', uppercase(qrymainDescription.asString))>0)*) (Qrymainreftype.asString ='Colour') and (isinteger(Qrymainfieldvalue.asString  )) and (strtoint(Qrymainfieldvalue.asString  )<>0) and sametext(Field.fieldname , QrymaincfieldValue.fieldname  )) OR
     ((*(Pos('COLOUR', uppercase(qrymainDescription.asString))>0)*) (Qrymainreftype.asString ='Colour') and (isinteger(QrymainDefaultValue.asString)) and (strtoint(QrymainDefaultValue.asString)<>0) and sametext(Field.fieldname , QrymainCDefaultValue.fieldname)) then  begin}
    try
      if ((Qrymainreftype.asString ='Colour') and
          (sametext(Field.fieldname , QrymaincfieldValue.fieldname) or  sametext(Field.fieldname , QrymainCDefaultValue.fieldname)) and
          (trim(Field.asString)<> '') and
          (isinteger(Field.asString  )) and
          (strtoint(Field.asString  )<>0)) then
          if sametext(Field.fieldname , QrymaincfieldValue.fieldname) then begin
            Abrush.color := strtoint(QrymaincfieldValue.asString);
            AFont.color := Abrush.color;
          end else if  sametext(Field.fieldname , QrymainCDefaultValue.fieldname) then begin
            Abrush.color := strtoint(QrymainDefaultValue.asString);
            AFont.color := Abrush.color;
          end;
    Except
      on E:Exception do begin end;
    end;
end;

procedure TPrejerenceToExportGUI.MakeQrymain;
begin
  Qrymain.SQL.Clear;
  Qrymain.SQL.add('Select');
  Qrymain.SQL.add('ID	            As ID,');
  Qrymain.SQL.add('Preftypeno	    As Preftypeno	,');
  Qrymain.SQL.add('PrefID	        As PrefID	,');
  Qrymain.SQL.add('reftype	      As reftype	,');
  Qrymain.SQL.add('Preftype	      As Preftype	,');
  Qrymain.SQL.add('page	          As page	,');
  Qrymain.SQL.add('Description	  As Description	,');
  Qrymain.SQL.add('GroupDesc	    As GroupDesc	,');
  Qrymain.SQL.add('Prefname	      As Prefname	,');
  Qrymain.SQL.add('FieldValue	    As FieldValue	,');
  Qrymain.SQL.add('defaultValue	  As defaultValue	,');
  Qrymain.SQL.add('mstimeStamp	  As mstimeStamp	,');
  Qrymain.SQL.add('FieldType	    As FieldType');
  Qrymain.SQL.add('from ' + PrejerenceToExportObj.BusObjectTablename);
  Qrymain.SQL.add('Order by page , GroupDesc ,Description');
end;

procedure TPrejerenceToExportGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMaincfieldValue.asString := TPrejerenceToExport.formatedfieldValue(QrymainfieldValue.asString , qrymainreftype.asString, qryMainFieldType.asString, QrymaingroupDesc.asString, Qrymaindescription.asString);
  qryMaincDefaultValue.asString := TPrejerenceToExport.formatedfieldValue(QrymainDefaultValue.asString , qrymainreftype.asString, qryMainFieldType.asString, Qrymaindescription.asString);
end;

procedure TPrejerenceToExportGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainID.fieldname);
  RemoveFieldfromGrid(qryMainPreftypeno.fieldname);
  RemoveFieldfromGrid(qryMainPrefID.fieldname);
  RemoveFieldfromGrid(qryMainPreftype.fieldname);
  RemoveFieldfromGrid(qryMainReftype.fieldname);
  RemoveFieldfromGrid(qryMainmstimeStamp.fieldname);
  RemoveFieldfromGrid(qryMainFieldType.fieldname);
  RemoveFieldfromGrid(QrymainfieldValue.fieldname);
  RemoveFieldfromGrid(QrymainDefaultValue.fieldname);
  if not devmode then RemoveFieldfromGrid(qryMainPrefname.fieldname);
end;

Initialization
  RegisterClassOnce(TPrejerenceToExportGUI);

end.
