-- MySQL Script generated by MySQL Workbench
-- Mon Jun  5 21:05:19 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema yasinkocanspotify
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema yasinkocanspotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `yasinkocanspotify` ;
USE `yasinkocanspotify` ;

-- -----------------------------------------------------
-- Table `yasinkocanspotify`.`INTERESTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yasinkocanspotify`.`INTERESTS` (
  `InterestID` INT NOT NULL,
  `Genre` VARCHAR(45) NULL,
  `Description` VARCHAR(200) NULL,
  PRIMARY KEY (`InterestID`),
  UNIQUE INDEX `InterestID_UNIQUE` (`InterestID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yasinkocanspotify`.`USER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yasinkocanspotify`.`USER` (
  `userID` VARCHAR(20) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `InterestID` INT NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `userID_UNIQUE` (`userID` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `fk_USER_INTERESTS1_idx` (`InterestID` ASC),
  CONSTRAINT `fk_USER_INTERESTS1`
    FOREIGN KEY (`InterestID`)
    REFERENCES `yasinkocanspotify`.`INTERESTS` (`InterestID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yasinkocanspotify`.`PAYMENTINFO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yasinkocanspotify`.`PAYMENTINFO` (
  `CardNumber` VARCHAR(16) NOT NULL,
  `expirationDate` VARCHAR(5) NULL,
  `SecurityCode` INT NULL,
  `userID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`CardNumber`, `userID`),
  INDEX `fk_PAYMENTINFO_USER_idx` (`userID` ASC),
  CONSTRAINT `fk_PAYMENTINFO_USER`
    FOREIGN KEY (`userID`)
    REFERENCES `yasinkocanspotify`.`USER` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yasinkocanspotify`.`ADDRESS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yasinkocanspotify`.`ADDRESS` (
  `Street` VARCHAR(60) NULL,
  `City` VARCHAR(45) NULL,
  `State` VARCHAR(45) NULL,
  `ZipCode` VARCHAR(45) NOT NULL,
  `userID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ZipCode`, `userID`),
  INDEX `fk_ADDRESS_USER1_idx` (`userID` ASC),
  CONSTRAINT `fk_ADDRESS_USER1`
    FOREIGN KEY (`userID`)
    REFERENCES `yasinkocanspotify`.`USER` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yasinkocanspotify`.`FREE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yasinkocanspotify`.`FREE` (
  `shufflePlaylist` VARCHAR(45) NULL,
  `createPlaylist` VARCHAR(45) NULL,
  `userID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `userID_UNIQUE` (`userID` ASC),
  CONSTRAINT `fk_FREE_USER1`
    FOREIGN KEY (`userID`)
    REFERENCES `yasinkocanspotify`.`USER` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yasinkocanspotify`.`PREMIUM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yasinkocanspotify`.`PREMIUM` (
  `listenOffline` VARCHAR(45) NULL,
  `highestQualityAudio` VARCHAR(45) NULL,
  `userID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `userID_UNIQUE` (`userID` ASC),
  CONSTRAINT `fk_PREMIUM_USER1`
    FOREIGN KEY (`userID`)
    REFERENCES `yasinkocanspotify`.`USER` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yasinkocanspotify`.`ARTIST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yasinkocanspotify`.`ARTIST` (
  `artistID` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `genre` VARCHAR(45) NULL,
  `listenCount` INT NULL,
  `rating` VARCHAR(45) NULL,
  PRIMARY KEY (`artistID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yasinkocanspotify`.`ALBUM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yasinkocanspotify`.`ALBUM` (
  `albumID` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `genre` VARCHAR(45) NULL,
  `listenCount` INT NULL,
  `rating` VARCHAR(45) NULL,
  `artistID` INT NULL, #MANUALLY CHANGED
  PRIMARY KEY (`albumID`),
  INDEX `fk_ALBUM_ARTIST1_idx` (`artistID` ASC),
  CONSTRAINT `fk_ALBUM_ARTIST1`
    FOREIGN KEY (`artistID`)
    REFERENCES `yasinkocanspotify`.`ARTIST` (`artistID`)
    ON DELETE SET NULL  # MANUALLY CHANGED
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yasinkocanspotify`.`SONG`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yasinkocanspotify`.`SONG` (
  `songID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `genre` VARCHAR(45) NULL,
  `listenCount` INT NULL,
  `rating` VARCHAR(45) NULL,
  `artistID` INT NULL,  # MANUALLY CHANGED
  `albumID` INT NULL,  # MANUALLY CHANGED
  `PREMIUM_userID` VARCHAR(20) NOT NULL,
  `FREE_userID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`songID`),
  INDEX `fk_SONG_ARTIST1_idx` (`artistID` ASC),
  INDEX `fk_SONG_ALBUM1_idx` (`albumID` ASC),
  INDEX `fk_SONG_PREMIUM1_idx` (`PREMIUM_userID` ASC),
  INDEX `fk_SONG_FREE1_idx` (`FREE_userID` ASC),
  CONSTRAINT `fk_SONG_ARTIST1`
    FOREIGN KEY (`artistID`)
    REFERENCES `yasinkocanspotify`.`ARTIST` (`artistID`)
    ON DELETE SET NULL  # MANUALLY CHANGED
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SONG_ALBUM1`
    FOREIGN KEY (`albumID`)
    REFERENCES `yasinkocanspotify`.`ALBUM` (`albumID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SONG_PREMIUM1`
    FOREIGN KEY (`PREMIUM_userID`)
    REFERENCES `yasinkocanspotify`.`PREMIUM` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SONG_FREE1`
    FOREIGN KEY (`FREE_userID`)
    REFERENCES `yasinkocanspotify`.`FREE` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yasinkocanspotify`.`ADVERTISEMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `yasinkocanspotify`.`ADVERTISEMENT` (
  `length` INT NULL,
  `name` VARCHAR(45) NOT NULL,
  `songID` INT NOT NULL,
  `FREE_userID` VARCHAR(20) NOT NULL,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  #UNIQUE INDEX `length_UNIQUE` (`length` ASC), MANUALLY REMOVED
  PRIMARY KEY (`name`, `songID`),
  INDEX `fk_ADVERTISEMENT_SONG1_idx` (`songID` ASC),
  INDEX `fk_ADVERTISEMENT_FREE1_idx` (`FREE_userID` ASC),
  CONSTRAINT `fk_ADVERTISEMENT_SONG1`
    FOREIGN KEY (`songID`)
    REFERENCES `yasinkocanspotify`.`SONG` (`songID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ADVERTISEMENT_FREE1`
    FOREIGN KEY (`FREE_userID`)
    REFERENCES `yasinkocanspotify`.`FREE` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
### END OF THE CREATION QUERIES 

select * from yasinkocanspotify.INTERESTS; 