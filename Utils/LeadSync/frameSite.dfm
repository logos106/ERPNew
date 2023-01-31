object frSite: TfrSite
  Left = 0
  Top = 0
  Width = 479
  Height = 50
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  ParentBackground = False
  ParentColor = False
  ParentFont = False
  TabOrder = 0
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 479
    Height = 50
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvLowered
    TabOrder = 0
    ExplicitHeight = 58
    DesignSize = (
      479
      50)
    object lblName: TLabel
      Left = 6
      Top = 6
      Width = 402
      Height = 15
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Site Name'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblStatus: TLabel
      Left = 24
      Top = 27
      Width = 441
      Height = 15
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Status'
    end
    object chkActive: TCheckBox
      Left = 414
      Top = 6
      Width = 51
      Height = 17
      Caption = 'Active'
      TabOrder = 0
    end
  end
end
