inherited fmPOSExtraDetails: TfmPOSExtraDetails
  Left = 154
  Top = 236
  HelpContext = 693000
  Caption = 'POS : Customer Details'
  ClientHeight = 248
  ClientWidth = 398
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  ExplicitLeft = 154
  ExplicitTop = 236
  ExplicitWidth = 406
  ExplicitHeight = 275
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 248
    Width = 398
    HelpContext = 693011
  end
  object DNMPanel1: TDNMPanel [3]
    Left = 0
    Top = 0
    Width = 398
    Height = 248
    HelpContext = 693001
    Align = alClient
    Color = 15722703
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitHeight = 241
    object Label1: TLabel
      Left = 16
      Top = 56
      Width = 96
      Height = 22
      HelpContext = 693002
      Caption = 'Post Code'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 16
      Top = 95
      Width = 67
      Height = 22
      HelpContext = 693003
      Caption = 'Source'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 1
      Top = 1
      Width = 396
      Height = 32
      HelpContext = 693004
      Align = alTop
      Alignment = taCenter
      Caption = 'Please Provide Customer'#39's '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      ExplicitWidth = 362
    end
    object Label4: TLabel
      Left = 16
      Top = 135
      Width = 114
      Height = 22
      HelpContext = 693005
      Caption = 'P.O. Number'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object edtPostCode: TEdit
      Left = 147
      Top = 52
      Width = 121
      Height = 30
      HelpContext = 693006
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnExit = edtPostCodeExit
    end
    object btnOk: TDNMSpeedButton
      Left = 66
      Top = 183
      Width = 94
      Height = 49
      HelpContext = 693008
      Caption = 'Ok'
      Color = 14810111
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 2
      WordWrap = True
      OnClick = btnOkClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 210
      Top = 183
      Width = 94
      Height = 49
      HelpContext = 693009
      Caption = 'Cancel'
      Color = 14810111
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 3
      WordWrap = True
      OnClick = btnCancelClick
    end
    object cboMediaType: TwwDBLookupCombo
      Left = 147
      Top = 91
      Width = 245
      Height = 30
      HelpContext = 693010
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'MediaType'#9'40'#9'MediaType'#9'F')
      LookupTable = qryMediaType
      LookupField = 'MedTypeID'
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnExit = cboMediaTypeExit
    end
    object edtPONumber: TEdit
      Left = 147
      Top = 131
      Width = 246
      Height = 30
      HelpContext = 693007
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnExit = edtPONumberExit
    end
  end
  object qryMediaType: TERPQuery
    SQL.Strings = (
      
        'SELECT  tblSource.MedTypeID, tblSource.MediaType, tblSource.Acti' +
        've '
      'FROM tblSource '
      
        'WHERE (((tblSource.MediaType)>" ") And ((tblSource.Active)<>'#39'F'#39')' +
        ') '
      'ORDER BY tblSource.MediaType; ')
    Options.LongStrings = False
    Left = 353
    Top = 58
  end
end
