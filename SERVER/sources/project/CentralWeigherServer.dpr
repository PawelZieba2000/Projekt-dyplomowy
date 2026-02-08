program CentralWeigherServer;

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  frmMain in '..\view\frmMain.pas' {Form2},
  frmAppMessage in '..\view\frmAppMessage.pas' {FormAppMessage},
  frmConfig in '..\view\frmConfig.pas' {FormConfig},
  frmCustomerList in '..\view\frmCustomerList.pas' {FormCustomerList},
  frmLogin in '..\view\frmLogin.pas' {FormLogin},
  frmProductList in '..\view\frmProductList.pas' {FormProductList},
  frmWeighing in '..\view\frmWeighing.pas' {FormWeighing},
  frmWeighingList in '..\view\frmWeighingList.pas' {FormWeighingList},
  cManagerConfig in '..\controller\cManagerConfig.pas',
  cManagerCustomers in '..\controller\cManagerCustomers.pas',
  cManagerProducts in '..\controller\cManagerProducts.pas',
  cManagerUser in '..\controller\cManagerUser.pas',
  cManagerWeighings in '..\controller\cManagerWeighings.pas',
  cDataSourceCustomers in '..\datasources\cDataSourceCustomers.pas',
  cDataSourceProducts in '..\datasources\cDataSourceProducts.pas',
  cDataSourceWeighings in '..\datasources\cDataSourceWeighings.pas',
  cHelpFunctions in '..\helper\cHelpFunctions.pas',
  cConfig in '..\model\cConfig.pas',
  cItemAddress in '..\model\cItemAddress.pas',
  cItemBase in '..\model\cItemBase.pas',
  cItemCustomer in '..\model\cItemCustomer.pas',
  cItemProduct in '..\model\cItemProduct.pas',
  cItemUser in '..\model\cItemUser.pas',
  cItemWeighing in '..\model\cItemWeighing.pas',
  cTypes in '..\model\cTypes.pas',
  uModDispatcher in '..\modules\uModDispatcher.pas' {ModDispatcher: TDataModule},
  uConsts in '..\units\uConsts.pas',
  frmBase in '..\view\baseForm\frmBase.pas' {FormBase},
  frmBaseAddEdit in '..\view\baseForm\frmBaseAddEdit.pas' {FormBaseAddEdit},
  frmBaseList in '..\view\baseForm\frmBaseList.pas' {FormBaseList},
  uWebModule in '..\modules\uWebModule.pas' {WebModuleMain: TDataModule},
  uModDatabase in '..\modules\uModDatabase.pas' {ModuleDataBase: TDataModule};

{$R *.res}

begin
  if WebRequestHandler.WebModuleClass <> nil then
    WebRequestHandler.WebModuleClass := WebModuleMain;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TModDispatcher, ModDispatcher);
  Application.CreateForm(TModuleDataBase, ModuleDataBase);
  Application.Run;
end.
