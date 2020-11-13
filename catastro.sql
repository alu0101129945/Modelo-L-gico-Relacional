-- MySQL Script generated by MySQL Workbench
-- vie 13 nov 2020 15:51:28 WET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Zona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Zona` (
  `Nombre` VARCHAR(45) NOT NULL,
  `Área` VARCHAR(45) NULL,
  PRIMARY KEY (`Nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Calle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Calle` (
  `Nombre` VARCHAR(45) NOT NULL,
  `Zona_Nombre` VARCHAR(45) NOT NULL,
  `Nº Carriles` INT NULL,
  `Tipo` VARCHAR(45) NULL,
  `Longitud` FLOAT NULL,
  PRIMARY KEY (`Nombre`),
  INDEX `fk_Calle_Zona_idx` (`Zona_Nombre` ASC) VISIBLE,
  CONSTRAINT `fk_Calle_Zona`
    FOREIGN KEY (`Zona_Nombre`)
    REFERENCES `mydb`.`Zona` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bloque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bloque` (
  `Número` INT NOT NULL,
  `Superficie` FLOAT NULL,
  `Año` DATE NULL,
  `Calle_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Número`, `Calle_Nombre`),
  INDEX `fk_Bloque_Calle1_idx` (`Calle_Nombre` ASC) VISIBLE,
  CONSTRAINT `fk_Bloque_Calle1`
    FOREIGN KEY (`Calle_Nombre`)
    REFERENCES `mydb`.`Calle` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Piso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Piso` (
  `Letra` VARCHAR(2) NOT NULL,
  `Planta` INT NOT NULL,
  `Bloque_Número` INT NOT NULL,
  `Bloque_Calle_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Letra`, `Planta`, `Bloque_Número`, `Bloque_Calle_Nombre`),
  INDEX `fk_Piso_Bloque1_idx` (`Bloque_Número` ASC, `Bloque_Calle_Nombre` ASC) VISIBLE,
  CONSTRAINT `fk_Piso_Bloque1`
    FOREIGN KEY (`Bloque_Número` , `Bloque_Calle_Nombre`)
    REFERENCES `mydb`.`Bloque` (`Número` , `Calle_Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Personas` (
  `DNI` VARCHAR(20) NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Apellidos` VARCHAR(45) NULL,
  `Piso_Letra` VARCHAR(2) NOT NULL,
  `Piso_Planta` INT NOT NULL,
  `Piso_Bloque_Número` INT NOT NULL,
  `Piso_Bloque_Calle_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DNI`),
  INDEX `fk_Personas_Piso1_idx` (`Piso_Letra` ASC, `Piso_Planta` ASC, `Piso_Bloque_Número` ASC, `Piso_Bloque_Calle_Nombre` ASC) VISIBLE,
  CONSTRAINT `fk_Personas_Piso1`
    FOREIGN KEY (`Piso_Letra` , `Piso_Planta` , `Piso_Bloque_Número` , `Piso_Bloque_Calle_Nombre`)
    REFERENCES `mydb`.`Piso` (`Letra` , `Planta` , `Bloque_Número` , `Bloque_Calle_Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Unifamiliares`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Unifamiliares` (
  `Nombre` VARCHAR(45) NOT NULL,
  `Superficie` FLOAT NULL,
  `Año` DATE NULL,
  `Nº habitantes` INT NULL,
  `Calle_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Nombre`, `Calle_Nombre`),
  INDEX `fk_Unifamiliares_Calle1_idx` (`Calle_Nombre` ASC) VISIBLE,
  CONSTRAINT `fk_Unifamiliares_Calle1`
    FOREIGN KEY (`Calle_Nombre`)
    REFERENCES `mydb`.`Calle` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
