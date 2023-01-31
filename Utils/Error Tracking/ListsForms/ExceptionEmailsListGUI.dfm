inherited ExceptionEmailsList: TExceptionEmailsList
  Left = 86
  Top = 100
  Caption = 'Exception Emails List'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TDNMPanel
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'Done;CheckBox;True;False')
      MultiSelectOptions = [msoShiftSelect]
    end
    inherited pnlfilter: TDNMPanel
      inherited DNMPanel1: TDNMPanel
        inherited rgOptions: TwwRadioGroup
          ItemIndex = 0
          Items.Strings = (
            'Incomplete'
            'All')
        end
      end
    end
  end
  inherited HeaderPanel: TDNMPanel
    inherited pnlHeader: TPanel
      Caption = 'Exception Emails List'
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'Exception Emails List'
        end
      end
    end
  end
  inherited FooterPanel: TDNMPanel
    inherited btnCustomize: TDNMSpeedButton
      Left = 146
      TabOrder = 5
    end
    inherited cmdClose: TDNMSpeedButton
      Left = 753
    end
    inherited cmdNew: TDNMSpeedButton
      Left = 388
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 631
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 267
    end
    object BitBtn1: TDNMSpeedButton
      Left = 510
      Top = 13
      Width = 93
      Height = 29
      Anchors = [akBottom]
      Caption = 'Download'
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
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      TabStop = False
      OnClick = BitBtn1Click
    end
  end
  inherited mnuFilter: TPopupMenu
    object N3: TMenuItem
      Caption = '-'
    end
    object Done1: TMenuItem
      Action = actFlagDone
    end
  end
  inherited actlstFilters: TActionList
    object actFlagDone: TAction
      Caption = 'Done'
      ImageIndex = 7
      OnExecute = actFlagDoneExecute
      OnUpdate = actFlagDoneUpdate
    end
  end
  inherited qryListData: TMyQuery
    SQL.Strings = (
      'select * from exceptionbugs'
      'where exceptionbugs.done like :xdone;')
    Left = 71
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xdone'
      end>
  end
  inherited qryCustomFilter: TMyQuery
    SQL.Strings = (
      'select'
      '0 as customfilterid,'
      'concat('#39'none'#39',space(200)) as filtername,'
      'space(9000) as filter'
      ''
      'union'
      ''
      'select'
      'customfilterid,'
      'filtername,'
      'filter'
      'from customfilters'
      'where userid = :xuserid'
      'and classname = :xclassname;')
  end
end
