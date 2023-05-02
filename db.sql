drop database if exists partiokauppa;
create database partiokauppa;
use partiokauppa;

/* ORDERING */
/* LUO ENSIN TAULUT ADMIN, CATEGORY JA PRODUCT */
/* JA SITTEN VASTA TAULUT CUSTOMER, `ORDER` JA ORDER_ROW */

create table customer (
  id int primary key auto_increment,
  firstname varchar(50) not null,
  lastname varchar(50) not null,
  email varchar(50) not null,
  phone varchar(50) not null,
  address varchar(50) not null,
  zip varchar(10) not null,
  city varchar(30) not null
);

create table `order` (
  id int primary key auto_increment,
  order_date timestamp default current_timestamp,
  customer_id int not null,
  index customer_id(customer_id),
  foreign key (customer_id) references customer(id)
  on delete restrict
);

CREATE TABLE order_row (
  order_id INT NOT NULL,
  INDEX order_id(order_id),
  FOREIGN KEY (order_id) REFERENCES `order`(id)
  ON DELETE RESTRICT,
  product_id INT NOT NULL,
  INDEX product_id(product_id),
  FOREIGN KEY (product_id) REFERENCES product(id)
  ON DELETE cascade,
  kpl INT NOT NULL
);

/* ADMIN */

create table admin (
  id int primary key auto_increment,
  firstname varchar(50) not null,
  lastname varchar(50) not null,
  email varchar(50) not null,
  password varchar(50) not null
);

insert into admin (firstname, lastname, email, password) values ('test', 'admin', 'admin@admin', 'admin');

/* CATEGORY */

create table category (
  id int primary key auto_increment,
  name varchar(50) not null,
  image varchar(100)
);

insert into category (name, image) values ('Reput ja laukut', 'reput.jpg');
insert into category (name, image) values ('Teltat', 'teltat.jpg');
insert into category (name, image) values ('Makuupussit', 'makuupussit.jpg');
insert into category (name, image) values ('Retkiruokailu', 'retkiruokailu.jpg');
insert into category (name, image) values ('Työkalut', 'työkalut.jpg');
insert into category (name, image) values ('Valaisimet', 'valaisimet.jpg');
insert into category (name, image) values ('Ensiapuvälineet', 'ensiapuvälineet.jpg');

/* PRODUCT */

create table product (
  id int primary key auto_increment,
  brand varchar(100) not null,
  name varchar(100) not null,
  description varchar(500) not null,
  price decimal(10,2) not null,
  image varchar(100),
  category_id int not null,
  index category_id(category_id),
  foreign key (category_id) references category(id)
  on delete cascade
);

/* Reput ja laukut */
insert into product (brand, name, description, price, image, category_id) values ("Fjällräven", "Reppu", "Erinomainen vaihtoehto niin kouluun, töihin kuin pikkuretkillekin.", 100, 'fjällräven-reppu.jpg', 1);
insert into product (brand, name, description, price, image, category_id) values ("Haglöfs", "Reppu", "Tämä innovatiivinen reppu avataan poikkeuksellisesti sivulta eikä päältä.", 120, 'haglöfs-reppu.jpg', 1);
insert into product (brand, name, description, price, image, category_id) values ("The North Face", "Olkalaukku", "Yksinkertainen, urbaani olkalaukku, jossa kuljetat kätevästi tärkeimmät tavarasi arjessa ja matkoilla.", 50, 'northface-olkalaukku.jpg', 1);
insert into product (brand, name, description, price, image, category_id) values ("The North Face", "Vyölaukku", "Kestävästä materiaalista valmistettu kevyt vyölaukku, jossa on päälokero ja yksi pienempi vetoketjullinen tasku.", 40, 'northface-vyölaukku.jpg', 1);
insert into product (brand, name, description, price, image, category_id) values ("Patagonia", "Kangaskassi", "Vastuullisesti valmistettu, kestävä kassi.", 20, 'patagonia-kangaskassi.jpg', 1);
insert into product (brand, name, description, price, image, category_id) values ("Savotta", "Rinkka", "Suomalainen laatutuote, joka kestää vuodesta seuraavaan.", 350, 'savotta-rinkka.jpg', 1);

/* Teltat */
insert into product (brand, name, description, price, image, category_id) values ("Fjällräven", "Tunneliteltta", "Kevyt ja vahva neljän vuodenajan tunneliteltta.", 1000, 'fjällräven-tunneliteltta.jpg', 2);
insert into product (brand, name, description, price, image, category_id) values ("Hilleberg", "Tunneliteltta", "Kolmen hengen ympärivuotinen teltta, jossa yhdistyvät keveys, tilavuus ja kestävyys.", 1200, 'hilleberg-tunneliteltta.jpg', 2);
insert into product (brand, name, description, price, image, category_id) values ("Nordisk", "Leiriteltta", "Erittäin suuri kellomainen puuvillateltta, jonka makuutilassa on tilaa jopa kuudelle hengelle.", 900, 'nordisk-leiriteltta.jpg', 2);
insert into product (brand, name, description, price, image, category_id) values ("Ticket To The Moon", "Riippumatto", "Näppärä riippumaton ja hyttysverkon yhdistelmä on helppo pakata retkelle ja kevyt kantaa mukana mihin tahansa.", 150, 'tickettothemoon-riippumatto.jpg', 2);
insert into product (brand, name, description, price, image, category_id) values ("Vaude", "Kupoliteltta", "Kevyt, itsestäänseisova kupoliteltta erinomaisilla ilmanvaihto-ominaisuuksilla.", 800, 'vaude-kupoliteltta.jpg', 2);

/* Makuupussit */
insert into product (brand, name, description, price, image, category_id) values ("Frilufts", "Tekokuitumakuupussi", "Kierrätettyä materiaalia sisältävä, vanutäytteinen makuupussi.", 150, 'frilufts-tekokuitu.jpg', 3);
insert into product (brand, name, description, price, image, category_id) values ("Marmot", "Tekokuitumakuupussi", "Kokonaan kierrätetyllä keinokuidulla täytetty makuupussi.", 200, 'marmot-tekokuitu.jpg', 3);
insert into product (brand, name, description, price, image, category_id) values ("Mountain Equipment", "Untuvamakuupussi", "Kevyt kolmen vuodenajan makuupussi retkeilyyn keväästä syksyyn. Makuupussi pitää sinut lämpimänä 0 °C:seen saakka ja mahtuu pieneen tilaan, joten se on kätevä kuljettaa repussa.", 300, 'mountain-untuva.jpg', 3);
insert into product (brand, name, description, price, image, category_id) values ("Rab", "Untuvamakuupussi", "Kolmen vuodenajan käyttöön soveltuva untuvamakuupussi, joka tarjoaa miellyttävää lämpöä lämpötilan pudotessa pakkaselle.", 350, 'rab-untuvamakuupussi.jpg', 3);
insert into product (brand, name, description, price, image, category_id) values ("Western Mountaineering", "Talvimakuupussi", "Sikeät ja rentouttavat ulkoilmaunet mahdollistava untuvamakuupussi vuoden viileimpiin kuukausiin.", 950, 'western-talvimakuupussi.jpg', 3);

/* Retkiruokailu */
insert into product (brand, name, description, price, image, category_id) values ("Kupilka", "Kuksa", "Ympäristöystävällisestä luonnonkuitukomposiitista valmistettu kuksa.", 20, 'kupilka-kuksa.jpg', 4);
insert into product (brand, name, description, price, image, category_id) values ("Kupilka", "Spork", "Ympäristöystävällisestä luonnonkuitukomposiitista valmistettu lusikka-haarukka.", 5, 'kupilka-spork.jpg', 4);
insert into product (brand, name, description, price, image, category_id) values ("Kupilka", "Tulukset", "Yltää jopa 3000˚C kipinöihin tehden tulenteosta helppoa kosteallakin säällä.", 20, 'kupilka-tulukset.jpg', 4);
insert into product (brand, name, description, price, image, category_id) values ("Leader", "Retkiruoka", "Herkullista retkiruokaa, johon lisätään vain vesi, annetaan hautua ja maukas ateria on valmis nautittavaksi.", 6, 'leader-retkiruoka.jpg', 4);
insert into product (brand, name, description, price, image, category_id) values ("Primus", "Kaasukeitin", "Vakaa, kaasupatruunan päälle ruuvattava retkikeitin.", 50, 'primus-kaasukeitin.jpg', 4);
insert into product (brand, name, description, price, image, category_id) values ("Real Turmat", "Retkiruoka", "Maukasta pakastekuivattua, vakuumipakattua ja laktoositonta retkiruokaa.", 7, 'realturmat-retkiruoka.jpg', 4);
insert into product (brand, name, description, price, image, category_id) values ("Thermos", "Termospullo", "Perinteinen testeissä menestynyt Thermoksen laadukas 750 ml termospullo. Pullossa pysyy kuuma kuumana ja kylmä kylmänä jopa 24 tuntia.", 50, 'thermos-termos.jpg', 4);
insert into product (brand, name, description, price, image, category_id) values ("Trangia", "Spriikeitin", "Trangia-keitinsetti spriipolttimella, kahdella kattilalla ja non-stick -paistinpannulla soveltuu 1-2 hengen käyttöön.", 80, 'trangia-spriikeitin.jpg', 4);

/* Työkalut */
insert into product (brand, name, description, price, image, category_id) values ("Fiskars", "Retkikirves", "Pienikokoinen retkikirves retkille, mökille, autoon tai veneeseen.", 50, 'fiskars-retkikirves.jpg', 5);
insert into product (brand, name, description, price, image, category_id) values ("Fiskars", "Retkisaha", "Tuoreiden puiden ja oksien sahaamiseen, leikkaamiseen ja karsimiseen.", 45, 'fiskars-retkisaha.jpg', 5);
insert into product (brand, name, description, price, image, category_id) values ("Leatherman", "Monitoimityökalu", "Kestosuosikki Leatherman monitoimityökalu.", 120, 'leatherman-monitoimityökalu.jpg', 5);
insert into product (brand, name, description, price, image, category_id) values ("Marttiini", "Puukko", "Linjakas käyttöpuukko, jonka taottu hiiliterästerä soveltuu erinomaisesti vuoluun.", 70, 'marttiini-puukko.jpg', 5);
insert into product (brand, name, description, price, image, category_id) values ("Marttiini", "Taittoveitsi", "Kätevä taittoveitsi tyylikkäällä, mustakromatulla rosteriterällä.", 30, 'marttiini-taittoveitsi.jpg', 5);
insert into product (brand, name, description, price, image, category_id) values ("Ortovox", "Lumilapio", "Yleiskäyttöinen alumiinilapio sopii kaikenlaisiin lumitöihin aina lumivyöryn uhrien pelastamisesta ja iglujen rakentamisesta mökkien sisäänkäyntien raivaamiseen lumesta.", 50, 'ortovox-lumilapio.jpg', 5);
insert into product (brand, name, description, price, image, category_id) values ("Roselli", "Puukko", "Lapsille kehitetty turvapuukko, jonka tylppä kärki estää itsensä pistämisen vahingossa.", 80, 'roselli-puukko.jpg', 5);
insert into product (brand, name, description, price, image, category_id) values ("Victorinox", "Linkkuveitsi", "Keskikokoinen linkkuveitsi, jonka ominaisuudet sopivat erinomaisesti retkeilijälle.", 30, 'victorinox-linkkuveitsi.jpg', 5);

/* Valaisimet */
insert into product (brand, name, description, price, image, category_id) values ("Feuerhand", "Lyhty", "Perinteinen myrskylyhty on hyvä tunnelmanluoja pihalla ja puutarhassa.", 40, 'feuerhand-lyhty.jpg', 6);
insert into product (brand, name, description, price, image, category_id) values ("Ledlenser", "Taskulamppu", "Kirkas ja kompakti.", 50, 'ledlenser-taskulamppu.jpg', 6);
insert into product (brand, name, description, price, image, category_id) values ("Petzl", "Otsalamppu", "Soveltuu retkeilyyn, polkujuoksemiseen ja aktiiviseen ulkoiluun.", 70, 'petzl-otsalamppu.jpg', 6);

/* Ensiapuvälineet */
insert into product (brand, name, description, price, image, category_id) values ("Care Plus", "Ensiapulaukku", "Pienikokoinen ja kevyt ensiapupakkaus, joka on helppo kuljettaa aina mukana.", 30, 'careplus-ensiapulaukku.jpg', 7);
insert into product (brand, name, description, price, image, category_id) values ("HEAT-IT ARCTIC AID", "Lämpöpakkaus", "Hetivalmis lämpöpakkaus, joka lämpiää noin 50-60 asteeseen ja pysyy lämpimänä useita tunteja. Keittäen uudelleenladattava, varmatoiminen lämpöpakkaus on todella tehokas lämmöntuottaja.", 20, 'heat-lämpöpakkaus.jpg', 7);
