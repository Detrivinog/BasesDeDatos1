-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DHTube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DHTube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DHTube` DEFAULT CHARACTER SET utf8 ;
USE `DHTube` ;

-- -----------------------------------------------------
-- Table `DHTube`.`Pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHTube`.`Pais` (
  `idPais` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idPais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHTube`.`Avatar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHTube`.`Avatar` (
  `idAvatar` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Url` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`idAvatar`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHTube`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHTube`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(200) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Nombre` VARCHAR(200) NOT NULL,
  `Fecha_Nacimiento` DATE NOT NULL,
  `Codigo_Postal` VARCHAR(45) NULL,
  `Id_Pais` INT NOT NULL,
  `Avatar_idAvatar` INT NOT NULL,
  PRIMARY KEY (`idUsuario`),
  INDEX `fk_Usuario_Pais_idx` (`Id_Pais` ASC) VISIBLE,
  INDEX `fk_Usuario_Avatar1_idx` (`Avatar_idAvatar` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_Pais`
    FOREIGN KEY (`Id_Pais`)
    REFERENCES `DHTube`.`Pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Avatar1`
    FOREIGN KEY (`Avatar_idAvatar`)
    REFERENCES `DHTube`.`Avatar` (`idAvatar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHTube`.`Privacidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHTube`.`Privacidad` (
  `idPrivacidad` INT NOT NULL AUTO_INCREMENT,
  `Tipo` SET("Público", "Privado") NOT NULL,
  PRIMARY KEY (`idPrivacidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHTube`.`Video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHTube`.`Video` (
  `idVideo` INT NOT NULL AUTO_INCREMENT,
  `Titulo` VARCHAR(45) NOT NULL,
  `Descripcion` TEXT NULL,
  `Tamano` FLOAT NOT NULL,
  `Nombre_Archivo` VARCHAR(200) NOT NULL,
  `Duracion` TIME NOT NULL,
  `Imagen_Url` VARCHAR(250) NOT NULL,
  `NReproducciones` BIGINT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `Fecha_Publicacion` DATETIME NOT NULL,
  `IdPrivacidad` INT NOT NULL,
  PRIMARY KEY (`idVideo`),
  INDEX `fk_Video_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  INDEX `fk_Video_Privacidad1_idx` (`IdPrivacidad` ASC) VISIBLE,
  CONSTRAINT `fk_Video_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `DHTube`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Video_Privacidad1`
    FOREIGN KEY (`IdPrivacidad`)
    REFERENCES `DHTube`.`Privacidad` (`idPrivacidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHTube`.`Reaccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHTube`.`Reaccion` (
  `idReaccion` INT NOT NULL AUTO_INCREMENT,
  `Tipo` VARCHAR(45) NOT NULL,
  `Emoticon` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idReaccion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHTube`.`Video_X_Reaccion_X_Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHTube`.`Video_X_Reaccion_X_Usuario` (
  `Video_idVideo` INT NOT NULL,
  `Reaccion_idReaccion` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `IdVideoReaccionUsuario` BIGINT NOT NULL AUTO_INCREMENT,
  `Fecha_Reaccion` DATETIME NOT NULL,
  PRIMARY KEY (`IdVideoReaccionUsuario`),
  INDEX `fk_Video_has_Reaccion_Reaccion1_idx` (`Reaccion_idReaccion` ASC) VISIBLE,
  INDEX `fk_Video_has_Reaccion_Video1_idx` (`Video_idVideo` ASC) VISIBLE,
  INDEX `fk_Video_X_Reaccion_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Video_has_Reaccion_Video1`
    FOREIGN KEY (`Video_idVideo`)
    REFERENCES `DHTube`.`Video` (`idVideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Video_has_Reaccion_Reaccion1`
    FOREIGN KEY (`Reaccion_idReaccion`)
    REFERENCES `DHTube`.`Reaccion` (`idReaccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Video_X_Reaccion_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `DHTube`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHTube`.`Etiqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHTube`.`Etiqueta` (
  `Codigo` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHTube`.`Etiqueta_X_Video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHTube`.`Etiqueta_X_Video` (
  `Etiqueta_Codigo` INT NOT NULL,
  `Video_idVideo` INT NOT NULL,
  PRIMARY KEY (`Etiqueta_Codigo`, `Video_idVideo`),
  INDEX `fk_Etiqueta_has_Video_Video1_idx` (`Video_idVideo` ASC) VISIBLE,
  INDEX `fk_Etiqueta_has_Video_Etiqueta1_idx` (`Etiqueta_Codigo` ASC) VISIBLE,
  CONSTRAINT `fk_Etiqueta_has_Video_Etiqueta1`
    FOREIGN KEY (`Etiqueta_Codigo`)
    REFERENCES `DHTube`.`Etiqueta` (`Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Etiqueta_has_Video_Video1`
    FOREIGN KEY (`Video_idVideo`)
    REFERENCES `DHTube`.`Video` (`idVideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHTube`.`Canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHTube`.`Canal` (
  `idCanal` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Descripcion` TEXT NULL,
  `Fecha_Creacion` DATE NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idCanal`),
  INDEX `fk_Canal_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Canal_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `DHTube`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHTube`.`Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHTube`.`Playlist` (
  `idPlaylist` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Fecha_Creacion` DATE NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `IdPrivacidad` INT NOT NULL,
  PRIMARY KEY (`idPlaylist`),
  INDEX `fk_Playlist_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  INDEX `fk_Playlist_Privacidad1_idx` (`IdPrivacidad` ASC) VISIBLE,
  CONSTRAINT `fk_Playlist_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `DHTube`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Playlist_Privacidad1`
    FOREIGN KEY (`IdPrivacidad`)
    REFERENCES `DHTube`.`Privacidad` (`idPrivacidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DHTube`.`Playlist_X_Video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DHTube`.`Playlist_X_Video` (
  `Playlist_idPlaylist` INT NOT NULL,
  `Video_idVideo` INT NOT NULL,
  PRIMARY KEY (`Playlist_idPlaylist`, `Video_idVideo`),
  INDEX `fk_Playlist_has_Video_Video1_idx` (`Video_idVideo` ASC) VISIBLE,
  INDEX `fk_Playlist_has_Video_Playlist1_idx` (`Playlist_idPlaylist` ASC) VISIBLE,
  CONSTRAINT `fk_Playlist_has_Video_Playlist1`
    FOREIGN KEY (`Playlist_idPlaylist`)
    REFERENCES `DHTube`.`Playlist` (`idPlaylist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Playlist_has_Video_Video1`
    FOREIGN KEY (`Video_idVideo`)
    REFERENCES `DHTube`.`Video` (`idVideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
