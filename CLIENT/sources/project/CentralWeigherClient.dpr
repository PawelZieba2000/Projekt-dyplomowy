program CentralWeigherClient;

uses
  Vcl.Forms,
  cManagerConfig in '..\controller\cManagerConfig.pas',
  cTypes in '..\model\cTypes.pas',
  cConfig in '..\model\cConfig.pas',
  iScaleTranssmision in '..\transsmision\iScaleTranssmision.pas',
  cItemProduct in '..\model\cItemProduct.pas',
  cItemUser in '..\model\cItemUser.pas',
  cItemCustomer in '..\model\cItemCustomer.pas',
  cItemWeighing in '..\model\cItemWeighing.pas',
  frmBase in '..\view\baseForm\frmBase.pas' {FormBase},
  frmBaseAddEdit in '..\view\baseForm\frmBaseAddEdit.pas' {FormBaseAddEdit},
  frmBaseList in '..\view\baseForm\frmBaseList.pas' {FormBaseList},
  frmMain in '..\view\frmMain.pas' {FormMain},
  frmLogin in '..\view\frmLogin.pas' {FormLogin},
  frmConfig in '..\view\frmConfig.pas' {FormConfig},
  uModDispatcher in '..\modules\uModDispatcher.pas' {ModDispatcher: TDataModule},
  cManagerUser in '..\controller\cManagerUser.pas',
  uConsts in '..\units\uConsts.pas',
  cHelpFunctions in '..\helper\cHelpFunctions.pas',
  frmCustomerList in '..\view\frmCustomerList.pas' {FormCustomerList},
  frmProductList in '..\view\frmProductList.pas' {FormProductList},
  frmWeighingList in '..\view\frmWeighingList.pas' {FormWeighingList},
  cRestClient in '..\service\cRestClient.pas',
  cScaleTranssRinstrumC520 in '..\transsmision\cScaleTranssRinstrumC520.pas',
  cItemBase in '..\model\cItemBase.pas',
  cItemAddress in '..\model\cItemAddress.pas',
  iApiClient in '..\service\iApiClient.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TModDispatcher, ModDispatcher);
  Application.Run;
end.
