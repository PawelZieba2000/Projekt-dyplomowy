unit frmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxLayoutControlAdapters,
  System.Actions, Vcl.ActnList, cxClasses, dxBar, System.ImageList, Vcl.ImgList,
  cxImageList, dxLayoutContainer, Vcl.StdCtrls, cxButtons, dxLayoutControl,
  dxLayoutcxEditAdapters, cxContainer, cxEdit, cxTextEdit, dxSkinsCore,
  dxSkinBasic;

type
  TFormLogin = class(TFormBase)
    lgCentral: TdxLayoutGroup;
    lgInput: TdxLayoutGroup;
    dxLayoutImageItem1: TdxLayoutImageItem;
    liUserName: TdxLayoutItem;
    liPassword: TdxLayoutItem;
    edtUserName: TcxTextEdit;
    edtPassword: TcxTextEdit;
    actOpenConfig: TAction;
    liOpenConfig: TdxLayoutItem;
    btnOpenConfig: TcxButton;
    procedure actOpenConfigExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
  private
    { Private declarations }
  public
    class function CreateAndShowModal(AOwner : TComponent) : Integer;
  end;

var
  FormLogin: TFormLogin;

implementation

uses
  frmConfig, cManagerUser, cItemUser, cHelpFunctions;

{$R *.dfm}

procedure TFormLogin.actCancelExecute(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TFormLogin.actOkExecute(Sender: TObject);
begin
  var tmpUser : TItemUser := TItemUser.Create();

  tmpUser.Login := edtUserName.Text;
  tmpUser.Password := edtPassword.Text;
  try
    if true {pomyslnie zalogowano} then
    begin
      TManagerUser.Instance.LoggedUser.AssignValues(tmpUser);
      Self.ModalResult := mrOk;
    end;
  finally
    tmpUser.Free;
  end;
end;

procedure TFormLogin.actOpenConfigExecute(Sender: TObject);
begin
  TFormConfig.CreateAndShowModal(Nil);
end;

class function TFormLogin.CreateAndShowModal(AOwner: TComponent): Integer;
begin
  Result := mrNone;

  if Assigned(FormLogin) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  FormLogin := TFormLogin.Create(AOwner);
  try
    Result := FormLogin.ShowModal;
  finally
    FreeAndNil(FormLogin);
  end;
end;

end.
