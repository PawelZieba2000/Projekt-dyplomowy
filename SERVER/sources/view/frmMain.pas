unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxClasses, dxBar, System.Actions,
  Vcl.ActnList, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxCore, dxRibbonSkins, dxRibbonCustomizationForm, dxRibbon, dxSkinsCore,
  dxSkinOffice2019Colorful, dxSkinBasic, dxDockControl, uModDispatcher,
  System.ImageList, Vcl.ImgList, cxImageList, dxStatusBar,
  IdHTTPWebBrokerBridge, cxSpinEdit, cxBarEditItem, cxTextEdit;

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
    stsbrBottom: TdxStatusBar;
    actOpenUsers: TAction;
    btnOpenUsers: TdxBarLargeButton;
    brServer: TdxBar;
    dxRibbonTabServer: TdxRibbonTab;
    btnStartServer: TdxBarLargeButton;
    btnStopServer: TdxBarLargeButton;
    actStartServer: TAction;
    actStopServer: TAction;
    dxBarLargeButton1: TdxBarLargeButton;
    baredtPort: TcxBarEditItem;
    baredtIpAddress: TcxBarEditItem;
    baredtUrl: TcxBarEditItem;
    procedure FormActivate(Sender: TObject);
    procedure actLoginExecute(Sender: TObject);
    procedure actOpenConfigExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actOpenWeighingHistoryExecute(Sender: TObject);
    procedure actOpenCustomersExecute(Sender: TObject);
    procedure actOpenProductsExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure actOpenUsersExecute(Sender: TObject);
    procedure actStartServerExecute(Sender: TObject);
    procedure actStopServerExecute(Sender: TObject);
  private
    FServer : TIdHTTPWebBrokerBridge;

    procedure StartServer();
    procedure StopServer();

    procedure OnGetSSLPassword(var APassword: String);
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses
  frmLogin, frmConfig, cHelpFunctions, System.StrUtils, cManagerUser, uConsts,
  cManagerConfig, frmWeighing, frmWeighingList, frmCustomerList, frmProductList,
  IdSSLOpenSSL, frmUserList, uModDatabase, cManagerAddresses, cManagerCustomers,
  cManagerProducts, cManagerWeighings;

{$R *.dfm}

procedure TFormMain.actExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TFormMain.actLoginExecute(Sender: TObject);
begin
  var logInResult : Boolean := TFormLogin.CreateAndShowModal(Nil) = mrOk;
  THelpFunctions.SetControlEnable([actOpenCustomers, actOpenProducts, actOpenWeighingHistory, actOpenUsers, actStartServer], logInResult);
  Self.stsbrBottom.Panels[0].Text := Self.stsbrBottom.Panels[0].Text + ' ' + System.StrUtils.IfThen(logInResult, TManagerUser.Instance.LoggedUser.FullName, EMPTY_STR);
end;

procedure TFormMain.actOpenConfigExecute(Sender: TObject);
begin
  TFormConfig.CreateAndShowModal(Nil);
end;

procedure TFormMain.actOpenCustomersExecute(Sender: TObject);
begin
  TFormCustomerList.CreateAndShowModal(nil);
end;

procedure TFormMain.actOpenProductsExecute(Sender: TObject);
begin
  TFormProductList.CreateAndShowModal(nil);
end;

procedure TFormMain.actOpenUsersExecute(Sender: TObject);
begin
  TFormUserList.CreateAndShowModal(nil);
end;

procedure TFormMain.actOpenWeighingHistoryExecute(Sender: TObject);
begin
  TFormWeighingList.CreateAndShowModal(nil);
end;

procedure TFormMain.actStartServerExecute(Sender: TObject);
begin
  Self.StartServer();
end;

procedure TFormMain.actStopServerExecute(Sender: TObject);
begin
  Self.StopServer();
end;

procedure TFormMain.FormActivate(Sender: TObject);
begin
  actLoginExecute(nil);
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  TManagerConfig.Instance.LoadConfig();
  TManagerUser.Instance;

  ModuleDataBase.Connect;

  TManagerAddresses.Instance;
  TManagerCustomers.Instance.GetCustomersFromDb;
  TManagerProducts.Instance.GetProductsFromDb;
  TManagerWeighings.Instance.GetWeighingsFromDb;

  FServer := TIdHTTPWebBrokerBridge.Create(Self);
end;

procedure TFormMain.StartServer;
  function GetServerUrl() : String;
  begin
    Result := 'http://';
    if Assigned(Self.FServer.IOHandler) and (Self.FServer.IOHandler is TIdServerIOHandlerSSLOpenSSL) then
      Result := 'https://';

    Result := Result + THelpFunctions.GetIPAddress();

    if Self.FServer.DefaultPort <> 80 then
      Result := Result + ':' + IntToStr(Self.FServer.DefaultPort);
  end;

begin
  if FServer.Active then
    Exit;

  FServer.Bindings.Clear;
  FServer.DefaultPort := TManagerConfig.Instance.RestServerConfig.ApiPort;

  if TManagerConfig.Instance.RestServerConfig.ApiUseSSL then
  begin
    var LIOHandleSSL : TIdServerIOHandlerSSLOpenSSL;
    LIOHandleSSL := TIdServerIOHandlerSSLOpenSSL.Create(FServer);

    LIOHandleSSL.SSLOptions.CertFile := TManagerConfig.Instance.RestServerConfig.ApiCertFile;
    LIOHandleSSL.SSLOptions.RootCertFile := TManagerConfig.Instance.RestServerConfig.ApiRootCertFile;
    LIOHandleSSL.SSLOptions.KeyFile := TManagerConfig.Instance.RestServerConfig.ApiKeyFile;

    LIOHandleSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
    LIOHandleSSL.SSLOptions.Mode := sslmServer;

    LIOHandleSSL.OnGetPassword := OnGetSSLPassword;
    FServer.IOHandler := LIOHandleSSL;
  end else if Assigned(FServer.IOHandler) and (FServer.IOHandler is TIdServerIOHandlerSSLOpenSSL) then
  begin
    FServer.IOHandler.Free;
    FServer.IOHandler := nil;
  end;

  FServer.Active := True;

  baredtIpAddress.EditValue := THelpFunctions.GetIPAddress();
  baredtPort.EditValue := FServer.DefaultPort;
  baredtUrl.EditValue := GetServerUrl();
  actStopServer.Enabled := True;
  actStartServer.Enabled := not actStopServer.Enabled;
end;

procedure TFormMain.StopServer;
begin
  FServer.Active := False;
  FServer.Bindings.Clear;
  actStopServer.Enabled := False;
  actStartServer.Enabled := not actStopServer.Enabled;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  Self.StopServer();
  FreeAndNil(Self.FServer);
  TManagerConfig.ReleaseInstance;
  TManagerUser.ReleaseInstance;
  TManagerAddresses.ReleaseInstance;
  TManagerCustomers.ReleaseInstance;
  TManagerProducts.ReleaseInstance;
  TManagerWeighings.ReleaseInstance;
  ModuleDataBase.Disconnect;
end;

procedure TFormMain.OnGetSSLPassword(var APassword: String);
begin
//
end;

end.
