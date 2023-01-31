inherited RewardPointsDueToExpireGUI: TRewardPointsDueToExpireGUI
  Left = 1451
  Top = 139
  HelpContext = 703000
  Caption = 'Reward Points Due to Expire'
  ExplicitLeft = 1451
  ExplicitTop = 139
  PixelsPerInch = 96
  TextHeight = 13
  inherited HeaderPanel: TPanel
    HelpContext = 703013
    inherited lblFrom: TLabel
      Width = 116
      HelpContext = 703014
      Caption = 'Points Expiring as of'
      Visible = True
      ExplicitWidth = 116
    end
    inherited pnlHeader: TPanel
      HelpContext = 703015
      inherited TitleShader: TShader
        HelpContext = 703016
        inherited TitleLabel: TLabel
          HelpContext = 703017
          Caption = 'Reward Points Due to Expire'
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 703018
      inherited grpFilters: TwwRadioGroup
        HelpContext = 703019
        ItemIndex = 0
        Visible = False
      end
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 703020
      Visible = True
    end
  end
  inherited Panel1: TPanel
    HelpContext = 703021
    inherited grdMain: TwwDBGrid
      HelpContext = 703022
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgMultiSelect, dgShowFooter, dgRowResize]
      ExplicitHeight = 156
    end
  end
  inherited FooterPanel: TDNMPanel
    HelpContext = 703001
    object lblMsg1: TLabel [5]
      Left = 0
      Top = 0
      Width = 996
      Height = 19
      HelpContext = 703022
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = '"Hold Down Ctrl to Select Multiple Entries"'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      ExplicitWidth = 998
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 703003
    end
    inherited cmdNew: TDNMSpeedButton
      Left = 569
      HelpContext = 703004
      ExplicitLeft = 569
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 683
      HelpContext = 703005
      ExplicitLeft = 683
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 455
      HelpContext = 703006
      ExplicitLeft = 455
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 703007
    end
    inherited pnlAdvPrinting: TDNMPanel
      Left = 384
      HelpContext = 703008
      ExplicitLeft = 384
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 703009
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 703010
      Panels = <
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          Text = 'Current Filter'
          TimeFormat = 'hh:mm:ss'
          Width = 80
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          TimeFormat = 'hh:mm:ss'
          Width = 700
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psOwnerDraw
          TimeFormat = 'hh:mm:ss'
          Width = 50
        end>
    end
    object btnSelect: TDNMSpeedButton
      Left = 340
      Top = 32
      Width = 87
      Height = 27
      HelpContext = 703012
      Anchors = [akBottom]
      Caption = 'Select All'
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
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      TabStop = False
      OnClick = btnSelectClick
    end
    object cmdEmail: TDNMSpeedButton
      Left = 226
      Top = 32
      Width = 87
      Height = 27
      HelpContext = 703011
      Anchors = [akBottom]
      Caption = 'E-mail'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      TabStop = False
      OnClick = cmdEmailClick
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'Select SP.* , C.Company , '
      
        'ifnull(round(Sum(SRP.UsedPoints),2),0) UsedPoints , round(Sum(SR' +
        'P.RedeemAmount),2) RedeemAmount, '
      
        'Cast( if(sp.IsOpeningBalance="T", SP.OpeningBalanceAsOn ,S.SaleD' +
        'ate)  as DAteTime ) as SaleDate, '
      
        'CAST(if(Ifnull(SP.PointExpiresOn,0)<> 0 , SP.PointExpiresOn ,  i' +
        'f(ifnull(SP.ExpiresOnNoOfMonthsAfterPurchase,0)  <> 0,  Date_Add' +
        '(S.SaleDate , Interval   ExpiresOnNoOfMonthsAfterPurchase MONTH)' +
        ',NULL )) as DAteTime) as ExpiryDate ,'
      
        'if(sp.IsOpeningBalance="T" , "OpeningBalance", if(S.IsInvoice="T' +
        '", "Invoice" , "CashSale")) as TRanstype'
      'from tblsaleslinespoints SP'
      'inner join tblClients c on C.clientID = SP.clientID'
      'Left Join tblsales AS S ON SP.SaleID = S.SaleID'
      
        'Left join tblsalesredeempoints SRP on SRP.SalesLinesPointsId = S' +
        'P.SalesLinesPointsId and SRP.active ="T"'
      'where SP.active = "T"'
      
        'and (ifnull(ExpiresOnNoOfMonthsAfterPurchase,0) <> 0 OR  ifnull(' +
        'PointExpiresOn,0) <> 0) '
      'group by SP.SalesLinesPointsId')
  end
end
