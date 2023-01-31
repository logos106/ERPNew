unit GenDataList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TGenDataListGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainDescription: TWideStringField;
    qryMainValue1: TWideStringField;
    qryMainValue2: TWideStringField;
    qryMainValue3: TWideStringField;
    qryMainValue4: TWideStringField;
    qryMainValue5: TWideStringField;
    qryMainEmployeeId: TIntegerField;
    qryMainmstimestamp: TDateTimeField;
    qryMainEmployeeName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fsValue4: String;
    fsDescription: String;
    fsValue5: String;
    fsValue2: String;
    fsValue3: String;
    fsValue1: String;
    { Private declarations }
  public
    Property Description:String read fsDescription write fsDescription;
    Property Value1:String read fsValue1 write fsValue1;
    Property value2:String read fsValue2 write fsValue2;
    Property Value3:String read fsValue3 write fsValue3;
    Property Value4:String read fsValue4 write fsValue4;
    Property Value5:String read fsValue5 write fsValue5;

  end;


implementation

uses CommonLib;

{$R *.dfm}
procedure TGenDataListGUI.FormCreate(Sender: TObject);
begin
  inherited;
    fsValue4      :='';
    fsDescription :='';
    fsValue5      :='';
    fsValue2      :='';
    fsValue3      :='';
    fsValue1      :='';
end;

procedure TGenDataListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if fsDescription<> '' then begin
    Grdmain.ColumnByname('Description').displayLabel:=fsDescription;
    Self.Caption :=fsDescription;
  end;
  if fsValue1     <> '' then Grdmain.ColumnByname('Value1').displayLabel   :=Value1;
  if fsValue2     <> '' then Grdmain.ColumnByname('Value2').displayLabel   :=Value2;
  if fsValue3     <> '' then Grdmain.ColumnByname('Value3').displayLabel   :=Value3;
  if fsValue4     <> '' then Grdmain.ColumnByname('Value4').displayLabel   :=Value4;
  if fsValue5     <> '' then Grdmain.ColumnByname('Value5').displayLabel   :=Value5;
end;

initialization
  RegisterClassOnce(TGenDataListGUI);

end.
