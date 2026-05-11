# Sustav za upravljanje restoranom




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
Plaćanje se prati putem  (id, Narudzbe_id, iznos, nacin_placanja), koji je povezan s narudžbama, dok se dostava može zahtijevati i dostava se održava putem (id, Kupac_id, Zaposlenik_id, Narudzbe_id, vrijeme_dostave). Sustav prati resurse (id, naziv, kolicina_resursa, vrijednost_resursa), nabavu resursa (id, Resursi_id, cijena, kolicina, datum_nabave) i Racunie rashoda (id, vrsta_rashoda, vrijeme_izdavanja_racuna, Nabava_resursi_id, iznos, status_racuna).
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
1. Zaposlenik relacija
2. Stol relacija
3. Jelovnik relacija
4. Jelo relacija
5. Specijalna_ponuda relacija
6. VIP_gosti relacija
7. Kupac relacija
8. Rezervacije relacija
9. Narudzbe relacija
10. Stavka_Narudzbe relacija
11. Placanje relacija
12. Dostava relacija
13. Racuni_prihodi relacija
14. Resursi relacija
15. Nabava_resursi relacija
16. Racuni_rashodi relacija
17. Obracun_prihoda_i_rashoda relacija
18. Bilanca relacija
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
* ### 8. Zaključak..................................................................................................
