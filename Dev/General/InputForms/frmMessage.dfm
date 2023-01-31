inherited fmMessage: TfmMessage
  Left = 576
  Top = 69
  HelpContext = 929001
  Caption = 'fmMessage'
  ClientHeight = 303
  ClientWidth = 557
  ExplicitLeft = 576
  ExplicitTop = 69
  ExplicitWidth = 573
  ExplicitHeight = 342
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 303
    Width = 557
    HelpContext = 929002
    ExplicitTop = 316
    ExplicitWidth = 553
  end
  inherited DnMPanel1: TDNMPanel
    Width = 557
    Height = 303
    HelpContext = 929003
    ExplicitWidth = 553
    ExplicitHeight = 329
    inherited lbltop: TLabel
      Width = 541
      HelpContext = 929014
    end
    inherited lblBottom: TLabel
      Top = 204
      Width = 541
      ExplicitTop = 204
      HelpContext = 929015
    end
    inherited pnlFooter: TDNMPanel
      Top = 229
      Width = 547
      HelpContext = 929004
      ExplicitTop = 255
      ExplicitWidth = 543
    end
    inherited pnlDetails: TDNMPanel
      Width = 547
      Height = 170
      HelpContext = 929007
      ExplicitWidth = 543
      ExplicitHeight = 152
      inherited Bevel1: TBevel
        Width = 545
        HelpContext = 929008
        ExplicitWidth = 505
      end
      object ScrollBox1: TScrollBox
        Left = 1
        Top = 2
        Width = 545
        Height = 167
        HelpContext = 929009
        HorzScrollBar.Visible = False
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 0
        DesignSize = (
          528
          167)
        object txtMsgText: TLabel
          AlignWithMargins = True
          Left = 0
          Top = 0
          Width = 509
          Height = 216
          HelpContext = 929010
          Anchors = [akLeft, akTop, akRight]
          Caption = 
            'test Caption test Caption test Caption test Caption test Caption' +
            ' test Caption test Caption test Caption test Caption test Captio' +
            'n test Caption test Caption test Caption test Caption test Capti' +
            'on test Caption test Caption test Caption test Caption test Capt' +
            'ion test Caption test Caption test Caption test Caption test Cap' +
            'tion test Caption test Caption test Caption test Caption test Ca' +
            'ption test Caption test Caption test Caption test Caption test C' +
            'aption test Caption test Caption test Caption test Caption test ' +
            'Caption test Caption test Caption test Caption test Caption test' +
            ' Caption test Caption test Caption test Caption test Caption tes' +
            't Caption test Caption test Caption test Caption test Caption te' +
            'st Caption test Caption test Caption test Caption test Caption t' +
            'est Caption test Caption '
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
      end
    end
    inherited chk: TCheckBox
      Top = 279
      Width = 547
      HelpContext = 929013
      ExplicitTop = 305
      ExplicitWidth = 543
    end
  end
  object TmrMsgFunc: TTimer
    OnTimer = TmrMsgFuncTimer
    Left = 88
    Top = 8
  end
end
