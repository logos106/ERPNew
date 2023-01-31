object fmMain: TfmMain
  Left = 413
  Top = 320
  Width = 659
  Height = 444
  Caption = 'ERP Data Synchronization'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TDNMPanel
    Left = 0
    Top = 368
    Width = 651
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      651
      42)
    object lblStatus: TLabel
      Left = 16
      Top = 16
      Width = 40
      Height = 15
      Caption = 'Status:'
      Transparent = True
    end
    object btnStart: TDNMSpeedButton
      Left = 512
      Top = 11
      Width = 60
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'Start'
      Color = clBtnFace
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 0
      OnClick = btnStartClick
    end
    object btnStop: TDNMSpeedButton
      Left = 576
      Top = 11
      Width = 60
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'Stop'
      Color = clBtnFace
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 1
      OnClick = btnStopClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 651
    Height = 368
    ActivePage = tsConfig
    Align = alClient
    TabIndex = 0
    TabOrder = 1
    object tsConfig: TTabSheet
      Caption = 'Config'
      object pnlServer: TDNMPanel
        Left = 0
        Top = 0
        Width = 643
        Height = 57
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          643
          57)
        object Label1: TLabel
          Left = 28
          Top = 20
          Width = 38
          Height = 15
          Caption = 'Server'
        end
        object edtServer: TEdit
          Left = 72
          Top = 16
          Width = 249
          Height = 23
          TabOrder = 0
          OnChange = edtServerChange
        end
        object btnTest: TDNMSpeedButton
          Left = 520
          Top = 11
          Width = 108
          Height = 23
          Anchors = [akTop, akRight]
          Caption = 'Test Conections'
          DisableTransparent = False
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          SlowDecease = True
          Style = bsModern
          TabOrder = 1
          OnClick = btnTestClick
        end
      end
      object tvConfig: TTreeView
        Left = 0
        Top = 57
        Width = 643
        Height = 241
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Indent = 19
        ParentFont = False
        TabOrder = 1
        OnDblClick = tvConfigDblClick
      end
      object DNMPanel1: TDNMPanel
        Left = 0
        Top = 298
        Width = 643
        Height = 42
        Align = alBottom
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object btnAdd: TDNMSpeedButton
          Left = 16
          Top = 11
          Width = 60
          Height = 23
          Caption = 'Add'
          DisableTransparent = False
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          SlowDecease = True
          Style = bsModern
          TabOrder = 0
          OnClick = btnAddClick
        end
        object btnEdit: TDNMSpeedButton
          Left = 80
          Top = 11
          Width = 60
          Height = 23
          Caption = 'Edit'
          DisableTransparent = False
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          SlowDecease = True
          Style = bsModern
          TabOrder = 1
          OnClick = btnEditClick
        end
        object btnDelete: TDNMSpeedButton
          Left = 144
          Top = 11
          Width = 60
          Height = 23
          Caption = 'Delete'
          DisableTransparent = False
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          OnClick = btnDeleteClick
        end
      end
    end
    object tsLog: TTabSheet
      Caption = 'Log'
      ImageIndex = 1
      object memLog: TMemo
        Left = 0
        Top = 0
        Width = 643
        Height = 340
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
  end
end
