inherited BarcodePriceMatrixGUI: TBarcodePriceMatrixGUI
  Left = 119
  Top = 118
  Caption = 'Price Matrix Barcodes '
  ClientHeight = 506
  OldCreateOrder = True
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    Top = 413
  end
  inherited FooterPanel: TPanel
    Top = 426
    Color = 15588572
    inherited lblTimeLabel: TLabel
      Left = 851
    end
    inherited lblTime: TLabel
      Left = 941
    end
    object btnContinue: TDNMSpeedButton [5]
      Left = 249
      Top = 32
      Width = 87
      Height = 27
      Anchors = [akBottom]
      Caption = 'Print Barcodes'
      Default = True
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnContinueClick
    end
    object pnlBarCode: TDNMPanel [6]
      Left = 327
      Top = 6
      Width = 346
      Height = 25
      Anchors = [akBottom]
      Color = 15588572
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        346
        25)
      object lblBarCode: TLabel
        Left = 36
        Top = 4
        Width = 242
        Height = 17
        Anchors = [akBottom]
        AutoSize = False
        Caption = '"Press Ctrl && Click to select Barcodes for printing'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
    end
    inherited cmdClose: TDNMSpeedButton
      TabOrder = 3
    end
    inherited cmdNew: TDNMSpeedButton
      Left = 523
      TabOrder = 4
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 660
      TabOrder = 7
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 386
      TabOrder = 8
    end
    inherited btnCustomize: TDNMSpeedButton
      TabOrder = 9
    end
    inherited pnlAdvPrinting: TDNMPanel
      Left = 363
      Top = 2
    end
    inherited barStatus: TAdvOfficeStatusBar
      Panels = <
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          Text = 'Current Filter'
          TimeFormat = 'hh:mm:ss'
          Width = 80
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          TimeFormat = 'hh:mm:ss'
          Width = 700
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psOwnerDraw
          TimeFormat = 'hh:mm:ss'
          Width = 50
          OfficeHint.Picture.Data = {}
        end>
    end
  end
  inherited HeaderPanel: TPanel
    Color = 15588572
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      Left = 208
      Caption = 'Price Matrix Barcodes '
    end
    inherited Panel3: TPanel
      inherited edtSearch: TEdit
        Width = 447
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      Visible = False
    end
    inherited cboDateRange: TComboBox
      Left = 961
    end
  end
  inherited Panel1: TPanel
    Height = 284
    inherited grdMain: TwwDBGrid
      Height = 284
      Selected.Strings = (
        'ProductName'#9'20'#9'ProductName'#9#9
        'UnitofMeasure'#9'10'#9'UnitofMeasure'#9#9
        'DescAttrib1'#9'10'#9'DescAttrib1'#9#9
        'DescAttrib2'#9'10'#9'DescAttrib2'#9#9
        'DescAttrib3'#9'10'#9'DescAttrib3'#9#9
        'DescAttrib4'#9'10'#9'DescAttrib4'#9#9
        'DescAttrib5'#9'10'#9'DescAttrib5'#9#9
        'BARCODE'#9'14'#9'BARCODE'#9#9
        'PriceMatrixDesc'#9'30'#9'PriceMatrixDesc'#9#9)
      TitleColor = 15588572
    end
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      
        'SELECT PriceMatrixID, PM.PartsID,PartName as ProductName, PM.Uni' +
        'tofMeasure, DescAttrib1, DescAttrib2, DescAttrib3, DescAttrib4, ' +
        'DescAttrib5, '
      'PM.BARCODE, PriceMatrixDesc  '
      'FROM tblParts P'
      'INNER JOIN tblpricematrix PM USING(PartsID)'
      'Where P.PartsID = :ID;')
    Left = 89
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qryMainProductName: TStringField
      DisplayWidth = 20
      FieldName = 'ProductName'
      Size = 60
    end
    object qryMainUnitofMeasure: TStringField
      DisplayWidth = 10
      FieldName = 'UnitofMeasure'
      Size = 255
    end
    object qryMainDescAttrib1: TStringField
      DisplayWidth = 10
      FieldName = 'DescAttrib1'
      Size = 255
    end
    object qryMainDescAttrib2: TStringField
      DisplayWidth = 10
      FieldName = 'DescAttrib2'
      Size = 255
    end
    object qryMainDescAttrib3: TStringField
      DisplayWidth = 10
      FieldName = 'DescAttrib3'
      Size = 255
    end
    object qryMainDescAttrib4: TStringField
      DisplayWidth = 10
      FieldName = 'DescAttrib4'
      Size = 255
    end
    object qryMainDescAttrib5: TStringField
      DisplayWidth = 10
      FieldName = 'DescAttrib5'
      Size = 255
    end
    object qryMainBARCODE: TStringField
      DisplayWidth = 14
      FieldName = 'BARCODE'
      Size = 255
    end
    object qryMainPriceMatrixDesc: TStringField
      DisplayWidth = 30
      FieldName = 'PriceMatrixDesc'
      Size = 255
    end
    object qryMainPriceMatrixID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'PriceMatrixID'
      ReadOnly = True
      Visible = False
    end
    object qryMainPartsID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartsID'
      Visible = False
    end
  end
end
