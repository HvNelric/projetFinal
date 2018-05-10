-- MySQL Script generated by MySQL Workbench
-- Mon May  7 15:44:15 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Schema hexago
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hexago` DEFAULT CHARACTER SET utf8 ;
USE `hexago` ;


-- -----------------------------------------------------
-- Table `hexago`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hexago`.`tags` (
  `id_tags` INT(11) NOT NULL AUTO_INCREMENT,
  `tag` ENUM('mer', 'plage', 'montagne', 'piscine', 'forêt', 'randonnée','croisière','grotte','balade','château','camping') NOT NULL,
  PRIMARY KEY (`id_tags`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hexago`.`groupe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hexago`.`groupe` (
  `id_groupe` INT(11) NOT NULL AUTO_INCREMENT,
  `date_debut_dispo_group` DATE NOT NULL,
  `date_fin_dispo_group` DATE NOT NULL,
  `budget_group` INT(11) NOT NULL,
  `taille_group` INT(11) NOT NULL,
  `tags_id_tags` INT(11) NOT NULL,
  PRIMARY KEY (`id_groupe`, `tags_id_tags`),
  INDEX `fk_groupe_tags1_idx` (`tags_id_tags` ASC),
  CONSTRAINT `fk_groupe_tags1`
    FOREIGN KEY (`tags_id_tags`)
    REFERENCES `hexago`.`tags` (`id_tags`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hexago`.`utilisateur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hexago`.`utilisateur` (
  `id_utilisateur` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(50) NOT NULL,
  `mdp` VARCHAR(50) NOT NULL,
  `civilite` ENUM('M.', 'Mme') NOT NULL,
  `nom` VARCHAR(50) NOT NULL,
  `prenom` VARCHAR(50) NOT NULL,
  `adresse` VARCHAR(50) NOT NULL,
  `cp` INT(11) NOT NULL,
  `ville` VARCHAR(50) NOT NULL,
  `date_naissance` DATE NOT NULL,
  `telephone` INT(11) NOT NULL,
  `date_debut_dispo` DATE NOT NULL,
  `date_fin_dispo` DATE NOT NULL,
  `tags_id_tags` INT(11) NOT NULL,
  PRIMARY KEY (`id_utilisateur`, `tags_id_tags`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `fk_utilisateur_tags_idx` (`tags_id_tags` ASC),
  CONSTRAINT `fk_utilisateur_tags`
    FOREIGN KEY (`tags_id_tags`)
    REFERENCES `hexago`.`tags` (`id_tags`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hexago`.`sejour`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hexago`.`sejour` (
  `id_sejour` INT(11) NOT NULL AUTO_INCREMENT,
  `prix` INT(11) NOT NULL,
  `date_expiration` DATE NOT NULL,
  `date_depart` DATE NOT NULL,
  `nb_nuits` INT(11) NOT NULL,
  `nb_places` INT(11) NOT NULL,
  `desciption` TEXT NOT NULL,
  `hebergement` VARCHAR(50) NOT NULL,
  `transport` VARCHAR(50) NOT NULL,
  `tags_id_tags` INT(11) NOT NULL,
  PRIMARY KEY (`id_sejour`, `tags_id_tags`),
  INDEX `fk_sejour_tags1_idx` (`tags_id_tags` ASC),
  CONSTRAINT `fk_sejour_tags1`
    FOREIGN KEY (`tags_id_tags`)
    REFERENCES `hexago`.`tags` (`id_tags`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hexago`.`reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hexago`.`reservation` (
  `id_reservation` INT(11) NOT NULL AUTO_INCREMENT,
  `date_reservation` DATE NOT NULL,
  `date_depart` DATE NOT NULL,
  `duree` INT(11) NOT NULL,
  `montant` INT(11) NOT NULL,
  `utilisateur_id_utilisateur` INT(11) NOT NULL,
  `sejour_id_sejour` INT(11) NOT NULL,
  PRIMARY KEY (`id_reservation`, `utilisateur_id_utilisateur`, `sejour_id_sejour`),
  INDEX `fk_reservation_utilisateur1_idx` (`utilisateur_id_utilisateur` ASC),
  INDEX `fk_reservation_sejour1_idx` (`sejour_id_sejour` ASC),
  CONSTRAINT `fk_reservation_utilisateur1`
    FOREIGN KEY (`utilisateur_id_utilisateur`)
    REFERENCES `hexago`.`utilisateur` (`id_utilisateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservation_sejour1`
    FOREIGN KEY (`sejour_id_sejour`)
    REFERENCES `hexago`.`sejour` (`id_sejour`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hexago`.`Appartient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hexago`.`Appartient` (
  `groupe_id_groupe` INT(11) NOT NULL,
  `utilisateur_id_utilisateur` INT(11) NOT NULL,
  PRIMARY KEY (`groupe_id_groupe`, `utilisateur_id_utilisateur`),
  INDEX `fk_groupe_has_utilisateur_utilisateur1_idx` (`utilisateur_id_utilisateur` ASC),
  INDEX `fk_groupe_has_utilisateur_groupe1_idx` (`groupe_id_groupe` ASC),
  CONSTRAINT `fk_groupe_has_utilisateur_groupe1`
    FOREIGN KEY (`groupe_id_groupe`)
    REFERENCES `hexago`.`groupe` (`id_groupe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_groupe_has_utilisateur_utilisateur1`
    FOREIGN KEY (`utilisateur_id_utilisateur`)
    REFERENCES `hexago`.`utilisateur` (`id_utilisateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `hexago` ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;