object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Central Weigher - klient'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 624
    Height = 124
    BarManager = barmngMain
    Style = rs2019
    ColorSchemeAccent = rcsaBlue
    ColorSchemeName = 'Basic'
    ShowMinimizeButton = False
    Contexts = <>
    TabOrder = 0
    TabStop = False
    object dxRibbonTabMain: TdxRibbonTab
      Active = True
      Caption = 'Narz'#281'dzia g'#322#243'wne'
      Groups = <
        item
          ToolbarName = 'brMain'
        end>
      Index = 0
    end
    object dxRibbonTabConfig: TdxRibbonTab
      Caption = 'Ustawienia'
      Groups = <
        item
          ToolbarName = 'brConfig'
        end>
      Index = 1
    end
    object dxRibbonTabDictionaries: TdxRibbonTab
      Caption = 'Kartoteki'
      Groups = <
        item
          ToolbarName = 'brDictionaries'
        end>
      Index = 2
    end
    object dxRibbonTabWeighings: TdxRibbonTab
      Caption = 'Wa'#380'enia'
      Groups = <
        item
          ToolbarName = 'brWeighing'
        end>
      Index = 3
    end
  end
  object stsbrBottom: TdxStatusBar
    Left = 0
    Top = 421
    Width = 624
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = 'Zalogowano jako: [%s]'
      end>
    ExplicitLeft = 432
    ExplicitTop = 304
    ExplicitWidth = 0
  end
  object actlstMain: TActionList
    Images = ModDispatcher.imgList32
    Left = 128
    Top = 160
    object actLogin: TAction
      Caption = 'Zaloguj'
      ImageIndex = 3
      OnExecute = actLoginExecute
    end
    object actOpenConfig: TAction
      Caption = 'Ustawienia'
      ImageIndex = 8
      OnExecute = actOpenConfigExecute
    end
    object actExit: TAction
      Caption = 'Zamknij'
      ImageIndex = 0
      OnExecute = actExitExecute
    end
    object actOpenWeighingHistory: TAction
      Caption = 'Lista wa'#380'e'#324
      Enabled = False
      ImageIndex = 5
      OnExecute = actOpenWeighingHistoryExecute
    end
    object actOpenCustomers: TAction
      Caption = 'Kontrahenci'
      Enabled = False
      ImageIndex = 4
      OnExecute = actOpenCustomersExecute
    end
    object actOpenProducts: TAction
      Caption = 'Produkty'
      Enabled = False
      ImageIndex = 2
      OnExecute = actOpenProductsExecute
    end
    object actOpenWeighing: TAction
      Caption = 'Nowe wa'#380'enie'
      Enabled = False
      ImageIndex = 4
      OnExecute = actOpenWeighingExecute
    end
  end
  object barmngMain: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = ModDispatcher.imgList32
    ImageOptions.LargeImages = ModDispatcher.imgList32
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 24
    Top = 160
    PixelsPerInch = 96
    object brMain: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Podstawowe'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 652
      FloatTop = 2
      FloatClientWidth = 59
      FloatClientHeight = 76
      ItemLinks = <
        item
          Visible = True
          ItemName = 'btnExit'
        end
        item
          Visible = True
          ItemName = 'btnLogin'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object brConfig: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Ustawienia'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 652
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      Images = ModDispatcher.imgList32
      ItemLinks = <
        item
          Visible = True
          ItemName = 'btnConfig'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object brDictionaries: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Kartoteki'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 652
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'btnOpenCustomers'
        end
        item
          Visible = True
          ItemName = 'btnOpenProducts'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object brWeighing: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Wa'#380'enie'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 652
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'btnOpenWeighing'
        end
        item
          Visible = True
          ItemName = 'btnOpenWeighingHistory'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object btnLogin: TdxBarLargeButton
      Action = actLogin
      Category = 0
    end
    object btnConfig: TdxBarLargeButton
      Action = actOpenConfig
      Category = 0
    end
    object btnExit: TdxBarLargeButton
      Action = actExit
      Category = 0
    end
    object btnOpenWeighing: TdxBarLargeButton
      Action = actOpenWeighing
      Category = 0
    end
    object btnOpenWeighingHistory: TdxBarLargeButton
      Action = actOpenWeighingHistory
      Category = 0
    end
    object btnOpenCustomers: TdxBarLargeButton
      Action = actOpenCustomers
      Category = 0
    end
    object btnOpenProducts: TdxBarLargeButton
      Action = actOpenProducts
      Category = 0
    end
  end
end
