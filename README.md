# Sustav za upravljanje restoranom




<br>

<br>



## Sadržaj

 
* ### 1. UVOD ....................................................................................................................
* ### 2. OPIS  PROCESA............................................................................................................ 
* ### 3. ER DIJAGRAM ............................................................................................................. 
* ### 3.1. OPIS ER DIJAGRAMA......................................................................................................
* ### 4. Relacijski model (sheme)..................................................................................................
* ### 5. EER dijagram (MySQL Workbench)...........................................................................................
* ### 6. Tablice baze podataka ..................................................................................................
* ### 7. Upiti (SQL upiti i objašnjenja)..........................................................................................
* ### 8. Zaključak..................................................................................................
*
*
*

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

<br>

<br>

<br>

<br>

<br>

## 3. ER DIJAGRAM


