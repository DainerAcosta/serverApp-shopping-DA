-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-07-2020 a las 09:02:16
-- Versión del servidor: 10.4.13-MariaDB
-- Versión de PHP: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_fast_shopping`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `st_buy`
--

CREATE TABLE `st_buy` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `price_total` double NOT NULL,
  `date_create` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `st_detail`
--

CREATE TABLE `st_detail` (
  `id` int(11) NOT NULL,
  `id_buy` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  `unit_price` double NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `st_product`
--

CREATE TABLE `st_product` (
  `id` int(11) NOT NULL,
  `image` text NOT NULL,
  `name_product` text NOT NULL,
  `price` double NOT NULL,
  `category` text NOT NULL,
  `description` text NOT NULL,
  `date_create` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `st_product`
--

INSERT INTO `st_product` (`id`, `image`, `name_product`, `price`, `category`, `description`, `date_create`) VALUES
(4, 'https://as1.ftcdn.net/jpg/03/08/57/00/500_F_308570068_XYo94iBAHQghEQKcEqainvg4KZdtrdHE.jpg', 'Silla tipo butaco pequeño', 45000, 'Hogar', 'Silla ideal para hacer trabajos que requieran bla bla bla', '2020-07-06 09:13:38'),
(5, 'https://cdn.pixabay.com/photo/2014/07/22/09/59/bread-399286_960_720.jpg', 'Pan casero con amor y ternura', 8000, 'Panadería', 'Pan ideal para acompañar las medias tardes, rico con chocolate o café', '2020-07-07 22:00:52'),
(6, 'https://as2.ftcdn.net/jpg/03/08/56/61/500_F_308566131_jjXij0XH4ZDFXRrEiZ1FBWss91AdKSnu.jpg', 'Arandanos, fresas, moras', 15000, 'Frutas', 'Frutos ricos en antioxidantes, arandanos, fresas, moras ideales para una dieta saludable', '2020-07-12 06:16:57'),
(7, 'https://as1.ftcdn.net/jpg/03/25/77/08/500_F_325770842_Nl27LUqKdJLBK2AgwcAYkPTkkrz555fI.jpg', 'Postre super rico', 11000, 'Alimentos', 'postre super rico para pasar la tarde o salir con tu pareja', '2020-07-12 06:19:32'),
(8, 'https://as1.ftcdn.net/jpg/03/09/41/16/500_F_309411621_ISdBZqt4XY2H7eP6qwwHr2Agz7Mrhu7q.jpg', 'Plato con pimentón', 22000, 'Alimentos', 'Plato ideal para personas veganas', '2020-07-12 06:21:09'),
(9, 'https://as2.ftcdn.net/jpg/02/69/84/41/500_F_269844103_KPwijcBcfrzfwz1ZWVkKAuLM56xvsc32.jpg', 'Sopa verde y rica', 18000, 'Alimentos', 'Sopa ideal para veganos y personas que gustan cuidar su salud', '2020-07-12 06:22:28'),
(10, 'https://as2.ftcdn.net/jpg/03/18/02/01/500_F_318020177_zsitp8nik1B9VdThTO2J9JZxdGNXfJqV.jpg', 'Rico helado de mora', 6000, 'Alimentos', 'Helado para el calor', '2020-07-12 06:24:46');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `us_user`
--

CREATE TABLE `us_user` (
  `id` int(11) NOT NULL,
  `full_name` text NOT NULL,
  `dni` text NOT NULL,
  `address` text NOT NULL,
  `phone_number` text NOT NULL,
  `email` text NOT NULL,
  `date_create` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `st_buy`
--
ALTER TABLE `st_buy`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indices de la tabla `st_detail`
--
ALTER TABLE `st_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_buy` (`id_buy`),
  ADD KEY `id_product` (`id_product`);

--
-- Indices de la tabla `st_product`
--
ALTER TABLE `st_product`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `us_user`
--
ALTER TABLE `us_user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `st_buy`
--
ALTER TABLE `st_buy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de la tabla `st_detail`
--
ALTER TABLE `st_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT de la tabla `st_product`
--
ALTER TABLE `st_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `us_user`
--
ALTER TABLE `us_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `st_buy`
--
ALTER TABLE `st_buy`
  ADD CONSTRAINT `st_buy_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `us_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `st_detail`
--
ALTER TABLE `st_detail`
  ADD CONSTRAINT `st_detail_ibfk_1` FOREIGN KEY (`id_buy`) REFERENCES `st_buy` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `st_detail_ibfk_2` FOREIGN KEY (`id_product`) REFERENCES `st_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
