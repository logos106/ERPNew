unit FaxObj;

interface

uses
  DB, MyAccess,ERPdbComponents, Classes, Wwdbgrid;

type
  TFaxObj = class(TObject)
  private
    qryFaxSpool: TERPQuery;
    qryFaxSpoolDocs: TERPQuery;
    function AddFaxDocToSpool(const FileName: string): boolean;
  public
    NoCoverSheet: boolean;
    procedure AddToFaxSpool(const EmployeeName, ClientName, FaxNumber, TransType, TransGlobal, Description, FaxDocPath: string;
      const DateSpooled: TDateTime);
  end;

implementation

uses FastFuncs,Dialogs, SysUtils, Forms, Controls, CommonDbLib, CommonLib;

 { TFaxObj }

procedure TFaxObj.AddToFaxSpool(const EmployeeName, ClientName, FaxNumber, TransType, TransGlobal,
  Description, FaxDocPath: string; const DateSpooled: TDateTime);
var
  NoPageFiles: boolean;
  PageCount: integer;
  TempFaxDocPath: string;
  InputCoverNotes: TwwMemoDialog;
  TempNotes: string;
  UseCoverSheet: boolean;
begin
  UseCoverSheet := false;
  qryFaxSpool := TERPQuery.Create(nil);
  qryFaxSpool.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryFaxSpoolDocs := TERPQuery.Create(nil);
  qryFaxSpoolDocs.Connection := CommonDbLib.GetSharedMyDacConnection;
  if not NoCoverSheet then begin
    if CommonLib.MessageDlgXP_Vista('Do You Wish To Have A Cover Sheet ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      UseCoverSheet := True;
      InputCoverNotes := TwwMemoDialog.Create(nil);
      try
        InputCoverNotes.Caption := 'Enter the Cover Sheet Comments .... ';
        InputCoverNotes.Font.Name := 'Arial';
        InputCoverNotes.Font.Style := [];
        InputCoverNotes.Font.Size := 9;
        InputCoverNotes.dlgHeight := 380;
        InputCoverNotes.dlgWidth := 480;
        if InputCoverNotes.Execute then begin
          TempNotes := InputCoverNotes.Lines.Text;
        end;
      finally
        FreeAndNil(InputCoverNotes);
      end;
    end;
  end;
  try
    qryFaxSpool.Sql.Add('SELECT * FROM tblfaxspool limit 1;');
    qryFaxSpool.Active := true;
    qryFaxSpool.Append;
    qryFaxSpool.FieldByName('EmployeeName').AsString     := EmployeeName;
    qryFaxSpool.FieldByName('ClientName').AsString       := ClientName;
    qryFaxSpool.FieldByName('FaxNumber').AsString        := FaxNumber;
    qryFaxSpool.FieldByName('DateSpooled').AsDateTime    := DateSpooled;
    qryFaxSpool.FieldByName('TransType').AsString        := TransType;
    qryFaxSpool.FieldByName('TransGlobal').AsString      := TransGlobal;
    qryFaxSpool.FieldByName('Description').AsString      := Description;
    qryFaxSpool.FieldByName('Status').AsString           := 'Spooling';
    qryFaxSpool.FieldByName('CoverSheetNotes').AsVariant := TempNotes;
    qryFaxSpool.FieldByName('UseCoverSheet').AsBoolean   := UseCoverSheet;
    qryFaxSpool.Post;

    qryFaxSpoolDocs.Sql.Add('SELECT FaxSpoolID,FaxDoc,SendOrder FROM tblfaxspooldocs limit 1;');
    qryFaxSpoolDocs.Active := true;

    PageCount   := 0;
    NoPageFiles := false;
    while not NoPageFiles do begin
      PageCount := PageCount + 1;
      TempFaxDocPath := ReplaceStr(FaxDocPath, 'IMG0001', 'IMG000' + IntToStr(PageCount));

      if FileExists(TempFaxDocPath) then begin
        qryFaxSpoolDocs.Append;
        qryFaxSpoolDocs.FieldByName('FaxSpoolID').AsString := qryFaxSpool.FieldByName('FaxSpoolID').AsString;
        qryFaxSpoolDocs.FieldByName('SendOrder').AsInteger := PageCount + 1;
        AddFaxDocToSpool(TempFaxDocPath);
        qryFaxSpoolDocs.Post;
      end else begin
        NoPageFiles := true;
      end;
    end;

    qryFaxSpool.Edit;
    qryFaxSpool.FieldByName('Status').AsString := 'Spooled';
    qryFaxSpool.Post;
  finally
    FreeAndNil(qryFaxSpool);
    FreeAndNil(qryFaxSpoolDocs);
  end;
end;

function TFaxObj.AddFaxDocToSpool(const FileName: string): boolean;
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    ms.LoadFromFile(FileName);
    ms.Position := 0;
    TBlobField(qryFaxSpoolDocs.FieldByName('FaxDoc')).LoadFromStream(ms);
    Result := true;
  finally
    FreeAndNil(ms);
  end;
end;

end.
