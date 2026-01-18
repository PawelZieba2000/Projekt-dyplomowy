unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxClasses, dxBar, System.Actions,
  Vcl.ActnList, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxCore, dxRibbonSkins, dxRibbonCustomizationForm, dxRibbon, dxSkinsCore,
  dxSkinOffice2019Colorful, dxSkinBasic, dxDockControl, uModDispatcher,
  System.ImageList, Vcl.ImgList, cxImageList;

type
  TFormMain = class(TForm)
    actlstMain: TActionList;
    actLogin: TAction;
    actOpenConfig: TAction;
    barmngMain: TdxBarManager;
    brMain: TdxBar;
    btnLogin: TdxBarLargeButton;
    btnConfig: TdxBarLargeButton;
    actExit: TAction;
    btnExit: TdxBarLargeButton;
    actOpenWeighingHistory: TAction;
    actOpenCustomers: TAction;
    actOpenProducts: TAction;
    actOpenWeighing: TAction;
    btnOpenWeighing: TdxBarLargeButton;
    btnOpenWeighingHistory: TdxBarLargeButton;
    btnOpenCustomers: TdxBarLargeButton;
    btnOpenProducts: TdxBarLargeButton;
    dxRibbon1: TdxRibbon;
    dxRibbonTabMain: TdxRibbonTab;
    brConfig: TdxBar;
    brDictionaries: TdxBar;
    brWeighing: TdxBar;
    dxRibbonTabConfig: TdxRibbonTab;
    dxRibbonTabDictionaries: TdxRibbonTab;
    dxRibbonTabWeighings: TdxRibbonTab;
    procedure FormActivate(Sender: TObject);
    procedure actLoginExecute(Sender: TObject);
    procedure actOpenConfigExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actOpenWeighingHistoryExecute(Sender: TObject);
    procedure actOpenCustomersExecute(Sender: TObject);
    procedure actOpenProductsExecute(Sender: TObject);
    procedure actOpenDictionariesExecute(Sender: TObject);
    procedure actOpenWeighingExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses
  frmLogin, frmConfig, cHelpFunctions;

{$R *.dfm}

procedure TFormMain.actExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TFormMain.actLoginExecute(Sender: TObject);
begin
  if not Assigned(FormLogin) then
    FormLogin := TFormLogin.Create(Nil);

  THelpFunctions.SetControlEnable([actOpenCustomers, actOpenProducts, actOpenWeighing, actOpenWeighingHistory], FormLogin.ModalResult = mrOk);
end;

procedure TFormMain.actOpenConfigExecute(Sender: TObject);
begin
  if not Assigned(FormConfig) then
    FormConfig := TFormConfig.Create(nil);

  FormConfig.ShowModal;
end;

procedure TFormMain.actOpenCustomersExecute(Sender: TObject);
begin
//
end;

procedure TFormMain.actOpenDictionariesExecute(Sender: TObject);
begin
//
end;

procedure TFormMain.actOpenProductsExecute(Sender: TObject);
begin
//
end;

procedure TFormMain.actOpenWeighingExecute(Sender: TObject);
begin
//
end;

procedure TFormMain.actOpenWeighingHistoryExecute(Sender: TObject);
begin
//
end;

procedure TFormMain.FormActivate(Sender: TObject);
begin
  actLoginExecute(nil);
end;

end.
