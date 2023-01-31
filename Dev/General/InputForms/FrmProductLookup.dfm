inherited FmProductLookup: TFmProductLookup
  Caption = 'FmProductLookup'
  ExplicitWidth = 315
  ExplicitHeight = 194
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1466002
  inherited cboQry: TERPQuery
    SQL.Strings = (
      'SELECT PartsID as ID, Partname as Name'
      'FROM tblparts'
      'WHERE Partname Is Not Null '
      'And (Active<>'#39'F'#39' or :ShowInactive ="T" or PartsId = :PartsId )'
      'ORDER BY Partname;')
    BeforeOpen = cboQryBeforeOpen
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ShowInactive'
      end
      item
        DataType = ftUnknown
        Name = 'PartsId'
      end>
  end
end
