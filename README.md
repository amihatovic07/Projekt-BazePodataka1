# Sustav za upravljanje restoranom

Izradili: Ivor Jusufović, David Kalčić, Korado Brajuha, Antonio Đusti i Alex Mihatović

Kolegij: Baza podataka 1

<br>

<br>



## Sadržaj

 
* ### 1. UVOD ....................................................................................................................
* ### 2. OPIS  PROCESA............................................................................................................ 
* ### 3. ER DIJAGRAM ............................................................................................................. 
* ### 3.1. OPIS ER DIJAGRAMA......................................................................................................
* ### 4. Relacijski model (sheme).................................................................................................
* ### 5. EER dijagram (MySQL Workbench)...........................................................................................
* ### 6. Tablice baze podataka ...................................................................................................
* ### 7. Upiti (SQL upiti i objašnjenja)..........................................................................................
* #### 7.1 UPIT 1 ................................................................................................................
* #### 7.2 UPIT 2 ................................................................................................................
* #### 7.3 UPIT 3.................................................................................................................
* #### 7.4 UPIT 4.................................................................................................................
* #### 7.5 UPIT 5.................................................................................................................
* #### 7.6 UPIT 6.................................................................................................................
* #### 7.7 UPIT 7.................................................................................................................
* #### 7.8 UPIT 8.................................................................................................................
* #### 7.9 UPIT 9.................................................................................................................
* #### 7.10 UPIT 10...............................................................................................................
* ### 8. Zaključak................................................................................................................

---

<br>

<br>

<br>

<br>

<br>

## 1. UVOD

Uvod se sastoji od dva dijela koja su ključna za početak dokumentacije sustava za upravljanje restoranom:

1. Opis projekta
2. Opis baze podataka

### Opis projekta

Navedeno poglavlje od uvoda je ključno jer opisuje zašto je kreiran navedeni sustav, sustav je kreiran kao projektni zadatak za kolegij Baze podataka 1, a projekt su kreirali studenti sa više smjerova kao što su računarstvo: Ivor Jusufović, te informatike: David Kalčić, Korado Brajuha, Antonio Đusti i Alex Mihatović. Projekt je kreiran kako bi studenti naučili raditi unutar grupa te kako bi naučili osnove rada sa relacijskim bazama podataka pomoću SQL jezika, a SQL se za navedeni projekt primjenjuje unutar MySQL Workbench, dok dokumentacija je kreirana pomoću Markdown jezika, ER dijagram je sastavljen unutar Lucidchart web aplikacije što je dodatno dokaz primjene sveukupno stiječenog znanja tijekom 1. i 2. semestara. 

### Opis baze podataka

Baza podataka je pozvana unutar SQL datoteke tako što prvo se makne ukoliko postoji baza podataka a potom se doda na novo te na taj način se olakša pristupanje podatcima i nije potrebno svaki upit ili tablicu zasebno pokretati. Nakon što se ponovo kreira baza podataka ona se odmah koristi naredbom USE

SQL programski blok:
``` sql
  DROP DATABASE IF EXISTS sustav_za_upravljanje_restoranom;
  CREATE DATABASE sustav_za_upravljanje_restoranom;
  USE sustav_za_upravljanje_restoranom;
```

## 2. OPIS  PROCESA

Unutar sustava se prati rad zaposlenika, gdje će se za svakog zaposlenika pratiti (id, ime, prezime, datum_zaposlenja, pozicija_zaposlenika, placa_zaposlenika). Jelovnik se prati putem (id, naziv_kategorije). Stol se prati pomoću (id, broj_stola, kapacitet_stola, trenutna_zauzetost_stola). Kupac ima (id, ime, prezime, VIP_gosti_id) i može imati relacije s VIP_gostima gdje je (id, mjesecni_popust, Specijalna_ponuda_id). Kupac može izvršiti rezervacije za koje se rezervacije prate pomoću(id, Stol_id, vrijeme_rezervacije, Kupac_id).
Nakon toga se vrše narudžbe, za koje se narudžba održava pomoću(id, vrijeme_narudzbe, Stol_id, Rezervacije_id, Kupac_id, Zaposlenik_id). Narudžba se sastoji od stavki narudžbe, koje se prate pomoću (id, Narudzbe_id, Jelo_id, kolicina).
Za jelo se prati pomoću (id , naziv_jela, cijena_jela, Trosak_pripravka_jela, Jelovnik_id), dok se specijalne ponude prate pomoću (id, Jelo_id, ponuden_popust, pridodana_svojstva). Prihod_računa održava se pomoću (id, iznos_racuna, vrijeme_izdavanja_racuna, status_racuna, Placanje_id) i povezan je s plaćanjima.
Plaćanje se prati putem  (id, Narudzbe_id, iznos, nacin_placanja), koji je povezan s narudžbama, dok se dostava može zahtijevati i dostava se održava putem (id, Kupac_id, Zaposlenik_id, Narudzbe_id, vrijeme_dostave). Sustav prati resurse (id, naziv, kolicina_resursa, vrijednost_resursa), nabavu resursa (id, Resursi_id, cijena, kolicina, datum_nabave) i Racuni rashoda (id, vrsta_rashoda, vrijeme_izdavanja_racuna, Nabava_resursi_id, iznos, status_racuna).
Konačno, slijedi izračun prihoda i rashoda (id, Racuni_prihodi_id, Racuni_rashodi_id, konacni_iznos), a zatim Bilanca (id, Obracun_prihoda_i_rashoda_id, Resursi_id, stanje_prije, stanje_poslije, datum_bilance).

## 3. ER DIJAGRAM

Navedeno poglavlje se sastoji od dvaju dijelova:
1. Slike ER dijagrama
2. Opisa ER dijagrama

### 1. Slika ER dijagrama
<slika ER dijagrama>

### 2. OPIS ER DIJAGRAMA


## Relacijski model (Relacijska shema)
Navedeno poglavlje se sastoji od 18 točaka koje su ključne za shvačanje šire slike primjene ovog sustava u radu, s obzirom da je namijena kreiranje sustava koji upravlja restoranom, pokriveni su svi mogući dijelovi restorana koji su važni za njegovo funkcioniranje te za njegov pravilan i efikasan rad, navedene relacije su istaknute unutar Relacijskog modela baze podataka:
1. Zaposlenik relacija (ime, prezime, datum_zaposlenja, pozicija_zaposlenika, placa_zaposlenika)
2. Stol relacija (broj_stola, kapacitet_stola, trenutna_zauzetost_stola)
3. Jelovnik relacija (naziv_kategorije)
4. Jelo relacija (naziv_jela, cijena_jela, Trosak_pripravka_jela, Jelovnik_id)
5. Specijalna_ponuda relacija (Jelo_id, ponuden_popust, pridodana_svojstva)
6. VIP_gosti relacija (mjesecni_popust, Specijalna_ponuda_id)
7. Kupac relacija (ime, prezime, VIP_gosti_id)
8. Rezervacije relacija (Stol_id, vrijeme_rezervacije, Kupac_id)
9. Narudzbe relacija (vrijeme_narudzbe, Stol_id, Rezervacije_id, Kupac_id, Zaposlenik_id)
10. Stavka_Narudzbe relacija (Narudzbe_id, Jelo_id, kolicina)
11. Placanje relacija (Narudzbe_id, iznos, nacin_placanja)
12. Dostava relacija (Kupac_id, Zaposlenik_id, Narudzbe_id, vrijeme_dostave)
13. Racuni_prihodi relacija (iznos_racuna, vrijeme_izdavanja_racuna, status_racuna, Placanje_id)
14. Resursi relacija (naziv, kolicina_resursa, vrijednost_resursa)
15. Nabava_resursi relacija (Resursi_id, cijena, kolicina, datum_nabave)
16. Racuni_rashodi relacija (vrsta_rashoda, vrijeme_izdavanja_racuna, Nabava_resursi_id, iznos, status_racuna)
17. Obracun_prihoda_i_rashoda relacija (Racuni_prihodi_id, Racuni_rashodi_id, konacni_iznos)
18. Bilanca relacija (Obracun_prihoda_i_rashoda_id, Resursi_id, stanje_prije, stanje_poslije, datum_bilance)

### 5. EER dijagram (MySQL Workbench)
  **Narudzbe** tablica povezuje tko je naručio (**kupac**), tko je poslužio (**zaposlenik**), za kojim stolom (**stol**) te ima li rezervacije. **Stavka_narudzbe** detaljno bilježi koja su jela naručena. Tablica **jelovnik** i **jelo** nudi širok izbor hrane uz njihove cijene i cijene pripravka. Dok tablica **placanje** i **racuni_prihodi** zabilježavaju naplatu, iznos i način plaćanja. Tablice **kupac** i **vip_gosti** razlikuje obične kupce od onih s povlasticama. Tablica rezervacija prati tko je rezervirao stol i u koje vrijeme. Tablica **dostava** zabilježava narudžbe koje idu van restorana, uključujući vrijeme dostave. Tablica **zaposlenik** sadrži podatke o radnicima, njihovim pozicijama i plaćama. Tablica **racuni_rashodi** bilježe se svi troškovi restorana, a kroz tablice **resursi** i **nabava_resursa** prate se zalihe namirnica i datum nabave. Tablice **obracun_prihoda_i_rashoda** i **bilanca** služe kako bi se pratio ukupni financijski rezultat i vrijednosti imovine restorana.
 
### 6. Tablice baze podataka 
  Tablice unutar baze podataka koju smo nazvali po našoj temi: **sustav_za_upravljanje_restoranom** su formirane pomoću naredbi CREATE TABLE  te je važna napomena da smo kod pojedinih podataka stavili uvjet da smiju biti sa praznom vrijednosti a za pojedine da nesmiju te je važna napomena kako smo postavili za atribut id za svaku tablicu naredbom AUTO INCREMENT automatsko unošenje vrijednosti. Svaka tablica ima značajnu ulogu u upravljanju restoranom s obzirom da je ključna ideja ušteda resursa, evidencija resursa, povečanje efikasnosti te povečanje pprihoda a smanjenje rashoda i iz tog razloga unutar svake tablice je bilo ključno povezati zaseban podatak kako bi se nakraju unutar dijagrama mogli povezati i na taj način sklopiti "Bigger picture". Pojedine tablice evidentiraju datume i vrijeme primjerice datum zaposlenja, vrijeme rezervacije i slično te to je postignuto pomoću DATE i DATETIME naredba koje su nam to omogučile bez da tretiramo atribute kao stringove ili kao niz znakova.

### 7. Upiti (SQL upiti i objašnjenja)
  Upiti unutar baze podataka su osmišljeni sa detaljnim planiranjem i analiziranjem funkcionalnosti koje su potrebne kako bismo postigli ultimativnu namjeru navedenog sustava, konstruirani su pomoću NATURAL JOIN, INNER JOIN, JOIN te GROUPBY naredba uz napomenu da GROUPBY naredba je dodatno koristila SUM, COUNT, MIN, MAX i slično kako bismo dobili podatke koje tražimo. 
  #### 7.1 UPIT 1
   
  #### 7.2 UPIT 2

  #### 7.3 UPIT 3

  #### 7.4 UPIT 4

  #### 7.5 UPIT 5

  #### 7.6 UPIT 6

  #### 7.7 UPIT 7

  #### 7.8 UPIT 8

  #### 7.9 UPIT 9

  #### 7.10 UPIT 10

### 8. Zaključak

