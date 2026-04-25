CREATE DATABASE sustav_za_upravljanje_restoranom;
USE sustav_za_upravljanje_restoranom;

CREATE TABLE Zaposlenik (
	id INT,
    ime VARCHAR(30),
    prezime VARCHAR(50),
    datum_zaposlenja VARCHAR(10),
    pozicija_zaposlenika VARCHAR(50),
    placa_zaposlenika DECIMAL(6, 2)
);

CREATE TABLE Stol (
	id INT,
    broj_stola INT,
    kapacitet_stola INT,
    trenutna_zauzetost_stola BOOL
);

CREATE TABLE Jelo (
	id INT,
    naziv_jela VARCHAR(50),
    cijena_jela DECIMAL(5, 2),
    Trosak_pripravka_jela DECIMAL(5, 2)
);

CREATE TABLE Jelovnik (
	id INT,
    Jelo_id INT,
    naziv_kategorije VARCHAR(40)
);

CREATE TABLE Narudzbe (
	id INT,
    vrijeme_narudzbe VARCHAR(17),
    Stol_id INT,
    Zaposlenik_id INT
);

CREATE TABLE Stavka_Narudzbe (
	id INT,
    Narudzbe_id INT,
    Jelo_ID INT,
    kolicina INT
);

CREATE TABLE placanje (
	id INT,
    Narudzbe_id INT,
    iznos DECIMAL(5, 2),
    nacin_placanja VARCHAR(50)
);

create table Specijalna_ponuda (
	id INT,
    Jelo_id INT,
    ponuden_popust DECIMAL(5, 2),
    pridodana_svojstva VARCHAR(40)
);

CREATE TABLE VIP_gosti (
	id INT,
    mjesecni_popust VARCHAR(3),
    Specijalna_ponuda_id INT
);

CREATE TABLE Kupac (
	id INT,
    ime VARCHAR(30),
    prezime VARCHAR(50),
    VIP_gosti_ID INT
);

CREATE TABLE Rezervacije (
	id INT,
    Stol_id INT,
    vrijeme_rezervacije VARCHAR(17),
    Kupac_id INT
);

CREATE TABLE Dostava (
	id INT,
    Kupac_id int,
    Zaposlenik_id INT,
    placanje_id INT,
    vrijeme_dostave VARCHAR(17)
);

CREATE TABLE Racuni_prihodi (
	id INT,
    iznos_racuna DECIMAL(6,2),
    vrijeme_izdavanja_racuna VARCHAR(17),
    status_racuna VARCHAR(20),
    Placanje_id INT
);

CREATE TABLE Racuni_rashodi (
	id INT,
    vrsta_rashoda VARCHAR(50),
    vrijeme_izdavanja_racuna VARCHAR(17),
    iznos DECIMAL(6,2),
    status_racuna VARCHAR(20)
);

CREATE TABLE Resursi (
	id INT,
    naziv VARCHAR(50),
    kolicina_resursa INT,
    vrijednost_resursa DECIMAL(6, 2)
);

CREATE TABLE Obracun_prihoda_i_rashoda (
	id INT,
    Racuni_prihodi_id INT,
    Racuni_rashodi_id INT,
    konacni_iznos DECIMAL(6,2)
);