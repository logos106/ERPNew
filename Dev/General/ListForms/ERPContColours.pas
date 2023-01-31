unit ERPContColours;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TERPContColoursGUI = class(TBaseListingGUI)
    qryMaincolour: TWideStringField;
    qryMaincolourcode: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TERPContColoursGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TERPContColoursGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
     if qryMaincolour.asString = 'GridColHighLightDarkGreen'          then Abrush.color := $00B3FFB3
else if qryMaincolour.asString = 'GridColhighLightGreen'              then Abrush.color := $00D9FFD9
else if qryMaincolour.asString = 'GridColhighLightYellow1'            then Abrush.color := $00CCFFFF
else if qryMaincolour.asString = 'GridColhighLightYellow2'            then Abrush.color := $00CCFFF0
else if qryMaincolour.asString = 'GridColhighLightBlue'               then Abrush.color := $00FFE9D2
else if qryMaincolour.asString = 'GridColhighLightRed'                then Abrush.color := $00D2D2FF
else if qryMaincolour.asString = 'GridColhighLightOrange'             then Abrush.color := $00B0CAFF
else if qryMaincolour.asString = 'GridColhighLightPurple'             then Abrush.color := $00FFBFDF
else if qryMaincolour.asString = 'GridColhighLightNavy'               then Abrush.color := $00FEBAA9
else if qryMaincolour.asString = 'GridcolInactive'                    then Abrush.color := clDkGray
else if qryMaincolour.asString = 'GridColBrushInactive'               then Abrush.color := $00D6D3D6
else if qryMaincolour.asString = 'GridColFontRed'                     then Abrush.color := clRed
else if qryMaincolour.asString = 'GridColFontBlack'                   then Abrush.color := clBlack
else if qryMaincolour.asString = 'GridColFontGreen'                   then Abrush.color := clGreen
else if qryMaincolour.asString = 'GridColFontOlive'                   then Abrush.color := clOlive
else if qryMaincolour.asString = 'Default_ColourAlternatingRow'       then Abrush.color := 10944511
else if qryMaincolour.asString = 'Default_ColourERPSingle'            then Abrush.color := 16777215
else if qryMaincolour.asString = 'Default_ColourERPButton'            then Abrush.color := 8388608
else if qryMaincolour.asString = 'Default_ColourERPButtonFont'        then Abrush.color := 16777215
else if qryMaincolour.asString = 'Default_ColourERPButtonHT'          then Abrush.color := 14248960
else if qryMaincolour.asString = 'Default_ColourAlternatingRowgreen'  then Abrush.color := 10944511
else if qryMaincolour.asString = 'Default_ColourERPSinglegreen'       then Abrush.color := 16777215
else if qryMaincolour.asString = 'Default_ColourERPButtongreen'       then Abrush.color := 13056
else if qryMaincolour.asString = 'Default_ColourERPButtonFontgreen'   then Abrush.color := 10092543
else if qryMaincolour.asString = 'Default_ColourERPButtonHTgreen'     then Abrush.color := 6723891
else if qryMaincolour.asString = 'Inactivefontcolor'                  then Abrush.color := $00BCBCBC;

end;

procedure TERPContColoursGUI.grdMainDblClick(Sender: TObject);
begin
  grdmain.SetActivefield(qryMaincolour.fieldname);
  DocopyData(nil);
  listtimermsg('Colour code copied');

end;

initialization
  RegisterClassOnce(TERPContColoursGUI);

end.
