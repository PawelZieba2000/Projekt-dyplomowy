unit frmUserList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmBaseList, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBasic, Vcl.Menus,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, Data.DB, cxDBData,
  dxLayoutControlAdapters, dxLayoutContainer, cxTextEdit, System.Actions,
  Vcl.ActnList, dxBar, cxBarEditItem, cxClasses, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.StdCtrls, cxButtons, dxLayoutControl, cItemUser;

type
  TFormUserList = class(TFormBaseList)
    clmnId: TcxGridColumn;
    clmnLogin: TcxGridColumn;
    clmnFullName: TcxGridColumn;
    procedure FormDestroy(Sender: TObject);
    procedure gGridListTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure actOkExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actRemoveExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
  private
    FUser: TItemUser;

    procedure SelectUser();
  public
    class function CreateAndShowModal(AOwner : TComponent) : Integer;
    class function CreateAndSelectOne(AOwner : TComponent) : TItemUser;

    constructor Create(AOwner: TComponent); overload;
    constructor Create(AOwner: TComponent; AUser: TItemUser); overload;
  end;

var
  FormUserList: TFormUserList;

implementation

uses
  cHelpFunctions, cTypes, frmAppMessage, frmUserAddEdit, cManagerUser;

{$R *.dfm}

procedure TFormUserList.actAddExecute(Sender: TObject);
begin
  var tmpUser : TItemUser := TItemUser.Create();

  if TFormUserAddEdit.CreateAndShowModal(nil, tmpUser, fetAddNew) = mrOk then
    TManagerUser.Instance.InsertUpdateUser(tmpUser)
  else
    tmpUser.Free;
end;

procedure TFormUserList.actEditExecute(Sender: TObject);
begin
  if (not Assigned(gGridListTableView1.Controller.FocusedRow))
     or (gGridListTableView1.Controller.FocusedRow is TcxGridFilterRow)
  then
    Exit;

  var tmpID : Integer := gGridListTableView1.Controller.FocusedRow.Values[clmnId.Index];
  for var user : TItemUser in TManagerUser.Instance.UsersList do
  begin
    if tmpID <> user.Id then
      Continue;

    if TFormUserAddEdit.CreateAndShowModal(nil, user, fetEdit) <> mrOk then
      Exit;

    TManagerUser.Instance.InsertUpdateUser(user);
    actRefreshExecute(nil);
    Break;
  end;
end;

procedure TFormUserList.actOkExecute(Sender: TObject);
begin
  if Assigned(Self.FUser) then
  begin
    Self.SelectUser;
    Self.ModalResult := mrOk;
  end;
end;

procedure TFormUserList.actRefreshExecute(Sender: TObject);
begin
  TManagerUser.Instance.GetUsersFromDb;
  Self.gGridListTableView1.DataController.CustomDataSource.DataChanged;
end;

procedure TFormUserList.actRemoveExecute(Sender: TObject);
begin
  var tmpID : Integer := gGridListTableView1.Controller.FocusedRow.Values[clmnId.Index];
  var user : TItemUser := nil;
  for var tmpUser : TItemUser in TManagerUser.Instance.UsersList do
  begin
    if tmpID <> tmpUser.Id then
      Continue;

    user := tmpUser;
    Break;
  end;

  if not Assigned(user) then
    Exit;

  if not TFormAppMessage.ShowQusetion('Czy na pewno chcesz usun¹æ u¿ytkownika ' + user.FullName + '?') then
    Exit;

  user.IsDeleted := True;
  TManagerUser.Instance.InsertUpdateUser(user);
  actRefreshExecute(nil);
end;

constructor TFormUserList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Self.FUser := nil;
  Self.gGridListTableView1.DataController.CustomDataSource := TManagerUser.Instance.UsersDS;
  actRefreshExecute(nil);
end;

constructor TFormUserList.Create(AOwner: TComponent; AUser: TItemUser);
begin
  Self.Create(AOwner);
  Self.FUser := AUser;
end;

class function TFormUserList.CreateAndSelectOne(
  AOwner: TComponent): TItemUser;
begin
  Result := nil;

  if Assigned(FormUserList) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  Result := TItemUser.Create;
  FormUserList := TFormUserList.Create(AOwner, Result);
  try
    if FormUserList.ShowModal <> mrOk then
      FreeAndNil(Result);
  finally
    FreeAndNil(FormUserList);
  end;
end;

class function TFormUserList.CreateAndShowModal(
  AOwner: TComponent): Integer;
begin
  Result := mrNone;

  if Assigned(FormUserList) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  FormUserList := TFormUserList.Create(AOwner);
  try
    Result := FormUserList.ShowModal;
  finally
    FreeAndNil(FormUserList);
  end;
end;

procedure TFormUserList.FormDestroy(Sender: TObject);
begin
  FormUserList := nil;
end;

procedure TFormUserList.gGridListTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if Assigned(Self.FUser) then
    Self.SelectUser;
end;

procedure TFormUserList.SelectUser;
begin
  if (not Assigned(Self.FUser))
     or (not Assigned(gGridListTableView1.Controller.FocusedRow))
     or (gGridListTableView1.Controller.FocusedRow is TcxGridFilterRow)
  then
    Exit;

  var Id : Integer := gGridListTableView1.Controller.FocusedRow.Values[clmnId.Index];
  for var user : TItemUser in TManagerUser.Instance.UsersList do
  begin
    if Id <> user.Id then
      Continue;

    Self.FUser.AssignValues(user);
    Break;
  end;
end;

end.
