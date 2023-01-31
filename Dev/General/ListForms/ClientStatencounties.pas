unit ClientStatencounties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel, GIFImg;

type
  TClientStatencountiesGUI = class(TBaseListingGUI)
    qryMainSeqno: TLargeintField;
    qryMainStatencountry: TWideStringField;
    qryMainState: TWideStringField;
    qryMainCountry: TWideStringField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
    fsStatenCountry: String;
  public
    Property StatenCountry :String read fsStatenCountry write fsStatenCountry;
  end;

implementation

uses CommonLib, DNMLib;

{$R *.dfm}

procedure TClientStatencountiesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  DisableSortoncolumtitleclick:= TRue;
  StatenCountry := '';
end;

procedure TClientStatencountiesGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Qrymainseqno.asInteger = 2 then begin
    Dobold(AFont,ABrush);
    DoGreenhighlight(AFont,ABrush);
  end;
end;
procedure TClientStatencountiesGUI.qryMainAfterOpen(DataSet: TDataSet);
var
  st:TStringlist;
begin
    if StatenCountry = '' then exit;
    st:= TStringlist.create;
    try
        st.commatext := '';
        SplitString(StatenCountry, '-' , st);
        if st.Count >0 then
          Qrymain.locate('Country;State', vararrayof([st[0],st[1]]) , []);
    finally
      Freeandnil(st);
    end;

end;

initialization
  RegisterClassOnce(TClientStatencountiesGUI);

end.
