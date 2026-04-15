inherited FormWeighingList: TFormWeighingList
  Caption = 'Lista wa'#380'e'#324
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
        object clmnWeighingNo: TcxGridColumn
          Caption = 'NR WAZENIA'
          HeaderAlignmentHorz = taCenter
        end
        object clmnCarNo: TcxGridColumn
          Caption = 'NR REJESTRACYJNY'
          HeaderAlignmentHorz = taCenter
        end
        object clmnTrailerNo: TcxGridColumn
          Caption = 'NR NACZEPY'
          HeaderAlignmentHorz = taCenter
        end
        object clmnDateIn: TcxGridColumn
          Caption = 'DATA WJAZDU'
          DataBinding.ValueType = 'DateTime'
          HeaderAlignmentHorz = taCenter
        end
        object clmnMassIn: TcxGridColumn
          Caption = 'MASA WJAZDU'
          HeaderAlignmentHorz = taCenter
        end
        object clmnDateOut: TcxGridColumn
          Caption = 'DATA WYJAZDU'
          DataBinding.ValueType = 'DateTime'
          HeaderAlignmentHorz = taCenter
        end
        object clmnMassOut: TcxGridColumn
          Caption = 'MASA WYJAZDU'
          HeaderAlignmentHorz = taCenter
        end
        object clmnMassTare: TcxGridColumn
          Caption = 'TARA'
          HeaderAlignmentHorz = taCenter
        end
        object clmnMassNet: TcxGridColumn
          Caption = 'NETTO'
          HeaderAlignmentHorz = taCenter
        end
        object clmnCustomerIdErp: TcxGridColumn
          Caption = 'ID KONTRAHENT'
          DataBinding.ValueType = 'Integer'
          Visible = False
          HeaderAlignmentHorz = taCenter
        end
        object clmnCustomerCode: TcxGridColumn
          Caption = 'KOD KONTRAHENTA'
          HeaderAlignmentHorz = taCenter
        end
        object clmnCustomerName: TcxGridColumn
          Caption = 'NAZWA KONTRAHENTA'
          HeaderAlignmentHorz = taCenter
        end
        object clmnProductIdErp: TcxGridColumn
          Caption = 'ID PRODUKTU'
          DataBinding.ValueType = 'Integer'
          Visible = False
          HeaderAlignmentHorz = taCenter
        end
        object clmnProductCode: TcxGridColumn
          Caption = 'KOD PRODUKTU'
          HeaderAlignmentHorz = taCenter
        end
        object clmnProductName: TcxGridColumn
          Caption = 'NAZWA PRODUKTU'
          HeaderAlignmentHorz = taCenter
        end
        object clmnUserInName: TcxGridColumn
          Caption = 'UZYTKOWNIK WJAZD'
          Visible = False
          HeaderAlignmentHorz = taCenter
        end
        object clmnUserInId: TcxGridColumn
          Caption = 'UZYTKOWNIK WJAZD ID'
          DataBinding.ValueType = 'Integer'
          Visible = False
          HeaderAlignmentHorz = taCenter
        end
        object clmnUserOutName: TcxGridColumn
          Caption = 'UZYTKOWNIK WYJAZD'
          Visible = False
          HeaderAlignmentHorz = taCenter
        end
        object clmnUserOutId: TcxGridColumn
          Caption = 'UZYTKOWNIK WYJAZD ID'
          DataBinding.ValueType = 'Integer'
          Visible = False
          HeaderAlignmentHorz = taCenter
        end
        object clmnIsDeleted: TcxGridColumn
          Caption = 'USUNIETO'
          DataBinding.ValueType = 'Integer'
          Visible = False
          HeaderAlignmentHorz = taCenter
        end
        object clmnModifDT: TcxGridColumn
          Caption = 'DATA MODYFIKACJI'
          DataBinding.ValueType = 'DateTime'
          Visible = False
          HeaderAlignmentHorz = taCenter
        end
      end
    end
  end
  inherited barmngMain: TdxBarManager
    PixelsPerInch = 96
  end
end
