object fmEDITrigger: TfmEDITrigger
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'EDI Trigger Edit'
  ClientHeight = 424
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    475
    424)
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 24
    Top = 20
    Width = 55
    Height = 15
    Caption = 'Data Type'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnSave: TDNMSpeedButton
    Left = 131
    Top = 389
    Width = 87
    Height = 27
    HelpContext = 1063005
    Anchors = [akBottom]
    Caption = 'Save'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 0
    OnClick = btnSaveClick
    ExplicitTop = 299
  end
  object btnCancel: TDNMSpeedButton
    Left = 257
    Top = 389
    Width = 87
    Height = 27
    HelpContext = 1063006
    Anchors = [akBottom]
    Caption = 'Cancel'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
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
    OnClick = btnCancelClick
    ExplicitTop = 299
  end
  object cboType: TComboBox
    Left = 96
    Top = 17
    Width = 129
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 2
    Text = 'Unknown'
    OnChange = cboTypeChange
    Items.Strings = (
      'Unknown'
      'File')
  end
  object pagesType: TPageControl
    Left = 8
    Top = 56
    Width = 459
    Height = 321
    ActivePage = tabFile
    TabOrder = 3
    object tabFile: TTabSheet
      Caption = 'File'
      ExplicitHeight = 203
      object pnlFile: TDNMPanel
        Left = 0
        Top = 0
        Width = 451
        Height = 291
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        Transparent = False
        ExplicitHeight = 203
        object Label3: TLabel
          Left = 16
          Top = 21
          Width = 60
          Height = 15
          Caption = 'Map Name'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 16
          Top = 50
          Width = 53
          Height = 15
          Caption = 'File Mask'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 16
          Top = 79
          Width = 63
          Height = 15
          Caption = 'File Source'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 16
          Top = 106
          Width = 109
          Height = 15
          Caption = 'Move Processed to'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 16
          Top = 166
          Width = 70
          Height = 15
          Caption = 'Check Every'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 182
          Top = 167
          Width = 20
          Height = 15
          Caption = 'Hrs'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 278
          Top = 167
          Width = 27
          Height = 15
          Caption = 'Mins'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
          Left = 16
          Top = 135
          Width = 80
          Height = 15
          Caption = 'Move Failed to'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label11: TLabel
          Left = 16
          Top = 259
          Width = 82
          Height = 15
          Caption = 'Email Address'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtMapName: TEdit
          Left = 131
          Top = 16
          Width = 179
          Height = 23
          TabOrder = 0
          Text = 'edtMapName'
        end
        object edtFileMask: TEdit
          Left = 131
          Top = 45
          Width = 87
          Height = 23
          TabOrder = 1
          Text = 'edtFileMask'
        end
        object edtFilePath: TEdit
          Left = 131
          Top = 74
          Width = 272
          Height = 23
          TabOrder = 2
          Text = 'edtFilePath'
        end
        object edtProcessedPath: TEdit
          Left = 131
          Top = 103
          Width = 272
          Height = 23
          TabOrder = 3
          Text = 'edtProcessedPath'
        end
        object edtIntervalHours: TAdvEdit
          Left = 131
          Top = 163
          Width = 45
          Height = 23
          EditType = etNumeric
          EmptyText = '00'
          LengthLimit = 2
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          Lookup.Separator = ';'
          Color = clWindow
          Enabled = True
          MaxLength = 2
          TabOrder = 4
          Text = '0'
          Visible = True
          OnChange = edtIntervalHoursChange
          Version = '2.8.6.9'
        end
        object edtIntervalMins: TAdvEdit
          Left = 227
          Top = 163
          Width = 45
          Height = 23
          EditType = etNumeric
          EmptyText = '00'
          LengthLimit = 2
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          Lookup.Separator = ';'
          Color = clWindow
          Enabled = True
          MaxLength = 2
          TabOrder = 5
          Text = '0'
          Visible = True
          Version = '2.8.6.9'
        end
        object btnFilePath: TButton
          Left = 401
          Top = 74
          Width = 30
          Height = 23
          Caption = '...'
          TabOrder = 6
          OnClick = btnFilePathClick
        end
        object btnProcessedPath: TButton
          Left = 401
          Top = 103
          Width = 30
          Height = 23
          Caption = '...'
          TabOrder = 7
          OnClick = btnProcessedPathClick
        end
        object edtFailPath: TEdit
          Left = 131
          Top = 132
          Width = 272
          Height = 23
          TabOrder = 8
          Text = 'edtFailPath'
        end
        object btnFailPath: TButton
          Left = 401
          Top = 132
          Width = 30
          Height = 23
          Caption = '...'
          TabOrder = 9
          OnClick = btnFailPathClick
        end
        object chkEmailOnError: TCheckBox
          Left = 16
          Top = 200
          Width = 137
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Email On Error'
          TabOrder = 10
        end
        object chkEmailOnSuccess: TCheckBox
          Left = 16
          Top = 225
          Width = 137
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Email On Success'
          TabOrder = 11
        end
        object edtEmail: TEdit
          Left = 131
          Top = 256
          Width = 214
          Height = 23
          TabOrder = 12
          Text = 'edtEmail'
        end
        object btnTest: TButton
          Left = 356
          Top = 256
          Width = 75
          Height = 25
          Caption = 'Test'
          TabOrder = 13
          OnClick = btnTestClick
        end
      end
    end
    object tabUnknown: TTabSheet
      Caption = 'Unknown'
      ImageIndex = 1
      ExplicitHeight = 203
      object pnlUnknown: TDNMPanel
        Left = 0
        Top = 0
        Width = 451
        Height = 291
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        Transparent = False
        ExplicitHeight = 203
        object Label5: TLabel
          Left = 24
          Top = 20
          Width = 82
          Height = 15
          Caption = 'Unknown Type'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
  end
  object OpenDialog: TOpenDialog
    Left = 336
    Top = 40
  end
end
