inherited RollaBlindViewCutoutGUI: TRollaBlindViewCutoutGUI
  Left = 211
  Top = 185
  Caption = 'View Cut-out'
  ClientHeight = 574
  ClientWidth = 841
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object DNMPanel1: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 841
    Height = 574
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      841
      574)
    object Bevel1: TBevel
      Left = 16
      Top = 72
      Width = 809
      Height = 441
      Shape = bsFrame
    end
    object Bevel2: TBevel
      Left = 16
      Top = 120
      Width = 807
      Height = 9
      Shape = bsTopLine
    end
    object Label1: TLabel
      Left = 36
      Top = 136
      Width = 40
      Height = 15
      Caption = 'Cutting'
      Transparent = True
    end
    object Label3: TLabel
      Left = 128
      Top = 80
      Width = 76
      Height = 15
      Caption = 'Lead Number'
      Transparent = True
    end
    object txtLeadNumber: TDBText
      Left = 128
      Top = 96
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
    object Label5: TLabel
      Left = 232
      Top = 80
      Width = 33
      Height = 15
      Caption = 'Name'
      Transparent = True
    end
    object txtName: TDBText
      Left = 232
      Top = 96
      Width = 145
      Height = 17
      DataField = 'Name'
      DataSource = dsHeading
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object txtProfileType: TDBText
      Left = 32
      Top = 88
      Width = 89
      Height = 17
      DataField = 'ProfileType'
      DataSource = dsHeading
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 384
      Top = 80
      Width = 36
      Height = 15
      Caption = 'Height'
      Transparent = True
    end
    object txtHeight: TDBText
      Left = 384
      Top = 96
      Width = 57
      Height = 17
      DataField = 'OpeningHeight'
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
      Left = 448
      Top = 80
      Width = 33
      Height = 15
      Caption = 'Width'
      Transparent = True
    end
    object txtWidth: TDBText
      Left = 448
      Top = 96
      Width = 57
      Height = 17
      DataField = 'OpeningWidth'
      DataSource = dsHeading
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 512
      Top = 80
      Width = 27
      Height = 15
      Caption = 'Drop'
      Transparent = True
    end
    object txtMod1Height: TDBText
      Left = 512
      Top = 96
      Width = 57
      Height = 17
      DataField = 'Mod1Height'
      DataSource = dsHeading
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 576
      Top = 80
      Width = 26
      Height = 15
      Caption = 'DMG'
      Transparent = True
    end
    object txtMod1Width: TDBText
      Left = 576
      Top = 96
      Width = 57
      Height = 17
      DataField = 'Mod1Width'
      DataSource = dsHeading
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label8: TLabel
      Left = 656
      Top = 80
      Width = 37
      Height = 15
      Caption = 'Profile'
      Transparent = True
    end
    object txtInstallType: TDBText
      Left = 656
      Top = 96
      Width = 65
      Height = 17
      DataField = 'InstallType'
      DataSource = dsHeading
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label9: TLabel
      Left = 736
      Top = 80
      Width = 34
      Height = 15
      Caption = 'Install'
      Transparent = True
    end
    object txtSubInstallType: TDBText
      Left = 736
      Top = 96
      Width = 73
      Height = 17
      DataField = 'SubInstallType'
      DataSource = dsHeading
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label10: TLabel
      Left = 476
      Top = 136
      Width = 72
      Height = 15
      Caption = 'Components'
      Transparent = True
    end
    object Label11: TLabel
      Left = 476
      Top = 368
      Width = 44
      Height = 15
      Caption = 'Colours'
      Transparent = True
    end
    object pnlTitle: TDNMPanel
      Left = 278
      Top = 16
      Width = 273
      Height = 41
      Anchors = [akTop]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object btnSave: TDNMSpeedButton
      Left = 286
      Top = 530
      Width = 87
      Height = 27
      Anchors = []
      Caption = '&Save'
      Default = True
      DisableTransparent = False
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
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btnCancelClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 495
      Top = 530
      Width = 87
      Height = 27
      Anchors = []
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
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
      Kind = bkCancel
      ModalResult = 2
      NumGlyphs = 2
      TabOrder = 4
      OnClick = btnCancelClick
    end
    object grdCutting: TwwDBGrid
      Left = 32
      Top = 152
      Width = 425
      Height = 345
      ControlType.Strings = (
        'Flag;CheckBox;T;F')
      Selected.Strings = (
        'ItemNumber'#9'7'#9'Item No'
        'Des'#9'28'#9'Description'
        'Qty'#9'5'#9'Qty'
        'Length'#9'7'#9'Length'
        'Colour'#9'5'#9'Colour'
        'Flag'#9'1'#9' ')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = dsCutting
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ParentFont = False
      TabOrder = 5
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
    end
    object grdComponents: TwwDBGrid
      Left = 472
      Top = 152
      Width = 337
      Height = 209
      ControlType.Strings = (
        'Flag;CheckBox;T;F')
      Selected.Strings = (
        'ItemNumber'#9'7'#9'Item No'
        'Des'#9'23'#9'Description'
        'Qty'#9'5'#9'Qty'
        'Colour'#9'5'#9'Colour'
        'Flag'#9'1'#9' ')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = dsComponents
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
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
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
    end
    object grdColours: TwwDBGrid
      Left = 472
      Top = 384
      Width = 337
      Height = 113
      Selected.Strings = (
        'ItemNumber'#9'7'#9'Item No'
        'Description'#9'25'#9'Description'
        'Qty'#9'5'#9'Qty'
        'Colour'#9'5'#9'Colour')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = dsColours
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ParentFont = False
      TabOrder = 2
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
    end
    object btnPrint: TDNMSpeedButton
      Left = 392
      Top = 530
      Width = 84
      Height = 27
      Caption = '&Print'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 6
      OnClick = btnPrintClick
    end
  end
  object qryHeading: TMyQuery
    SQL.Strings = (
      'SELECT rs.ProfileType, c.ClientID AS LeadNumber, '
      'CONCAT_WS(" ", c.Title, c.FirstName, c.LastName) AS Name,'
      'rs.OpeningHeight, rs.OpeningWidth, rs.Mod1Height,'
      'rs.Mod1Width, rs.InstallType, rs.SubInstallType'
      'FROM tblclients c'
      'INNER JOIN tblrollasheet1 rs ON c.ClientID=rs.LeadNumber'
      'WHERE c.ClientID=:ClientID AND rs.SheetID=:SheetID;')
    Left = 168
    Top = 8
    ParamData = <
      item
        DataType = ftString
        Name = 'ClientID'
        Value = ''
      end
      item
        DataType = ftUnknown
        Name = 'SheetID'
      end>
    object qryHeadingProfileType: TStringField
      DisplayWidth = 50
      FieldName = 'ProfileType'
      Size = 50
    end
    object qryHeadingLeadNumber: TIntegerField
      DisplayWidth = 10
      FieldName = 'LeadNumber'
    end
    object qryHeadingName: TStringField
      DisplayWidth = 114
      FieldName = 'Name'
      Size = 114
    end
    object qryHeadingOpeningHeight: TFloatField
      DisplayWidth = 10
      FieldName = 'OpeningHeight'
    end
    object qryHeadingOpeningWidth: TFloatField
      DisplayWidth = 10
      FieldName = 'OpeningWidth'
    end
    object qryHeadingMod1Height: TFloatField
      DisplayWidth = 10
      FieldName = 'Mod1Height'
    end
    object qryHeadingMod1Width: TFloatField
      DisplayWidth = 10
      FieldName = 'Mod1Width'
    end
    object qryHeadingInstallType: TStringField
      DisplayWidth = 50
      FieldName = 'InstallType'
      Size = 50
    end
    object qryHeadingSubInstallType: TStringField
      DisplayWidth = 50
      FieldName = 'SubInstallType'
      Size = 50
    end
  end
  object dsHeading: TDataSource
    DataSet = qryHeading
    Left = 200
    Top = 8
  end
  object qryCutting: TMyQuery
    SQL.Strings = (
      'SELECT ItemNumber, Des, Qty, Length, Colour, Flag'
      'FROM tblrollasheet2'
      
        'WHERE (SheetID = :SheetID) AND (CutOrComp = '#39'Cutting'#39') AND (Item' +
        'Number <> '#39#39')'
      'ORDER BY Sheet2ID_Asc, Des')
    Left = 40
    Top = 40
    ParamData = <
      item
        DataType = ftString
        Name = 'SheetID'
        Value = ''
      end>
    object qryCuttingItemNumber: TStringField
      DisplayLabel = 'Item No'
      DisplayWidth = 7
      FieldName = 'ItemNumber'
      Origin = 'tblrollaaddsheet2.ItemNumber'
      Size = 50
    end
    object qryCuttingDes: TStringField
      DisplayLabel = 'Description'
      DisplayWidth = 28
      FieldName = 'Des'
      Origin = 'tblrollaaddsheet2.Des'
      Size = 50
    end
    object qryCuttingQty: TFloatField
      DisplayWidth = 5
      FieldName = 'Qty'
      Origin = 'tblrollaaddsheet2.Qty'
    end
    object qryCuttingLength: TFloatField
      FieldName = 'Length'
    end
    object qryCuttingColour: TStringField
      DisplayWidth = 5
      FieldName = 'Colour'
      Origin = 'tblrollaaddsheet2.Colour'
      Size = 50
    end
    object qryCuttingFlag: TStringField
      DisplayLabel = ' '
      DisplayWidth = 1
      FieldName = 'Flag'
      Origin = 'tblrollaaddsheet2.Flag'
      FixedChar = True
      Size = 1
    end
  end
  object dsCutting: TDataSource
    DataSet = qryCutting
    Left = 72
    Top = 40
  end
  object qryComponents: TMyQuery
    SQL.Strings = (
      'SELECT ItemNumber, Des, Qty, Colour, Flag'
      'FROM tblrollasheet2'
      
        'WHERE (SheetID = :SheetID) AND (CutOrComp = '#39'Components'#39') AND (I' +
        'temNumber <> '#39#39')'
      'ORDER BY Sheet2ID')
    Left = 104
    Top = 40
    ParamData = <
      item
        DataType = ftString
        Name = 'SheetID'
        Value = ''
      end>
    object qryComponentsItemNumber: TStringField
      DisplayLabel = 'Item No'
      DisplayWidth = 7
      FieldName = 'ItemNumber'
      Origin = 'tblrollaaddsheet2.ItemNumber'
      Size = 50
    end
    object qryComponentsDes: TStringField
      DisplayLabel = 'Description'
      DisplayWidth = 23
      FieldName = 'Des'
      Origin = 'tblrollaaddsheet2.Des'
      Size = 50
    end
    object qryComponentsQty: TFloatField
      DisplayWidth = 5
      FieldName = 'Qty'
      Origin = 'tblrollaaddsheet2.Qty'
    end
    object qryComponentsColour: TStringField
      DisplayWidth = 5
      FieldName = 'Colour'
      Origin = 'tblrollaaddsheet2.Colour'
      Size = 50
    end
    object qryComponentsFlag: TStringField
      DisplayLabel = ' '
      DisplayWidth = 1
      FieldName = 'Flag'
      Origin = 'tblrollaaddsheet2.Flag'
      FixedChar = True
      Size = 1
    end
  end
  object dsComponents: TDataSource
    DataSet = qryComponents
    Left = 136
    Top = 40
  end
  object qryColours: TMyQuery
    SQL.Strings = (
      
        'SELECT racg2.ItemNumber, racg2.Description, racg2.Qty, racg2.Col' +
        'our'
      'FROM tblrollaaddcolgrid2 racg2'
      'INNER JOIN tblrollaaddcolgrid1 racg1 USING(SheetID)'
      'WHERE (racg2.SheetID = :SheetID) AND (racg2.ItemNumber <> '#39#39')'
      'ORDER BY racg1.ColourGridID DESC, racg2.BuildID DESC;')
    Left = 168
    Top = 40
    ParamData = <
      item
        DataType = ftString
        Name = 'SheetID'
        Value = ''
      end>
    object qryColoursItemNumber: TStringField
      DisplayLabel = 'Item No'
      DisplayWidth = 7
      FieldName = 'ItemNumber'
      Origin = 'tblrollaaddcolgrid2.ItemNumber'
      Size = 50
    end
    object qryColoursDescription: TStringField
      DisplayWidth = 25
      FieldName = 'Description'
      Origin = 'tblrollaaddcolgrid2.Description'
      Size = 50
    end
    object qryColoursQty: TFloatField
      DisplayWidth = 5
      FieldName = 'Qty'
      Origin = 'tblrollaaddcolgrid2.Qty'
    end
    object qryColoursColour: TStringField
      DisplayWidth = 5
      FieldName = 'Colour'
      Origin = 'tblrollaaddcolgrid2.Colour'
      Size = 50
    end
  end
  object dsColours: TDataSource
    DataSet = qryColours
    Left = 200
    Top = 40
  end
end
