inherited fmBOMPLannerOptions: TfmBOMPLannerOptions
  Left = 723
  Top = 249
  HelpContext = 1423002
  Caption = 'BOM Planner Options'
  ClientHeight = 384
  ClientWidth = 351
  Position = poMainFormCenter
  ExplicitLeft = 723
  ExplicitTop = 249
  ExplicitWidth = 367
  ExplicitHeight = 423
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 334
    Width = 351
    HelpContext = 1423003
    ExplicitTop = 381
    ExplicitWidth = 459
  end
  object Label2: TLabel [3]
    AlignWithMargins = True
    Left = 3
    Top = 55
    Width = 345
    Height = 22
    HelpContext = 1423004
    Margins.Top = 5
    Margins.Bottom = 5
    Align = alTop
    Alignment = taCenter
    Caption = 'Choose Fields to Show'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    ExplicitWidth = 213
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 334
    Width = 351
    Height = 50
    HelpContext = 1423014
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      351
      50)
    object cmdClose: TDNMSpeedButton
      Left = 69
      Top = 11
      Width = 93
      Height = 29
      HelpContext = 1423015
      Anchors = [akRight, akBottom]
      Caption = '&Save'
      Default = True
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
    end
    object cmdCancel: TDNMSpeedButton
      Left = 189
      Top = 11
      Width = 93
      Height = 29
      HelpContext = 1423016
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 351
    Height = 50
    HelpContext = 1423017
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    ExplicitTop = -2
    DesignSize = (
      351
      50)
    object pnlTitle: TDNMPanel
      Left = 85
      Top = 5
      Width = 181
      Height = 39
      HelpContext = 1423018
      Anchors = []
      
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 179
        Height = 37
        HelpContext = 1423019
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        FromColor = clBtnFace
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = clBtnFace
        Steps = 10
        Direction = False
        Version = '1.4.0.0'
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 179
          Height = 37
          HelpContext = 1423020
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Options'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = -1
          ExplicitWidth = 428
        end
      end
    end
  end
  object DNMPanel4: TDNMPanel [7]
    Left = 176
    Top = 82
    Width = 175
    Height = 252
    HelpContext = 1423021
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Label3: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 167
      Height = 19
      Hint = 'Choose the fields to Appear on the Details and Hint of Each Item'
      HelpContext = 1423022
      Align = alTop
      Caption = 'Details'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      ExplicitWidth = 52
    end
    object Label5: TLabel
      Left = 1
      Top = 26
      Width = 173
      Height = 28
      HelpContext = 1423023
      Align = alTop
      Caption = 
        '(Choose the fields to Appear on the Details and Hint of Each Ite' +
        'm)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ExplicitWidth = 171
    end
    object chkCaption: TCheckBox
      AlignWithMargins = True
      Left = 23
      Top = 57
      Width = 148
      Height = 17
      HelpContext = 1423024
      Margins.Left = 22
      Align = alTop
      Caption = 'Item'
      TabOrder = 1
    end
    object chkProcessStep: TCheckBox
      AlignWithMargins = True
      Left = 23
      Top = 80
      Width = 148
      Height = 17
      HelpContext = 1423025
      Margins.Left = 22
      Align = alTop
      Caption = 'Process'
      TabOrder = 2
    end
    object chkTotalduration: TCheckBox
      AlignWithMargins = True
      Left = 23
      Top = 103
      Width = 148
      Height = 17
      HelpContext = 1423026
      Margins.Left = 22
      Align = alTop
      Caption = 'Total Duration'
      TabOrder = 3
    end
    object chkSchdDuration: TCheckBox
      AlignWithMargins = True
      Left = 23
      Top = 126
      Width = 148
      Height = 17
      HelpContext = 1423027
      Margins.Left = 22
      Align = alTop
      Caption = 'Scheduled Duration'
      TabOrder = 7
    end
    object chkProcessStatus: TCheckBox
      AlignWithMargins = True
      Left = 23
      Top = 218
      Width = 148
      Height = 17
      HelpContext = 1423028
      Margins.Left = 22
      Align = alTop
      Caption = 'Status'
      TabOrder = 4
    end
    object chkResourcename: TCheckBox
      AlignWithMargins = True
      Left = 23
      Top = 149
      Width = 148
      Height = 17
      HelpContext = 1423029
      Margins.Left = 22
      Align = alTop
      Caption = 'Resource'
      TabOrder = 5
    end
    object chkREsourceDetailName: TCheckBox
      AlignWithMargins = True
      Left = 23
      Top = 172
      Width = 148
      Height = 17
      HelpContext = 1423030
      Margins.Left = 22
      Align = alTop
      Caption = 'Resource Details'
      TabOrder = 0
    end
    object chkShowSchdtime: TCheckBox
      AlignWithMargins = True
      Left = 23
      Top = 195
      Width = 148
      Height = 17
      HelpContext = 1423031
      Margins.Left = 22
      Align = alTop
      Caption = 'Sheduled Time'
      TabOrder = 6
    end
  end
  object DNMPanel1: TDNMPanel [8]
    Left = 0
    Top = 82
    Width = 175
    Height = 252
    HelpContext = 1423005
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 167
      Height = 19
      Hint = 'Choose the fields to Appear on the Caption of Each Item'
      HelpContext = 1423006
      Align = alTop
      Caption = 'Caption'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      ExplicitWidth = 60
    end
    object Label4: TLabel
      Left = 1
      Top = 26
      Width = 173
      Height = 28
      HelpContext = 1423007
      Align = alTop
      Caption = '(Choose the fields to Appear on the Caption of Each Item)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ExplicitWidth = 171
    end
    object chkshowSaleId: TCheckBox
      AlignWithMargins = True
      Left = 23
      Top = 57
      Width = 148
      Height = 17
      HelpContext = 1423008
      Margins.Left = 22
      Align = alTop
      Caption = 'Sale #'
      TabOrder = 0
    end
    object chkCustomerName: TCheckBox
      AlignWithMargins = True
      Left = 23
      Top = 80
      Width = 148
      Height = 17
      HelpContext = 1423009
      Margins.Left = 22
      Align = alTop
      Caption = 'Customer Name'
      TabOrder = 1
    end
    object chkSaleDate: TCheckBox
      AlignWithMargins = True
      Left = 23
      Top = 103
      Width = 148
      Height = 17
      HelpContext = 1423010
      Margins.Left = 22
      Align = alTop
      Caption = 'Sale Date'
      TabOrder = 2
    end
    object chkShowProductName: TCheckBox
      AlignWithMargins = True
      Left = 23
      Top = 126
      Width = 148
      Height = 17
      HelpContext = 1423011
      Margins.Left = 22
      Align = alTop
      Caption = 'Product Name'
      TabOrder = 3
    end
    object chkUOM: TCheckBox
      AlignWithMargins = True
      Left = 23
      Top = 195
      Width = 148
      Height = 17
      HelpContext = 1423012
      Margins.Left = 22
      Align = alTop
      Caption = 'UOM'
      TabOrder = 4
    end
    object chkshipped: TCheckBox
      AlignWithMargins = True
      Left = 23
      Top = 172
      Width = 148
      Height = 17
      HelpContext = 1423013
      Margins.Left = 22
      Align = alTop
      Caption = 'Sales Quantity'
      TabOrder = 5
      OnClick = chkshippedClick
    end
    object chkShowProductDesc: TCheckBox
      AlignWithMargins = True
      Left = 23
      Top = 149
      Width = 148
      Height = 17
      HelpContext = 1423032
      Margins.Left = 22
      Align = alTop
      Caption = 'Product Description'
      TabOrder = 6
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 328
    Top = 40
  end
  inherited tmrdelay: TTimer
    Left = 328
    Top = 104
  end
  inherited popSpelling: TPopupMenu
    Left = 328
    Top = 72
  end
  inherited tmrdelayMsg: TTimer
    Left = 328
    Top = 8
  end
end
