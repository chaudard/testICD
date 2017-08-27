unit ICDrecord;

interface

type TICDRecord = class
  private
    FId: integer;
    FCodeICD10: string;
    FFrDescription: string;
    FNlDescription: string;
  published
    property id: integer read FId write FId;
    property codeICD10: string read FCodeICD10 write FCodeICD10;
    property frDescription: string read FFrDescription write FFrDescription;
    property nlDescription: string read FNlDescription write FNlDescription;
  public
    constructor Create; overload;
    constructor Create(const aCodeICD10: string;
                       const aFrDescription: string;
                       const aNlDescription: string); overload;
    destructor Destroy; override;
end;

implementation

{ TICDRecord }

constructor TICDRecord.Create;
begin
  codeICD10 := '';
  frDescription := '';
  nlDescription := '';
end;

constructor TICDRecord.Create(const aCodeICD10, aFrDescription,
  aNlDescription: string);
begin
  codeICD10 := aCodeICD10;
  frDescription := aFrDescription;
  nlDescription := aNlDescription;
end;

destructor TICDRecord.Destroy;
begin
  //
  inherited;
end;

end.
