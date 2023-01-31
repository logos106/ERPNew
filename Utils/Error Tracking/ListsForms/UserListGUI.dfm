inherited UsersList: TUsersList
  Left = 97
  Top = 140
  Caption = 'Users List'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TDNMPanel
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'UserID'#9'15'#9'UserID'#9#9
        'UserName'#9'50'#9'UserName'#9#9
        'UserType'#9'50'#9'UserType'#9#9)
    end
  end
  inherited HeaderPanel: TDNMPanel
    inherited pnlHeader: TPanel
      Caption = 'Users List'
    end
  end
  inherited FooterPanel: TDNMPanel
    inherited cmdNew: TDNMSpeedButton
      OnClick = cmdNewClick
    end
  end
  inherited qryListData: TMyQuery
    SQL.Strings = (
      'select '
      'users.userid,'
      'users.username,'
      'usertypes.usertype'
      'from users '
      'left join usertypes on  users.usertypeid=usertypes.usertypeid')
  end
end
