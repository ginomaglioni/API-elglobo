-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 10-12-2025 a las 19:24:32
-- Versión del servidor: 8.0.31
-- Versión de PHP: 8.4.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `el-globo`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades`
--

DROP TABLE IF EXISTS `actividades`;
CREATE TABLE IF NOT EXISTS `actividades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `costo` int DEFAULT NULL,
  `turno` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `actividades`
--

INSERT INTO `actividades` (`id`, `nombre`, `costo`, `turno`) VALUES
(1, 'Basquet', 10000, 'Tarde'),
(3, 'Hokey', 15000, 'Tarde'),
(4, 'Tenis', 20000, 'Noche'),
(5, 'Natacion', 10000, 'Mañana - Tarde'),
(6, 'Futbol', 15000, 'Mañana - Tarde'),
(10, 'Voley', 12000, 'Mañana');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `casilleros`
--

DROP TABLE IF EXISTS `casilleros`;
CREATE TABLE IF NOT EXISTS `casilleros` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nro_casillero` int DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `monto_mensual` mediumint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `casilleros`
--

INSERT INTO `casilleros` (`id`, `nro_casillero`, `estado`, `monto_mensual`) VALUES
(1, 1, 'Ocupado', 50000),
(3, 2, 'Disponible', 500);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

DROP TABLE IF EXISTS `categorias`;
CREATE TABLE IF NOT EXISTS `categorias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `monto` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `monto`) VALUES
(1, 'Infantil (hasta 12 años)', 10000),
(2, 'Cadete (13 a 17 años)', 15000),
(3, 'Adulto (18 a 64 años)', 20000),
(4, 'Adulto Mayor (65+ años)', 17000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cobradores`
--

DROP TABLE IF EXISTS `cobradores`;
CREATE TABLE IF NOT EXISTS `cobradores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `zona` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `cobradores`
--

INSERT INTO `cobradores` (`id`, `nombre`, `zona`) VALUES
(1, 'Jose', 'Sur'),
(2, 'Juan', 'Norte');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cobranzas`
--

DROP TABLE IF EXISTS `cobranzas`;
CREATE TABLE IF NOT EXISTS `cobranzas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fechaEmision` date DEFAULT NULL,
  `mes` varchar(10) DEFAULT NULL,
  `monto` int DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `recargo` decimal(10,0) DEFAULT NULL,
  `descuento` decimal(10,0) DEFAULT NULL,
  `idSocio` int NOT NULL,
  `idCobrador` int NOT NULL,
  PRIMARY KEY (`id`,`idSocio`,`idCobrador`),
  KEY `fk_cuotas_socios1_idx` (`idSocio`),
  KEY `fk_cuotas_cobradores1_idx` (`idCobrador`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `cobranzas`
--

INSERT INTO `cobranzas` (`id`, `fechaEmision`, `mes`, `monto`, `estado`, `recargo`, `descuento`, `idSocio`, `idCobrador`) VALUES
(2, '2025-12-10', 'Junio', 50000, 'Impago', 0, 15, 3, 1),
(3, '2025-12-04', 'Diciembre', 15000, 'Pago', 10, 0, 3, 1),
(4, '2025-12-04', 'Diciembre', 15000, 'Pago', 10, 0, 14, 1),
(5, '2025-11-06', 'Noviembre', 20000, 'Pago', 10, 0, 14, 2),
(6, '2025-11-28', 'Noviembre', 15000, 'Impago', 5, 0, 14, 2),
(7, '2025-11-28', 'Noviembre', 15000, 'Pago', 5, 0, 23, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socios`
--

DROP TABLE IF EXISTS `socios`;
CREATE TABLE IF NOT EXISTS `socios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `dni` varchar(10) DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `fechaAlta` date DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `idZona` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `idCasillero` int NOT NULL,
  `idCategoria` int NOT NULL,
  PRIMARY KEY (`id`,`idCasillero`,`idCategoria`),
  UNIQUE KEY `dni_UNIQUE` (`dni`),
  KEY `fk_socios_categorias1_idx` (`idCategoria`),
  KEY `zona` (`idZona`) USING BTREE,
  KEY `fk_socios_casilleros1_idx` (`idCasillero`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `socios`
--

INSERT INTO `socios` (`id`, `nombre`, `apellido`, `dni`, `fechaNacimiento`, `direccion`, `telefono`, `email`, `fechaAlta`, `estado`, `idZona`, `idCasillero`, `idCategoria`) VALUES
(3, 'Ricardo', 'Darin', '22.244.355', '2025-11-25', 'Rosario 54', '3476578941', 'bombita@gmail.com', '2025-06-05', 'Pago', '1', 1, 3),
(14, 'Joaquin', 'Medina', '46378944', '2004-12-17', 'Aconcagua 123', '3417891455', 'medinajoa@gmail.com', '2025-12-05', NULL, '2', 3, 3),
(23, 'Pepe Juan', 'Toño', '35478962', '1994-10-11', 'Dr. Ghio 154', '03476985142', 'pepe@gmail.com', '2025-12-10', NULL, '1', 1, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socio_actividades`
--

DROP TABLE IF EXISTS `socio_actividades`;
CREATE TABLE IF NOT EXISTS `socio_actividades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idSocio` int NOT NULL,
  `idActividad` int NOT NULL,
  PRIMARY KEY (`id`,`idSocio`,`idActividad`),
  KEY `fk_socio_actividad_socios_idx` (`idSocio`),
  KEY `fk_socio_actividad_actividades1_idx` (`idActividad`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `socio_actividades`
--

INSERT INTO `socio_actividades` (`id`, `idSocio`, `idActividad`) VALUES
(1, 3, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) NOT NULL,
  `contrasena` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `rol` varchar(15) NOT NULL,
  `idSocio` int DEFAULT NULL,
  `idCobrador` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `idSocio` (`idSocio`),
  KEY `idCobrador` (`idCobrador`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `contrasena`, `rol`, `idSocio`, `idCobrador`) VALUES
(2, 'admin', '$2b$10$V6JF6o7raqVNIiA6LXLviOPSPoInWU0beQBXRXG6PWIhqHJOWNQjG', 'admin', NULL, NULL),
(5, 'ricardo', '$2b$10$5inLWU5HfTQ.5tnmTSUw6.wVUf1tYj/vP8t6Y4QTuW90AQnKTDW9q', 'socio', 3, NULL),
(10, 'joaquin', '$2b$10$nDABY6JkdCViDttOMdtKYO059RRVbkNPrEbslECije4qZcOra2e8y', 'socio', 14, NULL),
(11, 'juan', '$2b$10$6AKGRNOuHT.33ahJI88I0eEtYo/AaabWD2r1/52ipJUy66.Kb.7Ae', 'cobrador', NULL, 2),
(12, 'Pepe', '$2b$10$IsGQyYOoe3NYc6eiAlMccOFUA0p4ivUbf96DGLfIttESqtIIEeYwu', 'socio', 23, NULL);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_cobranzas`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `vista_cobranzas`;
CREATE TABLE IF NOT EXISTS `vista_cobranzas` (
`descuento` decimal(10,0)
,`estado` varchar(45)
,`fechaEmision` date
,`id` int
,`idCobrador` int
,`idSocio` int
,`mes` varchar(10)
,`monto` int
,`nombreCobrador` varchar(50)
,`nombreSocio` varchar(50)
,`recargo` decimal(10,0)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zona`
--

DROP TABLE IF EXISTS `zona`;
CREATE TABLE IF NOT EXISTS `zona` (
  `id` int NOT NULL,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `zona`
--

INSERT INTO `zona` (`id`, `nombre`) VALUES
(1, 'Norte'),
(2, 'Este'),
(3, 'Oeste'),
(4, 'Sur');

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_cobranzas`
--
DROP TABLE IF EXISTS `vista_cobranzas`;

DROP VIEW IF EXISTS `vista_cobranzas`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_cobranzas`  AS SELECT `c`.`id` AS `id`, `s`.`nombre` AS `nombreSocio`, `c`.`fechaEmision` AS `fechaEmision`, `c`.`mes` AS `mes`, `c`.`monto` AS `monto`, `c`.`recargo` AS `recargo`, `c`.`descuento` AS `descuento`, `c`.`estado` AS `estado`, `co`.`nombre` AS `nombreCobrador`, `s`.`id` AS `idSocio`, `co`.`id` AS `idCobrador` FROM ((`cobranzas` `c` join `socios` `s` on((`c`.`idSocio` = `s`.`id`))) join `cobradores` `co` on((`c`.`idCobrador` = `co`.`id`))) ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cobranzas`
--
ALTER TABLE `cobranzas`
  ADD CONSTRAINT `fk_cuotas_cobradores1` FOREIGN KEY (`idCobrador`) REFERENCES `cobradores` (`id`),
  ADD CONSTRAINT `fk_cuotas_socios1` FOREIGN KEY (`idSocio`) REFERENCES `socios` (`id`);

--
-- Filtros para la tabla `socios`
--
ALTER TABLE `socios`
  ADD CONSTRAINT `fk_socios_casilleros1` FOREIGN KEY (`idCasillero`) REFERENCES `casilleros` (`id`),
  ADD CONSTRAINT `fk_socios_categorias1` FOREIGN KEY (`idCategoria`) REFERENCES `categorias` (`id`);

--
-- Filtros para la tabla `socio_actividades`
--
ALTER TABLE `socio_actividades`
  ADD CONSTRAINT `fk_socio_actividad_actividades1` FOREIGN KEY (`idActividad`) REFERENCES `actividades` (`id`),
  ADD CONSTRAINT `fk_socio_actividad_socios` FOREIGN KEY (`idSocio`) REFERENCES `socios` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`idSocio`) REFERENCES `socios` (`id`),
  ADD CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`idCobrador`) REFERENCES `cobradores` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
