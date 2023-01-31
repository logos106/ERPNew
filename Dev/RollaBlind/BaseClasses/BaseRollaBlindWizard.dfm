inherited BaseRollaBlindWizardGUI: TBaseRollaBlindWizardGUI
  Left = 202
  Top = 187
  Caption = 'BaseRollaBlindWizardGUI'
  ClientHeight = 589
  ClientWidth = 897
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object DNMPanel1: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 897
    Height = 589
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      897
      589)
    object Label1: TLabel
      Left = 20
      Top = 72
      Width = 93
      Height = 15
      Caption = 'Progress Status'
      Transparent = True
    end
    object Label2: TLabel
      Left = 376
      Top = 72
      Width = 106
      Height = 15
      Caption = 'Cut-out Sheet Data'
      Transparent = True
    end
    object btnBack: TDNMSpeedButton
      Left = 531
      Top = 546
      Width = 87
      Height = 27
      Anchors = [akRight, akBottom]
      Caption = '&Back'
      DisableTransparent = False
      Enabled = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 0
      OnClick = btnBackClick
    end
    object btnNext: TDNMSpeedButton
      Left = 631
      Top = 546
      Width = 87
      Height = 27
      Anchors = [akRight, akBottom]
      Caption = '&Next'
      DisableTransparent = False
      Enabled = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 1
      OnClick = btnNextClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 792
      Top = 546
      Width = 87
      Height = 27
      Anchors = [akRight, akBottom]
      Caption = '&Cancel'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 2
      OnClick = btnCancelClick
    end
    object DNMPanel2: TDNMPanel
      Left = 18
      Top = 88
      Width = 340
      Height = 442
      Anchors = [akLeft, akTop, akBottom]
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      DesignSize = (
        340
        442)
      object Bevel2: TBevel
        Left = 0
        Top = 0
        Width = 340
        Height = 442
        Align = alClient
        Shape = bsFrame
      end
      object ScrollBox: TScrollBox
        Left = 20
        Top = 20
        Width = 300
        Height = 400
        VertScrollBar.Tracking = True
        Anchors = [akLeft, akTop, akRight, akBottom]
        BorderStyle = bsNone
        Color = clSilver
        ParentColor = False
        TabOrder = 0
      end
    end
    object DNMPanel3: TDNMPanel
      Left = 374
      Top = 88
      Width = 505
      Height = 442
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      DesignSize = (
        505
        442)
      object Bevel3: TBevel
        Left = 0
        Top = 0
        Width = 505
        Height = 442
        Align = alClient
        Shape = bsFrame
      end
      object Label3: TLabel
        Left = 16
        Top = 16
        Width = 76
        Height = 15
        Caption = 'Lead Number'
        Transparent = True
      end
      object txtLeadNumber: TDBText
        Left = 16
        Top = 32
        Width = 89
        Height = 17
        DataField = 'LeadNumber'
        DataSource = dsHeading
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label4: TLabel
        Left = 120
        Top = 16
        Width = 24
        Height = 15
        Caption = 'Title'
        Transparent = True
      end
      object Label5: TLabel
        Left = 168
        Top = 16
        Width = 61
        Height = 15
        Caption = 'First Name'
        Transparent = True
      end
      object Label6: TLabel
        Left = 264
        Top = 16
        Width = 52
        Height = 15
        Caption = 'Surname'
        Transparent = True
      end
      object Label7: TLabel
        Left = 392
        Top = 16
        Width = 81
        Height = 15
        Caption = 'Sheet Number'
        Transparent = True
      end
      object txtTitle: TDBText
        Left = 120
        Top = 32
        Width = 41
        Height = 17
        DataField = 'Title'
        DataSource = dsHeading
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object txtFirstName: TDBText
        Left = 168
        Top = 32
        Width = 73
        Height = 17
        DataField = 'FirstName'
        DataSource = dsHeading
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object txtSurname: TDBText
        Left = 264
        Top = 32
        Width = 97
        Height = 17
        DataField = 'Surname'
        DataSource = dsHeading
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object txtSheetNumber: TDBText
        Left = 392
        Top = 32
        Width = 97
        Height = 17
        DataField = 'SheetID'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Bevel1: TBevel
        Left = 8
        Top = 56
        Width = 487
        Height = 9
        Anchors = [akLeft, akTop, akRight]
        Shape = bsTopLine
      end
      object imgArrow: TImage
        Left = 8
        Top = 416
        Width = 10
        Height = 16
        Picture.Data = {
          07544269746D6170F6000000424DF60000000000000076000000280000000A00
          0000100000000100040000000000800000000000000000000000100000000000
          0000000000000000800000800000008080008000000080008000808000008080
          8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
          FF00FFFFFFFFFF0000001FFFFFFFFF00000011FFFFFFFF000000111FFFFFFF00
          00001111FFFFFF00000011111FFFFF000000111111FFFF0000001111111FFF00
          000011111111FF0000001111111FFF000000111111FFFF00000011111FFFFF00
          00001111FFFFFF000000111FFFFFFF00000011FFFFFFFF0000001FFFFFFFFF00
          0000}
        Transparent = True
        Visible = False
      end
    end
    object pnlTitle: TDNMPanel
      Left = 20
      Top = 16
      Width = 340
      Height = 41
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 80
    Top = 544
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 16
    Top = 544
  end
  inherited MyConnection: TMyConnection
    Left = 112
    Top = 543
  end
  inherited DataState: TDataState
    Left = 320
    Top = 544
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 288
    Top = 544
  end
  object qryMain: TMyQuery
    SQL.Strings = (
      
        'SELECT *, IF(Perforated='#39'T'#39', '#39'Perforated'#39', '#39'Non-perforated'#39') AS ' +
        'PerforatedOrNon, '
      'IF(Standard='#39'T'#39', '#39'Standard'#39', '#39'Reverse'#39') AS StandardOrReverse '
      'FROM tblrollaaddsheet1')
    Left = 144
    Top = 544
  end
  object qryHeading: TMyQuery
    SQL.Strings = (
      
        'SELECT  ClientID as LeadNumber, Title, FirstName, LastName as Su' +
        'rname '
      'FROM tblclients '
      'WHERE ClientID=:ClientID')
    Left = 176
    Top = 544
    ParamData = <
      item
        DataType = ftString
        Name = 'ClientID'
        Value = ''
      end>
    object qryHeadingLeadNumber: TIntegerField
      FieldName = 'LeadNumber'
    end
    object qryHeadingTitle: TStringField
      FieldName = 'Title'
      Size = 32
    end
    object qryHeadingFirstName: TStringField
      FieldName = 'FirstName'
      Size = 40
    end
    object qryHeadingSurname: TStringField
      FieldName = 'Surname'
      Size = 40
    end
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 216
    Top = 544
  end
  object dsHeading: TDataSource
    DataSet = qryHeading
    Left = 248
    Top = 544
  end
end
