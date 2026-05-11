DROP DATABASE IF EXISTS sustav_za_upravljanje_restoranom;
CREATE DATABASE sustav_za_upravljanje_restoranom;
USE sustav_za_upravljanje_restoranom;
-- ---Korado Brajuha----------------------------
CREATE TABLE Zaposlenik (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    ime VARCHAR(30) NOT NULL,
    prezime VARCHAR(50) NOT NULL,
    datum_zaposlenja DATE NOT NULL,
    pozicija_zaposlenika VARCHAR(50) NOT NULL,
    placa_zaposlenika DECIMAL(6, 2) NOT NULL
);

CREATE TABLE Stol (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    broj_stola INT NOT NULL UNIQUE,
    kapacitet_stola INT NOT NULL,
    trenutna_zauzetost_stola BOOL NOT NULL
);

CREATE TABLE Jelovnik (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    naziv_kategorije VARCHAR(40) NOT NULL
);

CREATE TABLE Jelo (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    naziv_jela VARCHAR(50) NOT NULL UNIQUE,
    cijena_jela DECIMAL(5, 2) NOT NULL,
    Trosak_pripravka_jela DECIMAL(5, 2) NOT NULL,
    Jelovnik_id INTEGER NOT NULL,
    FOREIGN KEY (Jelovnik_id) REFERENCES Jelovnik (id)
);

create table Specijalna_ponuda (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    Jelo_id INTEGER NOT NULL,
    FOREIGN KEY (Jelo_id) REFERENCES Jelo (id),
    ponuden_popust DECIMAL(5, 2) NOT NULL,
    pridodana_svojstva VARCHAR(40) NOT NULL
);
-- ---Antonio Đusti----------------------------
CREATE TABLE VIP_gosti (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    mjesecni_popust DECIMAL(4, 2) NOT NULL,
    Specijalna_ponuda_id INTEGER NOT NULL,
    FOREIGN KEY (Specijalna_ponuda_id) REFERENCES Specijalna_ponuda (id)
);

CREATE TABLE Kupac (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    ime VARCHAR(30) NOT NULL,
    prezime VARCHAR(50) NOT NULL,
    VIP_gosti_id INTEGER NULL,
    FOREIGN KEY (VIP_gosti_id) REFERENCES VIP_gosti (id)
);

CREATE TABLE Rezervacije (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    Stol_id INTEGER NOT NULL,
    FOREIGN KEY (Stol_id) REFERENCES Stol (id),
    vrijeme_rezervacije DATETIME NOT NULL,
    Kupac_id INTEGER NOT NULL,
    FOREIGN KEY (Kupac_id) REFERENCES Kupac (id)
);
-- ---Ivor Jusufović----------------------------
CREATE TABLE Narudzbe (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    vrijeme_narudzbe DATETIME NOT NULL,
    Stol_id INTEGER NOT NULL,
    FOREIGN KEY (Stol_id) REFERENCES Stol (id),
    Rezervacije_id INTEGER NULL,
    FOREIGN KEY (Rezervacije_id) REFERENCES Rezervacije (id),
    Kupac_id INTEGER NOT NULL,
    FOREIGN KEY (Kupac_id) REFERENCES Kupac (id),
    Zaposlenik_id INTEGER NOT NULL,
    FOREIGN KEY (Zaposlenik_id) REFERENCES Zaposlenik (id)
);

CREATE TABLE Stavka_Narudzbe (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    Narudzbe_id INTEGER NOT NULL,
    FOREIGN KEY (Narudzbe_id) REFERENCES Narudzbe (id),
    Jelo_id INTEGER NOT NULL,
    FOREIGN KEY (Jelo_id) REFERENCES Jelo (id),
    kolicina INTEGER NOT NULL
);

CREATE TABLE Placanje (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    Narudzbe_id INTEGER NOT NULL,
    FOREIGN KEY (Narudzbe_id) REFERENCES Narudzbe (id),
    iznos DECIMAL(7, 2) NOT NULL,
    nacin_placanja VARCHAR(50) NOT NULL
);
-- ---Antonio Đusti----------------------------
CREATE TABLE Dostava (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    Kupac_id INTEGER NOT NULL,
    FOREIGN KEY (Kupac_id) REFERENCES Kupac (id),
    Zaposlenik_id INTEGER NOT NULL,
    FOREIGN KEY (Zaposlenik_id) REFERENCES Zaposlenik (id),
    Narudzbe_id INTEGER  NOT NULL,
    FOREIGN KEY (Narudzbe_id) REFERENCES Narudzbe (id),
    vrijeme_dostave DATETIME NOT NULL
);
-- ---Ivor Jusufović----------------------------
CREATE TABLE Racuni_prihodi (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    iznos_racuna DECIMAL(7,2) NOT NULL,
    vrijeme_izdavanja_racuna DATETIME NOT NULL,
    status_racuna VARCHAR(20) NOT NULL,
    Placanje_id INTEGER NOT NULL,
    FOREIGN KEY (Placanje_id) REFERENCES Placanje (id)
);
-- ---Alex Mihatović----------------------------
CREATE TABLE Resursi (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(50) NOT NULL,
    kolicina_resursa INT NOT NULL,
    vrijednost_resursa DECIMAL(6, 2) NOT NULL
);

CREATE TABLE Nabava_resursi (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    Resursi_id INTEGER NOT NULL,
    FOREIGN KEY (Resursi_id) REFERENCES Resursi (id),
    cijena DECIMAL(6, 2) NOT NULL,
    kolicina INTEGER NOT NULL,
    datum_nabave DATE NOT NULL
);

CREATE TABLE Racuni_rashodi (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    vrsta_rashoda VARCHAR(50) NOT NULL,
    vrijeme_izdavanja_racuna DATETIME NOT NULL,
    Nabava_resursi_id INTEGER NOT NULL,
    FOREIGN KEY (Nabava_resursi_id) REFERENCES Nabava_resursi (id),
    iznos DECIMAL(6,2) NOT NULL,
    status_racuna VARCHAR(20) NOT NULL
);

CREATE TABLE Obracun_prihoda_i_rashoda (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    Racuni_prihodi_id INTEGER NOT NULL,
    FOREIGN KEY (Racuni_prihodi_id) REFERENCES Racuni_prihodi (id),
    Racuni_rashodi_id INTEGER NOT NULL,
    FOREIGN KEY (Racuni_rashodi_id) REFERENCES Racuni_rashodi (id),
    konacni_iznos DECIMAL(6,2) NOT NULL
);
-- ---Korado Brajuha----------------------------
CREATE TABLE Bilanca (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
	Obracun_prihoda_i_rashoda_id INTEGER NOT NULL,
    FOREIGN KEY (Obracun_prihoda_i_rashoda_id) REFERENCES Obracun_prihoda_i_rashoda (ID),
	Resursi_id INTEGER NOT NULL,
    FOREIGN KEY (Resursi_id) REFERENCES Resursi (id),
    stanje_prije DECIMAL(8,2) NOT NULL,
    stanje_poslije DECIMAL(8,2) NOT NULL,
    datum_bilance DATE NOT NULL
);

-- ---Insertani podatci unutar tablica----------------------------
INSERT INTO Zaposlenik(ime, prezime, datum_zaposlenja, pozicija_zaposlenika, placa_zaposlenika) VALUES
    ('Ivan', 'Ivić', '2022-03-12', 'Glavni kuhar', 2250),
    ('Antun', 'Skočić', '2024-02-12', 'Pomoćni kuhar', 1500),
    ('Ana', 'Anić', '2025-05-21', 'Pomoćna kuharica', 1500),
    ('Karla', 'Ivić', '2025-03-12', 'Čistač', 1150),
    ('Romina', 'Lakić', '2025-07-12', 'Čistač', 1150),
    ('Loren', 'Listić', '2025-04-17', 'Konobar', 1200),
    ('Lorna', 'Ciklić', '2023-05-11', 'Konobar', 1200),
    ('Korina', 'Kristić', '2025-03-13', 'Konobar', 1200),
    ('Lorena', 'Lukić', '2026-02-01', 'Dostavljač', 1450),
    ('Lino', 'Kapulić', '2022-09-30', 'Dostavljač', 1450),
    ('David', 'Prstić', '2023-07-14', 'Dostavljač', 1450);

INSERT INTO Stol(broj_stola, kapacitet_stola, trenutna_zauzetost_stola) VALUES
	(1, 10, false),
    (2, 10, false),
    (3, 10, false),
    (4, 10, true),
    (5, 8, true),
    (6, 8, false),
    (7, 8, false),
    (8, 6, true),
    (9, 4, true),
    (10, 4, true);

INSERT INTO Jelovnik (naziv_kategorije) VALUES
	('Predjela'),
    ('Juhe'),
    ('Glavna jela'),
    ('Deserti'),
    ('Bezalkoholna pića'),
    ('Alkoholna pića');
    
INSERT INTO Jelo(naziv_jela, cijena_jela, Trosak_pripravka_jela, Jelovnik_id) VALUES
	('Juha od paradajza', 3.50, 1.50, 2),
    ('Goveđa juha', 4.50, 2.00, 2),
    ('Bruschette', 4.00, 2.00, 1),
    ('Pileća juha', 4.00, 1.75, 2),
    ('Tiramisu', 6.00, 2.50, 4),
    ('Cheese cake', 7.50, 3.00, 4),
    ('Coca Cola', 2.50, 0.50, 5),
    ('Crno Vino', 4.00, 1.50, 6),
    ('Jack Daniels', 5.00, 2.50, 6),
    ('Rum & Coke', 6.50, 3.00, 6),
    ('Tjestenina sa umakom od rajčice', 9.00, 4.00, 3),
    ('Rižoto s plodovima mora', 14.50, 6.00, 3),
    ('Rižoto s povrčem', 12.50, 5.00, 3),
    ('Pommes Fries', 6.00, 2.00, 1),
    ('Sladoledni kup', 7.00, 3.00, 4),
    ('Fanta', 3.00, 0.70, 5),
    ('Pašareta', 2.00, 0.75, 5),
    ('Palačinke', 7.50, 3.00, 4),
    ('Palenta sa tradicionalnim Istarskim šugom', 10.50, 3.75, 3),
    ('Lignja na žaru', 13.00, 6.75, 3),
    ('Meso na žaru', 12.75, 7.00, 3),
    ('Povrče na žaru', 9.00, 4.25, 3),
    ('Pastrva na žaru', 11.75, 5.50, 3),
    ('Čevapi u lepinji', 12.00, 6.50, 3),
    ('Pljeskavica u lepinji', 13.00, 6.75, 3),
    ('Punjena pljeskavica', 13.75, 7.00, 3),
    ('Mesna plata', 14.00, 7.50, 3),
    ('Riba na žaru', 11.25, 5.75, 3),
    ('Topla čokolada', 4.75, 1.20, 5),
    ('Bijela kava', 2.25, 1.00, 5),
    ('Espresso', 2.00, 0.75, 5),
    ('Machiatto', 2.10, 0.80, 5),
    ('Medica', 4.50, 2.00, 6);

INSERT INTO Specijalna_ponuda(Jelo_id, ponuden_popust, pridodana_svojstva)
	(1, 5, Kuhana riža),
	(5, 8, šumsko voće),
	(11, 5, Salata od rikule),
	(14, 10, Majoneza),
	(18, 15, Lješnjak),
	(20, 10, Blitva s krumpirom),
	(21, 8, Lepinja),
	(22, 12, Baguette),
	(23, 8, Kruh ispod peke),
	(24, 10, ajvar),
	(28, 15, Pogača s maslinovim uljem);

INSERT INTO VIP_gosti(mjesecni_popust, Specijalna_ponuda_id) 
