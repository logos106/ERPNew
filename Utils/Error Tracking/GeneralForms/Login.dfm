inherited LoginGUI: TLoginGUI
  Left = 433
  Top = 183
  BorderStyle = bsDialog
  Caption = 'Login'
  ClientHeight = 248
  ClientWidth = 296
  ParentFont = True
  Position = poScreenCenter
  DesignSize = (
    296
    248)
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 56
    Top = 130
    Width = 61
    Height = 16
    Caption = 'Password'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel [1]
    Left = 56
    Top = 72
    Width = 32
    Height = 16
    Caption = 'User:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Password: TEdit [2]
    Left = 56
    Top = 147
    Width = 197
    Height = 24
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 1
  end
  object User: TwwDBLookupCombo [3]
    Left = 56
    Top = 88
    Width = 197
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    LookupTable = qryMaster
    LookupField = 'LoginName'
    Style = csDropDownList
    DropDownWidth = 200
    ParentFont = False
    TabOrder = 0
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = False
  end
  inherited pnlHeader: TPanel
    Left = 54
    Top = 11
    Width = 195
    Height = 45
    TabOrder = 2
    inherited TitleShader: TShader
      Width = 193
      Height = 43
      inherited TitleLabel: TLabel
        Width = 193
        Height = 43
        Caption = 'Login'
      end
    end
  end
  inherited Cancel: TDNMSpeedButton
    Left = 175
    Top = 198
    TabOrder = 3
  end
  inherited Print: TDNMSpeedButton
    Left = 159
    Top = 243
    TabOrder = 4
  end
  inherited Save: TDNMSpeedButton
    Left = 40
    Top = 198
    Caption = 'OK'
    TabOrder = 5
  end
  inherited New: TDNMSpeedButton
    Left = 60
    Top = 243
    TabOrder = 6
  end
  inherited DBConnection: TMyConnection
    Port = 3309
  end
  inherited qryMaster: TMyQuery
    SQL.Strings = (
      'SELECT users.userid, users.loginname'
      'FROM users'
      'WHERE (length(loginname)>0);')
  end
end
