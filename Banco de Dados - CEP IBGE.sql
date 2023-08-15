SET FOREIGN_KEY_CHECKS = 0;

use aula; 

--
-- Table structure for table geo_pais
--

DROP TABLE IF EXISTS geo_pais;
/*!40101 SET @saved_cs_client  = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE geo_pais ( 
 pais_id int(10) unsigned NOT NULL AUTO_INCREMENT,
 pais_nm varchar(255) DEFAULT NULL, 
 pais_sigla char(2) DEFAULT NULL, -- Sigla global do país
 pais_currency char(3) DEFAULT NULL, -- Símbolo Global da Moeda (Consulte OANDA.COM)
 pais_del_sn tinyint(1) DEFAULT '0',
 pais_cre_ts datetime DEFAULT CURRENT_TIMESTAMP,
 pais_upd_ts datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 pais_del_ts datetime DEFAULT CURRENT_TIMESTAMP,
 PRIMARY KEY (pais_id)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table geo_estado
--

DROP TABLE IF EXISTS geo_estado;
/*!40101 SET @saved_cs_client  = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE geo_estado ( 
 uf_id int(10) unsigned NOT NULL AUTO_INCREMENT,
 uf_pais_id int(10) unsigned DEFAULT NULL,
 uf_ibge_cd tinyint(2) DEFAULT NULL,
 uf_nm varchar(55) DEFAULT NULL,
 uf_sigla char(2) DEFAULT NULL,
 uf_del_sn tinyint(1) DEFAULT '0',
 uf_cre_ts datetime DEFAULT CURRENT_TIMESTAMP,
 uf_upd_ts datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 uf_del_ts datetime DEFAULT NULL,
 PRIMARY KEY (uf_id),
 KEY idx_estado_pais_id (uf_pais_id),
 CONSTRAINT fk_estado_pais_id FOREIGN KEY (uf_pais_id) REFERENCES pais (pais_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table geo_municipio
--

DROP TABLE IF EXISTS geo_municipio;
/*!40101 SET @saved_cs_client  = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE geo_municipio ( 
 municipio_id int(10) unsigned NOT NULL AUTO_INCREMENT,
 mun_uf_id int(10) unsigned DEFAULT NULL,
 mun_ibge_cd int(10) unsigned DEFAULT NULL,
 mun_nm varchar(55) DEFAULT NULL,
 mun_cep int(8) unsigned zerofill DEFAULT NULL,
 mun_del_sn tinyint(1) DEFAULT '0',
 mun_cre_ts datetime DEFAULT CURRENT_TIMESTAMP,
 mun_upd_ts datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 mun_del_ts datetime DEFAULT NULL,
 PRIMARY KEY (municipio_id),
 KEY idx_municipio_estado_id (mun_uf_id) USING BTREE,
 CONSTRAINT fk_municipio_estado_id FOREIGN KEY (mun_uf_id) REFERENCES geo_estado (uf_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14194 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table geo_bairro
--

DROP TABLE IF EXISTS geo_bairro;
/*!40101 SET @saved_cs_client  = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE geo_bairro ( 
 bairro_id int(10) unsigned NOT NULL AUTO_INCREMENT,
 bai_mun_id int(10) unsigned DEFAULT NULL,
 bai_nm varchar(255) DEFAULT NULL,
 bai_del_sn tinyint(1) DEFAULT '0',
 bai_cre_ts datetime DEFAULT CURRENT_TIMESTAMP,
 bai_upd_ts datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 bai_del_ts datetime DEFAULT NULL,
 PRIMARY KEY (bairro_id),
 KEY idx_bairro_municipio_id (bai_mun_id) USING BTREE,
 CONSTRAINT fk_bairro_municipio_id FOREIGN KEY (bai_mun_id) REFERENCES geo_municipio (municipio_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61579 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table geo_logradouro
--

DROP TABLE IF EXISTS geo_logradouro;
/*!40101 SET @saved_cs_client  = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE geo_logradouro (
 logradouro_id int(10) unsigned NOT NULL AUTO_INCREMENT,
 logr_bairro_id int(10) unsigned DEFAULT NULL,
 logr_tp varchar(30) DEFAULT NULL,
 logr_nm varchar(90) DEFAULT NULL,
 logr_alternativa_nm varchar(90) DEFAULT NULL,
 logr_cep int(8) unsigned zerofill DEFAULT NULL,
 logr_desc varchar(100) DEFAULT NULL,
 logr_del_sn tinyint(1) DEFAULT '0',
 logr_cre_ts datetime DEFAULT CURRENT_TIMESTAMP,
 logr_upd_ts datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 logr_del_ts datetime DEFAULT NULL,
 PRIMARY KEY (logradouro_id),
 KEY idx_logradouro_bairro_id (logr_bairro_id) USING BTREE,
 KEY idx_logradouro_cep (logr_cep), 
 CONSTRAINT fk_logradouro_bairro_id FOREIGN KEY (logr_bairro_id) REFERENCES geo_bairro (bairro_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1101231 DEFAULT CHARSET=utf8;


SET FOREIGN_KEY_CHECKS = 1;