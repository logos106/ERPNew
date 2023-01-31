inherited fmTrainingStatusDetails: TfmTrainingStatusDetails
  Left = 191
  Top = 214
  HelpContext = 767000
  Caption = 'Training Status Details'
  ExplicitLeft = 191
  ExplicitTop = 214
  PixelsPerInch = 96
  TextHeight = 15
  inherited pnlForm: TDNMPanel
    HelpContext = 767013
    inherited pnlTop: TDNMPanel
      HelpContext = 767014
      object pnlTitle: TDNMPanel
        Left = 231
        Top = 9
        Width = 489
        Height = 39
        HelpContext = 767010
        Caption = 'Invoice'
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
          Width = 487
          Height = 37
          HelpContext = 767011
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
            Width = 487
            Height = 37
            HelpContext = 767012
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'Training Status'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -29
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
        end
      end
    end
    inherited pnlbottom: TDNMPanel
      DesignSize = (
        947
        63)
      HelpContext = 767015
      object btnCompleted: TDNMSpeedButton
        Left = 224
        Top = 17
        Width = 87
        Height = 27
        HelpContext = 767005
        Anchors = [akTop]
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
        AutoDisableParentOnclick = True
        OnClick = btnCompletedClick
      end
      object btnvideo: TDNMSpeedButton
        Left = 328
        Top = 17
        Width = 87
        Height = 27
        HelpContext = 767006
        Anchors = [akTop]
        Caption = 'Show Video'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = btnvideoClick
      end
      object btnClose: TDNMSpeedButton
        Left = 643
        Top = 17
        Width = 87
        Height = 27
        HelpContext = 767007
        Anchors = [akTop]
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
        AutoDisableParentOnclick = True
        OnClick = btnCloseClick
      end
      object DNMSpeedButton1: TDNMSpeedButton
        Left = 433
        Top = 17
        Width = 87
        Height = 27
        HelpContext = 767008
        Anchors = [akTop]
        Caption = '&Print'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 3
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton1Click
      end
      object btnHelp: TDNMSpeedButton
        Left = 538
        Top = 17
        Width = 87
        Height = 27
        HelpContext = 767009
        Anchors = [akTop]
        Caption = 'Help'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentFont = False
        TabOrder = 4
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = btnHelpClick
      end
    end
    inherited pnlmain: TDNMPanel
      HelpContext = 767016
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 945
        Height = 132
        HelpContext = 767001
        Align = alTop
        Caption = 
          'This form can only be called from  TfmTrainingStatus and uses co' +
          'nnection and dataset from the same.  Query components here are o' +
          'nly for design purpose'
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -37
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Visible = False
        WordWrap = True
        ExplicitWidth = 939
      end
      object hcGrid: THeaderControl
        Left = 1
        Top = 133
        Width = 945
        Height = 21
        HelpContext = 767003
        Sections = <
          item
            ImageIndex = -1
            Text = 'Task Title'
            Width = 210
          end
          item
            ImageIndex = -1
            Text = 'Task Description'
            Width = 650
          end
          item
            ImageIndex = -1
            MinWidth = 20
            Text = 'Done'
            Width = 50
          end>
        OnSectionResize = hcGridSectionResize
      end
      object sbGrid: TScrollBox
        Left = 1
        Top = 154
        Width = 945
        Height = 249
        HelpContext = 767004
        VertScrollBar.Tracking = True
        Align = alClient
        TabOrder = 2
      end
      object grdMain: TwwDBGrid
        Left = 538
        Top = 208
        Width = 398
        Height = 165
        HelpContext = 767002
        ControlType.Strings = (
          'Done;CheckBox;T;F')
        Selected.Strings = (
          'Tasktitle'#9'24'#9'Task Title'#9'T'#9
          'TaskDescription'#9'90'#9'Task Description'#9'T'#9
          'Done'#9'4'#9'Done'#9#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableCustomControls, ecoDisableDateTimePicker, ecoDisableEditorIfReadOnly]
        DataSource = dsTrainingEmployeeModuleStatusDetails
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
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
        Visible = False
        FooterColor = clWhite
      end
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 80
  end
  inherited MyConnection: TERPConnection
    Left = 112
    Top = 15
  end
  inherited imgsort: TImageList
    Top = 20
    Bitmap = {
      494C010102002000300010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryTrainingEmployeeModuleStatusDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblTrainingEmployeeModuleStatusDetails'
      'order by Seqno')
    MasterFields = 'trainingemployeemoduleStatusID'
    DetailFields = 'trainingemployeemoduleStatusID'
    Left = 392
    Top = 240
    ParamData = <
      item
        DataType = ftInteger
        Name = 'trainingemployeemoduleStatusID'
        ParamType = ptInput
        Value = 6
      end>
    object qryTrainingEmployeeModuleStatusDetailsTasktitle: TWideStringField
      DisplayLabel = 'Task Title'
      DisplayWidth = 24
      FieldKind = fkLookup
      FieldName = 'Tasktitle'
      LookupDataSet = qrytrainingmoduletask
      LookupKeyFields = 'TrainingModuleTaskID'
      LookupResultField = 'TrainingModuleTaskTitle'
      KeyFields = 'TaskID'
      Size = 100
      Lookup = True
    end
    object qryTrainingEmployeeModuleStatusDetailsTaskDescription: TWideStringField
      DisplayLabel = 'Task Description'
      DisplayWidth = 90
      FieldKind = fkLookup
      FieldName = 'TaskDescription'
      LookupDataSet = qrytrainingmoduletask
      LookupKeyFields = 'TrainingModuleTaskID'
      LookupResultField = 'TrainingModuleTaskDescription'
      KeyFields = 'TaskID'
      Size = 255
      Lookup = True
    end
    object qryTrainingEmployeeModuleStatusDetailsDone: TWideStringField
      DisplayWidth = 4
      FieldName = 'Done'
      Origin = 'tblTrainingEmployeeModuleStatusDetails.Done'
      FixedChar = True
      Size = 1
    end
    object qryTrainingEmployeeModuleStatusDetailsDoneon: TDateTimeField
      DisplayLabel = 'Done On'
      DisplayWidth = 10
      FieldName = 'Doneon'
      Origin = 'tblTrainingEmployeeModuleStatusDetails.Doneon'
      Visible = False
    end
    object qryTrainingEmployeeModuleStatusDetailsTaskID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TaskID'
      Origin = 'tblTrainingEmployeeModuleStatusDetails.TaskID'
      Visible = False
    end
    object qryTrainingEmployeeModuleStatusDetailsGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblTrainingEmployeeModuleStatusDetails.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryTrainingEmployeeModuleStatusDetailsTrainingEmployeeModuleStatusDetailsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'TrainingEmployeeModuleStatusDetailsID'
      Origin = 
        'tblTrainingEmployeeModuleStatusDetails.TrainingEmployeeModuleSta' +
        'tusDetailsID'
      Visible = False
    end
    object qryTrainingEmployeeModuleStatusDetailstrainingemployeemoduleStatusID: TIntegerField
      DisplayWidth = 10
      FieldName = 'trainingemployeemoduleStatusID'
      Origin = 
        'tblTrainingEmployeeModuleStatusDetails.trainingemployeemoduleSta' +
        'tusID'
      Visible = False
    end
    object qryTrainingEmployeeModuleStatusDetailsmstimestamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'mstimestamp'
      Origin = 'tblTrainingEmployeeModuleStatusDetails.mstimestamp'
      Visible = False
    end
    object qryTrainingEmployeeModuleStatusDetailsSeqNo: TLargeintField
      DisplayWidth = 15
      FieldName = 'SeqNo'
      Origin = 'tblTrainingEmployeeModuleStatusDetails.SeqNo'
      Visible = False
    end
  end
  object dsTrainingEmployeeModuleStatusDetails: TDataSource
    DataSet = qryTrainingEmployeeModuleStatusDetails
    Left = 480
    Top = 296
  end
  object qrytrainingmoduletask: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tbltrainingmoduletask')
    Left = 520
    Top = 264
    object qrytrainingmoduletaskTrainingModuleTaskID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'TrainingModuleTaskID'
      Origin = 'tbltrainingmoduletask.TrainingModuleTaskID'
    end
    object qrytrainingmoduletaskSeqno: TIntegerField
      FieldName = 'Seqno'
      Origin = 'tbltrainingmoduletask.Seqno'
    end
    object qrytrainingmoduletaskTrainingModuleTaskTitle: TWideStringField
      FieldName = 'TrainingModuleTaskTitle'
      Origin = 'tbltrainingmoduletask.TrainingModuleTaskTitle'
      Size = 100
    end
    object qrytrainingmoduletaskTrainingModuleTaskDescription: TWideMemoField
      FieldName = 'TrainingModuleTaskDescription'
      Origin = 'tbltrainingmoduletask.TrainingModuleTaskDescription'
      BlobType = ftWideMemo
    end
  end
end
