--Student maj�cy najmniejsz� kwot� na cz�onka rodziny
SELECT Indeks, Imie as "Imi�", Nazwisko, DochodNaCzlonkaRodziny
	FROM Studenci
	WHERE DochodNaCzlonkaRodziny IN
		(SELECT MIN(DochodNaCzlonkaRodziny)
			FROM Studenci);

--Studenci, kt�rzy maj� najni�sz� �redni� na uczelni
SELECT Studenci.Indeks, Imie as "Imi�", Nazwisko, Kierunek, Wydzia�, Srednia
	FROM Studenci, ProgramyStudiow
	WHERE ProgramyStudiow.Srednia IN
		(SELECT MIN(ProgramyStudiow.Srednia)
			FROM ProgramyStudiow);

--Wszystkie Osi�gni�cia studenta o indeksie 160669 uporz�dkowane rosn�co wed�ug daty
SELECT Osiagniecia.Opis, Osiagniecia.DataOtrzymania
	FROM Osiagniecia
	WHERE Osiagniecia.StudentIndeks = '160669'
	ORDER BY DataOtrzymania ASC;

--��czna kwota wyp�acona konkretnego dnia
SELECT Wyplaty.DataWyplacenia as "Data wyp�aty", SUM(Wyplaty.Kwota) as "��czna kwota"
	FROM Wyplaty
	GROUP BY Wyplaty.DataWyplacenia;

--Utworzenie widoku, w kt�rym znajduj� si� dane o studentach, kt�rzy posiadaj� �redni� wy�sz� ni� 4.0
--CREATE VIEW NajlepsiStudenci
--	AS SELECT Studenci.Imie, Studenci.Nazwisko, Studenci.Indeks, ProgramyStudiow.Srednia, ProgramyStudiow.Kierunek
--		FROM Studenci, ProgramyStudiow
--		WHERE ProgramyStudiow.Srednia > 4.0 AND Studenci.Indeks = ProgramyStudiow.Indeks

SELECT DISTINCT * 
	FROM NajlepsiStudenci;

--Numer konta, ��czna kwota wp�aty oraz nazwa funduszu, kt�ry wp�aci� najwi�ksz� sum� na rzecz stynepdi�w.
SELECT TOP 1 Wyplaty.NumerKonta, SUM(Wyplaty.Kwota) as "��czna kwota", Fundusze.Nazwa as "Nazwa Funduszu"
	FROM Wyplaty, Fundusze
	WHERE Fundusze.NumerKonta = Wyplaty.NumerKonta
	GROUP BY Wyplaty.NumerKonta, Fundusze.Nazwa
	ORDER BY 2 DESC;

--SELECT TOP 1 Wyplaty.NumerKonta, SUM(Wyplaty.Kwota) as "��czna kwota", Fundusze.Nazwa as "Nazwa Funduszu"
	--FROM Wyplaty JOIN Fundusze ON  Fundusze.NumerKonta = Wyplaty.NumerKonta
	--GROUP BY Wyplaty.NumerKonta, Fundusze.Nazwa
	--ORDER BY 2 DESC;

--Dane student�w, kt�rym przyznano stypendium, wraz z jego rodzajem oraz rokiem akademicki, za kt�ry zosta�o przyznane.
SELECT DISTINCT Studenci.Imie as "Imi�", Studenci.Nazwisko, Studenci.Indeks, Stypendia.RodzajStypendium as "Rodzaj stypendium",
		Stypendia.RokAkademicki
	FROM Studenci, Stypendia, Wnioski
	WHERE Wnioski.CzyPrzyznano = 'Przyznano' AND Wnioski.IDStypendium = Stypendia.IDStypendium
		 AND Studenci.Indeks = Wnioski.Indeks;

--Informacje o studentach wraz z ��czna kwoat� jak� uzyskali na rzecz stypendium
SELECT Studenci.Imie, Studenci.Nazwisko, Studenci.Indeks, SUM(Wyplaty.Kwota) as "��czna uzyskana kwoata"
	FROM Wnioski, Studenci, Wyplaty
	WHERE Studenci.Indeks = Wnioski.Indeks AND Wnioski.IDWniosku = Wyplaty.IDWniosku
	GROUP BY Studenci.Imie, Studenci.Nazwisko, Studenci.Indeks
	ORDER BY 4 DESC;