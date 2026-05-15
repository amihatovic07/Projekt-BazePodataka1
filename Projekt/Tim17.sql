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
    placa_zaposlenika DECIMAL(6, 2) NOT NULL CHECK (placa_zaposlenika > 1050)
);

CREATE TABLE Stol (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    broj_stola INTEGER NOT NULL UNIQUE CHECK (broj_stola > 0),
    kapacitet_stola INTEGER NOT NULL CHECK (kapacitet_stola > 2),
    trenutna_zauzetost_stola BOOL NOT NULL
);

CREATE TABLE Jelovnik (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    naziv_kategorije VARCHAR(40) NOT NULL
);

CREATE TABLE Jelo (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    naziv_jela VARCHAR(50) NOT NULL UNIQUE,
    cijena_jela DECIMAL(5, 2) NOT NULL CHECK (cijena_jela > 0),
    Trosak_pripravka_jela DECIMAL(5, 2) NOT NULL CHECK (Trosak_pripravka_jela > 0),
    Jelovnik_id INTEGER NOT NULL,
    FOREIGN KEY (Jelovnik_id) REFERENCES Jelovnik (id)
);

create table Specijalna_ponuda (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    Jelo_id INTEGER NOT NULL,
    FOREIGN KEY (Jelo_id) REFERENCES Jelo (id),
    ponuden_popust DECIMAL(5, 2) NOT NULL CHECK (ponuden_popust BETWEEN 0 AND 100),
    pridodana_svojstva VARCHAR(40) NOT NULL
);
-- ---Antonio Đusti----------------------------
CREATE TABLE VIP_gosti (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    mjesecni_popust DECIMAL(4, 2) NOT NULL CHECK (mjesecni_popust BETWEEN 0 AND 100),
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
    Stol_id INTEGER NULL,
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
    vrijeme_izdavanja_racuna DATETIME NOT NULL,
    status_racuna VARCHAR(20) NOT NULL,
    Placanje_id INTEGER NOT NULL,
    FOREIGN KEY (Placanje_id) REFERENCES Placanje (id)
);
-- ---Alex Mihatović----------------------------
CREATE TABLE Resursi (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(50) NOT NULL,
    kolicina_resursa INT NOT NULL CHECK (kolicina_resursa >= 0),
    vrijednost_resursa DECIMAL(6, 2) NOT NULL CHECK (vrijednost_resursa >= 0),
    kategorija VARCHAR(30) NOT NULL
);

CREATE TABLE Nabava_resursi (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    Resursi_id INTEGER NOT NULL,
    FOREIGN KEY (Resursi_id) REFERENCES Resursi (id),
    cijena DECIMAL(6, 2) NOT NULL CHECK (cijena > 0),
    kolicina INTEGER NOT NULL CHECK (kolicina > 0),
    datum_nabave DATE NOT NULL
);

CREATE TABLE Racuni_rashodi (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    vrsta_rashoda VARCHAR(50) NOT NULL,
    vrijeme_izdavanja_racuna DATETIME NOT NULL,
    Nabava_resursi_id INTEGER NOT NULL,
    FOREIGN KEY (Nabava_resursi_id) REFERENCES Nabava_resursi (id),
    iznos DECIMAL(6,2) NOT NULL CHECK (iznos > 0),
    status_racuna VARCHAR(20) NOT NULL
);

CREATE TABLE Obracun_prihoda_i_rashoda (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    Racuni_prihodi_id INTEGER NOT NULL,
    FOREIGN KEY (Racuni_prihodi_id) REFERENCES Racuni_prihodi (id),
    Racuni_rashodi_id INTEGER NOT NULL,
    FOREIGN KEY (Racuni_rashodi_id) REFERENCES Racuni_rashodi (id)
);
-- ---Korado Brajuha----------------------------
CREATE TABLE Bilanca (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
	Obracun_prihoda_i_rashoda_id INTEGER NOT NULL,
    FOREIGN KEY (Obracun_prihoda_i_rashoda_id) REFERENCES Obracun_prihoda_i_rashoda (id),
	Resursi_id INTEGER NOT NULL,
    FOREIGN KEY (Resursi_id) REFERENCES Resursi (id),
    stanje_prije DECIMAL(8,2) NOT NULL CHECK (stanje_prije >= 0),
    stanje_poslije DECIMAL(8,2) NOT NULL CHECK (stanje_poslije >= 0),
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

INSERT INTO Specijalna_ponuda(Jelo_id, ponuden_popust, pridodana_svojstva) VALUES
	(1, 5, 'Kuhana riža'),
	(5, 8, 'Šumsko voće'),
	(11, 5, 'Salata od rikule'),
	(14, 10, 'Majoneza'),
	(18, 15, 'Lješnjak'),
	(20, 10, 'Blitva s krumpirom'),
	(21, 8, 'Lepinja'),
	(22, 12, 'Baguette'),
	(23, 8, 'Kruh ispod peke'),
	(24, 10, 'Ajvar'),
	(28, 15, 'Pogača s maslinovim uljem');

INSERT INTO VIP_gosti(mjesecni_popust, Specijalna_ponuda_id) VALUES
	(5, 1),
	(10, 5),
	(15, 6),
	(20, 11);

INSERT INTO Kupac(ime, prezime, VIP_gosti_id) VALUES
	('Lovro', 'Lovrić', NULL),
	('Laura', 'Lingaši', 1),
	('Gabrijel', 'Paghrasi', 3),
	('Ludovico', 'Trastelighio', 4),
	('Ante', 'Lukaši', NULL),
	('Leotro', 'Suleiman', 3),
	('Paolo', 'Rakšin', NULL),
	('Ivan', 'Ivanišić', 2),
	('Petra', 'Petrić', NULL),
	('Roberta', 'Redak', 4);

INSERT INTO Rezervacije (Stol_id, vrijeme_rezervacije, Kupac_id) VALUES
	(4, '2026-03-12 11:45:00', 2),
	(5, '2026-01-21 12:30:00', 3),
	(8, '2026-04-11 11:00:00', 4),
	(9, '2026-05-14 11:30:00', 1),
	(10, '2026-05-13 11:15:00', 10),
	(3, '2026-05-24 12:30:00', 6);

INSERT INTO Narudzbe(vrijeme_narudzbe, Stol_id, Rezervacije_id, Kupac_id, Zaposlenik_id) VALUES
	('2026-03-12 11:42:11', 4, 1, 2, 7),
	('2026-01-21 12:38:13', 5, 2, 3, 6),
	('2026-04-11 11:00:23', 8, 3, 4, 8),
	('2026-05-14 11:32:01', 9, 4, 1, 7),
	('2026-05-13 11:16:54', 10, 5, 10, 8),
	('2026-05-24 12:38:48', 3, 6, 6, 8),
	('2026-03-12 11:47:37', NULL, NULL, 1, 9),
	('2026-05-12 16:33:41', NULL, NULL, 7, 9),
	('2026-12-12 13:30:29', NULL, NULL, 9, 11);

INSERT INTO Stavka_Narudzbe (Narudzbe_id, Jelo_id, kolicina) VALUES
	(1, 2, 3),
	(1, 1, 1),
	(1, 19, 3),
	(1, 20, 4),
	(1, 18, 4),
	(1, 7, 2),
	(1, 8, 5),
	(1, 9, 2),
	(2, 3, 2),
	(2, 2, 2),
	(2, 1, 3),
	(2, 19, 4),
	(2, 27, 3),
	(2, 28, 3),
	(3, 5, 3),
	(3, 6, 4),
	(3, 7, 3),
	(4, 19, 5),
	(4, 18, 4),
	(4, 17, 6),
	(4, 16, 4),
	(4, 7, 2),
	(5, 20, 6),
	(5, 21, 5),
	(5, 7, 4),
	(5, 8, 3),
	(6, 11, 2),
	(6, 12, 3),
	(6, 13, 1),
	(6, 28, 1),
	(6, 8, 3),
	(6, 7, 1),
	(7, 13, 2),
	(7, 7, 1),
	(7, 14, 2),
	(8, 20, 3),
	(8, 5, 2),
	(8, 18, 3),
	(8, 17, 4),
	(9, 27, 2),
	(9, 6, 4);
    
INSERT INTO Placanje(Narudzbe_id, nacin_placanja) VALUES
	(1, 'Gotovina'),
    (2, 'Kartica'),
    (3, 'Kartica'),
    (4, 'Gotovina'),
    (5, 'Kartica'),
    (6, 'Gotovina'),
    (7, 'Gotovina'),
    (8, 'Kartica'),
    (9, 'Gotovina');

INSERT INTO Dostava(Kupac_id, Zaposlenik_id, Narudzbe_id, vrijeme_dostave) values
	(1, 9, 7, '2026-03-12 12:00:34'),
    (7, 9, 8, '2026-05-12 16:52:15'),
    (9, 11, 9, '2026-12-12 13:45:53');
    
INSERT INTO Racuni_prihodi(vrijeme_izdavanja_racuna, status_racuna, Placanje_id) VALUES
	('2026-03-12 13:33:31', 'U obradi', 1),
    ('2026-01-21 14:21:29', 'Izvršeno', 2),
    ('2026-04-11 12:49:13', 'U obradi', 3),
    ('2026-05-14 13:02:11', 'Izvršeno', 4),
    ('2026-05-13 15:00:10', 'Izvršeno', 5),
    ('2026-05-24 14:42:36', 'Izvršeno', 6),
    ('2026-03-12 12:00:34', 'U obradi', 7),
    ('2026-05-12 16:52:15', 'U obradi', 8),
    ('2026-12-12 13:45:53', 'Izvršeno', 9);
    
INSERT INTO Resursi(naziv, kolicina_resursa, vrijednost_resursa, kategorija) VALUES
	('Govedina', 500, 5000.00, 'Skladište'),
    ('Piletina', 375, 2975.00, 'Skladište'),
    ('Junetina', 425, 4775.50, 'Skladište'),
    ('Pastrva', 350, 5250.00, 'Skladište'),
    ('Lignje', 400, 3000.00, 'Skladište'),
    ('Sladoled vanilija', 200, 1200.00, 'Namirnice'),
    ('Sladoled čokolada', 200, 1250.00, 'Namirnice'),
    ('Sladoled sa okusom voća', 400, 2000.00, 'Namirnice'),
    ('Dodatci za deserte', 500, 1750.00, 'Namirnice'),
    ('Kuhaće', 65, 125.00, 'Kuhinjska oprema'),
    ('Krpe', 125, 335.00, 'Kuhinjska oprema'),
    ('Mikser', 4, 240.00, 'Kuhinjska aparatura'),
    ('Drobilica za kavu', 2, 80.00, 'Kuhinjska oprema'),
    ('Indukcijska ploča', 4, 850.00, 'Kuhinjska aparatura'),
    ('Hladnjak', 8, 2500.00, 'Kuhinjska aparatura'),
    ('Uniforma za konobara', 8, 700.00, 'Radne uniforme'),
    ('Uniforma za kuhara', 6, 675.00, 'Radne uniforme'),
    ('Uniforma za Dostavljaća', 8, 525.00, 'Radne uniforme'),
    ('Uniforma za Čistaća', 8, 575.00, 'Radne uniforme'),
    ('Iznajmljena dostavna vozila', 3, 1200.00, 'Dostavna vozila'),
    ('Stol', 12, 3000.00, 'Restoranski namještaj'),
    ('Stolice', 100, 2425.00, 'Restoranski namještaj'),
    ('Dekoracije', 30, 750.00, 'Restoranski namještaj'),
    ('Noževi', 200, 300.00, 'Pribor za jelo'),
    ('Vilice', 200, 250.00, 'Pribor za jelo'),
    ('Tanjuri', 200, 425.00, 'Pribor za jelo'),
    ('Žlice', 200, 325.00, 'Pribor za jelo'),
    ('Vinske čaše', 175, 650.00, 'Pribor za jelo'),
    ('Čaše', 225, 575.00, 'Pribor za jelo'),
    ('Coca Cola', 200, 250.50, 'Namirnice'),
    ('Fanta', 225, 230.75, 'Namirnice'),
    ('Jack Daniels', 50, 600.00, 'Namirnice'),
    ('Riža', 500, 1250.00, 'Namirnice'),
    ('Rum', 45, 750.00, 'Namirnice'),
    ('Brašno', 250, 750.00, 'Namirnice'),
    ('Kvasac', 175, 1000.00, 'Namirnice'),
    ('Crno vino', 75, 1750.00, 'Namirnice'),
    ('Suncokretovo ulje', 125, 1750.00, 'Namirnice'),
    ('Maslinovo ulje', 45, 750.00, 'Namirnice'),
    ('Kava u zrnu', 200, 1000, 'Namirnice');
    
INSERT INTO Nabava_resursi(Resursi_id, cijena, kolicina, datum_nabave) VALUES
    (1, 4500.00, 450, '2026-01-15'),
    (2, 2500.00, 300, '2026-01-15'),
    (3, 4200.00, 400, '2026-01-20'),
    (4, 4800.00, 320, '2026-02-01'),
    (5, 2800.00, 380, '2026-02-01'),
    (6, 1100.00, 180, '2026-02-10'),
    (31, 220.00, 180, '2026-02-10'),
    (32, 200.00, 200, '2026-02-15'),
    (33, 550.00, 45, '2026-02-15'),
    (34, 1100.00, 450, '2026-03-01'),
    (35, 680.00, 40, '2026-03-01'),
    (36, 1600.00, 70, '2026-03-10'),
    (38, 680.00, 40, '2026-03-10'),
    (39, 900.00, 180, '2026-03-15'),
    (14, 800.00, 4, '2026-04-01'); 
    
INSERT INTO Racuni_rashodi(vrsta_rashoda, vrijeme_izdavanja_racuna, Nabava_resursi_id, iznos, status_racuna) VALUES
    ('Nabava mesa', '2026-01-15 09:00:00', 1, 4500.00, 'Izvršeno'),
    ('Nabava mesa', '2026-01-15 09:00:00', 2, 2500.00, 'Izvršeno'),
    ('Nabava mesa', '2026-01-20 10:00:00', 3, 4200.00, 'Izvršeno'),
    ('Nabava ribe', '2026-02-01 08:30:00', 4, 4800.00, 'Izvršeno'),
    ('Nabava ribe', '2026-02-01 08:30:00', 5, 2800.00, 'Izvršeno'),
    ('Nabava namirnica', '2026-02-10 11:00:00', 6, 1100.00, 'Izvršeno'),
    ('Nabava pića', '2026-02-10 11:00:00', 7, 220.00, 'Izvršeno'),
    ('Nabava pića', '2026-02-15 10:30:00', 8, 200.00, 'Izvršeno'),
    ('Nabava pića', '2026-02-15 10:30:00', 9, 550.00, 'Izvršeno'),
    ('Nabava namirnica', '2026-03-01 09:00:00', 10, 1100.00, 'Izvršeno'),
    ('Nabava namirnica', '2026-03-01 09:00:00', 11, 680.00, 'Izvršeno'),
    ('Nabava pića', '2026-03-10 11:00:00', 12, 1600.00, 'Izvršeno'),
    ('Nabava namirnica', '2026-03-10 11:00:00', 13, 680.00, 'Izvršeno'),
    ('Nabava namirnica', '2026-03-15 08:00:00', 14, 900.00, 'Izvršeno'),
    ('Nabava aparature', '2026-04-01 14:00:00', 15, 800.00, 'Izvršeno');
    
INSERT INTO Obracun_prihoda_i_rashoda(Racuni_prihodi_id, Racuni_rashodi_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9);
    
INSERT INTO Bilanca(Obracun_prihoda_i_rashoda_id, Resursi_id, stanje_prije, stanje_poslije, datum_bilance) VALUES
    (1, 1, 50000.00, 45500.00, '2026-01-15'),
    (2, 2, 45500.00, 43000.00, '2026-01-15'),
    (3, 3, 43000.00, 38800.00, '2026-01-20'),
    (4, 4, 38800.00, 34000.00, '2026-02-01'),
    (5, 5, 34000.00, 31200.00, '2026-02-01'),
    (6, 6, 31200.00, 30100.00, '2026-02-10'),
    (7, 7, 30100.00, 29880.00, '2026-02-10'),
    (8, 8, 29880.00, 29680.00, '2026-02-15'),
    (9, 9, 29680.00, 29130.00, '2026-02-15');

-- ---Upiti---------------------------- 

-- --Ivor Jusufović-----
-- -upit 1 ----
-- -Lista kupaca bez dostave za narudžbe prije određenog datuma---
SELECT 
    Kupac.id,
    Kupac.ime,
    Kupac.prezime
FROM Kupac
INNER JOIN Narudzbe
    ON Kupac.id = Narudzbe.Kupac_id
INNER JOIN Placanje
    ON Narudzbe.id = Placanje.Narudzbe_id
WHERE Narudzbe.vrijeme_narudzbe < '2026-05-01'
HAVING Kupac.id NOT IN (
    SELECT Kupac_id 
    FROM Dostava
);
-- -upit 2 ----
-- -Filtriranje narudžbi po zaposleniku i datumu---
SELECT 
    Zaposlenik.id,
    Zaposlenik.ime,
    Zaposlenik.prezime,
    Narudzbe.id AS narudzba_id
FROM Zaposlenik
INNER JOIN Narudzbe
    ON Zaposlenik.id = Narudzbe.Zaposlenik_id
WHERE Zaposlenik.pozicija_zaposlenika = 'Konobar'
AND Narudzbe.vrijeme_narudzbe > '2026-03-01';
-- -upit 3----
-- -Narudžbe s ukupnom količinom artikala većom od 10---
SELECT 
    Narudzbe.id,
    SUM(Stavka_Narudzbe.kolicina) AS ukupna_kolicina
FROM Narudzbe
INNER JOIN Stavka_Narudzbe
    ON Narudzbe.id = Stavka_Narudzbe.Narudzbe_id
GROUP BY Narudzbe.id
HAVING SUM(Stavka_Narudzbe.kolicina) > 10;
-- -upit 4 ----
-- -Dostave izvršene prije 01.06.2026. i pripadni zaposlenici---
SELECT 
    Dostava.Narudzbe_id,
    Dostava.vrijeme_dostave,
    Zaposlenik.ime,
    Zaposlenik.prezime
FROM Dostava
INNER JOIN Zaposlenik
    ON Dostava.Zaposlenik_id = Zaposlenik.id
INNER JOIN Narudzbe
    ON Dostava.Narudzbe_id = Narudzbe.id
WHERE Dostava.vrijeme_dostave < '2026-06-01';
