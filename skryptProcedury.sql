DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `dodajSpecjaliste`(
    IN p_imie VARCHAR(20),
    IN p_nazwisko VARCHAR(20),
    IN p_rodzaj_specjalisty VARCHAR(8)
)
BEGIN
	INSERT into SPECJALISCI(imie, nazwisko, rodzaj_specjalisty)
	values(p_imie, p_nazwisko, p_rodzaj_specjalisty);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `dodajUzytkownika`(
	IN p_login VARCHAR(45),
	IN p_haslo VARCHAR(20),
	IN p_rodzaj_uzytkownika VARCHAR(16),
	IN p_organizacja VARCHAR(20),
	IN p_imie VARCHAR(20),
	IN p_nazwisko VARCHAR(20)
)
BEGIN
    IF (SELECT exists (SELECT 1 from UZYTKOWNICY where login = p_login)) THEN
        SELECT 'Login zajęty!';     
    ELSE
        INSERT into UZYTKOWNICY
        values
        (
            p_login,
            p_haslo,
            p_rodzaj_uzytkownika,
            p_organizacja,
            p_imie,
            p_nazwisko
        );
        SELECT 'Poprawnie stworzono użytkownika.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `logowanieUzytkownika`(
	IN p_login VARCHAR(45),
    IN p_haslo VARCHAR(20)
    /*OUT walidacja INT(11)*/
)
BEGIN
	declare walidacja INT(11);
	set walidacja = 0;
	IF (SELECT exists (select 1 from Uzytkownicy where p_login = login and p_haslo != haslo)) then
    /*select * from UZYTKOWNICY where login = p_login;*/
		select 'Błędne hasło!';
	elseif (SELECT not exists (select 1 from Uzytkownicy where p_login = login)) then
		select 'Błędny login!';
	elseif (SELECT exists (select 1 from Uzytkownicy where p_login = login and p_haslo = haslo)) then
		set walidacja = 1;
        select walidacja;
	END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `nowyArkusz`(
    IN p_nazwa VARCHAR(20),
	IN p_data DATE,
    IN p_przedmioty INT(11),
    IN p_operatorzy INT(11),
    IN p_cechy INT(11),
    IN p_proby INT(11),
    IN p_firma VARCHAR(20),
    IN p_proces VARCHAR(45),
    IN p_login VARCHAR(45)
    /*,
    IN p_imie VARCHAR(20),
    IN p_nazwisko VARCHAR(20),
    IN p_rodzaj_specjalisty VARCHAR(8)*/
)
BEGIN
	/*CALL dodajSpecjaliste(p_imie, p_nazwisko, p_rodzaj_specjalisty);*/
	insert into ARKUSZE(nazwa, data, rodzaj_arkusza, liczba_przedmiotow, liczba_operatorow, liczba_cech, liczba_prob, firma, proces, UZYTKOWNICY_login)
	values(p_nazwa, p_data, 'zwykły', p_przedmioty, p_operatorzy, p_cechy, p_proby, p_firma, p_proces, p_login);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `nowyPrzedmiot`(
    IN p_nazwa_czesci VARCHAR(20),
    IN p_nazwa_elementu VARCHAR(20),
    IN p_typ VARCHAR(6)
)
BEGIN
	INSERT into PRZEDMIOTY(nazwa_czesci, nazwa_elementu, typ)
	values(p_nazwa_czesci, p_nazwa_elementu, p_typ);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `nowyRaport`(
	IN p_data DATE,
    IN p_klient VARCHAR(45),
    IN p_login VARCHAR(45),
    IN p_id_arkusza INT(11),
    IN p_stanowisko VARCHAR(45)
)
BEGIN
	insert into RAPORTY(data, klient, UZYTKOWNICY_login, ARKUSZE_id_arkusza, stanowisko)
	values(p_data, p_klient, p_login, p_id_arkusza, p_stanowisko);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `nowySzablon`(
    IN p_nazwa VARCHAR(20),
    IN p_przedmioty INT(11),
    IN p_operatorzy INT(11),
    IN p_cechy INT(11),
    IN p_firma VARCHAR(20),
    IN p_proces VARCHAR(45),
    IN p_login VARCHAR(45)/*,
    
    IN p_imie VARCHAR(20),
    IN p_nazwisko VARCHAR(20),
    IN p_rodzaj_specjalisty VARCHAR(8)*/
)
BEGIN
	/*CALL dodajSpecjaliste(p_imie, p_nazwisko, p_rodzaj_specjalisty);*/
	insert into ARKUSZE(nazwa, rodzaj_arkusza, liczba_przedmiotow, liczba_operatorow, liczba_cech, firma, proces, UZYTKOWNICY_login)
	values(CONCAT('SZABLON_', p_nazwa), 'szablon', p_przedmioty, p_operatorzy, p_cechy, p_firma, p_proces, p_login);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `przypiszArkuszDoRaportu`(
    IN p_id_raportu INT(11),
    IN p_id_arkusza INT(11)
)
BEGIN
    UPDATE RAPORTY SET ARKUSZE_id_arkusza = p_id_arkusza
    where id_raportu = p_id_raportu;
    /*UPDATE ARKUSZE SET rodzaj_arkusza = 'badanie' where id_arkusza = p_id_arkusza;*/
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `przypiszArkuszDoUzytkownika`(
    IN p_id_arkusza INT(11),
    IN p_login VARCHAR(45)
)
BEGIN
    UPDATE Uzytkownicy SET UZYTKOWNICY_login = p_login 
    where p_id_arkusza = id_arkusza and rodzaj_uzytkownika = 'Osoba nadzorująca badanie';
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `przypiszCechy`(
    IN p_nazwa_cechy VARCHAR(20),
    IN p_id_czesci INT(11)
)
BEGIN
	INSERT into PRZEDMIOT_has_CECHY()
	values(p_nazwa_cechy, p_id_czesci);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `przypiszDecyzje`(
    IN p_ARKUSZE_id_arkusza INT(11),
    IN p_SPECJALISCI_id_specjalisty INT(11),
    IN p_SKALA_nazwa VARCHAR(20)
)
BEGIN
	INSERT into DECYZJE()
	values(p_ARKUSZE_id_arkusza, p_SPECJALISCI_id_specjalisty, p_SKALA_nazwa);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `przypiszPrzedmioty`(
    IN p_ARKUSZE_id_arkusza INT(11),
    IN p_PRZEDMIOTY_id_czesci INT(11)
)
BEGIN
	INSERT into ARKUSZE_has_PRZEDMIOTY()
	values(p_ARKUSZE_id_arkusza, p_PRZEDMIOTY_id_czesci);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `przypiszRaportDoArkusza`(
    IN p_id_raportu INT(11),
    IN p_id_arkusza INT(11)
)
BEGIN
    UPDATE RAPORTY SET ARKUSZE_id_arkusza = p_id_arkusza
    where id_raportu = p_id_raportu;
    /*UPDATE Arkusze SET rodzaj_arkusza = 'badanie' where id_arkusza = p_id_arkusza;*/
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `przypiszRaportDoUzytkownika`(
	IN p_id_raportu INT(11),
    IN p_login VARCHAR(45)
)
BEGIN
	DECLARE sukces INT(11);
    SET sukces = 0;
	IF (select not exists (SELECT 1 from Uzytkownicy where p_login = login)) then
		select 'Użytkownik nie istnieje!';
	ELSEIF (select not exists (SELECT 1 from Raporty where p_id_raportu = id_raportu)) then
		select 'Raport nie istnieje!';
	elseif (select exists (SELECT 1 from Uzytkownicy where login = p_login and rodzaj_uzytkownika = 'Inżynier jakości')) then
		UPDATE RAPORTY set UZYTKOWNICY_login = p_login where p_id_raportu = id_raportu;
        SET sukces = 1;
        SELECT sukces;
	END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `przypiszSpecjaliste`(
    IN p_ARKUSZE_id_arkusza INT(11),
    IN p_SPECJALISCI_id_specjalisty INT(11)
)
BEGIN
	INSERT into ARKUSZE_has_SPECJALISCI()
	values(p_ARKUSZE_id_arkusza, p_SPECJALISCI_id_specjalisty);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `usunArkusz`(
	IN p_id_arkusza INT(11)
)
BEGIN
	IF (select exists (select 1 from Arkusze where p_id_arkusza = id_arkusza)) then
		UPDATE RAPORTY set ARKUSZE_id_arkusza = NULL where p_id_arkusza = ARKUSZE_id_arkusza;
        DELETE from ARKUSZE_has_PRZEDMIOTY where p_id_arkusza = ARKUSZE_id_arkusza;
        DELETE from Decyzje where p_id_arkusza = ARKUSZE_id_arkusza;
        DELETE from ARKUSZE_has_SPECJALISCI where p_id_arkusza = ARKUSZE_id_arkusza;
        
        DELETE from Arkusze where p_id_arkusza = id_arkusza;
        
        select 'Usunięto wskazany arkusz.';
	END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `usunUzytkownika`(
	IN p_login VARCHAR(45)
)
BEGIN
    IF (SELECT exists (SELECT 1 from UZYTKOWNICY where login = p_login)) THEN
        DELETE FROM UZYTKOWNICY where login = p_login;
    ELSE
        SELECT 'Użytkownik nie istnieje!';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `zmienFirme`(
	IN p_id_arkusza INT(11),
    IN p_firma VARCHAR(20)    
)
BEGIN
	DECLARE sukces INT(11);
    SET sukces = 0;
	IF (select not exists (SELECT 1 from Arkusze where p_id_arkusza = id_arkusza)) then
		select 'Arkusz nie istnieje!';
        SELECT sukces;
	else
		UPDATE Arkusze set firma = p_firma where p_id_arkusza = id_arkusza;
        SET sukces = 1;
        SELECT sukces;
	END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `zmienHaslo`(
	IN p_login VARCHAR(45),
    IN p_haslo VARCHAR(20)
)
BEGIN
	DECLARE sukces INT(11);
    SET sukces = 0;
	IF (select not exists (SELECT 1 from Uzytkownicy where p_login = login)) then
		select 'Użytkownik nie istnieje!';
	else
		UPDATE Uzytkownicy set haslo = p_haslo where p_login = login;
        SET sukces = 1;
        SELECT sukces;
	END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `zmienImieSpecjalisty`(
	IN p_id_specjalisty INT(11),
    IN p_imie VARCHAR(20)    
)
BEGIN
	DECLARE sukces INT(11);
    SET sukces = 0;
	IF (select not exists (SELECT 1 from Specjalisci where p_id_specjalisty = id_specjalisty)) then
		select sukces;
	else
		UPDATE Specjalisci set imie = p_imie where p_id_specjalisty = id_specjalisty;
        SET sukces = 1;
        SELECT sukces;
	END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `zmienImieUzytkownika`(
	IN p_login VARCHAR(45),
    IN p_imie VARCHAR(20)    
)
BEGIN
	DECLARE sukces INT(11);
    SET sukces = 0;
	IF (select not exists (SELECT 1 from Uzytkownicy where p_login = login)) then
		select 'Użytkownik nie istnieje!';
	else
		UPDATE Uzytkownicy set imie = p_imie where p_login = login;
        SET sukces = 1;
        SELECT sukces;
	END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `zmienNazwiskoSpecjalisty`(
	IN p_id_specjalisty INT(11),
    IN p_nazwisko VARCHAR(20)    
)
BEGIN
	DECLARE sukces INT(11);
    SET sukces = 0;
	IF (select not exists (SELECT 1 from Specjalisci where p_id_specjalisty = id_specjalisty)) then
		select sukces;
	else
		UPDATE Specjalisci set nazwisko = p_nazwisko where p_id_specjalisty = id_specjalisty;
        SET sukces = 1;
        SELECT sukces;
	END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `zmienNazwiskoUzytkownika`(
	IN p_login VARCHAR(45),
    IN p_nazwisko VARCHAR(20)    
)
BEGIN
	DECLARE sukces INT(11);
    SET sukces = 0;
	IF (select not exists (SELECT 1 from Uzytkownicy where p_login = login)) then
		select 'Użytkownik nie istnieje!';
	else
		UPDATE Uzytkownicy set nazwisko = p_nazwisko where p_login = login;
        SET sukces = 1;
        SELECT sukces;
	END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `zmienOrganizacje`(
	IN p_login VARCHAR(45),
    IN p_organizacja VARCHAR(20)    
)
BEGIN
	DECLARE sukces INT(11);
    SET sukces = 0;
	IF (select not exists (SELECT 1 from Uzytkownicy where p_login = login)) then
		select 'Użytkownik nie istnieje!';
	else
		UPDATE Uzytkownicy set organizacja = p_organizacja where p_login = login;
        SET sukces = 1;
        SELECT sukces;
	END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `zmienRodzajUzytkownika`(
	IN p_login VARCHAR(45),
    IN p_rodzaj VARCHAR(20)    
)
BEGIN
	DECLARE sukces INT(11);
    SET sukces = 0;
	IF (select not exists (SELECT 1 from Uzytkownicy where p_login = login)) then
		select 'Użytkownik nie istnieje!';
	else
		UPDATE Uzytkownicy set rodzaj_uzytkownika = p_rodzaj where p_login = login;
        SET sukces = 1;
        SELECT sukces;
	END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `dodajSkale`(
    IN p_nazwa VARCHAR(20),
    IN p_rodzaj VARCHAR(20)
)
BEGIN
	INSERT into SKALA()
	values(p_nazwa, p_rodzaj);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `dodajCechy`(
    IN p_nazwa VARCHAR(20)
)
BEGIN
	INSERT into CECHY
	values(p_nazwa);
END$$
DELIMITER ;
