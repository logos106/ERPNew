inherited fmRecTrans: TfmRecTrans
  Left = 113
  Top = 274
  Caption = 'Reconciliation Inconsistancies'
  ClientHeight = 564
  ClientWidth = 998
  TransparentColor = True
  OldCreateOrder = True
  WindowState = wsMaximized
  ExplicitLeft = 113
  ExplicitTop = 274
  ExplicitWidth = 1014
  ExplicitHeight = 603
  DesignSize = (
    998
    564)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 564
    Width = 998
    ExplicitTop = 564
    ExplicitWidth = 998
  end
  object DNMPanel5: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 998
    Height = 69
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    DesignSize = (
      998
      69)
    object pnlHeader: TPanel
      Left = 186
      Top = 10
      Width = 561
      Height = 49
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 559
        Height = 47
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
          Width = 559
          Height = 47
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Reconciliation Inconsistancies'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 500
        end
      end
    end
  end
  object btnrefresh: TDNMSpeedButton [6]
    Left = 72
    Top = 532
    Width = 95
    Height = 27
    Anchors = [akBottom]
    Caption = 'Refresh'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 2
    AutoDisableParentOnclick = True
    OnClick = btnrefreshclick
  end
  object MainPage: TPageControl [7]
    Left = 0
    Top = 69
    Width = 998
    Height = 457
    ActivePage = TabSheet4
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    MultiLine = True
    ParentFont = False
    TabHeight = 25
    TabOrder = 0
    TabWidth = 189
    object TabSheet1: TTabSheet
      Caption = '1'
      object DNMPanel4: TDNMPanel
        Left = 0
        Top = 0
        Width = 990
        Height = 422
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          990
          422)
        object lbl1: TLabel
          Left = 1
          Top = 406
          Width = 988
          Height = 15
          Align = alBottom
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitWidth = 3
        end
        object Label1: TLabel
          Left = 1
          Top = 1
          Width = 988
          Height = 22
          Align = alTop
          Alignment = taCenter
          Caption = 'Deposits Reconciled but No Rec Record'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 367
        end
        object wwDBGrid1: TwwDBGrid
          Left = 1
          Top = 23
          Width = 988
          Height = 353
          Selected.Strings = (
            'ReconciliationID'#9'10'#9'Rec#'#9'F'
            'Seqno'#9'10'#9'Seqno'#9'F'#9
            'Notes'#9'35'#9'Notes'#9'F'
            'AccountID'#9'10'#9'AccountID'#9#9
            'DepositID'#9'10'#9'DepositID'#9#9
            'DepositLineID'#9'15'#9'DepositLineID'#9#9
            'DepositDate'#9'10'#9'DepositDate'#9#9
            'Amount'#9'10'#9'Amount'#9#9
            'PaymentID'#9'10'#9'PaymentID'#9#9
            'ReferenceNo'#9'1'#9'ReferenceNo'#9#9
            'CompanyName'#9'1'#9'CompanyName'#9#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          Align = alTop
          DataSource = ds1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          FooterColor = clWhite
        end
        object DNMSpeedButton5: TDNMSpeedButton
          Left = 448
          Top = 390
          Width = 95
          Height = 27
          Anchors = [akBottom]
          Caption = 'Update'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          ModalResult = 2
          ParentFont = False
          TabOrder = 1
          AutoDisableParentOnclick = True
          OnClick = DNMSpeedButton5Click
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = '2'
      ImageIndex = 1
      object DNMPanel3: TDNMPanel
        Left = 0
        Top = 0
        Width = 990
        Height = 422
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          990
          422)
        object lbl2: TLabel
          Left = 1
          Top = 406
          Width = 988
          Height = 15
          Align = alBottom
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitWidth = 3
        end
        object Label2: TLabel
          Left = 1
          Top = 1
          Width = 988
          Height = 22
          Align = alTop
          Alignment = taCenter
          Caption = 'Deposits Not Reconciled but Rec Record '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 378
        end
        object DNMSpeedButton4: TDNMSpeedButton
          Left = 470
          Top = 390
          Width = 95
          Height = 27
          Anchors = [akBottom]
          Caption = 'Update'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          ModalResult = 2
          ParentFont = False
          TabOrder = 0
          AutoDisableParentOnclick = True
          OnClick = DNMSpeedButton4Click
        end
        object wwDBGrid2: TwwDBGrid
          Left = 1
          Top = 23
          Width = 988
          Height = 353
          Selected.Strings = (
            'ReconciliationID'#9'10'#9'Rec#'#9'F'
            'Seqno'#9'10'#9'Seqno'#9'F'#9
            'Notes'#9'35'#9'Notes'#9'F'
            'AccountID'#9'10'#9'AccountID'#9#9
            'DepositID'#9'10'#9'DepositID'#9#9
            'DepositLineID'#9'15'#9'DepositLineID'#9#9
            'DepositDate'#9'10'#9'DepositDate'#9#9
            'Amount'#9'10'#9'Amount'#9#9
            'PaymentID'#9'10'#9'PaymentID'#9#9
            'ReferenceNo'#9'1'#9'ReferenceNo'#9#9
            'CompanyName'#9'1'#9'CompanyName'#9#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          Align = alTop
          DataSource = ds2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
          ParentFont = False
          TabOrder = 1
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          FooterColor = clWhite
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = '3'
      ImageIndex = 2
      object DNMPanel2: TDNMPanel
        Left = 0
        Top = 0
        Width = 990
        Height = 422
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          990
          422)
        object lbl3: TLabel
          Left = 1
          Top = 406
          Width = 988
          Height = 15
          Align = alBottom
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitWidth = 3
        end
        object Label3: TLabel
          Left = 1
          Top = 1
          Width = 988
          Height = 22
          Align = alTop
          Alignment = taCenter
          Caption = 'Withdrawal Reconciled but No Rec Record'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 387
        end
        object wwDBGrid3: TwwDBGrid
          Left = 1
          Top = 23
          Width = 988
          Height = 353
          Selected.Strings = (
            'ReconciliationID'#9'10'#9'Rec#'#9'F'
            'Seqno'#9'10'#9'Seqno'#9'F'#9
            'Notes'#9'35'#9'Notes'#9'F'
            'AccountID'#9'10'#9'AccountID'#9#9
            'DepositID'#9'10'#9'DepositID'#9#9
            'DepositLineID'#9'15'#9'DepositLineID'#9#9
            'DepositDate'#9'10'#9'DepositDate'#9#9
            'Amount'#9'10'#9'Amount'#9#9
            'PaymentID'#9'10'#9'PaymentID'#9#9
            'ReferenceNo'#9'1'#9'ReferenceNo'#9#9
            'CompanyName'#9'1'#9'CompanyName'#9#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          Align = alTop
          DataSource = ds3
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          FooterColor = clWhite
        end
        object DNMSpeedButton3: TDNMSpeedButton
          Left = 470
          Top = 390
          Width = 95
          Height = 27
          Anchors = [akBottom]
          Caption = 'Update'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          ModalResult = 2
          ParentFont = False
          TabOrder = 1
          AutoDisableParentOnclick = True
          OnClick = DNMSpeedButton3Click
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = '4'
      ImageIndex = 3
      object DNMPanel1: TDNMPanel
        Left = 0
        Top = 0
        Width = 990
        Height = 422
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          990
          422)
        object lbl4: TLabel
          Left = 1
          Top = 406
          Width = 988
          Height = 15
          Align = alBottom
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitWidth = 3
        end
        object Label4: TLabel
          Left = 1
          Top = 1
          Width = 988
          Height = 22
          Align = alTop
          Alignment = taCenter
          Caption = 'Withdrawal Not Reconciled but Rec Record '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 398
        end
        object wwDBGrid4: TwwDBGrid
          Left = 1
          Top = 23
          Width = 988
          Height = 353
          Selected.Strings = (
            'ReconciliationID'#9'10'#9'Rec#'#9'F'
            'Seqno'#9'10'#9'Seqno'#9'F'#9
            'Notes'#9'35'#9'Notes'#9'F'
            'AccountID'#9'10'#9'AccountID'#9#9
            'DepositID'#9'10'#9'DepositID'#9#9
            'DepositLineID'#9'15'#9'DepositLineID'#9#9
            'DepositDate'#9'10'#9'DepositDate'#9#9
            'Amount'#9'10'#9'Amount'#9#9
            'PaymentID'#9'10'#9'PaymentID'#9#9
            'ReferenceNo'#9'1'#9'ReferenceNo'#9#9
            'CompanyName'#9'1'#9'CompanyName'#9#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          Align = alTop
          DataSource = ds4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          FooterColor = clWhite
        end
        object DNMSpeedButton2: TDNMSpeedButton
          Left = 470
          Top = 390
          Width = 95
          Height = 27
          Anchors = [akBottom]
          Caption = 'Update'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          ModalResult = 2
          ParentFont = False
          TabOrder = 1
          AutoDisableParentOnclick = True
          OnClick = DNMSpeedButton2Click
        end
      end
    end
  end
  object btnPopulateSQL: TDNMSpeedButton [8]
    Left = 8
    Top = 504
    Width = 100
    Height = 23
    Caption = 'Populate SQL'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 5
    AutoDisableParentOnclick = True
    OnClick = btnPopulateSQLClick
  end
  object btnCancel: TDNMSpeedButton [9]
    Left = -47
    Top = 530
    Width = 95
    Height = 27
    Anchors = [akBottom]
    Caption = 'Print'
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    AutoDisableParentOnclick = True
    OnClick = Button2Click
  end
  object DNMSpeedButton1: TDNMSpeedButton [10]
    Left = -47
    Top = 530
    Width = 95
    Height = 27
    Anchors = [akBottom]
    Caption = 'History'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 3
    AutoDisableParentOnclick = True
    OnClick = DNMSpeedButton1Click
  end
  inherited dlgReportSelect: TSelectionDialog
    Top = 96
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 112
    Top = 96
  end
  inherited DataState: TDataState
    Left = 40
    Top = 96
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 240
    Top = 96
  end
  inherited imgsort: TImageList
    Left = 76
    Top = 100
    Bitmap = {
      494C01010200AC00B40010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  inherited QryCustomField: TERPQuery
    Left = 154
    Top = 96
  end
  object Qry1: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'T.*  , `RwL`.`ReconciliationLineID`  , Rwl.ReconciliationID  '
      'FROM'
      'tmp_bankrec AS `T`'
      
        'Left Join  `tblreconciliationwithdrawallines` AS `RwL` ON `RwL`.' +
        '`PaymentID` = `T`.`DepositID` AND `RwL`.`DepositLineID` = `T`.`D' +
        'epositLineID` AND `RwL`.`ClientID` = `T`.`CusID` AND `RwL`.`Refe' +
        'rence` = `T`.`ReferenceNo` AND `RwL`.`DepositDate` = `T`.`Deposi' +
        'tDate` AND `RwL`.`AccountID` = `T`.`AccountID` and `T`.`Category' +
        '` =  "Withdrawal"'
      
        'WHERE T.reconciled = "T" and ifnull(`RwL`.`ReconciliationLineID`' +
        ' ,0) = 0  '
      'and Category = "Deposit"')
    AfterOpen = Qry1AfterOpen
    Options.LongStrings = False
    Left = 10
    Top = 184
    object Qry1ID: TIntegerField
      FieldName = 'ID'
    end
    object Qry1SeqNo: TIntegerField
      FieldName = 'SeqNo'
    end
    object Qry1Reconciled: TWideStringField
      FieldName = 'Reconciled'
      FixedChar = True
      Size = 1
    end
    object Qry1ReconciledFlagtype: TWideStringField
      FieldName = 'ReconciledFlagtype'
      Size = 1
    end
    object Qry1Description: TWideStringField
      FieldName = 'Description'
      Size = 50
    end
    object Qry1Category: TWideStringField
      FieldName = 'Category'
      Size = 50
    end
    object Qry1AccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object Qry1DepositID: TIntegerField
      FieldName = 'DepositID'
    end
    object Qry1DepositLineID: TIntegerField
      FieldName = 'DepositLineID'
    end
    object Qry1DepositDate: TDateTimeField
      FieldName = 'DepositDate'
    end
    object Qry1Amount: TFloatField
      FieldName = 'Amount'
    end
    object Qry1PaymentID: TIntegerField
      FieldName = 'PaymentID'
    end
    object Qry1CusID: TIntegerField
      FieldName = 'CusID'
    end
    object Qry1ReferenceNo: TWideStringField
      FieldName = 'ReferenceNo'
      Size = 255
    end
    object Qry1Notes: TWideStringField
      FieldName = 'Notes'
      Size = 255
    end
    object Qry1CompanyName: TWideStringField
      FieldName = 'CompanyName'
      Size = 100
    end
    object Qry1ReconciliationLineID: TIntegerField
      FieldName = 'ReconciliationLineID'
    end
    object Qry1ReconciliationID: TIntegerField
      FieldName = 'ReconciliationID'
    end
  end
  object qry2: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'T.*  , `RwL`.`ReconciliationLineID` , Rwl.ReconciliationID  '
      'FROM'
      'tmp_bankrec  AS `T`'
      
        'Left Join  `tblreconciliationwithdrawallines` AS `RwL` ON `RwL`.' +
        '`PaymentID` = `T`.`DepositID` AND `RwL`.`DepositLineID` = `T`.`D' +
        'epositLineID` AND `RwL`.`ClientID` = `T`.`CusID` AND `RwL`.`Refe' +
        'rence` = `T`.`ReferenceNo` AND `RwL`.`DepositDate` = `T`.`Deposi' +
        'tDate` AND `RwL`.`AccountID` = `T`.`AccountID` and `T`.`Category' +
        '` =  "Withdrawal"'
      
        'WHERE T.reconciled = "F" and ifnull(`RwL`.`ReconciliationLineID`' +
        ' ,0) <> 0  '
      'and Category = "Deposit"')
    AfterOpen = qry2AfterOpen
    Options.LongStrings = False
    Left = 50
    Top = 184
    object qry2ID: TIntegerField
      FieldName = 'ID'
    end
    object qry2SeqNo: TIntegerField
      FieldName = 'SeqNo'
    end
    object qry2Reconciled: TWideStringField
      FieldName = 'Reconciled'
      FixedChar = True
      Size = 1
    end
    object qry2ReconciledFlagtype: TWideStringField
      FieldName = 'ReconciledFlagtype'
      Size = 1
    end
    object qry2Description: TWideStringField
      FieldName = 'Description'
      Size = 50
    end
    object qry2Category: TWideStringField
      FieldName = 'Category'
      Size = 50
    end
    object qry2AccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object qry2DepositID: TIntegerField
      FieldName = 'DepositID'
    end
    object qry2DepositLineID: TIntegerField
      FieldName = 'DepositLineID'
    end
    object qry2DepositDate: TDateTimeField
      FieldName = 'DepositDate'
    end
    object qry2Amount: TFloatField
      FieldName = 'Amount'
    end
    object qry2PaymentID: TIntegerField
      FieldName = 'PaymentID'
    end
    object qry2CusID: TIntegerField
      FieldName = 'CusID'
    end
    object qry2ReferenceNo: TWideStringField
      FieldName = 'ReferenceNo'
      Size = 255
    end
    object qry2Notes: TWideStringField
      FieldName = 'Notes'
      Size = 255
    end
    object qry2CompanyName: TWideStringField
      FieldName = 'CompanyName'
      Size = 100
    end
    object qry2ReconciliationLineID: TIntegerField
      FieldName = 'ReconciliationLineID'
    end
    object qry2ReconciliationID: TIntegerField
      FieldName = 'ReconciliationID'
    end
  end
  object Qry3: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'T.*  , `RwL`.`ReconciliationLineID`  , Rwl.ReconciliationID  '
      'FROM'
      'tmp_bankrec AS `T`'
      
        'Left Join  `tblreconciliationwithdrawallines` AS `RwL` ON `RwL`.' +
        '`PaymentID` = `T`.`DepositID` AND `RwL`.`DepositLineID` = `T`.`D' +
        'epositLineID` AND `RwL`.`ClientID` = `T`.`CusID` AND `RwL`.`Refe' +
        'rence` = `T`.`ReferenceNo` AND `RwL`.`DepositDate` = `T`.`Deposi' +
        'tDate` AND `RwL`.`AccountID` = `T`.`AccountID` and `T`.`Category' +
        '` =  "Withdrawal"'
      
        'WHERE T.reconciled = "T" and ifnull(`RwL`.`ReconciliationLineID`' +
        ' ,0) = 0  '
      'and Category = "Withdrawal"')
    AfterOpen = Qry3AfterOpen
    Options.LongStrings = False
    Left = 90
    Top = 184
    object Qry3ID: TIntegerField
      FieldName = 'ID'
    end
    object Qry3SeqNo: TIntegerField
      FieldName = 'SeqNo'
    end
    object Qry3Reconciled: TWideStringField
      FieldName = 'Reconciled'
      FixedChar = True
      Size = 1
    end
    object Qry3ReconciledFlagtype: TWideStringField
      FieldName = 'ReconciledFlagtype'
      Size = 1
    end
    object Qry3Description: TWideStringField
      FieldName = 'Description'
      Size = 50
    end
    object Qry3Category: TWideStringField
      FieldName = 'Category'
      Size = 50
    end
    object Qry3AccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object Qry3DepositID: TIntegerField
      FieldName = 'DepositID'
    end
    object Qry3DepositLineID: TIntegerField
      FieldName = 'DepositLineID'
    end
    object Qry3DepositDate: TDateTimeField
      FieldName = 'DepositDate'
    end
    object Qry3Amount: TFloatField
      FieldName = 'Amount'
    end
    object Qry3PaymentID: TIntegerField
      FieldName = 'PaymentID'
    end
    object Qry3CusID: TIntegerField
      FieldName = 'CusID'
    end
    object Qry3ReferenceNo: TWideStringField
      FieldName = 'ReferenceNo'
      Size = 255
    end
    object Qry3Notes: TWideStringField
      FieldName = 'Notes'
      Size = 255
    end
    object Qry3CompanyName: TWideStringField
      FieldName = 'CompanyName'
      Size = 100
    end
    object Qry3ReconciliationLineID: TIntegerField
      FieldName = 'ReconciliationLineID'
    end
    object Qry3ReconciliationID: TIntegerField
      FieldName = 'ReconciliationID'
    end
  end
  object Qry4: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'T.*  , `RwL`.`ReconciliationLineID`  , Rwl.ReconciliationID  '
      'FROM'
      'tmp_bankrec AS `T`'
      
        'Left Join  `tblreconciliationwithdrawallines` AS `RwL` ON `RwL`.' +
        '`PaymentID` = `T`.`DepositID` AND `RwL`.`DepositLineID` = `T`.`D' +
        'epositLineID` AND `RwL`.`ClientID` = `T`.`CusID` AND `RwL`.`Refe' +
        'rence` = `T`.`ReferenceNo` AND `RwL`.`DepositDate` = `T`.`Deposi' +
        'tDate` AND `RwL`.`AccountID` = `T`.`AccountID` and `T`.`Category' +
        '` =  "Withdrawal"'
      
        'WHERE T.reconciled = "F" and ifnull(`RwL`.`ReconciliationLineID`' +
        ' ,0) <> 0  '
      'and Category = "Withdrawal"')
    AfterOpen = Qry4AfterOpen
    Options.LongStrings = False
    Left = 122
    Top = 184
    object Qry4ID: TIntegerField
      FieldName = 'ID'
    end
    object Qry4SeqNo: TIntegerField
      FieldName = 'SeqNo'
    end
    object Qry4Reconciled: TWideStringField
      FieldName = 'Reconciled'
      FixedChar = True
      Size = 1
    end
    object Qry4ReconciledFlagtype: TWideStringField
      FieldName = 'ReconciledFlagtype'
      Size = 1
    end
    object Qry4Description: TWideStringField
      FieldName = 'Description'
      Size = 50
    end
    object Qry4Category: TWideStringField
      FieldName = 'Category'
      Size = 50
    end
    object Qry4AccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object Qry4DepositID: TIntegerField
      FieldName = 'DepositID'
    end
    object Qry4DepositLineID: TIntegerField
      FieldName = 'DepositLineID'
    end
    object Qry4DepositDate: TDateTimeField
      FieldName = 'DepositDate'
    end
    object Qry4Amount: TFloatField
      FieldName = 'Amount'
    end
    object Qry4PaymentID: TIntegerField
      FieldName = 'PaymentID'
    end
    object Qry4CusID: TIntegerField
      FieldName = 'CusID'
    end
    object Qry4ReferenceNo: TWideStringField
      FieldName = 'ReferenceNo'
      Size = 255
    end
    object Qry4Notes: TWideStringField
      FieldName = 'Notes'
      Size = 255
    end
    object Qry4CompanyName: TWideStringField
      FieldName = 'CompanyName'
      Size = 100
    end
    object Qry4ReconciliationLineID: TIntegerField
      FieldName = 'ReconciliationLineID'
    end
    object Qry4ReconciliationID: TIntegerField
      FieldName = 'ReconciliationID'
    end
  end
  object ds1: TDataSource
    DataSet = Qry1
    Left = 8
    Top = 224
  end
  object ds2: TDataSource
    DataSet = qry2
    Left = 56
    Top = 224
  end
  object ds3: TDataSource
    DataSet = Qry3
    Left = 96
    Top = 224
  end
  object ds4: TDataSource
    DataSet = Qry4
    Left = 136
    Top = 224
  end
  object qry5: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'T.*  , `RwL`.`ReconciliationLineID`  , Rwl.ReconciliationID  '
      'FROM'
      'tmp_bankrec AS `T`'
      
        'Left Join  `tblreconciliationwithdrawallines` AS `RwL` ON `RwL`.' +
        '`PaymentID` = `T`.`DepositID` AND `RwL`.`DepositLineID` = `T`.`D' +
        'epositLineID` AND `RwL`.`ClientID` = `T`.`CusID` AND `RwL`.`Refe' +
        'rence` = `T`.`ReferenceNo` AND `RwL`.`DepositDate` = `T`.`Deposi' +
        'tDate` AND `RwL`.`AccountID` = `T`.`AccountID` and `T`.`Category' +
        '` =  "Withdrawal"'
      
        'WHERE T.reconciled = "F" and ifnull(`RwL`.`ReconciliationLineID`' +
        ' ,0) <> 0  '
      'and Category = "Withdrawal"')
    Options.LongStrings = False
    Left = 170
    Top = 184
    object IntegerField1: TIntegerField
      FieldName = 'ID'
    end
    object IntegerField2: TIntegerField
      FieldName = 'SeqNo'
    end
    object StringField1: TWideStringField
      FieldName = 'Reconciled'
      FixedChar = True
      Size = 1
    end
    object StringField2: TWideStringField
      FieldName = 'ReconciledFlagtype'
      Size = 1
    end
    object StringField3: TWideStringField
      FieldName = 'Description'
      Size = 50
    end
    object StringField4: TWideStringField
      FieldName = 'Category'
      Size = 50
    end
    object IntegerField3: TIntegerField
      FieldName = 'AccountID'
    end
    object IntegerField4: TIntegerField
      FieldName = 'DepositID'
    end
    object IntegerField5: TIntegerField
      FieldName = 'DepositLineID'
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'DepositDate'
    end
    object FloatField1: TFloatField
      FieldName = 'Amount'
    end
    object IntegerField6: TIntegerField
      FieldName = 'PaymentID'
    end
    object IntegerField7: TIntegerField
      FieldName = 'CusID'
    end
    object StringField5: TWideStringField
      FieldName = 'ReferenceNo'
      Size = 255
    end
    object StringField6: TWideStringField
      FieldName = 'Notes'
      Size = 255
    end
    object StringField7: TWideStringField
      FieldName = 'CompanyName'
      Size = 100
    end
    object IntegerField8: TIntegerField
      FieldName = 'ReconciliationLineID'
    end
    object IntegerField9: TIntegerField
      FieldName = 'ReconciliationID'
    end
  end
  object ds5: TDataSource
    DataSet = qry5
    Left = 184
    Top = 224
  end
  object ds6: TDataSource
    DataSet = qry6
    Left = 240
    Top = 224
  end
  object qry6: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select BDL.TrnsType , R.ReconciliationID,PO.TotalAmountInc  , PO' +
        '.PurchaseOrderId transId, PO.suppliername, BDL.CompanyName , RWL' +
        '.Payee  , RWL.ReconciliationLineID , '#39'rwl'#39' category'
      'From tblpurchaseorders PO '
      'INNER JOIN tblbankdepositlines BDL ON '
      'PO.PurchaseOrderID = BDL.PaymentID AND '
      'PO.SupplierName = BDL.CompanyName AND '
      'PO.ClientID = BDL.CusID AND '
      'PO.OrderDate = BDL.PaymentDate AND '
      'BDL.TrnsType="Cheque" '
      'INNER JOIN tblreconciliationwithdrawallines RWL'#9'ON '
      'BDL.DepositID = RWL.PaymentID AND '
      '#BDL.CompanyName = RWL.Payee AND '
      'BDL.PaymentDate = RWL.DepositDate AND '
      'ABS(PO.TotalAmountInc) = ABS(RWL.Amount) AND '
      'BDL.TrnsType = RWL.Notes '
      
        'INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.Recon' +
        'ciliationID '
      
        '#Where PO.PurchaseOrderID=0 AND PO.IsCheque="T" AND R.Deleted<>"' +
        'T" AND R.Finished="T" '
      'Where BDL.CompanyName <> RWL.Payee '
      'Group By R.ReconciliationID '
      
        'HAVING Round(PO.TotalAmountInc,2) = Round(Sum(If(BDL.TrnsType="C' +
        'heque",-BDL.Amount,0.00)),2)'
      'union all '
      
        'Select BDL.TrnsType, R.ReconciliationID,PO.TotalAmountInc , PO.P' +
        'urchaseOrderId , PO.suppliername, BDL.CompanyName , '
      'RdL.Payee  , RdL.ReconciliationLineID , '#39'rdl'#39'  '
      'From tblpurchaseorders PO '
      'INNER JOIN tblbankdepositlines BDL ON '
      'PO.PurchaseOrderID = BDL.PaymentID AND '
      'PO.SupplierName = BDL.CompanyName AND '
      'PO.ClientID = BDL.CusID AND '
      'PO.OrderDate = BDL.PaymentDate AND '
      'BDL.TrnsType="Cheque" '
      'INNER JOIN tblreconciliationdepositlines RDL'#9'ON '
      'BDL.DepositID = RDL.PaymentID AND '
      'BDL.PaymentDate = RDL.DepositDate AND '
      'ABS(PO.TotalAmountInc) = ABS(RDL.Amount) AND '
      'BDL.TrnsType = RDL.Notes '
      
        'INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.Recon' +
        'ciliationID '
      
        '#Where PO.PurchaseOrderID=0 AND PO.IsCheque="T" AND R.Deleted<>"' +
        'T" AND R.Finished="T" '
      'Where BDL.CompanyName <> RDL.Payee '
      'Group By R.ReconciliationID '
      
        'HAVING Round(PO.TotalAmountInc,2) = Round(Sum(If(BDL.TrnsType="C' +
        'heque",-BDL.Amount,0.00)),2)'
      'union all '
      
        'Select BDL.TrnsType , R.ReconciliationID  , PO.TotalAmountInc  ,' +
        ' PO.PurchaseOrderId , PO.suppliername, BDL.CompanyName , RWL.Pay' +
        'ee  , RWL.ReconciliationLineID , '#39'rwl'#39
      'From tblpurchaseorders PO '
      'INNER JOIN tblbankdepositlines BDL ON '
      'PO.PurchaseOrderID = BDL.PaymentID AND '
      'PO.SupplierName = BDL.CompanyName AND '
      'PO.ClientID = BDL.CusID AND '
      'PO.OrderDate = BDL.PaymentDate AND '
      'BDL.TrnsType="Cheque Deposit" '
      'INNER JOIN tblreconciliationwithdrawallines RWL'#9'ON '
      'BDL.DepositID = RWL.PaymentID AND '
      ''
      'BDL.PaymentDate = RWL.DepositDate AND '
      'ABS(BDL.Amount) = ABS(RWL.Amount) AND '
      'BDL.TrnsType = RWL.Notes '
      
        'INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.Recon' +
        'ciliationID '
      
        '#Where PO.PurchaseOrderID=0 AND PO.IsCheque="T" AND R.Deleted<>"' +
        'T" AND R.Finished="T" '
      'Where BDL.CompanyName <> RWL.Payee '
      'Group By R.ReconciliationID '
      'union all '
      ''
      ''
      
        'Select BDL.TrnsType,R.ReconciliationID ,PO.TotalAmountInc , PO.P' +
        'urchaseOrderId , PO.suppliername, BDL.CompanyName , RdL.Payee  ,' +
        ' RdL.ReconciliationLineID , '#39'rdl'#39
      'From tblpurchaseorders PO '
      'INNER JOIN tblbankdepositlines BDL ON '
      'PO.PurchaseOrderID = BDL.PaymentID AND '
      'PO.SupplierName = BDL.CompanyName AND '
      'PO.ClientID = BDL.CusID AND '
      'PO.OrderDate = BDL.PaymentDate AND '
      'BDL.TrnsType="Cheque Deposit" '
      'INNER JOIN tblreconciliationdepositlines RDL'#9'ON '
      'BDL.DepositID = RDL.PaymentID AND '
      ''
      'BDL.PaymentDate = RDL.DepositDate AND '
      'ABS(BDL.Amount) = ABS(RDL.Amount) AND '
      'BDL.TrnsType = RDL.Notes '
      
        'INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.Recon' +
        'ciliationID '
      'Where BDL.CompanyName <> RDL.Payee '
      'Group By R.ReconciliationID'
      ''
      'union all '
      'Select BDL.TrnsType , '
      
        'R.ReconciliationID  , BDL.Amount , BDL.PaymentID , PP.CompanyNam' +
        'e ,  BDL.CompanyName , RDL.Payee, RdL.ReconciliationLineID , '#39'rd' +
        'l'#39
      'From tblprepayments PP '
      'INNER JOIN tblbankdepositlines BDL ON '
      'BDL.PaymentID = PP.PrePaymentID AND '
      'BDL.PaymentDate = PP.PrePaymentDate AND '
      'BDL.AccountID = PP.BankAccountID AND '
      'BDL.Amount = PP.PayAmount  AND '
      'BDL.CompanyName= PP.CompanyName AND '
      'BDL.CusID=PP.ClientID AND '
      'BDL.TrnsType = "Customer Prepayment" '
      'INNER JOIN tblreconciliationdepositlines RDL'#9'ON '
      'BDL.DepositID = RDL.PaymentID AND '
      'BDL.PaymentDate = RDL.DepositDate AND '
      'BDL.AccountID = RDL.AccountID AND '
      'BDL.Amount = RDL.Amount AND '
      'BDL.TrnsType = RDL.Notes AND '
      'BDL.DepositLineID = RDL.DepositLineID '
      
        'INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.Recon' +
        'ciliationID '
      'Where BDL.CompanyName <> RDL.Payee '
      'Group By R.ReconciliationID '
      ''
      'union all'
      ''
      ''
      'Select '
      'BDL.TrnsType , '
      
        'R.ReconciliationID  , BDL.Amount , BDL.PaymentID , PP.CompanyNam' +
        'e ,  BDL.CompanyName , RwL.Payee , RwL.ReconciliationLineID , '#39'r' +
        'wl'#39'  '
      'From tblprepayments PP '
      'INNER JOIN tblbankdepositlines BDL ON '
      'BDL.PaymentID = PP.PrePaymentID AND '
      'BDL.PaymentDate = PP.PrePaymentDate AND '
      'BDL.AccountID = PP.BankAccountID AND '
      'BDL.Amount = PP.PayAmount  AND '
      'BDL.CompanyName= PP.CompanyName AND '
      'BDL.CusID=PP.ClientID AND '
      'BDL.TrnsType = "Customer Prepayment" '
      'INNER JOIN tblreconciliationwithdrawallines RWL'#9'ON '
      'BDL.DepositID = RWL.PaymentID AND '
      'BDL.PaymentDate = RWL.DepositDate AND '
      'BDL.AccountID = RWL.AccountID AND '
      '-BDL.Amount = RWL.Amount AND '
      'BDL.TrnsType = RWL.Notes AND '
      'BDL.DepositLineID = RWL.DepositLineID '
      
        'INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.Recon' +
        'ciliationID '
      'Where BDL.CompanyName <> RWL.Payee '
      'Group By R.ReconciliationID '
      'union all '
      'Select '
      'BDL.TrnsType , '
      
        'R.ReconciliationID  , BDL.Amount , BDL.PaymentID , PP.CompanyNam' +
        'e ,  BDL.CompanyName , RwL.Payee , RwL.ReconciliationLineID , '#39'r' +
        'wl'#39'  '
      'From tblprepayments PP '
      'INNER JOIN tblbankdepositlines BDL ON '
      'BDL.PaymentID = PP.PrePaymentID AND '
      'BDL.PaymentDate = PP.PrePaymentDate AND '
      'BDL.AccountID = PP.BankAccountID AND '
      'BDL.Amount = PP.PayAmount  AND '
      'BDL.CompanyName= PP.CompanyName AND '
      'BDL.CusID=PP.ClientID AND '
      'BDL.TrnsType = "Supplier Prepayment" '
      'INNER JOIN tblreconciliationwithdrawallines RWL'#9'ON '
      'BDL.DepositID = RWL.PaymentID AND '
      ''
      'BDL.PaymentDate = RWL.DepositDate AND '
      'BDL.AccountID = RWL.AccountID AND '
      'BDL.Amount = RWL.Amount AND '
      'BDL.TrnsType = RWL.Notes AND '
      'BDL.DepositLineID = RWL.DepositLineID '
      
        'INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.Recon' +
        'ciliationID '
      'Where BDL.CompanyName <> RWL.Payee '
      'Group By R.ReconciliationID '
      'union all '
      'Select '
      'BDL.TrnsType , '
      
        'R.ReconciliationID  , BDL.Amount , BDL.PaymentID , PP.CompanyNam' +
        'e ,  BDL.CompanyName , RdL.Payee, RdL.ReconciliationLineID , '#39'rd' +
        'l'#39'  '
      'From tblprepayments PP '
      'INNER JOIN tblbankdepositlines BDL ON '
      'BDL.PaymentID = PP.PrePaymentID AND '
      'BDL.PaymentDate = PP.PrePaymentDate AND '
      'BDL.AccountID = PP.BankAccountID AND '
      'BDL.Amount = PP.PayAmount  AND '
      'BDL.CompanyName= PP.CompanyName AND '
      'BDL.CusID=PP.ClientID AND '
      'BDL.TrnsType = "Supplier Prepayment" '
      'INNER JOIN tblreconciliationdepositlines RDL'#9'ON '
      'BDL.DepositID = RDL.PaymentID AND '
      ''
      'BDL.PaymentDate = RDL.DepositDate AND '
      'BDL.AccountID = RDL.AccountID AND '
      '-BDL.Amount = RDL.Amount AND '
      'BDL.TrnsType = RDL.Notes AND '
      'BDL.DepositLineID = RDL.DepositLineID '
      
        'INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.Recon' +
        'ciliationID '
      'Where BDL.CompanyName <> RDL.Payee '
      'Group By R.ReconciliationID '
      'union all'
      ''
      'Select '
      'BDL.TrnsType , '
      
        'R.ReconciliationID  , BDL.Amount , BDL.PaymentID , D.CompanyName' +
        ' ,  BDL.CompanyName , RdL.Payee, RdL.ReconciliationLineID , '#39'rdl' +
        #39'  '
      ''
      'From tbldeposits D '
      'INNER JOIN tbldepositline DL USING(PaymentID) '
      'INNER JOIN tblbankdepositlines BDL ON '
      'BDL.PaymentID = D.PaymentID AND '
      'BDL.PaymentDate = D.PaymentDate AND '
      'BDL.AccountID = D.AccountID AND '
      'BDL.Amount = D.Amount  AND '
      'BDL.CompanyName = D.CompanyName AND '
      'BDL.CusID = D.CusID AND '
      'BDL.TrnsType = "Customer Payment" '
      'INNER JOIN tblreconciliationdepositlines RDL'#9'ON '
      'BDL.DepositID = RDL.PaymentID AND '
      'BDL.CompanyName = RDL.Payee AND '
      'BDL.PaymentDate = RDL.DepositDate AND '
      'BDL.AccountID = RDL.AccountID AND '
      'BDL.Amount = RDL.Amount AND '
      'BDL.TrnsType = RDL.Notes AND '
      'BDL.DepositLineID = RDL.DepositLineID '
      
        'INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.Recon' +
        'ciliationID '
      
        'Where D.PaymentID=0 AND D.Deleted<>"T" AND R.Deleted<>"T" AND R.' +
        'Finished="T" '
      'Group By R.ReconciliationID '
      ''
      'union all '
      ''
      ''
      ''
      'Select '
      'BDL.TrnsType , '
      
        'R.ReconciliationID  , BDL.Amount , BDL.PaymentID , D.CompanyName' +
        ' ,  BDL.CompanyName , RwL.Payee , RwL.ReconciliationLineID , '#39'rw' +
        'l'#39'  '
      'From tbldeposits D '
      'INNER JOIN tbldepositline DL USING(PaymentID) '
      'INNER JOIN tblbankdepositlines BDL ON '
      'BDL.PaymentID = D.PaymentID AND '
      'BDL.PaymentDate = D.PaymentDate AND '
      'BDL.AccountID = D.AccountID AND '
      'BDL.Amount = D.Amount  AND '
      'BDL.CompanyName = D.CompanyName AND '
      'BDL.CusID = D.CusID AND '
      'BDL.TrnsType = "Customer Payment" '
      'INNER JOIN tblreconciliationwithdrawallines RWL'#9'ON '
      'BDL.DepositID = RWL.PaymentID AND '
      ''
      'BDL.PaymentDate = RWL.DepositDate AND '
      'BDL.AccountID = RWL.AccountID AND '
      '-BDL.Amount = RWL.Amount AND '
      'BDL.TrnsType = RWL.Notes AND '
      'BDL.DepositLineID = RWL.DepositLineID '
      
        'INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.Recon' +
        'ciliationID '
      'Where BDL.CompanyName <> RWL.Payee '
      'Group By R.ReconciliationID '
      'union all '
      'Select '
      'BDL.TrnsType , '
      
        'R.ReconciliationID  , BDL.Amount , BDL.PaymentID , w.CompanyName' +
        ' ,  BDL.CompanyName , RwL.Payee , RwL.ReconciliationLineID , '#39'rw' +
        'l'#39'  '
      'From tblwithdrawal W '
      'INNER JOIN tblwithdrawallines WL USING(PaymentID) '
      'INNER JOIN tblbankdepositlines BDL ON '
      'BDL.PaymentID = W.PaymentID AND '
      'BDL.PaymentDate = W.PaymentDate AND '
      'BDL.AccountID = W.AccountID AND '
      '-BDL.Amount = W.Amount  AND '
      'BDL.CompanyName = W.CompanyName AND '
      'BDL.CusID = W.SupplierID AND '
      'BDL.TrnsType = "Supplier Payment" '
      'INNER JOIN tblreconciliationwithdrawallines RWL'#9'ON '
      'BDL.DepositID = RWL.PaymentID AND '
      ''
      'BDL.PaymentDate = RWL.DepositDate AND '
      'BDL.AccountID = RWL.AccountID AND '
      'W.Amount = RWL.Amount AND '
      'BDL.TrnsType = RWL.Notes AND '
      'BDL.DepositLineID = RWL.DepositLineID '
      
        'INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.Recon' +
        'ciliationID '
      'Where BDL.CompanyName <> RWL.Payee '
      'Group By R.ReconciliationID '
      ''
      'union all '
      'Select '
      'BDL.TrnsType , '
      
        'R.ReconciliationID  , BDL.Amount , BDL.PaymentID , w.CompanyName' +
        ' ,  BDL.CompanyName , RdL.Payee, RdL.ReconciliationLineID , '#39'rdl' +
        #39'  '
      ''
      'From tblwithdrawal W '
      'INNER JOIN tblwithdrawallines WL USING(PaymentID) '
      'INNER JOIN tblbankdepositlines BDL ON '
      'BDL.PaymentID = W.PaymentID AND '
      'BDL.PaymentDate = W.PaymentDate AND '
      'BDL.AccountID = W.AccountID AND '
      '-BDL.Amount = W.Amount  AND '
      'BDL.CompanyName = W.CompanyName AND '
      'BDL.CusID = W.SupplierID AND '
      'BDL.TrnsType = "Supplier Payment" '
      'INNER JOIN tblreconciliationdepositlines RDL'#9'ON '
      'BDL.DepositID = RDL.PaymentID AND '
      'BDL.CompanyName = RDL.Payee AND '
      'BDL.PaymentDate = RDL.DepositDate AND '
      'BDL.AccountID = RDL.AccountID AND '
      '-W.Amount = RDL.Amount AND '
      'BDL.TrnsType = RDL.Notes AND '
      'BDL.DepositLineID = RDL.DepositLineID '
      
        'INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.Recon' +
        'ciliationID '
      'Where W.PaymentID=0 AND R.Deleted<>"T" AND R.Finished="T" '
      'Group By R.ReconciliationID '
      ''
      'order by suppliername')
    AfterOpen = qry6AfterOpen
    Options.LongStrings = False
    Left = 226
    Top = 184
    object qry6TrnsType: TWideStringField
      FieldName = 'TrnsType'
      Size = 255
    end
    object qry6ReconciliationID: TIntegerField
      FieldName = 'ReconciliationID'
    end
    object qry6TotalAmountInc: TFloatField
      FieldName = 'TotalAmountInc'
    end
    object qry6suppliername: TWideStringField
      FieldName = 'suppliername'
      Size = 255
    end
    object qry6CompanyName: TWideStringField
      FieldName = 'CompanyName'
      Size = 100
    end
    object qry6Payee: TWideStringField
      FieldName = 'Payee'
      Size = 255
    end
    object qry6ReconciliationLineID: TIntegerField
      FieldName = 'ReconciliationLineID'
    end
    object qry6category: TWideStringField
      FieldName = 'category'
      Size = 3
    end
    object qry6transId: TIntegerField
      FieldName = 'transId'
    end
  end
end
