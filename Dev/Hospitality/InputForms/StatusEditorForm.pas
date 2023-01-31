unit StatusEditorForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB,  Grids, Wwdbigrd, Wwdbgrid, StdCtrls,
  Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, SelectionDialog, AppEvnts, Mask, wwdbedit,
  Wwdotdot, Wwdbcomb, wwdblook, ImgList, kbmMemTable, DBAccess, MyAccess,ERPdbComponents,
  DataState, Menus, AdvMenus, MemDS, Shader;

type
  TfrmStatusEditor = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    BitBtn1: TDNMSpeedButton;
    wwDBGrid1: TwwDBGrid;
    dsStatus: TDataSource;
    qryStatus: TERPQuery;
    qryStatusGlobalRef: TWideStringField;
    qryStatusStatusID: TIntegerField;
    qryStatusColour: TIntegerField;
    qryStatusStatusText: TWideStringField;
    ImageList1: TImageList;
    wwDBLookupCombo1: TwwDBLookupCombo;
    qryStatusColourName: TWideStringField;
    memQryColours: TkbmMemTable;
    memQryColoursColourName: TWideStringField;
    memQryColoursImageIndex: TIntegerField;
    dsColours: TDataSource;
    memQryColoursColour: TIntegerField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryStatusColourNameChange(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses DNMExceptions, CommonLib;

{$R *.dfm}

procedure TfrmStatusEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TfrmStatusEditor.FormCreate(Sender: TObject);
begin
  inherited;
  // Now we need to create our static colour table
  with memQryColours do begin
    memQryColours.Open;
    Insert;
    FieldByName('ColourName').AsString  := 'Aqua';
    FieldByName('Colour').AsInteger     := ColorToRGB(clAqua);
    FieldByName('ImageIndex').AsInteger := 0;
    Post;

    Insert;
    FieldByName('ColourName').AsString  := 'White';
    FieldByName('Colour').AsInteger     := ColorToRGB(clWhite);
    FieldByName('ImageIndex').AsInteger := 14;
    Post;

    Insert;
    FieldByName('ColourName').AsString  := 'Black';
    FieldByName('Colour').AsInteger     := ColorToRGB(clBlack);
    FieldByName('ImageIndex').AsInteger := 1;
    Post;

    Insert;
    FieldByName('ColourName').AsString  := 'Blue';
    FieldByName('Colour').AsInteger     := ColorToRGB(clBlue);
    FieldByName('ImageIndex').AsInteger := 2;
    Post;

    Insert;
    FieldByName('ColourName').AsString  := 'Fuchsia';
    FieldByName('Colour').AsInteger     := ColorToRGB(clFuchsia);
    FieldByName('ImageIndex').AsInteger := 3;
    Post;

    Insert;
    FieldByName('ColourName').AsString  := 'Grey';
    FieldByName('Colour').AsInteger     := ColorToRGB(clGray);
    FieldByName('ImageIndex').AsInteger := 4;
    Post;

    Insert;
    FieldByName('ColourName').AsString  := 'Green';
    FieldByName('Colour').AsInteger     := ColorToRGB(clGreen);
    FieldByName('ImageIndex').AsInteger := 5;
    Post;

    Insert;
    FieldByName('ColourName').AsString  := 'Lime';
    FieldByName('Colour').AsInteger     := ColorToRGB(clLime);
    FieldByName('ImageIndex').AsInteger := 6;
    Post;

    Insert;
    FieldByName('ColourName').AsString  := 'Maroon';
    FieldByName('Colour').AsInteger     := ColorToRGB(clMaroon);
    FieldByName('ImageIndex').AsInteger := 7;
    Post;

    Insert;
    FieldByName('ColourName').AsString  := 'Navy';
    FieldByName('Colour').AsInteger     := ColorToRGB(clNavy);
    FieldByName('ImageIndex').AsInteger := 8;
    Post;

    Insert;
    FieldByName('ColourName').AsString  := 'Olive';
    FieldByName('Colour').AsInteger     := ColorToRGB(clOlive);
    FieldByName('ImageIndex').AsInteger := 9;
    Post;

    Insert;
    FieldByName('ColourName').AsString  := 'Purple';
    FieldByName('Colour').AsInteger     := ColorToRGB(clPurple);
    FieldByName('ImageIndex').AsInteger := 10;
    Post;

    Insert;
    FieldByName('ColourName').AsString  := 'Red';
    FieldByName('Colour').AsInteger     := ColorToRGB(clRed);
    FieldByName('ImageIndex').AsInteger := 11;
    Post;

    Insert;
    FieldByName('ColourName').AsString  := 'Silver';
    FieldByName('Colour').AsInteger     := ColorToRGB(clSilver);
    FieldByName('ImageIndex').AsInteger := 12;
    Post;

    Insert;
    FieldByName('ColourName').AsString  := 'Teal';
    FieldByName('Colour').AsInteger     := ColorToRGB(clTeal);
    FieldByName('ImageIndex').AsInteger := 13;
    Post;

    Insert;
    FieldByName('ColourName').AsString  := 'Yellow';
    FieldByName('Colour').AsInteger     := ColorToRGB(clYellow);
    FieldByName('ImageIndex').AsInteger := 15;
    Post;
    memQryColours.SortOn('ColourName', []);
  end;
end;

procedure TfrmStatusEditor.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      //  Setlength(QueryNamesNotToOpen, 1);
      //  QueryNamesNotToOpen[0] := 'qryDeleteFloorPlan';
      //  OpenQueries(QueryNamesNotToOpen);
      OpenQueries;
    except
      on EABort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmStatusEditor.qryStatusColourNameChange(Sender: TField);
begin
  inherited;
  qryStatus.FieldByName('Colour').AsInteger := memQryColours.FieldByName('Colour').AsInteger;
end;

initialization
  RegisterClassOnce(TfrmStatusEditor);
end.
