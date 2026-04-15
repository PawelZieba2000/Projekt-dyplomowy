unit frmUserAddEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmBaseAddEdit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBasic, Vcl.Menus,
  dxLayoutControlAdapters, System.Actions, Vcl.ActnList, cxClasses, dxBar,
  dxLayoutContainer, Vcl.StdCtrls, cxButtons, dxLayoutControl, cTypes,
  dxLayoutcxEditAdapters, cxContainer, cxEdit, cxMaskEdit,
  cxSpinEdit, cxTextEdit, cItemUser;

type
  TFormUserAddEdit = class(TFormBaseAddEdit)
    lgTop: TdxLayoutGroup;
    lgCenter: TdxLayoutGroup;
    imgTitle: TdxLayoutImageItem;
    liLblTitle: TdxLayoutLabeledItem;
    sprtr1: TdxLayoutSeparatorItem;
    liLogin: TdxLayoutItem;
    liPassword: TdxLayoutItem;
    edtLogin: TcxTextEdit;
    edtPassword: TcxTextEdit;
    liFirstName: TdxLayoutItem;
    liLastName: TdxLayoutItem;
    edtFirstName: TcxTextEdit;
    edtLastName: TcxTextEdit;
    procedure actOkExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FEditMode : TFormEditType;
    FUser : TItemUser;
    FIsInEdit : Boolean;

    procedure FillComponents();
    procedure FillUserValues();
    function ValidateValues() : Boolean;

    procedure SetControlsReadOnly(pIsReadOnly: Boolean);
  public
    class function CreateAndShowModal(AOwner : TComponent;  AUser: TItemUser; AEditMode: TFormEditType) : Integer;

    constructor Create(AOwner: TComponent; AUser: TItemUser; AEditMode: TFormEditType); overload;
  end;

var
  FormUserAddEdit: TFormUserAddEdit;

implementation

uses
  cHelpFunctions, uConsts, frmAppMessage;

{$R *.dfm}

procedure TFormUserAddEdit.actCancelExecute(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TFormUserAddEdit.actOkExecute(Sender: TObject);
begin
  if (Self.FEditMode = fetEdit) and (not Self.FISInEdit) then
  begin
    Self.FIsInEdit := True;
    Self.SetControlsReadOnly(not Self.FIsInEdit);

    Self.actOk.Caption := 'OK';
    Exit;
  end;

  if (Self.FISInEdit) then
  begin
    if not Self.ValidateValues then
      Exit;

    Self.FillUserValues();
    Self.ModalResult := mrOk;
  end;
end;

constructor TFormUserAddEdit.Create(AOwner: TComponent;
  AUser: TItemUser; AEditMode: TFormEditType);
begin
inherited Create(AOwner);

  Self.FEditMode := AEditMode;
  Self.FUser := AUser;

  case Self.FEditMode of
    fetAddNew: begin
      Self.Caption := 'Dodawanie nowego u¿ytkownika';
      Self.actOk.Caption := 'Dodaj';
    end;

    fetEdit: begin
      Self.Caption := 'Edycja u¿ytkownika: ' + Self.FUser.FullName;
      Self.actOk.Caption := 'Edytuj';
    end;
  end;

  liLblTitle.CaptionOptions.Text := Self.Caption;
  FIsInEdit := Self.FEditMode = fetAddNew;

  Self.FillComponents;
  Self.SetControlsReadOnly(not FIsInEdit);
end;

class function TFormUserAddEdit.CreateAndShowModal(AOwner: TComponent;
  AUser: TItemUser; AEditMode: TFormEditType): Integer;
begin
  Result := mrNone;
  if Assigned(FormUserAddEdit) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  FormUserAddEdit := TFormUserAddEdit.Create(AOwner, AUser, AEditMode);
  try
    Result := FormUserAddEdit.ShowModal;
  finally
    FreeAndNil(FormUserAddEdit);
  end;
end;

procedure TFormUserAddEdit.FillComponents;
begin
  Self.edtLogin.Text := Self.FUser.Login;
  Self.edtPassword.Text := Self.FUser.Password;
  Self.edtFirstName.Text := Self.FUser.FirstName;
  Self.edtLastName.Text := Self.FUser.LastName;
end;

procedure TFormUserAddEdit.FillUserValues;
begin
  Self.FUser.Login := Self.edtLogin.Text;
  Self.FUser.Password := Self.edtPassword.Text;
  Self.FUser.FirstName := Self.edtFirstName.Text;
  Self.FUser.LastName := Self.edtLastName.Text;
end;

procedure TFormUserAddEdit.FormDestroy(Sender: TObject);
begin
  FormUserAddEdit := nil;
end;

procedure TFormUserAddEdit.SetControlsReadOnly(pIsReadOnly: Boolean);
begin
  Self.edtLogin.Properties.ReadOnly := pIsReadOnly;
  Self.edtPassword.Properties.ReadOnly := pIsReadOnly;
  Self.edtFirstName.Properties.ReadOnly := pIsReadOnly;
  Self.edtLastName.Properties.ReadOnly := pIsReadOnly;
end;

function TFormUserAddEdit.ValidateValues: Boolean;
begin
    Result := False;
  try
    if Self.edtLogin.Text = EMPTY_STR then
      raise Exception.Create('Login nie mo¿e byæ pusty');

    if Self.edtPassword.Text = EMPTY_STR then
      raise Exception.Create('Has³o nie mo¿e byæ puste');

    if Self.edtFirstName.Text = EMPTY_STR then
      raise Exception.Create('Imiê nie mo¿e byæ puste');

    if Self.edtLastName.Text = EMPTY_STR then
      raise Exception.Create('Nazwisko nie mo¿e byæ puste');

    Result := True;
  except
    on E: Exception do
    begin
      TFormAppMessage.ShowWarning(E.Message);
    end;
  end;
end;

end.
