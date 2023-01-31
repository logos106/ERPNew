inherited fmStSProduction: TfmStSProduction
  Left = 1004
  Top = 216
  Caption = 'Production'
  ClientHeight = 361
  ClientWidth = 705
  ExplicitLeft = 1004
  ExplicitTop = 216
  ExplicitWidth = 721
  ExplicitHeight = 400
  DesignSize = (
    705
    361)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 318
    Width = 705
    ExplicitTop = 196
    ExplicitWidth = 673
  end
  inherited shapehint: TShape
    Left = 10
    ExplicitLeft = 9
  end
  inherited shapehintextra1: TShape
    Left = 59
    ExplicitLeft = 56
  end
  inherited pnlFooter: TDNMPanel
    Top = 318
    Width = 705
    ExplicitTop = 236
    ExplicitWidth = 486
    DesignSize = (
      705
      43)
    inherited btnCompleted: TDNMSpeedButton
      Left = 238
      ExplicitLeft = 206
    end
    inherited btnClose: TDNMSpeedButton
      Left = 412
      ExplicitLeft = 380
    end
  end
  inherited pnlHeader: TDNMPanel
    Width = 705
    ExplicitWidth = 673
    DesignSize = (
      705
      57)
    inherited pnlTitle: TDNMPanel
      Width = 441
      ExplicitWidth = 409
      inherited TitleShader: TShader
        Width = 439
        ExplicitWidth = 407
        inherited TitleLabel: TLabel
          Width = 439
          Caption = 'Production'
          ExplicitWidth = 407
        end
      end
    end
  end
  inherited pnlDetails: TDNMPanel
    Width = 705
    Height = 261
    ExplicitTop = 59
    ExplicitWidth = 673
    ExplicitHeight = 261
    object Label1: TLabel
      Left = 93
      Top = 93
      Width = 39
      Height = 15
      HelpContext = 314095
      Alignment = taRightJustify
      Caption = 'Count :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 97
      Top = 152
      Width = 35
      Height = 15
      Alignment = taRightJustify
      Caption = 'Date : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblProductPrintName: TLabel
      Left = 67
      Top = 212
      Width = 65
      Height = 15
      HelpContext = 314766
      Alignment = taRightJustify
      Caption = 'Description'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Shape1: TShape
      Left = 137
      Top = 18
      Width = 547
      Height = 47
      Brush.Style = bsClear
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 35
      Top = 34
      Width = 97
      Height = 15
      HelpContext = 314095
      Margins.Left = 11
      Alignment = taRightJustify
      Caption = 'Production Type :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object optTagForProduct: TwwRadioGroup
      AlignWithMargins = True
      Left = 140
      Top = 18
      Width = 536
      Height = 47
      DisableThemes = False
      Columns = 4
      DataField = 'StSProducttype'
      DataSource = dsststagproduct
      Items.Strings = (
        'Cuttings'
        'Clones'
        'Seeds'
        'Manufacure Product')
      TabOrder = 0
    end
    object edtTHC_Content: TwwDBSpinEdit
      Left = 137
      Top = 89
      Width = 57
      Height = 23
      Increment = 1.000000000000000000
      MaxValue = 100.000000000000000000
      DataField = 'Productcount'
      DataSource = dsststagproduct
      TabOrder = 1
      UnboundDataType = wwDefault
    end
    object dtProductionDate: TwwDBDateTimePicker
      Left = 137
      Top = 148
      Width = 162
      Height = 23
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'Tahoma'
      CalendarAttributes.Font.Style = []
      DataField = 'ProductionDate'
      DataSource = dsststagproduct
      Epoch = 1950
      ShowButton = True
      TabOrder = 2
    end
    object edtStrainName: TwwDBEdit
      Left = 137
      Top = 208
      Width = 547
      Height = 23
      DataField = 'Description'
      DataSource = dsststagproduct
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object btnChooseTags: TDNMSpeedButton
      Left = 265
      Top = 86
      Width = 117
      Height = 29
      HelpContext = 358022
      Caption = 'Choose Tag'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      AutoDisableParentOnclick = True
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 486
    Top = 111
  end
  inherited tmrdelay: TTimer
    Left = 519
    Top = 111
  end
  inherited popSpelling: TPopupMenu
    Left = 156
    Top = 111
  end
  inherited tmrdelayMsg: TTimer
    Left = 453
    Top = 111
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 255
    Top = 111
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 288
    Top = 111
  end
  inherited MyConnection: TERPConnection
    Database = 'ststest'
    Server = 'localhost'
    Left = 58
    Top = 111
  end
  inherited DataState: TDataState
    Left = 321
    Top = 111
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 189
    Top = 111
  end
  inherited imgsort: TImageList
    Left = 354
    Top = 111
  end
  inherited QryCustomField: TERPQuery
    Left = 90
    Top = 111
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 387
    Top = 111
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 222
    Top = 111
  end
  inherited qryMemTrans: TERPQuery
    Left = 123
    Top = 111
  end
  inherited tmrOnshow: TTimer
    Left = 552
    Top = 111
  end
  object dsststagproduct: TDataSource
    Left = 420
    Top = 111
  end
end
