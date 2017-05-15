--Student maj¹cy najmniejsz¹ kwotê na cz³onka rodziny
SELECT Indeks, Imie as "Imiê", Nazwisko, DochodNaCzlonkaRodziny
	FROM Studenci
	WHERE DochodNaCzlonkaRodziny IN
		(SELECT MIN(DochodNaCzlonkaRodziny)
			FROM Studenci);

--Studenci, którzy maj¹ najni¿sz¹ œredni¹ na uczelni
SELECT Studenci.Indeks, Imie as "Imiê", Nazwisko, Kierunek, Wydzia³, Srednia
	FROM Studenci, ProgramyStudiow
	WHERE ProgramyStudiow.Srednia IN
		(SELECT MIN(ProgramyStudiow.Srednia)
			FROM ProgramyStudiow);

--Wszystkie Osi¹gniêcia studenta o indeksie 160669 uporz¹dkowane rosn¹co wed³ug daty
SELECT Osiagniecia.Opis, Osiagniecia.DataOtrzymania
	FROM Osiagniecia
	WHERE Osiagniecia.StudentIndeks = '160669'
	ORDER BY DataOtrzymania ASC;

--£¹czna kwota wyp³acona konkretnego dnia
SELECT Wyplaty.DataWyplacenia as "Data wyp³aty", SUM(Wyplaty.Kwota) as "£¹czna kwota"
	FROM Wyplaty
	GROUP BY Wyplaty.DataWyplacenia;

--Utworzenie widoku, w którym znajduj¹ siê dane o studentach, którzy posiadaj¹ œredni¹ wy¿sz¹ ni¿ 4.0
--CREATE VIEW NajlepsiStudenci
--	AS SELECT Studenci.Imie, Studenci.Nazwisko, Studenci.Indeks, ProgramyStudiow.Srednia, ProgramyStudiow.Kierunek
--		FROM Studenci, ProgramyStudiow
--		WHERE ProgramyStudiow.Srednia > 4.0 AND Studenci.Indeks = ProgramyStudiow.Indeks

SELECT DISTINCT * 
	FROM NajlepsiStudenci;

--Numer konta, ³¹czna kwota wp³aty oraz nazwa funduszu, który wp³aci³ najwiêksz¹ sumê na rzecz stynepdiów.
SELECT TOP 1 Wyplaty.NumerKonta, SUM(Wyplaty.Kwota) as "£¹czna kwota", Fundusze.Nazwa as "Nazwa Funduszu"
	FROM Wyplaty, Fundusze
	WHERE Fundusze.NumerKonta = Wyplaty.NumerKonta
	GROUP BY Wyplaty.NumerKonta, Fundusze.Nazwa
	ORDER BY 2 DESC;

--SELECT TOP 1 Wyplaty.NumerKonta, SUM(Wyplaty.Kwota) as "£¹czna kwota", Fundusze.Nazwa as "Nazwa Funduszu"
	--FROM Wyplaty JOIN Fundusze ON  Fundusze.NumerKonta = Wyplaty.NumerKonta
	--GROUP BY Wyplaty.NumerKonta, Fundusze.Nazwa
	--ORDER BY 2 DESC;

--Dane studentów, którym przyznano stypendium, wraz z jego rodzajem oraz rokiem akademicki, za który zosta³o przyznane.
SELECT DISTINCT Studenci.Imie as "Imiê", Studenci.Nazwisko, Studenci.Indeks, Stypendia.RodzajStypendium as "Rodzaj stypendium",
		Stypendia.RokAkademicki
	FROM Studenci, Stypendia, Wnioski
	WHERE Wnioski.CzyPrzyznano = 'Przyznano' AND Wnioski.IDStypendium = Stypendia.IDStypendium
		 AND Studenci.Indeks = Wnioski.Indeks;

--Informacje o studentach wraz z ³¹czna kwoat¹ jak¹ uzyskali na rzecz stypendium
SELECT Studenci.Imie, Studenci.Nazwisko, Studenci.Indeks, SUM(Wyplaty.Kwota) as "£¹czna uzyskana kwoata"
	FROM Wnioski, Studenci, Wyplaty
	WHERE Studenci.Indeks = Wnioski.Indeks AND Wnioski.IDWniosku = Wyplaty.IDWniosku
	GROUP BY Studenci.Imie, Studenci.Nazwisko, Studenci.Indeks
	ORDER BY 4 DESC;