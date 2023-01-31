inherited FmProcessStepUnAssigned: TFmProcessStepUnAssigned
  Left = 363
  Top = 125
  Caption = 'Process Steps Un-Assigned'
  ClientHeight = 419
  ClientWidth = 494
  Position = poMainFormCenter
  ExplicitLeft = 363
  ExplicitTop = 125
  ExplicitWidth = 502
  ExplicitHeight = 446
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1395002
  inherited lblSkingroupMsg: TLabel
    Top = 369
    Width = 494
    ExplicitTop = 369
    ExplicitWidth = 494
    HelpContext = 1395003
  end
  inherited shapehint: TShape
    Left = -2
    ExplicitLeft = -2
  end
  inherited shapehintextra1: TShape
    Left = 20
    ExplicitLeft = 20
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 494
    Height = 61
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 949
    DesignSize = (
      494
      61)
    HelpContext = 1395004
    object pnlTitle: TDNMPanel
      Left = 23
      Top = 9
      Width = 448
      Height = 39
      HelpContext = 1395005
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
        Width = 446
        Height = 37
        HelpContext = 1395006
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
          Width = 446
          Height = 37
          HelpContext = 1395007
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Process Steps'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = -3
        end
      end
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 369
    Width = 494
    Height = 50
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      494
      50)
    HelpContext = 1395008
    object cmdClose: TDNMSpeedButton
      Left = 200
      Top = 11
      Width = 93
      Height = 29
      HelpContext = 1395009
      Anchors = [akBottom]
      Caption = 'OK'
      Default = True
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
      TabOrder = 0
      OnClick = cmdCloseClick
    end
  end
  object DNMPanel2: TDNMPanel [7]
    Left = 0
    Top = 61
    Width = 494
    Height = 308
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    HelpContext = 1395010
    object Label3: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 486
      Height = 19
      Align = alTop
      Alignment = taCenter
      Caption = 'List of Process Steps not Assigned to Employee / Resource'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitTop = 137
      ExplicitWidth = 451
      HelpContext = 1395011
    end
    object DNMPanel4: TDNMPanel
      Left = 1
      Top = 26
      Width = 248
      Height = 281
      Align = alLeft
      Anchors = []
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      ExplicitTop = 159
      ExplicitHeight = 148
      HelpContext = 1395012
      object Label1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 242
        Height = 19
        Align = alTop
        Alignment = taCenter
        Caption = 'Employee Not Assigned'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        ExplicitWidth = 182
        HelpContext = 1395013
      end
      object grdNoEmp: TwwDBGrid
        Left = 0
        Top = 25
        Width = 248
        Height = 256
        Hint = 'Double Click to Assign Employee(s)'
        Selected.Strings = (
          'Processstep'#9'30'#9'Processstep')
        MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
        IniAttributes.SaveToRegistry = True
        IniAttributes.Delimiter = ';;'
        IniAttributes.CheckNewFields = True
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
        Align = alClient
        Color = clWhite
        DataSource = dsNoEmp
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = True
        LineColors.GroupingColor = clSilver
        OnDblClick = grdNoEmpDblClick
        FooterColor = clWhite
        FooterCellColor = clWhite
        ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
        PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
        ExplicitHeight = 123
        HelpContext = 1395014
        object btnGrid: TwwIButton
          Left = 0
          Top = 0
          Width = 13
          Height = 22
          AllowAllUp = True
          HelpContext = 1395015
        end
      end
    end
    object DNMPanel5: TDNMPanel
      Left = 249
      Top = 26
      Width = 244
      Height = 281
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      ExplicitTop = 159
      ExplicitHeight = 148
      HelpContext = 1395016
      object Label2: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 238
        Height = 19
        Align = alTop
        Alignment = taCenter
        Caption = 'Resource Not Created'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        ExplicitWidth = 169
        HelpContext = 1395017
      end
      object grdNoRes: TwwDBGrid
        Left = 0
        Top = 25
        Width = 244
        Height = 256
        Hint = 'Double Click to Create a New Resouce'
        Selected.Strings = (
          'Processstep'#9'30'#9'Processstep')
        MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
        IniAttributes.SaveToRegistry = True
        IniAttributes.Delimiter = ';;'
        IniAttributes.CheckNewFields = True
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
        Align = alClient
        Color = clWhite
        DataSource = dsNoRes
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = True
        LineColors.GroupingColor = clSilver
        OnDblClick = grdNoResDblClick
        FooterColor = clWhite
        FooterCellColor = clWhite
        ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
        PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
        ExplicitHeight = 123
        HelpContext = 1395018
        object wwIButton1: TwwIButton
          Left = 0
          Top = 0
          Width = 13
          Height = 22
          AllowAllUp = True
          HelpContext = 1395019
        end
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 417
    Top = 234
  end
  inherited tmrdelay: TTimer
    Left = 449
    Top = 234
  end
  inherited popSpelling: TPopupMenu
    Left = 137
    Top = 234
  end
  inherited tmrdelayMsg: TTimer
    Left = 386
    Top = 234
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 231
    Top = 234
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 262
    Top = 234
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Top = 161
  end
  inherited DataState: TDataState
    Left = 293
    Top = 234
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 168
    Top = 234
  end
  inherited imgsort: TImageList
    Left = 324
    Top = 234
    Bitmap = {
      494C010102005801580110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 106
    Top = 234
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 355
    Top = 234
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 199
    Top = 234
  end
  inherited qryMemTrans: TERPQuery
    Left = 75
    Top = 234
  end
  object qryNoEmp: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select  Ps.ID as ProcessStepId,Ps.Description as Processstep '
      'from  tblprocessstep Ps '
      'left join tblemployeeprocesssteps EP on Ps.ID = EP.ProcessStepID'
      'where ifnull(EP.EmpProcessStepsID,0)=0'
      'order by Processstep')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Active = True
    Left = 11
    Top = 234
    object qryNoEmpProcessstep: TWideStringField
      DisplayWidth = 30
      FieldName = 'Processstep'
      Origin = 'Ps.Description'
      Size = 255
    end
    object qryNoEmpProcessStepId: TIntegerField
      FieldName = 'ProcessStepId'
      Origin = 'Ps.ID'
      Visible = False
    end
  end
  object dsNoEmp: TDataSource
    DataSet = qryNoEmp
    Left = 11
    Top = 201
  end
  object dsNoRes: TDataSource
    DataSet = qryNoRes
    Left = 42
    Top = 201
  end
  object qryNoRes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select  Ps.ID as ProcessStepId,Ps.Description as Processstep '
      'from  tblprocessstep Ps '
      
        'Left join tblprocresourceprocess PR  on Ps.ID = PR.ProcessStepId' +
        '  '
      'where ifnull(PR.ProcResourceProcessId,0)=0'
      'order by Processstep')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Active = True
    Left = 42
    Top = 234
    object qryNoResProcessstep: TWideStringField
      DisplayWidth = 30
      FieldName = 'Processstep'
      Origin = 'Ps.Description'
      Size = 255
    end
    object qryNoResProcessStepId: TIntegerField
      FieldName = 'ProcessStepId'
      Origin = 'Ps.ID'
      Visible = False
    end
  end
end
