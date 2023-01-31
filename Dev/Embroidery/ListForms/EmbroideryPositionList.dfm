inherited EmbroideryPositionListGUI: TEmbroideryPositionListGUI
  Caption = 'Embroidery Position List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 15527129
  end
  inherited HeaderPanel: TPanel
    Color = 15527129
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'Image;Bitmap;Stretch To Fit;Source Copy')
      Selected.Strings = (
        'Description'#9'30'#9'Description'#9#9
        'Image'#9'10'#9'Picture'#9#9)
      TitleColor = 15527129
      RowHeightPercent = 300
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT *'
      'FROM tblembroideryposition')
    object qryMainDescription: TStringField
      DisplayWidth = 30
      FieldName = 'Description'
      ReadOnly = True
      Size = 255
    end
    object qryMainImage: TBlobField
      DisplayLabel = 'Picture'
      DisplayWidth = 10
      FieldName = 'Image'
      ReadOnly = True
    end
    object qryMainEmbroideryPositionID: TIntegerField
      FieldName = 'EmbroideryPositionID'
      Visible = False
    end
    object qryMainGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Visible = False
    end
  end
end
