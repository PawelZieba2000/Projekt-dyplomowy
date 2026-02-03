inherited FormProductList: TFormProductList
  Caption = 'Lista produkt'#243'w'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited lcMain: TdxLayoutControl
    inherited gGridList: TcxGrid
      inherited gGridListTableView1: TcxGridTableView
        OnCellDblClick = gGridListTableView1CellDblClick
        OptionsView.ColumnAutoWidth = True
        object clmnIdErp: TcxGridColumn
          Caption = 'ID ERP'
          DataBinding.ValueType = 'Integer'
          HeaderAlignmentHorz = taCenter
        end
        object clmnProdCode: TcxGridColumn
          Caption = 'KOD'
          HeaderAlignmentHorz = taCenter
        end
        object clmnProdName: TcxGridColumn
          Caption = 'NAZWA'
          HeaderAlignmentHorz = taCenter
        end
        object clmnProdPrice: TcxGridColumn
          Caption = 'CENA [z'#322'/kg]'
          DataBinding.ValueType = 'Currency'
          HeaderAlignmentHorz = taCenter
        end
        object clmnProdLocationId: TcxGridColumn
          Caption = 'ID ODDZIA'#321'U'
          DataBinding.ValueType = 'Integer'
          HeaderAlignmentHorz = taCenter
        end
        object clmnProdModifDT: TcxGridColumn
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
