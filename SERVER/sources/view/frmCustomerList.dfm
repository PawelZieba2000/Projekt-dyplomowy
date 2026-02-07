inherited FormCustomerList: TFormCustomerList
  Caption = 'Lista kontrahent'#243'w'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited lcMain: TdxLayoutControl
    inherited gGridList: TcxGrid
      inherited gGridListTableView1: TcxGridTableView
        OnCellDblClick = gGridListTableView1CellDblClick
        object clmnIdErp: TcxGridColumn
          Caption = 'ID ERP'
          DataBinding.ValueType = 'Integer'
          HeaderAlignmentHorz = taCenter
        end
        object clmnCustomerCode: TcxGridColumn
          Caption = 'KOD'
          HeaderAlignmentHorz = taCenter
        end
        object clmnCustomerName: TcxGridColumn
          Caption = 'NAZWA'
          HeaderAlignmentHorz = taCenter
        end
        object clmnCustomerNIP: TcxGridColumn
          Caption = 'NIP'
          HeaderAlignmentHorz = taCenter
        end
        object clmnAddressStreet: TcxGridColumn
          Caption = 'ULICA'
          HeaderAlignmentHorz = taCenter
        end
        object clmnAddressHouseNo: TcxGridColumn
          Caption = 'NR BUDYNKU'
          HeaderAlignmentHorz = taCenter
        end
        object clmnAddressLocalNo: TcxGridColumn
          Caption = 'NR LOKALU'
          HeaderAlignmentHorz = taCenter
        end
        object clmnAddressPostCode: TcxGridColumn
          Caption = 'KOD POCZTOWY'
          HeaderAlignmentHorz = taCenter
        end
        object clmnAddressCity: TcxGridColumn
          Caption = 'MIASTO'
          HeaderAlignmentHorz = taCenter
        end
        object clmnCustomerPhoneNo: TcxGridColumn
          Caption = 'NR TEL.'
          HeaderAlignmentHorz = taCenter
        end
        object clmnCustomerLocationId: TcxGridColumn
          Caption = 'ID ODDZIA'#321'U'
          DataBinding.ValueType = 'Integer'
          HeaderAlignmentHorz = taCenter
        end
        object clmnCustomerModifDT: TcxGridColumn
          Caption = 'DATA MODYFIKACJI'
          DataBinding.ValueType = 'DateTime'
          HeaderAlignmentHorz = taCenter
        end
      end
    end
  end
  inherited barmngMain: TdxBarManager
    PixelsPerInch = 96
  end
end
