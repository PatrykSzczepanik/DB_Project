CREATE TABLE Studenci (
	Indeks INTEGER PRIMARY KEY NOT NULL,
	Imie VARCHAR(15) NOT NULL,
	Nazwisko VARCHAR(25) NOT NULL,
	Adres VARCHAR(140) NOT NULL,
	DochodNaCzlonkaRodziny DECIMAL(7,2) NOT NULL 
		CHECK ( DochodNaCzlonkaRodziny >= 0 ),
)

CREATE TABLE Osiagniecia (
	IDOsiagniecia INTEGER PRIMARY KEY NOT NULL,
	Typ VARCHAR(20) NOT NULL,
	Opis VARCHAR(300) NOT NULL,
	DataOtrzymania DATE NOT NULL,
	StudentIndeks INTEGER NOT NULL REFERENCES Studenci,
)

CREATE TABLE ProgramyStudiow (
	IDProgramuStudiow INTEGER PRIMARY KEY NOT NULL,
	Kierunek VARCHAR(40) NOT NULL, 
	Wydzia³ VARCHAR(5) NOT NULL,
	Semestr TINYINT NOT NULL   
		CHECK ( Semestr > 0 AND Semestr <= 10),
	Srednia DECIMAL(3,2) NOT NULL
		CHECK ( Srednia >= 2.0 AND Srednia <= 5.5 ),		
	Indeks INTEGER NOT NULL REFERENCES Studenci,
)

CREATE TABLE Fundatorzy (
	IDFundatora INTEGER PRIMARY KEY NOT NULL,
	Nazwa VARCHAR(40) NOT NULL,
	Adres VARCHAR(120) NOT NULL,
)

CREATE TABLE Stypendia (
	IDStypendium INTEGER PRIMARY KEY NOT NULL,
	OdKiedy DATE NOT NULL,
	NaIleMiesiecy TINYINT NOT NULL
		CHECK ( NaIleMiesiecy > 0 ),
	RokAkademicki CHAR(9) NOT NULL
		CHECK ( RokAkademicki like '2[0-9][0-9][0-9]/2[0-9][0-9][0-9]' ),
	RodzajStypendium VARCHAR(20) NOT NULL,
	Wydzial VARCHAR(5) NOT NULL,
	IDFundatora INTEGER NOT NULL REFERENCES Fundatorzy,
)

CREATE TABLE Kryteria (
	IDKryteriow INTEGER PRIMARY KEY NOT NULL,
	SredniaOd DECIMAL(3,2) NOT NULL
		CHECK ( SredniaOd >= 2.0 AND SredniaOd <= 5.5 ),
	SredniaDo DECIMAL(3,2) NOT NULL
		CHECK (SredniaDo >= 2.0 AND SredniaDO <= 5.5 ),
	Kwota Decimal(7,2) NOT NULL,
	MinimalnyDochod DECIMAL(7,2) NOT NULL,
	MaksymalnyDochod DECIMAL(7,2) NOT NULL,
	IDStypendium INTEGER NOT NULL REFERENCES Stypendia,
)

CREATE TABLE Wnioski (
	IDWniosku INTEGER PRIMARY KEY NOT NULL,
	CzyPrzyznano VARCHAR(13) NOT NULL
		CHECK (CzyPrzyznano in ('Przyznano', 'Nie przyznano')),
	DataZlozenia DATE 
		DEFAULT GETDATE(),
	NumerKonta CHAR(26) NOT NULL,
	IDStypendium INTEGER NOT NULL REFERENCES Stypendia,
	Indeks INTEGER NOT NULL REFERENCES Studenci,
)

CREATE TABLE Ksiegowi (
	IDKsiegowego INTEGER PRIMARY KEY NOT NULL,
	Imie VARCHAR(15) NOT NULL,
	Nazwisko VARCHAR(25) NOT NULL,
)

CREATE TABLE Fundusze (
	NumerKonta CHAR(26) PRIMARY KEY NOT NULL,
	Nazwa VARCHAR(50) NOT NULL,
)

CREATE TABLE Wyplaty (
	IDWyplaty INTEGER PRIMARY KEY NOT NULL,
	DataWyplacenia DATE NOT NULL,
	Kwota DECIMAL(7,2) NOT NULL,
	IDWniosku INTEGER NOT NULL REFERENCES Wnioski,
	IDKsiegowego INTEGER NOT NULL REFERENCES Ksiegowi,
	NumerKonta CHAR(26) NOT NULL REFERENCES Fundusze,
)

