-- MySQL Script generated by MySQL Workbench
-- mié 15 jun 2022 17:19:52
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema liga
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `liga` ;

-- -----------------------------------------------------
-- Schema liga
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `liga` ;
USE `liga` ;

-- -----------------------------------------------------
-- Table `liga`.`equipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `liga`.`equipos` (
  `idEquipo` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEquipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `liga`.`ligas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `liga`.`ligas` (
  `idLiga` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idLiga`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `liga`.`enfrentamientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `liga`.`enfrentamientos` (
  `idEquipoLoc` INT UNSIGNED NOT NULL,
  `idEquipoVis` INT UNSIGNED NOT NULL,
  `idLiga` INT UNSIGNED NOT NULL,
  `jornada` INT UNSIGNED NOT NULL,
  `fecha` DATE NOT NULL,
  `golesLoc` INT UNSIGNED NOT NULL,
  `golesVis` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idEquipoLoc`, `idEquipoVis`),
  INDEX `fk_equipos_has_equipos_equipos1_idx` (`idEquipoVis` ASC) VISIBLE,
  INDEX `fk_equipos_has_equipos_equipos_idx` (`idEquipoLoc` ASC) VISIBLE,
  INDEX `fk_equipos_has_equipos_ligas1_idx` (`idLiga` ASC) VISIBLE,
  CONSTRAINT `fk_equipos_has_equipos_equipos`
    FOREIGN KEY (`idEquipoLoc`)
    REFERENCES `liga`.`equipos` (`idEquipo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_equipos_has_equipos_equipos1`
    FOREIGN KEY (`idEquipoVis`)
    REFERENCES `liga`.`equipos` (`idEquipo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_equipos_has_equipos_ligas1`
    FOREIGN KEY (`idLiga`)
    REFERENCES `liga`.`ligas` (`idLiga`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
