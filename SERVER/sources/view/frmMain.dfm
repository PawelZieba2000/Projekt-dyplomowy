object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Central Weigher - serwer'
  ClientHeight = 550
  ClientWidth = 871
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
    Width = 871
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
    object dxRibbonTabServer: TdxRibbonTab
      Active = True
      Caption = 'Serwer'
      Groups = <
        item
          ToolbarName = 'brServer'
        end>
      Index = 4
    end
  end
  object stsbrBottom: TdxStatusBar
    Left = 0
    Top = 530
    Width = 871
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = 'Zalogowano jako:'
      end>
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
    object actOpenUsers: TAction
      Caption = 'U'#380'ytkownicy'
      Enabled = False
      ImageIndex = 17
      OnExecute = actOpenUsersExecute
    end
    object actStartServer: TAction
      Caption = 'Uruchom'
      Enabled = False
      ImageIndex = 18
      OnExecute = actStartServerExecute
    end
    object actStopServer: TAction
      Caption = 'Zatrzymaj'
      Enabled = False
      ImageIndex = 19
      OnExecute = actStopServerExecute
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
        end
        item
          Visible = True
          ItemName = 'btnOpenUsers'
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
          ItemName = 'btnOpenWeighingHistory'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object brServer: TdxBar
      Caption = 'Serwer'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 899
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'btnStartServer'
        end
        item
          Visible = True
          ItemName = 'btnStopServer'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'baredtPort'
        end
        item
          Visible = True
          ItemName = 'baredtIpAddress'
        end
        item
          Visible = True
          ItemName = 'baredtUrl'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
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
    object btnOpenUsers: TdxBarLargeButton
      Action = actOpenUsers
      Category = 0
    end
    object btnStartServer: TdxBarLargeButton
      Action = actStartServer
      Category = 0
    end
    object btnStopServer: TdxBarLargeButton
      Action = actStopServer
      Category = 0
    end
    object dxBarLargeButton1: TdxBarLargeButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
    object baredtPort: TcxBarEditItem
      Align = iaClient
      Caption = 'Port'
      Category = 0
      Hint = 'Port'
      Visible = ivAlways
      PropertiesClassName = 'TcxSpinEditProperties'
      Properties.Alignment.Horz = taRightJustify
      Properties.ReadOnly = True
      Properties.SpinButtons.Visible = False
    end
    object baredtIpAddress: TcxBarEditItem
      Align = iaClient
      Caption = 'Adres IP'
      Category = 0
      Hint = 'Adres IP'
      Visible = ivAlways
      PropertiesClassName = 'TcxTextEditProperties'
      Properties.ReadOnly = True
    end
    object baredtUrl: TcxBarEditItem
      Align = iaClient
      Caption = 'Adres URL'
      Category = 0
      Hint = 'Adres URL'
      Visible = ivAlways
      PropertiesClassName = 'TcxTextEditProperties'
      Properties.ReadOnly = True
    end
  end
end
