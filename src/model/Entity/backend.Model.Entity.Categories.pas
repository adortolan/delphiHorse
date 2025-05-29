unit backend.Model.Entity.Categories;

interface

uses
  SimpleAttributes;

type
  [Tabela('Categories')]
  TCategories = class
  private
    FName: String;
    FIsActive: SmallInt;
    FID: String;
    FDescription: String;
    procedure setDescription(const Value: String);
    procedure setID(const Value: String);
    procedure setIsActive(const Value: SmallInt);
    procedure setName(const Value: String);
  public
    constructor Create;
    destructor Destroy;override;
    [Campo('ID'), PK]
    property Id: String read FID write setID;
    [Campo('Name')]
    property Name: String read FName write setName;
    [Campo('Description')]
    property Description: String read FDescription write setDescription;
    [Campo('IsActive')]
    property IsActive: SmallInt read FIsActive write setIsActive;
  end;

implementation

{ TCategories }

constructor TCategories.Create;
begin

end;

destructor TCategories.Destroy;
begin

  inherited;
end;

procedure TCategories.setDescription(const Value: String);
begin
  FDescription := Value;
end;

procedure TCategories.setID(const Value: String);
begin
  FID := Value;
end;

procedure TCategories.setIsActive(const Value: SmallInt);
begin
  FIsActive := Value;
end;

procedure TCategories.setName(const Value: String);
begin
  FName := Value;
end;

end.
