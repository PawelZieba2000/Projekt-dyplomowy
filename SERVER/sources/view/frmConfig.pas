unit frmConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxLayoutControlAdapters,
  System.Actions, Vcl.ActnList, cxClasses, dxBar, System.ImageList, Vcl.ImgList,
  cxImageList, dxLayoutContainer, Vcl.StdCtrls, cxButtons, dxLayoutControl,
  dxLayoutcxEditAdapters, cxContainer, cxEdit, cxLabel, uModDispatcher,
  dxCoreGraphics, cxButtonEdit, cxMaskEdit, cxSpinEdit, cxTextEdit, dxSkinsCore,
  dxSkinBasic, cxDropDownEdit, CPortCtl, cConfig;

type
  TFormConfig = class(TFormBase)
    lgTop: TdxLayoutGroup;
    lgCenter: TdxLayoutGroup;
    imgTittle: TdxLayoutImageItem;
    liLblTitle: TdxLayoutLabeledItem;
    sprtrTop: TdxLayoutSeparatorItem;
    liApiPort: TdxLayoutItem;
    lgApiConfig: TdxLayoutGroup;
    liApiLogPath: TdxLayoutItem;
    edtbtnApiLogPath: TcxButtonEdit;
    liDbConnTest: TdxLayoutItem;
    btnDbConnTest: TcxButton;
    actDbConnTest: TAction;
    lgDbConfig: TdxLayoutGroup;
    seRestApiPort: TcxSpinEdit;
    liDbPath: TdxLayoutItem;
    liDbServerAddress: TdxLayoutItem;
    liDbServerPort: TdxLayoutItem;
    liDbUsername: TdxLayoutItem;
    liDbPassword: TdxLayoutItem;
    edtDbServerAddress: TcxTextEdit;
    seDbServerPort: TcxSpinEdit;
    edtDbPath: TcxTextEdit;
    edtDbUsername: TcxTextEdit;
    edtDbPassword: TcxTextEdit;
    liChbApiUseSSL: TdxLayoutCheckBoxItem;
    procedure actOkExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure edtbtnApiLogPathPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FormCreate(Sender: TObject);
    procedure actDbConnTestExecute(Sender: TObject);
  private
    procedure FillControls();
    function ValidateData() : Boolean;
    procedure SetDbConfig(pDbConf : TDataBaseConfig);
  public
    class function CreateAndShowModal(AOwner : TComponent) : Integer;
  end;

var
  FormConfig: TFormConfig;

implementation

uses
  cManagerConfig, cHelpFunctions, cTypes, frmAppMessage, uModDatabase;

{$R *.dfm}

{ TFormConfig }

procedure TFormConfig.actCancelExecute(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TFormConfig.actDbConnTestExecute(Sender: TObject);
begin
  var tmpDbConf : TDataBaseConfig := TDataBaseConfig.Create;
  try
    Self.SetDbConfig(tmpDbConf);
    var res : Boolean := False;
    try
      res := ModuleDataBase.CheckConnection(tmpDbConf);
    except
      on E: Exception do
      begin
        TFormAppMessage.ShowError('Nie uda³o siê po³¹czyæ z baz¹ danych' + sLineBreak + '[Error]: ' + E.Message);
        Exit;
      end;
    end;

    if res then
      TFormAppMessage.ShowInfo('Po³¹czono z baz¹ danych')
    else
      TFormAppMessage.ShowWarning('Nie uda³o siê po³¹czyæ z baz¹ danych');
  finally
    tmpDbConf.Free;
  end;
end;

procedure TFormConfig.actOkExecute(Sender: TObject);
begin
  if not TFormAppMessage.ShowQusetion('Czy na pewno chcesz zapisaæ ustawienia?') then
    Exit;

  //valdiate data
  if not ValidateData() then
    Exit;

  //assign data
  with TManagerConfig.Instance.RestServerConfig do
  begin
    ApiPort := seRestApiPort.Value;
    ApiLogPath := Trim(edtbtnApiLogPath.Text);
    ApiUseSSL := liChbApiUseSSL.Checked;
  end;

  SetDbConfig(TManagerConfig.Instance.DatabaseConfig);
//  with TManagerConfig.Instance.DatabaseConfig do
//  begin
//    DbServer := Trim(edtDbServerAddress.Text);
//    DbPort := seDbServerPort.Value;
//    DbPath := Trim(edtDbPath.Text);
//    DbUsername := Trim(edtDbUsername.Text);
//    DbPassword := Trim(edtDbPassword.Text);
//  end;

  TManagerConfig.Instance.SaveConfig;

  Self.ModalResult := mrOk;
end;

class function TFormConfig.CreateAndShowModal(AOwner: TComponent): Integer;
begin
  Result := mrNone;

  if Assigned(FormConfig) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  FormConfig := TFormConfig.Create(AOwner);
  try
    Result := FormConfig.ShowModal;
  finally
    FreeAndNil(FormConfig);
  end;
end;

procedure TFormConfig.edtbtnApiLogPathPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  var fod : TFileOpenDialog := TFileOpenDialog.Create(nil);
  fod.Options := fod.Options + [fdoPickFolders];
  fod.DefaultFolder := THelpFunctions.GetCurrentDirectory;
  var tmpPath : String := Trim(Self.edtbtnApiLogPath.Text);
  if DirectoryExists(tmpPath) then
    fod.DefaultFolder := tmpPath;

  try
    if fod.Execute then
      Self.edtbtnApiLogPath.Text := fod.FileName;
  finally
    fod.Free;
  end;
end;

procedure TFormConfig.FillControls;
begin
  with TManagerConfig.Instance.RestServerConfig do
  begin
    seRestApiPort.Value := ApiPort;
    edtbtnApiLogPath.Text := ApiLogPath;
    liChbApiUseSSL.Checked := ApiUseSSL;
  end;

  with TManagerConfig.Instance.DatabaseConfig do
  begin
    edtDbServerAddress.Text := DbServer;
    seDbServerPort.Value := DbPort;
    edtDbPath.Text := DbPath;
    edtDbUsername.Text := DbUsername;
    edtDbPassword.Text := DbPassword;
  end;
end;

procedure TFormConfig.FormCreate(Sender: TObject);
begin
  Self.FillControls;
end;

procedure TFormConfig.SetDbConfig(pDbConf: TDataBaseConfig);
begin
  if not Assigned(pDbConf) then
  begin
    TFormAppMessage.ShowError('Obiekt ustawieñ nie istnieje!');
    Exit;
  end;

  with pDbConf do
  begin
    DbServer := Trim(edtDbServerAddress.Text);
    DbPort := seDbServerPort.Value;
    DbPath := Trim(edtDbPath.Text);
    DbUsername := Trim(edtDbUsername.Text);
    DbPassword := Trim(edtDbPassword.Text);
  end;
end;

function TFormConfig.ValidateData: Boolean;
begin
  Result := False;

//  if liChbScaleActive.Checked then
//  begin
//    if (Self.cmbScaleProtocols.ItemIndex = -1) or (Self.cmbScaleProtocols.ItemIndex = sptNone.ToInteger) then
//    begin
//      TFormAppMessage.ShowWarning('Protokó³ komunikacyjny nie zosta³ wybrany!');
//      Exit;
//    end;
//  end;

  Result := True;
end;

end.
