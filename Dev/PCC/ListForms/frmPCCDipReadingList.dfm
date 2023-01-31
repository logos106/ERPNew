inherited PCCDipReadingList: TPCCDipReadingList
  Left = 193
  Top = 165
  Caption = 'Fuel Dip Reading List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 13092579
  end
  inherited HeaderPanel: TPanel
    Color = 13092579
    inherited pnlHeader: TPanel
      Caption = 'Fuel Dip Reading List'
    end
    inherited Panel2: TPanel
      inherited grpFilters: TRadioGroup
        ItemIndex = 0
        Items.Strings = (
          'Active'
          'Inactive'
          'All')
      end
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      TitleColor = 13092579
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT'
      'TankNo as TankNo,'
      'ReadingDateTime as ReadingDateTime,'
      'DipReading as DipReading,'
      'PCCDipReadingID,'
      'Active'
      'FROM tblPCCDipReading')
    object qryMainTankNo: TIntegerField
      FieldName = 'TankNo'
    end
    object qryMainReadingDateTime: TDateTimeField
      FieldName = 'ReadingDateTime'
    end
    object qryMainDipReading: TIntegerField
      FieldName = 'DipReading'
    end
    object qryMainPCCDipReadingID: TIntegerField
      FieldName = 'PCCDipReadingID'
      Visible = False
    end
    object qryMainActive: TStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
  end
end
