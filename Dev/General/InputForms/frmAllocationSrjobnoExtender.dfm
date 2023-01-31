inherited fmAllocationSrjobnoExtender: TfmAllocationSrjobnoExtender
  Left = 299
  Top = 335
  HelpContext = 689000
  BorderStyle = bsNone
  Caption = 'fmAllocationSrjobnoExtender'
  ClientHeight = 357
  ClientWidth = 311
  ExplicitLeft = 299
  ExplicitTop = 335
  ExplicitWidth = 319
  ExplicitHeight = 384
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 357
    Width = 311
    HelpContext = 689009
  end
  object DNMPanel3: TDNMPanel [3]
    Left = 0
    Top = 0
    Width = 311
    Height = 357
    HelpContext = 689001
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      311
      357)
    object lblSelect: TLabel
      Left = 4
      Top = 3
      Width = 305
      Height = 15
      HelpContext = 689004
      Alignment = taCenter
      AutoSize = False
      Caption = 'Serial Numbers'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object DNMPanel4: TDNMPanel
      Left = 1
      Top = 293
      Width = 309
      Height = 63
      HelpContext = 689002
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        309
        63)
      object lblNote: TLabel
        Left = 1
        Top = 1
        Width = 307
        Height = 15
        HelpContext = 689003
        Align = alTop
        Alignment = taCenter
        Caption = 'Click In The Grid To Search...ALT+DEL To Clear Search'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExplicitWidth = 299
      end
      object btnCompleted: TDNMSpeedButton
        Left = 15
        Top = 23
        Width = 87
        Height = 27
        HelpContext = 689005
        Anchors = [akLeft, akBottom]
        Caption = '&Save'
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
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 0
        TabStop = False
        OnClick = btnCompletedClick
      end
      object btnClose: TDNMSpeedButton
        Left = 205
        Top = 23
        Width = 87
        Height = 27
        HelpContext = 689006
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
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 2
        TabStop = False
        OnClick = btnCloseClick
      end
      object cmdNew: TDNMSpeedButton
        Left = 110
        Top = 23
        Width = 87
        Height = 27
        HelpContext = 689007
        Anchors = []
        Caption = '&New'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
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
        TabOrder = 1
        OnClick = cmdNewClick
      end
    end
    object grdmain: TwwDBGrid
      Left = 4
      Top = 18
      Width = 305
      Height = 275
      HelpContext = 689008
      Selected.Strings = (
        'SerialNo'#9'45'#9'Serial number'#9'F'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = False
      Anchors = [akLeft, akTop, akRight, akBottom]
      Ctl3D = False
      DataSource = dsSerialNumbers
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyOptions = []
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgFooter3DCells, dgRowResize]
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clGreen
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      LineColors.FixedColor = clSilver
      OnDblClick = grdmainDblClick
      OnKeyUp = grdmainKeyUp
      FooterColor = clWhite
    end
  end
  object QrySerialNumbers: TERPQuery
    SQL.Strings = (
      'SELECT classId departmentID, Serialno FROM tblSerialnumbers')
    Filtered = True
    Left = 54
    Top = 153
    object QrySerialNumbersSerialNo: TWideStringField
      DisplayLabel = 'Serial number'
      DisplayWidth = 45
      FieldName = 'SerialNo'
      Origin = 'tblSerialnumbers.SerialNo'
      Size = 100
    end
    object QrySerialNumbersDepartmentID: TIntegerField
      FieldName = 'DepartmentID'
    end
  end
  object dsSerialNumbers: TDataSource
    DataSet = QrySerialNumbers
    Left = 51
    Top = 185
  end
end
