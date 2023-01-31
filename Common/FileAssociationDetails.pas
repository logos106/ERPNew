unit FileAssociationDetails;

{
  Created       : 2009-05-07
  Description   : Class to get file type description and icons.
                  * Extensions and Descriptions are held in a TStringLists.
                  * Icons are stored in a TImageList.

                  Assumption is all lists are in same order.
}

interface

uses Classes, Controls;

type
  TFileAssociationDetails = class(TObject)
  private
    FImages : TImageList;
    FExtensions : TStringList;
    FDescriptions : TStringList;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AddFile(FileName : string);
    procedure AddExtension(Extension : string);
    procedure Clear;
    procedure GetFileIconsAndDescriptions;

    property Images : TImageList read FImages;
    property Extensions : TStringList read FExtensions;
    property Descriptions : TStringList read FDescriptions;
  end;

implementation

uses SysUtils, ShellAPI, Graphics, Windows;

{ TFileAssociationDetails }

constructor TFileAssociationDetails.Create;
begin
  try
    inherited;

    FExtensions := TStringList.Create;
    FExtensions.Sorted := true;
    FDescriptions := TStringList.Create;
    FImages := TImageList.Create(nil);
  except
  end;
end;

destructor TFileAssociationDetails.Destroy;
begin
  try
    FExtensions.Free;
    FDescriptions.Free;
    FImages.Free;
  finally
    inherited;
  end;
end;

procedure TFileAssociationDetails.AddFile(FileName: string);
begin
  AddExtension(ExtractFileExt(FileName));
end;

procedure TFileAssociationDetails.AddExtension(Extension : string);
begin
  Extension := UpperCase(Extension);
  if (Trim(Extension) <> '') and
     (FExtensions.IndexOf(Extension) = -1) then
    FExtensions.Add(Extension);
end;

procedure TFileAssociationDetails.Clear;
begin
  FExtensions.Clear;
end;

procedure TFileAssociationDetails.GetFileIconsAndDescriptions;
var
  Icon: TIcon;
  iCount : integer;
  Extension : string;
  FileInfo : SHFILEINFO;
begin
  FImages.Clear;
  FDescriptions.Clear;

  Icon := TIcon.Create;
  try
    // Loop through all stored extensions and retrieve relevant info
    for iCount := 0 to FExtensions.Count - 1 do
    begin
      Extension := '*' + FExtensions.Strings[iCount];

      // Get description type
      SHGetFileInfo(PChar(Extension),
                    FILE_ATTRIBUTE_NORMAL,
                    FileInfo,
                    SizeOf(FileInfo),
                    SHGFI_TYPENAME or SHGFI_USEFILEATTRIBUTES
                    );
      FDescriptions.Add(FileInfo.szTypeName);

      // Get icon and copy into ImageList
      SHGetFileInfo(PChar(Extension),
                    FILE_ATTRIBUTE_NORMAL,
                    FileInfo,
                    SizeOf(FileInfo),
                    SHGFI_ICON or SHGFI_SMALLICON or
                    SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES
                    );
      Icon.Handle := FileInfo.hIcon;
      FImages.AddIcon(Icon);
    end;
  finally
    Icon.Free;
  end;
end;

end.

