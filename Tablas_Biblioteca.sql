-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Biblioteca
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Biblioteca
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Biblioteca` DEFAULT CHARACTER SET utf8 ;
USE `Biblioteca` ;

-- -----------------------------------------------------
-- Table `Biblioteca`.`Editorial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Biblioteca`.`Editorial` (
  `idEditorial` INT NOT NULL,
  `razonSocial` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(20) NULL,
  PRIMARY KEY (`idEditorial`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`Autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Biblioteca`.`Autor` (
  `idAutor` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  PRIMARY KEY (`idAutor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`Libro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Biblioteca`.`Libro` (
  `idLibro` INT NOT NULL AUTO_INCREMENT,
  `ISBN` VARCHAR(13) NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `anioPublicacion` YEAR(4) NOT NULL,
  `anioEdicion` YEAR(4) NULL,
  `idEditorial` INT NOT NULL,
  `idAutor` INT NOT NULL,
  PRIMARY KEY (`idLibro`, `idEditorial`, `idAutor`),
  INDEX `fk_Libro_Editorial_idx` (`idEditorial` ASC) VISIBLE,
  INDEX `fk_Libro_Autor1_idx` (`idAutor` ASC) VISIBLE,
  CONSTRAINT `fk_Libro_Editorial`
    FOREIGN KEY (`idEditorial`)
    REFERENCES `Biblioteca`.`Editorial` (`idEditorial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Libro_Autor1`
    FOREIGN KEY (`idAutor`)
    REFERENCES `Biblioteca`.`Autor` (`idAutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`CopiaLibro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Biblioteca`.`CopiaLibro` (
  `idCopiaLibro` INT NOT NULL,
  `estado` SET('Prestado', 'Libre') NULL,
  `deteriorado` TINYINT(1) NULL,
  `Libro_idLibro` INT NOT NULL,
  `Libro_idEditorial` INT NOT NULL,
  `Libro_idAutor` INT NOT NULL,
  PRIMARY KEY (`idCopiaLibro`, `Libro_idLibro`, `Libro_idEditorial`, `Libro_idAutor`),
  INDEX `fk_CopiaLibro_Libro1_idx` (`Libro_idLibro` ASC, `Libro_idEditorial` ASC, `Libro_idAutor` ASC) VISIBLE,
  CONSTRAINT `fk_CopiaLibro_Libro1`
    FOREIGN KEY (`Libro_idLibro` , `Libro_idEditorial` , `Libro_idAutor`)
    REFERENCES `Biblioteca`.`Libro` (`idLibro` , `idEditorial` , `idAutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`Socios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Biblioteca`.`Socios` (
  `idSocios` INT NOT NULL AUTO_INCREMENT,
  `dni` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NULL,
  `direccion` VARCHAR(150) NULL,
  `telefono` VARCHAR(20) NULL,
  PRIMARY KEY (`idSocios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`prestamoLibros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Biblioteca`.`prestamoLibros` (
  `idprestamoLibros` INT NOT NULL AUTO_INCREMENT,
  `fechaRetiro` DATETIME(4) NOT NULL,
  `fechaDevolucion` DATETIME(4) NOT NULL,
  `fechaMaxDevolucion` DATETIME(4) NOT NULL,
  `idSocios` INT NOT NULL,
  PRIMARY KEY (`idprestamoLibros`, `idSocios`),
  INDEX `fk_prestamoLibros_Socios1_idx` (`idSocios` ASC) VISIBLE,
  CONSTRAINT `fk_prestamoLibros_Socios1`
    FOREIGN KEY (`idSocios`)
    REFERENCES `Biblioteca`.`Socios` (`idSocios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`LibrosPrestados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Biblioteca`.`LibrosPrestados` (
  `CopiaLibro_idCopiaLibro` INT NOT NULL,
  `CopiaLibro_Libro_idLibro` INT NOT NULL,
  `CopiaLibro_Libro_idEditorial` INT NOT NULL,
  `CopiaLibro_Libro_idAutor` INT NOT NULL,
  `prestamoLibros_idprestamoLibros` INT NOT NULL,
  `prestamoLibros_idSocios` INT NOT NULL,
  PRIMARY KEY (`CopiaLibro_idCopiaLibro`, `CopiaLibro_Libro_idLibro`, `CopiaLibro_Libro_idEditorial`, `CopiaLibro_Libro_idAutor`, `prestamoLibros_idprestamoLibros`, `prestamoLibros_idSocios`),
  INDEX `fk_CopiaLibro_has_prestamoLibros_prestamoLibros1_idx` (`prestamoLibros_idprestamoLibros` ASC, `prestamoLibros_idSocios` ASC) VISIBLE,
  INDEX `fk_CopiaLibro_has_prestamoLibros_CopiaLibro1_idx` (`CopiaLibro_idCopiaLibro` ASC, `CopiaLibro_Libro_idLibro` ASC, `CopiaLibro_Libro_idEditorial` ASC, `CopiaLibro_Libro_idAutor` ASC) VISIBLE,
  CONSTRAINT `fk_CopiaLibro_has_prestamoLibros_CopiaLibro1`
    FOREIGN KEY (`CopiaLibro_idCopiaLibro` , `CopiaLibro_Libro_idLibro` , `CopiaLibro_Libro_idEditorial` , `CopiaLibro_Libro_idAutor`)
    REFERENCES `Biblioteca`.`CopiaLibro` (`idCopiaLibro` , `Libro_idLibro` , `Libro_idEditorial` , `Libro_idAutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CopiaLibro_has_prestamoLibros_prestamoLibros1`
    FOREIGN KEY (`prestamoLibros_idprestamoLibros` , `prestamoLibros_idSocios`)
    REFERENCES `Biblioteca`.`prestamoLibros` (`idprestamoLibros` , `idSocios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
