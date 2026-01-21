inherited FormCustomerList: TFormCustomerList
  Caption = 'Lista kontrahent'#243'w'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited barmngMain: TdxBarManager
    PixelsPerInch = 96
    inherited baredtFilter: TcxBarEditItem
      InternalEditValue = ''
    end
  end
end
