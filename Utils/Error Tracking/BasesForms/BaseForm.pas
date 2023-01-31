unit BaseForm;

interface

uses
  Forms,Classes,DB,Controls;

type
  TBaseFormGUI = class(TForm)
    procedure PrintReport;
    procedure DesignReport;
    procedure ExportReport;
    procedure ImportReport;
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fsReportName:String;
    fbPreview:Boolean;
    fbDataset:TDataset;
    fbDataset1:TDataset;
    fsDatasetName1:String;
    fbDataset2:TDataset;
    fsDatasetName2:String;
    fbDataset3:TDataset;
    fsDatasetName3:String;
  Protected
    procedure SetButtonProperties(const Control: TWinControl);
    Function LoadReportBinary(Const ReportName:String):Boolean;
  public
    { Public declarations }
    Property ReportName :String read fsReportName write fsReportName;
    Property Preview :Boolean read fbPreview write fbPreview;
    Property Dataset :TDataset read fbDataset write fbDataset;
    Property Dataset1 :TDataset read fbDataset1 write fbDataset1;
    Property DatasetName1 :String read fsDatasetName1 write fsDatasetName1;
    Property Dataset2 :TDataset read fbDataset2 write fbDataset2;
    Property DatasetName2 :String read fsDatasetName2 write fsDatasetName2;
    Property Dataset3 :TDataset read fbDataset3 write fbDataset3;
    Property DatasetName3 :String read fsDatasetName3 write fsDatasetName3;
  end;

var
  BaseFormGUI: TBaseFormGUI;

implementation
  Uses Types, ComCtrls, SysUtils,BaseDataMod,FuncLib, Dialogs,Graphics,DNMPanel,DNMSpeedButton,
       Shader,GraphUtil, FastFuncs;


{$R *.dfm}

function TBaseFormGUI.LoadReportBinary(const ReportName: String): Boolean;
var
  ReportStream: TMemoryStream;
begin
  Result := False;
  ReportStream := TMemoryStream.Create;
  Try
    Try
      BaseDataModule.qryReports.Close;
      BaseDataModule.qryReports.Params.ParseSQL(BaseDataModule.qryReports.SQL.Text, True);
      BaseDataModule.qryReports.Params.ParamByName('xReportName').asString := FastFuncs.Trim(ReportName);
      BaseDataModule.qryReports.Open;
      BaseDataModule.ppReport.Template.New;
      If BaseDataModule.qryReports.RecordCount=1 then Begin
        TBlobField(BaseDataModule.qryReports.Fieldbyname('DesignBinary')).SaveToStream(ReportStream);
        If ReportStream.Size>0 Then Begin
          BaseDataModule.ppReport.Template.LoadFromStream(ReportStream);
        end;
        Result := True;
      end;
    Except
    end;
  Finally
    FreeAndNil(ReportStream);
  end;
end;

procedure TBaseFormGUI.PrintReport;
var
  ReportStream: TMemoryStream;
begin
//Print
  ReportStream := TMemoryStream.Create;
  Try
    If LoadReportBinary(fsReportName) then Begin
      If Assigned(fbDataset) then Begin
        BaseDataModule.DBPipeline.DataSource.DataSet := fbDataset;
        BaseDataModule.DBPipeline.UserName := ReplaceStr(fsReportName,' ','_');
        BaseDataModule.DBPipeline.Visible := True;
      end;
      If Assigned(fbDataset1) then Begin
        BaseDataModule.DBPipeline1.DataSource.DataSet := fbDataset1;
        BaseDataModule.DBPipeline1.UserName := ReplaceStr(fsDatasetName1,' ','_');
        BaseDataModule.DBPipeline1.Visible := True;
      end;
      If Assigned(fbDataset2) then Begin
        BaseDataModule.DBPipeline2.DataSource.DataSet := fbDataset2;
        BaseDataModule.DBPipeline2.UserName := ReplaceStr(fsDatasetName2,' ','_');
        BaseDataModule.DBPipeline2.Visible := True;
      end;
      If Assigned(fbDataset3) then Begin
        BaseDataModule.DBPipeline3.DataSource.DataSet := fbDataset3;
        BaseDataModule.DBPipeline3.UserName := ReplaceStr(fsDatasetName3,' ','_');
        BaseDataModule.DBPipeline3.Visible := True;
      end;

      If fbPreview then begin
        BaseDataModule.ppReport.DeviceType := 'Screen';
      end else begin
        BaseDataModule.ppReport.DeviceType := 'Printer';
      end;

      BaseDataModule.ppReport.Print;

    end;
  Finally
    FreeAndNil(ReportStream);
    fsReportName:='';
    BaseDataModule.DBPipeline.Visible := False;
    BaseDataModule.DBPipeline1.Visible := False;
    BaseDataModule.DBPipeline2.Visible := False;
    BaseDataModule.DBPipeline3.Visible := False;
    BaseDataModule.DBPipeline.DataSource.DataSet := nil;
    BaseDataModule.DBPipeline1.DataSource.DataSet := nil;
    BaseDataModule.DBPipeline2.DataSource.DataSet := nil;
    BaseDataModule.DBPipeline3.DataSource.DataSet := nil;
    fbDataset:=nil;
    fbDataset1:=nil;
    fbDataset2:=nil;
    fbDataset3:=nil;
  end;
end;

procedure TBaseFormGUI.DesignReport;
var
  ReportStream: TMemoryStream;
begin
//Designer
  ReportStream := TMemoryStream.Create;
  Try
    If LoadReportBinary(fsReportName) then Begin
      If Assigned(fbDataset) then Begin
        BaseDataModule.DBPipeline.DataSource.DataSet := fbDataset;
        BaseDataModule.DBPipeline.UserName := ReplaceStr(fsReportName,' ','_');
        BaseDataModule.DBPipeline.Visible := True;
      end;
      If Assigned(fbDataset1) then Begin
        BaseDataModule.DBPipeline1.DataSource.DataSet := fbDataset1;
        BaseDataModule.DBPipeline1.UserName := ReplaceStr(fsDatasetName1,' ','_');
        BaseDataModule.DBPipeline1.Visible := True;
      end;
      If Assigned(fbDataset2) then Begin
        BaseDataModule.DBPipeline2.DataSource.DataSet := fbDataset2;
        BaseDataModule.DBPipeline2.UserName := ReplaceStr(fsDatasetName2,' ','_');
        BaseDataModule.DBPipeline2.Visible := True;
      end;
      If Assigned(fbDataset3) then Begin
        BaseDataModule.DBPipeline3.DataSource.DataSet := fbDataset3;
        BaseDataModule.DBPipeline3.UserName := ReplaceStr(fsDatasetName3,' ','_');
        BaseDataModule.DBPipeline3.Visible := True;
      end;
      BaseDataModule.ppDesigner.WindowState := wsMaximized;
      BaseDataModule.ppDesigner.ShowModal;

      if (MessageDlg('Save Report Template Changes ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then Begin
        BaseDataModule.ppReport.Template.SaveToStream(ReportStream);
        BaseDataModule.qryReports.Edit;
        TBlobField(BaseDataModule.qryReports.Fieldbyname('DesignBinary')).LoadFromStream(ReportStream);
        BaseDataModule.qryReports.Post;
      end;
    end;
  Finally
    FreeAndNil(ReportStream);
    fsReportName:='';
    BaseDataModule.DBPipeline.Visible := False;
    BaseDataModule.DBPipeline1.Visible := False;
    BaseDataModule.DBPipeline2.Visible := False;
    BaseDataModule.DBPipeline3.Visible := False;
    BaseDataModule.DBPipeline.DataSource.DataSet := nil;
    BaseDataModule.DBPipeline1.DataSource.DataSet := nil;
    BaseDataModule.DBPipeline2.DataSource.DataSet := nil;
    BaseDataModule.DBPipeline3.DataSource.DataSet := nil;
    fbDataset:=nil;
    fbDataset1:=nil;
    fbDataset2:=nil;
    fbDataset3:=nil;
  end;
end;

procedure TBaseFormGUI.FormPaint(Sender: TObject);
begin
  inherited;
  PaintGradientColor(Self);
end;

procedure TBaseFormGUI.ExportReport;
var
  ReportStream: TMemoryStream;
  SaveDialog: TSaveDialog;
begin
  ReportStream := TMemoryStream.Create;
  SaveDialog := TSaveDialog.Create(Self);
  Try
    If LoadReportBinary(fsReportName) then Begin
       BaseDataModule.ppReport.Template.SaveToStream(ReportStream);
       SaveDialog.Title := 'Save Template To File';
       SaveDialog.DefaultExt := 'dtt';
       SaveDialog.Filter := 'Development Tracking Template(*.dtt)|*.dtt|AnyFile(*.*)|*.*';
       SaveDialog.FileName := fsReportName;
       If SaveDialog.Execute then Begin
         ReportStream.SaveToFile(SaveDialog.FileName);
       end;
    end;
  Finally
    FreeAndNil(SaveDialog);
    FreeAndNil(ReportStream);
  end;
end;

procedure TBaseFormGUI.ImportReport;
var
  ReportStream: TMemoryStream;
  OpenDialog: TOpenDialog;
begin
  ReportStream := TMemoryStream.Create;
  OpenDialog := TOpenDialog.Create(Self);
  Try
    If LoadReportBinary(fsReportName) then Begin
      OpenDialog.Title := 'Import Template From File';
      OpenDialog.DefaultExt := 'dtt';
      OpenDialog.Filter := 'Development Tracking Template(*.dtt)|*.dtt|AnyFile(*.*)|*.*';
      OpenDialog.FileName := fsReportName;
      If OpenDialog.Execute then Begin
        ReportStream.LoadFromFile(OpenDialog.FileName);
        BaseDataModule.qryReports.Edit;
        TBlobField(BaseDataModule.qryReports.Fieldbyname('DesignBinary')).LoadFromStream(ReportStream);
        BaseDataModule.qryReports.Post;
      end;
    end;
  Finally
    FreeAndNil(OpenDialog);
    FreeAndNil(ReportStream);
  end;
end;

procedure TBaseFormGUI.FormCreate(Sender: TObject);
begin
  SetButtonProperties(Self);
end;

procedure TBaseFormGUI.SetButtonProperties(const Control: TWinControl);
var
  Index: integer;
begin
  for Index := 0 to Control.ComponentCount - 1 do begin
    if (Control.Components[Index] is TForm) or
       (Control.Components[Index] is TFrame) then
      SetButtonProperties(TWinControl(Control.Components[Index]))
    else if Control.Components[Index] is TDNMSpeedButton then begin
      with TDNMSpeedButton(Control.Components[Index]) do begin
        Alignment := taCenter;
        Color := clWhite;
        HotTrackColor := clBtnShadow;
        SlowDecease := true;
        Style := bsModern;
      end;
    end else if (Components[Index] is TShader) and (Components[Index].Name='TitleShader') then Begin
        TShader(Components[Index]).FromColor := cDefaultGradientColor;
        TShader(Components[Index]).ToColorMirror := cDefaultGradientColor;
    end;
  end;
end;

end.




