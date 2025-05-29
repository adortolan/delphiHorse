unit backend.Model.DAO;

interface

uses
  System.JSON,
  REST.Json,
  SimpleInterface,
  SimpleDAO,
  SimpleAttributes,
  SimpleQueryFiredac,
  Data.DB,
  DataSet.Serialize,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  backend.Model.Connection;

type

  iDAOGeneric<T : class> = interface
    ['{B6015000-0F9F-4287-9C34-DE07451AD0F6}']
    function Find : TJsonArray; overload;
    function Find (const aID : String ) : TJsonObject; overload;
    function Insert (const aJsonObject : TJsonObject) : TJsonObject;
    function Update (const aJsonObject : TJsonObject) : TJsonObject;
    function Delete (aField : String; aValue : String) : TJsonObject;
    function DAO : ISimpleDAO<T>;
    function DataSetAsJsonArray : TJsonArray;
    function DataSetAsJsonObject : TJsonObject;
    function DataSetToStream : String;
  end;

  TDAOGeneric<T : class, constructor> = class(TInterfacedObject, iDAOGeneric<T>)
  private
    FIndexConn : Integer;
    FConn : iSimpleQuery;
    FDAO : iSimpleDAO<T>;
    FDataSource : TDataSource;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iDAOGeneric<T>;
    function Find : TJsonArray; overload;
    function Find (const aID : String ) : TJsonObject; overload;
    function Insert (const aJsonObject : TJsonObject) : TJsonObject;
    function Update (const aJsonObject : TJsonObject) : TJsonObject;
    function Delete (aField : String; aValue : String) : TJsonObject;
    function DAO : ISimpleDAO<T>;
    function DataSetAsJsonArray : TJsonArray;
    function DataSetAsJsonObject : TJsonObject;
    function DataSetToStream : String;
  end;

implementation

{ TDAOGeneric<T> }

uses
  System.SysUtils,
  System.Classes,
  GBJSON.Helper,
  GBJSON.Interfaces;

constructor TDAOGeneric<T>.Create;
begin
  FDataSource := TDataSource.Create(nil);
  FIndexConn := backend.Model.Connection.Connected;
  FConn := TSimpleQueryFiredac.New(backend.Model.Connection.FConnList.Items[FIndexConn]);
  FDAO := TSimpleDAO<T>.New(FConn).DataSource(FDataSource);
end;

function TDAOGeneric<T>.DAO: ISimpleDAO<T>;
begin
  Result := FDAO;
end;

function TDAOGeneric<T>.DataSetAsJsonArray: TJsonArray;
begin
  Result := FDataSource.DataSet.ToJSONArray;
end;

function TDAOGeneric<T>.DataSetAsJsonObject: TJsonObject;
begin
  Result := FDataSource.DataSet.ToJSONObject;
end;

function TDAOGeneric<T>.DataSetToStream: String;
var
  lStream : TStringStream;
  FDMemTable : TFDMemTable;
begin
  lStream := TStringStream.Create;
  FDMemTable := TFDMemTable.Create(nil);
  try
    FDMemTable.Assign(FDataSource.DataSet);
    FDMemTable.SaveToStream(lStream, sfJSON);
    lStream.Position := 0;
    Result := lStream.DataString;
  finally
    lStream.Free;
    FDMemTable.Free;
  end;

end;

function TDAOGeneric<T>.Delete(aField, aValue: String): TJsonObject;
begin
  FDAO.Delete(aField, aValue);
  Result := FDataSource.DataSet.ToJSONObject;
end;

destructor TDAOGeneric<T>.Destroy;
begin
  FDataSource.Free;
  backend.Model.Connection.Disconnected(FIndexConn);
  inherited;
end;

function TDAOGeneric<T>.Find(const aID: String): TJsonObject;
begin
  FDAO.Find(StrToInt(aID));
  Result := FDataSource.DataSet.ToJSONObject;
end;

function TDAOGeneric<T>.Find: TJsonArray;
var
  ateste: Integer;
  ateste2: string;
begin
  FDAO.Find(False);
  Result := FDataSource.DataSet.ToJSONArray;
end;

class function TDAOGeneric<T>.New: iDAOGeneric<T>;
begin
  Result := Self.Create;
end;

function TDAOGeneric<T>.Insert(const aJsonObject: TJsonObject): TJsonObject;
var
  aObj : T;
begin
  aObj := T.Create;
  try
    TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
    TGBJSONDefault.Serializer<T>(False).JsonObjectToObject(aObj, aJsonObject);
    aObj.fromJSONObject(aJsonObject);
    FDAO.Insert(aObj);
    Result := FDataSource.DataSet.ToJSONObject;
  finally
    aObj.Free;
  end;
end;

function TDAOGeneric<T>.Update(const aJsonObject: TJsonObject): TJsonObject;
var
  aObj : T;
begin
  aObj := T.Create;
  try
    TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
    TGBJSONDefault.Serializer<T>(False).JsonObjectToObject(aObj, aJsonObject);
    aObj.fromJSONObject(aJsonObject);
    FDAO.Update(aObj);
    Result := FDataSource.DataSet.ToJSONObject;
  finally
    aObj.Free;
  end;
end;

end.
