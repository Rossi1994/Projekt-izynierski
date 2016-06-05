-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db` DEFAULT CHARACTER SET utf8 ;
USE `db` ;


-- -----------------------------------------------------
-- Table `db`.`UZYTKOWNICY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`UZYTKOWNICY` (
  `login` VARCHAR(45) NOT NULL,
  `haslo` VARCHAR(20) NOT NULL,
  `rodzaj_uzytkownika` VARCHAR(16) BINARY NOT NULL,
  `organizacja` VARCHAR(20) NOT NULL,
  `imie` VARCHAR(20) NOT NULL,
  `nazwisko` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`login`))
PACK_KEYS = 0
ROW_FORMAT = DEFAULT;

-- -----------------------------------------------------
-- Table `db`.`SPECJALISCI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`SPECJALISCI` (
  `id_specjalisty` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `imie` VARCHAR(20) NOT NULL,
  `nazwisko` VARCHAR(20) NOT NULL,
  `rodzaj_specjalisty` VARCHAR(8) BINARY NOT NULL,
  PRIMARY KEY (`id_specjalisty`))
PACK_KEYS = 0
ROW_FORMAT = DEFAULT;


-- -----------------------------------------------------
-- Table `db`.`PRZEDMIOTY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`PRZEDMIOTY` (
  `id_czesci` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nazwa_czesci` VARCHAR(20) NOT NULL,
  `nazwa_elementu` VARCHAR(20) NOT NULL,
  `typ` VARCHAR(6) BINARY NOT NULL,
  PRIMARY KEY (`id_czesci`))
PACK_KEYS = 0
ROW_FORMAT = DEFAULT;


-- -----------------------------------------------------
-- Table `db`.`CECHY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`CECHY` (
  `nazwa` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`nazwa`))
PACK_KEYS = 0
ROW_FORMAT = DEFAULT;

/*SET foreign_key_checks = 0;
DROP table Arkusze
SET foreign_key_checks = 1;*/
-- -----------------------------------------------------
-- Table `db`.`ARKUSZE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`ARKUSZE` (
  `id_arkusza` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(20) NOT NULL,
  `data` DATE NULL,
  `rodzaj_arkusza` VARCHAR(7) BINARY NOT NULL,
  `liczba_przedmiotow` INT(11) UNSIGNED NOT NULL,
  `liczba_operatorow` INT(11) UNSIGNED NOT NULL,
  `liczba_cech` INT(11) UNSIGNED NOT NULL,
  `liczba_prob` INT(11) UNSIGNED NOT NULL,
  `firma` VARCHAR(20) NOT NULL,
  `proces` VARCHAR(45) NOT NULL,
  `UZYTKOWNICY_login` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_arkusza`),
  INDEX `fk_ARKUSZE_UZYTKOWNICY1_idx` (`UZYTKOWNICY_login` ASC),
  CONSTRAINT `fk_ARKUSZE_UZYTKOWNICY1`
    FOREIGN KEY (`UZYTKOWNICY_login`)
    REFERENCES `db`.`UZYTKOWNICY` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
PACK_KEYS = 0
ROW_FORMAT = DEFAULT;


-- -----------------------------------------------------
-- Table `db`.`RAPORTY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`RAPORTY` (
  `id_raportu` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `klient` VARCHAR(45) NOT NULL,
  `UZYTKOWNICY_login` VARCHAR(45) NOT NULL,
  `ARKUSZE_id_arkusza` INT(11) UNSIGNED NOT NULL,
  `stanowisko` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_raportu`),
  INDEX `fk_RAPORTY_UZYTKOWNICY1_idx` (`UZYTKOWNICY_login` ASC),
  INDEX `fk_RAPORTY_ARKUSZE1_idx` (`ARKUSZE_id_arkusza` ASC),
  CONSTRAINT `fk_RAPORTY_UZYTKOWNICY1`
    FOREIGN KEY (`UZYTKOWNICY_login`)
    REFERENCES `db`.`UZYTKOWNICY` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RAPORTY_ARKUSZE1`
    FOREIGN KEY (`ARKUSZE_id_arkusza`)
    REFERENCES `db`.`ARKUSZE` (`id_arkusza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
PACK_KEYS = 0
ROW_FORMAT = DEFAULT;


-- -----------------------------------------------------
-- Table `db`.`ARKUSZE_has_SPECJALISCI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`ARKUSZE_has_SPECJALISCI` (
  `ARKUSZE_id_arkusza` INT(11) UNSIGNED NOT NULL,
  `SPECJALISCI_id_specjalisty` INT(11) UNSIGNED NOT NULL,
  INDEX `ARKUSZE_has_BADACZE_FKIndex1` (`ARKUSZE_id_arkusza` ASC),
  INDEX `ARKUSZE_has_BADACZE_FKIndex2` (`SPECJALISCI_id_specjalisty` ASC),
  CONSTRAINT `fk_{7433A416-6F89-4F7F-826B-6C691ED4398C}`
    FOREIGN KEY (`ARKUSZE_id_arkusza`)
    REFERENCES `db`.`ARKUSZE` (`id_arkusza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_{BD3F424C-FC74-4B20-9651-235927C6F746}`
    FOREIGN KEY (`SPECJALISCI_id_specjalisty`)
    REFERENCES `db`.`SPECJALISCI` (`id_specjalisty`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
PACK_KEYS = 0
ROW_FORMAT = DEFAULT;


-- -----------------------------------------------------
-- Table `db`.`SKALA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`SKALA` (
  `nazwa` VARCHAR(20) NOT NULL,
  `CECHY_nazwa` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`nazwa`),
  INDEX `fk_SKALA_CECHY1_idx` (`CECHY_nazwa` ASC),
  CONSTRAINT `fk_SKALA_CECHY1`
    FOREIGN KEY (`CECHY_nazwa`)
    REFERENCES `db`.`CECHY` (`nazwa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
PACK_KEYS = 0
ROW_FORMAT = DEFAULT;


-- -----------------------------------------------------
-- Table `db`.`PRZEDMIOT_has_CECHY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`PRZEDMIOT_has_CECHY` (
  `CECHY_nazwa` VARCHAR(20) NOT NULL,
  `PRZEDMIOTY_id_czesci` INT(11) UNSIGNED NOT NULL,
  INDEX `fk_PRZEDMIOT_has_CECHY_CECHY1_idx` (`CECHY_nazwa` ASC),
  INDEX `fk_PRZEDMIOT_has_CECHY_PRZEDMIOTY1_idx` (`PRZEDMIOTY_id_czesci` ASC),
  CONSTRAINT `fk_PRZEDMIOT_has_CECHY_CECHY1`
    FOREIGN KEY (`CECHY_nazwa`)
    REFERENCES `db`.`CECHY` (`nazwa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRZEDMIOT_has_CECHY_PRZEDMIOTY1`
    FOREIGN KEY (`PRZEDMIOTY_id_czesci`)
    REFERENCES `db`.`PRZEDMIOTY` (`id_czesci`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `db`.`ARKUSZE_has_PRZEDMIOTY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`ARKUSZE_has_PRZEDMIOTY` (
  `ARKUSZE_id_arkusza` INT(11) UNSIGNED NOT NULL,
  `PRZEDMIOTY_id_czesci` INT(11) UNSIGNED NOT NULL,
  INDEX `ARKUSZE_has_PRZEDMIOTY_FKIndex1` (`ARKUSZE_id_arkusza` ASC),
  INDEX `fk_ARKUSZE_has_PRZEDMIOTY_PRZEDMIOTY1_idx` (`PRZEDMIOTY_id_czesci` ASC),
  CONSTRAINT `fk_{55D089D1-7004-4AD5-9C2D-4CD7B906EB1D}`
    FOREIGN KEY (`ARKUSZE_id_arkusza`)
    REFERENCES `db`.`ARKUSZE` (`id_arkusza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ARKUSZE_has_PRZEDMIOTY_PRZEDMIOTY1`
    FOREIGN KEY (`PRZEDMIOTY_id_czesci`)
    REFERENCES `db`.`PRZEDMIOTY` (`id_czesci`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `db`.`DECYZJE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`DECYZJE` (
  `ARKUSZE_id_arkusza` INT(11) UNSIGNED NOT NULL,
  `SPECJALISCI_id_specjalisty` INT(11) UNSIGNED NOT NULL,
  `SKALA_nazwa` VARCHAR(20) NOT NULL,
  INDEX `ARKUSZE_has_SPECJALISCI_FKIndex1` (`ARKUSZE_id_arkusza` ASC),
  INDEX `ARKUSZE_has_SPECJALISCI_FKIndex2` (`SPECJALISCI_id_specjalisty` ASC),
  INDEX `ARKUSZE_has_SPECJALISCI_FKIndex3` (`SKALA_nazwa` ASC),
  CONSTRAINT `fk_{8AF889F2-4B01-413E-9CBF-EBA68C66CEC9}`
    FOREIGN KEY (`ARKUSZE_id_arkusza`)
    REFERENCES `db`.`ARKUSZE` (`id_arkusza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_{87683B12-8F07-4D6D-9C2F-4A422D11782E}`
    FOREIGN KEY (`SPECJALISCI_id_specjalisty`)
    REFERENCES `db`.`SPECJALISCI` (`id_specjalisty`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_{BAC39D76-F981-459A-96EB-F71F07F32AA6}`
    FOREIGN KEY (`SKALA_nazwa`)
    REFERENCES `db`.`SKALA` (`nazwa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
PACK_KEYS = 0
ROW_FORMAT = DEFAULT;


-- -----------------------------------------------------
-- Table `db`.`tbl_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db`.`tbl_user` (
  `user_id` BIGINT NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/*SELECT @@sql_mode
SET GLOBAL sql_mode = 'NO_ENGINE_SUBSTITUTION';
SET SESSION sql_mode = 'NO_ENGINE_SUBSTITUTION';*/
